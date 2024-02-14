; ModuleID = 'doitgen-red.c'
source_filename = "doitgen-red.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_doitgen([20 x [30 x double]]* %A, [30 x double]* %C4, double* %sum) #0 !dbg !7 {
entry:
  %A.addr = alloca [20 x [30 x double]]*, align 8
  %C4.addr = alloca [30 x double]*, align 8
  %sum.addr = alloca double*, align 8
  %r = alloca i32, align 4
  %q = alloca i32, align 4
  %p = alloca i32, align 4
  %s = alloca i32, align 4
  %sum_tmp = alloca double, align 8
  store [20 x [30 x double]]* %A, [20 x [30 x double]]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [20 x [30 x double]]** %A.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store [30 x double]* %C4, [30 x double]** %C4.addr, align 8
  call void @llvm.dbg.declare(metadata [30 x double]** %C4.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store double* %sum, double** %sum.addr, align 8
  call void @llvm.dbg.declare(metadata double** %sum.addr, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %r, metadata !26, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %q, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata i32* %p, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %s, metadata !33, metadata !DIExpression()), !dbg !34
  store i32 0, i32* %r, align 4, !dbg !35
  br label %for.cond, !dbg !37

for.cond:                                         ; preds = %for.inc40, %entry
  %0 = load i32, i32* %r, align 4, !dbg !38
  %cmp = icmp slt i32 %0, 25, !dbg !40
  br i1 %cmp, label %for.body, label %for.end42, !dbg !41

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %q, align 4, !dbg !42
  br label %for.cond1, !dbg !45

for.cond1:                                        ; preds = %for.inc37, %for.body
  %1 = load i32, i32* %q, align 4, !dbg !46
  %cmp2 = icmp slt i32 %1, 20, !dbg !48
  br i1 %cmp2, label %for.body3, label %for.end39, !dbg !49

for.body3:                                        ; preds = %for.cond1
  store i32 0, i32* %p, align 4, !dbg !50
  br label %for.cond4, !dbg !53

for.cond4:                                        ; preds = %for.inc20, %for.body3
  %2 = load i32, i32* %p, align 4, !dbg !54
  %cmp5 = icmp slt i32 %2, 30, !dbg !56
  br i1 %cmp5, label %for.body6, label %for.end22, !dbg !57

for.body6:                                        ; preds = %for.cond4
  call void @llvm.dbg.declare(metadata double* %sum_tmp, metadata !58, metadata !DIExpression()), !dbg !60
  store double 0.000000e+00, double* %sum_tmp, align 8, !dbg !60
  store i32 0, i32* %s, align 4, !dbg !61
  br label %for.cond7, !dbg !63

for.cond7:                                        ; preds = %for.inc, %for.body6
  %3 = load i32, i32* %s, align 4, !dbg !64
  %cmp8 = icmp slt i32 %3, 30, !dbg !66
  br i1 %cmp8, label %for.body9, label %for.end, !dbg !67

for.body9:                                        ; preds = %for.cond7
  %4 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8, !dbg !68
  %5 = load i32, i32* %r, align 4, !dbg !70
  %idxprom = sext i32 %5 to i64, !dbg !68
  %arrayidx = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %4, i64 %idxprom, !dbg !68
  %6 = load i32, i32* %q, align 4, !dbg !71
  %idxprom10 = sext i32 %6 to i64, !dbg !68
  %arrayidx11 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx, i64 0, i64 %idxprom10, !dbg !68
  %7 = load i32, i32* %s, align 4, !dbg !72
  %idxprom12 = sext i32 %7 to i64, !dbg !68
  %arrayidx13 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx11, i64 0, i64 %idxprom12, !dbg !68
  %8 = load double, double* %arrayidx13, align 8, !dbg !68
  %9 = load [30 x double]*, [30 x double]** %C4.addr, align 8, !dbg !73
  %10 = load i32, i32* %s, align 4, !dbg !74
  %idxprom14 = sext i32 %10 to i64, !dbg !73
  %arrayidx15 = getelementptr inbounds [30 x double], [30 x double]* %9, i64 %idxprom14, !dbg !73
  %11 = load i32, i32* %p, align 4, !dbg !75
  %idxprom16 = sext i32 %11 to i64, !dbg !73
  %arrayidx17 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx15, i64 0, i64 %idxprom16, !dbg !73
  %12 = load double, double* %arrayidx17, align 8, !dbg !73
  %mul = fmul double %8, %12, !dbg !76
  %13 = load double, double* %sum_tmp, align 8, !dbg !77
  %add = fadd double %13, %mul, !dbg !77
  store double %add, double* %sum_tmp, align 8, !dbg !77
  br label %for.inc, !dbg !78

for.inc:                                          ; preds = %for.body9
  %14 = load i32, i32* %s, align 4, !dbg !79
  %inc = add nsw i32 %14, 1, !dbg !79
  store i32 %inc, i32* %s, align 4, !dbg !79
  br label %for.cond7, !dbg !80, !llvm.loop !81

for.end:                                          ; preds = %for.cond7
  %15 = load double, double* %sum_tmp, align 8, !dbg !84
  %16 = load double*, double** %sum.addr, align 8, !dbg !85
  %17 = load i32, i32* %p, align 4, !dbg !86
  %idxprom18 = sext i32 %17 to i64, !dbg !85
  %arrayidx19 = getelementptr inbounds double, double* %16, i64 %idxprom18, !dbg !85
  store double %15, double* %arrayidx19, align 8, !dbg !87
  br label %for.inc20, !dbg !88

for.inc20:                                        ; preds = %for.end
  %18 = load i32, i32* %p, align 4, !dbg !89
  %inc21 = add nsw i32 %18, 1, !dbg !89
  store i32 %inc21, i32* %p, align 4, !dbg !89
  br label %for.cond4, !dbg !90, !llvm.loop !91

for.end22:                                        ; preds = %for.cond4
  store i32 0, i32* %p, align 4, !dbg !93
  br label %for.cond23, !dbg !95

for.cond23:                                       ; preds = %for.inc34, %for.end22
  %19 = load i32, i32* %p, align 4, !dbg !96
  %cmp24 = icmp slt i32 %19, 30, !dbg !98
  br i1 %cmp24, label %for.body25, label %for.end36, !dbg !99

for.body25:                                       ; preds = %for.cond23
  %20 = load double*, double** %sum.addr, align 8, !dbg !100
  %21 = load i32, i32* %p, align 4, !dbg !102
  %idxprom26 = sext i32 %21 to i64, !dbg !100
  %arrayidx27 = getelementptr inbounds double, double* %20, i64 %idxprom26, !dbg !100
  %22 = load double, double* %arrayidx27, align 8, !dbg !100
  %23 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8, !dbg !103
  %24 = load i32, i32* %r, align 4, !dbg !104
  %idxprom28 = sext i32 %24 to i64, !dbg !103
  %arrayidx29 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %23, i64 %idxprom28, !dbg !103
  %25 = load i32, i32* %q, align 4, !dbg !105
  %idxprom30 = sext i32 %25 to i64, !dbg !103
  %arrayidx31 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx29, i64 0, i64 %idxprom30, !dbg !103
  %26 = load i32, i32* %p, align 4, !dbg !106
  %idxprom32 = sext i32 %26 to i64, !dbg !103
  %arrayidx33 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx31, i64 0, i64 %idxprom32, !dbg !103
  store double %22, double* %arrayidx33, align 8, !dbg !107
  br label %for.inc34, !dbg !108

for.inc34:                                        ; preds = %for.body25
  %27 = load i32, i32* %p, align 4, !dbg !109
  %inc35 = add nsw i32 %27, 1, !dbg !109
  store i32 %inc35, i32* %p, align 4, !dbg !109
  br label %for.cond23, !dbg !110, !llvm.loop !111

for.end36:                                        ; preds = %for.cond23
  br label %for.inc37, !dbg !113

for.inc37:                                        ; preds = %for.end36
  %28 = load i32, i32* %q, align 4, !dbg !114
  %inc38 = add nsw i32 %28, 1, !dbg !114
  store i32 %inc38, i32* %q, align 4, !dbg !114
  br label %for.cond1, !dbg !115, !llvm.loop !116

for.end39:                                        ; preds = %for.cond1
  br label %for.inc40, !dbg !118

for.inc40:                                        ; preds = %for.end39
  %29 = load i32, i32* %r, align 4, !dbg !119
  %inc41 = add nsw i32 %29, 1, !dbg !119
  store i32 %inc41, i32* %r, align 4, !dbg !119
  br label %for.cond, !dbg !120, !llvm.loop !121

for.end42:                                        ; preds = %for.cond
  ret void, !dbg !123
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "doitgen-red.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/doitgen-red")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_doitgen", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !16, !19}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 38400, elements: !13)
!12 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!13 = !{!14, !15}
!14 = !DISubrange(count: 20)
!15 = !DISubrange(count: 30)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 1920, elements: !18)
!18 = !{!15}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!20 = !DILocalVariable(name: "A", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!21 = !DILocation(line: 3, column: 28, scope: !7)
!22 = !DILocalVariable(name: "C4", arg: 2, scope: !7, file: !1, line: 3, type: !16)
!23 = !DILocation(line: 3, column: 49, scope: !7)
!24 = !DILocalVariable(name: "sum", arg: 3, scope: !7, file: !1, line: 3, type: !19)
!25 = !DILocation(line: 3, column: 67, scope: !7)
!26 = !DILocalVariable(name: "r", scope: !7, file: !1, line: 5, type: !27)
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DILocation(line: 5, column: 7, scope: !7)
!29 = !DILocalVariable(name: "q", scope: !7, file: !1, line: 6, type: !27)
!30 = !DILocation(line: 6, column: 7, scope: !7)
!31 = !DILocalVariable(name: "p", scope: !7, file: !1, line: 7, type: !27)
!32 = !DILocation(line: 7, column: 7, scope: !7)
!33 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 8, type: !27)
!34 = !DILocation(line: 8, column: 7, scope: !7)
!35 = !DILocation(line: 14, column: 10, scope: !36)
!36 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 3)
!37 = !DILocation(line: 14, column: 8, scope: !36)
!38 = !DILocation(line: 14, column: 15, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !1, line: 14, column: 3)
!40 = !DILocation(line: 14, column: 17, scope: !39)
!41 = !DILocation(line: 14, column: 3, scope: !36)
!42 = !DILocation(line: 19, column: 12, scope: !43)
!43 = distinct !DILexicalBlock(scope: !44, file: !1, line: 19, column: 5)
!44 = distinct !DILexicalBlock(scope: !39, file: !1, line: 14, column: 28)
!45 = !DILocation(line: 19, column: 10, scope: !43)
!46 = !DILocation(line: 19, column: 17, scope: !47)
!47 = distinct !DILexicalBlock(scope: !43, file: !1, line: 19, column: 5)
!48 = !DILocation(line: 19, column: 19, scope: !47)
!49 = !DILocation(line: 19, column: 5, scope: !43)
!50 = !DILocation(line: 24, column: 14, scope: !51)
!51 = distinct !DILexicalBlock(scope: !52, file: !1, line: 24, column: 7)
!52 = distinct !DILexicalBlock(scope: !47, file: !1, line: 19, column: 30)
!53 = !DILocation(line: 24, column: 12, scope: !51)
!54 = !DILocation(line: 24, column: 19, scope: !55)
!55 = distinct !DILexicalBlock(scope: !51, file: !1, line: 24, column: 7)
!56 = !DILocation(line: 24, column: 21, scope: !55)
!57 = !DILocation(line: 24, column: 7, scope: !51)
!58 = !DILocalVariable(name: "sum_tmp", scope: !59, file: !1, line: 25, type: !12)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 24, column: 32)
!60 = !DILocation(line: 25, column: 16, scope: !59)
!61 = !DILocation(line: 27, column: 9, scope: !62)
!62 = distinct !DILexicalBlock(scope: !59, file: !1, line: 27, column: 2)
!63 = !DILocation(line: 27, column: 7, scope: !62)
!64 = !DILocation(line: 27, column: 14, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !1, line: 27, column: 2)
!66 = !DILocation(line: 27, column: 16, scope: !65)
!67 = !DILocation(line: 27, column: 2, scope: !62)
!68 = !DILocation(line: 28, column: 22, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 27, column: 27)
!70 = !DILocation(line: 28, column: 24, scope: !69)
!71 = !DILocation(line: 28, column: 27, scope: !69)
!72 = !DILocation(line: 28, column: 30, scope: !69)
!73 = !DILocation(line: 28, column: 35, scope: !69)
!74 = !DILocation(line: 28, column: 38, scope: !69)
!75 = !DILocation(line: 28, column: 41, scope: !69)
!76 = !DILocation(line: 28, column: 33, scope: !69)
!77 = !DILocation(line: 28, column: 19, scope: !69)
!78 = !DILocation(line: 29, column: 9, scope: !69)
!79 = !DILocation(line: 27, column: 23, scope: !65)
!80 = !DILocation(line: 27, column: 2, scope: !65)
!81 = distinct !{!81, !67, !82, !83}
!82 = !DILocation(line: 29, column: 9, scope: !62)
!83 = !{!"llvm.loop.mustprogress"}
!84 = !DILocation(line: 30, column: 11, scope: !59)
!85 = !DILocation(line: 30, column: 2, scope: !59)
!86 = !DILocation(line: 30, column: 6, scope: !59)
!87 = !DILocation(line: 30, column: 9, scope: !59)
!88 = !DILocation(line: 31, column: 7, scope: !59)
!89 = !DILocation(line: 24, column: 28, scope: !55)
!90 = !DILocation(line: 24, column: 7, scope: !55)
!91 = distinct !{!91, !57, !92, !83}
!92 = !DILocation(line: 31, column: 7, scope: !51)
!93 = !DILocation(line: 32, column: 14, scope: !94)
!94 = distinct !DILexicalBlock(scope: !52, file: !1, line: 32, column: 7)
!95 = !DILocation(line: 32, column: 12, scope: !94)
!96 = !DILocation(line: 32, column: 19, scope: !97)
!97 = distinct !DILexicalBlock(scope: !94, file: !1, line: 32, column: 7)
!98 = !DILocation(line: 32, column: 21, scope: !97)
!99 = !DILocation(line: 32, column: 7, scope: !94)
!100 = !DILocation(line: 33, column: 22, scope: !101)
!101 = distinct !DILexicalBlock(scope: !97, file: !1, line: 32, column: 32)
!102 = !DILocation(line: 33, column: 26, scope: !101)
!103 = !DILocation(line: 33, column: 9, scope: !101)
!104 = !DILocation(line: 33, column: 11, scope: !101)
!105 = !DILocation(line: 33, column: 14, scope: !101)
!106 = !DILocation(line: 33, column: 17, scope: !101)
!107 = !DILocation(line: 33, column: 20, scope: !101)
!108 = !DILocation(line: 34, column: 7, scope: !101)
!109 = !DILocation(line: 32, column: 28, scope: !97)
!110 = !DILocation(line: 32, column: 7, scope: !97)
!111 = distinct !{!111, !99, !112, !83}
!112 = !DILocation(line: 34, column: 7, scope: !94)
!113 = !DILocation(line: 35, column: 5, scope: !52)
!114 = !DILocation(line: 19, column: 26, scope: !47)
!115 = !DILocation(line: 19, column: 5, scope: !47)
!116 = distinct !{!116, !49, !117, !83}
!117 = !DILocation(line: 35, column: 5, scope: !43)
!118 = !DILocation(line: 36, column: 3, scope: !44)
!119 = !DILocation(line: 14, column: 24, scope: !39)
!120 = !DILocation(line: 14, column: 3, scope: !39)
!121 = distinct !{!121, !41, !122, !83}
!122 = !DILocation(line: 36, column: 3, scope: !36)
!123 = !DILocation(line: 38, column: 1, scope: !7)
