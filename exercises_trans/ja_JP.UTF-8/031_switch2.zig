//
// とても素晴らしいのは、switch 文を、値を返す式として使えることです。
// 
//
//     var a = switch (x) {
//         1 => 9,
//         2 => 16,
//         3 => 7,
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        const real_char: u8 = switch (c) {
            1 => 'A',
            2 => 'B',
            3 => 'C',
            4 => 'D',
            5 => 'E',
            6 => 'F',
            7 => 'G',
            8 => 'H',
            9 => 'I',
            10 => 'J',
            // ...
            25 => 'Y',
            26 => 'Z',
            // 前回の演習と同様に、'else' 節を追加してください。
            // そして今回は、感嘆符 '!' を返すようにしてください。
        };

        std.debug.print("{c}", .{real_char});
        // 注意: "{c}" は print() に値を文字として表示するように強制します。
        // "c "を取り除くとどうなるか分かりますか？試してみてください。
    }

    std.debug.print("\n", .{});
}
