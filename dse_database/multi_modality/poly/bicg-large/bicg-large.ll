; ModuleID = 'bicg-large.c'
source_filename = "bicg-large.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_bicg(i32 %m, i32 %n, [390 x double]* %A, double* %s, double* %q, double* %p, double* %r) #0 !dbg !9 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [390 x double]*, align 8
  %s.addr = alloca double*, align 8
  %q.addr = alloca double*, align 8
  %p.addr = alloca double*, align 8
  %r.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %m.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store [390 x double]* %A, [390 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [390 x double]** %A.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store double* %s, double** %s.addr, align 8
  call void @llvm.dbg.declare(metadata double** %s.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store double* %q, double** %q.addr, align 8
  call void @llvm.dbg.declare(metadata double** %q.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store double* %p, double** %p.addr, align 8
  call void @llvm.dbg.declare(metadata double** %p.addr, metadata !28, metadata !DIExpression()), !dbg !29
  store double* %r, double** %r.addr, align 8
  call void @llvm.dbg.declare(metadata double** %r.addr, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %i, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %j, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !38

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !39
  %cmp = icmp slt i32 %0, 390, !dbg !41
  br i1 %cmp, label %for.body, label %for.end, !dbg !42

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %s.addr, align 8, !dbg !43
  %2 = load i32, i32* %i, align 4, !dbg !44
  %idxprom = sext i32 %2 to i64, !dbg !43
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !43
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !45
  br label %for.inc, !dbg !43

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !46
  %inc = add nsw i32 %3, 1, !dbg !46
  store i32 %inc, i32* %i, align 4, !dbg !46
  br label %for.cond, !dbg !47, !llvm.loop !48

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !51
  br label %for.cond1, !dbg !53

for.cond1:                                        ; preds = %for.inc30, %for.end
  %4 = load i32, i32* %i, align 4, !dbg !54
  %cmp2 = icmp slt i32 %4, 410, !dbg !56
  br i1 %cmp2, label %for.body3, label %for.end32, !dbg !57

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %q.addr, align 8, !dbg !58
  %6 = load i32, i32* %i, align 4, !dbg !60
  %idxprom4 = sext i32 %6 to i64, !dbg !58
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !58
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !61
  store i32 0, i32* %j, align 4, !dbg !62
  br label %for.cond6, !dbg !64

for.cond6:                                        ; preds = %for.inc27, %for.body3
  %7 = load i32, i32* %j, align 4, !dbg !65
  %cmp7 = icmp slt i32 %7, 390, !dbg !67
  br i1 %cmp7, label %for.body8, label %for.end29, !dbg !68

for.body8:                                        ; preds = %for.cond6
  %8 = load double*, double** %r.addr, align 8, !dbg !69
  %9 = load i32, i32* %i, align 4, !dbg !71
  %idxprom9 = sext i32 %9 to i64, !dbg !69
  %arrayidx10 = getelementptr inbounds double, double* %8, i64 %idxprom9, !dbg !69
  %10 = load double, double* %arrayidx10, align 8, !dbg !69
  %11 = load [390 x double]*, [390 x double]** %A.addr, align 8, !dbg !72
  %12 = load i32, i32* %i, align 4, !dbg !73
  %idxprom11 = sext i32 %12 to i64, !dbg !72
  %arrayidx12 = getelementptr inbounds [390 x double], [390 x double]* %11, i64 %idxprom11, !dbg !72
  %13 = load i32, i32* %j, align 4, !dbg !74
  %idxprom13 = sext i32 %13 to i64, !dbg !72
  %arrayidx14 = getelementptr inbounds [390 x double], [390 x double]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !72
  %14 = load double, double* %arrayidx14, align 8, !dbg !72
  %mul = fmul double %10, %14, !dbg !75
  %15 = load double*, double** %s.addr, align 8, !dbg !76
  %16 = load i32, i32* %j, align 4, !dbg !77
  %idxprom15 = sext i32 %16 to i64, !dbg !76
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15, !dbg !76
  %17 = load double, double* %arrayidx16, align 8, !dbg !78
  %add = fadd double %17, %mul, !dbg !78
  store double %add, double* %arrayidx16, align 8, !dbg !78
  %18 = load [390 x double]*, [390 x double]** %A.addr, align 8, !dbg !79
  %19 = load i32, i32* %i, align 4, !dbg !80
  %idxprom17 = sext i32 %19 to i64, !dbg !79
  %arrayidx18 = getelementptr inbounds [390 x double], [390 x double]* %18, i64 %idxprom17, !dbg !79
  %20 = load i32, i32* %j, align 4, !dbg !81
  %idxprom19 = sext i32 %20 to i64, !dbg !79
  %arrayidx20 = getelementptr inbounds [390 x double], [390 x double]* %arrayidx18, i64 0, i64 %idxprom19, !dbg !79
  %21 = load double, double* %arrayidx20, align 8, !dbg !79
  %22 = load double*, double** %p.addr, align 8, !dbg !82
  %23 = load i32, i32* %j, align 4, !dbg !83
  %idxprom21 = sext i32 %23 to i64, !dbg !82
  %arrayidx22 = getelementptr inbounds double, double* %22, i64 %idxprom21, !dbg !82
  %24 = load double, double* %arrayidx22, align 8, !dbg !82
  %mul23 = fmul double %21, %24, !dbg !84
  %25 = load double*, double** %q.addr, align 8, !dbg !85
  %26 = load i32, i32* %i, align 4, !dbg !86
  %idxprom24 = sext i32 %26 to i64, !dbg !85
  %arrayidx25 = getelementptr inbounds double, double* %25, i64 %idxprom24, !dbg !85
  %27 = load double, double* %arrayidx25, align 8, !dbg !87
  %add26 = fadd double %27, %mul23, !dbg !87
  store double %add26, double* %arrayidx25, align 8, !dbg !87
  br label %for.inc27, !dbg !88

for.inc27:                                        ; preds = %for.body8
  %28 = load i32, i32* %j, align 4, !dbg !89
  %inc28 = add nsw i32 %28, 1, !dbg !89
  store i32 %inc28, i32* %j, align 4, !dbg !89
  br label %for.cond6, !dbg !90, !llvm.loop !91

for.end29:                                        ; preds = %for.cond6
  br label %for.inc30, !dbg !93

for.inc30:                                        ; preds = %for.end29
  %29 = load i32, i32* %i, align 4, !dbg !94
  %inc31 = add nsw i32 %29, 1, !dbg !94
  store i32 %inc31, i32* %i, align 4, !dbg !94
  br label %for.cond1, !dbg !95, !llvm.loop !96

for.end32:                                        ; preds = %for.cond1
  ret void, !dbg !98
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "bicg-large.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/bicg-large")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "kernel_bicg", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !12, !13, !17, !17, !17, !17}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 24960, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 390)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!18 = !DILocalVariable(name: "m", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!19 = !DILocation(line: 3, column: 22, scope: !9)
!20 = !DILocalVariable(name: "n", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!21 = !DILocation(line: 3, column: 28, scope: !9)
!22 = !DILocalVariable(name: "A", arg: 3, scope: !9, file: !1, line: 3, type: !13)
!23 = !DILocation(line: 3, column: 37, scope: !9)
!24 = !DILocalVariable(name: "s", arg: 4, scope: !9, file: !1, line: 3, type: !17)
!25 = !DILocation(line: 3, column: 56, scope: !9)
!26 = !DILocalVariable(name: "q", arg: 5, scope: !9, file: !1, line: 3, type: !17)
!27 = !DILocation(line: 3, column: 70, scope: !9)
!28 = !DILocalVariable(name: "p", arg: 6, scope: !9, file: !1, line: 3, type: !17)
!29 = !DILocation(line: 3, column: 84, scope: !9)
!30 = !DILocalVariable(name: "r", arg: 7, scope: !9, file: !1, line: 3, type: !17)
!31 = !DILocation(line: 3, column: 98, scope: !9)
!32 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 5, type: !12)
!33 = !DILocation(line: 5, column: 7, scope: !9)
!34 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 6, type: !12)
!35 = !DILocation(line: 6, column: 7, scope: !9)
!36 = !DILocation(line: 7, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !9, file: !1, line: 7, column: 3)
!38 = !DILocation(line: 7, column: 8, scope: !37)
!39 = !DILocation(line: 7, column: 15, scope: !40)
!40 = distinct !DILexicalBlock(scope: !37, file: !1, line: 7, column: 3)
!41 = !DILocation(line: 7, column: 17, scope: !40)
!42 = !DILocation(line: 7, column: 3, scope: !37)
!43 = !DILocation(line: 8, column: 5, scope: !40)
!44 = !DILocation(line: 8, column: 7, scope: !40)
!45 = !DILocation(line: 8, column: 10, scope: !40)
!46 = !DILocation(line: 7, column: 25, scope: !40)
!47 = !DILocation(line: 7, column: 3, scope: !40)
!48 = distinct !{!48, !42, !49, !50}
!49 = !DILocation(line: 8, column: 23, scope: !37)
!50 = !{!"llvm.loop.mustprogress"}
!51 = !DILocation(line: 15, column: 10, scope: !52)
!52 = distinct !DILexicalBlock(scope: !9, file: !1, line: 15, column: 3)
!53 = !DILocation(line: 15, column: 8, scope: !52)
!54 = !DILocation(line: 15, column: 15, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !1, line: 15, column: 3)
!56 = !DILocation(line: 15, column: 17, scope: !55)
!57 = !DILocation(line: 15, column: 3, scope: !52)
!58 = !DILocation(line: 16, column: 5, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 15, column: 29)
!60 = !DILocation(line: 16, column: 7, scope: !59)
!61 = !DILocation(line: 16, column: 10, scope: !59)
!62 = !DILocation(line: 19, column: 12, scope: !63)
!63 = distinct !DILexicalBlock(scope: !59, file: !1, line: 19, column: 5)
!64 = !DILocation(line: 19, column: 10, scope: !63)
!65 = !DILocation(line: 19, column: 17, scope: !66)
!66 = distinct !DILexicalBlock(scope: !63, file: !1, line: 19, column: 5)
!67 = !DILocation(line: 19, column: 19, scope: !66)
!68 = !DILocation(line: 19, column: 5, scope: !63)
!69 = !DILocation(line: 20, column: 15, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 19, column: 31)
!71 = !DILocation(line: 20, column: 17, scope: !70)
!72 = !DILocation(line: 20, column: 22, scope: !70)
!73 = !DILocation(line: 20, column: 24, scope: !70)
!74 = !DILocation(line: 20, column: 27, scope: !70)
!75 = !DILocation(line: 20, column: 20, scope: !70)
!76 = !DILocation(line: 20, column: 7, scope: !70)
!77 = !DILocation(line: 20, column: 9, scope: !70)
!78 = !DILocation(line: 20, column: 12, scope: !70)
!79 = !DILocation(line: 21, column: 15, scope: !70)
!80 = !DILocation(line: 21, column: 17, scope: !70)
!81 = !DILocation(line: 21, column: 20, scope: !70)
!82 = !DILocation(line: 21, column: 25, scope: !70)
!83 = !DILocation(line: 21, column: 27, scope: !70)
!84 = !DILocation(line: 21, column: 23, scope: !70)
!85 = !DILocation(line: 21, column: 7, scope: !70)
!86 = !DILocation(line: 21, column: 9, scope: !70)
!87 = !DILocation(line: 21, column: 12, scope: !70)
!88 = !DILocation(line: 22, column: 5, scope: !70)
!89 = !DILocation(line: 19, column: 27, scope: !66)
!90 = !DILocation(line: 19, column: 5, scope: !66)
!91 = distinct !{!91, !68, !92, !50}
!92 = !DILocation(line: 22, column: 5, scope: !63)
!93 = !DILocation(line: 23, column: 3, scope: !59)
!94 = !DILocation(line: 15, column: 25, scope: !55)
!95 = !DILocation(line: 15, column: 3, scope: !55)
!96 = distinct !{!96, !57, !97, !50}
!97 = !DILocation(line: 23, column: 3, scope: !52)
!98 = !DILocation(line: 24, column: 1, scope: !9)
