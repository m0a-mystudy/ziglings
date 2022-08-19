//
// 信じられないかもしれませんが、プログラムではうまくいかないことがあります。
//
// Zigでは、エラーが値として扱われます。エラーにはうまくいかないことを特定できるように
// 名前がついています、エラーは「エラーセット」で作成されます。
// これは名前の付いたエラーの単なるコレクションです。
//
// エラーセットの開始点はりますが、条件に
// "TooSmall "がありません。必要なところに追加してください!
const MyNumberError = error{
    TooBig,
    ???,
    TooFour,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |n| {
        std.debug.print("{}", .{n});

        const number_error = numberFail(n);

        if (number_error == MyNumberError.TooBig) {
            std.debug.print(">4. ", .{});
        }
        if (???) {
            std.debug.print("<4. ", .{});
        }
        if (number_error == MyNumberError.TooFour) {
            std.debug.print("=4. ", .{});
        }
    }

    std.debug.print("\n", .{});
}

// この関数が MyNumberError の任意のメンバを返すことができることに注意してください。
// エラーセットの任意のメンバーを返すことができることに注意してください。
fn numberFail(n: u8) MyNumberError {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall; // <---- こちらは自由です!(訳注:意味わかってないです)
    return MyNumberError.TooFour;
}
