; RUN: opt -indvars -S < %s
; XFAIL: *
; REQUIRES: asserts
target triple = "x86_64-unknown-linux-gnu"

define void @single_case() {
  switch i32 0, label %x [
  ]

x:                                                ; preds = %x, %0
  br label %x
}
