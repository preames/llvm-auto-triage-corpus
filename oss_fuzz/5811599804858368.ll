; RUN: opt -gvn -S < %s
; XFAIL: *
source_filename = "M"

define void @f() {
BB:
  %A24 = alloca i1, align 1
  %A8 = alloca i1**, align 8
  %C17 = icmp uge i16 -1, 0
  %C = fcmp olt double 4.940660e-324, 0.000000e+00
  %A11 = alloca i1*, align 8
  %A1 = alloca i1, align 1
  %C13 = fcmp olt float 0x47EFFFFFE0000000, 0x36A0000000000000
  %B = xor i1 true, %C13
  %G10 = getelementptr i1, i1* %A1, i32 65536
  %G7 = getelementptr i1*, i1** %A11, i1 %C
  store i1 %C17, i1* %A1, align 1
  %C11 = icmp ne i1 %B, %C
  %G6 = getelementptr inbounds i1, i1* %A1, i1 %B
  store i1 %C11, i1* %G6, align 1
  store i1* %G10, i1** %A11, align 8
  %C23 = icmp eq i1 %C11, %C11
  store i1** %G7, i1*** %A8, align 8
  store i1 %C23, i1* %A24, align 1
  br label %BB1

BB1:                                              ; preds = %BB6, %BB5, %BB1, %BB
  %C8 = icmp ule i1 true, true
  %C5 = icmp eq i1 %C8, %C8
  %C21 = icmp slt i1 %C8, true
  %B9 = xor i1 %C5, true
  %G1 = getelementptr i1, i1* %A1, i1 false
  %L14 = load i1, i1* %G1, align 1
  %L5 = load i1, i1* %G1, align 1
  %B15 = ashr i1 %B9, %L14
  %G2 = getelementptr i1, i1* %G1, i1 %L5
  %C7 = icmp uge i1 %B15, %C8
  %B6 = ashr i1 %C21, %C7
  %L1 = load i1, i1* %G2, align 1
  %G5 = getelementptr i1, i1* %G1, i1 %B6
  %L3 = load i1, i1* %G5, align 1
  %G3 = getelementptr i1, i1* %G2, i1 %L1
  %L = load i1, i1* %G3, align 1
  %C1 = icmp ne i1 %L5, %B15
  store i1 %C5, i1* %G5, align 1
  br i1 %C1, label %BB1, label %BB4

BB4:                                              ; preds = %BB7, %BB4, %BB1
  %G = getelementptr i1, i1* %G1, i1 %B6
  %L15 = load i1, i1* %G, align 1
  %L6 = load i1, i1* %G, align 1
  %C16 = icmp sle i1 %L6, %L15
  %L8 = load i1, i1* %G, align 1
  %L7 = load i1, i1* %G, align 1
  %G13 = getelementptr i1, i1* %G, i1 %L8
  %L13 = load i1, i1* %G13, align 1
  %L11 = load i1, i1* %G13, align 1
  %B8 = xor i1 %L7, %L11
  %C15 = icmp ne i1 %B8, %L13
  %L10 = load i1, i1* %G, align 1
  %C22 = icmp uge i1 %B8, %L13
  %B4 = mul i1 %C22, %C15
  %C12 = icmp sle i1 %C16, %B4
  br i1 %C15, label %BB4, label %BB7

BB7:                                              ; preds = %BB4
  %C6 = icmp ult i1 %L10, %C12
  %C3 = icmp ne i1 true, true
  %L9 = load i1, i1* %G, align 1
  %G4 = getelementptr i1, i1* %G2, i1 %L5
  %L16 = load i1, i1* %G4, align 1
  %G12 = getelementptr i1, i1* %G4, i1 %L10
  %G9 = getelementptr i1, i1* %G12, i16 -32768
  store i1 %C6, i1* %G12, align 1
  %B3 = lshr i1 %L3, %L1
  %B17 = or i1 %L16, %C3
  store i1 %C3, i1* %G9, align 1
  store i1 %B17, i1* undef, align 1
  br i1 %L9, label %BB4, label %BB5

BB5:                                              ; preds = %BB7
  %C9 = icmp ult i32 65536, 65536
  %B7 = frem float 0x36A0000000000000, 0x47EFFFFFE0000000
  store i1 %B3, i1* undef, align 1
  store i1* %G, i1** undef, align 8
  store float %B7, float* undef, align 4
  br i1 %C9, label %BB1, label %BB2

BB2:                                              ; preds = %BB2, %BB5
  %L2 = load i1, i1* %G1, align 1
  %B5 = or i1 %L2, true
  %B2 = ashr i1 %L, false
  %C2 = icmp eq i1 %B2, %B5
  br i1 %B2, label %BB2, label %BB6

BB6:                                              ; preds = %BB2
  %C14 = fcmp ugt float 0x47EFFFFFE0000000, 0.000000e+00
  store i1 %C14, i1* undef, align 1
  %C10 = icmp sle i16 -32768, 256
  %C20 = icmp sgt i1 %C10, %C14
  store i1 %C20, i1* undef, align 1
  br i1 %C2, label %BB1, label %BB3

BB3:                                              ; preds = %BB6
  %A = alloca i1, align 1
  %G14 = getelementptr i1, i1* %A, i64 -1
  %L12 = load i1, i1* %A, align 1
  %G11 = getelementptr i1, i1* %G14, i16 256
  %B1 = mul i1 %B2, false
  %G15 = getelementptr i1, i1* %A, i1 %B1
  store i1 %B1, i1* %G15, align 1
  %G8 = getelementptr i1, i1* %G11, i1 %L12
  %C4 = icmp ne i1 true, %B1
  %C19 = icmp ult i1 %C4, %C4
  %C18 = icmp sle i1 %L12, %C4
  store i1 %C19, i1* %G8, align 1
  store i1 %C18, i1* undef, align 1
  ret void
}
