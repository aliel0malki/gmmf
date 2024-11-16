const std = @import("std");
const stdout = std.io.getStdOut().writer();
const Color = @import("utils.zig").Color;

pub fn print_usage() !void {
    try stdout.print("\n{s}GMMF - General Multi-Purpose File Finder{s}\n", .{ Color.Cyan, Color.Reset });
    try stdout.print("\nUSAGE:\n", .{});
    try stdout.print("\ngmmf -g/-f <search term> <directory>\n", .{});

    try stdout.print("\nARGUMENTS:\n", .{});
    try stdout.print("  -g/-f                      : Mode, '-g' for grep or '-f' for find (default: '-f')\n", .{});
    try stdout.print("  <search term>              : File name or search string to look for\n", .{});
    try stdout.print("  <directory>                : Directory to search in\n", .{});

    try stdout.print("\nEXAMPLES:\n", .{});
    try stdout.print("  gmmf -f Documents.txt /home/user\n", .{});
    try stdout.print("  gmmf -g 'find this text' /home/user\n", .{});

    try stdout.print("\nMODES:\n", .{});
    try stdout.print("  -f (find) (default)        : Search for a file by name\n", .{});
    try stdout.print("  -g (grep)                 : Search for a string inside files\n", .{});

    try stdout.print("\nNOTE: If the [mode] is omitted, the default mode is '-f'\n", .{});
}
