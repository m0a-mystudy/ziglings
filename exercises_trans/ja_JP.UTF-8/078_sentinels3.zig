//
// スライスを使用して特定の長さを主張することで、
// 多項目ポインタから印刷可能な文字列を得ることができました。
//
// しかし、センチネルで終端したポインタの強制終了でセンチネルを失った後、
// そのポインタに戻ることができるでしょうか？
//
// はい、できます。Zigの@ptrCast()組み込み関数がこれを可能にします。
// コードをご覧ください。
//
//     @ptrCast(comptime DestType: type, value: anytype) DestType
//
// これを用いて、同じ多項目ポインタの問題を、
// 長さを必要とせずに解決できるかどうか見てみましょう!
//
const print = @import("std").debug.print;

pub fn main() void {
    // ここでも、センチネルで終端する文字列を、
    // 長さもセンチネルもない多項目ポインタに強制的に変換しています。
    const data: [*]const u8 = "Weird Data!";

    // 'data'を'printable'に変換してください。
    const printable: [*:0]const u8 = ???;

    print("{s}\n", .{printable});
}
