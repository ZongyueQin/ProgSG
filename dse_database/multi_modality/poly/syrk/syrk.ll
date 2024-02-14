; ModuleID = 'syrk.c'
source_filename = "syrk.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_syrk(double %alpha, double %beta, [80 x double]* %C, [60 x double]* %A) #0 !dbg !7 {
entry:
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %C.addr = alloca [80 x double]*, align 8
  %A.addr = alloca [60 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store double %beta, double* %beta.addr, align 8
  call void @llvm.dbg.declare(metadata double* %beta.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store [80 x double]* %C, [80 x double]** %C.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %C.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store [60 x double]* %A, [60 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [60 x double]** %A.addr, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %i, metadata !27, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %j, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %k, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 0, i32* %i, align 4, !dbg !34
  br label %for.cond, !dbg !36

for.cond:                                         ; preds = %for.inc36, %entry
  %0 = load i32, i32* %i, align 4, !dbg !37
  %cmp = icmp slt i32 %0, 80, !dbg !39
  br i1 %cmp, label %for.body, label %for.end38, !dbg !40

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !41
  br label %for.cond1, !dbg !44

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !45
  %cmp2 = icmp slt i32 %1, 80, !dbg !47
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !48

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %j, align 4, !dbg !49
  %3 = load i32, i32* %i, align 4, !dbg !52
  %cmp4 = icmp sle i32 %2, %3, !dbg !53
  br i1 %cmp4, label %if.then, label %if.end, !dbg !54

if.then:                                          ; preds = %for.body3
  %4 = load double, double* %beta.addr, align 8, !dbg !55
  %5 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !57
  %6 = load i32, i32* %i, align 4, !dbg !58
  %idxprom = sext i32 %6 to i64, !dbg !57
  %arrayidx = getelementptr inbounds [80 x double], [80 x double]* %5, i64 %idxprom, !dbg !57
  %7 = load i32, i32* %j, align 4, !dbg !59
  %idxprom5 = sext i32 %7 to i64, !dbg !57
  %arrayidx6 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx, i64 0, i64 %idxprom5, !dbg !57
  %8 = load double, double* %arrayidx6, align 8, !dbg !60
  %mul = fmul double %8, %4, !dbg !60
  store double %mul, double* %arrayidx6, align 8, !dbg !60
  br label %if.end, !dbg !61

if.end:                                           ; preds = %if.then, %for.body3
  br label %for.inc, !dbg !62

for.inc:                                          ; preds = %if.end
  %9 = load i32, i32* %j, align 4, !dbg !63
  %inc = add nsw i32 %9, 1, !dbg !63
  store i32 %inc, i32* %j, align 4, !dbg !63
  br label %for.cond1, !dbg !64, !llvm.loop !65

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %k, align 4, !dbg !68
  br label %for.cond7, !dbg !70

for.cond7:                                        ; preds = %for.inc33, %for.end
  %10 = load i32, i32* %k, align 4, !dbg !71
  %cmp8 = icmp slt i32 %10, 60, !dbg !73
  br i1 %cmp8, label %for.body9, label %for.end35, !dbg !74

for.body9:                                        ; preds = %for.cond7
  store i32 0, i32* %j, align 4, !dbg !75
  br label %for.cond10, !dbg !78

for.cond10:                                       ; preds = %for.inc30, %for.body9
  %11 = load i32, i32* %j, align 4, !dbg !79
  %cmp11 = icmp slt i32 %11, 80, !dbg !81
  br i1 %cmp11, label %for.body12, label %for.end32, !dbg !82

for.body12:                                       ; preds = %for.cond10
  %12 = load i32, i32* %j, align 4, !dbg !83
  %13 = load i32, i32* %i, align 4, !dbg !86
  %cmp13 = icmp sle i32 %12, %13, !dbg !87
  br i1 %cmp13, label %if.then14, label %if.end29, !dbg !88

if.then14:                                        ; preds = %for.body12
  %14 = load double, double* %alpha.addr, align 8, !dbg !89
  %15 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !91
  %16 = load i32, i32* %i, align 4, !dbg !92
  %idxprom15 = sext i32 %16 to i64, !dbg !91
  %arrayidx16 = getelementptr inbounds [60 x double], [60 x double]* %15, i64 %idxprom15, !dbg !91
  %17 = load i32, i32* %k, align 4, !dbg !93
  %idxprom17 = sext i32 %17 to i64, !dbg !91
  %arrayidx18 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx16, i64 0, i64 %idxprom17, !dbg !91
  %18 = load double, double* %arrayidx18, align 8, !dbg !91
  %mul19 = fmul double %14, %18, !dbg !94
  %19 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !95
  %20 = load i32, i32* %j, align 4, !dbg !96
  %idxprom20 = sext i32 %20 to i64, !dbg !95
  %arrayidx21 = getelementptr inbounds [60 x double], [60 x double]* %19, i64 %idxprom20, !dbg !95
  %21 = load i32, i32* %k, align 4, !dbg !97
  %idxprom22 = sext i32 %21 to i64, !dbg !95
  %arrayidx23 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx21, i64 0, i64 %idxprom22, !dbg !95
  %22 = load double, double* %arrayidx23, align 8, !dbg !95
  %mul24 = fmul double %mul19, %22, !dbg !98
  %23 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !99
  %24 = load i32, i32* %i, align 4, !dbg !100
  %idxprom25 = sext i32 %24 to i64, !dbg !99
  %arrayidx26 = getelementptr inbounds [80 x double], [80 x double]* %23, i64 %idxprom25, !dbg !99
  %25 = load i32, i32* %j, align 4, !dbg !101
  %idxprom27 = sext i32 %25 to i64, !dbg !99
  %arrayidx28 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx26, i64 0, i64 %idxprom27, !dbg !99
  %26 = load double, double* %arrayidx28, align 8, !dbg !102
  %add = fadd double %26, %mul24, !dbg !102
  store double %add, double* %arrayidx28, align 8, !dbg !102
  br label %if.end29, !dbg !103

if.end29:                                         ; preds = %if.then14, %for.body12
  br label %for.inc30, !dbg !104

for.inc30:                                        ; preds = %if.end29
  %27 = load i32, i32* %j, align 4, !dbg !105
  %inc31 = add nsw i32 %27, 1, !dbg !105
  store i32 %inc31, i32* %j, align 4, !dbg !105
  br label %for.cond10, !dbg !106, !llvm.loop !107

for.end32:                                        ; preds = %for.cond10
  br label %for.inc33, !dbg !109

for.inc33:                                        ; preds = %for.end32
  %28 = load i32, i32* %k, align 4, !dbg !110
  %inc34 = add nsw i32 %28, 1, !dbg !110
  store i32 %inc34, i32* %k, align 4, !dbg !110
  br label %for.cond7, !dbg !111, !llvm.loop !112

for.end35:                                        ; preds = %for.cond7
  br label %for.inc36, !dbg !114

for.inc36:                                        ; preds = %for.end35
  %29 = load i32, i32* %i, align 4, !dbg !115
  %inc37 = add nsw i32 %29, 1, !dbg !115
  store i32 %inc37, i32* %i, align 4, !dbg !115
  br label %for.cond, !dbg !116, !llvm.loop !117

for.end38:                                        ; preds = %for.cond
  ret void, !dbg !119
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "syrk.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/syrk")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_syrk", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !11, !15}
!10 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 5120, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 80)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3840, elements: !17)
!17 = !{!18}
!18 = !DISubrange(count: 60)
!19 = !DILocalVariable(name: "alpha", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!20 = !DILocation(line: 3, column: 25, scope: !7)
!21 = !DILocalVariable(name: "beta", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!22 = !DILocation(line: 3, column: 38, scope: !7)
!23 = !DILocalVariable(name: "C", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!24 = !DILocation(line: 3, column: 50, scope: !7)
!25 = !DILocalVariable(name: "A", arg: 4, scope: !7, file: !1, line: 3, type: !15)
!26 = !DILocation(line: 3, column: 67, scope: !7)
!27 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !28)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !DILocation(line: 5, column: 7, scope: !7)
!30 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !28)
!31 = !DILocation(line: 6, column: 7, scope: !7)
!32 = !DILocalVariable(name: "k", scope: !7, file: !1, line: 7, type: !28)
!33 = !DILocation(line: 7, column: 7, scope: !7)
!34 = !DILocation(line: 20, column: 10, scope: !35)
!35 = distinct !DILexicalBlock(scope: !7, file: !1, line: 20, column: 3)
!36 = !DILocation(line: 20, column: 8, scope: !35)
!37 = !DILocation(line: 20, column: 15, scope: !38)
!38 = distinct !DILexicalBlock(scope: !35, file: !1, line: 20, column: 3)
!39 = !DILocation(line: 20, column: 17, scope: !38)
!40 = !DILocation(line: 20, column: 3, scope: !35)
!41 = !DILocation(line: 23, column: 12, scope: !42)
!42 = distinct !DILexicalBlock(scope: !43, file: !1, line: 23, column: 5)
!43 = distinct !DILexicalBlock(scope: !38, file: !1, line: 20, column: 28)
!44 = !DILocation(line: 23, column: 10, scope: !42)
!45 = !DILocation(line: 23, column: 17, scope: !46)
!46 = distinct !DILexicalBlock(scope: !42, file: !1, line: 23, column: 5)
!47 = !DILocation(line: 23, column: 19, scope: !46)
!48 = !DILocation(line: 23, column: 5, scope: !42)
!49 = !DILocation(line: 24, column: 11, scope: !50)
!50 = distinct !DILexicalBlock(scope: !51, file: !1, line: 24, column: 11)
!51 = distinct !DILexicalBlock(scope: !46, file: !1, line: 23, column: 30)
!52 = !DILocation(line: 24, column: 16, scope: !50)
!53 = !DILocation(line: 24, column: 13, scope: !50)
!54 = !DILocation(line: 24, column: 11, scope: !51)
!55 = !DILocation(line: 25, column: 20, scope: !56)
!56 = distinct !DILexicalBlock(scope: !50, file: !1, line: 24, column: 19)
!57 = !DILocation(line: 25, column: 9, scope: !56)
!58 = !DILocation(line: 25, column: 11, scope: !56)
!59 = !DILocation(line: 25, column: 14, scope: !56)
!60 = !DILocation(line: 25, column: 17, scope: !56)
!61 = !DILocation(line: 26, column: 7, scope: !56)
!62 = !DILocation(line: 27, column: 5, scope: !51)
!63 = !DILocation(line: 23, column: 26, scope: !46)
!64 = !DILocation(line: 23, column: 5, scope: !46)
!65 = distinct !{!65, !48, !66, !67}
!66 = !DILocation(line: 27, column: 5, scope: !42)
!67 = !{!"llvm.loop.mustprogress"}
!68 = !DILocation(line: 34, column: 12, scope: !69)
!69 = distinct !DILexicalBlock(scope: !43, file: !1, line: 34, column: 5)
!70 = !DILocation(line: 34, column: 10, scope: !69)
!71 = !DILocation(line: 34, column: 17, scope: !72)
!72 = distinct !DILexicalBlock(scope: !69, file: !1, line: 34, column: 5)
!73 = !DILocation(line: 34, column: 19, scope: !72)
!74 = !DILocation(line: 34, column: 5, scope: !69)
!75 = !DILocation(line: 37, column: 14, scope: !76)
!76 = distinct !DILexicalBlock(scope: !77, file: !1, line: 37, column: 7)
!77 = distinct !DILexicalBlock(scope: !72, file: !1, line: 34, column: 30)
!78 = !DILocation(line: 37, column: 12, scope: !76)
!79 = !DILocation(line: 37, column: 19, scope: !80)
!80 = distinct !DILexicalBlock(scope: !76, file: !1, line: 37, column: 7)
!81 = !DILocation(line: 37, column: 21, scope: !80)
!82 = !DILocation(line: 37, column: 7, scope: !76)
!83 = !DILocation(line: 38, column: 13, scope: !84)
!84 = distinct !DILexicalBlock(scope: !85, file: !1, line: 38, column: 13)
!85 = distinct !DILexicalBlock(scope: !80, file: !1, line: 37, column: 32)
!86 = !DILocation(line: 38, column: 18, scope: !84)
!87 = !DILocation(line: 38, column: 15, scope: !84)
!88 = !DILocation(line: 38, column: 13, scope: !85)
!89 = !DILocation(line: 39, column: 22, scope: !90)
!90 = distinct !DILexicalBlock(scope: !84, file: !1, line: 38, column: 21)
!91 = !DILocation(line: 39, column: 30, scope: !90)
!92 = !DILocation(line: 39, column: 32, scope: !90)
!93 = !DILocation(line: 39, column: 35, scope: !90)
!94 = !DILocation(line: 39, column: 28, scope: !90)
!95 = !DILocation(line: 39, column: 40, scope: !90)
!96 = !DILocation(line: 39, column: 42, scope: !90)
!97 = !DILocation(line: 39, column: 45, scope: !90)
!98 = !DILocation(line: 39, column: 38, scope: !90)
!99 = !DILocation(line: 39, column: 11, scope: !90)
!100 = !DILocation(line: 39, column: 13, scope: !90)
!101 = !DILocation(line: 39, column: 16, scope: !90)
!102 = !DILocation(line: 39, column: 19, scope: !90)
!103 = !DILocation(line: 40, column: 9, scope: !90)
!104 = !DILocation(line: 41, column: 7, scope: !85)
!105 = !DILocation(line: 37, column: 28, scope: !80)
!106 = !DILocation(line: 37, column: 7, scope: !80)
!107 = distinct !{!107, !82, !108, !67}
!108 = !DILocation(line: 41, column: 7, scope: !76)
!109 = !DILocation(line: 42, column: 5, scope: !77)
!110 = !DILocation(line: 34, column: 26, scope: !72)
!111 = !DILocation(line: 34, column: 5, scope: !72)
!112 = distinct !{!112, !74, !113, !67}
!113 = !DILocation(line: 42, column: 5, scope: !69)
!114 = !DILocation(line: 43, column: 3, scope: !43)
!115 = !DILocation(line: 20, column: 24, scope: !38)
!116 = !DILocation(line: 20, column: 3, scope: !38)
!117 = distinct !{!117, !40, !118, !67}
!118 = !DILocation(line: 43, column: 3, scope: !35)
!119 = !DILocation(line: 44, column: 1, scope: !7)
