//
// 最後の2つのエクササイズは、機能的に同じものでした。Continue
// 式は、「continue文」 と一緒に使うと、その有用性を発揮します。
// 
//
// 例:
//
//     while (条件) : (continue式) {
//
//         if (他の条件) continue; // <--これがcontinue文
//
//     }
//
// 「continue 式」は、ループが再スタートするたびに実行され
// 「continue 文」が発生してもしなくても実行されます
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // 1 から 20 までの数字で、3 または 5 で割り切れないものをすべて表示したい。
    // 
    while (n <= 20) : (n += 1) {
        // '%' 記号は「モジュロ」演算子で、除算後の余りを返す。
        // 
        if (n % 3 == 0) ???;
        if (n % 5 == 0) ???;
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}
