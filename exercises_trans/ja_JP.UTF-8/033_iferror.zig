//
// 一番最初のエラー演習を再確認してみましょう。今回は
// 今回は、"if "ステートメントのエラー処理のバリエーションを見てみましょう。
//
//     if (foo) |value| {
//
//         // foo はエラーでない; value は foo のエラーでない値
//
//     } else |err| {
//
//         // fooはエラー; errはfooのエラー値
//
//     }
//
// さらに進めて、switch文で処理することにします。
// エラーの種類を指定します。
//
//     if (foo) |value| {
//         ...
//     } else |err| switch(err) {
//         ...
//     }
//
const MyNumberError = error{
    TooBig,
    TooSmall,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |num| {
        std.debug.print("{}", .{num});

        const n = numberMaybeFail(num);
        if (n) |value| {
            std.debug.print("={}. ", .{value});
        } else |err| switch (err) {
            MyNumberError.TooBig => std.debug.print(">4. ", .{}),
            // ここにTooSmallのマッチングを追加し、"<4. "を印刷されるようにしてください。
        }
    }

    std.debug.print("\n", .{});
}

// 今回は、numberMaybeFail() がストレートなエラーではなく、エラーユニオンを返すようにします。
// 直接のエラーではなく、エラーユニオンを返すようにします。
fn numberMaybeFail(n: u8) MyNumberError!u8 {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall;
    return n;
}
