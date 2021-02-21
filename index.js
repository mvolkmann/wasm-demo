//const wasmPath = 'math.wasm';
const wasmPath = 'rust-math/target/wasm32-unknown-unknown/debug/rust_math.wasm';
WebAssembly.instantiateStreaming(fetch(wasmPath)).then(m => {
  const {distance, distance2, distance3, sum} = m.instance.exports;
  document.getElementById('sum').textContent = sum(19, 3);
  document.getElementById('distance').textContent = distance(2, 3, 5, 7);
  console.log('distance1 =', distance(2, 3, 5, 7));
  console.log('distance2 =', distance2(2, 3, 5, 7));
  console.log('distance3 =', distance3(2, 3, 5, 7));
});
