//
// 無名構造体値LITERAL（構造体TYPEと混同しないように）には、
// '.{}'構文が使用されます。
//
//     .{
//          .center_x = 15,
//          .center_y = 12,
//          .radius = 6,
//     }
//
// これらのリテラルは常にコンパイル時に完全に評価されます。
// 上記の例は、前回の演習で使用した「円構造体」の 
// i32 変形に強制することができます。
//
// この例のように、完全に匿名にしておくこともできます。
//
//
//     fn bar(foo: anytype) void {
//         print("a:{} b:{}\n", .{foo.a, foo.b});
//     }
//
//     bar(.{
//         .a = true,
//         .b = false,
//     });
//
// 上の例では、「a:true b:false」と表示されます。
//
const print = @import("std").debug.print;

pub fn main() void {
    printCircle(.{
        .center_x = @as(u32, 205),
        .center_y = @as(u32, 187),
        .radius = @as(u32, 12),
    });
}

// 円を表す匿名構造体を表示するこの関数を完成させてください。
//
fn printCircle(???) void {
    print("x:{} y:{} radius:{}\n", .{
        circle.center_x,
        circle.center_y,
        circle.radius,
    });
}
