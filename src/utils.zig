const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const out = std.io.getStdOut();
var buf = std.io.bufferedWriter(out.writer());
var stdout = buf.writer();
var is_header_printed = false;

const MAX_FILE_SIZE = 10 * 1024 * 1024;
const MAX_BUFFER_SIZE = 1024 * 1024;

pub const Color = struct {
    pub const Reset = "\x1b[0m";
    pub const Green = "\x1b[32m";
    pub const Yellow = "\x1b[33m";
    pub const Red = "\x1b[31m";
    pub const Cyan = "\x1b[36m";
    pub const Bold = "\x1b[1m";
};

pub fn findFileRecursive(dir_path: []const u8, target: []const u8, allocator: *std.mem.Allocator, exclude: []const []const u8) !u8 {
    var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();

    if (!is_header_printed) {
        try stdout.print("{s}{s}FOUND:{s}\n", .{ Color.Green, Color.Bold, Color.Reset });
        is_header_printed = true;
    }

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

            const subdir_path = try std.fs.path.join(allocator.*, &.{ dir_path, entry.name });
            defer allocator.free(subdir_path);

            _ = try findFileRecursive(subdir_path, target, allocator, exclude);
            continue;
        }

        if (mem.containsAtLeast(u8, entry.name, 1, target)) {
            const file_path = try std.fs.path.join(allocator.*, &.{ dir_path, "/", entry.name });
            defer allocator.free(file_path);

            try stdout.print("    {s}{s}{s}\n", .{ Color.Cyan, file_path, Color.Reset });
        }
        try buf.flush();
    }

    return 0;
}

pub fn grepSearch(dir_path: []const u8, target: []const u8, allocator: *std.mem.Allocator, exclude: []const []const u8) !u8 {
    var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();

    if (!is_header_printed) {
        try stdout.print("{s}{s}FOUND IN:{s}\n", .{ Color.Green, Color.Bold, Color.Reset });
        is_header_printed = true;
    }

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

            const subdir_path = try std.fs.path.join(allocator.*, &.{ dir_path, entry.name });
            defer allocator.free(subdir_path);

            _ = try grepSearch(subdir_path, target, allocator, exclude);
            continue;
        }

        if (entry.kind != .file) continue;

        var file = try dir.openFile(entry.name, .{});
        defer file.close();
        var reader = file.reader();

        const file_size = try file.getEndPos();
        if (file_size > MAX_FILE_SIZE) {
            try stdout.print("{s}{s}ERROR: File Too Large to Process.{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
            try buf.flush();
            return 1;
        }

        var buffer: [MAX_BUFFER_SIZE]u8 = undefined;
        var line_number: usize = 0;
        const found_at: usize = 0;

        var total_read: usize = 0;
        while (try reader.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
            total_read += line.len;
            line_number += 1;

            if (total_read > MAX_FILE_SIZE) {
                try stdout.print("{s}{s}ERROR: File Too Large to Process.{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
                try buf.flush();
                return 1;
            }

            if (mem.containsAtLeast(u8, line, 1, target)) {
                const file_path = try std.fs.path.join(allocator.*, &.{ dir_path, "/", entry.name });
                defer allocator.free(file_path);

                try stdout.print("    {s}{s}{s} AT {s}{d}:{d}{s}\n", .{ Color.Cyan, file_path, Color.Reset, Color.Yellow, line_number, found_at, Color.Reset });
            }
            try buf.flush();
        }
    }

    return 0;
}
