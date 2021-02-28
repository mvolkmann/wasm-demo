function cube(n) {
  return n ** 3;
}

function square(n) {
  return n * n;
}

const importObject = {env: {cube, square}};

const wasmPath = 'math.wasm';
//const wasmPath = 'rust-math/target/wasm32-unknown-unknown/debug/rust_math.wasm';
WebAssembly.instantiateStreaming(fetch(wasmPath), importObject).then(m => {
  const {
    avg,
    avgOfSquares,
    distance,
    distance2,
    distance3,
    favSqr,
    gt,
    loop,
    max,
    select,
    sum,
    sum_of_square_and_cube,
    switchLike
  } = m.instance.exports;

  document.getElementById('sum').textContent = sum(19, 3);

  document.getElementById('distance').textContent = distance(2, 3, 5, 7);
  //console.log('distance1 =', distance(2, 3, 5, 7));
  //console.log('distance2 =', distance2(2, 3, 5, 7));
  //console.log('distance3 =', distance3(2, 3, 5, 7));

  //console.log('**2 + **3 =', sum_of_square_and_cube(2));

  console.log('max =', max(5, 7));
  console.log('max =', max(7, 5));

  console.log('select =', select(1, 2, 3));
  console.log('select =', select(5, 2, 0));

  console.log('gt =', gt(5, 2));
  console.log('gt =', gt(2, 5));
  console.log('gt =', gt(2, 2));

  for (let exponent = 0; exponent < 5; exponent++) {
    console.log('loop with export', exponent, 'gives', loop(5, exponent));
  }

  console.log('avg =', avg(3, 8));
  console.log('avg of squares =', avgOfSquares(3, 5));

  console.log('switch 0 =', switchLike(0));
  console.log('switch 1 =', switchLike(1));
  console.log('switch 2 =', switchLike(2));
  console.log('switch 19 =', switchLike(19));

  console.log('favorite squared =', favSqr());
});
