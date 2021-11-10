; RUN: opt -gvn -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

define void @f() {
BB:
  %C17 = icmp uge i16 -1, 0
  %A1 = alloca i1, align 1
  %B = xor i1 true, false
  store i1 %C17, i1* %A1, align 1
  %G6 = getelementptr inbounds i1, i1* %A1, i1 %B
  br label %BB1

BB1:                                              ; preds = %BB5, %BB1, %BB
  %C8 = icmp ule i1 true, true
  %C5 = icmp eq i1 %C8, %C8
  %G1 = getelementptr i1, i1* %A1, i1 false
  %L5 = load i1, i1* %G1, align 1
  %G2 = getelementptr i1, i1* %G1, i1 %L5
  %B6 = ashr i1 false, false
  %L1 = load i1, i1* %G2, align 1
  %G5 = getelementptr i1, i1* %G1, i1 %B6
  %G3 = getelementptr i1, i1* %G2, i1 %L1
  store i1 %C5, i1* %G5, align 1
  br i1 undef, label %BB1, label %BB4

BB4:                                              ; preds = %BB4, %BB1
  %G = getelementptr i1, i1* %G1, i1 %B6
  %L8 = load i1, i1* %G, align 1
  %G13 = getelementptr i1, i1* %G, i1 %L8
  %L13 = load i1, i1* %G13, align 1
  %L10 = load i1, i1* %G, align 1
  %C22 = icmp uge i1 undef, %L13
  %G4 = getelementptr i1, i1* %G2, i1 %L5
  %G12 = getelementptr i1, i1* %G4, i1 %L10
  store i1 undef, i1* %G12, align 1
  br i1 undef, label %BB4, label %BB5

BB5:                                              ; preds = %BB4
  br i1 false, label %BB1, label %BB2

BB2:                                              ; preds = %BB2, %BB5
  br label %BB2
}
