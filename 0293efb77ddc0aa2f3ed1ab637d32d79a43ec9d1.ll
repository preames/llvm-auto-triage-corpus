; RUN: opt -indvars -S < %s
; XFAIL: *
; REQUIRES: asserts
target triple = "x86_64-unknown-linux-gnu"

define void @single_case() {
  switch i32 -1, label %x [
  ]

x:                                                ; preds = %x, %0
  br i1 false, label %x, label %BB

BB:                                               ; preds = %x
  ret void
}
