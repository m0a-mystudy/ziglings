//
// 値をグループ化することができるので、これを変えてみましょう。
//
//     point1_x = 3;
//     point1_y = 16;
//     point1_z = 27;
//     point2_x = 7;
//     point2_y = 13;
//     point2_z = 34;
//
// 上記は以下にできます。
//
//     point1 = Point{ .x=3, .y=16, .z=27 };
//     point2 = Point{ .x=7, .y=13, .z=34 };
//
// 上のPointは「struct」（「構造体」の略）の一例です。
// そのstruct型の定義方法は以下の通りです。
//
//     const Point = struct{ x: u32, y: u32, z: u32 };
//
// 構造体に、ロールプレイングキャラクターを格納しましょう。
//
const std = @import("std");

//キャラクタクラスを指定するためにenumを使用することにします。
const Class = enum {
    wizard,
    thief,
    bard,
    warrior,
};

// この構造体に "health "という新しいプロパティを追加し、
// u8整数型にしてください。
const Character = struct {
    class: Class,
    gold: u32,
    experience: u32,
};

pub fn main() void {
    // Glorpの体力を100に初期化してください。
    var glorp_the_wise = Character{
        .class = Class.wizard,
        .gold = 20,
        .experience = 10,
    };

    // Glorpがゴールドを獲得。
    glorp_the_wise.gold += 5;

    // 痛っ! Glorpがパンチを食らった!
    glorp_the_wise.health -= 10;

    std.debug.print("Your wizard has {} health and {} gold.\n", .{
        glorp_the_wise.health,
        glorp_the_wise.gold,
    });
}
