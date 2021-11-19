; RUN: opt -indvars -S < %s
; XFAIL: *
; REQUIRES: asserts

@g = global i32 0

define i32 @single_case() {
  switch i32 -1, label %x [
  ]

x:                                                ; preds = %x, %0
  br i1 false, label %x, label %BB

BB:                                               ; preds = %x
  ret i32 0
}

define i32 @multiple_cases() {
  %B = or i32 -1, 0
  switch i32 %B, label %x [
    i32 1, label %one
    i32 2, label %two
  ]

x:                                                ; preds = %0
  ret i32 0

one:                                              ; preds = %0
  ret i32 1

two:                                              ; preds = %0
  ret i32 2
}
