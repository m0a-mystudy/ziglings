//
// あるコードブロックが終了した後に実行されるコードを割り当てるには、 
// "defer "ステートメントを使用してそれを遅延させることができます。
//
//     {
//         defer runLater();
//         runNow();
//     }
//
// 上の例では、runLater() はブロック ({...}) が終了したときに実行されます。
// つまり、上のコードは以下の順番で実行されることになります
//
//     runNow();
//     runLater();
//
// この機能は最初は奇妙に思えますが、次の演習でそれがどのように役立つかを
// 見てみましょう。
const std = @import("std");

pub fn main() void {
    // 他に何も変更せずに、'defer' ステートメントをコードに追加して、
    // プログラムが "One Two\n" を出力するようにしてください。
    std.debug.print("Two\n", .{});
    std.debug.print("One ", .{});
}
