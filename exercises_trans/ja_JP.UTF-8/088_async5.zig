//
// 確かに、グローバル変数で非同期値の問題を解決することができます。
// しかし、これは理想的な解決策とは言い難い。
//
// では、実際に非同期関数から戻り値を取得するにはどうすればよいのだろうか？
//
// 'await' キーワードは、非同期関数が完了するのを待ち、その戻り値を取得します。
//
//
//     fn foo() u32 {
//         return 5;
//     }
//
//    var foo_frame = async foo(); // フレーム起動・取得
//    var value = await foo_frame; // フレームを使って結果を待ちます。
//
// 上記の例は、foo()を呼び出して5を返すだけの愚かな方法です。
// しかし、foo()がもっと面白いことをした場合、
// 例えば5を得るためにネットワークの応答を待つとしたら、
// 我々のコードは値の準備ができるまで一時停止します。
//
// ご覧のように、async/await は基本的に関数呼び出しを 2 つのパートに分割します。
// 
//
//    1. 関数を呼び出す ('async')
//    2. 戻り値の取得（'await')
//
// また、'suspend' キーワードは、async コンテキストで呼び出される関数に
// 存在する必要はないことに注意してください。
//
// 'await' を使用して、getPageTitle() が返す文字列を取得します。
//
//
const print = @import("std").debug.print;

pub fn main() void {
    var myframe = async getPageTitle("http://example.com");

    var value = ???

    print("{s}\n", .{value});
}

fn getPageTitle(url: []const u8) []const u8 {
    // これは実際にネットワークリクエストを行っていることを前提にしてください。
    _ = url;
    return "Example Title.";
}
