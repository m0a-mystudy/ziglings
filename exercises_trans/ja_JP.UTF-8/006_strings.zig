//
// 配列について学んだので、文字列について話しましょう。
//
// Zig文字列リテラル「"Hello world.\n"」をすでに見たと思います
//
// Zigは文字列をバイトの配列として格納します。
//
//     const foo = "Hello";
//
// 上記は以下とほぼ同じです。
//
//     const foo = [_]u8{ 'H', 'e', 'l', 'l', 'o' };
//
// (* Zigの文字列が実際にどのようなものであるかは、Exercise 77 で確認します。)
//
// 個々の文字がシングルクォート('H')を使用し、
// 文字列がダブルクォート("H")を使用することに注意してください。これらは互換性がありません!
//
const std = @import("std");

pub fn main() void {
    const ziggy = "stardust";

    // (問題 1)
    // 配列の角括弧構文を使って、上の文字列 "stardust" から文字 'd' を取得してください。
    //
    const d: u8 = ziggy[???];

    // (問題 2)
    // 配列の繰り返し'**' 演算子を使って、"ha ha ha " を作ってください。
    const laugh = "ha " ???;

    // (問題 3)
    // 配列の連結 '++' 演算子を使用して "Major Tom"を作成してください。
    // (スペースも必要です!)
    const major = "Major";
    const tom = "Tom";
    const major_tom = major ??? tom;

    // 問題は以上です。結果を見てみましょう。
    std.debug.print("d={u} {s}{s}\n", .{ d, laugh, major_tom });
    // よく見ると、上のフォーマット文字列の プレースホルダー'{}' の中に 'u' と 's'
    // を入れていることに気づいたでしょうか？。これは
    // print() 関数に、値をそれぞれ UTF-8「文字」とUTF-8「文字列」としてフォーマットするよう 
    // 命令します。もしこれを行わなければ、'100'と表示されるでしょう。
    // '100'は UTF-8 の 'd' 文字に対応する 10 進数です。
    // (文字列の場合はエラーとなります）。
    //
    // この話題のついでに、'c' (ASCII エンコードされた文字) も 
    // 'u' の代わりに使えます。これはUTF-8 の最初の 128 文字は
    // ASCII と同じだからです。
    //
}
