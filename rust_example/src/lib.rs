#[no_mangle]
extern "C" fn sum(a: i32, b: i32) -> i32 {
    let s = a + b;
    println!("From WASM: Sum is: {:?}", s);
    s
}