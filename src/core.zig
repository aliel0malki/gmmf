const std = @import("std");
const processGrep = @import("utils.zig").processGrep;
const processFind = @import("utils.zig").processFind;
const Color = @import("config.zig").Color;

const fs = std.fs;
const mem = std.mem;
const out = std.io.getStdOut();
var buf = std.io.bufferedWriter(out.writer());
var stdout = buf.writer();

pub const Core = struct {
    allocator: *std.mem.Allocator,

    const Self = @This();

    pub fn init(allocator: *std.mem.Allocator) !Core {
        return Core{
            .allocator = allocator,
        };
    }

    pub fn find(
        self: *Self,
        dir_path: []const u8,
        target: []const u8,
        exclude: []const []const u8,
    ) !bool {
        var found = false;
        var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
        defer dir.close();
        var iter = dir.iterate();

        while (try iter.next()) |entry| {
            var skip = false;
            if (entry.kind == .directory) {
                for (exclude) |ex| {
                    if (mem.eql(u8, ex, entry.name)) {
                        skip = true;
                        break;
                    }
                }
                if (skip) continue;

                const subdir_path = try std.fs.path.join(self.allocator.*, &.{ dir_path, entry.name });
                defer self.allocator.free(subdir_path);

                _ = try self.find(subdir_path, target, exclude);
                continue;
            }

            found = try processFind(self.allocator, dir_path, entry.name, target);
        }

        return found;
    }

    pub fn grep(
        self: *Self,
        dir_path: []const u8,
        target: []const u8,
        exclude: []const []const u8,
    ) !bool {
        var found = false;
        var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
        defer dir.close();
        var iter = dir.iterate();

        while (try iter.next()) |entry| {
            var skip = false;
            if (entry.kind == .directory) {
                for (exclude) |ex| {
                    if (mem.eql(u8, ex, entry.name)) {
                        skip = true;
                        break;
                    }
                }
                if (skip) continue;

                const subdir_path = try std.fs.path.join(self.allocator.*, &.{ dir_path, entry.name });
                defer self.allocator.free(subdir_path);

                _ = try self.grep(subdir_path, target, exclude);
                continue;
            }

            found = try processGrep(self.allocator, &dir, dir_path, entry.name, target);
        }

        return found;
    }
};
