const std = @import("std");
const Color = @import("config.zig").Color;
const mem = std.mem;
const out = std.io.getStdOut();
var buf = std.io.bufferedWriter(out.writer());
var stdout = buf.writer();

const MAX_FILE_SIZE = 100 * 1024 * 1024;
const MAX_BUFFER_SIZE = 4 * 1024 * 1024;

pub fn processFind(
    allocator: *std.mem.Allocator,
    dir_path: []const u8,
    file: []const u8,
    target: []const u8,
) !bool {
    if (mem.containsAtLeast(u8, file, 1, target)) {
        const file_path = try std.fs.path.join(allocator.*, &.{ dir_path, "/", file });
        defer allocator.free(file_path);
        try stdout.print("    {s}{s}{s}\n", .{ Color.Cyan, file_path, Color.Reset });
        try buf.flush();
        return true;
    }
    return false;
}

pub fn processGrep(
    allocator: *std.mem.Allocator,
    dir: *std.fs.Dir,
    cwd: []const u8,
    file_path: []const u8,
    target: []const u8,
) !bool {
    var file = try dir.openFile(file_path, .{});
    defer file.close();
    var buffer_reader = std.io.bufferedReader(file.reader());
    var reader = buffer_reader.reader();

    const file_size = try file.getEndPos();
    if (file_size > MAX_FILE_SIZE) {
        std.debug.print("{s}{s}ERROR: File Too Large to Process.{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
        try buf.flush();
        return false;
    }

    var buffer: [MAX_BUFFER_SIZE]u8 = undefined;
    var line_number: usize = 0;
    while (try reader.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        line_number += 1;
        if (mem.containsAtLeast(u8, line, 1, target)) {
            const found_at = mem.indexOf(u8, line, target).?;
            const output_path = try std.fs.path.join(allocator.*, &.{ cwd, "/", file_path });
            defer allocator.free(output_path);
            try stdout.print("    {s}{s}{s} AT {s}{d}:{d}{s}\n", .{ Color.Cyan, output_path, Color.Reset, Color.Yellow, line_number, found_at, Color.Reset });
            try buf.flush();
            return true;
        }
    }

    return false;
}
