//
// 非同期 Zig 関数は中断と再開が可能なので、
// 「コルーチン」と呼ばれるより一般的なプログラミングの概念の
// 一例と言えます。Zigの非同期関数の優れた点の1つは、
// 中断と再開の際に状態を保持することです。
//
//
// このプログラムが "5 4 3 2 1" と表示されるかどうか見てみましょう。
//
const print = @import("std").debug.print;

pub fn main() void {
    const n = 5;
    var foo_frame = async foo(n);

    ???

    print("\n", .{});
}

fn foo(countdown: u32) void {
    var current = countdown;

    while (current > 0) {
        print("{} ", .{current});
        current -= 1;
        suspend {}
    }
}
