; RUN: opt -early-cse -S < %s
; XFAIL: *

define i1 @i32_cast_cmp_oeq_int_0_uitofp_ppcf128() {
  %f = uitofp i32 65536 to ppc_fp128
  %B1 = fdiv ppc_fp128 %f, 0xM7FEFFFFFFFFFFFFF7C8FFFFFFFFFFFFE
  %B6 = fdiv ppc_fp128 %f, %B1
  store ppc_fp128 %B6, ppc_fp128* null, align 16
  ret i1 false
}
