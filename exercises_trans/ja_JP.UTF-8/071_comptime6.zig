//
// プログラム中にループを使えたらいいのですが、
// コンパイル時にしかできないことがあるため、ループを使えないことが何度かありました。
// 結局、そのようなことは手動で行わなければなりませんでした。
// 普通の人ならね。バーン！私たちはプログラマーなんだ! コンピュータが
// この仕事をするのだ
//
//
// インライン for はコンパイル時に実行され、通常の実行時の 
// for ループが許されない上記のような状況下で、
// 一連の項目をプログラム的にループすることができます。
//
//
//     inline for (.{ u8, u16, u32, u64 }) |T| {
//         print("{} ", .{@typeInfo(T).Int.bits});
//     }
//
// 上の例では、型のリストをループしています。
// これはコンパイル時にのみ利用可能です。
//
const print = @import("std").debug.print;

// 練習問題 065 で、リフレクションのためにビルトインを使用した Narcissus を覚えていますか？彼は復活して、
// それを気に入っています。
const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined,
};

pub fn main() void {
    print("Narcissus has room in his heart for:", .{});

    // 前回、Narcissus 構造体を調べたとき、私たちは 3 つのフィールドに
    // それぞれ手動でアクセスしなければなりませんでした。私たちの 'if' ステートメントは、ほとんどそのままの形で 
    // 3 回繰り返されました。うっそー
    //
    // スライス 'fields' の各フィールドに対して以下のブロックを実装するために
    //  'inline for' を使ってください。

    const fields = @typeInfo(Narcissus).Struct.fields;

    ??? {
        if (field.field_type != void) {
            print(" {s}", .{field.name});
        }
    }

    // これができたら、エクササイズに戻って見てください。
    // 065 に戻って、あなたが書いたものを、私たちが書いた醜態と
    // 比較してみてください。

    print(".\n", .{});
}
