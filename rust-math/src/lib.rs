extern "C" {
    fn cube(n: f64) -> f64;
    fn square(n: f64) -> f64;
}

#[no_mangle]
pub fn sum(n1: f64, n2: f64) -> f64 {
    n1 + n2
}

#[no_mangle]
pub fn distance(x1: f64, y1: f64, x2: f64, y2: f64) -> f64 {
    ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt()
}

#[no_mangle]
pub fn sum_of_square_and_cube(n: f64) -> f64 {
    let result;
    unsafe {
        result = square(n) + cube(n);
    }
    result
}
