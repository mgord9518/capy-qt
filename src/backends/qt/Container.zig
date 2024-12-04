const std = @import("std");
const lib = @import("../../capy.zig");
const common = @import("common.zig");
const c = common.c;
const trait = @import("../../trait.zig");
const shared = @import("../shared.zig");

const Container = @This();

peer: *anyopaque,

pub fn create() common.BackendError!Container {
    return Container{ .peer = undefined };
}

pub fn deinit(self: *const Container) void {
    _ = self;
}

pub fn add(self: *const Container, peer: *anyopaque) void {
    _ = self;
    _ = peer;
}

pub fn remove(self: *const Container, peer: *anyopaque) void {
    _ = self;
    _ = peer;
}

pub fn move(self: *const Container, peer: *anyopaque, x: u32, y: u32) void {
    _ = self;
    _ = peer;
    _ = x;
    _ = y;
}

pub fn resize(self: *const Container, peer: *anyopaque, w: u32, h: u32) void {
    _ = self;
    _ = peer;
    _ = w;
    _ = h;
}

pub fn setTabOrder(self: *const Container, peers: []const *anyopaque) void {
    _ = self;
    _ = peers;
}

pub fn getX(self: *const Container) c_int {
    _ = self;
    return 0;
}

pub fn getY(self: *const Container) c_int {
    _ = self;
    return 0;
}

pub fn getWidth(self: *const Container) c_int {
    _ = self;
    return 0;
}

pub fn getHeight(self: *const Container) c_int {
    _ = self;
    return 0;
}

pub inline fn setUserData(self: *Container, data: anytype) void {
    _ = self;
    comptime {
        if (!trait.isSingleItemPtr(@TypeOf(data))) {
            @compileError(std.fmt.comptimePrint("Expected single item pointer, got {s}", .{@typeName(@TypeOf(data))}));
        }
    }
}

pub fn setCallback(self: *Container, comptime Event: shared.BackendEventType, cb: anytype) !void {
    _ = self;
    _ = Event;
    _ = cb;
}

pub fn setOpacity(self: *Container, opacity: f64) void {
    _ = self;
    _ = opacity;
}
