//
// よくあるエラーのケースは、次のような状況です。
// 値がある、または何かが間違っている場合です。この例を見てみましょう。
//
//     var text: Text = getText("foo.txt");
//
// getText() が "foo.txt" を見つけられなかった場合はどうなるのでしょうか？ 
// Zig ではどのように表現するのでしょうか？
//
// Zig では、「エラーユニオン」と呼ばれるものを作成することができます。
// 以下は、通常の値であるか、セットからのエラーであるかのどちらかを示します。
//
//     var text: MyErrorSet!Text = getText("foo.txt");
//
// とりあえず、エラーユニオンを作れるかどうか試してみましょう!
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    var my_number: ??? = 5;

    // my_number は数字を格納する必要があるようです。
    // エラーになります。上で正しく型を設定できますか？
    my_number = MyNumberError.TooSmall;

    std.debug.print("I compiled!\n", .{});
}
