//
// 構造体型は、名前を付けるまでは常に「anonymous(匿名)」です。
//
//     struct {};
//
// これまでは、次のように構造体型に名前を付けていました。
//
//     const Foo = struct {};
//
// * @typeName(Foo) の値は "<filename>.Foo"です。
//
// 構造体は、関数から返すときにも名前が与えられます。
//
//
//     fn Bar() type {
//         return struct {};
//     }
//
//     const MyBar = Bar();  // 構造体型を格納する。
//     const bar = Bar() {}; // 構造体のインスタンスを作成する。
//
// * @typeName(Bar())の値は "Bar() "である。
// * @typeName(MyBar)の値は "Bar() "である。
// * @typeName(@TypeOf(bar))の値は "Bar() "である。
//
// 完全に無名の構造体を持つこともできます。typeName(struct {})の値は
// 「struct:<position in source>」です。
//
const print = @import("std").debug.print;

// この関数は、匿名構造体型
// （この関数から返された後は匿名ではなくなります）を返して、
// 汎用データ構造を作成します。
fn Circle(comptime T: type) type {
    return struct {
        center_x: T,
        center_y: T,
        radius: T,
    };
}

pub fn main() void {
    //
    // これらの値を保持することができる円構造体型のインスタンスを作成するために、
    // これら2つの変数の初期化式を完成させることができるかどうかを確認します。
    //
    //
    // * circle1 は i32 個の整数を保持する必要があります。
    // * circle2 は f32 浮動小数点数を保持します。
    //
    var circle1 = ??? {
        .center_x = 25,
        .center_y = 70,
        .radius = 15,
    };

    var circle2 = ??? {
        .center_x = 25.234,
        .center_y = 70.999,
        .radius = 15.714,
    };

    print("[{s}: {},{},{}] ", .{
        stripFname(@typeName(@TypeOf(circle1))),
        circle1.center_x,
        circle1.center_y,
        circle1.radius,
    });

    print("[{s}: {d:.1},{d:.1},{d:.1}]\n", .{
        stripFname(@typeName(@TypeOf(circle2))),
        circle2.center_x,
        circle2.center_y,
        circle2.radius,
    });
}

// Ex.065の型名の「ナルシスト的(narcissistic)修正」を覚えていますか？
// ここで同じことをします。ハードコードされたスライスを使用して型名を返します。
// これは出力がより美しく見えるようにするためです。自分の虚栄心を満足させてください。
// プログラマは美しいのです。
fn stripFname(mytype: []const u8) []const u8 {
    return mytype[22..];
}
// 上記コードは、「本物」のプログラムでは即赤信号ものです。
