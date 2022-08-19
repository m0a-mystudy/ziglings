//
// メソッドがどのように機能するかを見てきましたので、いくつかの Elephantのメソッドで
// 私たちの象をもう少し助けられるか見てみましょう。
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null,
    visited: bool = false,

    // 新しいエレファントメソッドの登場
    pub fn getTail(self: *Elephant) *Elephant {
        return self.tail.?; //  "orelse unreachable" を意味することを忘れないでください。
    }

    pub fn hasTail(self: *Elephant) bool {
        return (self.tail != null);
    }

    pub fn visit(self: *Elephant) void {
        self.visited = true;
    }

    pub fn print(self: *Elephant) void {
        // 象を表す文字と[v]isitedを出力します。
        var v: u8 = if (self.visited) 'v' else ' ';
        std.debug.print("{u}{u} ", .{ self.letter, v });
    }
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // これは、それぞれの尾が次の尾を "指す "ように、象たちを繋ぐものです。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// この関数は、すべての象を一度だけ訪れ、最初の象から始めて、次の象まで尾をたどります。
// 最初の象から始めて、次の象まで尾をたどる。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (true) {
        e.print();
        e.visit();

        // 次の象を取得するか停止する
        if (e.hasTail()) {
            e = e.???; // ここでは、どのメソッドを使います？
        } else {
            break;
        }
    }
}

// Zigの列挙型はメソッドを持つこともできる! このコメントは、もともと
// enum メソッドのインスタンスを見つけることができるかどうか。その結果
// 最初の 5 つのプルリクエストが受け入れられましたので、ここに紹介します。
//
// 1) drforester - Zig のソースに一つありました。
// https://github.com/ziglang/zig/blob/041212a41cfaf029dc3eb9740467b721c76f406c/src/Compilation.zig#L2495
//
// 2) bbuccianti - 1つ見つけました!
// https://github.com/ziglang/zig/blob/6787f163eb6db2b8b89c2ea6cb51d63606487e12/lib/std/debug.zig#L477
//
// 3) GoldsteinE - たくさん見つかりました。
// https://github.com/ziglang/zig/blob/ce14bc7176f9e441064ffdde2d85e35fd78977f2/lib/std/target.zig#L65
//
// 4) SpencerCDixon - この言語が今のところ大好きです :-)
// https://github.com/ziglang/zig/blob/a502c160cd51ce3de80b3be945245b7a91967a85/src/zir.zig#L530
//
// 5) tomkun - こちらも enum メソッドです。
// https://github.com/ziglang/zig/blob/4ca1f4ec2e3ae1a08295bc6ed03c235cb7700ab9/src/codegen/aarch64.zig#L24
