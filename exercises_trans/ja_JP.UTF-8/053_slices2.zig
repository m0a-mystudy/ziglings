//
// 文字列のスライスを試したくなったでしょうか？文字列は
// u8 文字の配列ですからね。文字列のスライスはとてもうまくいきます。
// Zigの文字列リテラルは不変（const）値であることを忘れないでください。
// そこで、スライスの型を次のように変更する必要があります。
// from:
//
//     var foo: []u8 = "foobar"[0..3];
//
// to:
//
//     var foo: []const u8 = "foobar"[0..3];
//
// この Zero Wing にインスパイアされたフレーズデスクランブラを修正できるかどうか見てみましょう。
const std = @import("std");

pub fn main() void {
    const scrambled = "great base for all your justice are belong to us";

    const base1: []u8 = scrambled[15..23];
    const base2: []u8 = scrambled[6..10];
    const base3: []u8 = scrambled[32..];
    printPhrase(base1, base2, base3);

    const justice1: []u8 = scrambled[11..14];
    const justice2: []u8 = scrambled[0..5];
    const justice3: []u8 = scrambled[24..31];
    printPhrase(justice1, justice2, justice3);

    std.debug.print("\n", .{});
}

fn printPhrase(part1: []u8, part2: []u8, part3: []u8) void {
    std.debug.print("'{s} {s} {s}.' ", .{ part1, part2, part3 });
}
