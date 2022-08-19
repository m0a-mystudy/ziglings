//
// トリッキーなのは、ポインタの変更可能性（var vs const）です。
// ポインタが指す先を変更できることであり、その場所の値を変更できることではありません。
// その場所の値を変更する能力ではありません。
//
//     const locked: u8 = 5;
//     var unlocked: u8 = 10;
//
//     const p1: *const u8 = &locked;
//     var   p2: *const u8 = &locked;
//
// p1、p2ともに、変更できない定数値を指しています。しかし
// p2は他のものを指すように変更でき、p1はできません!
//
//     const p3: *u8 = &unlocked;
//     var   p4: *u8 = &unlocked;
//     const p5: *const u8 = &unlocked;
//     var   p6: *const u8 = &unlocked;
//
// ここで、p3 と p4 はどちらも指す値を変更するために使うことができますが
// p3 はそれ以外を指すことはできません。
// 面白いのは、p5 と p6 は p1 と p2 のように動作するが、unlocked の値を指していることである。
// "unlocked "の値を指すことです。これは、任意の値への定数参照を作成できる
// と意味しています。
//
const std = @import("std");

pub fn main() void {
    var foo: u8 = 5;
    var bar: u8 = 10;

    // ポインタ "p" を定義して、foo または bar のどちらかを指すようにしてください。
    // bar のどちらかを指し、その指し示す値を変更できるようにポインタ "p" を定義してください!
    ??? p: ??? = undefined;

    p = &foo;
    p.* += 1;
    p = &bar;
    p.* += 1;
    std.debug.print("foo={}, bar={}\n", .{ foo, bar });
}
