//
// エラーユニオンに対処する一つの方法として、あらゆるエラーを「キャッチ」し
// デフォルト値に置き換えることです。
//
//     foo = canFail() catch 6;
//
// canFail() が失敗した場合、foo は 6 になる。
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    var a: u32 = addTwenty(44) catch 22;
    var b: u32 = addTwenty(4) ??? 22;

    std.debug.print("a={}, b={}\n", .{ a, b });
}

// この関数の戻り値の型を提示してください。
// ヒント：エラーユニオンになります。
fn addTwenty(n: u32) ??? {
    if (n < 5) {
        return MyNumberError.TooSmall;
    } else {
        return n + 20;
    }
}
