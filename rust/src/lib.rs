use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    fn alert(s: &str);

    // See https://rustwasm.github.io/docs/wasm-bindgen/examples/console-log.html

    // Use `js_namespace` here to bind `console.log(..)`
    // instead of just `log(..)`
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);

    // `console.log` is polymorphic, so we can bind it with multiple signatures.
    // Note that we need to use `js_name` to ensure we always call `log` in JS.
    #[wasm_bindgen(js_namespace = console, js_name = log)]
    fn log_u32(a: u32);

    // Multiple arguments too!
    #[wasm_bindgen(js_namespace = console, js_name = log)]
    fn log_many(a: &str, b: &str);
}

// Define a macro that's like `println!`, only it works for `console.log`.
// `println!` doesn't work on the wasm target because
// the standard library currently just eats all output.
// To get `println!`-like behavior, you'll likely want a macro like this.
macro_rules! console_log {
    // This is using the `log` function imported above.
    ($($t:tt)*) => (log(&format_args!($($t)*).to_string()))
}

#[wasm_bindgen]
pub fn greet() {
    log("Hello from Rust!");
    log_u32(42);
    log_many("Logging", "many values!");

    console_log!("Hello {}!", "world");
    console_log!("Let's print some numbers...");
    console_log!("1 + 3 = {}", 1 + 3);

    // We don't even have to define the `log` function
    // because the `web_sys` crate already does.
    //use web_sys::console;
    //console::log_1(&"Hello using web-sys".into());

    alert("Hello, rust-math!");
}

#[wasm_bindgen]
pub fn sum(a: i32, b: i32) -> i32 {
    let s = a + b;
    println!("From WASM: Sum is: {:?}", s);
    s
}

#[wasm_bindgen]
pub fn distance(x1: f64, y1: f64, x2: f64, y2: f64) -> f64 {
    ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt()
}
