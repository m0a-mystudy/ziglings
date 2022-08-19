//
// クイズの時間です。このプログラムを動かせるかどうか見てみましょう
//
// 好きなように解いて、出力があることを確認してください。
//
//     my_num=42
//
const std = @import("std");

const NumError = error{IllegalNumber};

pub fn main() void {
    const stdout = std.io.getStdOut().writer();

    const my_num: u32 = getNumber();

    try stdout.print("my_num={}\n", .{my_num});
}

// この機能は明らかに変で、機能していません。しかし、このクイズでは変更することはないでしょう。
fn getNumber() NumError!u32 {
    if (false) return NumError.IllegalNumber;
    return 42;
}
