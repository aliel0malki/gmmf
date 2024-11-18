const std = @import("std");
const findFileRecursive = @import("utils.zig").findFileRecursive;
const grepSearch = @import("utils.zig").grepSearch;

const dir = "__tests__";

test "findFileRecursive" {
    var allocator = std.testing.allocator;

    const found = try findFileRecursive(dir, "target.txt", &allocator, &[_][]const u8{"exclude"});
    try std.testing.expect(found == true);

    const not_found = try findFileRecursive(dir, "missing.txt", &allocator, &[_][]const u8{"exclude"});
    try std.testing.expect(not_found != true);
}

test "grepSearch" {
    var allocator = std.testing.allocator;

    const found = try grepSearch(dir, "needle", &allocator, &[_][]const u8{"exclude"});
    try std.testing.expect(found == true);

    const not_found = try grepSearch(dir, "missing", &allocator, &[_][]const u8{"exclude"});
    try std.testing.expect(not_found != true);
}
