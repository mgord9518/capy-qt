const std = @import("std");
const capy = @import("capy");

pub fn main() !void {
    try capy.init();
    defer capy.deinit();

    var window = try capy.Window.init();

    window.show();

    window.setTitle("bruh");

    //var row = try capy.row(.{}, .{});

    //try row.add(
    const but = capy.button(.{ .label = "test" });
    //);

    but.setLabel("ligma");

    try but.show();

    //window.resize(1000, 420);

    //    var column = try capy.column(.{}, .{});
    //    var i: usize = 0;
    //    while (i < 4) : (i += 1) {
    //        var row = try capy.row(.{}, .{});
    //        var j: usize = 0;
    //        while (j < 20) : (j += 1) {
    //            try row.add(try capy.column(.{}, .{capy.label(.{ .text = "Sample Item" })}));
    //        }
    //
    //        try column.add(capy.label(.{ .text = "Row" }));
    //        try column.add(try capy.scrollable(row));
    //    }
    //
    //    try window.set(capy.scrollable(column));
    window.setPreferredSize(200, 600);

    capy.runEventLoop();
}
