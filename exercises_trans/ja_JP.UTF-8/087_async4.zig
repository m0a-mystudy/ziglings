//
// 'async' キーワードは代わりにフレームを返すので、
// foo() からの戻り値をもはやキャプチャしていないことに、
// おそらく皆さんは気づかないことはないでしょう。
//
// これを解決する一つの方法は、グローバル変数を使用することです。
//
// このプログラムで "1 2 3 4 5" と表示させることができるかどうか見てみましょう。
//
const print = @import("std").debug.print;

var global_counter: i32 = 0;

pub fn main() void {
    var foo_frame = async foo();

    while (global_counter <= 5) {
        print("{} ", .{global_counter});
        ???
    }

    print("\n", .{});
}

fn foo() void {
    while (true) {
        ???
        ???
    }
}
