; ModuleID = 'atax.c'
source_filename = "atax.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_atax(i32 %m, i32 %n, [124 x double]* %A, double* %x, double* %y, double* %tmp) #0 !dbg !9 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [124 x double]*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %tmp.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %m.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store [124 x double]* %A, [124 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [124 x double]** %A.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store double* %tmp, double** %tmp.addr, align 8
  call void @llvm.dbg.declare(metadata double** %tmp.addr, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %i, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %j, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 0, i32* %i, align 4, !dbg !34
  br label %for.cond, !dbg !36

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !37
  %cmp = icmp slt i32 %0, 124, !dbg !39
  br i1 %cmp, label %for.body, label %for.end, !dbg !40

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %y.addr, align 8, !dbg !41
  %2 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %2 to i64, !dbg !41
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !41
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !43
  br label %for.inc, !dbg !41

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !44
  %inc = add nsw i32 %3, 1, !dbg !44
  store i32 %inc, i32* %i, align 4, !dbg !44
  br label %for.cond, !dbg !45, !llvm.loop !46

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !49
  br label %for.cond1, !dbg !51

for.cond1:                                        ; preds = %for.inc36, %for.end
  %4 = load i32, i32* %i, align 4, !dbg !52
  %cmp2 = icmp slt i32 %4, 116, !dbg !54
  br i1 %cmp2, label %for.body3, label %for.end38, !dbg !55

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %tmp.addr, align 8, !dbg !56
  %6 = load i32, i32* %i, align 4, !dbg !58
  %idxprom4 = sext i32 %6 to i64, !dbg !56
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !56
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !59
  store i32 0, i32* %j, align 4, !dbg !60
  br label %for.cond6, !dbg !62

for.cond6:                                        ; preds = %for.inc17, %for.body3
  %7 = load i32, i32* %j, align 4, !dbg !63
  %cmp7 = icmp slt i32 %7, 124, !dbg !65
  br i1 %cmp7, label %for.body8, label %for.end19, !dbg !66

for.body8:                                        ; preds = %for.cond6
  %8 = load [124 x double]*, [124 x double]** %A.addr, align 8, !dbg !67
  %9 = load i32, i32* %i, align 4, !dbg !69
  %idxprom9 = sext i32 %9 to i64, !dbg !67
  %arrayidx10 = getelementptr inbounds [124 x double], [124 x double]* %8, i64 %idxprom9, !dbg !67
  %10 = load i32, i32* %j, align 4, !dbg !70
  %idxprom11 = sext i32 %10 to i64, !dbg !67
  %arrayidx12 = getelementptr inbounds [124 x double], [124 x double]* %arrayidx10, i64 0, i64 %idxprom11, !dbg !67
  %11 = load double, double* %arrayidx12, align 8, !dbg !67
  %12 = load double*, double** %x.addr, align 8, !dbg !71
  %13 = load i32, i32* %j, align 4, !dbg !72
  %idxprom13 = sext i32 %13 to i64, !dbg !71
  %arrayidx14 = getelementptr inbounds double, double* %12, i64 %idxprom13, !dbg !71
  %14 = load double, double* %arrayidx14, align 8, !dbg !71
  %mul = fmul double %11, %14, !dbg !73
  %15 = load double*, double** %tmp.addr, align 8, !dbg !74
  %16 = load i32, i32* %i, align 4, !dbg !75
  %idxprom15 = sext i32 %16 to i64, !dbg !74
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15, !dbg !74
  %17 = load double, double* %arrayidx16, align 8, !dbg !76
  %add = fadd double %17, %mul, !dbg !76
  store double %add, double* %arrayidx16, align 8, !dbg !76
  br label %for.inc17, !dbg !77

for.inc17:                                        ; preds = %for.body8
  %18 = load i32, i32* %j, align 4, !dbg !78
  %inc18 = add nsw i32 %18, 1, !dbg !78
  store i32 %inc18, i32* %j, align 4, !dbg !78
  br label %for.cond6, !dbg !79, !llvm.loop !80

for.end19:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4, !dbg !82
  br label %for.cond20, !dbg !84

for.cond20:                                       ; preds = %for.inc33, %for.end19
  %19 = load i32, i32* %j, align 4, !dbg !85
  %cmp21 = icmp slt i32 %19, 124, !dbg !87
  br i1 %cmp21, label %for.body22, label %for.end35, !dbg !88

for.body22:                                       ; preds = %for.cond20
  %20 = load [124 x double]*, [124 x double]** %A.addr, align 8, !dbg !89
  %21 = load i32, i32* %i, align 4, !dbg !91
  %idxprom23 = sext i32 %21 to i64, !dbg !89
  %arrayidx24 = getelementptr inbounds [124 x double], [124 x double]* %20, i64 %idxprom23, !dbg !89
  %22 = load i32, i32* %j, align 4, !dbg !92
  %idxprom25 = sext i32 %22 to i64, !dbg !89
  %arrayidx26 = getelementptr inbounds [124 x double], [124 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !89
  %23 = load double, double* %arrayidx26, align 8, !dbg !89
  %24 = load double*, double** %tmp.addr, align 8, !dbg !93
  %25 = load i32, i32* %i, align 4, !dbg !94
  %idxprom27 = sext i32 %25 to i64, !dbg !93
  %arrayidx28 = getelementptr inbounds double, double* %24, i64 %idxprom27, !dbg !93
  %26 = load double, double* %arrayidx28, align 8, !dbg !93
  %mul29 = fmul double %23, %26, !dbg !95
  %27 = load double*, double** %y.addr, align 8, !dbg !96
  %28 = load i32, i32* %j, align 4, !dbg !97
  %idxprom30 = sext i32 %28 to i64, !dbg !96
  %arrayidx31 = getelementptr inbounds double, double* %27, i64 %idxprom30, !dbg !96
  %29 = load double, double* %arrayidx31, align 8, !dbg !98
  %add32 = fadd double %29, %mul29, !dbg !98
  store double %add32, double* %arrayidx31, align 8, !dbg !98
  br label %for.inc33, !dbg !99

for.inc33:                                        ; preds = %for.body22
  %30 = load i32, i32* %j, align 4, !dbg !100
  %inc34 = add nsw i32 %30, 1, !dbg !100
  store i32 %inc34, i32* %j, align 4, !dbg !100
  br label %for.cond20, !dbg !101, !llvm.loop !102

for.end35:                                        ; preds = %for.cond20
  br label %for.inc36, !dbg !104

for.inc36:                                        ; preds = %for.end35
  %31 = load i32, i32* %i, align 4, !dbg !105
  %inc37 = add nsw i32 %31, 1, !dbg !105
  store i32 %inc37, i32* %i, align 4, !dbg !105
  br label %for.cond1, !dbg !106, !llvm.loop !107

for.end38:                                        ; preds = %for.cond1
  ret void, !dbg !109
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "atax.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/atax")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "kernel_atax", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !12, !13, !17, !17, !17}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 7936, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 124)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!18 = !DILocalVariable(name: "m", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!19 = !DILocation(line: 3, column: 22, scope: !9)
!20 = !DILocalVariable(name: "n", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!21 = !DILocation(line: 3, column: 28, scope: !9)
!22 = !DILocalVariable(name: "A", arg: 3, scope: !9, file: !1, line: 3, type: !13)
!23 = !DILocation(line: 3, column: 37, scope: !9)
!24 = !DILocalVariable(name: "x", arg: 4, scope: !9, file: !1, line: 3, type: !17)
!25 = !DILocation(line: 3, column: 56, scope: !9)
!26 = !DILocalVariable(name: "y", arg: 5, scope: !9, file: !1, line: 3, type: !17)
!27 = !DILocation(line: 3, column: 70, scope: !9)
!28 = !DILocalVariable(name: "tmp", arg: 6, scope: !9, file: !1, line: 3, type: !17)
!29 = !DILocation(line: 3, column: 84, scope: !9)
!30 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 5, type: !12)
!31 = !DILocation(line: 5, column: 7, scope: !9)
!32 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 6, type: !12)
!33 = !DILocation(line: 6, column: 7, scope: !9)
!34 = !DILocation(line: 8, column: 10, scope: !35)
!35 = distinct !DILexicalBlock(scope: !9, file: !1, line: 8, column: 3)
!36 = !DILocation(line: 8, column: 8, scope: !35)
!37 = !DILocation(line: 8, column: 15, scope: !38)
!38 = distinct !DILexicalBlock(scope: !35, file: !1, line: 8, column: 3)
!39 = !DILocation(line: 8, column: 17, scope: !38)
!40 = !DILocation(line: 8, column: 3, scope: !35)
!41 = !DILocation(line: 9, column: 5, scope: !38)
!42 = !DILocation(line: 9, column: 7, scope: !38)
!43 = !DILocation(line: 9, column: 10, scope: !38)
!44 = !DILocation(line: 8, column: 25, scope: !38)
!45 = !DILocation(line: 8, column: 3, scope: !38)
!46 = distinct !{!46, !40, !47, !48}
!47 = !DILocation(line: 9, column: 23, scope: !35)
!48 = !{!"llvm.loop.mustprogress"}
!49 = !DILocation(line: 16, column: 10, scope: !50)
!50 = distinct !DILexicalBlock(scope: !9, file: !1, line: 16, column: 3)
!51 = !DILocation(line: 16, column: 8, scope: !50)
!52 = !DILocation(line: 16, column: 15, scope: !53)
!53 = distinct !DILexicalBlock(scope: !50, file: !1, line: 16, column: 3)
!54 = !DILocation(line: 16, column: 17, scope: !53)
!55 = !DILocation(line: 16, column: 3, scope: !50)
!56 = !DILocation(line: 17, column: 5, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 16, column: 29)
!58 = !DILocation(line: 17, column: 9, scope: !57)
!59 = !DILocation(line: 17, column: 12, scope: !57)
!60 = !DILocation(line: 20, column: 12, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 20, column: 5)
!62 = !DILocation(line: 20, column: 10, scope: !61)
!63 = !DILocation(line: 20, column: 17, scope: !64)
!64 = distinct !DILexicalBlock(scope: !61, file: !1, line: 20, column: 5)
!65 = !DILocation(line: 20, column: 19, scope: !64)
!66 = !DILocation(line: 20, column: 5, scope: !61)
!67 = !DILocation(line: 21, column: 17, scope: !68)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 20, column: 31)
!69 = !DILocation(line: 21, column: 19, scope: !68)
!70 = !DILocation(line: 21, column: 22, scope: !68)
!71 = !DILocation(line: 21, column: 27, scope: !68)
!72 = !DILocation(line: 21, column: 29, scope: !68)
!73 = !DILocation(line: 21, column: 25, scope: !68)
!74 = !DILocation(line: 21, column: 7, scope: !68)
!75 = !DILocation(line: 21, column: 11, scope: !68)
!76 = !DILocation(line: 21, column: 14, scope: !68)
!77 = !DILocation(line: 22, column: 5, scope: !68)
!78 = !DILocation(line: 20, column: 27, scope: !64)
!79 = !DILocation(line: 20, column: 5, scope: !64)
!80 = distinct !{!80, !66, !81, !48}
!81 = !DILocation(line: 22, column: 5, scope: !61)
!82 = !DILocation(line: 25, column: 12, scope: !83)
!83 = distinct !DILexicalBlock(scope: !57, file: !1, line: 25, column: 5)
!84 = !DILocation(line: 25, column: 10, scope: !83)
!85 = !DILocation(line: 25, column: 17, scope: !86)
!86 = distinct !DILexicalBlock(scope: !83, file: !1, line: 25, column: 5)
!87 = !DILocation(line: 25, column: 19, scope: !86)
!88 = !DILocation(line: 25, column: 5, scope: !83)
!89 = !DILocation(line: 26, column: 15, scope: !90)
!90 = distinct !DILexicalBlock(scope: !86, file: !1, line: 25, column: 31)
!91 = !DILocation(line: 26, column: 17, scope: !90)
!92 = !DILocation(line: 26, column: 20, scope: !90)
!93 = !DILocation(line: 26, column: 25, scope: !90)
!94 = !DILocation(line: 26, column: 29, scope: !90)
!95 = !DILocation(line: 26, column: 23, scope: !90)
!96 = !DILocation(line: 26, column: 7, scope: !90)
!97 = !DILocation(line: 26, column: 9, scope: !90)
!98 = !DILocation(line: 26, column: 12, scope: !90)
!99 = !DILocation(line: 27, column: 5, scope: !90)
!100 = !DILocation(line: 25, column: 27, scope: !86)
!101 = !DILocation(line: 25, column: 5, scope: !86)
!102 = distinct !{!102, !88, !103, !48}
!103 = !DILocation(line: 27, column: 5, scope: !83)
!104 = !DILocation(line: 28, column: 3, scope: !57)
!105 = !DILocation(line: 16, column: 25, scope: !53)
!106 = !DILocation(line: 16, column: 3, scope: !53)
!107 = distinct !{!107, !55, !108, !48}
!108 = !DILocation(line: 28, column: 3, scope: !50)
!109 = !DILocation(line: 30, column: 1, scope: !9)
