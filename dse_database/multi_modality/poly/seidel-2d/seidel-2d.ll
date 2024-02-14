; ModuleID = 'seidel-2d.c'
source_filename = "seidel-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_seidel_2d(i32 %tsteps, i32 %n, [120 x double]* %A) #0 !dbg !7 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [120 x double]*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %tsteps.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store [120 x double]* %A, [120 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [120 x double]** %A.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %t, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %i, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %j, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 0, i32* %t, align 4, !dbg !28
  br label %for.cond, !dbg !30

for.cond:                                         ; preds = %for.inc66, %entry
  %0 = load i32, i32* %t, align 4, !dbg !31
  %cmp = icmp sle i32 %0, 39, !dbg !33
  br i1 %cmp, label %for.body, label %for.end68, !dbg !34

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4, !dbg !35
  br label %for.cond1, !dbg !38

for.cond1:                                        ; preds = %for.inc63, %for.body
  %1 = load i32, i32* %i, align 4, !dbg !39
  %cmp2 = icmp sle i32 %1, 118, !dbg !41
  br i1 %cmp2, label %for.body3, label %for.end65, !dbg !42

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4, !dbg !43
  br label %for.cond4, !dbg !46

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %j, align 4, !dbg !47
  %cmp5 = icmp sle i32 %2, 118, !dbg !49
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !50

for.body6:                                        ; preds = %for.cond4
  %3 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !51
  %4 = load i32, i32* %i, align 4, !dbg !53
  %sub = sub nsw i32 %4, 1, !dbg !54
  %idxprom = sext i32 %sub to i64, !dbg !51
  %arrayidx = getelementptr inbounds [120 x double], [120 x double]* %3, i64 %idxprom, !dbg !51
  %5 = load i32, i32* %j, align 4, !dbg !55
  %sub7 = sub nsw i32 %5, 1, !dbg !56
  %idxprom8 = sext i32 %sub7 to i64, !dbg !51
  %arrayidx9 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx, i64 0, i64 %idxprom8, !dbg !51
  %6 = load double, double* %arrayidx9, align 8, !dbg !51
  %7 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !57
  %8 = load i32, i32* %i, align 4, !dbg !58
  %sub10 = sub nsw i32 %8, 1, !dbg !59
  %idxprom11 = sext i32 %sub10 to i64, !dbg !57
  %arrayidx12 = getelementptr inbounds [120 x double], [120 x double]* %7, i64 %idxprom11, !dbg !57
  %9 = load i32, i32* %j, align 4, !dbg !60
  %idxprom13 = sext i32 %9 to i64, !dbg !57
  %arrayidx14 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !57
  %10 = load double, double* %arrayidx14, align 8, !dbg !57
  %add = fadd double %6, %10, !dbg !61
  %11 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !62
  %12 = load i32, i32* %i, align 4, !dbg !63
  %sub15 = sub nsw i32 %12, 1, !dbg !64
  %idxprom16 = sext i32 %sub15 to i64, !dbg !62
  %arrayidx17 = getelementptr inbounds [120 x double], [120 x double]* %11, i64 %idxprom16, !dbg !62
  %13 = load i32, i32* %j, align 4, !dbg !65
  %add18 = add nsw i32 %13, 1, !dbg !66
  %idxprom19 = sext i32 %add18 to i64, !dbg !62
  %arrayidx20 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx17, i64 0, i64 %idxprom19, !dbg !62
  %14 = load double, double* %arrayidx20, align 8, !dbg !62
  %add21 = fadd double %add, %14, !dbg !67
  %15 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !68
  %16 = load i32, i32* %i, align 4, !dbg !69
  %idxprom22 = sext i32 %16 to i64, !dbg !68
  %arrayidx23 = getelementptr inbounds [120 x double], [120 x double]* %15, i64 %idxprom22, !dbg !68
  %17 = load i32, i32* %j, align 4, !dbg !70
  %sub24 = sub nsw i32 %17, 1, !dbg !71
  %idxprom25 = sext i32 %sub24 to i64, !dbg !68
  %arrayidx26 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx23, i64 0, i64 %idxprom25, !dbg !68
  %18 = load double, double* %arrayidx26, align 8, !dbg !68
  %add27 = fadd double %add21, %18, !dbg !72
  %19 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !73
  %20 = load i32, i32* %i, align 4, !dbg !74
  %idxprom28 = sext i32 %20 to i64, !dbg !73
  %arrayidx29 = getelementptr inbounds [120 x double], [120 x double]* %19, i64 %idxprom28, !dbg !73
  %21 = load i32, i32* %j, align 4, !dbg !75
  %idxprom30 = sext i32 %21 to i64, !dbg !73
  %arrayidx31 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx29, i64 0, i64 %idxprom30, !dbg !73
  %22 = load double, double* %arrayidx31, align 8, !dbg !73
  %add32 = fadd double %add27, %22, !dbg !76
  %23 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !77
  %24 = load i32, i32* %i, align 4, !dbg !78
  %idxprom33 = sext i32 %24 to i64, !dbg !77
  %arrayidx34 = getelementptr inbounds [120 x double], [120 x double]* %23, i64 %idxprom33, !dbg !77
  %25 = load i32, i32* %j, align 4, !dbg !79
  %add35 = add nsw i32 %25, 1, !dbg !80
  %idxprom36 = sext i32 %add35 to i64, !dbg !77
  %arrayidx37 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx34, i64 0, i64 %idxprom36, !dbg !77
  %26 = load double, double* %arrayidx37, align 8, !dbg !77
  %add38 = fadd double %add32, %26, !dbg !81
  %27 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !82
  %28 = load i32, i32* %i, align 4, !dbg !83
  %add39 = add nsw i32 %28, 1, !dbg !84
  %idxprom40 = sext i32 %add39 to i64, !dbg !82
  %arrayidx41 = getelementptr inbounds [120 x double], [120 x double]* %27, i64 %idxprom40, !dbg !82
  %29 = load i32, i32* %j, align 4, !dbg !85
  %sub42 = sub nsw i32 %29, 1, !dbg !86
  %idxprom43 = sext i32 %sub42 to i64, !dbg !82
  %arrayidx44 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx41, i64 0, i64 %idxprom43, !dbg !82
  %30 = load double, double* %arrayidx44, align 8, !dbg !82
  %add45 = fadd double %add38, %30, !dbg !87
  %31 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !88
  %32 = load i32, i32* %i, align 4, !dbg !89
  %add46 = add nsw i32 %32, 1, !dbg !90
  %idxprom47 = sext i32 %add46 to i64, !dbg !88
  %arrayidx48 = getelementptr inbounds [120 x double], [120 x double]* %31, i64 %idxprom47, !dbg !88
  %33 = load i32, i32* %j, align 4, !dbg !91
  %idxprom49 = sext i32 %33 to i64, !dbg !88
  %arrayidx50 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx48, i64 0, i64 %idxprom49, !dbg !88
  %34 = load double, double* %arrayidx50, align 8, !dbg !88
  %add51 = fadd double %add45, %34, !dbg !92
  %35 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !93
  %36 = load i32, i32* %i, align 4, !dbg !94
  %add52 = add nsw i32 %36, 1, !dbg !95
  %idxprom53 = sext i32 %add52 to i64, !dbg !93
  %arrayidx54 = getelementptr inbounds [120 x double], [120 x double]* %35, i64 %idxprom53, !dbg !93
  %37 = load i32, i32* %j, align 4, !dbg !96
  %add55 = add nsw i32 %37, 1, !dbg !97
  %idxprom56 = sext i32 %add55 to i64, !dbg !93
  %arrayidx57 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx54, i64 0, i64 %idxprom56, !dbg !93
  %38 = load double, double* %arrayidx57, align 8, !dbg !93
  %add58 = fadd double %add51, %38, !dbg !98
  %div = fdiv double %add58, 9.000000e+00, !dbg !99
  %39 = load [120 x double]*, [120 x double]** %A.addr, align 8, !dbg !100
  %40 = load i32, i32* %i, align 4, !dbg !101
  %idxprom59 = sext i32 %40 to i64, !dbg !100
  %arrayidx60 = getelementptr inbounds [120 x double], [120 x double]* %39, i64 %idxprom59, !dbg !100
  %41 = load i32, i32* %j, align 4, !dbg !102
  %idxprom61 = sext i32 %41 to i64, !dbg !100
  %arrayidx62 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx60, i64 0, i64 %idxprom61, !dbg !100
  store double %div, double* %arrayidx62, align 8, !dbg !103
  br label %for.inc, !dbg !104

for.inc:                                          ; preds = %for.body6
  %42 = load i32, i32* %j, align 4, !dbg !105
  %inc = add nsw i32 %42, 1, !dbg !105
  store i32 %inc, i32* %j, align 4, !dbg !105
  br label %for.cond4, !dbg !106, !llvm.loop !107

for.end:                                          ; preds = %for.cond4
  br label %for.inc63, !dbg !110

for.inc63:                                        ; preds = %for.end
  %43 = load i32, i32* %i, align 4, !dbg !111
  %inc64 = add nsw i32 %43, 1, !dbg !111
  store i32 %inc64, i32* %i, align 4, !dbg !111
  br label %for.cond1, !dbg !112, !llvm.loop !113

for.end65:                                        ; preds = %for.cond1
  br label %for.inc66, !dbg !115

for.inc66:                                        ; preds = %for.end65
  %44 = load i32, i32* %t, align 4, !dbg !116
  %inc67 = add nsw i32 %44, 1, !dbg !116
  store i32 %inc67, i32* %t, align 4, !dbg !116
  br label %for.cond, !dbg !117, !llvm.loop !118

for.end68:                                        ; preds = %for.cond
  ret void, !dbg !120
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "seidel-2d.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/seidel-2d")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_seidel_2d", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 7680, elements: !14)
!13 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!14 = !{!15}
!15 = !DISubrange(count: 120)
!16 = !DILocalVariable(name: "tsteps", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 27, scope: !7)
!18 = !DILocalVariable(name: "n", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!19 = !DILocation(line: 3, column: 38, scope: !7)
!20 = !DILocalVariable(name: "A", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!21 = !DILocation(line: 3, column: 47, scope: !7)
!22 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 5, type: !10)
!23 = !DILocation(line: 5, column: 7, scope: !7)
!24 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 6, type: !10)
!25 = !DILocation(line: 6, column: 7, scope: !7)
!26 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 7, type: !10)
!27 = !DILocation(line: 7, column: 7, scope: !7)
!28 = !DILocation(line: 15, column: 10, scope: !29)
!29 = distinct !DILexicalBlock(scope: !7, file: !1, line: 15, column: 3)
!30 = !DILocation(line: 15, column: 8, scope: !29)
!31 = !DILocation(line: 15, column: 15, scope: !32)
!32 = distinct !DILexicalBlock(scope: !29, file: !1, line: 15, column: 3)
!33 = !DILocation(line: 15, column: 17, scope: !32)
!34 = !DILocation(line: 15, column: 3, scope: !29)
!35 = !DILocation(line: 22, column: 12, scope: !36)
!36 = distinct !DILexicalBlock(scope: !37, file: !1, line: 22, column: 5)
!37 = distinct !DILexicalBlock(scope: !32, file: !1, line: 15, column: 29)
!38 = !DILocation(line: 22, column: 10, scope: !36)
!39 = !DILocation(line: 22, column: 17, scope: !40)
!40 = distinct !DILexicalBlock(scope: !36, file: !1, line: 22, column: 5)
!41 = !DILocation(line: 22, column: 19, scope: !40)
!42 = !DILocation(line: 22, column: 5, scope: !36)
!43 = !DILocation(line: 25, column: 14, scope: !44)
!44 = distinct !DILexicalBlock(scope: !45, file: !1, line: 25, column: 7)
!45 = distinct !DILexicalBlock(scope: !40, file: !1, line: 22, column: 32)
!46 = !DILocation(line: 25, column: 12, scope: !44)
!47 = !DILocation(line: 25, column: 19, scope: !48)
!48 = distinct !DILexicalBlock(scope: !44, file: !1, line: 25, column: 7)
!49 = !DILocation(line: 25, column: 21, scope: !48)
!50 = !DILocation(line: 25, column: 7, scope: !44)
!51 = !DILocation(line: 26, column: 20, scope: !52)
!52 = distinct !DILexicalBlock(scope: !48, file: !1, line: 25, column: 34)
!53 = !DILocation(line: 26, column: 22, scope: !52)
!54 = !DILocation(line: 26, column: 24, scope: !52)
!55 = !DILocation(line: 26, column: 29, scope: !52)
!56 = !DILocation(line: 26, column: 31, scope: !52)
!57 = !DILocation(line: 26, column: 38, scope: !52)
!58 = !DILocation(line: 26, column: 40, scope: !52)
!59 = !DILocation(line: 26, column: 42, scope: !52)
!60 = !DILocation(line: 26, column: 47, scope: !52)
!61 = !DILocation(line: 26, column: 36, scope: !52)
!62 = !DILocation(line: 26, column: 52, scope: !52)
!63 = !DILocation(line: 26, column: 54, scope: !52)
!64 = !DILocation(line: 26, column: 56, scope: !52)
!65 = !DILocation(line: 26, column: 61, scope: !52)
!66 = !DILocation(line: 26, column: 63, scope: !52)
!67 = !DILocation(line: 26, column: 50, scope: !52)
!68 = !DILocation(line: 26, column: 70, scope: !52)
!69 = !DILocation(line: 26, column: 72, scope: !52)
!70 = !DILocation(line: 26, column: 75, scope: !52)
!71 = !DILocation(line: 26, column: 77, scope: !52)
!72 = !DILocation(line: 26, column: 68, scope: !52)
!73 = !DILocation(line: 26, column: 84, scope: !52)
!74 = !DILocation(line: 26, column: 86, scope: !52)
!75 = !DILocation(line: 26, column: 89, scope: !52)
!76 = !DILocation(line: 26, column: 82, scope: !52)
!77 = !DILocation(line: 26, column: 94, scope: !52)
!78 = !DILocation(line: 26, column: 96, scope: !52)
!79 = !DILocation(line: 26, column: 99, scope: !52)
!80 = !DILocation(line: 26, column: 101, scope: !52)
!81 = !DILocation(line: 26, column: 92, scope: !52)
!82 = !DILocation(line: 26, column: 108, scope: !52)
!83 = !DILocation(line: 26, column: 110, scope: !52)
!84 = !DILocation(line: 26, column: 112, scope: !52)
!85 = !DILocation(line: 26, column: 117, scope: !52)
!86 = !DILocation(line: 26, column: 119, scope: !52)
!87 = !DILocation(line: 26, column: 106, scope: !52)
!88 = !DILocation(line: 26, column: 126, scope: !52)
!89 = !DILocation(line: 26, column: 128, scope: !52)
!90 = !DILocation(line: 26, column: 130, scope: !52)
!91 = !DILocation(line: 26, column: 135, scope: !52)
!92 = !DILocation(line: 26, column: 124, scope: !52)
!93 = !DILocation(line: 26, column: 140, scope: !52)
!94 = !DILocation(line: 26, column: 142, scope: !52)
!95 = !DILocation(line: 26, column: 144, scope: !52)
!96 = !DILocation(line: 26, column: 149, scope: !52)
!97 = !DILocation(line: 26, column: 151, scope: !52)
!98 = !DILocation(line: 26, column: 138, scope: !52)
!99 = !DILocation(line: 26, column: 157, scope: !52)
!100 = !DILocation(line: 26, column: 9, scope: !52)
!101 = !DILocation(line: 26, column: 11, scope: !52)
!102 = !DILocation(line: 26, column: 14, scope: !52)
!103 = !DILocation(line: 26, column: 17, scope: !52)
!104 = !DILocation(line: 27, column: 7, scope: !52)
!105 = !DILocation(line: 25, column: 30, scope: !48)
!106 = !DILocation(line: 25, column: 7, scope: !48)
!107 = distinct !{!107, !50, !108, !109}
!108 = !DILocation(line: 27, column: 7, scope: !44)
!109 = !{!"llvm.loop.mustprogress"}
!110 = !DILocation(line: 28, column: 5, scope: !45)
!111 = !DILocation(line: 22, column: 28, scope: !40)
!112 = !DILocation(line: 22, column: 5, scope: !40)
!113 = distinct !{!113, !42, !114, !109}
!114 = !DILocation(line: 28, column: 5, scope: !36)
!115 = !DILocation(line: 29, column: 3, scope: !37)
!116 = !DILocation(line: 15, column: 25, scope: !32)
!117 = !DILocation(line: 15, column: 3, scope: !32)
!118 = distinct !{!118, !34, !119, !109}
!119 = !DILocation(line: 29, column: 3, scope: !29)
!120 = !DILocation(line: 31, column: 1, scope: !7)
