(module
  (type (;0;) (func (param f64 f64) (result f64)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (type (;3;) (func (param f64 f64 f64 f64) (result f64)))
  (func (;0;) (type 0) (param f64 f64) (result f64)
    local.get 0
    local.get 1
    f64.add
    f64.const 0x1p+1 (;=2;)
    f64.div)
  (func (;1;) (type 0) (param f64 f64) (result f64)
    local.get 0
    local.tee 0
    local.get 0
    f64.mul
    local.get 1
    local.tee 1
    local.get 1
    f64.mul
    call 0)
  (func (;2;) (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.gt_s)
  (func (;3;) (type 1) (param i32 i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 3
    i32.const 1
    local.set 2
    block  ;; label = @1
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.eq
        br_if 1 (;@1;)
        local.get 2
        local.get 0
        i32.mul
        local.set 2
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        br 0 (;@2;)
      end
    end
    local.get 2)
  (func (;4;) (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.gt_s
    if (result i32)  ;; label = @1
      local.get 0
    else
      local.get 1
    end)
  (func (;5;) (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    select)
  (func (;6;) (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func (;7;) (type 3) (param f64 f64 f64 f64) (result f64)
    local.get 0
    local.get 2
    f64.sub
    local.tee 0
    local.get 0
    f64.mul
    local.get 1
    local.get 3
    f64.sub
    local.tee 1
    local.get 1
    f64.mul
    f64.add
    f64.sqrt)
  (func (;8;) (type 3) (param f64 f64 f64 f64) (result f64)
    (local f64 f64)
    local.get 0
    local.get 2
    f64.sub
    local.set 4
    local.get 1
    local.get 3
    f64.sub
    local.set 5
    local.get 4
    local.get 4
    f64.mul
    local.get 5
    local.get 5
    f64.mul
    f64.add
    f64.sqrt)
  (func (;9;) (type 3) (param f64 f64 f64 f64) (result f64)
    local.get 0
    local.get 2
    f64.sub
    local.tee 0
    local.get 0
    f64.mul
    local.get 1
    local.get 3
    f64.sub
    local.tee 1
    local.get 1
    f64.mul
    f64.add
    f64.sqrt)
  (export "avg" (func 0))
  (export "avgOfSquares" (func 1))
  (export "gt" (func 2))
  (export "loop" (func 3))
  (export "max" (func 4))
  (export "select" (func 5))
  (export "sum" (func 6))
  (export "distance" (func 7))
  (export "distance2" (func 8))
  (export "distance3" (func 9)))
