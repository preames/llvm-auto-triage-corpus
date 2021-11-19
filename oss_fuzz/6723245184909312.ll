; RUN: opt -instcombine -S < %s
; XFAIL: *
; REQUIRES: asserts

define <vscale x 4 x float> @insertelement_bitcast(<vscale x 4 x i32> %vec, i32 %x) {
  %x_cast = bitcast i32 %x to float
  %vec_cast = bitcast <vscale x 4 x i32> %vec to <vscale x 4 x float>
  %r = insertelement <vscale x 4 x float> %vec_cast, float %x_cast, i32 0
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x i32> @insertelement_extractelement(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
  %t0 = extractelement <vscale x 4 x i32> %a, i32 1
  %t1 = insertelement <vscale x 4 x i32> %b, i32 %t0, i32 0
  ret <vscale x 4 x i32> %t1
}

define <4 x i32> @insertelement_extractelement_fixed_vec_extract_from_scalable(<vscale x 4 x i32> %a, <4 x i32> %b) {
  %t0 = extractelement <vscale x 4 x i32> %a, i32 1
  %t1 = insertelement <4 x i32> %b, i32 %t0, i32 0
  ret <4 x i32> %t1
}

define <vscale x 4 x i32> @insertelement_insertelement(<vscale x 4 x i32> %vec) {
  %t0 = insertelement <vscale x 4 x i32> %vec, i32 1, i32 1
  %t1 = insertelement <vscale x 4 x i32> %t0, i32 2, i32 2
  ret <vscale x 4 x i32> %t1
}

define <vscale x 4 x float> @insertelement_sequene_may_not_be_splat(float %x) {
  %t0 = insertelement <vscale x 4 x float> undef, float %x, i32 0
  %E = extractelement <vscale x 4 x float> %t0, i1 true
  %t1 = insertelement <vscale x 4 x float> %t0, float %x, i32 1
  %t2 = insertelement <vscale x 4 x float> %t1, float %x, i32 2
  %t3 = insertelement <vscale x 4 x float> %t2, float %E, i32 3
  ret <vscale x 4 x float> %t3
}
