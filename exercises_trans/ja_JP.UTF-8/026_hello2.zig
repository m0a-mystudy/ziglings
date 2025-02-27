//
// 素晴らしいニュースです。これで、「本当の」Hello Worldを理解するのに十分な知識が得られました。
// Zig でのプログラム - システムの標準出力リソースを使用するものです...これは
// 失敗する可能性があります。
//
const std = @import("std");

// この main() の定義が、単なる "void" ではなく、"!void" を返すようになったことに
// 注意してください。特定のエラータイプは存在しないので、これはつまり
// Zig がエラーの種類を推測することを意味します。これは、main() の場合には適切です。
// しかし、他の場所に影響を及ぼす可能性があります。
pub fn main() !void {
    // 標準出力用のWriterを取得し、そこにprint()することができるようにしました。
    const stdout = std.io.getStdOut().writer();

    // std.debug.print()とは異なり、標準出力ライターはエラーで失敗することがあります。
    // エラーが何であるかは気にしません。
    // main()の戻り値として渡すことができるようにしたいです。
    //
    // これを実現する1つの文があることを習ったばかりですよね
    stdout.print("Hello world!\n", .{});
}
