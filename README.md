# wasm-demo

This is a simple demonstration of using WebAssembly (WASM).

## Manually coding WebAssembly

See the files `math.wat` and `wat.html`.

To build and run this:

1. Install [WebAssembly Binary Toolkit (WABT)](https://github.com/WebAssembly/wabt).
   This includes a set of command line tools including
   `wat2wasm`, `wasm2wat`, `wasm-validate`, and `wasm-interp`.
   In macOS this can be installed using Homebrew
   by entering `brew install wabt`.

1. Enter `wat2wasm math.wat` to create the binary file `math.wasm`
   from the text file `math.wat`.

1. Start a local HTTP file server.
   One approach is to install [Deno](https://deno.land/)
   and then enter these commands:

   ```bash
   deno install --allow-net --allow-read https://deno.land/std@0.87.0/http/file_server.ts
   file_server .
   ```

1. Browse localhost:{port}/wat.html where port is
   the port on which the local server is listening.

See this [wat2wasm issue](https://github.com/WebAssembly/wabt/issues/1611).

## Converting Rust to WASM

See the files `rust/Cargo.toml`, `rust/src/lib.rs` and `rust.html`.

To build and run this:

1. Install wasm-pack by entering the following command:

   ```bash
   curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
   ```

1. `cd rust`

1. Enter `wasm-pack build --target web`

1. Start a local HTTP file server as described earlier.

1. Browse localhost:{port}/rust.html where port is
   the port on which the local server is listening.

## Running outside a web browser

WASM code can be run outside of a web browser.
To try this:

1. Enter `rustup target add wasm32-wasi`.
1. Enter `cargo new demo`
1. Enter `cd demo`
1. Enter `cargo build --target wasm32-wasi`
1. Install the Wasmtime CLI by entering
   `curl https://wasmtime.dev/install.sh -sSf | bash`
1. Open a new terminal.
1. Run the program by entering
   `wasmtime target/wasm32-wasi/debug/demo.wasm`
