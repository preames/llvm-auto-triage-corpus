; RUN: opt -licm -S < %s
; XFAIL: *
; REQUIRES: asserts

define i177 @test1(i177 %X) {
  ret i177 95780971304118053647396689196894323976171195136475135
}

define <2 x i177> @test2(<2 x i177> %X) {
  br label %BB

BB:                                               ; preds = %BB, %0
  %I3 = insertelement <2 x i177> undef, i177 95780971304118053647396689196894323976171195136475135, i177 95780971304118053647396689196894323976171195136475135
  br i1 true, label %BB, label %BB1

BB1:                                              ; preds = %BB1, %BB
  br i1 true, label %BB1, label %BB2

BB2:                                              ; preds = %BB1
  ret <2 x i177> %I3
}

define <2 x i177> @test3(<2 x i177> %X) {
  br label %BB

BB:                                               ; preds = %BB2, %BB3, %BB, %0
  br i1 false, label %BB, label %BB3

BB3:                                              ; preds = %BB
  br i1 true, label %BB, label %BB2

BB2:                                              ; preds = %BB3
  br i1 true, label %BB, label %BB1

BB1:                                              ; preds = %BB2
  ret <2 x i177> undef
}
