; RUN: opt -instcombine -S < %s
; XFAIL: *
; REQUIRES: asserts
target triple = "x86_64-unknown-linux-gnu"

define void @gep_alloca_inbounds_vscale_nonzero() {
  %a = alloca <vscale x 4 x i32>, i32 0, align 16
  %G = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %a, i1 true
  store <vscale x 4 x i32>* %G, <vscale x 4 x i32>** null, align 8
  ret void
}
