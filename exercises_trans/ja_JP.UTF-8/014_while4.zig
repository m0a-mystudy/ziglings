//
// "break "ステートメントでループを強制終了させることができる。
//
//     while (条件) : (continue式) {
//
//         if (他の条件) break;
//
//     }
//
// whileループがブレークして停止した場合、Continue式は「実行されません」。
// 
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // なんということでしょう! この while ループは永遠に続くのですか!
    // 以下の print 文が望ましい出力をするように、これを修正してください。
    while (true) : (n += 1) {
        if (???) ???;
    }

    // 結果：n=4 が欲しい
    std.debug.print("n={}\n", .{n});
}
