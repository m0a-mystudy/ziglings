//
// Zigコンパイラは「ビルトイン」関数を提供します。
// Ziglingsのエクササイズの先頭にある@import()はもう見慣れましたね。
//
//
// 016_for2.zig" や "058_quiz7.zig" では @intCast() も見かけました。
// "036_enums2.zig "では@enumToInt()を見ています。
//
// ビルトインは（標準ライブラリで提供されるのではなく）
// Zig言語自体に内在するものなので、特別なものです。
// また、型イントロスペクション（プログラムの中から型のプロパティを調べる機能）
// のように、コンパイラの助けがなければ実現できない機能を提供できるのも
// 特別な点です。
//
//
// Zig には現在 101 の組み込み関数があります。
// そのすべてを網羅するつもりはありませんが、
// 興味深いものをいくつか見てみましょう。
//
// 始める前に、多くの組み込み関数が "comptime"とマークされたパラメータを
// 持っていることを知っておいてください。これらのパラメータが
// 「コンパイル時に既知である」必要があると言ったとき、私たちが何を意味しているかは、
// おそらくかなり明確でしょう。しかし、我々はすぐに "comptime "について
// 本当の正義を行うので、安心してください。
//
const print = @import("std").debug.print;

pub fn main() void {
    //  最初の組み込みは、アルファベット順です。
    //
    //   @addWithOverflow(comptime T: type, a: T, b: T, result: *T) bool
    //     * 'T' は他のパラメータの型になります。
    //     * 'a' と 'b' は T 型の数値である。
    //     *  'result' は、提供する空間へのポインタであり、T型である。
    //     * 返り値は、加算の結果、型Tの容量を超える値
    //       または下回る値が得られた場合に真となる。
    //
    //わかりやすくするために、小さな4ビット整数のサイズで試してみよう。
    const a: u4 = 0b1101;
    const b: u4 = 0b0101;
    var my_result: u4 = undefined;
    var overflowed: bool = undefined;
    overflowed = @addWithOverflow(u4, a, b, &my_result);

    // おしゃれなフォーマットを見てみましょう！ b:0>4 は、
    // 「2進数で表示し、ゼロパッドで右寄せにした4桁を表示する」という意味です。
    // 以下の print() は、次のように出力します。"1101 + 0101 = 0010 (true)"
    print("{b:0>4} + {b:0>4} = {b:0>4} ({})", .{ a, b, my_result, overflowed });

    // この答えに意味を持たせてみましょう。b'の10進数での値は5です。
    // 'a'に5を足してみますが、1つずつ行ってどこでオーバーフローするか見てみましょう。
    //
    //   a  |  b   | result | overflowed?
    // ----------------------------------
    // 1101 + 0001 =  1110  | false
    // 1110 + 0001 =  1111  | false
    // 1111 + 0001 =  0000  | true  (本当の答えは10000です)
    // 0000 + 0001 =  0001  | false
    // 0001 + 0001 =  0010  | false
    //
    // 最後の2行では、3行目でオーバーフローがあったため'a'の値が壊れていますが、
    // 4行目と5行目の演算そのものはオーバーフローしていません。
    // 
    // 以下のような違いがあります。
    //  - ある時点でオーバーフローし、破損してしまった値
    //  - オーバーフローした1つの演算が、その後のエラーを引き起こす可能性がある。
    // 実際には、オーバーフローした値に最初に気づき、
    // オーバーフローを引き起こした操作までさかのぼって考えなければならない。
    //
    // aに5を足しても全くオーバーフローしなかった場合、'my_result'はどのような値を持つか？
    // その答えを 'expected_result' に書き込んでください。
    const expected_result: u8 = ???;
    print(". Without overflow: {b:0>8}. ", .{expected_result});

    print("Furthermore, ", .{});

    //  ここに楽しいものがあります。
    //
    //   @bitReverse(comptime T: type, integer: T) T
    //     * 'T' は入出力の型になります。
    //     * 'integer'は反転させる値です。
    //     * 返り値は、値のビットを反転した同じ型になる!
    //
    //
    // 次はあなたの番です。この組み込み関数を使って 
    // u8 整数のビットを反転させようとする試みを修正できるかどうか見てみましょう。
    const input: u8 = 0b11110000;
    const tupni: u8 = @bitReverse(input);
    print("{b:0>8} backwards is {b:0>8}.\n", .{ input, tupni });
}
