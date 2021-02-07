//
// Oops! This program is supposed to print a line like our Hello World
// example. But we forgot how to import the Zig Standard Library.
//
// The @import() function is built into Zig. It returns a value which
// represents the imported code. It's a good idea to store the import as
// a constant value with the same name as the import:
//
//     const foo = @import("foo");
//
// Please complete the import below:
//

??? = @import("std");

pub fn main() void {
    std.debug.print("Standard Library.\n", .{});
}

// Going deeper: imports must be declared as "constants" (with the 'const'
// keyword rather than "variables" (with the 'var' keyword) is that they
// can only be used at "compile time" rather than "run time". Zig evaluates
// const values at compile time. Don't worry if none of this makes sense
// yet! See also this answer: https://stackoverflow.com/a/62567550/695615
