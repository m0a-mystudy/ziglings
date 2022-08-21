//
// コンパイル時に関数に型を渡すことができるため、
// 複数の型で動作するコードを生成することができます。
// しかし、異なる型の値を関数に渡す助けにはなりません。
//
// このため、'anytype' プレースホルダーを用意しています。
// これは、コンパイル時にパラメータの実際の型を推測するように Zig に指示します。
//
//     fn foo(thing: anytype) void { ... }
//
// そして、@TypeOf()、@typeInfo()、@typeName()、
// @hasDecl()、@hasField()などの組み込み関数を使って、
// 渡された型についてさらに詳しく調べることができるようになるのです。
// このロジックは、すべてコンパイル時に実行されます。
//
const print = @import("std").debug.print;

// 3つの構造体を定義してみましょう。Duck、RubberDuck、Duct
// DuckとRubberDuckは、名前空間で宣言されたwaddle()とquack()メソッドを含んでいることに
// 注意してください（「decl」とも呼ばれます

const Duck = struct {
    eggs: u8,
    loudness: u8,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: Duck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: Duck) void {
        if (self.loudness < 4) {
            print("\"Quack.\" ", .{});
        } else {
            print("\"QUACK!\" ", .{});
        }
    }
};

const RubberDuck = struct {
    in_bath: bool = false,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: RubberDuck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: RubberDuck) void {
        // 式を'_'に代入することで、安全に
        // 値を「利用」しつつ、無視することができる。
        _ = self;
        print("\"Squeek!\" ", .{});
    }

    fn listen(self: RubberDuck, dev_talk: []const u8) void {
        // プログラミングの問題について開発者の話を聞く。
        // 黙々と問題を考える。役に立つ音を出す。
        _ = dev_talk;
        self.quack();
    }
};

const Duct = struct {
    diameter: u32,
    length: u32,
    galvanized: bool,
    connection: ?*Duct = null,

    fn connect(self: Duct, other: *Duct) !void {
        if (self.diameter == other.diameter) {
            self.connection = other;
        } else {
            return DuctError.UnmatchedDiameters;
        }
    }
};

const DuctError = error{UnmatchedDiameters};

pub fn main() void {
    // これは本物のアヒルです!
    const ducky1 = Duck{
        .eggs = 0,
        .loudness = 3,
    };

    // これは本物のアヒルではないが、
    // quack()とwaddle()の能力を持っているので、やはり "アヒル "である。
    const ducky2 = RubberDuck{
        .in_bath = false,
    };

    // これはアヒルとは言えない。
    const ducky3 = Duct{
        .diameter = 17,
        .length = 165,
        .galvanized = true,
    };

    print("ducky1: {}, ", .{isADuck(ducky1)});
    print("ducky2: {}, ", .{isADuck(ducky2)});
    print("ducky3: {}\n", .{isADuck(ducky3)});
}

// この関数は、コンパイル時に推論される単一のパラメータを持ちます。
// 組み込み関数 @TypeOf() と @hasDecl() を使ってアヒルの型付け
// （「アヒルのように歩き、アヒルのように鳴くなら、それはアヒルに違いない」）
// を行い、その型が「アヒル」であるかどうかを判断しています。
fn isADuck(possible_duck: anytype) bool {
    //  @hasDecl()を使って、
    // その型が「アヒル」に必要なものをすべて持っているかどうかを判断します。
    //
    // この例では、Foo型がincrement()メソッドを持つ場合、
    // 'has_increment'はtrueになります。
    //
    //     const has_increment = @hasDecl(Foo, "increment");
    //
    // MyType が waddle() と quack() の両方のメソッドを持っていることを
    // 確認してください。
    const MyType = @TypeOf(possible_duck);
    const walks_like_duck = ???;
    const quacks_like_duck = ???;

    const is_duck = walks_like_duck and quacks_like_duck;

    if (is_duck) {
        // ここで quack() メソッドを呼んで、Zig が十分にアヒルっぽいものに対して
        // アヒルアクションを実行できることを証明する。
        //
        //
        // チェックと推論はすべてコンパイル時に行われるため、
        // 完全な型安全性が保たれている。
        // quack()メソッドを持たない構造体（Ductなど）に対して
        // quack()メソッドを呼び出そうとすると、コンパイルエラーとなり、
        // 実行時のパニックやクラッシュは発生しません。
        //
        possible_duck.quack();
    }

    return is_duck;
}
