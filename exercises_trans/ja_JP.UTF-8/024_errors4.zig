//
// エラーをデフォルト値に置き換えるために `catch` を使用することは、
// エラーが何であるかが重要ではないので、少し乱暴な手段です。
//
// catch を使用すると、エラー値をキャプチャして、このフォームで
// 追加のアクションを実行できます。
// 
//     canFail() catch |err| {
//         if (err == FishError.TunaMalfunction) {
//             ...
//         }
//     };
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    // 以下の「catch 0」は、makeJustRight()が返したエラーユニオンに対処するための
    // 一時的なハックです(今のところ)。
    var a: u32 = makeJustRight(44) catch 0;
    var b: u32 = makeJustRight(14) catch 0;
    var c: u32 = makeJustRight(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

// この愚かな例では、数を正しく作る責任を
// 4つの関数に分割しています。
//
//     makeJustRight()   fixTooBig() を呼び出し、エラーを修正することはできない。
//     fixTooBig()       fixTooSmall() を呼び出し、TooBigエラーを修正する。
//     fixTooSmall()     detectProblems() をコールし、小さすぎるエラーを修正する。
//     detectProblems()  数値またはエラーを返します。
//
fn makeJustRight(n: u32) MyNumberError!u32 {
    return fixTooBig(n) catch |err| {
        return err;
    };
}

fn fixTooBig(n: u32) MyNumberError!u32 {
    return fixTooSmall(n) catch |err| {
        if (err == MyNumberError.TooBig) {
            return 20;
        }

        return err;
    };
}

fn fixTooSmall(n: u32) MyNumberError!u32 {
    // やれやれ、これでは足りないですねぇ。でも心配しないでください、これはほとんど
    // 上の fixTooBig() と同じです。
    //
    // TooSmall エラーが発生したら、10 を返すようにします。
    // その他のエラーが発生した場合は、そのエラーを返します。
    // それ以外の場合は、u32 の数値を返します。
    return detectProblems(n) ???;
}

fn detectProblems(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
