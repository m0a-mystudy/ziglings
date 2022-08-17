//
// 素晴らしいことに、Zig には複数行の文字列があります!
//
// 複数行の文字列を作るには、コードコメントと同じように各行の先頭に 
// '\\' を付けます。
//
//     const two_lines =
//         \\Line One
//         \\Line Two
//     ;
//
// このプログラムで歌詞を表示できるか試してみましょう。
//
const std = @import("std");

pub fn main() void {
    const lyrics =
        Ziggy played guitar
        Jamming good with Andrew Kelley
        And the Spiders from Mars
    ;

    std.debug.print("{s}\n", .{lyrics});
}
