WebAssembly.instantiateStreaming(fetch('add.wasm')).then(m => {
  const sum = m.instance.exports.add(19, 3);
  console.log('sum =', sum);
  document.getElementById('result').textContent = sum;
});
