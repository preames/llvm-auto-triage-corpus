; RUN: opt -gvn -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

define void @f(i1* %G2, i1 %L5) {
BB:
  %A1 = alloca i1, align 1
  %B = xor i1 true, false
  store i1 true, i1* %A1, align 1
  %G6 = getelementptr inbounds i1, i1* %A1, i1 %B
  br label %BB1

BB1:                                              ; preds = %BB5, %BB1, %BB
  %G1 = getelementptr i1, i1* %A1, i1 false
  %L51 = load i1, i1* %G1, align 1
  %G22 = getelementptr i1, i1* %G1, i1 %L51
  %B6 = ashr i1 false, false
  %L1 = load i1, i1* %G22, align 1
  %G5 = getelementptr i1, i1* %G1, i1 %B6
  %G3 = getelementptr i1, i1* %G2, i1 %L1
  store i1 true, i1* %G5, align 1
  br i1 undef, label %BB1, label %BB4

BB4:                                              ; preds = %BB7, %BB1
  %G = getelementptr i1, i1* %G1, i1 %B6
  %L8 = load i1, i1* %G, align 1
  %G13 = getelementptr i1, i1* %G, i1 %L8
  %L13 = load i1, i1* %G13, align 1
  %C15 = icmp ne i1 false, %L13
  br label %BB7

BB7:                                              ; preds = %BB4
  %G4 = getelementptr i1, i1* %G22, i1 %L5
  %G12 = getelementptr i1, i1* %G4, i1 undef
  store i1 false, i1* %G12, align 1
  br i1 false, label %BB4, label %BB5

BB5:                                              ; preds = %BB7
  br i1 false, label %BB1, label %BB2

BB2:                                              ; preds = %BB2, %BB5
  br label %BB2
}
