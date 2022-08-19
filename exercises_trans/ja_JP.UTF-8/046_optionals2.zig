//
// オプショナルの型ができたので、構造体に適用することができます。
// 前回、象をチェックインしたときに、3頭ともリンクさせる必要がありました。
// 最後の尻尾が最初の象にリンクするように、3頭の象を「輪」にする必要がありました。
// これは、私たちが他の象を指していない尻尾
// という概念を持っていなかったからです。
//
// 便利な ".?" というショートカットも紹介します。
//
//     const foo = bar.?;
//
// 上記シュートカットは以下と同じです。
//
//     const foo = bar orelse unreachable;
//
// 以下、このショートカットを使っている箇所を探してみてください。
//
// では、象の尻尾をオプショナルにしましょう!
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: *Elephant = null, //うーん...尻尾に何か必要だな...。
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // 象の尻尾が次の象を "指す "ようにつなげます。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// この関数は、すべての象を一度だけ訪れ、最初の象から始めて、
// 次の象まで尾をたどります。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;

        // 他の要素を指していない尾部に遭遇した時点で
        // 停止する必要があります。
        // それを実現するために、ここに何を書けばいいのでしょうか？
        if (e.tail == null) ???;

        e = e.tail.?;
    }
}
