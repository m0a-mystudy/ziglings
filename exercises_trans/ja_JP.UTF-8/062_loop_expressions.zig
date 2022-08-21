//
// if/else文をこのような式として使用したことを覚えていますか？
//
//     var foo: u8 = if (true) 5 else 0;
//
// Zig では、for や while ループも式として使用できます。
//
// 関数の 'return' のように、
// break を使ってループブロックから値を返すことができる。
//
//     break true; // ブロックからブール値を返す
//
// しかし、break 文に到達しない場合、ループからどのような値が返されるのでしょうか？
// デフォルトの式が必要だ。
// ありがたいことに、Zigループには「else」句があります。ご想像の通り、
// 'else'節は次のような場合に評価されます。1) 'while' 条件が偽になったとき、
// 2) 'for' ループがアイテムを使い果たしたとき。
//
//     const two: u8 = while (true) break 2 else 0;         // 2
//     const three: u8 = for ([1]u8{1}) |f| break 3 else 0; // 3
//
// else 節を指定しないと、空の else 節が指定され、
// それは void 型に評価されますが、それはおそらくあなたが望むものではありません。
// そのため、ループを式として使用する際にはelse節は必須であると考えましょう。
//
//
//     const four: u8 = while (true) {
//         break 4;
//     };               // <-- エラー! ここに暗黙の'else void'がある!
//
// このことを踏まえて、このプログラムで問題を解決できるかどうか
// 見てみましょう。
//
const print = @import("std").debug.print;

pub fn main() void {
    const langs: [6][]const u8 = .{
        "Erlang",
        "Algol",
        "C",
        "OCaml",
        "Zig",
        "Prolog",
    };

    // 3文字の名前を持つ最初の言語を見つけて 
    // それをforループから返します。
    const current_lang: ?[]const u8 = for (langs) |lang| {
        if (lang.len == 3) break lang;
    };

    if (current_lang) |cl| {
        print("Current language: {s}\n", .{cl});
    } else {
        print("Did not find a three-letter language name. :-(\n", .{});
    }
}
