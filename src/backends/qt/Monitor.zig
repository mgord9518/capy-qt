const std = @import("std");
const lib = @import("../../capy.zig");

const Monitor = @This();

var monitor_list: ?[]Monitor = null;

peer: *anyopaque,
internal_name: ?[]const u8 = null,

pub fn getList() []Monitor {
    //    if (monitor_list) |list| {
    //        return list;
    //    } else {
    //        // TODO: gdk_display_manager_list_displays
    //        const display = c.gdk_display_get_default();
    //        const list_model = c.gdk_display_get_monitors(display);
    //        const n: usize = c.g_list_model_get_n_items(list_model);
    //        const list = lib.internal.lasting_allocator.alloc(Monitor, n) catch @panic("OOM");
    //
    //        for (0..c.g_list_model_get_n_items(list_model)) |i| {
    //            const item: *c.GdkMonitor = @ptrCast(c.g_list_model_get_item(list_model, @intCast(i)).?);
    //            list[i] = Monitor{ .peer = item };
    //        }
    //        monitor_list = list;
    //        return list;
    //    }
    return &.{};
}

pub fn deinitAllPeers() void {}

pub fn getName(self: *Monitor) []const u8 {
    _ = self;
    return "FIXME";
}

pub fn getInternalName(self: *Monitor) []const u8 {
    _ = self;
    return "FIXME";
}

pub fn getWidth(self: *Monitor) u32 {
    _ = self;
    return 500;
}

pub fn getHeight(self: *Monitor) u32 {
    _ = self;
    return 500;
}

pub fn getRefreshRateMillihertz(self: *Monitor) u32 {
    _ = self;
    return 60_000;
}

pub fn getDpi(self: *Monitor) u32 {
    _ = self;
    return 72;
}

pub fn getNumberOfVideoModes(self: *Monitor) usize {
    // TODO: find a way to actually list video modes on GTK+
    _ = self;
    return 1;
}

pub fn getVideoMode(self: *Monitor, index: usize) lib.VideoMode {
    _ = index;
    return .{
        .width = self.getWidth(),
        .height = self.getHeight(),
        .refresh_rate_millihertz = self.getRefreshRateMillihertz(),
        .bit_depth = 32,
    };
}

pub fn deinit(self: *Monitor) void {
    _ = self;
}
