; RUN: opt -instcombine -S < %s
; XFAIL: *
; ModuleID = '/home/preames/Downloads/clusterfuzz-testcase-minimized-llvm-opt-fuzzer--x86_64-instcombine-5701534861754368'
source_filename = "llvm-project/llvm/test/Transforms/InstCombine/AArch64/sve-cast-of-alloc.ll"

define void @fixed_array16i32_to_scalable4i32(<vscale x 4 x i32>* %out) {
entry:
  %tmp = alloca [16 x i32], align 16
  %cast = bitcast [16 x i32]* %tmp to <vscale x 4 x i32>*
  store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* %cast, align 16
  %reload = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %cast, align 16
  store <vscale x 4 x i32> %reload, <vscale x 4 x i32>* %out, align 16
  ret void
}

define void @scalable4i32_to_fixed16i32(<16 x i32>* %out) {
entry:
  %tmp = alloca <vscale x 4 x i32>, align 16
  %cast = bitcast <vscale x 4 x i32>* %tmp to <16 x i32>*
  %G = getelementptr <16 x i32>, <16 x i32>* %cast, i16 256
  store <16 x i32> zeroinitializer, <16 x i32>* %cast, align 16
  %reload = load volatile <16 x i32>, <16 x i32>* %cast, align 16
  store <16 x i32> %reload, <16 x i32>* %G, align 16
  ret void
}

define void @fixed16i32_to_scalable4i32(<vscale x 4 x i32>* %out) {
entry:
  %A = alloca <vscale x 4 x i32>*, align 8
  %tmp = alloca <16 x i32>, align 16
  %cast = bitcast <16 x i32>* %tmp to <vscale x 4 x i32>*
  store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* %cast, align 16
  %reload = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %cast, align 16
  %G = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %cast, i16 -1
  store <vscale x 4 x i32> %reload, <vscale x 4 x i32>* %out, align 16
  store <vscale x 4 x i32>* %G, <vscale x 4 x i32>** %A, align 8
  ret void
}

define void @scalable16i32_to_fixed16i32(<16 x i32>* %out) {
entry:
  %tmp = alloca <vscale x 16 x i32>, align 16
  %cast = bitcast <vscale x 16 x i32>* %tmp to <16 x i32>*
  store volatile <16 x i32> zeroinitializer, <16 x i32>* %cast, align 16
  %reload = load volatile <16 x i32>, <16 x i32>* %cast, align 16
  store <16 x i32> %reload, <16 x i32>* %out, align 16
  ret void
}

define void @scalable32i32_to_scalable16i32(<vscale x 16 x i32>* %out) {
entry:
  %tmp = alloca <vscale x 32 x i32>, align 16
  %cast = bitcast <vscale x 32 x i32>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  %G = getelementptr <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, i64 -9223372036854775808
  store <vscale x 16 x i32>* %G, <vscale x 16 x i32>** undef, align 8
  ret void
}

define void @scalable32i16_to_scalable16i32(<vscale x 16 x i32>* %out) {
entry:
  %tmp = alloca <vscale x 32 x i16>, align 16
  %cast = bitcast <vscale x 32 x i16>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  ret void
}

define void @scalable32i16_to_scalable16i32_multiuse(<vscale x 16 x i32>* %out, <vscale x 32 x i16>* %out2) {
entry:
  %A = alloca <vscale x 32 x i16>, align 64
  %tmp = alloca <vscale x 32 x i16>, align 16
  %cast = bitcast <vscale x 32 x i16>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  %reload2 = load volatile <vscale x 32 x i16>, <vscale x 32 x i16>* %tmp, align 16
  store <vscale x 32 x i16> %reload2, <vscale x 32 x i16>* %out2, align 16
  %I = insertelement <vscale x 32 x i16> %reload2, i16 256, i8 16
  store <vscale x 32 x i16> %I, <vscale x 32 x i16>* %A, align 64
  ret void
}
