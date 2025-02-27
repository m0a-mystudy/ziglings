//
// 'suspend' を持つ関数は非同期で、'async' キーワードなしで非同期関数を呼び出すと
// 呼び出し元の関数が非同期になることを思い出してください。
// 
//
//     fn fooThatMightSuspend(maybe: bool) void {
//         if (maybe) suspend {}
//     }
//
//     fn bar() void {
//         fooThatMightSuspend(true); // Now bar() is async!
//     }
//
// しかし、関数がサスペンドしないことが分かっている場合、 
// 'nosuspend' キーワードでコンパイラに約束させることができます。
//
//     fn bar() void {
//         nosuspend fooThatMightSuspend(false);
//     }
//
// もし関数がサスペンドしてコンパイラとの約束が破られた場合、
// プログラムは実行時にパニックを起こします。
// この誓い破りめ! >:-(
//
const print = @import("std").debug.print;

pub fn main() void {

    // main()関数は非同期ではありえない。しかし、我々はgetBeef()が
    // この特定の呼び出しで中断されないことを知っています。
    // これをOKにしてください。
    var my_beef = getBeef(0);

    print("beef? {X}!\n", .{my_beef});
}

fn getBeef(input: u32) u32 {
    if (input == 0xDEAD) {
        suspend {}
    }

    return 0xBEEF;
}
//
// もっと深く...
//                     ...uNdeFiNEd beHAVi0r!
//
// まだ説明していませんでしたが、ランタイムの「安全性」機能には、
// コンパイルされたプログラムにいくつかの余分な命令が必要です。
// たいていの場合、これらを入れておくとよいでしょう。
//
// しかし、プログラムによっては、データの整合性が処理速度よりも重要でない場合
// （例えば、いくつかのゲーム）、これらの安全機能なしでコンパイルすることができます。
// 
//
// これは単に Zig言語が 何が起こるかを定義していない つまりUndefined Behavior (UB)
// であることを意味します。
// 最良のケースはクラッシュすることですが、最悪のケースでは、
// 間違った結果で実行し続け、データを破損したり、
// セキュリティリスクにさらされたりすることになります。
// 
//
// このプログラムは UB を探求するのに最適な方法です。
// 動作するようになったら、getBeef()関数を値0xDEADで呼び出して、
// 「suspend」キーワードを呼び出すようにしてみてください。
//
//     getBeef(0xDEAD)
//
// このプログラムを実行すると、パニックが発生し、
// 問題のデバッグに役立つスタックトレースが表示されます。
//
//     zig run exercises/090_async7.zig
//     thread 328 panic: async function called...
//     ...
//
// しかし、ReleaseFastモードを使用して安全チェックをオフにすると
// どうなるかを見てみましょう。
//
//     zig run -O ReleaseFast exercises/090_async7.zig
//     beef? 0!
//
// これは間違った結果です。あなたのコンピュータでは、違う答えが
// 返ってくるかもしれませんし、クラッシュするかもしれません! 
// 具体的に何が起こるかは未定です。あなたのコンピュータは今、
// 野生動物のように、CPUの基本的な本能で生のメモリの
// ビットとバイトに反応しています。それは恐ろしくもあり、爽快でもあります。
//
