//
// Zig型の強制適用を学ぶには、ほんの少し時間がかかります。
// ルールは非常に論理的だからです。
//
// 1. 型は常に「より」制限的にすることができる。
//
//    var foo: u8 = 5;
//    var p1: *u8 = &foo;
//    var p2: *const u8 = p1; // ミュータブルからイミュータブルへ
//
// 2. 数値型はより「大きな」型に変換することができる
//
//    var n1: u8 = 5;
//    var n2: u16 = n1; // integer "widening"
//
//    var n3: f16 = 42.0;
//    var n4: f32 = n3; // float "widening"
//
// 3. 配列への単一項目ポインタは、スライスと多項目ポインタに変換される。
// 
//
//    const arr: [3]u8 = [3]u8{5, 6, 7};
//    const s: []const u8 = &arr;  // to slice
//    const p: [*]const u8 = &arr; // to many-item pointer
//
// 4. 単項目ポインタは、長さ1の配列を指す単項目ポインタに変換することができます。
// 
//
//    var five: u8 = 5;
//    var a_five: *[1]u8 = &five;
//
// 5. ペイロード型と NULL強制をオプショナルに 
//
//    var num: u8 = 5;
//    var maybe_num: ?u8 = num; // payload type
//    maybe_num = null;         // null
//
// 6. ペイロード型とエラーは、エラーユニオンに強制される。
//
//    const MyError = error{Argh};
//    var char: u8 = 'x';
//    var char_or_die: MyError!u8 = char; // payload type
//    char_or_die = MyError.Argh;         // error
//
// 7. 'undefined' は任意の型に強制される (そうでなければ動作しない!)。
//
// 8. コンパイル時の数値は互換性のある型に強制される。
//
// しかし、完全で適切な説明は、
// 第三の目を開くテーマである comptime で近々行われる予定です。
// 
//
// 9. タグ付きユニオンは、現在のタグ付き列挙型を強制する 
//
// 10. 列挙型は、タグ付きフィールドが (void のような) 値を 1 つだけ持つ長さゼロの型である場合、
// 　　列挙型はタグ付きユニオンになる。
//
// 11. ゼロビット型（voidなど）は1項目ポインタに強制することができる。
// 
//
// 最後の3つはかなり難解ですが、詳しくはZig言語の公式ドキュメントを読んで、
// 自分で実験してみるといいでしょう。
// 

const print = @import("std").debug.print;

pub fn main() void {
    var letter: u8 = 'A';

    const my_letter:   ???   = &letter;
    //               ^^^^^^^
    //        ここにあなたの型があります。
    // &letter (これは *u8) から強制されなければなりません。
    // ヒント：強制ルール4と5を使用する。

    // 正解の場合、これは動作します。
    print("Letter: {u}\n", .{my_letter.?.*[0]});
}
