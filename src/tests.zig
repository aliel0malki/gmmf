const std = @import("std");
const Core = @import("core.zig");

const dir = "__tests__";

test "find" {
    var allocator = std.testing.allocator;
    var core: Core.Core = try Core.Core.init(&allocator);

    const found = try core.find(dir, "needle.txt", &[_][]const u8{"exclude"});
    try std.testing.expect(found);

    const not_found = try core.find(dir, "missing.txt", &[_][]const u8{"exclude"});
    try std.testing.expect(!not_found);
}

test "grepSearch" {
    var allocator = std.testing.allocator;
    var core: Core.Core = try Core.Core.init(&allocator);

    const found = try core.grep(dir, "needle", &[_][]const u8{"exclude"});
    try std.testing.expect(found);

    const not_found = try core.grep(dir, "missing", &[_][]const u8{"exclude"});
    try std.testing.expect(!not_found);
}
