; RUN: opt -gvn -S < %s
; XFAIL: *
; ModuleID = '/home/preames/Downloads/clusterfuzz-testcase-minimized-llvm-opt-fuzzer--x86_64-gvn-5109216548749312'
source_filename = "llvm/test/Transforms/SimplifyCFG/indirectbr.ll"

@anchor = constant [13 x i8*] [i8* blockaddress(@indbrtest3, %L1), i8* blockaddress(@indbrtest3, %L2), i8* blockaddress(@indbrtest3, %L3), i8* blockaddress(@indbrtest4, %L1), i8* blockaddress(@indbrtest4, %L2), i8* blockaddress(@indbrtest4, %L3), i8* blockaddress(@indbrtest5, %L1), i8* blockaddress(@indbrtest5, %L2), i8* blockaddress(@indbrtest5, %L3), i8* blockaddress(@indbrtest5, %L4), i8* blockaddress(@indbrtest6, %L1), i8* blockaddress(@indbrtest6, %L2), i8* blockaddress(@indbrtest6, %L3)]
@xblkx.bbs = internal unnamed_addr constant [9 x i8*] [i8* blockaddress(@indbrtest7, %xblkx.begin), i8* blockaddress(@indbrtest7, %xblkx.begin3), i8* blockaddress(@indbrtest7, %xblkx.begin4), i8* blockaddress(@indbrtest7, %xblkx.begin5), i8* blockaddress(@indbrtest7, %xblkx.begin6), i8* blockaddress(@indbrtest7, %xblkx.begin7), i8* blockaddress(@indbrtest7, %xblkx.begin8), i8* blockaddress(@indbrtest7, %xblkx.begin9), i8* blockaddress(@indbrtest7, %xblkx.end)]

declare void @foo()

declare void @A()

declare void @B(i32)

declare void @C()

define void @indbrtest0(i8** %P, i8** %Q) {
entry:
  indirectbr i8* undef, [label %BB0, label %BB1, label %BB2, label %BB0, label %BB1, label %BB2]

BB0:                                              ; preds = %entry, %entry
  br label %BB1

BB1:                                              ; preds = %BB1, %BB0, %entry, %entry
  br i1 true, label %BB1, label %BB

BB:                                               ; preds = %BB1
  ret void

BB2:                                              ; preds = %entry, %entry
  ret void
}

define void @indbrtest1(i8** %P, i8** %Q) {
entry:
  indirectbr i8* undef, [label %BB0, label %BB0]

BB0:                                              ; preds = %entry, %entry
  ret void
}

define void @indbrtest2(i8* %t) {
entry:
  indirectbr i8* %t, [label %BB0, label %BB0]

BB0:                                              ; preds = %entry, %entry
  ret void
}

; Function Attrs: nounwind
define void @indbrtest3(i1 %cond, i8* %address) #0 {
entry:
  indirectbr i8* undef, [label %L1, label %L2, label %L3]

L1:                                               ; preds = %entry
  ret void

L2:                                               ; preds = %entry
  ret void

L3:                                               ; preds = %entry
  ret void
}

; Function Attrs: nounwind
define void @indbrtest4(i1 %cond) #0 {
entry:
  indirectbr i8* undef, [label %L1, label %L2, label %L3]

L1:                                               ; preds = %entry
  ret void

L2:                                               ; preds = %entry
  ret void

L3:                                               ; preds = %entry
  ret void
}

; Function Attrs: nounwind
define void @indbrtest5(i1 %cond, i8* %anchor) #0 {
entry:
  indirectbr i8* undef, [label %L3, label %L4]

L1:                                               ; preds = %L4, %L1
  br i1 false, label %L1, label %BB

BB:                                               ; preds = %L1
  ret void

L2:                                               ; preds = %L4
  ret void

L3:                                               ; preds = %entry
  ret void

L4:                                               ; preds = %entry
  indirectbr i8* %anchor, [label %L1, label %L2]
}

; Function Attrs: nounwind
define void @indbrtest6(i1 %cond, i8* %anchor) #0 {
entry:
  indirectbr i8* undef, [label %L2, label %L3]

L1:                                               ; preds = %BB
  ret void

L2:                                               ; preds = %BB, %entry
  ret void

L3:                                               ; preds = %L3, %entry
  br i1 true, label %L3, label %BB

BB:                                               ; preds = %L3
  indirectbr i8* %anchor, [label %L1, label %L2]
}

define void @indbrtest7() {
escape-string.top:
  br label %xlab5x

xlab8x:                                           ; preds = %xlab5x
  indirectbr i8* undef, [label %xblkx.begin, label %xblkx.begin3, label %xblkx.begin4, label %xblkx.begin5, label %xblkx.begin6, label %xblkx.begin7, label %xblkx.begin8, label %xblkx.begin9, label %xblkx.end]

xblkx.begin:                                      ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin3:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin4:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin5:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin6:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin7:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin8:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.begin9:                                     ; preds = %xlab8x
  br label %xblkx.end

xblkx.end:                                        ; preds = %xblkx.end, %xblkx.begin9, %xblkx.begin8, %xblkx.begin7, %xblkx.begin6, %xblkx.begin5, %xblkx.begin4, %xblkx.begin3, %xblkx.begin, %xlab8x
  br i1 false, label %xblkx.end, label %BB1

BB1:                                              ; preds = %xblkx.end
  br i1 true, label %v2j, label %xlab17x

v2j:                                              ; preds = %BB2, %v2j, %BB1
  br i1 false, label %v2j, label %BB2

BB2:                                              ; preds = %v2j
  br i1 true, label %v2j, label %BB

BB:                                               ; preds = %BB2
  br label %xlab4x

xlab17x:                                          ; preds = %BB1
  br label %xlab4x

xlab4x:                                           ; preds = %xlab17x, %BB
  br label %xlab5x

xlab5x:                                           ; preds = %xlab4x, %escape-string.top
  br i1 true, label %xlab8x, label %xlab9x

xlab9x:                                           ; preds = %xlab5x
  ret void
}

declare i32 @xfunc5x()

declare i8 @xfunc7x()

declare i32 @xselectorx()

declare i32 @xactionx()

attributes #0 = { nounwind }
