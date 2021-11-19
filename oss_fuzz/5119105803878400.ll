; RUN: opt -instcombine -S < %s
; XFAIL: *
; REQUIRES: asserts

define <vscale x 2 x i1> @sge(<vscale x 2 x i8> %x) {
  %cmp = icmp sge <vscale x 2 x i8> %x, zeroinitializer
  ret <vscale x 2 x i1> %cmp
}

; Function Attrs: nounwind
define <vscale x 2 x i1> @gep_scalevector1(i32* %X) #0 {
  %A = getelementptr inbounds i32, i32* %X, <vscale x 2 x i64> zeroinitializer
  %C = icmp eq <vscale x 2 x i32*> %A, zeroinitializer
  ret <vscale x 2 x i1> %C
}

define <vscale x 2 x i1> @signbit_bitcast_fpext_scalevec(<vscale x 2 x half> %x) {
  %f = fpext <vscale x 2 x half> %x to <vscale x 2 x float>
  %b = bitcast <vscale x 2 x float> %f to <vscale x 2 x i32>
  %r = icmp slt <vscale x 2 x i32> %b, zeroinitializer
  ret <vscale x 2 x i1> %r
}

attributes #0 = { nounwind }
