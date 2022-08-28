//
// ------------------------------------------------------------
//  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET
// ------------------------------------------------------------
//
// Zig文字列リテラルについての真実を知る準備は？
//
//ここにあります。
//
//     @TypeOf("foo") == *const [3:0]u8
//
// つまり、文字列リテラルは
// 「u8のゼロ終端（ヌル終端）固定サイズ配列への定数ポインタ」である。
//
// これでわかっただろう。あなたはそれを獲得したのです。秘密クラブへようこそ!
//
// ------------------------------------------------------------
//
// すでに長さがわかっているのに、なぜわざわざ Zig で文字列を終了するために
// ゼロ/ヌルセンチネルを使うのでしょうか？
//
// 汎用性があるからです! Zigの文字列は、C言語の文字列（ヌル終端）と互換性があり、
// また、他の様々な文字列に強制変換することができます。
// Zig型に強制することができます。
//
//     const a: [5]u8 = "array".*;
//     const b: *const [16]u8 = "pointer to array";
//     const c: []const u8 = "slice";
//     const d: [:0]const u8 = "slice with sentinel";
//     const e: [*:0]const u8 = "many-item pointer with sentinel";
//     const f: [*]const u8 = "many-item pointer";
//
// 'f' 以外は表示してもよい。
// (センチネルのない多項目ポインタは、どこで終わるか分からないので、印刷しても安全ではありません!)
//
//
const print = @import("std").debug.print;

const WeirdContainer = struct {
    data: [*]const u8,
    length: usize,
};

pub fn main() void {
    // WeirdContainer は文字列を格納するための厄介な方法です。
    //
    // 多項目ポインタ（センチネル終端なし）であるため、
    // 「data」フィールドは長さ情報と文字列リテラル「Weird Data！」の
    // センチネル終端を「失います」。
    //
    // 幸運にも、'length' フィールドによってこの値をまだ扱うことが可能です。
    //
    const foo = WeirdContainer{
        .data = "Weird Data!",
        .length = 11,
    };

    // どのようにして 'foo' から印字可能な値を得るのでしょうか？一つの方法は、
    // 長さがわかっているものに変えることです。
    // 実際に 長さ... 実はこの問題、前に解決したことがあるんです!
    //
    // ここで大きなヒントがあります：スライスの取り方を覚えていますか？
    const printable = ???;

    print("{s}\n", .{printable});
}
