////////////////////////////////////////////////////////////////////////////////
//  GMMF - General Multi-Purpose File Finder
//  ----------------------------------------
//  Author: Ali El0malki
//  License: MIT License
//  Version: 0.45.0
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
const Color = @import("utils.zig").Color;
const findFileRecursive = @import("utils.zig").findFileRecursive;
const grepSearch = @import("utils.zig").grepSearch;

pub fn main() !u8 {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const args = try proc.argsAlloc(allocator);
    defer proc.argsFree(allocator, args);

    if (args.len < 3) {
        try @import("constants.zig").print_usage();
        return 69;
    }

    const mode = if (args.len > 3) args[1] else "-f";
    const searchTerm = args[args.len - 2];
    const directory = args[args.len - 1];

    fs.cwd().access(directory, .{}) catch |err| {
        switch (err) {
            error.FileNotFound => {
                try stdout.print("{s}{s}ERROR: Directory Not Found{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
                return 1;
            },
            else => return err,
        }
    };

    if (mem.eql(u8, mode, "-g") or mem.eql(u8, mode, "grep")) {
        try stdout.print("{s}{s}Mode: GREP (case-sensitive){s}\n", .{ Color.Bold, Color.Yellow, Color.Reset });
        const found = try grepSearch(directory, searchTerm, &allocator);
        if (!found) {
            try stdout.print("{s}{s}No Matches Found{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
            return 1;
        }
    } else if (mem.eql(u8, mode, "-f") or mem.eql(u8, mode, "find")) {
        try stdout.print("{s}{s}Mode: FIND{s}\n", .{ Color.Bold, Color.Yellow, Color.Reset });
        if (!(try findFileRecursive(directory, searchTerm, &allocator))) {
            try stdout.print("{s}{s}File Not Found{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
            return 1;
        }
    } else {
        try stdout.print("{s}{s}Invalid Mode: {s}{s}\n", .{ Color.Red, Color.Bold, mode, Color.Reset });
        return 1;
    }

    try stdout.print("\n{s}© 2024 - GMMF (General Multi-Purpose File Finder){s}\n", .{ Color.Bold, Color.Reset });
    return 0;
}
