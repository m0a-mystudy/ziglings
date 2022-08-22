//
// 'suspend'にはこのようなブロック式が必要なことに
// お気づきでしょうか。
//
//     suspend {}
//
// サスペンドブロックは関数がサスペンドするときに実行されます。
// どんなときにサスペンドされるかを知るために、
// 次の文字列を表示するプログラムを作ってみてください。
//
//     "ABCDEF"
//
const print = @import("std").debug.print;

pub fn main() void {
    print("A", .{});

    var frame = async suspendable();

    print("X", .{});

    resume frame;

    print("F", .{});
}

fn suspendable() void {
    print("X", .{});

    suspend {
        print("X", .{});
    }

    print("X", .{});
}
