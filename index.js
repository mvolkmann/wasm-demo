WebAssembly.instantiateStreaming(fetch('math.wasm')).then(m => {
  const sum = m.instance.exports.add(19, 3);
  console.log('sum =', sum);
  document.getElementById('sum').textContent = sum;

  const distance = m.instance.exports.distance3(1, 2, 4, 6);
  console.log('distance =', distance);
  document.getElementById('distance').textContent = distance;
});
