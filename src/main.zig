////////////////////////////////////////////////////////////////////////////////
//  GMMF - General Multi-Purpose File Finder
//  ----------------------------------------
//  Author: Ali El0malki
//  License: MIT License
//  Version: 0.2.0
//
//  Copyright (c) 2024 ali elmalki
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const heap = std.heap;
const proc = std.process;
const stdout = std.io.getStdOut().writer();

const Color = struct {
    pub const Reset = "\x1b[0m";
    pub const Green = "\x1b[32m";
    pub const Yellow = "\x1b[33m";
    pub const Red = "\x1b[31m";
    pub const Cyan = "\x1b[36m";
    pub const Bold = "\x1b[1m";
};

fn findFileRecursive(dir_path: []const u8, target: []const u8, allocator: *std.mem.Allocator) !bool {
    var dir = try fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();

    while (try iter.next()) |entry| {
        if (entry.kind == .directory) {
            const subdir_path = try std.fs.path.join(allocator.*, &.{ dir_path, entry.name });
            defer allocator.free(subdir_path);

            if (try findFileRecursive(subdir_path, target, allocator)) {
                return true;
            }
        }

        if (mem.eql(u8, entry.name, target)) {
            try stdout.print("{s}{s}FOUND: {s}{s}/{s}{s}\n", .{ Color.Bold, Color.Green, Color.Cyan, dir_path, entry.name, Color.Reset });
            return true;
        }
    }

    return false;
}

pub fn main() !u8 {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const args = try proc.argsAlloc(allocator);
    defer proc.argsFree(allocator, args);

    if (args.len < 3) {
        try stdout.print("{s}{s}GMMF - General Multi-Purpose File Finder{s}\n\n", .{ Color.Bold, Color.Cyan, Color.Reset });
        try stdout.print("{s}USAGE:{s}\n\t{s}gmmf <directory> <file name>{s}\n", .{ Color.Bold, Color.Yellow, Color.Cyan, Color.Reset });
        return 69;
    }

    fs.cwd().access(args[1], .{}) catch |err| {
        switch (err) {
            error.FileNotFound => {
                try stdout.print("{s}{s}ERROR: Directory Not Found{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
                return 1;
            },
            else => return err,
        }
    };

    if (!(try findFileRecursive(args[1], args[2], &allocator))) {
        try stdout.print("{s}{s}File Not Found{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
        try stdout.print("\n{s}© 2024 - GMMF (General Multi-Purpose File Finder){s}\n", .{ Color.Bold, Color.Reset });
        return 1;
    }

    try stdout.print("\n{s}© 2024 - GMMF (General Multi-Purpose File Finder){s}\n", .{ Color.Bold, Color.Reset });
    return 0;
}
