//
// 整数の場合と同様に、構造体へのポインタを渡すと、その構造体を変更することができます。
// 構造体を変更したい場合、その構造体へのポインタを渡すことができます。ポインタは次のような場合にも便利です。
// 構造体への参照（構造体への「リンク」）を格納する必要がある場合。
//
//     const Vertex = struct{ x: u32, y: u32, z: u32 };
//
//     var v1 = Vertex{ .x=3, .y=2, .z=5 };
//
//     var pv: *Vertex = &v1;   // <-- 構造体へのポインタ
//
// 構造体のフィールドにアクセスするために "pv" ポインタをデリファレンスする
// 必要はないことに注意してください。
//
//     こっちでOK: pv.x
//     だめです:   pv.*.x
//
// 構造体へのポインタを引数に取る関数を書くことができます。
// この foo() 関数は構造体 v を変更します。
//
//     fn foo(v: *Vertex) void {
//         v.x += 2;
//         v.y += 3;
//         v.z += 7;
//     }
//
// このように呼び出します。
//
//     foo(&v1);
//
// RPG の例を見直して、printCharacter() 関数を作ってみましょう。
// この関数は参照によってキャラクタを受け取り、それを表示します。
// リンクされた師匠(menter) キャラクタがあれば、それを表示します。
//
const std = @import("std");

const Class = enum {
    wizard,
    thief,
    bard,
    warrior,
};

const Character = struct {
    class: Class,
    gold: u32,
    health: u8 = 100, // デフォルト値を提供することができます
    experience: u32,

    // ここで'?'を使って、NULL値を許容する必要があるんだ。
    // でも、その説明は後ほど。内緒でお願いします。
    mentor: ?*Character = null,
};

pub fn main() void {
    var mighty_krodor = Character{
        .class = Class.wizard,
        .gold = 10000,
        .experience = 2340,
    };

    var glorp = Character{ // Glorp!
        .class = Class.wizard,
        .gold = 10,
        .experience = 20,
        .mentor = &mighty_krodor, // Glorpの師匠は Mighty Krodor
    };

    // 直して!
    // printCharacter()にGlorpを渡してください。
    printCharacter(???);
}

// この関数の "c "パラメータがCharacter構造体へのポインタであることに注意してください。
fn printCharacter(c: *Character) void {
    // ここで、今まで見たことのないものを紹介します。enumを切り替えるとき、
    // 完全なenum名を書く必要はないのです。Zigは、Classのenum値をスイッチするとき、
    // 「.wizard」は「Class.wizard」を意味すると理解してくれます。
    const class_name = switch (c.class) {
        .wizard => "Wizard",
        .thief => "Thief",
        .bard => "Bard",
        .warrior => "Warrior",
    };

    std.debug.print("{s} (G:{} H:{} XP:{})\n", .{
        class_name,
        c.gold,
        c.health,
        c.experience,
    });

    // 「optional」の値をチェックし、それをキャプチャします。
    // 詳細はは後で説明します(これは前述の'?'と対になります)。
    if (c.mentor) |mentor| {
        std.debug.print("  Mentor: ", .{});
        printCharacter(mentor);
    }
}
