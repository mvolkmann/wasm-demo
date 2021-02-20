# wasm-demo

This is a simple demonstration of using WebAssembly from a web app.
To build and run this:

1. Install [WebAssembly Binary Toolkit (WABT)](https://github.com/WebAssembly/wabt).
   This includes a set of command line tools including
   wat2wasm, wasm2wat, wasm-validate, and wasm-interp.
   In macOS this can be installed using Homebrew
   by entering `brew install wabt`.

1. Enter `wat2wasm` to create the binary file `math.wasm`
   from the text file `math.wat`.

1. Start a local HTTP file server.
   One approach is to install [Deno](https://deno.land/)
   and enter these commands:

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
   ```

1. Enter `cargo build --target wasm32-wasi`

1. What else? See the link above.
