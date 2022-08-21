//
// ユニオンを使うと、異なるタイプやサイズのデータを同じメモリアドレスに
// 格納することができます。これはどのようにして可能なのでしょうか？
// コンパイラは、格納したい最大のもののために十分なメモリを確保しています。
// 
//
// この例では、Foo のインスタンスは、現在 u8 を格納していても、
// 常に u64 のメモリ空間を占有します。
//
//     const Foo = union {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// 構文は構造体と同じように見えますが、
// Fooはsmall、medium、large 値のいずれかしか保持できません。
// あるフィールドがアクティブになると、他の非アクティブなフィールドはアクセスできなくなります。
// アクティブなフィールドを変更するには、まったく新しいインスタンスを割り当てます。
//
//     var f = Foo{ .small = 5 };
//     f.small += 5;                  // OKAY
//     f.medium = 5432;               // ERROR!
//     f = Foo{ .medium = 5432 };     // OKAY
//
// ユニオンはメモリ内の空間を「再利用」できるため、メモリ内の空間を節約することができます。
// また、一種のプリミティブなポリモーフィズムを提供します。
// ここでは、fooBar() は、それがどんなサイズの符号なし整数であっても 
// Foo を受け取ることができます。
//
//     fn fooBar(f: Foo) void { ... }
//
// しかし、fooBar()はどのフィールドがアクティブであるかをどうやって知るのでしょうか？
// Zig にはきちんとした追跡方法がありますが、
// 今のところは手動でやるしかないでしょう。
//
// このプログラムが動くかどうか見てみましょう!
//
const std = @import("std");

// 簡単な生態系シミュレーションを書き始めたところです。
// 昆虫はハチかアリで表現します。蜂は
// その日に訪れた花の数を記憶し、アリは単に
// 生きているかどうかを記憶します。
const Insect = union {
    flowers_visited: u16,
    still_alive: bool,
};

// 昆虫の種類を指定する必要があるので 
// enum を使用します（覚えていますか？）
const AntOrBee = enum { a, b };

pub fn main() void {
        // 試しに蜂と蟻を1匹ずつ作ってみます。
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 15 };

    std.debug.print("Insect report! ", .{});

    // おっと! ここで間違いがありました。
    printInsect(ant, AntOrBee.c);
    printInsect(bee, AntOrBee.c);

    std.debug.print("\n", .{});
}

// エキセントリックなドクター・ゾラプテラが、
// 昆虫の印刷には1つの関数しか使えないと言う。ドクターZは小柄で、
// 時々不可解なことを言うが、我々は彼女を問いただすことはしない。
fn printInsect(insect: Insect, what_it_is: AntOrBee) void {
    switch (what_it_is) {
        .a => std.debug.print("Ant alive is: {}. ", .{insect.still_alive}),
        .b => std.debug.print("Bee visited {} flowers. ", .{insect.flowers_visited}),
    }
}
