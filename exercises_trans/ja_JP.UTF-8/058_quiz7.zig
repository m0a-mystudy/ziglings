//
// Zigで使える型のバリエーションについて、多くの情報を吸収してきました。
// 大まかに、順番に説明すると
//
//                          u8  シングルアイテム
//                         *u8  シングルアイテムのポインタ
//                        []u8  スライス(サイズは実行時に判明)
//                       [5]u8  5個のu8からなる配列
//                       [*]u8  複数値のポインタ（0個以上）
//                 enum {a, b}  一意な値 a と b のセット
//                error {e, f}  一意なエラー値 e と f のセット
//      struct {y: u8, z: i32}  y と z の値グループ。
// union(enum) {a: u8, b: i32}  u8 または i32 のどちらかの単一値
//
// 上記のいずれの型の値も、"var" または "const" として代入することで、
// 代入した名前による変更を許可または禁止することができる。
//
//     const a: u8 = 5; // 変更不可
//       var b: u8 = 5; // 変更可能
//
// 上記のいずれかから、エラーユニオンやオプショナル型を作ることもできる。
// 
//
//     var a: E!u8 = 5; // u8 またはセット E からのエラーとすることができます。
//     var b: ?u8 = 5;  // u8 または null を指定可能
//
// これだけ知っていれば、地元の仙人を助けることができるかもしれない。
// 彼は森を旅する計画を立てるために、小さなZigプログラムを作りました。
// しかし、これにはいくつかの間違いがあります。
//
// *************************************************************
// *               この演習についての注意事項                      *
// *                                                           *
// *        このプログラムの隅々まで読んで理解する必要はありません。    *
// *        これは非常に大きな例です。自由に読み飛ばし、              *
// *        実際に壊れているいくつかの部分にだけ集中してください。      *                             
// *                                                           *
// *                                                           *
// *************************************************************
//
const print = @import("std").debug.print;

// grueはZorkにちなんだものです。
const TripError = error{ Unreachable, EatenByAGrue };

// まず、地図上の場所について説明します。それぞれには名前と
// 距離や移動の難易度（仙人が判断したもの）があります。
//
// 後で経路を割り当てる必要があるため、場所を mutable (var) 
// として宣言していることに注意してください。それはなぜか？なぜなら、
// パスは場所へのポインタを含んでおり、今それを代入すると依存関係が発生してしまうからです。
// ループになります。
const Place = struct {
    name: []const u8,
    paths: []const Path = undefined,
};

var a = Place{ .name = "Archer's Point" };
var b = Place{ .name = "Bridge" };
var c = Place{ .name = "Cottage" };
var d = Place{ .name = "Dogwood Grove" };
var e = Place{ .name = "East Pond" };
var f = Place{ .name = "Fox Pond" };

//                 仙人の手描きアスキーマップ
//  +---------------------------------------------------+
//  |         * Archer's Point                ~~~~      |
//  | ~~~                              ~~~~~~~~         |
//  |   ~~~| |~~~~~~~~~~~~      ~~~~~~~                 |
//  |         Bridge     ~~~~~~~~                       |
//  |  ^             ^                           ^      |
//  |     ^ ^                      / \                  |
//  |    ^     ^  ^       ^        |_| Cottage          |
//  |   Dogwood Grove                                   |
//  |                  ^     <boat>                     |
//  |  ^  ^  ^  ^          ~~~~~~~~~~~~~    ^   ^       |
//  |      ^             ~~ East Pond ~~~               |
//  |    ^    ^   ^       ~~~~~~~~~~~~~~                |
//  |                           ~~          ^           |
//  |           ^            ~~~ <-- short waterfall    |
//  |   ^                 ~~~~~                         |
//  |            ~~~~~~~~~~~~~~~~~                      |
//  |          ~~~~ Fox Pond ~~~~~~~    ^         ^     |
//  |      ^     ~~~~~~~~~~~~~~~           ^ ^          |
//  |                ~~~~~                              |
//  +---------------------------------------------------+
//
// 地図上の場所の数に基づいて、プログラム内のメモリを確保することになります。
// この値の型を指定する必要がないことに注意してください。
// なぜなら、一度コンパイルされたプログラムは、実際にはこの値を使用しないからです! 
// (まだ意味が分からなくても気にしないでください)。
const place_count = 6;

// さて、サイト間のすべてのパス(ある場所から別の場所へ行くルート)を作成しましょう
// パスは距離を持っています。
const Path = struct {
    from: *const Place,
    to: *const Place,
    dist: u8,
};

// ところで、以下のコードが多くの退屈な手作業に見えるなら、その通りです! 
// Zigのキラー機能の一つは、コンパイル時に実行されるコードを書いて
// 反復的なコードを「自動化」することですが（他の言語におけるマクロのようなもの）、
// 我々はまだその方法を学んでいないのです!
// 
const a_paths = [_]Path{
    Path{
        .from = &a, // from: Archer's Point
        .to = &b,   //   to: Bridge
        .dist = 2,
    },
};

const b_paths = [_]Path{
    Path{
        .from = &b, // from: Bridge
        .to = &a,   //   to: Archer's Point
        .dist = 2,
    },
    Path{
        .from = &b, // from: Bridge
        .to = &d,   //   to: Dogwood Grove
        .dist = 1,
    },
};

const c_paths = [_]Path{
    Path{
        .from = &c, // from: Cottage
        .to = &d,   //   to: Dogwood Grove
        .dist = 3,
    },
    Path{
        .from = &c, // from: Cottage
        .to = &e,   //   to: East Pond
        .dist = 2,
    },
};

const d_paths = [_]Path{
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &b,   //   to: Bridge
        .dist = 1,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &c,   //   to: Cottage
        .dist = 3,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &f,   //   to: Fox Pond
        .dist = 7,
    },
};

const e_paths = [_]Path{
    Path{
        .from = &e, // from: East Pond
        .to = &c,   //   to: Cottage
        .dist = 2,
    },
    Path{
        .from = &e, // from: East Pond
        .to = &f,   //   to: Fox Pond
        .dist = 1,  // (one-way down a short waterfall!)
    },
};

const f_paths = [_]Path{
    Path{
        .from = &f, // from: Fox Pond
        .to = &d,   //   to: Dogwood Grove
        .dist = 7,
    },
};

// 森の中の最適なコースをプロットしたら、それを「トリップ」にします。
// トリップとは、パスによって接続された一連の場所のことです。
// ここでは、TripItem ユニオンを使用して、Places と Paths の両方を
// 同じ配列にすることができます。
const TripItem = union(enum) {
    place: *const Place,
    path: *const Path,

    // これは、2つの異なるタイプのアイテムを正しく表示するための
    // 小さなヘルパー関数です。
    fn printMe(self: TripItem) void {
        switch (self) {
            // // おっと！？わらし仙人は、switch文の中で、
            // ユニオンの値をどのようにキャプチャするか忘れてしまいました。
            // 両方の値を  'p'として捕捉してください。そうすればprint文は機能します!
            .place => print("{s}", .{p.name}),
            .path => print("--{}->", .{p.dist}),
        }
    }
};

// 仙人のノートブックは、すべての魔法が起こる場所です。
// ノートブックの項目は、地図上で発見された場所と、そこへ行くための経路、
// 出発点からそこまでの距離です。
// もし、その場所に行くのにもっと良い道（短い距離）が見つかれば、エントリーを更新します。
// エントリーは「Todo」リストとしても機能し、次にどの道を探索すべきかを
// 記録しておくことができる。
const NotebookEntry = struct {
    place: *const Place,
    coming_from: ?*const Place,
    via_path: ?*const Path,
    dist_to_reach: u16,
};

// +------------------------------------------------+
// |               ~ 仙人のノートブック ~              |
// +---+----------------+----------------+----------+
// |   |      Place     |      From      | Distance |
// +---+----------------+----------------+----------+
// | 0 | Archer's Point | null           |        0 |
// | 1 | Bridge         | Archer's Point |        2 | < next_entry
// | 2 | Dogwood Grove  | Bridge         |        1 |
// | 3 |                |                |          | < end_of_entries
// |                      ...                       |
// +---+----------------+----------------+----------+
//
const HermitsNotebook = struct {
    // 配列の繰り返し演算子 `**` を覚えていますか？
    // ただの奇抜なものではなく、配列内の複数の項目を一つ一つ並べることなく
    // 代入できる素晴らしい方法なのです。
    // ここでは、これを使用して null 値を含む配列を初期化しています。
    entries: [place_count]?NotebookEntry = .{null} ** place_count,

    // 次のEntryは、"todo" リストのどこにいるのかを記録します。
    next_entry: u8 = 0,

    // ノートブックの空き領域の開始をマークします。
    end_of_entries: u8 = 0,

    // PlaceからEntryを探したいことがよくあります。
    // 見つからない場合は nullを返します。
    fn getEntry(self: *HermitsNotebook, place: *const Place) ?*NotebookEntry {
        for (self.entries) |*entry, i| {
            if (i >= self.end_of_entries) break;

            // ここで、仙人は行き詰まりました。
            // NotebookEntryへのオプションのポインタを返す必要があります。
            //
            // "entry "で持っているのはその逆で、
            // オプショナルなNotebookEntryへのポインタです!
            //
            // 片方を得るには、"entry "を（.*で）参照解除し、
            // オプショナルの（.？で）非NULL値を取得し、
            // そのアドレスを返す必要がある。
            // if文は、参照解除とオプショナル値の「アンラップ」が
            // どのように行われるかを示す手がかりを与えてくれます。
            // アドレスを「&」演算子で返すことを覚えておいてください。
            // 
            if (place == entry.*.?.place) return entry;
            //  これくらいの長さの答えにしてみてください：__________;
        }
        return null;
    }

    // checkNote() メソッドは、魔法のノートブックの心臓部です。
    // NotebookEntry 構造体の形式で新しいノートが与えられると、
    // そのノートの場所のエントリーがすでにあるかどうかを調べます。
    //
    // 「ない」場合、そのエントリをノートブックの最後に追加し、
    // 移動した経路と距離も記録します。
    //
    // 「ある」場合、その経路が前に記録した経路よりも
    // 「良い」（距離が短い）かどうかを確認します。
    // もしそうなら、古いエントリを新しいエントリで上書きします。
    fn checkNote(self: *HermitsNotebook, note: NotebookEntry) void {
        var existing_entry = self.getEntry(note.place);

        if (existing_entry == null) {
            self.entries[self.end_of_entries] = note;
            self.end_of_entries += 1;
        } else if (note.dist_to_reach < existing_entry.?.dist_to_reach) {
            existing_entry.?.* = note;
        }
    }

    // 次の2つのメソッドで、ノートブックを「Todo」リストとして使用することができます。
    // 
    fn hasNextEntry(self: *HermitsNotebook) bool {
        return self.next_entry < self.end_of_entries;
    }

    fn getNextEntry(self: *HermitsNotebook) *const NotebookEntry {
        defer self.next_entry += 1; // Increment after getting entry
        return &self.entries[self.next_entry].?;
    }

    // 地図の探索が完了したら、
    // すべての場所への最短経路を計算する。
    // 出発地から目的地までの全行程を収集するには、
    // 目的地のノートブックのエントリから、
    // coming_from ポインタを辿って出発地まで逆行する必要があります。
    // 最終的に得られるのは、逆順のトリップを含む TripItems の配列です。
    //
    // main()関数に配列のメモリを「所有」させたいので、
    // tripの配列をパラメータとして取る必要があります。
    // この関数のスタックフレーム（関数の「ローカル」データ用に割り当てられたスペース）
    // に配列を割り当て、そのポインタまたはスライスを返した場合、
    // 何が起こると思いますか？
    //
    //
    // 仙人はこの関数の戻り値に何かを忘れているようです。
    // それは何でしょう？
    fn getTripTo(self: *HermitsNotebook, trip: []?TripItem, dest: *Place) void {
        // 目的地のエントリーからスタートします。
        const destination_entry = self.getEntry(dest);

        //  この関数は、要求された目的地に到達しなかった場合、エラーを返す必要があります。
        // (このマップでは、すべての場所が他の場所から到達可能なので、
        // 実際には起こりえません)。
        // 
        if (destination_entry == null) {
            return TripError.Unreachable;
        }

        // 変数には、現在調べているエントリと、その場所を追跡するための
        // トリップアイテムを追加する場所を追跡するためのインデックスを保持します。
        var current_entry = destination_entry.?;
        var i: u8 = 0;

        // 各ループの最後に、continue 式でインデックスをインクリメントしています。
        // なぜ、2つずつ増やす必要があるかわかりますか？
        while (true) : (i += 2) {
            trip[i] = TripItem{ .place = current_entry.place };

            // どこからも来ないエントリーは、スタート地点に着いたということなので、
            // これで終了です。
            if (current_entry.coming_from == null) break;

            // そうでなければ、エントリにはパスがあります。
            trip[i + 1] = TripItem{ .path = current_entry.via_path.? };

            // 今、私たちは「どこから」来たのか、そのエントリーを追っています。
            // もし Place で "coming from" のエントリを見つけられなかったら、
            // プログラムに何か大きな問題があったということです! 
            // (これは本当に起こってはならないことです。グルーはチェックしましたか?)
            // 
            // 注意: ここでは何も修正する必要はありません。
            const previous_entry = self.getEntry(current_entry.coming_from.?);
            if (previous_entry == null) return TripError.EatenByAGrue;
            current_entry = previous_entry.?;
        }
    }
};

pub fn main() void {
    // ここで、仙人は自分の行きたい場所を決めます。
    // プログラムが動くようになったら、地図上のいろいろな場所を
    // 試してみてください。
    const start = &a;        // Archer's Point
    const destination = &f;  // Fox Pond

    // 各Path配列をスライスとして各Placeに格納する。
    // 前述のように、コンパイラが各アイテムのためのスペースを
    // どのように割り当てるかを見つけ出そうとしているときに
    // 依存ループを作成しないように、これらの参照を行うのを遅らせる必要がありました。
    a.paths = a_paths[0..];
    b.paths = b_paths[0..];
    c.paths = c_paths[0..];
    d.paths = d_paths[0..];
    e.paths = e_paths[0..];
    f.paths = f_paths[0..];

    // ここで、ノートブックのインスタンスを作成し、最初の「start」エントリーを追加します。
    // null値に注意してください。
    // このエントリーがどのようにノートブックに追加されるかは、
    // 上記の checkNote() メソッドのコメントを読んでください。
    var notebook = HermitsNotebook{};
    var working_note = NotebookEntry{
        .place = start,
        .coming_from = null,
        .via_path = null,
        .dist_to_reach = 0,
    };
    notebook.checkNote(working_note);

    // ノートブックから次のエントリーを取得します
    // （最初のエントリーは先ほど追加した "start "です）。
    // この時点で、到達可能なすべての場所をチェックしたことになります。
    while (notebook.hasNextEntry()) {
        var place_entry = notebook.getNextEntry();

        // 現在の場所から続くすべてのパスについて、
        // 新しいノート（NotebookEntry形式）を作成し、
        // 目的地の場所と、その場所に到達するためのスタートからの総距離を記述します。
        // 繰り返しますが、これがどのように動作するかは、
        // checkNote() メソッドのコメントを読んでください。
        for (place_entry.place.paths) |*path| {
            working_note = NotebookEntry{
                .place = path.to,
                .coming_from = place_entry.place,
                .via_path = path,
                .dist_to_reach = place_entry.dist_to_reach + path.dist,
            };
            notebook.checkNote(working_note);
        }
    }

    // 上のループが終了すると、到達可能なすべての場所への
    // 最短経路を計算したことになります。
    // あとは、旅行のためのメモリを確保し、
    // 目的地から経路までの旅行を仙人のノートに記入させるだけです。
    // 目的地を実際に使うのはこれが初めてであることに注意してください。
    var trip = [_]?TripItem{null} ** (place_count * 2);

    notebook.getTripTo(trip[0..], destination) catch |err| {
        print("Oh no! {}\n", .{err});
        return;
    };

    // 以下の小さなヘルパー関数でトリップを出力します。
    printTrip(trip[0..]);
}

// トリップは、目的地から出発地までの場所または経路を含む一連の TripItem 
// が交互に配置されることを忘れないでください。
// そのため、配列の先頭にある目的地に到達するまで、
// NULL 値をスキップしてアイテムを逆ループする必要があります。
// 
fn printTrip(trip: []?TripItem) void {
    // usizeの長さを@intCast()でu8に変換していますが、
    // これは@import()と同じようにビルトイン関数です。
    // これらについては、後の演習できちんと学びます。
    var i: u8 = @intCast(u8, trip.len);

    while (i > 0) {
        i -= 1;
        if (trip[i] == null) continue;
        trip[i].?.printMe();
    }

    print("\n", .{});
}

// もっと深く
//
// コンピュータサイエンスの用語では、マップの場所は「ノード」または「頂点」、
// パスは「エッジ」です。これらを合わせると、「重み付き有向グラフ」になる。
// 各パスは距離（「コスト」とも呼ばれる）を持つので、「重み付き」である。
// 各パスはある場所から別の場所へ行くので「有向」である
// （無向グラフではエッジ上をどちらの方向へも移動できる）。
//
//
// ノートブックの新しい項目をリストの最後に追加し、
// それぞれを最初から順番に探索するので（「todo」リストのように）、
// ノートブックを「先入れ先出し」（FIFO）キューとして扱っているのです。
// 
//
// 「todo」キューのおかげで、それ以上のパスを試す前に最も近いパスをすべて最初に調べるので、
// 「幅優先探索」（BFS）を行っていることになります。
// 
//
// 「最低コスト」の経路を追跡することで、「最小コスト探索」を
// 行っていると言うこともできる。
//
// さらに言えば、「仙人のノート」は、Edward F. Mooreの「最短経路高速化アルゴリズム（SPFA）」に
// 最もよく似ている。単純なFIFOキューを「優先キュー」に置き換えることで、
// 基本的にはダイクストラのアルゴリズムになります。
// 優先度待ち行列は、「重み」によってソートされた項目を検索します
// （この場合、最短距離を持つ経路を待ち行列の先頭に維持することになります）。
// ダイクストラのアルゴリズムは、より長い経路をより速く排除することができるので、
// より効率的です。(その理由は紙の上で考えてみてください!)

