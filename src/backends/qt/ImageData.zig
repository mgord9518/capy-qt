const std = @import("std");
const lib = @import("../../capy.zig");
const common = @import("common.zig");
const DrawContext = @import("../../backend.zig").DrawContext;

const ImageData = @This();

peer: ?*anyopaque,
mutex: std.Thread.Mutex = .{},
width: usize,
height: usize,

pub const DrawLock = struct {
    _surface: ?*anyopaque,
    draw_context: DrawContext,
    data: *ImageData,

    pub fn end(self: DrawLock) void {
        _ = self;
    }
};

// TODO: copy bytes to a new array
pub fn from(width: usize, height: usize, stride: usize, cs: lib.Colorspace, bytes: []const u8) !ImageData {
    _ = stride;
    _ = cs;
    _ = bytes;

    return ImageData{
        .peer = null,
        .width = width,
        .height = height,
    };
}

pub fn draw(self: *ImageData) DrawLock {
    self.mutex.lock();
    // TODO: just create one surface and use it forever
    return DrawLock{
        ._surface = undefined,
        .draw_context = undefined,
        .data = self,
    };
}

pub fn deinit(self: *ImageData) void {
    self.mutex.lock();
    defer self.mutex.unlock();
}
