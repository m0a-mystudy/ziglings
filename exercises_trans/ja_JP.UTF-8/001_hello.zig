//
// このプログラムは "Hello world!"を表示するものです。
// あなたの助けが必要です!
//
//
// Zig 関数はデフォルトで private ですが、main() 関数は public であるべきです。
// publicにする必要があります。
//
// 関数のpublic化は、"pub "ステートメントで以下のように宣言します。
//
// pub fn foo() void {...
// ...
// }
//
// プログラムを修正して `ziglings` を実行し、動作するかどうか試してみてください!
//
const std = @import("std");

fn main() void {
    std.debug.print("Hello world!\n", .{});
}
