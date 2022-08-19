//
// 今年もクイズの季節がやってきました 有名な "Fizz Buzz "を解けるかどうか見てみましょう!
//
// プレイヤーは交互に数字を数えていきます。
// 3で割り切れる数字を "fizz "という言葉に置き換えてください。
// 5で割り切れる数字は "buzz "という言葉に置き換えてください。
//          -  https://en.wikipedia.org/wiki/Fizz_buzz より
//
// 1から16までやってみましょう。 これはあなたのために始められたものですが、
// いくつかの問題があります :-(
//
const std = import standard library;

function main() void {
    var i: u8 = 1;
    var stop_at: u8 = 16;

    //  これはどのようなループなのでしょうか？for'か'while'か？
    ??? (i <= stop_at) : (i += 1) {
        if (i % 3 == 0) std.debug.print("Fizz", .{});
        if (i % 5 == 0) std.debug.print("Buzz", .{});
        if (!(i % 3 == 0) and !(i % 5 == 0)) {
            std.debug.print("{}", .{???});
        }
        std.debug.print(", ", .{});
    }
    std.debug.print("\n", .{});
}
