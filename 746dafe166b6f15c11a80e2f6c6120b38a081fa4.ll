; RUN: opt -instsimplify -S < %s
; XFAIL: *

define i1 @i32_cast_cmp_oeq_int_0_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_n0_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_0_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_n0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_int_0_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_int_n0_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_int_0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_int_n0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_ueq_int_0_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ueq_int_n0_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ueq_int_0_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ueq_int_n0_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_une_int_0_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_une_int_n0_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_une_int_0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_une_int_n0_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ogt_int_0_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_ogt_int_n0_uitofp(i32 %i) {
  br label %BB

BB:                                               ; preds = %0
  ret i1 true
}

define i1 @i32_cast_cmp_ogt_int_0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_ogt_int_n0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_ole_int_0_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ole_int_0_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_olt_int_0_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i64_cast_cmp_oeq_int_0_uitofp(i64 %i) {
  ret i1 true
}

define i1 @i64_cast_cmp_oeq_int_0_sitofp(i64 %i) {
  ret i1 false
}

define i1 @i64_cast_cmp_oeq_int_0_uitofp_half(i64 %i) {
  ret i1 true
}

define i1 @i64_cast_cmp_oeq_int_0_sitofp_half(i64 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_0_uitofp_ppcf128(i32 %i) {
  %f = uitofp i32 65536 to ppc_fp128
  %B1 = fdiv ppc_fp128 %f, 0xM7FEFFFFFFFFFFFFF7C8FFFFFFFFFFFFE
  %B6 = fdiv ppc_fp128 %f, %B1
  store ppc_fp128 %B6, ppc_fp128* undef, align 16
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i24max_uitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_i24max_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i24maxp1_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i24maxp1_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i32umax_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_big_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i32umax_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_i32imin_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_i32imax_uitofp(i32 %i) {
  br label %BB

BB:                                               ; preds = %0
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_i32imax_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_negi32umax_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_half_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_half_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_half_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_one_half_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_ueq_half_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_ueq_half_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_une_half_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_une_half_sitofp(i32 %i) {
  ret i1 false
}

define i1 @i32_cast_cmp_oeq_int_inf_uitofp(i32 %i) {
  ret i1 true
}

define i1 @i32_cast_cmp_oeq_int_inf_sitofp(i32 %i) {
  ret i1 true
}

define i1 @i128_cast_cmp_oeq_int_inf_uitofp(i128 %i) {
  ret i1 true
}
