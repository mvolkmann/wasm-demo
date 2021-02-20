pub fn sum(a: i32, b: i32) -> i32 {
    a + b
}

pub fn distance(x1: f64, y1: f64, x2: f64, y2: f64) -> f64 {
    ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt()
}

fn main() {
    println!("sum = {}", sum(19, 3));
    println!("distance = {}", distance(2.0, 3.0, 5.0, 7.0));
}
