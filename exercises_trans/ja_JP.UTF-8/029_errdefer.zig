//
// もう一つのよくある問題は、エラーによって複数の場所で終了する可能性があるコードブロックです。
// しかし、終了する前に何かをする必要があります。
// （通常は後始末をするため）。
//
// 「errdefer」は、ブロックがエラーで終了した場合にのみ実行されるdefferです。
//
//     {
//         errdefer cleanup();
//         try canFail();
//     }
//
// cleanup() 関数は、try 文が canFail() で生成されたエラーを返した場合のみ呼び出される。
// 
//
const std = @import("std");

var counter: u32 = 0;

const MyErr = error{ GetFail, IncFail };

pub fn main() void {
    // 数字が取れなければ、プログラム全体を終了するだけです。
    var a: u32 = makeNumber() catch return;
    var b: u32 = makeNumber() catch return;

    std.debug.print("Numbers: {}, {}\n", .{ a, b });
}

fn makeNumber() MyErr!u32 {
    std.debug.print("Getting number...", .{});

    // makeNumber()がエラーで終了した場合のみ、"failed "メッセージを表示するようにしてください。
    // 
    std.debug.print("failed!\n", .{});

    var num = try getNumber(); // <-- これは失敗するかも！？

    num = try increaseNumber(num); // <-- これは絶対に失敗します。

    std.debug.print("got {}. ", .{num});

    return num;
}

fn getNumber() MyErr!u32 {
    // 失敗する可能性がある...でも、失敗しない!
    return 4;
}

fn increaseNumber(n: u32) MyErr!u32 {
    // 初めて走らされた後、失敗した！？
    if (counter > 0) return MyErr.IncFail;

    // こっそりと、グローバルな変数をいじっている
    counter += 1;

    return n + 1;
}
