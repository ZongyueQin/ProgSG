; ModuleID = 'atax-medium.c'
source_filename = "atax-medium.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_atax([410 x double]* %A, double* %x, double* %y, double* %tmp) #0 !dbg !9 {
entry:
  %A.addr = alloca [410 x double]*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %tmp.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [410 x double]* %A, [410 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [410 x double]** %A.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store double* %tmp, double** %tmp.addr, align 8
  call void @llvm.dbg.declare(metadata double** %tmp.addr, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.declare(metadata i32* %j, metadata !28, metadata !DIExpression()), !dbg !29
  store i32 0, i32* %i, align 4, !dbg !30
  br label %for.cond, !dbg !32

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !33
  %cmp = icmp slt i32 %0, 410, !dbg !35
  br i1 %cmp, label %for.body, label %for.end, !dbg !36

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %y.addr, align 8, !dbg !37
  %2 = load i32, i32* %i, align 4, !dbg !38
  %idxprom = sext i32 %2 to i64, !dbg !37
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !37
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !39
  br label %for.inc, !dbg !37

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !40
  %inc = add nsw i32 %3, 1, !dbg !40
  store i32 %inc, i32* %i, align 4, !dbg !40
  br label %for.cond, !dbg !41, !llvm.loop !42

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !45
  br label %for.cond1, !dbg !47

for.cond1:                                        ; preds = %for.inc36, %for.end
  %4 = load i32, i32* %i, align 4, !dbg !48
  %cmp2 = icmp slt i32 %4, 390, !dbg !50
  br i1 %cmp2, label %for.body3, label %for.end38, !dbg !51

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %tmp.addr, align 8, !dbg !52
  %6 = load i32, i32* %i, align 4, !dbg !54
  %idxprom4 = sext i32 %6 to i64, !dbg !52
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !52
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !55
  store i32 0, i32* %j, align 4, !dbg !56
  br label %for.cond6, !dbg !58

for.cond6:                                        ; preds = %for.inc17, %for.body3
  %7 = load i32, i32* %j, align 4, !dbg !59
  %cmp7 = icmp slt i32 %7, 410, !dbg !61
  br i1 %cmp7, label %for.body8, label %for.end19, !dbg !62

for.body8:                                        ; preds = %for.cond6
  %8 = load [410 x double]*, [410 x double]** %A.addr, align 8, !dbg !63
  %9 = load i32, i32* %i, align 4, !dbg !65
  %idxprom9 = sext i32 %9 to i64, !dbg !63
  %arrayidx10 = getelementptr inbounds [410 x double], [410 x double]* %8, i64 %idxprom9, !dbg !63
  %10 = load i32, i32* %j, align 4, !dbg !66
  %idxprom11 = sext i32 %10 to i64, !dbg !63
  %arrayidx12 = getelementptr inbounds [410 x double], [410 x double]* %arrayidx10, i64 0, i64 %idxprom11, !dbg !63
  %11 = load double, double* %arrayidx12, align 8, !dbg !63
  %12 = load double*, double** %x.addr, align 8, !dbg !67
  %13 = load i32, i32* %j, align 4, !dbg !68
  %idxprom13 = sext i32 %13 to i64, !dbg !67
  %arrayidx14 = getelementptr inbounds double, double* %12, i64 %idxprom13, !dbg !67
  %14 = load double, double* %arrayidx14, align 8, !dbg !67
  %mul = fmul double %11, %14, !dbg !69
  %15 = load double*, double** %tmp.addr, align 8, !dbg !70
  %16 = load i32, i32* %i, align 4, !dbg !71
  %idxprom15 = sext i32 %16 to i64, !dbg !70
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15, !dbg !70
  %17 = load double, double* %arrayidx16, align 8, !dbg !72
  %add = fadd double %17, %mul, !dbg !72
  store double %add, double* %arrayidx16, align 8, !dbg !72
  br label %for.inc17, !dbg !73

for.inc17:                                        ; preds = %for.body8
  %18 = load i32, i32* %j, align 4, !dbg !74
  %inc18 = add nsw i32 %18, 1, !dbg !74
  store i32 %inc18, i32* %j, align 4, !dbg !74
  br label %for.cond6, !dbg !75, !llvm.loop !76

for.end19:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4, !dbg !78
  br label %for.cond20, !dbg !80

for.cond20:                                       ; preds = %for.inc33, %for.end19
  %19 = load i32, i32* %j, align 4, !dbg !81
  %cmp21 = icmp slt i32 %19, 410, !dbg !83
  br i1 %cmp21, label %for.body22, label %for.end35, !dbg !84

for.body22:                                       ; preds = %for.cond20
  %20 = load [410 x double]*, [410 x double]** %A.addr, align 8, !dbg !85
  %21 = load i32, i32* %i, align 4, !dbg !87
  %idxprom23 = sext i32 %21 to i64, !dbg !85
  %arrayidx24 = getelementptr inbounds [410 x double], [410 x double]* %20, i64 %idxprom23, !dbg !85
  %22 = load i32, i32* %j, align 4, !dbg !88
  %idxprom25 = sext i32 %22 to i64, !dbg !85
  %arrayidx26 = getelementptr inbounds [410 x double], [410 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !85
  %23 = load double, double* %arrayidx26, align 8, !dbg !85
  %24 = load double*, double** %tmp.addr, align 8, !dbg !89
  %25 = load i32, i32* %i, align 4, !dbg !90
  %idxprom27 = sext i32 %25 to i64, !dbg !89
  %arrayidx28 = getelementptr inbounds double, double* %24, i64 %idxprom27, !dbg !89
  %26 = load double, double* %arrayidx28, align 8, !dbg !89
  %mul29 = fmul double %23, %26, !dbg !91
  %27 = load double*, double** %y.addr, align 8, !dbg !92
  %28 = load i32, i32* %j, align 4, !dbg !93
  %idxprom30 = sext i32 %28 to i64, !dbg !92
  %arrayidx31 = getelementptr inbounds double, double* %27, i64 %idxprom30, !dbg !92
  %29 = load double, double* %arrayidx31, align 8, !dbg !94
  %add32 = fadd double %29, %mul29, !dbg !94
  store double %add32, double* %arrayidx31, align 8, !dbg !94
  br label %for.inc33, !dbg !95

for.inc33:                                        ; preds = %for.body22
  %30 = load i32, i32* %j, align 4, !dbg !96
  %inc34 = add nsw i32 %30, 1, !dbg !96
  store i32 %inc34, i32* %j, align 4, !dbg !96
  br label %for.cond20, !dbg !97, !llvm.loop !98

for.end35:                                        ; preds = %for.cond20
  br label %for.inc36, !dbg !100

for.inc36:                                        ; preds = %for.end35
  %31 = load i32, i32* %i, align 4, !dbg !101
  %inc37 = add nsw i32 %31, 1, !dbg !101
  store i32 %inc37, i32* %i, align 4, !dbg !101
  br label %for.cond1, !dbg !102, !llvm.loop !103

for.end38:                                        ; preds = %for.cond1
  ret void, !dbg !105
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "atax-medium.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/atax-medium")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "kernel_atax", scope: !1, file: !1, line: 4, type: !10, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !16, !16, !16}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 26240, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 410)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!17 = !DILocalVariable(name: "A", arg: 1, scope: !9, file: !1, line: 4, type: !12)
!18 = !DILocation(line: 4, column: 25, scope: !9)
!19 = !DILocalVariable(name: "x", arg: 2, scope: !9, file: !1, line: 4, type: !16)
!20 = !DILocation(line: 4, column: 44, scope: !9)
!21 = !DILocalVariable(name: "y", arg: 3, scope: !9, file: !1, line: 4, type: !16)
!22 = !DILocation(line: 4, column: 58, scope: !9)
!23 = !DILocalVariable(name: "tmp", arg: 4, scope: !9, file: !1, line: 4, type: !16)
!24 = !DILocation(line: 4, column: 72, scope: !9)
!25 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 6, type: !26)
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DILocation(line: 6, column: 7, scope: !9)
!28 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 7, type: !26)
!29 = !DILocation(line: 7, column: 7, scope: !9)
!30 = !DILocation(line: 8, column: 10, scope: !31)
!31 = distinct !DILexicalBlock(scope: !9, file: !1, line: 8, column: 3)
!32 = !DILocation(line: 8, column: 8, scope: !31)
!33 = !DILocation(line: 8, column: 15, scope: !34)
!34 = distinct !DILexicalBlock(scope: !31, file: !1, line: 8, column: 3)
!35 = !DILocation(line: 8, column: 17, scope: !34)
!36 = !DILocation(line: 8, column: 3, scope: !31)
!37 = !DILocation(line: 9, column: 5, scope: !34)
!38 = !DILocation(line: 9, column: 7, scope: !34)
!39 = !DILocation(line: 9, column: 10, scope: !34)
!40 = !DILocation(line: 8, column: 25, scope: !34)
!41 = !DILocation(line: 8, column: 3, scope: !34)
!42 = distinct !{!42, !36, !43, !44}
!43 = !DILocation(line: 9, column: 23, scope: !31)
!44 = !{!"llvm.loop.mustprogress"}
!45 = !DILocation(line: 16, column: 10, scope: !46)
!46 = distinct !DILexicalBlock(scope: !9, file: !1, line: 16, column: 3)
!47 = !DILocation(line: 16, column: 8, scope: !46)
!48 = !DILocation(line: 16, column: 15, scope: !49)
!49 = distinct !DILexicalBlock(scope: !46, file: !1, line: 16, column: 3)
!50 = !DILocation(line: 16, column: 17, scope: !49)
!51 = !DILocation(line: 16, column: 3, scope: !46)
!52 = !DILocation(line: 17, column: 5, scope: !53)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 16, column: 29)
!54 = !DILocation(line: 17, column: 9, scope: !53)
!55 = !DILocation(line: 17, column: 12, scope: !53)
!56 = !DILocation(line: 20, column: 12, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 20, column: 5)
!58 = !DILocation(line: 20, column: 10, scope: !57)
!59 = !DILocation(line: 20, column: 17, scope: !60)
!60 = distinct !DILexicalBlock(scope: !57, file: !1, line: 20, column: 5)
!61 = !DILocation(line: 20, column: 19, scope: !60)
!62 = !DILocation(line: 20, column: 5, scope: !57)
!63 = !DILocation(line: 21, column: 17, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 20, column: 31)
!65 = !DILocation(line: 21, column: 19, scope: !64)
!66 = !DILocation(line: 21, column: 22, scope: !64)
!67 = !DILocation(line: 21, column: 27, scope: !64)
!68 = !DILocation(line: 21, column: 29, scope: !64)
!69 = !DILocation(line: 21, column: 25, scope: !64)
!70 = !DILocation(line: 21, column: 7, scope: !64)
!71 = !DILocation(line: 21, column: 11, scope: !64)
!72 = !DILocation(line: 21, column: 14, scope: !64)
!73 = !DILocation(line: 22, column: 5, scope: !64)
!74 = !DILocation(line: 20, column: 27, scope: !60)
!75 = !DILocation(line: 20, column: 5, scope: !60)
!76 = distinct !{!76, !62, !77, !44}
!77 = !DILocation(line: 22, column: 5, scope: !57)
!78 = !DILocation(line: 25, column: 12, scope: !79)
!79 = distinct !DILexicalBlock(scope: !53, file: !1, line: 25, column: 5)
!80 = !DILocation(line: 25, column: 10, scope: !79)
!81 = !DILocation(line: 25, column: 17, scope: !82)
!82 = distinct !DILexicalBlock(scope: !79, file: !1, line: 25, column: 5)
!83 = !DILocation(line: 25, column: 19, scope: !82)
!84 = !DILocation(line: 25, column: 5, scope: !79)
!85 = !DILocation(line: 26, column: 15, scope: !86)
!86 = distinct !DILexicalBlock(scope: !82, file: !1, line: 25, column: 31)
!87 = !DILocation(line: 26, column: 17, scope: !86)
!88 = !DILocation(line: 26, column: 20, scope: !86)
!89 = !DILocation(line: 26, column: 25, scope: !86)
!90 = !DILocation(line: 26, column: 29, scope: !86)
!91 = !DILocation(line: 26, column: 23, scope: !86)
!92 = !DILocation(line: 26, column: 7, scope: !86)
!93 = !DILocation(line: 26, column: 9, scope: !86)
!94 = !DILocation(line: 26, column: 12, scope: !86)
!95 = !DILocation(line: 27, column: 5, scope: !86)
!96 = !DILocation(line: 25, column: 27, scope: !82)
!97 = !DILocation(line: 25, column: 5, scope: !82)
!98 = distinct !{!98, !84, !99, !44}
!99 = !DILocation(line: 27, column: 5, scope: !79)
!100 = !DILocation(line: 28, column: 3, scope: !53)
!101 = !DILocation(line: 16, column: 25, scope: !49)
!102 = !DILocation(line: 16, column: 3, scope: !49)
!103 = distinct !{!103, !51, !104, !44}
!104 = !DILocation(line: 28, column: 3, scope: !46)
!105 = !DILocation(line: 29, column: 1, scope: !9)
