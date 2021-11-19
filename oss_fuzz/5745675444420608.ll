; RUN: opt -instcombine -S < %s
; XFAIL: *
; REQUIRES: asserts

define <vscale x 2 x i8*> @gep_index_type_is_scalable(i8* %p) {
  %C = fcmp oeq double 0.000000e+00, 0.000000e+00
  %gep = getelementptr i8, i8* %p, <vscale x 2 x i64> undef
  store i1 %C, i1* undef, align 1
  ret <vscale x 2 x i8*> %gep
}

define <vscale x 4 x i32>* @gep_num_of_indices_1(<vscale x 4 x i32>* %p) {
  %gep = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %p, i64 1
  ret <vscale x 4 x i32>* %gep
}

define void @gep_bitcast(i8* %p) {
  %cast = bitcast i8* %p to <vscale x 16 x i8>*
  %gep1 = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %cast, i64 0
  store <vscale x 16 x i8> zeroinitializer, <vscale x 16 x i8>* %gep1, align 16
  %gep2 = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %cast, i64 1
  store <vscale x 16 x i8> zeroinitializer, <vscale x 16 x i8>* %gep2, align 16
  ret void
}

define i32 @gep_alloca_inbounds_vscale_zero() {
  %A = alloca <vscale x 4 x i32>*, align 8
  %B = ashr i1 true, true
  %a = alloca <vscale x 4 x i32>, align 16
  %tmp = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %a, i32 0, i32 2
  %load = load i32, i32* %tmp, align 4
  %G = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %a, i64 0
  store i1 %B, i1* undef, align 1
  store <vscale x 4 x i32>* %G, <vscale x 4 x i32>** %A, align 8
  ret i32 %load
}

define i32 @gep_alloca_inbounds_vscale_nonzero() {
  %B = sub i32 -1, 0
  %A = alloca i32, align 4
  %a = alloca <vscale x 4 x i32>, i32 %B, align 16
  %L1 = load <vscale x 4 x i32>, <vscale x 4 x i32>* %a, align 16
  %E2 = extractelement <vscale x 4 x i32> %L1, i32 65536
  %L = load <vscale x 4 x i32>, <vscale x 4 x i32>* %a, align 16
  %G = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %a, i1 true
  %E = extractelement <vscale x 4 x i32> %L, i8 -128
  store <vscale x 4 x i32>* %G, <vscale x 4 x i32>** undef, align 8
  store i32 %E2, i32* %A, align 4
  ret i32 %E
}
