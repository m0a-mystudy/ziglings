
// 助けて 邪悪なエイリアンが地球上に卵を隠し、
// 孵化し始めたんだ
//
// 戦いに飛び込む前に、4つのことを知っておく必要があります。
//
// 1. 構造体には関数を付けることができる。
//
//     const Foo = struct{
//         pub fn hello() void {
//             std.debug.print("Foo says hello!\n", .{});
//         }
//     };
//
// 2. 構造体のメンバである関数は「メソッド」と呼ばれ、次のように「ドット構文」
//    で呼び出します。
//
//     Foo.hello();
//
// 3. メソッドの特長は、「self」という特別なパラメータを持ち、
//    「self」はその型の構造体のインスタンスを取ることができます。
//
//     const Bar = struct{
//         number: u32,
//
//         pub fn printMe(self: Bar) void {
//             std.debug.print("{}\n", .{self.number});
//         }
//     };
//
//    (実際には、最初のパラメータにどんな名前を付けても構いませんが
//    慣習に従って "self "を使ってほしいです)
// 
// 4. この構造体のインスタンスに対して、このメソッドを「ドット構文」で呼び出すと
//    そのインスタンスが自動的に「self」パラメータとして渡されます。
//    
//
//     var my_bar = Bar{ .number = 2000 };
//     my_bar.printMe(); // prints "2000"
//
// さて、あなたは武装しています。
//
// さて、エイリアンの構造体がすべてなくなるまで、ザッピングしてください。
// 地球は滅亡する!
//
const std = @import("std");

// この醜いエイリアンの構造を見てください。敵を知れ!
const Alien = struct {
    health: u8,

    // このメソッドは嫌いです。
    pub fn hatch(strength: u8) Alien {
        return Alien{
            .health = strength * 5,
        };
    }
};

// あなたの信頼できる武器。エイリアンをやっつけろ!
const HeatRay = struct {
    damage: u8,

    // 私たちはこのメソッドが大好きです。
    pub fn zap(self: *HeatRay, alien: *Alien) void {
        alien.health -= if (self.damage >= alien.health) alien.health else self.damage;
    }
};

pub fn main() void {
    // 見てください、この様々な強さを持った宇宙人たちを!
    var aliens = [_]Alien{
        Alien.hatch(2),
        Alien.hatch(1),
        Alien.hatch(3),
        Alien.hatch(3),
        Alien.hatch(5),
        Alien.hatch(3),
    };

    var aliens_alive = aliens.len;
    var heat_ray = HeatRay{ .damage = 7 }; // 熱線兵器を渡された。

    // まだエイリアンを全部倒していないかどうか、チェックし続けます。
    while (aliens_alive > 0) {
        aliens_alive = 0;

        // すべてのエイリアンを参照でループする（※ポインタ・キャプチャの値を作る）
        for (aliens) |*alien| {

            // *** ここで熱線でエイリアンをザッピング! ***
            ???.zap(???);

            // エイリアンの体力がまだ0を超えていれば、生きていることになる。
            if (alien.health > 0) aliens_alive += 1;
        }

        std.debug.print("{} aliens. ", .{aliens_alive});
    }

    std.debug.print("Earth is saved!\n", .{});
}
