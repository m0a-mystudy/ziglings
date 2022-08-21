//
//　タグ付き共用体を使用すると、さらに「良いことがあります」。
// 別の列挙型を使用する必要がない場合、推論された列挙型を一度に定義することができます。
// タグの型の代わりに 'enum' キーワードを使用するだけです。
// 
//
//     const Foo = union(enum) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// Insectを変換してみよう。Zoraptera 博士はすでに 
// 明示的な InsectStat 列挙型を削除してくれました!
//
const std = @import("std");

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 17 };

    std.debug.print("Insect report! ", .{});

    printInsect(ant);
    printInsect(bee);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (insect) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

// 推論されたenumは、enumとunionの関係における氷山の一角を表しているような、
// すてきなものです。実際に、enumにユニオンを強制することができます
// （ユニオンからenumとしてアクティブなフィールドを得ることができます）。
// さらに不思議なことに、enumをunionに強制することができるのです！
// しかし、あまり興奮しないでください。
// これは、ユニオンの型がvoidのような奇妙なゼロビット型の1つである場合にのみ機能します
// 
//
// タグ付きユニオンは、コンピュータサイエンスにおける多くのアイデアと同様に、
// 1960年代にまで遡る長い歴史を持っています。しかし、
// 特にシステムレベルのプログラミング言語では、最近になってようやく主流になりつつあります。
// また、「バリアント」、「和集合型」、「列挙型」とも呼ばれているのを
// 見たことがあるかもしれません!
