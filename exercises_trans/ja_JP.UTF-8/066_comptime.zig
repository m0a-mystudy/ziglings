//
// 「コンパイル時」とは、プログラムがコンパイルされている間の環境のこと。
// これに対して「ランタイム」とは、コンパイルされたプログラムが実行されている
// 間の環境（従来はハードウェアCPU上のマシンコードとして）
// 
//
// エラーがわかりやすい例です。
//
// 1. コンパイル時のエラー：コンパイラによって検出され、
//      通常はプログラマにメッセージが表示される。
//
// 2. ランタイムエラー：実行中のプログラム自身、またはホストハードウェアやオペレーティングシステム
//      によって捕捉される。優雅にキャッチして処理されることもあれば、
//      コンピュータをクラッシュさせる（あるいは停止させて火災を発生させる）
//      こともありうる！
//
// すべてのコンパイル言語は、コードを解析し、シンボル（変数名や関数名など）のテーブルを維持するために、
// コンパイル時に一定のロジックを実行する必要がある。
//
//
// 最適化コンパイラは、コンパイル時にプログラムのどの程度を事前計算または
// 「インライン化」して、結果として得られるプログラムをより
// 効率的にすることができるかを把握することもできます。
// 賢いコンパイラはループを「アンロール」して、そのロジックを高速な線形命令列に変換することもできる
// （通常、繰り返されるコードのサイズが大きくなるという犠牲はごくわずかである）。
//
//
// Zigはこれらの概念をさらに推し進め、
// これらの最適化を言語自体の不可欠な部分としています。
//
const print = @import("std").debug.print;

pub fn main() void {
    // Zig の全ての数値リテラルは comptime_int 型または
    // comptime_float 型です。これらは任意の大きさです（必要なだけ大きくても小さくても構いません）。
    // これらは任意のサイズです（必要なだけ大きくても小さくても構いません）．
    //
    // const" で識別子を固定的に割り当てる場合、"u8"、"i32"、"f64" 
    // のようなサイズを指定する必要がないことに注意してください。
    //
    //
    // これらの識別子をプログラム中で使用すると、
    // コンパイル時に実行コードに値が挿入される。 
    // "const_int" と "const_float" は、
    // コンパイルされたアプリケーションには存在しない!
    const const_int = 12345;
    const const_float = 987.654;

    print("Immutable: {}, {d:.3}; ", .{ const_int, const_float });

    //  しかし、"var "を使って全く同じ値をミュータブルに識別子に代入すると、
    // 何かが変わる。
    //
    // リテラルは comptime_int と comptime_float のままですが、
    // 実行時に変更可能な識別子に代入したいのです。
    //
    //
    // 実行時に変更可能であるためには、これらの識別子はメモリの領域を参照する必要があります。
    // メモリ領域を参照するために、Zig はこれらの値のために確保すべきメモリの量を
    // 正確に知っていなければなりません。
    // したがって、特定のサイズを持つ数値型を指定すればよいことになる。
    // comptimeの数値は、選択したランタイム型に強制的に入れられます
    // （もし入れられるなら！）。
    var var_int = 12345;
    var var_float = 987.654;

    // 実行中のコンパイルプログラムで、"var_int" と "var_float" に
    // 割り当てられた領域に格納されているものを変更することができます。
    var_int = 54321;
    var_float = 456.789;

    print("Mutable: {}, {d:.3}; ", .{ var_int, var_float });

    // ボーナス：Zig の組み込み関数に慣れたので、次のことができるようになりました。
    // 型が何であるかを調べることができます。
    // 推測は不要です!
    print("Types: {}, {}, {}, {}\n", .{
        @TypeOf(const_int),
        @TypeOf(const_float),
        @TypeOf(var_int),
        @TypeOf(var_float),
    });
}
