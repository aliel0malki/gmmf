const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const out = std.io.getStdOut();
var buf = std.io.bufferedWriter(out.writer());
var stdout = buf.writer();

pub const Color = struct {
    pub const Reset = "\x1b[0m";
    pub const Green = "\x1b[32m";
    pub const Yellow = "\x1b[33m";
    pub const Red = "\x1b[31m";
    pub const Cyan = "\x1b[36m";
    pub const Bold = "\x1b[1m";
};

// 10 MB max file size to handle
const MAX_FILE_SIZE = 10 * 1024 * 1024;

pub fn findFileRecursive(dir_path: []const u8, target: []const u8, allocator: *std.mem.Allocator) !bool {
    var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();
    var found = false;

    while (try iter.next()) |entry| {
        if (entry.kind == .directory) {
            const subdir_path = try std.fs.path.join(allocator.*, &.{ dir_path, entry.name });
            defer allocator.free(subdir_path);

            if (try findFileRecursive(subdir_path, target, allocator)) {
                return true;
            }
        }

        if (mem.containsAtLeast(u8, entry.name, 1, target)) {
            if (!found) {
                try stdout.print("{s}{s}FOUND:{s}\n", .{ Color.Green, Color.Bold, Color.Reset });
            }
            try stdout.print("    {s}{s}{s}{s}\n", .{ Color.Cyan, dir_path, entry.name, Color.Reset });
            found = true;
            try buf.flush();
            continue;
        }
    }

    if (found) {
        return true;
    }

    return false;
}

pub fn grepSearch(dir_path: []const u8, target: []const u8, allocator: *std.mem.Allocator) !bool {
    var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();
    var found = false;

    while (try iter.next()) |entry| {
        if (entry.kind == .directory) {
            const subdir_path = try std.fs.path.join(allocator.*, &.{ dir_path, entry.name });
            defer allocator.free(subdir_path);

            if (try grepSearch(subdir_path, target, allocator)) {
                return true;
            }
        }
        if (entry.kind != .file) {
            continue;
        }

        var file = try dir.openFile(entry.name, .{});
        defer file.close();
        var reader = file.reader();
        // Increased buffer size to 4 KB
        var buffer: [4096]u8 = undefined;
        var line_number: usize = 0;
        var found_at: usize = 0;
        var total_read: usize = 0;

        // Read the file line by line
        while (try reader.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
            total_read += line.len;
            line_number += 1;
            // Stop processing if file is too large
            if (total_read > MAX_FILE_SIZE) {
                try stdout.print("{s}{s}ERROR: File too large to process.{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
                try buf.flush();
                return false;
            }

            if (mem.containsAtLeast(u8, line, 1, target)) {
                if (!found) {
                    try stdout.print("{s}{s}FOUND IN:{s}\n", .{ Color.Green, Color.Bold, Color.Reset });
                }
                found_at = mem.indexOf(u8, line, target).?;
                try stdout.print("    {s}{s}{s}{s} AT {s}{d}:{d}{s}\n", .{ Color.Cyan, dir_path, entry.name, Color.Reset, Color.Yellow, line_number, found_at + 1, Color.Reset });
                found = true;
                try buf.flush();
                continue;
            }
        }
    }

    if (found) {
        return true;
    }

    return false;
}
