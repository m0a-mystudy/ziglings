//
// つまり、「suspend」は呼び出された場所（「呼び出し先」）
// に制御を戻すのです。サスペンドされた関数に制御を戻すには
// どうすればよいのでしょうか？
//
// そのために 'resume' という新しいキーワードを用意しました。
// これは非同期関数呼び出しのフレームを受け取り、そこに制御を戻すものです。
//
//     fn fooThatSuspends() void {
//         suspend {}
//     }
//
//     var foo_frame = async fooThatSuspends();
//     resume foo_frame;
//
// このプログラムで "Hello async!"と表示させられるか試してみましょう。
//
const print = @import("std").debug.print;

pub fn main() void {
    var foo_frame = async foo();
}

fn foo() void {
    print("Hello ", .{});
    suspend {}
    print("async!\n", .{});
}
