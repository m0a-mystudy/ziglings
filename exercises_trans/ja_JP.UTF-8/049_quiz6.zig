//
// "鼻としっぽは
// 便利なものだ
//
// 手をつないで』より
// レノア・M・リンク作
//
// 尾っぽは全部わかったから、鼻を実装してくれない？
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null,
    trunk: ?*Elephant = null,
    visited: bool = false,

    // Elephant tail methods!
    pub fn getTail(self: *Elephant) *Elephant {
        return self.tail.?; // "orelse unreachable" を意味することを忘れないでください。
    }

    pub fn hasTail(self: *Elephant) bool {
        return (self.tail != null);
    }

    // あなたのエレファントの鼻(trunk)のメソッドはこちら
    // ---------------------------------------------------

    ???

    // ---------------------------------------------------

    pub fn visit(self: *Elephant) void {
        self.visited = true;
    }

    pub fn print(self: *Elephant) void {
        // 象の文字と[v]isitedを出力します。
        var v: u8 = if (self.visited) 'v' else ' ';
        std.debug.print("{u}{u} ", .{ self.letter, v });
    }
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // それぞれの尻尾が次の尻尾を「指す」ように、象をつないでいきます。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    // そして、それぞれの鼻が前の鼻を「指す」ように、象をつなげます。
    elephantB.trunk = &elephantA;
    elephantC.trunk = &elephantB;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// この関数は、すべての象を尾から鼻へ2回ずつ訪れます。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    // 尾を追うんだ！
    while (true) {
        e.print();
        e.visit();

        // これで次のゾウを得るか停止する
        if (e.hasTail()) {
            e = e.getTail();
        } else {
            break;
        }
    }

    // 鼻を追うんだ！
    while (true) {
        e.print();

        // これは、前の象を取得するか、停止。
        if (e.hasTrunk()) {
            e = e.getTrunk();
        } else {
            break;
        }
    }
}
