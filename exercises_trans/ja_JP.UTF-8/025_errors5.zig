//
// Zig には、この一般的なエラー処理パターンに対する便利な「try」ショートカットがあります。
//
//     canFail() catch |err| return err;
//
// 上記はよりコンパクトに次のように書くことができます。
//
//     try canFail();
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    var a: u32 = addFive(44) catch 0;
    var b: u32 = addFive(14) catch 0;
    var c: u32 = addFive(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

fn addFive(n: u32) MyNumberError!u32 {
    // この関数は、detect()から返ってくるかもしれないあらゆるエラーを返す必要がある。
    // "catch "ではなく、"try "ステートメントを使用してください。
    //
    var x = detect(n);

    return x + 5;
}

fn detect(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
