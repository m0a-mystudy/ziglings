//
// "switch "ステートメントを使用すると、ある式の取り得る値をマッチングさせ、それぞれに対して異なるアクションを実行することができます。
// 式にマッチし、それぞれに対して異なるアクションを実行します。
//
// このスイッチ
//
//     switch (players) {
//         1 => startOnePlayerGame(),
//         2 => startTwoPlayerGame(),
//         else => {
//             alert();
//             return GameError.TooManyPlayers;
//         }
//     }
//
// このif/elseと等価です。
//
//     if (players == 1) startOnePlayerGame();
//     else if (players == 2) startTwoPlayerGame();
//     else {
//         alert();
//         return GameError.TooManyPlayers;
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        switch (c) {
            1 => std.debug.print("A", .{}),
            2 => std.debug.print("B", .{}),
            3 => std.debug.print("C", .{}),
            4 => std.debug.print("D", .{}),
            5 => std.debug.print("E", .{}),
            6 => std.debug.print("F", .{}),
            7 => std.debug.print("G", .{}),
            8 => std.debug.print("H", .{}),
            9 => std.debug.print("I", .{}),
            10 => std.debug.print("J", .{}),
            // ...全部はいらない ...
            25 => std.debug.print("Y", .{}),
            26 => std.debug.print("Z", .{}),
            // Switchステートメントは「網羅的」にする必要があります
            // (すべての可能な値にマッチする必要があります）。 このスイッチに "else" を追加してください。
            // c が既存のマッチのいずれでもない場合、クエスチョンマーク "?" を表示するよう、
            // このスイッチに追加してください。
        }
    }

    std.debug.print("\n", .{});
}
