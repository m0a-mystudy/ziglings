//
//    "私たちは無知の島に住んでいる。
//     無限の海の中にある 無知の島に住んでいるのだ
//     遠くへ旅立つべきでない"
//
//     クトゥルフの呼び声より
//       H.P.ラヴクラフト著
//
// Zigには「値がない」という表現が少なくとも4つある。
//
// * undefined(未定義)
//
//       var foo: u8 = undefined;
//
//       "undefined "は値として考えるべきではない。
//       コンパイラに値を「まだ」代入していないことを伝える方法である。
//       どのような型でも未定義に設定することができるが、
//       その値を読み取ったり使用したりしようとすることは「常に」間違いである。
//
// * null
//
//       var foo: ?u8 = null;
//
//       nullは「値がない」ことを意味するプリミティブな値である。
//       これは通常、上述した ?u8 と同様オプショナルな型に使われる
//       fooがnullに等しいとき、それはu8型の値ではない
//       これは、foo の中に u8 型の値がまったく存在しないことを意味する。
//
// * error
//
//       var foo: MyError!u8 = BadError;
//
//       エラーはnullと「非常によく」似ている。それらは値であるが
//       探していた「本当の値」が存在しないことを示す。
//       その代わりに、エラーを保持している。この例では
//       エラーユニオン型である MyError!u8 は、foo が u8 の値か、
//       エラーかのどちらかを保持していることを意味する。
//       エラーに設定されているとき、foo には u8 型の値は存在しない。
//
// * void
//
//       var foo: void = {};
//
//       "void "は値ではなく 「型」 である。これは、最も一般的な
//       ゼロビット型（全くスペースを取らず、意味的な値のみを持つ型）の中で最もよく知られている。
//       実行可能なコードにコンパイルされたとき、
//       ゼロビット型はまったくコードを生成しない。上の例では
//       void 型の変数 foo には，空の式が代入されている。
//       void 型は何も返さない関数の戻り値の型として見るのがもっとも一般的である。
//       
//
// Zig では、このようにさまざまなタイプの「値がない」ことを表現する方法がある。
// なぜなら、それぞれに目的があるからである。簡単に説明すると
//
//   * undefined - 値がない、まだ読めない。
//   * null      - "値なし "という明示的な値が存在する。
//   * errors    - 何か問題が発生したため、値が存在しない。
//   * void      - ここに値が格納されることは決してない。
//
// このプログラムを作るために、それぞれの "no value "に正しい値を使用しよう。
// このコードはネクロノミコンからの呪いの引用をプリントアウトします。...あえて言うなら
//
const std = @import("std");

const Err = error{Cthulhu};

pub fn main() void {
    var first_line1: *const [16]u8 = ???;
    first_line1 = "That is not dead";

    var first_line2: Err!*const [21]u8 = ???;
    first_line2 = "which can eternal lie";

    // エラーユニオンの文字列には、"{!s}"のフォーマットが必要であることに注意してください。
    std.debug.print("{s} {!s} / ", .{ first_line1, first_line2 });

    printSecondLine();
}

fn printSecondLine() ??? {
    var second_line2: ?*const [18]u8 = ???;
    second_line2 = "even death may die";

    std.debug.print("And with strange aeons {s}.\n", .{second_line2.?});
}
