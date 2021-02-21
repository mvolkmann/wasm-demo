(module
  (func $sum (param $lhs i32) (param $rhs i32) (result i32)
    local.get $lhs
    local.get $rhs
    i32.add
  )
  (export "sum" (func $sum))

  ;; This uses the "linear" format.
  (func $distance
    (param $x1 f64)
    (param $y1 f64)
    (param $x2 f64)
    (param $y2 f64)
    (result f64)

    get_local $x1
    get_local $x2
    f64.sub
    tee_local $x1 ;; reusing $x1 to hold temporary dx value
    get_local $x1
    f64.mul

    get_local $y1
    get_local $y2
    f64.sub
    tee_local $y1 ;; reusing $y1 to hold temporary dy value
    get_local $y1
    f64.mul

    f64.add
    f64.sqrt
  )
  (export "distance" (func $distance))

  ;; This uses S-expressions.
  (func $distance2
    (param $x1 f64)
    (param $y1 f64)
    (param $x2 f64)
    (param $y2 f64)
    (result f64)

    (local $dx f64)
    (local $dy f64)

    (set_local $dx
      (f64.sub
        (local.get $x1)
        (local.get $x2)
      )
    )
    (set_local $dy
      (f64.sub
        (local.get $y1)
        (local.get $y2)
      )
    )

    (f64.sqrt
      (f64.add
        (f64.mul
          ;; There is no instruction to duplicate the value at
          ;; the top of the stack, so we have to do this twice.
          ;; See https://github.com/WebAssembly/design/issues/1365.
          (get_local $dx)
          (get_local $dx)
        )
        (f64.mul
          (get_local $dy)
          (get_local $dy)
        )
      )
    )
  )
  (export "distance2" (func $distance2))

  ;; This uses even more S-expressions.
  (func $distance3
    (param $x1 f64)
    (param $y1 f64)
    (param $x2 f64)
    (param $y2 f64)
    (result f64)

    (f64.sqrt
      (f64.add
        (f64.mul
          (tee_local $x1 ;; reusing $x1 to hold temporary dx value
            (f64.sub
              (get_local $x1)
              (get_local $x2)
            )
          )
          (get_local $x1)
        )
        (f64.mul
          (tee_local $y1 ;; reusing $y1 to hold temporary dy value
            (f64.sub
              (get_local $y1)
              (get_local $y2)
            )
          )
          (get_local $y1)
        )
      )
    )
  )
  (export "distance3" (func $distance3))
)
