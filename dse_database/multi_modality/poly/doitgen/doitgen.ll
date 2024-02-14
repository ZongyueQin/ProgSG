; ModuleID = 'doitgen.c'
source_filename = "doitgen.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_doitgen(i32 %nr, i32 %nq, i32 %np, [20 x [30 x double]]* %A, [30 x double]* %C4, double* %sum) #0 !dbg !7 {
entry:
  %nr.addr = alloca i32, align 4
  %nq.addr = alloca i32, align 4
  %np.addr = alloca i32, align 4
  %A.addr = alloca [20 x [30 x double]]*, align 8
  %C4.addr = alloca [30 x double]*, align 8
  %sum.addr = alloca double*, align 8
  %r = alloca i32, align 4
  %q = alloca i32, align 4
  %p = alloca i32, align 4
  %s = alloca i32, align 4
  store i32 %nr, i32* %nr.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nr.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 %nq, i32* %nq.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nq.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store i32 %np, i32* %np.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %np.addr, metadata !25, metadata !DIExpression()), !dbg !26
  store [20 x [30 x double]]* %A, [20 x [30 x double]]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [20 x [30 x double]]** %A.addr, metadata !27, metadata !DIExpression()), !dbg !28
  store [30 x double]* %C4, [30 x double]** %C4.addr, align 8
  call void @llvm.dbg.declare(metadata [30 x double]** %C4.addr, metadata !29, metadata !DIExpression()), !dbg !30
  store double* %sum, double** %sum.addr, align 8
  call void @llvm.dbg.declare(metadata double** %sum.addr, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %r, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %q, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata i32* %p, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata i32* %s, metadata !39, metadata !DIExpression()), !dbg !40
  store i32 0, i32* %r, align 4, !dbg !41
  br label %for.cond, !dbg !43

for.cond:                                         ; preds = %for.inc42, %entry
  %0 = load i32, i32* %r, align 4, !dbg !44
  %cmp = icmp slt i32 %0, 25, !dbg !46
  br i1 %cmp, label %for.body, label %for.end44, !dbg !47

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %q, align 4, !dbg !48
  br label %for.cond1, !dbg !51

for.cond1:                                        ; preds = %for.inc39, %for.body
  %1 = load i32, i32* %q, align 4, !dbg !52
  %cmp2 = icmp slt i32 %1, 20, !dbg !54
  br i1 %cmp2, label %for.body3, label %for.end41, !dbg !55

for.body3:                                        ; preds = %for.cond1
  store i32 0, i32* %p, align 4, !dbg !56
  br label %for.cond4, !dbg !59

for.cond4:                                        ; preds = %for.inc22, %for.body3
  %2 = load i32, i32* %p, align 4, !dbg !60
  %cmp5 = icmp slt i32 %2, 30, !dbg !62
  br i1 %cmp5, label %for.body6, label %for.end24, !dbg !63

for.body6:                                        ; preds = %for.cond4
  %3 = load double*, double** %sum.addr, align 8, !dbg !64
  %4 = load i32, i32* %p, align 4, !dbg !66
  %idxprom = sext i32 %4 to i64, !dbg !64
  %arrayidx = getelementptr inbounds double, double* %3, i64 %idxprom, !dbg !64
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !67
  store i32 0, i32* %s, align 4, !dbg !68
  br label %for.cond7, !dbg !70

for.cond7:                                        ; preds = %for.inc, %for.body6
  %5 = load i32, i32* %s, align 4, !dbg !71
  %cmp8 = icmp slt i32 %5, 30, !dbg !73
  br i1 %cmp8, label %for.body9, label %for.end, !dbg !74

for.body9:                                        ; preds = %for.cond7
  %6 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8, !dbg !75
  %7 = load i32, i32* %r, align 4, !dbg !77
  %idxprom10 = sext i32 %7 to i64, !dbg !75
  %arrayidx11 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %6, i64 %idxprom10, !dbg !75
  %8 = load i32, i32* %q, align 4, !dbg !78
  %idxprom12 = sext i32 %8 to i64, !dbg !75
  %arrayidx13 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx11, i64 0, i64 %idxprom12, !dbg !75
  %9 = load i32, i32* %s, align 4, !dbg !79
  %idxprom14 = sext i32 %9 to i64, !dbg !75
  %arrayidx15 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx13, i64 0, i64 %idxprom14, !dbg !75
  %10 = load double, double* %arrayidx15, align 8, !dbg !75
  %11 = load [30 x double]*, [30 x double]** %C4.addr, align 8, !dbg !80
  %12 = load i32, i32* %s, align 4, !dbg !81
  %idxprom16 = sext i32 %12 to i64, !dbg !80
  %arrayidx17 = getelementptr inbounds [30 x double], [30 x double]* %11, i64 %idxprom16, !dbg !80
  %13 = load i32, i32* %p, align 4, !dbg !82
  %idxprom18 = sext i32 %13 to i64, !dbg !80
  %arrayidx19 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx17, i64 0, i64 %idxprom18, !dbg !80
  %14 = load double, double* %arrayidx19, align 8, !dbg !80
  %mul = fmul double %10, %14, !dbg !83
  %15 = load double*, double** %sum.addr, align 8, !dbg !84
  %16 = load i32, i32* %p, align 4, !dbg !85
  %idxprom20 = sext i32 %16 to i64, !dbg !84
  %arrayidx21 = getelementptr inbounds double, double* %15, i64 %idxprom20, !dbg !84
  %17 = load double, double* %arrayidx21, align 8, !dbg !86
  %add = fadd double %17, %mul, !dbg !86
  store double %add, double* %arrayidx21, align 8, !dbg !86
  br label %for.inc, !dbg !87

for.inc:                                          ; preds = %for.body9
  %18 = load i32, i32* %s, align 4, !dbg !88
  %inc = add nsw i32 %18, 1, !dbg !88
  store i32 %inc, i32* %s, align 4, !dbg !88
  br label %for.cond7, !dbg !89, !llvm.loop !90

for.end:                                          ; preds = %for.cond7
  br label %for.inc22, !dbg !93

for.inc22:                                        ; preds = %for.end
  %19 = load i32, i32* %p, align 4, !dbg !94
  %inc23 = add nsw i32 %19, 1, !dbg !94
  store i32 %inc23, i32* %p, align 4, !dbg !94
  br label %for.cond4, !dbg !95, !llvm.loop !96

for.end24:                                        ; preds = %for.cond4
  store i32 0, i32* %p, align 4, !dbg !98
  br label %for.cond25, !dbg !100

for.cond25:                                       ; preds = %for.inc36, %for.end24
  %20 = load i32, i32* %p, align 4, !dbg !101
  %cmp26 = icmp slt i32 %20, 30, !dbg !103
  br i1 %cmp26, label %for.body27, label %for.end38, !dbg !104

for.body27:                                       ; preds = %for.cond25
  %21 = load double*, double** %sum.addr, align 8, !dbg !105
  %22 = load i32, i32* %p, align 4, !dbg !107
  %idxprom28 = sext i32 %22 to i64, !dbg !105
  %arrayidx29 = getelementptr inbounds double, double* %21, i64 %idxprom28, !dbg !105
  %23 = load double, double* %arrayidx29, align 8, !dbg !105
  %24 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8, !dbg !108
  %25 = load i32, i32* %r, align 4, !dbg !109
  %idxprom30 = sext i32 %25 to i64, !dbg !108
  %arrayidx31 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %24, i64 %idxprom30, !dbg !108
  %26 = load i32, i32* %q, align 4, !dbg !110
  %idxprom32 = sext i32 %26 to i64, !dbg !108
  %arrayidx33 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx31, i64 0, i64 %idxprom32, !dbg !108
  %27 = load i32, i32* %p, align 4, !dbg !111
  %idxprom34 = sext i32 %27 to i64, !dbg !108
  %arrayidx35 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx33, i64 0, i64 %idxprom34, !dbg !108
  store double %23, double* %arrayidx35, align 8, !dbg !112
  br label %for.inc36, !dbg !113

for.inc36:                                        ; preds = %for.body27
  %28 = load i32, i32* %p, align 4, !dbg !114
  %inc37 = add nsw i32 %28, 1, !dbg !114
  store i32 %inc37, i32* %p, align 4, !dbg !114
  br label %for.cond25, !dbg !115, !llvm.loop !116

for.end38:                                        ; preds = %for.cond25
  br label %for.inc39, !dbg !118

for.inc39:                                        ; preds = %for.end38
  %29 = load i32, i32* %q, align 4, !dbg !119
  %inc40 = add nsw i32 %29, 1, !dbg !119
  store i32 %inc40, i32* %q, align 4, !dbg !119
  br label %for.cond1, !dbg !120, !llvm.loop !121

for.end41:                                        ; preds = %for.cond1
  br label %for.inc42, !dbg !123

for.inc42:                                        ; preds = %for.end41
  %30 = load i32, i32* %r, align 4, !dbg !124
  %inc43 = add nsw i32 %30, 1, !dbg !124
  store i32 %inc43, i32* %r, align 4, !dbg !124
  br label %for.cond, !dbg !125, !llvm.loop !126

for.end44:                                        ; preds = %for.cond
  ret void, !dbg !128
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "doitgen.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/doitgen")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_doitgen", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !10, !11, !17, !20}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 38400, elements: !14)
!13 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!14 = !{!15, !16}
!15 = !DISubrange(count: 20)
!16 = !DISubrange(count: 30)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 1920, elements: !19)
!19 = !{!16}
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!21 = !DILocalVariable(name: "nr", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!22 = !DILocation(line: 3, column: 25, scope: !7)
!23 = !DILocalVariable(name: "nq", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!24 = !DILocation(line: 3, column: 32, scope: !7)
!25 = !DILocalVariable(name: "np", arg: 3, scope: !7, file: !1, line: 3, type: !10)
!26 = !DILocation(line: 3, column: 39, scope: !7)
!27 = !DILocalVariable(name: "A", arg: 4, scope: !7, file: !1, line: 3, type: !11)
!28 = !DILocation(line: 3, column: 49, scope: !7)
!29 = !DILocalVariable(name: "C4", arg: 5, scope: !7, file: !1, line: 3, type: !17)
!30 = !DILocation(line: 3, column: 70, scope: !7)
!31 = !DILocalVariable(name: "sum", arg: 6, scope: !7, file: !1, line: 3, type: !20)
!32 = !DILocation(line: 3, column: 88, scope: !7)
!33 = !DILocalVariable(name: "r", scope: !7, file: !1, line: 5, type: !10)
!34 = !DILocation(line: 5, column: 7, scope: !7)
!35 = !DILocalVariable(name: "q", scope: !7, file: !1, line: 6, type: !10)
!36 = !DILocation(line: 6, column: 7, scope: !7)
!37 = !DILocalVariable(name: "p", scope: !7, file: !1, line: 7, type: !10)
!38 = !DILocation(line: 7, column: 7, scope: !7)
!39 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 8, type: !10)
!40 = !DILocation(line: 8, column: 7, scope: !7)
!41 = !DILocation(line: 14, column: 10, scope: !42)
!42 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 3)
!43 = !DILocation(line: 14, column: 8, scope: !42)
!44 = !DILocation(line: 14, column: 15, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 14, column: 3)
!46 = !DILocation(line: 14, column: 17, scope: !45)
!47 = !DILocation(line: 14, column: 3, scope: !42)
!48 = !DILocation(line: 19, column: 12, scope: !49)
!49 = distinct !DILexicalBlock(scope: !50, file: !1, line: 19, column: 5)
!50 = distinct !DILexicalBlock(scope: !45, file: !1, line: 14, column: 28)
!51 = !DILocation(line: 19, column: 10, scope: !49)
!52 = !DILocation(line: 19, column: 17, scope: !53)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 19, column: 5)
!54 = !DILocation(line: 19, column: 19, scope: !53)
!55 = !DILocation(line: 19, column: 5, scope: !49)
!56 = !DILocation(line: 24, column: 14, scope: !57)
!57 = distinct !DILexicalBlock(scope: !58, file: !1, line: 24, column: 7)
!58 = distinct !DILexicalBlock(scope: !53, file: !1, line: 19, column: 30)
!59 = !DILocation(line: 24, column: 12, scope: !57)
!60 = !DILocation(line: 24, column: 19, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 24, column: 7)
!62 = !DILocation(line: 24, column: 21, scope: !61)
!63 = !DILocation(line: 24, column: 7, scope: !57)
!64 = !DILocation(line: 25, column: 9, scope: !65)
!65 = distinct !DILexicalBlock(scope: !61, file: !1, line: 24, column: 32)
!66 = !DILocation(line: 25, column: 13, scope: !65)
!67 = !DILocation(line: 25, column: 16, scope: !65)
!68 = !DILocation(line: 26, column: 16, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 26, column: 9)
!70 = !DILocation(line: 26, column: 14, scope: !69)
!71 = !DILocation(line: 26, column: 21, scope: !72)
!72 = distinct !DILexicalBlock(scope: !69, file: !1, line: 26, column: 9)
!73 = !DILocation(line: 26, column: 23, scope: !72)
!74 = !DILocation(line: 26, column: 9, scope: !69)
!75 = !DILocation(line: 27, column: 21, scope: !76)
!76 = distinct !DILexicalBlock(scope: !72, file: !1, line: 26, column: 34)
!77 = !DILocation(line: 27, column: 23, scope: !76)
!78 = !DILocation(line: 27, column: 26, scope: !76)
!79 = !DILocation(line: 27, column: 29, scope: !76)
!80 = !DILocation(line: 27, column: 34, scope: !76)
!81 = !DILocation(line: 27, column: 37, scope: !76)
!82 = !DILocation(line: 27, column: 40, scope: !76)
!83 = !DILocation(line: 27, column: 32, scope: !76)
!84 = !DILocation(line: 27, column: 11, scope: !76)
!85 = !DILocation(line: 27, column: 15, scope: !76)
!86 = !DILocation(line: 27, column: 18, scope: !76)
!87 = !DILocation(line: 28, column: 9, scope: !76)
!88 = !DILocation(line: 26, column: 30, scope: !72)
!89 = !DILocation(line: 26, column: 9, scope: !72)
!90 = distinct !{!90, !74, !91, !92}
!91 = !DILocation(line: 28, column: 9, scope: !69)
!92 = !{!"llvm.loop.mustprogress"}
!93 = !DILocation(line: 29, column: 7, scope: !65)
!94 = !DILocation(line: 24, column: 28, scope: !61)
!95 = !DILocation(line: 24, column: 7, scope: !61)
!96 = distinct !{!96, !63, !97, !92}
!97 = !DILocation(line: 29, column: 7, scope: !57)
!98 = !DILocation(line: 30, column: 14, scope: !99)
!99 = distinct !DILexicalBlock(scope: !58, file: !1, line: 30, column: 7)
!100 = !DILocation(line: 30, column: 12, scope: !99)
!101 = !DILocation(line: 30, column: 19, scope: !102)
!102 = distinct !DILexicalBlock(scope: !99, file: !1, line: 30, column: 7)
!103 = !DILocation(line: 30, column: 21, scope: !102)
!104 = !DILocation(line: 30, column: 7, scope: !99)
!105 = !DILocation(line: 31, column: 22, scope: !106)
!106 = distinct !DILexicalBlock(scope: !102, file: !1, line: 30, column: 32)
!107 = !DILocation(line: 31, column: 26, scope: !106)
!108 = !DILocation(line: 31, column: 9, scope: !106)
!109 = !DILocation(line: 31, column: 11, scope: !106)
!110 = !DILocation(line: 31, column: 14, scope: !106)
!111 = !DILocation(line: 31, column: 17, scope: !106)
!112 = !DILocation(line: 31, column: 20, scope: !106)
!113 = !DILocation(line: 32, column: 7, scope: !106)
!114 = !DILocation(line: 30, column: 28, scope: !102)
!115 = !DILocation(line: 30, column: 7, scope: !102)
!116 = distinct !{!116, !104, !117, !92}
!117 = !DILocation(line: 32, column: 7, scope: !99)
!118 = !DILocation(line: 33, column: 5, scope: !58)
!119 = !DILocation(line: 19, column: 26, scope: !53)
!120 = !DILocation(line: 19, column: 5, scope: !53)
!121 = distinct !{!121, !55, !122, !92}
!122 = !DILocation(line: 33, column: 5, scope: !49)
!123 = !DILocation(line: 34, column: 3, scope: !50)
!124 = !DILocation(line: 14, column: 24, scope: !45)
!125 = !DILocation(line: 14, column: 3, scope: !45)
!126 = distinct !{!126, !47, !127, !92}
!127 = !DILocation(line: 34, column: 3, scope: !42)
!128 = !DILocation(line: 36, column: 1, scope: !7)
