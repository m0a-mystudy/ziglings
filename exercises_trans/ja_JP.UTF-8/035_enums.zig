//
// "unreachable "ステートメントを使って作った小さな数学的バーチャルマシンを覚えていますか？
// その時、オペコードの使い方には2つの問題がありました。
// 
//
//   1. オペコードを番号で覚えるのは良くない。
//   2. Zigは有効なopコードの数を知る術がないので、unreachableを使わざるを得なかった。
// 
//
// 「enum(列挙型)」はZigの構成要素の一つで、数値に名前を付けてセットで保存することができる、
//  Zig の構成要素です。これはエラーセットとよく似ています。
//
//     const Fruit = enum{ apple, pear, orange };
//
//     const my_fruit = Fruit.apple;
//
// 前バージョンで使っていた数値の代わりに enum を使ってみましょう!
// 
//
const std = @import("std");

// enumを完成させてください!
const Ops = enum { ??? };

pub fn main() void {
    const operations = [_]Ops{
        Ops.inc,
        Ops.inc,
        Ops.inc,
        Ops.pow,
        Ops.dec,
        Ops.dec,
    };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            Ops.inc => {
                current_value += 1;
            },
            Ops.dec => {
                current_value -= 1;
            },
            Ops.pow => {
                current_value *= current_value;
            },
            // "else"は必要ない! なぜなんでしょう？
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
