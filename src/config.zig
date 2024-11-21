const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub const Color = struct {
    pub const Reset = "\x1b[0m";
    pub const Green = "\x1b[32m";
    pub const Yellow = "\x1b[33m";
    pub const Red = "\x1b[31m";
    pub const Cyan = "\x1b[36m";
    pub const Bold = "\x1b[1m";
};

pub fn print_usage() !void {
    try stdout.print("\n{s}GMMF - General Multi-Purpose File Finder{s}\n", .{ Color.Cyan, Color.Reset });
    try stdout.print("\nUSAGE:\n", .{});
    try stdout.print("  gmmf <mode> <search term> <directory> [options]\n", .{});

    try stdout.print("\nARGUMENTS:\n", .{});
    try stdout.print("  <mode>                     : Mode to use (find or grep)\n", .{});
    try stdout.print("  <search term>              : File name or search string to look for\n", .{});
    try stdout.print("  <directory>                : Directory to search in\n", .{});

    try stdout.print("\nMODES:\n", .{});
    try stdout.print("  -f (find)                 : Search for a file\n", .{});
    try stdout.print("  -g (grep)                 : Search for a string inside files\n", .{});

    try stdout.print("\nOPTIONS:\n", .{});
    try stdout.print("  -ex=<directory>              : Exclude directories from search\n", .{});

    try stdout.print("\nEXAMPLES:\n", .{});
    try stdout.print("  gmmf -f documents.txt /home/user\n", .{});
    try stdout.print("  gmmf -g \"search text\" /home/user\n", .{});
    try stdout.print("  gmmf -g \"search text\" /home/user -ex=workspace -ex=dont-touch\n", .{});
}
