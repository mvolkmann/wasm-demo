(module
  (global $favorite (mut i32) (i32.const 19))

  (func $average (param $n1 f64) (param $n2 f64) (result f64)
    local.get $n1
    local.get $n2
    f64.add
    f64.const 2
    f64.div
  )
  (export "avg" (func $average))

  (func $avg_of_squares (param $n1 f64) (param $n2 f64) (result f64)
    local.get $n1
    local.tee $n1
    local.get $n1
    f64.mul

    local.get $n2
    local.tee $n2
    local.get $n2
    f64.mul

    call $average
  )
  (export "avgOfSquares" (func $avg_of_squares))

  (func $fav_squared (result i32)
    (global.set $favorite (i32.sub (global.get $favorite) (i32.const 2)))
    (global.get $favorite)
    (global.get $favorite)
    (i32.mul)
  )
  (export "favSqr" (func $fav_squared))

  (func $gt (param $n1 i32) (param $n2 i32) (result i32)
    ;; Returns 0 (false) or 1 (true).
    (i32.gt_s (local.get $n1) (local.get $n2))
  )
  (export "gt" (func $gt))

  (func $loop_demo (param $n i32) (param $times i32) (result i32)
    ;;TODO: Can you declare and initialize a local variable in one line?
    (local $counter i32)
    (local $product i32)

    (local.set $counter (i32.const 0))
    (local.set $product (i32.const 1))

    (block
      ;; loop creates its own block.
      (loop $top
        ;; Break out of the lop if $counter equals $times.
        (br_if 1 (i32.eq (local.get $counter) (local.get $times)))

        ;; Multiply $product by $n.
        (local.set $product (i32.mul (local.get $product) (local.get $n)))

        ;; Increment $counter.
        (local.set $counter (i32.add (local.get $counter) (i32.const 1)))

        ;; Go to top of loop.
        (br 0)
      )
    )

    (local.get $product)
  )
  (export "loop" (func $loop_demo))

  (func $max (param $n1 i32) (param $n2 i32) (result i32)
    (if (result i32) (i32.gt_s (local.get $n1) (local.get $n2))
      (then (local.get $n1))
      (else (local.get $n2))
    )
  )
  (export "max" (func $max))

  (func $select(param $n1 i32) (param $n2 i32) (param $n3 i32) (result i32)
    ;; The select instruction is similar to a ternary operator.
    (select
     (local.get $n1) ;; selects this if $n3 is not zero
     (local.get $n2) ;; selects this if $n3 is zero
     (local.get $n3)
     ;; The third argument can be the result of a comparison function
     ;; which returns 0 or 1.
     ;;(i32.gt_s (local.get $n1) (local.get $n2))
    )
  )
  (export "select" (func $select))

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

    local.get $x1
    local.get $x2
    f64.sub
    local.tee $x1 ;; reusing $x1 to hold temporary dx value
    local.get $x1
    f64.mul

    local.get $y1
    local.get $y2
    f64.sub
    local.tee $y1 ;; reusing $y1 to hold temporary dy value
    local.get $y1
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

    (local.set $dx
      (f64.sub
        (local.get $x1)
        (local.get $x2)
      )
    )
    (local.set $dy
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
          (local.get $dx)
          (local.get $dx)
        )
        (f64.mul
          (local.get $dy)
          (local.get $dy)
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
          (local.tee $x1 ;; reusing $x1 to hold temporary dx value
            (f64.sub
              (local.get $x1)
              (local.get $x2)
            )
          )
          (local.get $x1)
        )
        (f64.mul
          (local.tee $y1 ;; reusing $y1 to hold temporary dy value
            (f64.sub
              (local.get $y1)
              (local.get $y2)
            )
          )
          (local.get $y1)
        )
      )
    )
  )
  (export "distance3" (func $distance3))

  ;; Note that rather than specifying a function name,
  ;; the export is done inline.
  ;; Without a name, it cannot be called by name by other WASM functions.
  (func (export "switchLike") (param $p i32) (result i32)
    (block
      (block
        (block
          (block
            ;; br takes a literal number, not a value from the stack.
            ;; It jumps out of the block at a given nesting level
            ;; from the current nesting level.
            ;;(br 2)

            ;; br_table uses the value on the top of the stack
            ;; to select an argument value that is used in a br.
            (local.get $p)
            ;; The top stack value is used to select an argument
            ;; that specifies the number of blocks to break out of.
            (br_table
              2   ;; p == 0 => same as (br 2)
              1   ;; p == 1 => same as (br 1)
              0   ;; p == 2 => same as (br 0)
              3)  ;; else same as (br 3)

          )
          ;; Target for (br 0)
          (return (i32.const 100))
        )
        ;; Target for (br 1)
        (return (i32.const 101))
      )
      ;; Target for (br 2)
      (return (i32.const 102))
    )
    ;; Target for (br 3)
    (return (i32.const 103))
  )
)
