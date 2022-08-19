//
// Zigには "unreachable "という文があります。この文は
// コンパイラに、あるコードの分岐は決して実行されるべきではなく
// 到達しただけでエラーになることをコンパイラに伝えたいときに使います。
//
//     if (true) {
//         ...
//     } else {
//         unreachable;
//     }
//
// ここでは、1つの数値に対して数学的な演算を行う小さな仮想マシンを作りました。
// 見た目は素晴らしいのですが、1つだけ小さな問題があります。
// switch 文は、u8 のすべての可能な値をカバーするわけではありません。
// 
//
// 私たちは3つの演算しかないことを知っているが、Zigは知らないのです
// unreachableステートメントを使用して、switchを完了させましょう
//
const std = @import("std");

pub fn main() void {
    const operations = [_]u8{ 1, 1, 1, 3, 2, 2 };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            1 => {
                current_value += 1;
            },
            2 => {
                current_value -= 1;
            },
            3 => {
                current_value *= current_value;
            },
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
