const std = @import("std");
const lib = @import("../../capy.zig");
const common = @import("common.zig");
const c = common.c;
const Monitor = @import("Monitor.zig");
const ImageData = @import("ImageData.zig");
const shared = @import("../shared.zig");
const trait = @import("../../trait.zig");

const backend = @import("backend.zig");

pub const EventType = shared.BackendEventType;

const Window = @This();

peer: *c.QtC_Widget,

pub fn create() common.BackendError!Window {
    const maybe_win = c.QtC_Widget_new(null, c.QtC_WindowFlags_Window);
    if (maybe_win) |win| {
        return Window{ .peer = win };
    }

    return error.InitializationError;
}

pub fn resize(self: *Window, width: c_int, height: c_int) void {
    c.QtC_Widget_resize(self.peer, width, height);
}

pub fn setTitle(self: *Window, title: []const u8) void {
    const str = c.QtC_String_new(title.ptr, @intCast(title.len));
    defer c.QtC_String_delete(str);

    c.QtC_Widget_setWindowTitle(self.peer, str);
}

// TODO
pub fn setIcon(self: *Window, data: ImageData) void {
    _ = self;
    _ = data;
}

pub fn setChild(self: *Window, peer: ?*anyopaque) void {
    _ = self;
    _ = peer;
}

pub inline fn setCallback(self: *Window, comptime eType: EventType, cb: anytype) !void {
    _ = self;
    _ = eType;
    _ = cb;
}

pub inline fn setUserData(self: *Window, data: anytype) void {
    _ = self;
    comptime {
        if (!trait.isSingleItemPtr(@TypeOf(data))) {
            @compileError(std.fmt.comptimePrint("Expected single item pointer, got {s}", .{@typeName(@TypeOf(data))}));
        }
    }
}

pub fn setMenuBar(self: *Window, bar: lib.MenuBar) void {
    _ = self;
    _ = bar;
}

pub fn setSourceDpi(self: *Window, dpi: u32) void {
    _ = self;
    _ = dpi;
}

pub fn setFullscreen(self: *Window, monitor: ?*Monitor, video_mode: ?lib.VideoMode) void {
    _ = self;
    _ = monitor;
    _ = video_mode;
}

pub fn unfullscreen(self: *Window) void {
    _ = self;
}

pub fn show(self: *Window) void {
    c.QtC_Widget_show(self.peer);
}

pub fn registerTickCallback(self: *Window) void {
    _ = self;
}

pub fn close(self: *Window) void {
    _ = self;
}
