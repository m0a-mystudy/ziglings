//
// 'for'ループを見てください! 
// for ループでは、配列の各要素に対してコードを実行することができます。
//
//     for (items) |item| {
//
//         // itemに対して何かを行う
//
//     }
//
const std = @import("std");

pub fn main() void {
    const story = [_]u8{ 'h', 'h', 's', 'n', 'h' };

    std.debug.print("A Dramatic Story: ", .{});

    for (???) |???| {
        if (scene == 'h') std.debug.print(":-)  ", .{});
        if (scene == 's') std.debug.print(":-(  ", .{});
        if (scene == 'n') std.debug.print(":-|  ", .{});
    }

    std.debug.print("The End.\n", .{});
}
// forループは「slices」と呼ばれるものに対しても機能することに注意。
// これは後で見ることになります。
