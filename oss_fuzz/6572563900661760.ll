; RUN: llc -O2 < %s
; XFAIL: *

; ModuleID = '<stdin>'
source_filename = "M"

define void @f() {
BB:
  %A8 = alloca i32, align 4
  %A = alloca i1, i32 2147483647, align 1
  %G = getelementptr i1, i1* %A, i16 32767
  store i32* %A8, i32** undef, align 8
  br label %BB8

BB8:                                              ; preds = %BB7, %BB12, %BB17, %BB8, %BB
  %A9 = alloca i1, align 1
  %L4 = load i1, i1* %A9, align 1
  br i1 %L4, label %BB8, label %BB17

BB17:                                             ; preds = %BB8
  br i1 %L4, label %BB8, label %BB12

BB12:                                             ; preds = %BB17
  %L1 = load i1, i1* %A9, align 1
  br i1 %L1, label %BB8, label %BB10

BB10:                                             ; preds = %BB12
  %G3 = getelementptr i1, i1* %A9, i1 true
  %L5 = load i1, i1* %G3, align 1
  store i1 %L5, i1* %G3, align 1
  br label %BB5

BB5:                                              ; preds = %BB15, %BB16, %BB5, %BB10
  store i1 false, i1* undef, align 1
  br i1 false, label %BB5, label %BB9

BB9:                                              ; preds = %BB9, %BB5
  br i1 false, label %BB9, label %BB16

BB16:                                             ; preds = %BB9
  store i1 false, i1* %G, align 1
  br i1 false, label %BB5, label %BB7

BB7:                                              ; preds = %BB7, %BB16
  store i1* %G3, i1** undef, align 8
  br i1 false, label %BB7, label %BB8

BB11:                                             ; preds = %BB11
  br i1 true, label %BB11, label %BB15

BB15:                                             ; preds = %BB11
  store i1 false, i1* undef, align 1
  br i1 false, label %BB5, label %BB6

BB6:                                              ; preds = %BB15
  br label %BB1

BB1:                                              ; preds = %BB3, %BB1, %BB6
  br i1 false, label %BB1, label %BB3

BB3:                                              ; preds = %BB1
  %B13 = sdiv i64 4294967296, 4294967296
  store i64 %B13, i64* undef, align 4
  br i1 false, label %BB1, label %BB2

BB2:                                              ; preds = %BB13, %BB2, %BB3
  br i1 true, label %BB2, label %BB13

BB13:                                             ; preds = %BB2
  br i1 true, label %BB2, label %BB4

BB4:                                              ; preds = %BB4, %BB13
  %C10 = icmp ugt i8 16, 16
  br i1 %C10, label %BB4, label %BB14

BB14:                                             ; preds = %BB4
  ret void
}
