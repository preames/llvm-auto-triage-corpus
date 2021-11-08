; RUN: opt -instcombine -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

define void @scalable4i32_to_fixed16i32() {
entry:
  %tmp = alloca <vscale x 4 x i32>, i32 0, align 1
  %cast1 = bitcast <vscale x 4 x i32>* %tmp to <16 x i32>*
  %reload = load volatile <16 x i32>, <16 x i32>* %cast1, align 16
  ret void
}
