// ----------------------------------------------------------------------------
//  Copyright (c) 2024 ali elmalki

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
// ----------------------------------------------------------------------------

const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const heap = std.heap;
const proc = std.process;
const stdout = std.io.getStdOut().writer();
const stderr = std.io.getStdErr().writer();
const Color = @import("config.zig").Color;
const Core = @import("core.zig");

pub fn main() !u8 {
    var arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();

    const args = try proc.argsAlloc(allocator);
    defer proc.argsFree(allocator, args);

    if (args.len < 3) {
        try @import("config.zig").print_usage();
        return 69;
    }

    const mode = args[1];
    const searchTerm = args[2];
    const directory = args[3];
    var exclude = std.ArrayList([]const u8).init(allocator);
    defer exclude.deinit();

    for (args) |arg| {
        if (mem.startsWith(u8, arg, "-ex=")) {
            try exclude.append(arg[4..]);
        }
    }

    fs.cwd().access(directory, .{}) catch |err| {
        switch (err) {
            error.FileNotFound => {
                try stderr.print("{s}{s}DIRECTORY NOT FOUND{s}\n", .{ Color.Red, Color.Bold, Color.Reset });
                return 1;
            },
            else => {
                try stderr.print("{s}{s}ERROR: {s}{s}\n", .{ Color.Red, Color.Bold, @errorName(err), Color.Reset });
                return 1;
            },
        }
    };

    var core: Core.Core = try Core.Core.init(&allocator);

    if (mem.eql(u8, mode, "-g") or mem.eql(u8, mode, "grep")) {
        try stdout.print("{s}{s}Mode: GREP (case-sensitive){s}\n", .{ Color.Bold, Color.Yellow, Color.Reset });
        const found = try core.grep(directory, searchTerm, exclude.items);
        if (found) {
            return 0;
        }
        return 1;
    } else if (mem.eql(u8, mode, "-f") or mem.eql(u8, mode, "find")) {
        try stdout.print("{s}{s}Mode: FIND{s}\n", .{ Color.Bold, Color.Yellow, Color.Reset });
        const found = try core.find(directory, searchTerm, exclude.items);
        if (found) {
            return 0;
        }
        return 1;
    } else {
        try stderr.print("{s}{s}INVALID MODE: {s}{s}\n", .{ Color.Red, Color.Bold, mode, Color.Reset });
        return 1;
    }

    try stdout.print("\n{s}© 2024 - GMMF (General Multi-Purpose File Finder){s}\n", .{ Color.Bold, Color.Reset });
    return 0;
}
