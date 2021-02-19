# wasm-demo

This is a simple demonstration of using WebAssembly from a web app.
To build and run this:

1. Install [WebAssembly Binary Toolkit (WABT)](https://github.com/WebAssembly/wabt).
   This includes a set of command line tools including
   wat2wasm, wasm2wat, wasm-validate, and wasm-interp.
   In macOS this can be installed using Homebrew
   by entering `brew install wabt`.

1. Enter `wat2wasm` to create the binary file `add.wasm`
   from the text file `add.wat`.

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
