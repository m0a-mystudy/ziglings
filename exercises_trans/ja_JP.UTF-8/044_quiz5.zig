//
// 「象が歩く
//   小道に沿って
//
//   手をつないでいる
//   しっぽを掴んでいる」
//
// 「手をつないで」より
//     レノア・M・リンク作
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: *Elephant = undefined,
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    // (ここにエレファントBを追加してください！）
    var elephantC = Elephant{ .letter = 'C' };

    // それぞれの尻尾が次の象を「指す」ように象をつなげる。
    // 円を作ように: A->B->C->A...
    elephantA.tail = &elephantB;
    // （ここで象Bの尻尾と象Cをリンクさせてください！）
    elephantC.tail = &elephantA;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// この関数は、すべての象を一度だけ訪問し、最初の象から始めて
// 次の象まで尾をたどります。
// もし、（visited=trueを設定して）象を訪問したように「マーク」しなければ、
// これは無限にループすることになります。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;
        e = e.tail;
    }
}
