; ModuleID = 'gemm-ncubed.c'
source_filename = "gemm-ncubed.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @gemm(double* %m1, double* %m2, double* %prod) #0 !dbg !9 {
entry:
  %m1.addr = alloca double*, align 8
  %m2.addr = alloca double*, align 8
  %prod.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %k_col = alloca i32, align 4
  %i_col = alloca i32, align 4
  %mult = alloca double, align 8
  %sum = alloca double, align 8
  store double* %m1, double** %m1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %m1.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store double* %m2, double** %m2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %m2.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store double* %prod, double** %prod.addr, align 8
  call void @llvm.dbg.declare(metadata double** %prod.addr, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %i, metadata !19, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %j, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %k, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %k_col, metadata !26, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.declare(metadata i32* %i_col, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata double* %mult, metadata !30, metadata !DIExpression()), !dbg !31
  br label %outer, !dbg !32

outer:                                            ; preds = %entry
  call void @llvm.dbg.label(metadata !33), !dbg !34
  store i32 0, i32* %i, align 4, !dbg !35
  br label %for.cond, !dbg !37

for.cond:                                         ; preds = %for.inc19, %outer
  %0 = load i32, i32* %i, align 4, !dbg !38
  %cmp = icmp slt i32 %0, 64, !dbg !40
  br i1 %cmp, label %for.body, label %for.end21, !dbg !41

for.body:                                         ; preds = %for.cond
  br label %middle, !dbg !42

middle:                                           ; preds = %for.body
  call void @llvm.dbg.label(metadata !43), !dbg !45
  store i32 0, i32* %j, align 4, !dbg !46
  br label %for.cond1, !dbg !48

for.cond1:                                        ; preds = %for.inc16, %middle
  %1 = load i32, i32* %j, align 4, !dbg !49
  %cmp2 = icmp slt i32 %1, 64, !dbg !51
  br i1 %cmp2, label %for.body3, label %for.end18, !dbg !52

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %i, align 4, !dbg !53
  %mul = mul nsw i32 %2, 64, !dbg !55
  store i32 %mul, i32* %i_col, align 4, !dbg !56
  call void @llvm.dbg.declare(metadata double* %sum, metadata !57, metadata !DIExpression()), !dbg !58
  store double 0.000000e+00, double* %sum, align 8, !dbg !58
  br label %inner, !dbg !59

inner:                                            ; preds = %for.body3
  call void @llvm.dbg.label(metadata !60), !dbg !61
  store i32 0, i32* %k, align 4, !dbg !62
  br label %for.cond4, !dbg !64

for.cond4:                                        ; preds = %for.inc, %inner
  %3 = load i32, i32* %k, align 4, !dbg !65
  %cmp5 = icmp slt i32 %3, 64, !dbg !67
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !68

for.body6:                                        ; preds = %for.cond4
  %4 = load i32, i32* %k, align 4, !dbg !69
  %mul7 = mul nsw i32 %4, 64, !dbg !71
  store i32 %mul7, i32* %k_col, align 4, !dbg !72
  %5 = load double*, double** %m1.addr, align 8, !dbg !73
  %6 = load i32, i32* %i_col, align 4, !dbg !74
  %7 = load i32, i32* %k, align 4, !dbg !75
  %add = add nsw i32 %6, %7, !dbg !76
  %idxprom = sext i32 %add to i64, !dbg !73
  %arrayidx = getelementptr inbounds double, double* %5, i64 %idxprom, !dbg !73
  %8 = load double, double* %arrayidx, align 8, !dbg !73
  %9 = load double*, double** %m2.addr, align 8, !dbg !77
  %10 = load i32, i32* %k_col, align 4, !dbg !78
  %11 = load i32, i32* %j, align 4, !dbg !79
  %add8 = add nsw i32 %10, %11, !dbg !80
  %idxprom9 = sext i32 %add8 to i64, !dbg !77
  %arrayidx10 = getelementptr inbounds double, double* %9, i64 %idxprom9, !dbg !77
  %12 = load double, double* %arrayidx10, align 8, !dbg !77
  %mul11 = fmul double %8, %12, !dbg !81
  store double %mul11, double* %mult, align 8, !dbg !82
  %13 = load double, double* %mult, align 8, !dbg !83
  %14 = load double, double* %sum, align 8, !dbg !84
  %add12 = fadd double %14, %13, !dbg !84
  store double %add12, double* %sum, align 8, !dbg !84
  br label %for.inc, !dbg !85

for.inc:                                          ; preds = %for.body6
  %15 = load i32, i32* %k, align 4, !dbg !86
  %inc = add nsw i32 %15, 1, !dbg !86
  store i32 %inc, i32* %k, align 4, !dbg !86
  br label %for.cond4, !dbg !87, !llvm.loop !88

for.end:                                          ; preds = %for.cond4
  %16 = load double, double* %sum, align 8, !dbg !91
  %17 = load double*, double** %prod.addr, align 8, !dbg !92
  %18 = load i32, i32* %i_col, align 4, !dbg !93
  %19 = load i32, i32* %j, align 4, !dbg !94
  %add13 = add nsw i32 %18, %19, !dbg !95
  %idxprom14 = sext i32 %add13 to i64, !dbg !92
  %arrayidx15 = getelementptr inbounds double, double* %17, i64 %idxprom14, !dbg !92
  store double %16, double* %arrayidx15, align 8, !dbg !96
  br label %for.inc16, !dbg !97

for.inc16:                                        ; preds = %for.end
  %20 = load i32, i32* %j, align 4, !dbg !98
  %inc17 = add nsw i32 %20, 1, !dbg !98
  store i32 %inc17, i32* %j, align 4, !dbg !98
  br label %for.cond1, !dbg !99, !llvm.loop !100

for.end18:                                        ; preds = %for.cond1
  br label %for.inc19, !dbg !102

for.inc19:                                        ; preds = %for.end18
  %21 = load i32, i32* %i, align 4, !dbg !103
  %inc20 = add nsw i32 %21, 1, !dbg !103
  store i32 %inc20, i32* %i, align 4, !dbg !103
  br label %for.cond, !dbg !104, !llvm.loop !105

for.end21:                                        ; preds = %for.cond
  ret void, !dbg !107
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "gemm-ncubed.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/machsuite/gemm-ncubed")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "gemm", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !12, !12}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!13 = !DILocalVariable(name: "m1", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!14 = !DILocation(line: 3, column: 18, scope: !9)
!15 = !DILocalVariable(name: "m2", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!16 = !DILocation(line: 3, column: 34, scope: !9)
!17 = !DILocalVariable(name: "prod", arg: 3, scope: !9, file: !1, line: 3, type: !12)
!18 = !DILocation(line: 3, column: 50, scope: !9)
!19 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 5, type: !20)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocation(line: 5, column: 7, scope: !9)
!22 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 6, type: !20)
!23 = !DILocation(line: 6, column: 7, scope: !9)
!24 = !DILocalVariable(name: "k", scope: !9, file: !1, line: 7, type: !20)
!25 = !DILocation(line: 7, column: 7, scope: !9)
!26 = !DILocalVariable(name: "k_col", scope: !9, file: !1, line: 8, type: !20)
!27 = !DILocation(line: 8, column: 7, scope: !9)
!28 = !DILocalVariable(name: "i_col", scope: !9, file: !1, line: 9, type: !20)
!29 = !DILocation(line: 9, column: 7, scope: !9)
!30 = !DILocalVariable(name: "mult", scope: !9, file: !1, line: 10, type: !4)
!31 = !DILocation(line: 10, column: 10, scope: !9)
!32 = !DILocation(line: 10, column: 3, scope: !9)
!33 = !DILabel(scope: !9, name: "outer", file: !1, line: 17)
!34 = !DILocation(line: 17, column: 3, scope: !9)
!35 = !DILocation(line: 18, column: 10, scope: !36)
!36 = distinct !DILexicalBlock(scope: !9, file: !1, line: 18, column: 3)
!37 = !DILocation(line: 18, column: 8, scope: !36)
!38 = !DILocation(line: 18, column: 15, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !1, line: 18, column: 3)
!40 = !DILocation(line: 18, column: 17, scope: !39)
!41 = !DILocation(line: 18, column: 3, scope: !36)
!42 = !DILocation(line: 18, column: 28, scope: !39)
!43 = !DILabel(scope: !44, name: "middle", file: !1, line: 25)
!44 = distinct !DILexicalBlock(scope: !39, file: !1, line: 18, column: 28)
!45 = !DILocation(line: 25, column: 5, scope: !44)
!46 = !DILocation(line: 26, column: 12, scope: !47)
!47 = distinct !DILexicalBlock(scope: !44, file: !1, line: 26, column: 5)
!48 = !DILocation(line: 26, column: 10, scope: !47)
!49 = !DILocation(line: 26, column: 17, scope: !50)
!50 = distinct !DILexicalBlock(scope: !47, file: !1, line: 26, column: 5)
!51 = !DILocation(line: 26, column: 19, scope: !50)
!52 = !DILocation(line: 26, column: 5, scope: !47)
!53 = !DILocation(line: 27, column: 15, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !1, line: 26, column: 30)
!55 = !DILocation(line: 27, column: 17, scope: !54)
!56 = !DILocation(line: 27, column: 13, scope: !54)
!57 = !DILocalVariable(name: "sum", scope: !54, file: !1, line: 28, type: !4)
!58 = !DILocation(line: 28, column: 14, scope: !54)
!59 = !DILocation(line: 28, column: 7, scope: !54)
!60 = !DILabel(scope: !54, name: "inner", file: !1, line: 31)
!61 = !DILocation(line: 31, column: 7, scope: !54)
!62 = !DILocation(line: 32, column: 14, scope: !63)
!63 = distinct !DILexicalBlock(scope: !54, file: !1, line: 32, column: 7)
!64 = !DILocation(line: 32, column: 12, scope: !63)
!65 = !DILocation(line: 32, column: 19, scope: !66)
!66 = distinct !DILexicalBlock(scope: !63, file: !1, line: 32, column: 7)
!67 = !DILocation(line: 32, column: 21, scope: !66)
!68 = !DILocation(line: 32, column: 7, scope: !63)
!69 = !DILocation(line: 33, column: 17, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 32, column: 32)
!71 = !DILocation(line: 33, column: 19, scope: !70)
!72 = !DILocation(line: 33, column: 15, scope: !70)
!73 = !DILocation(line: 34, column: 16, scope: !70)
!74 = !DILocation(line: 34, column: 19, scope: !70)
!75 = !DILocation(line: 34, column: 27, scope: !70)
!76 = !DILocation(line: 34, column: 25, scope: !70)
!77 = !DILocation(line: 34, column: 32, scope: !70)
!78 = !DILocation(line: 34, column: 35, scope: !70)
!79 = !DILocation(line: 34, column: 43, scope: !70)
!80 = !DILocation(line: 34, column: 41, scope: !70)
!81 = !DILocation(line: 34, column: 30, scope: !70)
!82 = !DILocation(line: 34, column: 14, scope: !70)
!83 = !DILocation(line: 35, column: 16, scope: !70)
!84 = !DILocation(line: 35, column: 13, scope: !70)
!85 = !DILocation(line: 36, column: 7, scope: !70)
!86 = !DILocation(line: 32, column: 28, scope: !66)
!87 = !DILocation(line: 32, column: 7, scope: !66)
!88 = distinct !{!88, !68, !89, !90}
!89 = !DILocation(line: 36, column: 7, scope: !63)
!90 = !{!"llvm.loop.mustprogress"}
!91 = !DILocation(line: 37, column: 25, scope: !54)
!92 = !DILocation(line: 37, column: 7, scope: !54)
!93 = !DILocation(line: 37, column: 12, scope: !54)
!94 = !DILocation(line: 37, column: 20, scope: !54)
!95 = !DILocation(line: 37, column: 18, scope: !54)
!96 = !DILocation(line: 37, column: 23, scope: !54)
!97 = !DILocation(line: 38, column: 5, scope: !54)
!98 = !DILocation(line: 26, column: 26, scope: !50)
!99 = !DILocation(line: 26, column: 5, scope: !50)
!100 = distinct !{!100, !52, !101, !90}
!101 = !DILocation(line: 38, column: 5, scope: !47)
!102 = !DILocation(line: 39, column: 3, scope: !44)
!103 = !DILocation(line: 18, column: 24, scope: !39)
!104 = !DILocation(line: 18, column: 3, scope: !39)
!105 = distinct !{!105, !41, !106, !90}
!106 = !DILocation(line: 39, column: 3, scope: !36)
!107 = !DILocation(line: 40, column: 1, scope: !9)
