//
// それでは、パラメータを受け取る関数を作ってみましょう。以下は
// 2つのパラメータを受け取る例です。見ての通り、パラメータは
// 他の型（"name": "type"）と同じように宣言されています。
//
//     fn myFunction(number: u8, is_lucky: bool) {
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    std.debug.print("Powers of two: {} {} {} {}\n", .{
        twoToThe(1),
        twoToThe(2),
        twoToThe(3),
        twoToThe(4),
    });
}

// この関数に正しい入力パラメータ（複数可）を与えてください。
// 我々が期待するパラメータ名と型を把握する必要があります。
// 我々が期待しているパラメータ名と型を把握する必要があります。出力タイプはすでに指定されています。
//
fn twoToThe(???) u32 {
    return std.math.pow(u32, 2, my_number);
    // std.math.pow(type, a, b) は，数値型と 2 つの数値を受け取ります．
    // その型の数値（またはその型を強制することができる数値）を受け取り
    // "aのb乗"を同じ数値型として返します。
}
