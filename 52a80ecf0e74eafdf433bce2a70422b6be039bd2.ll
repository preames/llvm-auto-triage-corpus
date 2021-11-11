; RUN: llc -O2 < %s
; XFAIL: *

define void @f() {
BB:
  %A8 = alloca i32, i32 0, align 4
  %A = alloca i1, i32 2147483647, align 1
  %G = getelementptr i1, i1* %A, i16 32767
  store i32* %A8, i32** null, align 8
  br label %BB8

BB8:                                              ; preds = %BB12, %BB17, %BB8, %BB
  %A9 = alloca i1, i32 0, align 1
  br i1 undef, label %BB8, label %BB17

BB17:                                             ; preds = %BB8
  br i1 false, label %BB8, label %BB12

BB12:                                             ; preds = %BB17
  br i1 false, label %BB8, label %BB10

BB10:                                             ; preds = %BB12
  br label %BB5

BB5:                                              ; preds = %BB16, %BB5, %BB10
  br i1 false, label %BB5, label %BB9

BB9:                                              ; preds = %BB9, %BB5
  br i1 false, label %BB9, label %BB16

BB16:                                             ; preds = %BB9
  store i1 false, i1* %G, align 1
  br label %BB5
}
