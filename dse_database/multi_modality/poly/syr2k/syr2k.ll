; ModuleID = 'syr2k.c'
source_filename = "syr2k.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_syr2k(double %alpha, double %beta, [80 x double]* %C, [60 x double]* %A, [60 x double]* %B) #0 !dbg !7 {
entry:
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %C.addr = alloca [80 x double]*, align 8
  %A.addr = alloca [60 x double]*, align 8
  %B.addr = alloca [60 x double]*, align 8
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
  store [60 x double]* %B, [60 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [60 x double]** %B.addr, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %j, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %k, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !38

for.cond:                                         ; preds = %for.inc47, %entry
  %0 = load i32, i32* %i, align 4, !dbg !39
  %cmp = icmp slt i32 %0, 80, !dbg !41
  br i1 %cmp, label %for.body, label %for.end49, !dbg !42

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !43
  br label %for.cond1, !dbg !46

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !47
  %cmp2 = icmp slt i32 %1, 80, !dbg !49
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !50

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %j, align 4, !dbg !51
  %3 = load i32, i32* %i, align 4, !dbg !54
  %cmp4 = icmp sle i32 %2, %3, !dbg !55
  br i1 %cmp4, label %if.then, label %if.end, !dbg !56

if.then:                                          ; preds = %for.body3
  %4 = load double, double* %beta.addr, align 8, !dbg !57
  %5 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !59
  %6 = load i32, i32* %i, align 4, !dbg !60
  %idxprom = sext i32 %6 to i64, !dbg !59
  %arrayidx = getelementptr inbounds [80 x double], [80 x double]* %5, i64 %idxprom, !dbg !59
  %7 = load i32, i32* %j, align 4, !dbg !61
  %idxprom5 = sext i32 %7 to i64, !dbg !59
  %arrayidx6 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx, i64 0, i64 %idxprom5, !dbg !59
  %8 = load double, double* %arrayidx6, align 8, !dbg !62
  %mul = fmul double %8, %4, !dbg !62
  store double %mul, double* %arrayidx6, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %if.then, %for.body3
  br label %for.inc, !dbg !64

for.inc:                                          ; preds = %if.end
  %9 = load i32, i32* %j, align 4, !dbg !65
  %inc = add nsw i32 %9, 1, !dbg !65
  store i32 %inc, i32* %j, align 4, !dbg !65
  br label %for.cond1, !dbg !66, !llvm.loop !67

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %k, align 4, !dbg !70
  br label %for.cond7, !dbg !72

for.cond7:                                        ; preds = %for.inc44, %for.end
  %10 = load i32, i32* %k, align 4, !dbg !73
  %cmp8 = icmp slt i32 %10, 60, !dbg !75
  br i1 %cmp8, label %for.body9, label %for.end46, !dbg !76

for.body9:                                        ; preds = %for.cond7
  store i32 0, i32* %j, align 4, !dbg !77
  br label %for.cond10, !dbg !80

for.cond10:                                       ; preds = %for.inc41, %for.body9
  %11 = load i32, i32* %j, align 4, !dbg !81
  %cmp11 = icmp slt i32 %11, 80, !dbg !83
  br i1 %cmp11, label %for.body12, label %for.end43, !dbg !84

for.body12:                                       ; preds = %for.cond10
  %12 = load i32, i32* %j, align 4, !dbg !85
  %13 = load i32, i32* %i, align 4, !dbg !88
  %cmp13 = icmp sle i32 %12, %13, !dbg !89
  br i1 %cmp13, label %if.then14, label %if.end40, !dbg !90

if.then14:                                        ; preds = %for.body12
  %14 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !91
  %15 = load i32, i32* %j, align 4, !dbg !93
  %idxprom15 = sext i32 %15 to i64, !dbg !91
  %arrayidx16 = getelementptr inbounds [60 x double], [60 x double]* %14, i64 %idxprom15, !dbg !91
  %16 = load i32, i32* %k, align 4, !dbg !94
  %idxprom17 = sext i32 %16 to i64, !dbg !91
  %arrayidx18 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx16, i64 0, i64 %idxprom17, !dbg !91
  %17 = load double, double* %arrayidx18, align 8, !dbg !91
  %18 = load double, double* %alpha.addr, align 8, !dbg !95
  %mul19 = fmul double %17, %18, !dbg !96
  %19 = load [60 x double]*, [60 x double]** %B.addr, align 8, !dbg !97
  %20 = load i32, i32* %i, align 4, !dbg !98
  %idxprom20 = sext i32 %20 to i64, !dbg !97
  %arrayidx21 = getelementptr inbounds [60 x double], [60 x double]* %19, i64 %idxprom20, !dbg !97
  %21 = load i32, i32* %k, align 4, !dbg !99
  %idxprom22 = sext i32 %21 to i64, !dbg !97
  %arrayidx23 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx21, i64 0, i64 %idxprom22, !dbg !97
  %22 = load double, double* %arrayidx23, align 8, !dbg !97
  %mul24 = fmul double %mul19, %22, !dbg !100
  %23 = load [60 x double]*, [60 x double]** %B.addr, align 8, !dbg !101
  %24 = load i32, i32* %j, align 4, !dbg !102
  %idxprom25 = sext i32 %24 to i64, !dbg !101
  %arrayidx26 = getelementptr inbounds [60 x double], [60 x double]* %23, i64 %idxprom25, !dbg !101
  %25 = load i32, i32* %k, align 4, !dbg !103
  %idxprom27 = sext i32 %25 to i64, !dbg !101
  %arrayidx28 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx26, i64 0, i64 %idxprom27, !dbg !101
  %26 = load double, double* %arrayidx28, align 8, !dbg !101
  %27 = load double, double* %alpha.addr, align 8, !dbg !104
  %mul29 = fmul double %26, %27, !dbg !105
  %28 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !106
  %29 = load i32, i32* %i, align 4, !dbg !107
  %idxprom30 = sext i32 %29 to i64, !dbg !106
  %arrayidx31 = getelementptr inbounds [60 x double], [60 x double]* %28, i64 %idxprom30, !dbg !106
  %30 = load i32, i32* %k, align 4, !dbg !108
  %idxprom32 = sext i32 %30 to i64, !dbg !106
  %arrayidx33 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx31, i64 0, i64 %idxprom32, !dbg !106
  %31 = load double, double* %arrayidx33, align 8, !dbg !106
  %mul34 = fmul double %mul29, %31, !dbg !109
  %add = fadd double %mul24, %mul34, !dbg !110
  %32 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !111
  %33 = load i32, i32* %i, align 4, !dbg !112
  %idxprom35 = sext i32 %33 to i64, !dbg !111
  %arrayidx36 = getelementptr inbounds [80 x double], [80 x double]* %32, i64 %idxprom35, !dbg !111
  %34 = load i32, i32* %j, align 4, !dbg !113
  %idxprom37 = sext i32 %34 to i64, !dbg !111
  %arrayidx38 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx36, i64 0, i64 %idxprom37, !dbg !111
  %35 = load double, double* %arrayidx38, align 8, !dbg !114
  %add39 = fadd double %35, %add, !dbg !114
  store double %add39, double* %arrayidx38, align 8, !dbg !114
  br label %if.end40, !dbg !115

if.end40:                                         ; preds = %if.then14, %for.body12
  br label %for.inc41, !dbg !116

for.inc41:                                        ; preds = %if.end40
  %36 = load i32, i32* %j, align 4, !dbg !117
  %inc42 = add nsw i32 %36, 1, !dbg !117
  store i32 %inc42, i32* %j, align 4, !dbg !117
  br label %for.cond10, !dbg !118, !llvm.loop !119

for.end43:                                        ; preds = %for.cond10
  br label %for.inc44, !dbg !121

for.inc44:                                        ; preds = %for.end43
  %37 = load i32, i32* %k, align 4, !dbg !122
  %inc45 = add nsw i32 %37, 1, !dbg !122
  store i32 %inc45, i32* %k, align 4, !dbg !122
  br label %for.cond7, !dbg !123, !llvm.loop !124

for.end46:                                        ; preds = %for.cond7
  br label %for.inc47, !dbg !126

for.inc47:                                        ; preds = %for.end46
  %38 = load i32, i32* %i, align 4, !dbg !127
  %inc48 = add nsw i32 %38, 1, !dbg !127
  store i32 %inc48, i32* %i, align 4, !dbg !127
  br label %for.cond, !dbg !128, !llvm.loop !129

for.end49:                                        ; preds = %for.cond
  ret void, !dbg !131
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "syr2k.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/syr2k")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_syr2k", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !11, !15, !15}
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
!20 = !DILocation(line: 3, column: 26, scope: !7)
!21 = !DILocalVariable(name: "beta", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!22 = !DILocation(line: 3, column: 39, scope: !7)
!23 = !DILocalVariable(name: "C", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!24 = !DILocation(line: 3, column: 51, scope: !7)
!25 = !DILocalVariable(name: "A", arg: 4, scope: !7, file: !1, line: 3, type: !15)
!26 = !DILocation(line: 3, column: 68, scope: !7)
!27 = !DILocalVariable(name: "B", arg: 5, scope: !7, file: !1, line: 3, type: !15)
!28 = !DILocation(line: 3, column: 85, scope: !7)
!29 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !30)
!30 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!31 = !DILocation(line: 5, column: 7, scope: !7)
!32 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !30)
!33 = !DILocation(line: 6, column: 7, scope: !7)
!34 = !DILocalVariable(name: "k", scope: !7, file: !1, line: 7, type: !30)
!35 = !DILocation(line: 7, column: 7, scope: !7)
!36 = !DILocation(line: 20, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !7, file: !1, line: 20, column: 3)
!38 = !DILocation(line: 20, column: 8, scope: !37)
!39 = !DILocation(line: 20, column: 15, scope: !40)
!40 = distinct !DILexicalBlock(scope: !37, file: !1, line: 20, column: 3)
!41 = !DILocation(line: 20, column: 17, scope: !40)
!42 = !DILocation(line: 20, column: 3, scope: !37)
!43 = !DILocation(line: 23, column: 12, scope: !44)
!44 = distinct !DILexicalBlock(scope: !45, file: !1, line: 23, column: 5)
!45 = distinct !DILexicalBlock(scope: !40, file: !1, line: 20, column: 28)
!46 = !DILocation(line: 23, column: 10, scope: !44)
!47 = !DILocation(line: 23, column: 17, scope: !48)
!48 = distinct !DILexicalBlock(scope: !44, file: !1, line: 23, column: 5)
!49 = !DILocation(line: 23, column: 19, scope: !48)
!50 = !DILocation(line: 23, column: 5, scope: !44)
!51 = !DILocation(line: 24, column: 11, scope: !52)
!52 = distinct !DILexicalBlock(scope: !53, file: !1, line: 24, column: 11)
!53 = distinct !DILexicalBlock(scope: !48, file: !1, line: 23, column: 30)
!54 = !DILocation(line: 24, column: 16, scope: !52)
!55 = !DILocation(line: 24, column: 13, scope: !52)
!56 = !DILocation(line: 24, column: 11, scope: !53)
!57 = !DILocation(line: 25, column: 20, scope: !58)
!58 = distinct !DILexicalBlock(scope: !52, file: !1, line: 24, column: 19)
!59 = !DILocation(line: 25, column: 9, scope: !58)
!60 = !DILocation(line: 25, column: 11, scope: !58)
!61 = !DILocation(line: 25, column: 14, scope: !58)
!62 = !DILocation(line: 25, column: 17, scope: !58)
!63 = !DILocation(line: 26, column: 7, scope: !58)
!64 = !DILocation(line: 27, column: 5, scope: !53)
!65 = !DILocation(line: 23, column: 26, scope: !48)
!66 = !DILocation(line: 23, column: 5, scope: !48)
!67 = distinct !{!67, !50, !68, !69}
!68 = !DILocation(line: 27, column: 5, scope: !44)
!69 = !{!"llvm.loop.mustprogress"}
!70 = !DILocation(line: 34, column: 12, scope: !71)
!71 = distinct !DILexicalBlock(scope: !45, file: !1, line: 34, column: 5)
!72 = !DILocation(line: 34, column: 10, scope: !71)
!73 = !DILocation(line: 34, column: 17, scope: !74)
!74 = distinct !DILexicalBlock(scope: !71, file: !1, line: 34, column: 5)
!75 = !DILocation(line: 34, column: 19, scope: !74)
!76 = !DILocation(line: 34, column: 5, scope: !71)
!77 = !DILocation(line: 37, column: 14, scope: !78)
!78 = distinct !DILexicalBlock(scope: !79, file: !1, line: 37, column: 7)
!79 = distinct !DILexicalBlock(scope: !74, file: !1, line: 34, column: 30)
!80 = !DILocation(line: 37, column: 12, scope: !78)
!81 = !DILocation(line: 37, column: 19, scope: !82)
!82 = distinct !DILexicalBlock(scope: !78, file: !1, line: 37, column: 7)
!83 = !DILocation(line: 37, column: 21, scope: !82)
!84 = !DILocation(line: 37, column: 7, scope: !78)
!85 = !DILocation(line: 38, column: 13, scope: !86)
!86 = distinct !DILexicalBlock(scope: !87, file: !1, line: 38, column: 13)
!87 = distinct !DILexicalBlock(scope: !82, file: !1, line: 37, column: 32)
!88 = !DILocation(line: 38, column: 18, scope: !86)
!89 = !DILocation(line: 38, column: 15, scope: !86)
!90 = !DILocation(line: 38, column: 13, scope: !87)
!91 = !DILocation(line: 39, column: 22, scope: !92)
!92 = distinct !DILexicalBlock(scope: !86, file: !1, line: 38, column: 21)
!93 = !DILocation(line: 39, column: 24, scope: !92)
!94 = !DILocation(line: 39, column: 27, scope: !92)
!95 = !DILocation(line: 39, column: 32, scope: !92)
!96 = !DILocation(line: 39, column: 30, scope: !92)
!97 = !DILocation(line: 39, column: 40, scope: !92)
!98 = !DILocation(line: 39, column: 42, scope: !92)
!99 = !DILocation(line: 39, column: 45, scope: !92)
!100 = !DILocation(line: 39, column: 38, scope: !92)
!101 = !DILocation(line: 39, column: 50, scope: !92)
!102 = !DILocation(line: 39, column: 52, scope: !92)
!103 = !DILocation(line: 39, column: 55, scope: !92)
!104 = !DILocation(line: 39, column: 60, scope: !92)
!105 = !DILocation(line: 39, column: 58, scope: !92)
!106 = !DILocation(line: 39, column: 68, scope: !92)
!107 = !DILocation(line: 39, column: 70, scope: !92)
!108 = !DILocation(line: 39, column: 73, scope: !92)
!109 = !DILocation(line: 39, column: 66, scope: !92)
!110 = !DILocation(line: 39, column: 48, scope: !92)
!111 = !DILocation(line: 39, column: 11, scope: !92)
!112 = !DILocation(line: 39, column: 13, scope: !92)
!113 = !DILocation(line: 39, column: 16, scope: !92)
!114 = !DILocation(line: 39, column: 19, scope: !92)
!115 = !DILocation(line: 40, column: 9, scope: !92)
!116 = !DILocation(line: 41, column: 7, scope: !87)
!117 = !DILocation(line: 37, column: 28, scope: !82)
!118 = !DILocation(line: 37, column: 7, scope: !82)
!119 = distinct !{!119, !84, !120, !69}
!120 = !DILocation(line: 41, column: 7, scope: !78)
!121 = !DILocation(line: 42, column: 5, scope: !79)
!122 = !DILocation(line: 34, column: 26, scope: !74)
!123 = !DILocation(line: 34, column: 5, scope: !74)
!124 = distinct !{!124, !76, !125, !69}
!125 = !DILocation(line: 42, column: 5, scope: !71)
!126 = !DILocation(line: 43, column: 3, scope: !45)
!127 = !DILocation(line: 20, column: 24, scope: !40)
!128 = !DILocation(line: 20, column: 3, scope: !40)
!129 = distinct !{!129, !42, !130, !69}
!130 = !DILocation(line: 43, column: 3, scope: !37)
!131 = !DILocation(line: 44, column: 1, scope: !7)
