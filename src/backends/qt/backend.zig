// NOTICE: This backend is heavily WIP

const std = @import("std");
const shared = @import("../shared.zig");
const lib = @import("../../capy.zig");
const common = @import("common.zig");
const c = common.c;

// TODO
//pub const Capabilities = .{ .useEventLoop = true };

pub var application: ?*c.QtC_Application = null;

pub const BackendError = error{
    InitializationError,
};

pub fn init() BackendError!void {
    if (application == null) {
        application = c.QtC_Application_new(
            @intCast(std.os.argv.len),
            @ptrCast(std.os.argv.ptr),
        );

        if (application == null) {
            return error.InitializationError;
        }
    }
}

pub fn showNativeMessageDialog(msgType: shared.MessageType, comptime fmt: []const u8, args: anytype) void {
    _ = msgType;

    const msg = std.fmt.allocPrintZ(lib.internal.scratch_allocator, fmt, args) catch {
        std.log.err("Could not launch message dialog, original text: " ++ fmt, args);
        return;
    };

    defer lib.internal.scratch_allocator.free(msg);
}

pub const PeerType = *anyopaque;

// pub const Button = @import("../../flat/button.zig").FlatButton;
pub const Monitor = @import("Monitor.zig");
pub const Window = @import("Window.zig");
pub const Button = @import("Button.zig");
//pub const CheckBox = @import("CheckBox.zig");
//pub const Dropdown = @import("Dropdown.zig");
//pub const Slider = @import("Slider.zig");
//pub const Label = @import("Label.zig");
//pub const TextArea = @import("TextArea.zig");
//pub const TextField = @import("TextField.zig");
pub const Canvas = @import("Canvas.zig");
pub const Container = @import("Container.zig");
//pub const TabContainer = @import("TabContainer.zig");
//pub const ScrollView = @import("ScrollView.zig");
//pub const ImageData = @import("ImageData.zig");
//pub const NavigationSidebar = @import("NavigationSidebar.zig");
//pub const AudioGenerator = @import("AudioGenerator.zig");

pub fn postEmptyEvent() void {
    // TODO: implement postEmptyEvent()
}

// TODO: Actually step through the event loop
pub fn runStep(step: shared.EventLoopStep) bool {
    _ = step;

    c.QtC_Application_exec(application);

    return false;
}
