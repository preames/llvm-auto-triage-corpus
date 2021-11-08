; RUN: opt -early-cse -S < %s
; XFAIL: *

define void @test7() {
entry:
  %v2 = load i32, i32* undef, align 4, !invariant.load !0
  store i32* null, i32** null, align 8
  store i32 %v2, i32* undef, align 4
  ret void
}

!0 = !{}
