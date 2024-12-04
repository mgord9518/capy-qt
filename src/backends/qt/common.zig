const std = @import("std");
const trait = @import("../../trait.zig");
const lib = @import("../../capy.zig");

const shared = @import("../shared.zig");

pub const EventFunctions = @import("backend.zig").EventFunctions;
pub const EventType = shared.BackendEventType;
pub const BackendError = shared.BackendError;
pub const MouseButton = shared.MouseButton;
pub const PeerType = *anyopaque;

pub const c = @cImport({
    @cInclude("QtC6/qt.h");
    @cInclude("QtC6/abstractbutton.h");
    @cInclude("QtC6/application.h");
    @cInclude("QtC6/object.h");
    @cInclude("QtC6/layout.h");
    @cInclude("QtC6/boxlayout.h");
    @cInclude("QtC6/widget.h");
    @cInclude("QtC6/label.h");
    @cInclude("QtC6/listview.h");
    @cInclude("QtC6/listwidget.h");
    @cInclude("QtC6/lineedit.h");
    @cInclude("QtC6/pushbutton.h");
    @cInclude("QtC6/pixmap.h");
    @cInclude("QtC6/string.h");
    @cInclude("QtC6/menubar.h");
    @cInclude("QtC6/mainwindow.h");
    @cInclude("QtC6/progressbar.h");
    @cInclude("QtC6/columnview.h");
    @cInclude("QtC6/treeview.h");
    @cInclude("QtC6/treewidget.h");
    @cInclude("QtC6/treewidgetitem.h");
    @cInclude("QtC6/stringlist.h");
    @cInclude("QtC6/tabwidget.h");
    @cInclude("QtC6/icon.h");
});

/// user data used for handling events
pub const EventUserData = struct {
    user: EventFunctions = .{},
    class: EventFunctions = .{},
    userdata: usize = 0,
    classUserdata: usize = 0,
    peer: PeerType,
    focusOnClick: bool = false,
    actual_x: ?u31 = null,
    actual_y: ?u31 = null,
    actual_width: ?u31 = null,
    actual_height: ?u31 = null,
};

pub fn Events(comptime T: type) type {
    return struct {
        const Self = @This();

        pub fn setupEvents(widget: *anyopaque) BackendError!void {
            _ = widget;
        }

        pub inline fn copyEventUserData(source: *anyopaque, destination: anytype) void {
            _ = source;
            _ = destination;
        }

        pub fn deinit(self: *const T) void {
            _ = self;
        }

        pub inline fn setUserData(self: *T, data: anytype) void {
            comptime {
                if (!trait.isSingleItemPtr(@TypeOf(data))) {
                    @compileError(std.fmt.comptimePrint("Expected single item pointer, got {s}", .{@typeName(@TypeOf(data))}));
                }
            }

            getEventUserData(self.peer).userdata = @intFromPtr(data);
        }

        pub inline fn setCallback(self: *T, comptime eType: EventType, cb: anytype) !void {
            _ = self;
            _ = eType;
            _ = cb;
        }

        pub fn setOpacity(self: *T, opacity: f64) void {
            _ = self;
            _ = opacity;
        }

        /// Requests a redraw
        pub fn requestDraw(self: *T) !void {
            _ = self;
        }

        pub fn getX(self: *const T) c_int {
            _ = self;
            return 0;
        }

        pub fn getY(self: *const T) c_int {
            _ = self;
            return 0;
        }

        pub fn getWidth(self: *const T) c_int {
            _ = self;
            return 0;
        }

        pub fn getHeight(self: *const T) c_int {
            _ = self;
            return 0;
        }

        pub fn getPreferredSize(self: *const T) lib.Size {
            _ = self;
            return lib.Size.init(
                0,
                0,
            );
        }
    };
}

pub inline fn getEventUserData(peer: *anyopaque) *EventUserData {
    _ = peer;
    return undefined;
}

pub fn getXPosFromPeer(peer: PeerType) c_int {
    _ = peer;
    return 0;
}

pub fn getYPosFromPeer(peer: PeerType) c_int {
    _ = peer;
    return 0;
}

pub fn getWidthFromPeer(peer: PeerType) c_int {
    _ = peer;
    return 0;
}

pub fn getHeightFromPeer(peer: PeerType) c_int {
    _ = peer;
    return 0;
}

/// Since GTK4 removed the ::size-allocate signal which was used to listen to widget resizes,
/// backend.Container now directly calls this method in order to emit the event.
pub fn widgetSizeChanged(peer: *anyopaque, width: u32, height: u32) void {
    _ = peer;
    _ = width;
    _ = height;
}
