; RUN: opt -gvn -S < %s
; XFAIL: *
target triple = "x86_64-unknown-linux-gnu"

define void @indbrtest6() {
entry:
  indirectbr i8* null, [label %L2, label %L3]

L1:                                               ; preds = %BB
  ret void

L2:                                               ; preds = %BB, %entry
  ret void

L3:                                               ; preds = %L3, %entry
  br i1 true, label %L3, label %BB

BB:                                               ; preds = %L3
  indirectbr i8* null, [label %L1, label %L2]
}
