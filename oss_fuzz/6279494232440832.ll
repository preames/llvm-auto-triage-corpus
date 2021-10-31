; RUN: opt -early-cse -S < %s
; XFAIL: *
; ModuleID = '/home/preames/Downloads/clusterfuzz-testcase-minimized-llvm-opt-fuzzer--x86_64-earlycse-6279494232440832'
source_filename = "llvm/test/Transforms/GVN/PRE/invariant-load.ll"

define i32 @test1(i32* nocapture %p, i8* nocapture %q) {
entry:
  ret i32 2147483647
}

define i32 @test2(i32* nocapture %p, i8* nocapture %q) {
entry:
  ret i32 -1
}

define i32 @test3(i1 %cnd, i32* %p, i32* %q) {
entry:
  br i1 %cnd, label %bb1, label %bb2

bb1:                                              ; preds = %entry
  br label %bb2

bb2:                                              ; preds = %bb1, %entry
  ret i32 -1
}

define i32 @test4(i1 %cnd, i32* %p, i32* %q) {
entry:
  br i1 %cnd, label %bb1, label %bb2

bb1:                                              ; preds = %entry
  br label %bb2

bb2:                                              ; preds = %bb1, %entry
  %v2 = load i32, i32* %p, align 4
  ret i32 %v2
}

define i32 @test5(i1 %cnd, i32* %p) {
entry:
  ret i32 -2147483648
}

declare void @foo()

define i32 @test6(i1 %cnd, i32* %p) {
entry:
  ret i32 2147483647
}

declare noalias i32* @bar(...)

define i32 @test7(i1 %cnd, i32* %p) {
entry:
  %v2 = load i32, i32* undef, align 4, !invariant.load !0
  store i32* undef, i32** undef, align 8
  store i32 %v2, i32* undef, align 4
  ret i32 %v2
}

define i32 @test8(i1 %cnd, i32* %p) {
entry:
  br i1 false, label %taken, label %merge

taken:                                            ; preds = %entry
  br label %merge

merge:                                            ; preds = %taken, %entry
  ret i32 0
}

!0 = !{}
