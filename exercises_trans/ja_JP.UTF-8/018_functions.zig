//
// 関数! すでに 'main()' と呼ばれる関数をたくさん作りました。では
// 違うことをしてみましょう。
//
//     fn foo(n: u8) u8 {
//         return n + 1;
//     }
//
// 上の foo() 関数は、数値 'n' を受け取り、それを 1 つ大きくした数値を返します。
// 
//
// 入力パラメータ 'n' と戻り値の型は共に u8 であることに注意。
//
const std = @import("std");

pub fn main() void {
    // 新しい関数 deepThought() は、42 という数字を返すはずです。以下を参照してください。
    const answer: u8 = deepThought();

    std.debug.print("Answer to the Ultimate Question: {}\n", .{answer});
}

// 以下、deepThought()関数を定義してください。
//
// いくつか足りないものがあります。不足していないものの1つは
// キーワード "pub" はここでは必要ありません。なぜかわかりますか？
//
??? deepThought() ??? {
    return 42; //  番号提供：ダグラス・アダムス
}
