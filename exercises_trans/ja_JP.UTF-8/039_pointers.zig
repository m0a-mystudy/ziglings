//
// これを見てください。
//
//     var foo: u8 = 5;      // foo は 5 です。
//     var bar: *u8 = &foo;  // bar はポインタです。
//
// ポインタとは何でしょうか？ある値への参照です。この例では
// bar は、現在値 5 が格納されているメモリ空間への参照です。
// 
//
// 上記の宣言が与えられた場合のチートシート。
//
//     u8         u8 値の型
//     foo        値 5
//     *u8        u8 値へのポインタの型
//     &foo       foo への参照
//     bar        foo の値へのポインタ
//     bar.*      値 5 (参照先 bar の値)
//
// ポインタがなぜ便利なのかは、すぐにわかります。とりあえず、この例がうまくいくかどうか見てみましょう。
// 
//
const std = @import("std");

pub fn main() void {
    var num1: u8 = 5;
    var num1_pointer: *u8 = &num1;

    var num2: u8 = undefined;

    // num1_pointer を使って、num2 が 5 になるようにしてください!
    // (アイデアについては、上記の "チートシート" を参照してください。)
    num2 = ???;

    std.debug.print("num1: {}, num2: {}\n", .{ num1, num2 });
}
