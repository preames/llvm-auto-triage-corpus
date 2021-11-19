; RUN: opt -indvars -S < %s
; XFAIL: *
; REQUIRES: asserts

define i32 @single_case() {
  switch i32 0, label %x [
  ]

x:                                                ; preds = %x, %0
  br label %x
}
