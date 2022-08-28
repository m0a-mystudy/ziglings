//
// これまでに学んだことを活かせるかどうか見てみましょう。
// 1つは "for "ループを含む関数、もう1つは 
// "while "ループを含む関数を作成します。
//
// 両方とも、以下では単に「loop」と表記しています。
//
const std = @import("std");

pub fn main() void {
    const my_numbers = [4]u16{ 5, 6, 7, 8 };

    printPowersOfTwo(my_numbers);
    std.debug.print("\n", .{});
}

// こんなの滅多にないでしょう: 
// ちょうど 4 つの u16 の数値からなる配列を受け取る関数です。これは通常、関数に配列を渡す方法ではありません。
// スライスとポインタについては、
// もう少し後で勉強しましょう。今のところ、私たちが知っていることを使っています。
//
// この関数は表示されますが、何も返しません。
//
fn printPowersOfTwo(numbers: [4]u16) ??? {
    loop (numbers) |n| {
        std.debug.print("{} ", .{twoToThe(n)});
    }
}

// この関数は、前回の演習の twoToThe() に酷似しています。
// しかし、騙されないでください! この関数は標準ライブラリの助けを借りずに
// 計算を行います。
//
fn twoToThe(number: u16) ??? {
    var n: u16 = 0;
    var total: u16 = 1;

    loop (n < number) : (n += 1) {
        total *= 2;
    }

    return ???;
}
