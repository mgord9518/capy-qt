const std = @import("std");
const lib = @import("../../capy.zig");
const common = @import("common.zig");
const c = common.c;
const shared = @import("../shared.zig");

const Canvas = @This();
const Window = @import("Window.zig");

/// Actual GtkCanvas
peer: *anyopaque,

pub const DrawContextImpl = struct {
    pub const TextLayout = struct {
        pub fn setFont(self: *TextLayout, font: lib.Font) void {
            _ = self;
            _ = font;
        }

        pub fn deinit(self: *TextLayout) void {
            _ = self;
        }

        pub fn getTextSize(self: *TextLayout, str: []const u8) lib.Size {
            _ = self;
            _ = str;

            unreachable;
        }

        pub fn init() TextLayout {
            unreachable;
        }
    };

    pub fn setColorRGBA(self: *DrawContextImpl, r: f32, g: f32, b: f32, a: f32) void {
        _ = self;
        _ = r;
        _ = g;
        _ = b;
        _ = a;
    }

    pub fn setLinearGradient(self: *DrawContextImpl, gradient: shared.LinearGradient) void {
        _ = self;
        _ = gradient;
    }

    pub fn rectangle(self: *DrawContextImpl, x: i32, y: i32, w: u32, h: u32) void {
        _ = self;
        _ = x;
        _ = y;
        _ = w;
        _ = h;
    }

    // The radiuses are in order: top left, top right, bottom left, bottom right
    pub fn roundedRectangleEx(self: *DrawContextImpl, x: i32, y: i32, w: u32, h: u32, corner_radiuses: [4]f32) void {
        _ = self;
        _ = x;
        _ = y;
        _ = w;
        _ = h;
        _ = corner_radiuses;
    }

    pub fn ellipse(self: *DrawContextImpl, x: i32, y: i32, w: u32, h: u32) void {
        _ = self;
        _ = x;
        _ = y;
        _ = w;
        _ = h;
    }

    pub fn clear(self: *DrawContextImpl, x: u32, y: u32, w: u32, h: u32) void {
        _ = self;
        _ = x;
        _ = y;
        _ = w;
        _ = h;
    }

    pub fn text(self: *DrawContextImpl, x: i32, y: i32, layout: TextLayout, str: []const u8) void {
        _ = self;
        _ = x;
        _ = y;
        _ = layout;
        _ = str;
    }

    pub fn line(self: *DrawContextImpl, x1: i32, y1: i32, x2: i32, y2: i32) void {
        c.cairo_move_to(self.cr, @as(f64, @floatFromInt(x1)), @as(f64, @floatFromInt(y1)));
        c.cairo_line_to(self.cr, @as(f64, @floatFromInt(x2)), @as(f64, @floatFromInt(y2)));
        c.cairo_stroke(self.cr);
    }

    pub fn image(self: *DrawContextImpl, x: i32, y: i32, w: u32, h: u32, data: lib.ImageData) void {
        c.cairo_save(self.cr);
        defer c.cairo_restore(self.cr);

        const width = @as(f64, @floatFromInt(data.width));
        const height = @as(f64, @floatFromInt(data.height));
        c.cairo_scale(self.cr, @as(f64, @floatFromInt(w)) / width, @as(f64, @floatFromInt(h)) / height);
        c.gdk_cairo_set_source_pixbuf(
            self.cr,
            data.peer.peer,
            @as(f64, @floatFromInt(x)) / (@as(f64, @floatFromInt(w)) / width),
            @as(f64, @floatFromInt(y)) / (@as(f64, @floatFromInt(h)) / height),
        );
        c.cairo_paint(self.cr);
    }

    pub fn setStrokeWidth(self: *DrawContextImpl, width: f32) void {
        c.cairo_set_line_width(self.cr, width);
    }

    pub fn stroke(self: *DrawContextImpl) void {
        c.cairo_stroke(self.cr);
    }

    pub fn fill(self: *DrawContextImpl) void {
        c.cairo_fill(self.cr);
    }
};

pub fn create() common.BackendError!Canvas {
    return Canvas{ .peer = null };
}
