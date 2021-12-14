; RUN: opt -loop-reduce < %s
; REQUIRE: asserts
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @e([0 x i8]* %c) {
entry:
  %0 = getelementptr inbounds [0 x i8], [0 x i8]* %c, i64 0, i64 0
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %1 = phi i8* [ %incdec.ptr, %while.cond ], [ %0, %entry ]
  %incdec.ptr = getelementptr inbounds i8, i8* %1, i64 1
  br i1 false, label %while.cond, label %while.cond2

while.cond2:                                      ; preds = %while.cond2, %while.cond
  %2 = phi i8* [ %incdec.ptr3, %while.cond2 ], [ %incdec.ptr, %while.cond ]
  %incdec.ptr3 = getelementptr inbounds i8, i8* %2, i64 1
  br i1 false, label %while.cond2, label %while.cond.1

while.cond.1:                                     ; preds = %while.cond.1, %while.cond2
  %3 = phi i8* [ %incdec.ptr.1, %while.cond.1 ], [ %incdec.ptr3, %while.cond2 ]
  %incdec.ptr.1 = getelementptr inbounds i8, i8* %3, i64 1
  br i1 false, label %while.cond.1, label %while.cond2.1

while.cond2.1:                                    ; preds = %while.cond2.1, %while.cond.1
  %4 = phi i8* [ %incdec.ptr3.1, %while.cond2.1 ], [ %incdec.ptr.1, %while.cond.1 ]
  %incdec.ptr3.1 = getelementptr inbounds i8, i8* %4, i64 1
  br i1 false, label %while.cond2.1, label %while.cond.2

while.cond.2:                                     ; preds = %while.cond.2, %while.cond2.1
  %5 = phi i8* [ %incdec.ptr.2, %while.cond.2 ], [ %incdec.ptr3.1, %while.cond2.1 ]
  %incdec.ptr.2 = getelementptr inbounds i8, i8* %5, i64 1
  br i1 false, label %while.cond.2, label %while.cond2.2

while.cond2.2:                                    ; preds = %while.cond2.2, %while.cond.2
  %6 = phi i8* [ %incdec.ptr3.2, %while.cond2.2 ], [ %incdec.ptr.2, %while.cond.2 ]
  %incdec.ptr3.2 = getelementptr inbounds i8, i8* %6, i64 1
  br i1 false, label %while.cond2.2, label %while.cond.3

while.cond.3:                                     ; preds = %while.cond.3, %while.cond2.2
  %7 = phi i8* [ %incdec.ptr.3, %while.cond.3 ], [ %incdec.ptr3.2, %while.cond2.2 ]
  %incdec.ptr.3 = getelementptr inbounds i8, i8* %7, i64 1
  br i1 false, label %while.cond.3, label %while.cond2.3

while.cond2.3:                                    ; preds = %while.cond2.3, %while.cond.3
  %8 = phi i8* [ %incdec.ptr3.3, %while.cond2.3 ], [ %incdec.ptr.3, %while.cond.3 ]
  %incdec.ptr3.3 = getelementptr inbounds i8, i8* %8, i64 1
  br i1 false, label %while.cond2.3, label %while.cond.4

while.cond.4:                                     ; preds = %while.cond.4, %while.cond2.3
  %9 = phi i8* [ %incdec.ptr.4, %while.cond.4 ], [ %incdec.ptr3.3, %while.cond2.3 ]
  %incdec.ptr.4 = getelementptr inbounds i8, i8* %9, i64 1
  br i1 false, label %while.cond.4, label %while.cond2.4

while.cond2.4:                                    ; preds = %while.cond2.4, %while.cond.4
  %10 = phi i8* [ %incdec.ptr3.4, %while.cond2.4 ], [ %incdec.ptr.4, %while.cond.4 ]
  %incdec.ptr3.4 = getelementptr inbounds i8, i8* %10, i64 1
  br i1 false, label %while.cond2.4, label %while.cond.5

while.cond.5:                                     ; preds = %while.cond.5, %while.cond2.4
  %11 = phi i8* [ %incdec.ptr.5, %while.cond.5 ], [ %incdec.ptr3.4, %while.cond2.4 ]
  %incdec.ptr.5 = getelementptr inbounds i8, i8* %11, i64 1
  br i1 false, label %while.cond.5, label %while.cond2.5

while.cond2.5:                                    ; preds = %while.cond2.5, %while.cond.5
  %12 = phi i8* [ %incdec.ptr3.5, %while.cond2.5 ], [ %incdec.ptr.5, %while.cond.5 ]
  %incdec.ptr3.5 = getelementptr inbounds i8, i8* %12, i64 1
  br i1 false, label %while.cond2.5, label %while.cond.6

while.cond.6:                                     ; preds = %while.cond.6, %while.cond2.5
  %13 = phi i8* [ %incdec.ptr.6, %while.cond.6 ], [ %incdec.ptr3.5, %while.cond2.5 ]
  %incdec.ptr.6 = getelementptr inbounds i8, i8* %13, i64 1
  br i1 false, label %while.cond.6, label %while.cond2.6

while.cond2.6:                                    ; preds = %while.cond2.6, %while.cond.6
  %14 = phi i8* [ %incdec.ptr3.6, %while.cond2.6 ], [ %incdec.ptr.6, %while.cond.6 ]
  %incdec.ptr3.6 = getelementptr inbounds i8, i8* %14, i64 1
  br i1 false, label %while.cond2.6, label %while.cond.7

while.cond.7:                                     ; preds = %while.cond.7, %while.cond2.6
  %15 = phi i8* [ %incdec.ptr.7, %while.cond.7 ], [ %incdec.ptr3.6, %while.cond2.6 ]
  %incdec.ptr.7 = getelementptr inbounds i8, i8* %15, i64 1
  br i1 false, label %while.cond.7, label %while.cond2.7

while.cond2.7:                                    ; preds = %while.cond2.7, %while.cond.7
  %16 = phi i8* [ %incdec.ptr3.7, %while.cond2.7 ], [ %incdec.ptr.7, %while.cond.7 ]
  %incdec.ptr3.7 = getelementptr inbounds i8, i8* %16, i64 1
  br i1 false, label %while.cond2.7, label %while.cond.8

while.cond.8:                                     ; preds = %while.cond.8, %while.cond2.7
  %17 = phi i8* [ %incdec.ptr.8, %while.cond.8 ], [ %incdec.ptr3.7, %while.cond2.7 ]
  %incdec.ptr.8 = getelementptr inbounds i8, i8* %17, i64 1
  br i1 false, label %while.cond.8, label %while.cond2.8

while.cond2.8:                                    ; preds = %while.cond2.8, %while.cond.8
  %18 = phi i8* [ %incdec.ptr3.8, %while.cond2.8 ], [ %incdec.ptr.8, %while.cond.8 ]
  %incdec.ptr3.8 = getelementptr inbounds i8, i8* %18, i64 1
  br i1 false, label %while.cond2.8, label %while.cond.9

while.cond.9:                                     ; preds = %while.cond.9, %while.cond2.8
  %19 = phi i8* [ %incdec.ptr.9, %while.cond.9 ], [ %incdec.ptr3.8, %while.cond2.8 ]
  %incdec.ptr.9 = getelementptr inbounds i8, i8* %19, i64 1
  br i1 false, label %while.cond.9, label %while.cond2.9

while.cond2.9:                                    ; preds = %while.cond2.9, %while.cond.9
  %20 = phi i8* [ %incdec.ptr3.9, %while.cond2.9 ], [ %incdec.ptr.9, %while.cond.9 ]
  %incdec.ptr3.9 = getelementptr inbounds i8, i8* %20, i64 1
  br i1 false, label %while.cond2.9, label %while.cond.10

while.cond.10:                                    ; preds = %while.cond.10, %while.cond2.9
  %21 = phi i8* [ %incdec.ptr.10, %while.cond.10 ], [ %incdec.ptr3.9, %while.cond2.9 ]
  %incdec.ptr.10 = getelementptr inbounds i8, i8* %21, i64 1
  br i1 false, label %while.cond.10, label %while.cond2.10

while.cond2.10:                                   ; preds = %while.cond2.10, %while.cond.10
  %22 = phi i8* [ %incdec.ptr3.10, %while.cond2.10 ], [ %incdec.ptr.10, %while.cond.10 ]
  %incdec.ptr3.10 = getelementptr inbounds i8, i8* %22, i64 1
  br i1 false, label %while.cond2.10, label %while.cond.11

while.cond.11:                                    ; preds = %while.cond.11, %while.cond2.10
  %23 = phi i8* [ %incdec.ptr.11, %while.cond.11 ], [ %incdec.ptr3.10, %while.cond2.10 ]
  %incdec.ptr.11 = getelementptr inbounds i8, i8* %23, i64 1
  br i1 false, label %while.cond.11, label %while.cond2.11

while.cond2.11:                                   ; preds = %while.cond2.11, %while.cond.11
  %24 = phi i8* [ %incdec.ptr3.11, %while.cond2.11 ], [ %incdec.ptr.11, %while.cond.11 ]
  %incdec.ptr3.11 = getelementptr inbounds i8, i8* %24, i64 1
  br i1 false, label %while.cond2.11, label %while.cond.12

while.cond.12:                                    ; preds = %while.cond.12, %while.cond2.11
  %25 = phi i8* [ %incdec.ptr.12, %while.cond.12 ], [ %incdec.ptr3.11, %while.cond2.11 ]
  %incdec.ptr.12 = getelementptr inbounds i8, i8* %25, i64 1
  br i1 false, label %while.cond.12, label %while.cond2.12

while.cond2.12:                                   ; preds = %while.cond2.12, %while.cond.12
  %26 = phi i8* [ %incdec.ptr3.12, %while.cond2.12 ], [ %incdec.ptr.12, %while.cond.12 ]
  %incdec.ptr3.12 = getelementptr inbounds i8, i8* %26, i64 1
  br i1 false, label %while.cond2.12, label %while.cond.13

while.cond.13:                                    ; preds = %while.cond.13, %while.cond2.12
  %27 = phi i8* [ %incdec.ptr.13, %while.cond.13 ], [ %incdec.ptr3.12, %while.cond2.12 ]
  %incdec.ptr.13 = getelementptr inbounds i8, i8* %27, i64 1
  br i1 false, label %while.cond.13, label %while.cond2.13

while.cond2.13:                                   ; preds = %while.cond2.13, %while.cond.13
  %28 = phi i8* [ %incdec.ptr3.13, %while.cond2.13 ], [ %incdec.ptr.13, %while.cond.13 ]
  %incdec.ptr3.13 = getelementptr inbounds i8, i8* %28, i64 1
  br i1 false, label %while.cond2.13, label %while.cond.14

while.cond.14:                                    ; preds = %while.cond.14, %while.cond2.13
  %29 = phi i8* [ %incdec.ptr.14, %while.cond.14 ], [ %incdec.ptr3.13, %while.cond2.13 ]
  %incdec.ptr.14 = getelementptr inbounds i8, i8* %29, i64 1
  br i1 false, label %while.cond.14, label %while.cond2.14

while.cond2.14:                                   ; preds = %while.cond2.14, %while.cond.14
  %30 = phi i8* [ %incdec.ptr3.14, %while.cond2.14 ], [ %incdec.ptr.14, %while.cond.14 ]
  %incdec.ptr3.14 = getelementptr inbounds i8, i8* %30, i64 1
  br i1 false, label %while.cond2.14, label %while.cond.15

while.cond.15:                                    ; preds = %while.cond.15, %while.cond2.14
  %31 = phi i8* [ %incdec.ptr.15, %while.cond.15 ], [ %incdec.ptr3.14, %while.cond2.14 ]
  %incdec.ptr.15 = getelementptr inbounds i8, i8* %31, i64 1
  br i1 false, label %while.cond.15, label %while.cond2.15

while.cond2.15:                                   ; preds = %while.cond2.15, %while.cond.15
  %32 = phi i8* [ %incdec.ptr3.15, %while.cond2.15 ], [ %incdec.ptr.15, %while.cond.15 ]
  %incdec.ptr3.15 = getelementptr inbounds i8, i8* %32, i64 1
  br i1 false, label %while.cond2.15, label %while.cond.16

while.cond.16:                                    ; preds = %while.cond.16, %while.cond2.15
  %33 = phi i8* [ %incdec.ptr.16, %while.cond.16 ], [ %incdec.ptr3.15, %while.cond2.15 ]
  %incdec.ptr.16 = getelementptr inbounds i8, i8* %33, i64 1
  %34 = load i8, i8* %incdec.ptr.16, align 1
  br label %while.cond.16
}
