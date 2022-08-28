//
// ループ本体はブロックであり、これも式である。
// これまで、ブロックがどのように値を評価したり返したりするのかを見てきました。
// この概念をさらに発展させるために、「ラベル」を適用して
// ブロックに名前を付けることもできることがわかりました。
//
//     my_label: { ... }
//
// ブロックにラベルを与えると、
// 'break' を使ってそのブロックから抜けることができます。
//
//     outer_block: {           // outer block
//         while (true) {       // inner block
//             break :outer_block;
//         }
//         unreachable;
//     }
//
// 先ほど学んだように、break文を使って値を返すことができます。
// ということは、どのラベル付きブロックからも値を返すことができるのでしょうか？
// はい、そうです。
//
//     const foo = make_five: {
//         const five = 1 + 1 + 1 + 1 + 1;
//         break :make_five five;
//     };
//
// ラベルはループでも使用できます。ネストされたループから特定のレベルで抜け出すことができるのは、
// 毎日使うものではありませんが、いざというときには非常に便利です。
// ループの内側から値を返すことができるのは、時にはとても便利で、
// まるで不正行為をしているような気分になります。
//  (また、一時変数を大量に作成するのを避けるのにも役立ちます）。
//
//
//     const bar: u8 = two_loop: while (true) {
//         while (true) {
//             break :two_loop 2;
//         }
//     } else 0;
//
// 上記の例では、break は "two_loop" と書かれた外側のループから抜け出し、
// 値 2 を返します。else 節は外側の two_loop に付属しており、
// break が呼ばれずにループが何らかの形で終了した場合に評価される。
//
//
// 最後に、ブロックラベルを 'continue' と一緒に使用することもできます。
// 
//
//     my_while: while (true) {
//         continue :my_while;
//     }
//
const print = @import("std").debug.print;

// 前述のように、なぜこの2つの数値に明示的な型が必要ないのか、
// すぐに理解できると思います。がんばれー
const ingredients = 4;
const foods = 4;

const Food = struct {
    name: []const u8,
    requires: [ingredients]bool,
};

//                 Chili  Macaroni  Tomato Sauce  Cheese
// ------------------------------------------------------
//  Mac & Cheese              x                     x
//  Chili Mac        x        x
//  Pasta                     x          x
//  Cheesy Chili     x                              x
// ------------------------------------------------------

const menu: [foods]Food = [_]Food{
    Food{
        .name = "Mac & Cheese",
        .requires = [ingredients]bool{ false, true, false, true },
    },
    Food{
        .name = "Chili Mac",
        .requires = [ingredients]bool{ true, true, false, false },
    },
    Food{
        .name = "Pasta",
        .requires = [ingredients]bool{ false, true, true, false },
    },
    Food{
        .name = "Cheesy Chili",
        .requires = [ingredients]bool{ true, false, false, true },
    },
};

pub fn main() void {
    // カフェテリアUSAへようこそ! 好きな食材を選んで
    // 美味しい食事を作りましょう。
    //
    // Cafeteria Customer Note: 全ての食材の組み合わせで食事が出来るわけではありません。
    // お料理をお作りします。デフォルトの食事は"Mac & Cheese"です。
    //
    // ソフトウェア開発者向けメモ: 食材の数をハードコーディングする。
    // ハードコーディングされた食材番号 (配列の位置に基づく) は、この小さな例では問題ありませんが
    // しかし、実際のアプリケーションでは、これは非常に危険な行為です。
    // 実際のアプリケーションでは、まさに犯罪です!
    const wanted_ingredients = [_]u8{ 0, 3 }; // Chili, Cheese

    // メニューの各食品を見る...
    const meal = food_loop: for (menu) |food| {

        // 次に、その食品に必要な食材を見る...
        for (food.requires) |required, required_ingredient| {

            // この食材は必須ではありませんので、スキップしてください。
            if (!required) continue;

            // 顧客がこの食材を希望したかどうかを確認する。
            // (各食品の必須成分リストにおける位置に基づいて、
            // want_it がその成分のインデックス番号になることを覚えておいてください) 
            // の位置に基づく食材のインデックス番号であることを忘れないように)。
            const found = for (wanted_ingredients) |want_it| {
                if (required_ingredient == want_it) break true;
            } else false;

            // この必要な食材が見つからなかったので、この食品は作れない。
            // はこの食品を作ることができない。外側のループを続ける。
            if (!found) continue :food_loop;
        }

        // ここまでくれば、必要な材料がすべて揃ったことになる。
        // この食品に必要な材料はすべて揃っている。
        //
        // このFoodをループから戻してください。
        break;
    };
    // ^ おっと! 要求された材料が見つからない場合、
    // デフォルトの食品としてMac & Cheeseを返すのを忘れていました。

    print("Enjoy your {s}!\n", .{meal.name});
}

// チャレンジ: 内部ループの変数 'found' をなくすこともできます。
// どうすればいいか、考えてみてください。
