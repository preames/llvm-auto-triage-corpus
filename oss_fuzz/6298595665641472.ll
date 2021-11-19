; RUN: opt -loop-vectorize -S < %s
; XFAIL: *
; REQUIRES: asserts
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define void @uniform_branch(i32* nocapture %a, i32* nocapture readonly %b, i32 %N, i32 %M) local_unnamed_addr {
entry:
  %C17 = fcmp oge double 0.000000e+00, 4.940660e-324
  %C8 = icmp sgt i8 0, -128
  %B18 = srem i32 2147483647, 2147483647
  %C9 = fcmp false double 0.000000e+00, 4.940660e-324
  %cmp39 = icmp sgt i32 %B18, 0
  %B19 = urem i1 %C8, %C9
  store i1 %B19, i1* undef, align 1
  %C13 = icmp eq i1 %cmp39, %C17
  br i1 %C13, label %outer.ph, label %for.end19

outer.ph:                                         ; preds = %entry
  %A4 = alloca i1, align 1
  %A2 = alloca i1*, align 8
  %B16 = and i1 true, true
  %G3 = getelementptr i1*, i1** %A2, i1 %B16
  %G8 = getelementptr i1*, i1** %G3, i64 9223372036854775807
  %0 = sext i32 %M to i64
  %B13 = xor i1 %B16, %B16
  %C2 = icmp sle i1 %B16, %B13
  store i1** %G8, i1*** undef, align 8
  store i1 %B16, i1* undef, align 1
  store i1 %C2, i1* undef, align 1
  %C3 = icmp sge i1 %C2, %B16
  store i1 %C3, i1* %A4, align 1
  br label %outer.body

outer.body:                                       ; preds = %outer.inc, %outer.ph
  %indvars.iv42 = phi i64 [ 0, %outer.ph ], [ %indvars.iv.next43, %outer.inc ]
  %A16 = alloca i1, align 1
  %C15 = fcmp true float 0.000000e+00, 0.000000e+00
  %C11 = icmp sgt i64 9223372036854775807, 4294967296
  %1 = mul nsw i64 %indvars.iv42, %0
  store i1 %C15, i1* %A16, align 1
  br i1 %C11, label %outer.inc, label %inner.ph

inner.ph:                                         ; preds = %inner.ph, %outer.body
  %B = sub i1 false, true
  %C4 = fcmp oge double 0.000000e+00, 4.940660e-324
  %B9 = sdiv i1 %C4, false
  %C = icmp slt i1 %B, true
  store i1 %B9, i1* undef, align 1
  store i1 %C, i1* undef, align 1
  %B22 = sdiv i1 %B9, %B9
  store i1 %B22, i1* undef, align 1
  store i1 %C4, i1* undef, align 1
  br i1 %C, label %inner.ph, label %BB

BB:                                               ; preds = %inner.ph
  %A10 = alloca i1, align 1
  %L = load i1, i1* %A10, align 1
  %G2 = getelementptr i1, i1* %A10, i1 %L
  store i1 %C4, i1* %G2, align 1
  %C7 = icmp ne i16 32767, -1
  store i1 %C7, i1* %A10, align 1
  br label %inner.body

inner.body:                                       ; preds = %inner.body, %BB
  %indvars.iv = phi i64 [ %indvars.iv.next, %inner.body ], [ 0, %BB ]
  %L10 = load i32*, i32** undef, align 8
  %2 = add nsw i64 %indvars.iv, %1
  %G20 = getelementptr i32, i32* %L10, i64 %2
  %G17 = getelementptr i32, i32* %L10, i64 %2
  %B1 = sub i64 %2, -1
  %G13 = getelementptr i32*, i32** undef, i32 65536
  %B3 = sub i64 %2, %B1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, %B3
  %G1 = getelementptr i32*, i32** undef, i64 %2
  %G4 = getelementptr i32, i32* %G17, i64 %B1
  %B26 = sub i64 %2, %indvars.iv.next
  %B17 = sub i64 %2, %2
  %exitcond = icmp eq i64 %indvars.iv.next, %B26
  %C16 = icmp sge i64 %B17, %2
  %B15 = or i1 %exitcond, %C16
  store i32* %G20, i32** %G1, align 8
  %G10 = getelementptr i32*, i32** %G13, i64 %B26
  store i64 %2, i64* undef, align 8
  store i32* %G4, i32** %G10, align 8
  br i1 %B15, label %outer.inc, label %inner.body

outer.inc:                                        ; preds = %inner.body, %outer.body
  %A5 = alloca i1, align 1
  %A29 = alloca i64, align 8
  %A3 = alloca i1, align 1
  %L1 = load i1, i1* %A3, align 1
  %B10 = fsub double 4.940660e-324, 4.940660e-324
  %indvars.iv.next43 = add nuw nsw i64 %indvars.iv42, 1
  %B8 = and i64 %indvars.iv.next43, 4294967296
  store double %B10, double* undef, align 8
  %B12 = or i1 %L1, %L1
  %B28 = mul i64 0, %B8
  %B25 = fadd double %B10, 4.940660e-324
  %G9 = getelementptr i64, i64* %A29, i1 %L1
  %C1 = fcmp ueq double %B10, %B25
  store i1 %C1, i1* %A3, align 1
  store i64 %B8, i64* %G9, align 8
  store i1* %A3, i1** undef, align 8
  %B4 = or i1 %B12, %L1
  store i64 %B28, i64* %A29, align 8
  store i1 %B4, i1* %A5, align 1
  %C10 = icmp eq i64 %indvars.iv.next43, %B28
  br i1 %C10, label %for.end19, label %outer.body, !llvm.loop !2

for.end19:                                        ; preds = %outer.inc, %entry
  %A = alloca i1*, align 8
  %L9 = load i1, i1* undef, align 1
  %G14 = getelementptr i1, i1* undef, i1 %L9
  %G21 = getelementptr i1, i1* %G14, i1 %L9
  %L6 = load i1, i1* undef, align 1
  %C14 = fcmp olt double 4.940660e-324, 4.940660e-324
  %A8 = alloca i1, align 1
  %C6 = icmp sge i8 127, -128
  %A9 = alloca float, align 4
  store float* %A9, float** undef, align 8
  %G6 = getelementptr i1, i1* %A8, i1 %L9
  store i1 %L9, i1* %G21, align 1
  store i1 %C14, i1* %A8, align 1
  store i1 %C6, i1* undef, align 1
  %B6 = sub i1 %C14, %L6
  store i1* %G6, i1** %A, align 8
  store i1 %B6, i1* %G6, align 1
  ret void
}

define void @divergent_branch(i32* nocapture %a, i32* nocapture readonly %b, i32 %N, i32 %B23) local_unnamed_addr {
entry:
  %L2 = load i1*, i1** undef, align 8
  %L3 = load i1, i1* %L2, align 1
  %G5 = getelementptr i1, i1* %L2, i1 %L3
  %B1 = sdiv i16 0, 0
  %C5 = icmp sgt i16 %B1, %B1
  store i16 %B1, i16* undef, align 2
  %C2 = icmp ne i1 %L3, %C5
  store i1 %C2, i1* %L2, align 1
  store i1* %G5, i1** undef, align 8
  br i1 %L3, label %outer.ph, label %for.end19

outer.ph:                                         ; preds = %entry
  %A17 = alloca i1, align 1
  %C = icmp eq i1 true, true
  %N64 = zext i32 %N to i64
  %C1 = icmp ne i64 %N64, %N64
  %M64 = zext i32 %B23 to i64
  %C16 = icmp ne i64 9223372036854775807, %M64
  store i1 %C1, i1* undef, align 1
  %B4 = udiv i8 0, 16
  store i1* undef, i1** undef, align 8
  %G7 = getelementptr i1*, i1** undef, i1 %C1
  %B18 = shl i1 %C1, %C
  store i1* undef, i1** %G7, align 8
  store i1 %B18, i1* undef, align 1
  store i8 %B4, i8* undef, align 1
  store i1 %C16, i1* %A17, align 1
  br label %outer.body

outer.body:                                       ; preds = %outer.inc, %outer.body, %outer.ph
  %C13 = fcmp ule double 4.940660e-324, 0.000000e+00
  %A2 = alloca i64, align 8
  %B19 = srem i1 false, false
  %C17 = icmp eq i1 %B19, %C13
  %B15 = xor i1 %B19, true
  %B7 = sdiv i64 0, 0
  %C8 = icmp sge i1 false, %B15
  %C3 = icmp uge i1 %C13, %C13
  store i1 %C17, i1* undef, align 1
  %B2 = shl i1 %C8, true
  %B = srem i64 %B7, 4294967296
  store i64 %B7, i64* undef, align 8
  %B22 = ashr i1 %B2, %C3
  store i64 %B, i64* %A2, align 8
  br i1 %C8, label %outer.body, label %BB

BB:                                               ; preds = %outer.body
  %C15 = icmp uge i32 0, -2147483648
  store i1 %B22, i1* undef, align 1
  %B6 = sub i1 %C15, %C15
  %B5 = sub i1 %C15, %B6
  br i1 %B5, label %outer.inc, label %inner.ph

inner.ph:                                         ; preds = %BB
  %C7 = fcmp ole float 0.000000e+00, 0x36A0000000000000
  %A15 = alloca i1, align 1
  %B24 = and i32 -1, -2147483648
  %C6 = icmp sle i32 0, -1
  store i1 %C7, i1* undef, align 1
  store i1 %C6, i1* %A15, align 1
  store i32 %B24, i32* undef, align 4
  %B8 = ashr i32 65536, -1
  store i64 -9223372036854775808, i64* undef, align 8
  store i32 %B8, i32* undef, align 4
  br label %inner.body

inner.body:                                       ; preds = %inner.body, %inner.ph
  %A = alloca i8*, align 8
  %G1 = getelementptr i8*, i8** %A, i16 256
  %exitcond = icmp eq i64 9223372036854775807, %M64
  %C10 = icmp eq i1 %exitcond, %exitcond
  %G14 = getelementptr i8, i8* undef, i64 9223372036854775807
  store float 0x47EFFFFFE0000000, float* undef, align 4
  store i1 %C10, i1* undef, align 1
  store i8* undef, i8** %G1, align 8
  store i8* %G14, i8** %A, align 8
  %G = getelementptr i8, i8* %G14, i1 true
  %G3 = getelementptr i8, i8* %G14, i1 %exitcond
  store i8* %G, i8** undef, align 8
  store i8* %G3, i8** undef, align 8
  br i1 %exitcond, label %outer.inc, label %inner.body

outer.inc:                                        ; preds = %inner.body, %BB
  %A13 = alloca i1, align 1
  %L = load i16*, i16** undef, align 8
  %L4 = load i16, i16* %L, align 2
  %G2 = getelementptr i16*, i16** undef, i16 %L4
  %G8 = getelementptr i16, i16* %L, i16 -32768
  %B13 = or i16 -1, 0
  %B12 = lshr i16 %L4, %L4
  %C12 = icmp uge i16 %B13, %B12
  %C9 = icmp ne i16 -32768, %B12
  %B9 = lshr i1 %C9, false
  %G6 = getelementptr i16, i16* %G8, i16 %B13
  %C4 = icmp ugt i1 %B9, %C12
  %G9 = getelementptr i1, i1* undef, i64 4294967296
  %C14 = icmp ne i1 %C4, %C12
  %C18 = icmp eq i1 %C4, false
  store i1* %G9, i1** undef, align 8
  store i1* %G9, i1** undef, align 8
  store i1 %C9, i1* %G9, align 1
  store i16* %G8, i16** %G2, align 8
  %C11 = icmp ne i16 %L4, %L4
  store i1 %C18, i1* %G9, align 1
  store i16* %G6, i16** undef, align 8
  store i16 %B12, i16* undef, align 2
  store i1 %C14, i1* undef, align 1
  store i1 %C11, i1* %A13, align 1
  br i1 %C4, label %for.end19, label %outer.body, !llvm.loop !2

for.end19:                                        ; preds = %outer.inc, %entry
  %A8 = alloca i32*, align 8
  %L5 = load i32*, i32** %A8, align 8
  %B3 = shl i1 false, false
  %A12 = alloca i1, align 1
  %L1 = load i32, i32* %L5, align 4
  %G4 = getelementptr i32, i32* %L5, i32 %L1
  store i1 false, i1* %A12, align 1
  %B17 = shl i1 false, %B3
  store i32* %L5, i32** %A8, align 8
  store i1 %B17, i1* undef, align 1
  store i32* %G4, i32** undef, align 8
  store i1* %A12, i1** undef, align 8
  ret void
}

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0"}
!2 = distinct !{!2, !3, !4}
!3 = !{!"llvm.loop.vectorize.width", i32 8}
!4 = !{!"llvm.loop.vectorize.enable", i1 true}
