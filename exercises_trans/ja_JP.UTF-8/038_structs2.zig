//
// 構造体で値をグループ化することは、単に便利なだけではありません。
// 値を格納したり、関数に渡したりする際に、値を1つのアイテムとして扱うことができます。
// 
//
// この演習では、構造体を配列に格納する方法と、配列に格納することで、
// ループを使用して構造体を表示する方法を示します。
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
    health: u8,
    experience: u32,
};

pub fn main() void {
    var chars: [2]Character = undefined;

    // 賢者Glorp
    chars[0] = Character{
        .class = Class.wizard,
        .gold = 20,
        .health = 100,
        .experience = 10,
    };

    // 以下のプロパティを持つ "Zump the Loud "を追加してください。
    //
    //     class      bard // 吟遊詩人
    //     gold       10  
    //     health     100
    //     experience 20
    //
    // このプログラムは、Zumpを追加せずに実行できます
    // その場合何をするのか？そして、それはなぜなのか？

    // RPGの全キャラクターをループで出力する。
    for (chars) |c, num| {
        std.debug.print("Character {} - G:{} H:{} XP:{}\n", .{
            num + 1, c.gold, c.health, c.experience,
        });
    }
}

// 上記のようにZumpを追加せずにプログラムを実行した場合
// ゴミのような値が表示されます。デバッグモードでは
// Zigはバイナリで "10101010 "という繰り返しパターンをすべての未定義の場所に書き込みます。
// デバッグ時に発見しやすくするために、すべての未定義の場所にバイナリ（16進数では0xAA）で 書き込みます。
// デバッグ時に発見しやすくします。
