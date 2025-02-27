//
// Zig では、整数リテラルをいくつかの便利な形式で表現することができます。
// フォーマットで表現することができます。これらはすべて同じ値です。
//
//     const a1: u8 = 65;           // 10進数
//     const a2: u8 = 0x41;         // 16 進法
//     const a3: u8 = 0o101;        // 8進数
//     const a4: u8 = 0b1000001;    // 2 進法
//     const a5: u8 = 'A';          // UTF-8 コードポイントリテラル
//
// 数字の中にアンダースコアを入れて、読みやすくすることもできます。
//
//     const t1: u32 = 14_689_520 // フォードモデル T の 1909-1927 年の販売台数。
//     const t2: u32 = 0xE0_24_F0 // 同じく、16進数で表記します。
//
// メッセージの修正をお願いします。


const print = @import("std").debug.print;

pub fn main() void {
    var zig = [_]u8 {
        0o131,     // octal
        0b1101000, // binary
        0x66,      // hex
    };

    print("{s} is cool.\n", .{zig});
}
