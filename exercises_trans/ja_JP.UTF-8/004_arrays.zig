//
// 配列の基本を学びましょう。配列は次のように宣言します。
//
//   var foo: [3]u32 = [3]u32{ 42, 108, 5423 };
//
// Zig が配列の大きさを推測できるときは、'_' をサイズ指定に使用できます。
//そうすることでZigにサイズをを推測させることもでき
// 宣言がより冗長にならずに済みます。
//
//   var foo = [_]u32{ 42, 108, 5423 };
//
// array[index]記法で配列の値を取得します。
//
//     const bar = foo[2]; // 5423
//
// array[index] 表記で配列の値を設定します。
//
//     foo[2] = 16;
//
// len プロパティを使用して配列の長さを取得します。
//
//     const length = foo.len;
//
const std = @import("std");

pub fn main() void {
    // (問題 1)
    // この "const "は、後で問題を引き起こします。
    // どうすれば直りますか？
    const some_primes = [_]u8{ 1, 3, 5, 7, 11, 13, 17, 19 };

    // 個々の値は'[]'表記で設定することができる。
    // 例: この行は最初の素数を 2 に変更する（これは正しい）。
    some_primes[0] = 2;

    // 個々の値には'[]'表記でアクセスすることもできる。
    // 例: この行では、最初の素数を "first "に格納しています。
    const first = some_primes[0];

    // (問題 2)
    // この式を完成させる必要があるようです。上の例を使って
    // 上記の例を使用して、"fourth" を some_primes 配列の 4 番目の要素に設定します。
    const fourth = some_primes[???];

    // (問題 3)
    // len プロパティを使用して配列の長さを取得します。
    const length = some_primes.???;

    std.debug.print("First: {}, Fourth: {}, Length: {}\n", .{
        first, fourth, length,
    });
}
