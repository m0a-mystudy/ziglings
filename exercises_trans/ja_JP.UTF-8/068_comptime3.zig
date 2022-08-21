//
// 関数の引数の前に 'comptime' を置くことで、
// 関数に渡される引数がコンパイル時に既知でなければならないことを
// 強制することもできる。
// 実際には、ずっとこのような関数std.debug.print()を使っています。
//
//     fn print(comptime fmt: []const u8, args: anytype) void
//
// 書式文字列パラメータ 'fmt' が 'comptime' とマークされていることに注意してください。
// この利点の一つは、実行時にクラッシュするのではなく、コンパイル時にformat文字列のエラーを
// チェックできることである。実行時にクラッシュするのではなく、
// コンパイル時にエラーをチェックできることです。
//
// (実際のフォーマットは std.fmt.format() で行われ、
// コンパイル時に実行される完全なフォーマット文字列パーサーを含んでいます! 
// コンパイル時に実行されます！)
//
const print = @import("std").debug.print;

// この構造体は模型のボートのモデルである。好きな縮尺に変形させることができる。
// 1:2 は半分の大きさ、1:32 は実物の 32 倍の大きさ、といった具合に。
// 
const Schooner = struct {
    name: []const u8,
    scale: u32 = 1,
    hull_length: u32 = 143,
    bowsprit_length: u32 = 34,
    mainmast_height: u32 = 95,

    fn scaleMe(self: *Schooner, comptime scale: u32) void {
        var my_scale = scale;

        // ここでは、誤って1:0のスケールを作成しようとする可能性を想定して、
        // 巧妙な工夫をしています。
        // 実行時にゼロ除算エラーになるのではなく、
        // コンパイルエラーに変えています。
        //
        //
        // これはおそらくほとんどの場合、正しい解決策です。
        // しかし、私たちのモデルボートモデルプログラムは非常にカジュアルで、
        // 私たちはただ「私が言いたいことをやって」動作し続けさせたいだけなのです。        
        //
        //
        // 代わりに0スケールを1に設定するように変更してください。
        // 
        if (my_scale == 0) @compileError("Scale 1:0 is not valid!");

        self.scale = my_scale;
        self.hull_length /= my_scale;
        self.bowsprit_length /= my_scale;
        self.mainmast_height /= my_scale;
    }

    fn printMe(self: Schooner) void {
        print("{s} (1:{}, {} x {})\n", .{
            self.name,
            self.scale,
            self.hull_length,
            self.mainmast_height,
        });
    }
};

pub fn main() void {
    var whale = Schooner{ .name = "Whale" };
    var shark = Schooner{ .name = "Shark" };
    var minnow = Schooner{ .name = "Minnow" };

    // ねえ、この実行時変数を
    // メソッドに渡すことはできない。どうすればいいんだ？
    // 
    var scale: u32 = undefined;

    scale = 32; // 1:32 scale

    minnow.scaleMe(scale);
    minnow.printMe();

    scale -= 16; // 1:16 scale

    shark.scaleMe(scale);
    shark.printMe();

    scale -= 16; // 1:0 scale (おっと、でもこれは修正しないでね!)

    whale.scaleMe(scale);
    whale.printMe();
}
//
// さらに深く
//
// もし、1:0の縮尺で模型を作ろうとしたら、どうなるでしょうか？
//
//
//    A) すでに完成しています。
//    B) 精神的なゼロ除算エラーに見舞われる。
//    C) 特異点を作り、地球を破壊する。
//
//
// 0:1の縮尺の模型はどうだろう？
//
//    A) すでに完成しています。
//    B) 無を元の無の形に注意深く並べるが、無限に拡大する。
//    C) 特異点を作り、惑星を破壊する。
//
// 答えはZiglingsのパッケージ裏面に記載されています。
