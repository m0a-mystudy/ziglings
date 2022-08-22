//
// 何らかの理由で命名規則に従わない識別子を作成する必要がある場合があります。
//
//
//     const 55_cows: i32 = 55; // ILLEGAL: 数字から始まる。
//     const isn't true: bool = false; // ILLEGAL: 何が真なんだ!
//
// 通常の状況でこれらのいずれかを作成しようとすると、
// 特別なプログラム識別子構文セキュリティチーム（PISST）が
// あなたの家に来てあなたを連れ去るでしょう。
//
// ありがたいことに、Zigはこれらの奇妙な識別子を当局の目を逃れてこっそり
// 使う方法を知っています：@"" 識別子の引用構文です。
//
//     @"foo"
//
// この逃亡中の識別子を私たちのプログラムに安全に密輸するのを助けてください。
//
//
const print = @import("std").debug.print;

pub fn main() void {
    const 55_cows: i32 = 55;
    const isn't true: bool = false;

    print("Sweet freedom: {}, {}.\n", .{
        55_cows,
        isn't true,
    });
}
