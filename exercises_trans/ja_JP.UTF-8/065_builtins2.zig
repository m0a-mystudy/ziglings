//
// Zigには、以下のような数学演算のための組み込み関数があります。
//
//      @sqrt        @sin          @cos
//      @exp         @log          @floor
//
// ...そして、以下のような多くの型キャスト操作があります。
//
//      @as          @intToError   @intToFloat
//      @intToPtr    @ptrToInt     @enumToInt
//
// 雨の日に、公式 Zig ドキュメントにある組み込み関数の完全なリストにざっと
// 目を通すのも悪くない時間の使い方でしょう。
// そこにあるのは、とてもクールな機能です。
// call、@compileLog、@embedFile、@srcをチェックしてみてください。
//
//                            ...
//
// とりあえず、Zigの数あるイントロスペクション能力のうち、3つだけを調べて、
// 組み込み件数の検証を完了します。
//
// 1. @This() type
//
// 関数呼び出しの内部にある、最も内側の構造体、列挙体、
// または共用体を返します。
//
// 2. @typeInfo(comptime T: type) @import("std").builtin.TypeInfo
//
// TypeInfoユニオンに含まれる任意の型に関する情報を返す。
// これは、どの型を調べるかによって異なる情報を含む。
//
//
// 3. @TypeOf(...) type
//
// すべての入力パラメータ（各パラメータは任意の式）に共通する型を返します。
// この型は、コンパイラが型を推定する際に使用するのと同じ「ピア型解決」プロセスを
// 使用して解決されます。
//
//
// (型を返す2つの関数が大文字で始まっていることに注目してください。
// これはZigの標準的な命名方法です)。
//
const print = @import("std").debug.print;

const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined, // Alas, poor Echo!

    fn fetchTheMostBeautifulType() type {
        return @This();
    }
};

pub fn main() void {
    var narcissus: Narcissus = Narcissus{};

    // おっと! me' と 'myself' フィールドを未定義のままにしておくことはできません。
    // ここで設定してください。
    narcissus.me = &narcissus;
    narcissus.??? = ???;

    // これは3つの別々の参照から「仲間の型」を決定します
    //（これらは偶然にもすべて同じオブジェクトです）。
    const Type1 = @TypeOf(narcissus, narcissus.me.*, narcissus.myself.*);

    // この関数を呼び出すとき、何か間違ったことをしたようです。
    // メソッドとして呼び出したので、セルフパラメータを持っていれば
    // うまくいくはずです。しかし、そうではありません。(上記参照)
    //
    // この修正は非常に微妙なものですが、大きな違いがあります!
    // 
    const Type2 = narcissus.fetchTheMostBeautifulType();

    // 今度はNarcissusについてのピタリとした文章を出力します。
    print("A {s} loves all {s}es. ", .{
        maximumNarcissism(Type1),
        maximumNarcissism(Type2),
    });

    //   彼の最後の言葉は、いつも見ていたあの海を
    //   いつも見ていた水辺で
    //   こう言った
    //       「悲しいかな、私の愛する少年よ、無駄だった！」
    //   その場所は、あらゆる言葉を返してきた。
    //   彼は泣いた
    //            "さらばだ"
    //   そしてエコーは..:
    //                   "さらばだ！"
    
    //     --オービッド『変身』より
    //       イアン・ジョンストン訳

    print("He has room in his heart for:", .{});

    // A StructFields array
    const fields = @typeInfo(Narcissus).Struct.fields;

    // 'fields' は StructFields のスライスです。以下はその宣言である。
    //
    //     pub const StructField = struct {
    //         name: []const u8,
    //         field_type: type,
    //         default_value: anytype,
    //         is_comptime: bool,
    //         alignment: comptime_int,
    //     };
    //
    // フィールドの型が 'void' (これはスペースを全く取らないゼロビット型です!) 
    // の場合、フィールド名が表示されないように、
    // これらの 'if' ステートメントを完成させてください。
    if (fields[0].??? != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[0].name});
    }

    if (fields[1].??? != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[1].name});
    }

    if (fields[2].??? != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[2].name});
    }

    // うっそー、上の繰り返されたコードを見てよ! 
    // これは痒くなりますね。
    //
    // なぜなら、'fields' はコンパイル時にしか評価されないからです。 
    // この「コンパイル時」について学ぶのはもう過去のことのように思えますが、
    // いかがでしたでしょうか？心配しなくても、そのうちわかるようになりますよ。

    print(".\n", .{});
}

// NOTE: この演習では、もともと以下のような関数は含まれていませんでした。
// しかし、Zig 0.10.0以降の変更で、型にソースファイル名が追加され、
// "Narcissus "は "065_builtins2.Narcissus "になりました。
//
// この問題を解決するために、
// 私はこの関数を追加しました。
// (これは、型名の14文字目から始まるスライスを返します
// (半角文字を想定しています))。
//
// 練習問題070で@typeNameを再び見ることになります。今のところ、あなたは
// Typeを受け取ってu8の "文字列 "を返していることがわかれば良いでしょう
fn maximumNarcissism(myType: anytype) []const u8 {
    // Turn '065_builtins2.Narcissus' into 'Narcissus'
    return @typeName(myType)[14..];
}
