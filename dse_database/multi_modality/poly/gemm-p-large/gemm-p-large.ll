; ModuleID = 'gemm-p-large.c'
source_filename = "gemm-p-large.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gemm(i32 %ni, i32 %nj, i32 %nk, double %alpha, double %beta, [220 x double]* %C, [240 x double]* %A, [220 x double]* %B) #0 !dbg !7 {
entry:
  %ni.addr = alloca i32, align 4
  %nj.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %C.addr = alloca [220 x double]*, align 8
  %A.addr = alloca [240 x double]*, align 8
  %B.addr = alloca [220 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %ni, i32* %ni.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ni.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 %nj, i32* %nj.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nj.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i32 %nk, i32* %nk.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nk.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store double %beta, double* %beta.addr, align 8
  call void @llvm.dbg.declare(metadata double* %beta.addr, metadata !28, metadata !DIExpression()), !dbg !29
  store [220 x double]* %C, [220 x double]** %C.addr, align 8
  call void @llvm.dbg.declare(metadata [220 x double]** %C.addr, metadata !30, metadata !DIExpression()), !dbg !31
  store [240 x double]* %A, [240 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [240 x double]** %A.addr, metadata !32, metadata !DIExpression()), !dbg !33
  store [220 x double]* %B, [220 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [220 x double]** %B.addr, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %i, metadata !36, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %j, metadata !38, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.declare(metadata i32* %k, metadata !40, metadata !DIExpression()), !dbg !41
  store i32 0, i32* %i, align 4, !dbg !42
  br label %for.cond, !dbg !44

for.cond:                                         ; preds = %for.inc32, %entry
  %0 = load i32, i32* %i, align 4, !dbg !45
  %cmp = icmp slt i32 %0, 200, !dbg !47
  br i1 %cmp, label %for.body, label %for.end34, !dbg !48

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !49
  br label %for.cond1, !dbg !52

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !53
  %cmp2 = icmp slt i32 %1, 220, !dbg !55
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !56

for.body3:                                        ; preds = %for.cond1
  %2 = load double, double* %beta.addr, align 8, !dbg !57
  %3 = load [220 x double]*, [220 x double]** %C.addr, align 8, !dbg !59
  %4 = load i32, i32* %i, align 4, !dbg !60
  %idxprom = sext i32 %4 to i64, !dbg !59
  %arrayidx = getelementptr inbounds [220 x double], [220 x double]* %3, i64 %idxprom, !dbg !59
  %5 = load i32, i32* %j, align 4, !dbg !61
  %idxprom4 = sext i32 %5 to i64, !dbg !59
  %arrayidx5 = getelementptr inbounds [220 x double], [220 x double]* %arrayidx, i64 0, i64 %idxprom4, !dbg !59
  %6 = load double, double* %arrayidx5, align 8, !dbg !62
  %mul = fmul double %6, %2, !dbg !62
  store double %mul, double* %arrayidx5, align 8, !dbg !62
  br label %for.inc, !dbg !63

for.inc:                                          ; preds = %for.body3
  %7 = load i32, i32* %j, align 4, !dbg !64
  %inc = add nsw i32 %7, 1, !dbg !64
  store i32 %inc, i32* %j, align 4, !dbg !64
  br label %for.cond1, !dbg !65, !llvm.loop !66

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %k, align 4, !dbg !69
  br label %for.cond6, !dbg !71

for.cond6:                                        ; preds = %for.inc29, %for.end
  %8 = load i32, i32* %k, align 4, !dbg !72
  %cmp7 = icmp slt i32 %8, 240, !dbg !74
  br i1 %cmp7, label %for.body8, label %for.end31, !dbg !75

for.body8:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4, !dbg !76
  br label %for.cond9, !dbg !79

for.cond9:                                        ; preds = %for.inc26, %for.body8
  %9 = load i32, i32* %j, align 4, !dbg !80
  %cmp10 = icmp slt i32 %9, 220, !dbg !82
  br i1 %cmp10, label %for.body11, label %for.end28, !dbg !83

for.body11:                                       ; preds = %for.cond9
  %10 = load double, double* %alpha.addr, align 8, !dbg !84
  %11 = load [240 x double]*, [240 x double]** %A.addr, align 8, !dbg !86
  %12 = load i32, i32* %i, align 4, !dbg !87
  %idxprom12 = sext i32 %12 to i64, !dbg !86
  %arrayidx13 = getelementptr inbounds [240 x double], [240 x double]* %11, i64 %idxprom12, !dbg !86
  %13 = load i32, i32* %k, align 4, !dbg !88
  %idxprom14 = sext i32 %13 to i64, !dbg !86
  %arrayidx15 = getelementptr inbounds [240 x double], [240 x double]* %arrayidx13, i64 0, i64 %idxprom14, !dbg !86
  %14 = load double, double* %arrayidx15, align 8, !dbg !86
  %mul16 = fmul double %10, %14, !dbg !89
  %15 = load [220 x double]*, [220 x double]** %B.addr, align 8, !dbg !90
  %16 = load i32, i32* %k, align 4, !dbg !91
  %idxprom17 = sext i32 %16 to i64, !dbg !90
  %arrayidx18 = getelementptr inbounds [220 x double], [220 x double]* %15, i64 %idxprom17, !dbg !90
  %17 = load i32, i32* %j, align 4, !dbg !92
  %idxprom19 = sext i32 %17 to i64, !dbg !90
  %arrayidx20 = getelementptr inbounds [220 x double], [220 x double]* %arrayidx18, i64 0, i64 %idxprom19, !dbg !90
  %18 = load double, double* %arrayidx20, align 8, !dbg !90
  %mul21 = fmul double %mul16, %18, !dbg !93
  %19 = load [220 x double]*, [220 x double]** %C.addr, align 8, !dbg !94
  %20 = load i32, i32* %i, align 4, !dbg !95
  %idxprom22 = sext i32 %20 to i64, !dbg !94
  %arrayidx23 = getelementptr inbounds [220 x double], [220 x double]* %19, i64 %idxprom22, !dbg !94
  %21 = load i32, i32* %j, align 4, !dbg !96
  %idxprom24 = sext i32 %21 to i64, !dbg !94
  %arrayidx25 = getelementptr inbounds [220 x double], [220 x double]* %arrayidx23, i64 0, i64 %idxprom24, !dbg !94
  %22 = load double, double* %arrayidx25, align 8, !dbg !97
  %add = fadd double %22, %mul21, !dbg !97
  store double %add, double* %arrayidx25, align 8, !dbg !97
  br label %for.inc26, !dbg !98

for.inc26:                                        ; preds = %for.body11
  %23 = load i32, i32* %j, align 4, !dbg !99
  %inc27 = add nsw i32 %23, 1, !dbg !99
  store i32 %inc27, i32* %j, align 4, !dbg !99
  br label %for.cond9, !dbg !100, !llvm.loop !101

for.end28:                                        ; preds = %for.cond9
  br label %for.inc29, !dbg !103

for.inc29:                                        ; preds = %for.end28
  %24 = load i32, i32* %k, align 4, !dbg !104
  %inc30 = add nsw i32 %24, 1, !dbg !104
  store i32 %inc30, i32* %k, align 4, !dbg !104
  br label %for.cond6, !dbg !105, !llvm.loop !106

for.end31:                                        ; preds = %for.cond6
  br label %for.inc32, !dbg !108

for.inc32:                                        ; preds = %for.end31
  %25 = load i32, i32* %i, align 4, !dbg !109
  %inc33 = add nsw i32 %25, 1, !dbg !109
  store i32 %inc33, i32* %i, align 4, !dbg !109
  br label %for.cond, !dbg !110, !llvm.loop !111

for.end34:                                        ; preds = %for.cond
  ret void, !dbg !113
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "gemm-p-large.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/gemm-p-large")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_gemm", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !10, !11, !11, !12, !16, !12}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 14080, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 220)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 15360, elements: !18)
!18 = !{!19}
!19 = !DISubrange(count: 240)
!20 = !DILocalVariable(name: "ni", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!21 = !DILocation(line: 3, column: 22, scope: !7)
!22 = !DILocalVariable(name: "nj", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!23 = !DILocation(line: 3, column: 29, scope: !7)
!24 = !DILocalVariable(name: "nk", arg: 3, scope: !7, file: !1, line: 3, type: !10)
!25 = !DILocation(line: 3, column: 36, scope: !7)
!26 = !DILocalVariable(name: "alpha", arg: 4, scope: !7, file: !1, line: 3, type: !11)
!27 = !DILocation(line: 3, column: 46, scope: !7)
!28 = !DILocalVariable(name: "beta", arg: 5, scope: !7, file: !1, line: 3, type: !11)
!29 = !DILocation(line: 3, column: 59, scope: !7)
!30 = !DILocalVariable(name: "C", arg: 6, scope: !7, file: !1, line: 3, type: !12)
!31 = !DILocation(line: 3, column: 71, scope: !7)
!32 = !DILocalVariable(name: "A", arg: 7, scope: !7, file: !1, line: 3, type: !16)
!33 = !DILocation(line: 3, column: 90, scope: !7)
!34 = !DILocalVariable(name: "B", arg: 8, scope: !7, file: !1, line: 3, type: !12)
!35 = !DILocation(line: 3, column: 109, scope: !7)
!36 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !10)
!37 = !DILocation(line: 5, column: 7, scope: !7)
!38 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !10)
!39 = !DILocation(line: 6, column: 7, scope: !7)
!40 = !DILocalVariable(name: "k", scope: !7, file: !1, line: 7, type: !10)
!41 = !DILocation(line: 7, column: 7, scope: !7)
!42 = !DILocation(line: 21, column: 10, scope: !43)
!43 = distinct !DILexicalBlock(scope: !7, file: !1, line: 21, column: 3)
!44 = !DILocation(line: 21, column: 8, scope: !43)
!45 = !DILocation(line: 21, column: 15, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !1, line: 21, column: 3)
!47 = !DILocation(line: 21, column: 17, scope: !46)
!48 = !DILocation(line: 21, column: 3, scope: !43)
!49 = !DILocation(line: 24, column: 12, scope: !50)
!50 = distinct !DILexicalBlock(scope: !51, file: !1, line: 24, column: 5)
!51 = distinct !DILexicalBlock(scope: !46, file: !1, line: 21, column: 29)
!52 = !DILocation(line: 24, column: 10, scope: !50)
!53 = !DILocation(line: 24, column: 17, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !1, line: 24, column: 5)
!55 = !DILocation(line: 24, column: 19, scope: !54)
!56 = !DILocation(line: 24, column: 5, scope: !50)
!57 = !DILocation(line: 25, column: 18, scope: !58)
!58 = distinct !DILexicalBlock(scope: !54, file: !1, line: 24, column: 31)
!59 = !DILocation(line: 25, column: 7, scope: !58)
!60 = !DILocation(line: 25, column: 9, scope: !58)
!61 = !DILocation(line: 25, column: 12, scope: !58)
!62 = !DILocation(line: 25, column: 15, scope: !58)
!63 = !DILocation(line: 26, column: 5, scope: !58)
!64 = !DILocation(line: 24, column: 27, scope: !54)
!65 = !DILocation(line: 24, column: 5, scope: !54)
!66 = distinct !{!66, !56, !67, !68}
!67 = !DILocation(line: 26, column: 5, scope: !50)
!68 = !{!"llvm.loop.mustprogress"}
!69 = !DILocation(line: 33, column: 12, scope: !70)
!70 = distinct !DILexicalBlock(scope: !51, file: !1, line: 33, column: 5)
!71 = !DILocation(line: 33, column: 10, scope: !70)
!72 = !DILocation(line: 33, column: 17, scope: !73)
!73 = distinct !DILexicalBlock(scope: !70, file: !1, line: 33, column: 5)
!74 = !DILocation(line: 33, column: 19, scope: !73)
!75 = !DILocation(line: 33, column: 5, scope: !70)
!76 = !DILocation(line: 36, column: 14, scope: !77)
!77 = distinct !DILexicalBlock(scope: !78, file: !1, line: 36, column: 7)
!78 = distinct !DILexicalBlock(scope: !73, file: !1, line: 33, column: 31)
!79 = !DILocation(line: 36, column: 12, scope: !77)
!80 = !DILocation(line: 36, column: 19, scope: !81)
!81 = distinct !DILexicalBlock(scope: !77, file: !1, line: 36, column: 7)
!82 = !DILocation(line: 36, column: 21, scope: !81)
!83 = !DILocation(line: 36, column: 7, scope: !77)
!84 = !DILocation(line: 37, column: 20, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !1, line: 36, column: 33)
!86 = !DILocation(line: 37, column: 28, scope: !85)
!87 = !DILocation(line: 37, column: 30, scope: !85)
!88 = !DILocation(line: 37, column: 33, scope: !85)
!89 = !DILocation(line: 37, column: 26, scope: !85)
!90 = !DILocation(line: 37, column: 38, scope: !85)
!91 = !DILocation(line: 37, column: 40, scope: !85)
!92 = !DILocation(line: 37, column: 43, scope: !85)
!93 = !DILocation(line: 37, column: 36, scope: !85)
!94 = !DILocation(line: 37, column: 9, scope: !85)
!95 = !DILocation(line: 37, column: 11, scope: !85)
!96 = !DILocation(line: 37, column: 14, scope: !85)
!97 = !DILocation(line: 37, column: 17, scope: !85)
!98 = !DILocation(line: 38, column: 7, scope: !85)
!99 = !DILocation(line: 36, column: 29, scope: !81)
!100 = !DILocation(line: 36, column: 7, scope: !81)
!101 = distinct !{!101, !83, !102, !68}
!102 = !DILocation(line: 38, column: 7, scope: !77)
!103 = !DILocation(line: 39, column: 5, scope: !78)
!104 = !DILocation(line: 33, column: 27, scope: !73)
!105 = !DILocation(line: 33, column: 5, scope: !73)
!106 = distinct !{!106, !75, !107, !68}
!107 = !DILocation(line: 39, column: 5, scope: !70)
!108 = !DILocation(line: 40, column: 3, scope: !51)
!109 = !DILocation(line: 21, column: 25, scope: !46)
!110 = !DILocation(line: 21, column: 3, scope: !46)
!111 = distinct !{!111, !48, !112, !68}
!112 = !DILocation(line: 40, column: 3, scope: !43)
!113 = !DILocation(line: 41, column: 1, scope: !7)
