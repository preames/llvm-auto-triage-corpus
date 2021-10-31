; RUN: opt -instcombine -S < %s
; XFAIL: *
; ModuleID = '/home/preames/Downloads/clusterfuzz-testcase-minimized-llvm-opt-fuzzer--x86_64-instcombine-5708744316157952'
source_filename = "llvm/test/Transforms/InstCombine/alloca.ll"

%opaque_type = type opaque
%struct_type = type { i32, i32 }

@int = global i32 0
@opaque_global = external constant %opaque_type, align 4

declare void @use(...)

define void @test() {
  ret void
}

define void @test2() {
  ret void
}

define void @test3() {
  ret void
}

define i32* @test4(i32 %n) {
  ret i32* undef
}

define void @test5() {
entry:
  ret void
}

declare void @f(i32*)

define void @test6() {
entry:
  ret void
}

define void @test7() {
entry:
  ret void
}

define void @test8() {
  ret void
}

declare void @test9_aux(<{ %struct_type }>* inalloca(<{ %struct_type }>))

; Function Attrs: nofree nosync nounwind willreturn
declare i8* @llvm.stacksave() #0

; Function Attrs: nofree nosync nounwind willreturn
declare void @llvm.stackrestore(i8*) #0

define void @test9(%struct_type* %a) {
entry:
  %argmem = alloca inalloca <{ %struct_type }>, i32 0, align 8
  call void @test9_aux(<{ %struct_type }>* inalloca(<{ %struct_type }>) %argmem)
  ret void
}

define void @test10() {
entry:
  ret void
}

define void @test11() {
entry:
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i32, i1 immarg) #1

attributes #0 = { nofree nosync nounwind willreturn }
attributes #1 = { argmemonly nofree nounwind willreturn }
