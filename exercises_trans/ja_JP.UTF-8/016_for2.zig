//
// for ループでは、反復処理の「index」を保存することもできます。
// indexとは0から始まり、反復ごとにカウントアップしていく数値です。
//
//     for (items) |item, index| {
//
//         // item と index を使って何かをする
//
//     }

//
// "item" と "index" には好きな名前を付けることができます。"i "はよく使われる
// index "の短縮形です。アイテム名は多くの場合、ループするアイテムの単数形です。
// 
//
const std = @import("std");

pub fn main() void {
    // 2進数1101のビットを以下のように
    // 「リトルエンディアン」順（最下位バイトが先）に格納しましょう。
    const bits = [_]u8{ 1, 0, 1, 1 };
    var value: u32 = 0;

    // ここで、2進数のビットを数値の値に変換するために、足し算をします。
    // 各ビットの2の累乗として場の値を計算します。
    //
    // 欠けている部分がわかりますか？
    for (bits) |bit, ???| {
        // usize型の i を u32型 に変換することに注意してください。
        // @intCast() という、@import()と同じ組み込み関数を使っています。
        // これについては、後の演習できちんと学びます。
        var place_value = std.math.pow(u32, 2, @intCast(u32, i));
        value += place_value * bit;
    }

    std.debug.print("The value of bits '1101': {}.\n", .{value});
}
