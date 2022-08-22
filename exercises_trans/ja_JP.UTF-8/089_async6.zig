//
// 複数のことを同時に行うとき、async/await の威力と目的がより明らかになる。
// FooとBarは互いに依存せず、同時に起こることができますが、
// Endでは両方が終了することが必要です。
//
//               +---------+
//               |  Start  |
//               +---------+
//                  /    \
//                 /      \
//        +---------+    +---------+
//        |   Foo   |    |   Bar   |
//        +---------+    +---------+
//                 \      /
//                  \    /
//               +---------+
//               |   End   |
//               +---------+
//
// これをZigで表現すると次のようになります。
//
//     fn foo() u32 { ... }
//     fn bar() u32 { ... }
//
//     // Start
//
//     var foo_frame = async foo();
//     var bar_frame = async bar();
//
//     var foo_value = await foo_frame;
//     var bar_value = await bar_frame;
//
//     // End
//
// ページタイトルは2つ待ってください。
//
const print = @import("std").debug.print;

pub fn main() void {
    var com_frame = async getPageTitle("http://example.com");
    var org_frame = async getPageTitle("http://example.org");

    var com_title = com_frame;
    var org_title = org_frame;

    print(".com: {s}, .org: {s}.\n", .{ com_title, org_title });
}

fn getPageTitle(url: []const u8) []const u8 {
    // これは実際にネットワークリクエストを行っていることを前提にしてください。
    _ = url;
    return "Example Title";
}
