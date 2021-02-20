# wasm-demo

This is a simple demonstration of using WebAssembly from a web app.
To build and run this:

1. Install [WebAssembly Binary Toolkit (WABT)](https://github.com/WebAssembly/wabt).
   This includes a set of command line tools including
   `wat2wasm`, `wasm2wat`, `wasm-validate`, and `wasm-interp`.
   In macOS this can be installed using Homebrew
   by entering `brew install wabt`.

1. Enter `wat2wasm` to create the binary file `math.wasm`
   from the text file `math.wat`.

1. Start a local HTTP file server.
   One approach is to install [Deno](https://deno.land/)
   and then enter these commands:

   ```bash
   deno install --allow-net --allow-read https://deno.land/std@0.87.0/http/file_server.ts
   file_server .
   ```

1. Browse localhost:{port} where port
   is the port on which the local server is listening.

See this [wat2wasm issue](https://github.com/WebAssembly/wabt/issues/1611).

WASM code can be run outside of a web browser as described here:
<https://alexene.dev/2020/08/17/webassembly-without-the-browser-part-1.html>.
Here are the steps to create a Rust project
that can be compiled to WASM and run outside a browser:

1. Enter `cargo new --lib rust_example`

1. `cd rust_example`

1. Edit `Cargo.toml` and add the following:

   ```toml
   [lib]
   crate-type = ["cdylib"]
   ```

1. Change the content of `src/lib.rs` to the following:

   ```rs
   #[no_mangle]
   extern "C" fn sum(a: i32, b: i32) -> i32 {
       let s = a + b;
       println!("From WASM: Sum is: {:?}", s);
       s
   }

   #[no_mangle]
   extern "C" fn distance(x1: f64, y1: f64, x2: f64, y2: f64) -> f64 {
       ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt()
   }
   ```

1. Enter `cargo build --target wasm32-wasi`

1. What else? See the link above.

```

```

## Using Rust version with wasm-pack

THIS DOES NOT WORK YET!

1. Create a `Cargo.toml` file:

   ```toml
   [package]
   name = "rust-math"
   version = "0.1.0"
   authors = ["R. Mark Volkmann <r.mark.volkmann@gmail.com>"]
   edition = "2018"

   [lib]
   crate-type = ["cdylib"]

   [dependencies]
   wasm-bindgen = "0.2.70"
   web-sys = "0.3.47"
   ```

1. Create a src/lib.rs file:

   ```rs
   use wasm_bindgen::prelude::*;

   // Optional section
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

   // Optional section
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
   ```

1. Create `index.html`:

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <script src="index.js"></script>
       <script type="module">
         import init, {distance, sum} from './rust-math/pkg/rust_math.js';

         async function run() {
           await init();
           document.getElementById('sum').textContent = sum(1, 2);
           document.getElementById('distance').textContent = distance(
             2,
             3,
             5,
             7
           );
         }

         run();
       </script>
     </head>
     <body>
       <div>sum = <span id="sum"></span></div>
       <div>distance = <span id="distance"></span></div>
     </body>
   </html>
   ```

1. Install wasm-pack by entering the following command:

   ```bash
   curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
   ```

1. Enter `wasm-pack build --target web`

1. Start a local HTTP file server.

1. Browse localhost:{port}

1. See output in the DevTools console.
