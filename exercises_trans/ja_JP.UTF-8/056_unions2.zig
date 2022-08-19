//
// ユニオンのアクティブフィールドを手動で追跡しなければならないのは、
// 実に不便ですね？
//
//ありがたいことに、Zigには「タグ付きユニオン」があり、
// どのフィールドがアクティブかを表す列挙値をユニオンの中に
// 格納することができます。
//
//     const FooTag = enum{ small, medium, large };
//
//     const Foo = union(FooTag) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// これで、ユニオンで直接スイッチを使用することができます。
// アクティブなフィールドに作用します。
//
//     var f = Foo{ .small = 10 };
//
//     switch (f) {
//         .small => |my_small| do_something(my_small),
//         .medium => |my_medium| do_something(my_medium),
//         .large => |my_large| do_something(my_large),
//     }
//
// Insectsにタグ付きユニオンを使わせよう（Doctor Zorapteraの承認済み）
// 
//
const std = @import("std");

const InsectStat = enum { flowers_visited, still_alive };

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 16 };

    std.debug.print("Insect report! ", .{});

    //本当にユニオンを渡すだけでいいのだろうか？
    printInsect(???);
    printInsect(???);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (???) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

// ところで、unionはオプショナル値とエラーについて思い出させてくれたでしょうか？
// オプショナル値は基本的に「ヌルユニオン」で、エラーは
// 「エラーユニオン型」です。あとは独自のユニオンを追加して、
// 遭遇しそうな状況に対応することができます。
//          union(Tag) { value: u32, toxic_ooze: void }
