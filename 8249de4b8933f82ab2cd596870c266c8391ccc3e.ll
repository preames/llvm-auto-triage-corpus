; RUN: opt -instcombine -S < %s
; XFAIL: *
; REQUIRES: asserts

define i32 @gep_alloca_inbounds_vscale_nonzero() {
  %a = alloca <vscale x 4 x i32>, i32 0, align 16
  %L = load <vscale x 4 x i32>, <vscale x 4 x i32>* %a, align 16
  %E = extractelement <vscale x 4 x i32> %L, i8 0
  ret i32 %E
}
