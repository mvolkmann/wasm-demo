#[no_mangle]
pub fn sum(n1: f64, n2: f64) -> f64 {
    n1 + n2
}

#[no_mangle]
pub fn distance(x1: f64, y1: f64, x2: f64, y2: f64) -> f64 {
    ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt()
}
