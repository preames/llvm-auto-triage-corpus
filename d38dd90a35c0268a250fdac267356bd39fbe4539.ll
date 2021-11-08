; RUN: opt -gvn -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind
define void @indbrtest6(i8* %anchor) #0 {
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

attributes #0 = { nounwind }
