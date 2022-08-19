//
// 「defer」の仕組みがわかったところで、もっと面白いことをやってみましょう。
// してみましょう。
//
const std = @import("std");

pub fn main() void {
    const animals = [_]u8{ 'g', 'c', 'd', 'd', 'g', 'z' };

    for (animals) |a| printAnimal(a);

    std.debug.print("done.\n", .{});
}

// この関数は、動物の名前を "(Goat)" のような括弧で表示することを想定していますが、
// この関数が4つの異なる場所で返すことができるにもかかわらず、
// なぜか最後の括弧を表示する必要があります
fn printAnimal(animal: u8) void {
    std.debug.print("(", .{});

    std.debug.print(") ", .{}); // <---- どうします？

    if (animal == 'g') {
        std.debug.print("Goat", .{});
        return;
    }
    if (animal == 'c') {
        std.debug.print("Cat", .{});
        return;
    }
    if (animal == 'd') {
        std.debug.print("Dog", .{});
        return;
    }

    std.debug.print("Unknown", .{});
}
