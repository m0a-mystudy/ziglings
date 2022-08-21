//
// 実のところ、任意の式の前に 'comptime' を置くことで、コ
// ンパイル時に強制的に実行させることができます。
//
// 関数を実行する:
//
//     comptime llama();
//
// 値を取得:
//
//     bar = comptime baz();
//
// ブロック全体を実行:
//
//     comptime {
//         bar = baz + biff();
//         llama(bar);
//     }
//
// ブロックから値を取得:
//
//     var llama = comptime bar: {
//         const baz = biff() + bonk();
//         break :bar baz;
//     }
//
const print = @import("std").debug.print;

const llama_count = 5;
const llamas = [llama_count]u32{ 5, 10, 15, 20, 25 };

pub fn main() void {
    // 最後のllamaを取得するつもりでした。アサーションが失敗しないように、
    // この単純なミスを修正してください。
    const my_llama = getLlama(5);

    print("My llama value is {}.\n", .{my_llama});
}

fn getLlama(i: usize) u32 {
    // この関数の先頭には、間違いを防ぐためにガードのassert()を入れています。
    // ここでの'comptime'キーワードは、コンパイル時にミスを検出することを意味します!
    //
    //
    // 'comptime' がなければ、これはまだ動作するが、
    // アサーションは実行時にPANICで失敗し、それはあまり良いことではない。
    // 
    //
    // 残念ながら、今エラーが発生しそうだ。
    // なぜなら 'i' パラメータはコンパイル時に既知であることが
    // 保証されている必要があるからだ。
    // これを実現するために、上の'i'パラメータで何ができるでしょうか？    
    comptime assert(i < llama_count);

    return llamas[i];
}

// 面白いことに、この assert() 関数は、Zig 標準ライブラリの 
// std.debug.assert() と同じものです。
fn assert(ok: bool) void {
    if (!ok) unreachable;
}
//
// おまけ: この演習では、誤って 'foo' のインスタンスをすべて 'llama' に
// 置き換えてしまいましたが、後悔はしていません!

