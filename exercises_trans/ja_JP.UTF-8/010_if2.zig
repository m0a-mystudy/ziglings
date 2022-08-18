//
//  If文も有効な式です。
//
//     var foo: u8 = if (a) 2 else 3;
//
const std = @import("std");

pub fn main() void {
    var discount = true;

    // "価格 "を設定するには、if...else式を使用してください。
    // discountがtrueの場合は$17、そうでない場合は$20にします
    var price: u8 = if ???;

    std.debug.print("With the discount, the price is ${}.\n", .{price});
}
