; RUN: opt -instcombine -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

define void @scalable4i32_to_fixed16i32() {
entry:
  %tmp = alloca <vscale x 4 x i32>, align 16
  %cast = bitcast <vscale x 4 x i32>* %tmp to <16 x i32>*
  %G = getelementptr <16 x i32>, <16 x i32>* %cast, i16 256
  %reload = load volatile <16 x i32>, <16 x i32>* %cast, align 16
  store <16 x i32> %reload, <16 x i32>* %G, align 16
  ret void
}
