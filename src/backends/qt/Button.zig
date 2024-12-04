const std = @import("std");
const common = @import("common.zig");
const c = common.c;
const lib = @import("../../capy.zig");
const trait = @import("../../trait.zig");
const shared = @import("../shared.zig");

const Button = @This();

peer: *c.QtC_PushButton,

pub fn create() common.BackendError!Button {
    const str = c.QtC_String_new("", 0);
    defer c.QtC_String_delete(str);
    const icon = c.QtC_Icon_new() orelse return error.UnknownError;

    return .{ .peer = c.QtC_PushButton_new(icon, str, null) orelse return error.UnknownError };
}

pub fn deinit(self: *const Button) void {
    c.QtC_PushButton_delete(self.peer);
}

pub fn setLabel(self: *const Button, label: []const u8) void {
    const str = c.QtC_String_new(
        @ptrCast(label.ptr),
        @intCast(label.len),
    );
    defer c.QtC_String_delete(str);

    c.QtC_AbstractButton_setText(
        @as(*c.QtC_AbstractButton, @ptrCast(self.peer)),
        str,
    );

    c.QtC_Widget_show(
        @as(*c.QtC_Widget, @ptrCast(self.peer)),
    );
}

// TODO
pub fn getLabel(self: *const Button) [:0]const u8 {
    _ = self;
    @panic("getLabel not yet implemented for Qt backend!");
}

// TODO
pub fn getPreferredSize(self: *const Button) lib.Size {
    _ = self;

    return lib.Size.init(
        50,
        50,
    );
}

// TODO
pub fn setEnabled(self: *const Button, enabled: bool) void {
    _ = self;
    _ = enabled;
}

pub inline fn setUserData(self: *Button, data: anytype) void {
    _ = self;
    comptime {
        if (!trait.isSingleItemPtr(@TypeOf(data))) {
            @compileError(std.fmt.comptimePrint("Expected single item pointer, got {s}", .{@typeName(@TypeOf(data))}));
        }
    }
}

pub fn setOpacity(self: *Button, opacity: f64) void {
    _ = self;
    _ = opacity;
}

pub fn setCallback(self: *Button, comptime Event: shared.BackendEventType, cb: anytype) !void {
    _ = self;
    _ = Event;
    _ = cb;
}
