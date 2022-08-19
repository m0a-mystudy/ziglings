//
// ある変数が値を保持しているかもしれないし、そうでないかもしれないことを知りたい場合があります。
// Zigはこの考えをうまく表現しています。オプショナル型と呼んでいます。
// オプショナル型は、以下のように「?」をつけます
//
//     var foo: ?u32 = 10;
//
// これで foo は u32 整数または null(存在しない値を格納する値) を格納することができます。
// 
//
//     foo = null;
//
//     if (foo == null) beginScreaming();
//
// オプションの値を NULL でない型（この場合は u32型の整数）として使用する前に、
// それが NULL でないことを保証する必要があります。
// これを行う一つの方法は、"orelse "ステートメントを使い
// それを試みることです。
//
// var bar = foo orelse 2;
//
// ここで、bar は foo に格納されている u32 整数値と等しくなります。
// foo に格納されている u32 整数値と等しいか、foo が NULL の場合は 2 となります。
//
const std = @import("std");

pub fn main() void {
    const result = deepThought();

    // 結果がdeepThought()の整数値か42のどちらかになるように、
    // resultを変えてください。
    var answer: u8 = result;

    std.debug.print("The Ultimate Answer: {}.\n", .{answer});
}

fn deepThought() ?u8 {
    // Deep Thoughtのアウトプットの質が低下しているようです。
    // でも、このままにしておきます。ごめんね Deep Thought。
    return null;
}
// 過去からのブラスト

// オプショナルは　error union typeによく似ていて、値かエラーを保持することができます。
// 同様に、orelse文は、値を「アンラップ」したり、デフォルト値を提供するために使用される
// catch文のようなものです。
//
//    var maybe_bad: Error!u32 = Error.Evil;
//    var number: u32 = maybe_bad catch 0;
//
