; RUN: opt -instcombine -S < %s
; XFAIL: *

define void @scalable4i32_to_fixed16i32(<16 x i32>* %cast) {
entry:
  %tmp = alloca <vscale x 4 x i32>, i32 0, align 16
  %cast1 = bitcast <vscale x 4 x i32>* %tmp to <16 x i32>*
  %G = getelementptr <16 x i32>, <16 x i32>* %cast, i16 256
  %reload = load volatile <16 x i32>, <16 x i32>* %cast1, align 16
  store <16 x i32> zeroinitializer, <16 x i32>* null, align 16
  ret void
}
