; ModuleID = 'bicg-medium.c'
source_filename = "bicg-medium.c"
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
  %2 = load i32, i32* %i, align 4, !dbg !45
  %idxprom = sext i32 %2 to i64, !dbg !43
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !43
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !46
  br label %for.inc, !dbg !47

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !48
  %inc = add nsw i32 %3, 1, !dbg !48
  store i32 %inc, i32* %i, align 4, !dbg !48
  br label %for.cond, !dbg !49, !llvm.loop !50

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !53
  br label %for.cond1, !dbg !55

for.cond1:                                        ; preds = %for.inc30, %for.end
  %4 = load i32, i32* %i, align 4, !dbg !56
  %cmp2 = icmp slt i32 %4, 410, !dbg !58
  br i1 %cmp2, label %for.body3, label %for.end32, !dbg !59

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %q.addr, align 8, !dbg !60
  %6 = load i32, i32* %i, align 4, !dbg !62
  %idxprom4 = sext i32 %6 to i64, !dbg !60
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !60
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !63
  store i32 0, i32* %j, align 4, !dbg !64
  br label %for.cond6, !dbg !66

for.cond6:                                        ; preds = %for.inc27, %for.body3
  %7 = load i32, i32* %j, align 4, !dbg !67
  %cmp7 = icmp slt i32 %7, 390, !dbg !69
  br i1 %cmp7, label %for.body8, label %for.end29, !dbg !70

for.body8:                                        ; preds = %for.cond6
  %8 = load double*, double** %r.addr, align 8, !dbg !71
  %9 = load i32, i32* %i, align 4, !dbg !73
  %idxprom9 = sext i32 %9 to i64, !dbg !71
  %arrayidx10 = getelementptr inbounds double, double* %8, i64 %idxprom9, !dbg !71
  %10 = load double, double* %arrayidx10, align 8, !dbg !71
  %11 = load [390 x double]*, [390 x double]** %A.addr, align 8, !dbg !74
  %12 = load i32, i32* %i, align 4, !dbg !75
  %idxprom11 = sext i32 %12 to i64, !dbg !74
  %arrayidx12 = getelementptr inbounds [390 x double], [390 x double]* %11, i64 %idxprom11, !dbg !74
  %13 = load i32, i32* %j, align 4, !dbg !76
  %idxprom13 = sext i32 %13 to i64, !dbg !74
  %arrayidx14 = getelementptr inbounds [390 x double], [390 x double]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !74
  %14 = load double, double* %arrayidx14, align 8, !dbg !74
  %mul = fmul double %10, %14, !dbg !77
  %15 = load double*, double** %s.addr, align 8, !dbg !78
  %16 = load i32, i32* %j, align 4, !dbg !79
  %idxprom15 = sext i32 %16 to i64, !dbg !78
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15, !dbg !78
  %17 = load double, double* %arrayidx16, align 8, !dbg !80
  %add = fadd double %17, %mul, !dbg !80
  store double %add, double* %arrayidx16, align 8, !dbg !80
  %18 = load [390 x double]*, [390 x double]** %A.addr, align 8, !dbg !81
  %19 = load i32, i32* %i, align 4, !dbg !82
  %idxprom17 = sext i32 %19 to i64, !dbg !81
  %arrayidx18 = getelementptr inbounds [390 x double], [390 x double]* %18, i64 %idxprom17, !dbg !81
  %20 = load i32, i32* %j, align 4, !dbg !83
  %idxprom19 = sext i32 %20 to i64, !dbg !81
  %arrayidx20 = getelementptr inbounds [390 x double], [390 x double]* %arrayidx18, i64 0, i64 %idxprom19, !dbg !81
  %21 = load double, double* %arrayidx20, align 8, !dbg !81
  %22 = load double*, double** %p.addr, align 8, !dbg !84
  %23 = load i32, i32* %j, align 4, !dbg !85
  %idxprom21 = sext i32 %23 to i64, !dbg !84
  %arrayidx22 = getelementptr inbounds double, double* %22, i64 %idxprom21, !dbg !84
  %24 = load double, double* %arrayidx22, align 8, !dbg !84
  %mul23 = fmul double %21, %24, !dbg !86
  %25 = load double*, double** %q.addr, align 8, !dbg !87
  %26 = load i32, i32* %i, align 4, !dbg !88
  %idxprom24 = sext i32 %26 to i64, !dbg !87
  %arrayidx25 = getelementptr inbounds double, double* %25, i64 %idxprom24, !dbg !87
  %27 = load double, double* %arrayidx25, align 8, !dbg !89
  %add26 = fadd double %27, %mul23, !dbg !89
  store double %add26, double* %arrayidx25, align 8, !dbg !89
  br label %for.inc27, !dbg !90

for.inc27:                                        ; preds = %for.body8
  %28 = load i32, i32* %j, align 4, !dbg !91
  %inc28 = add nsw i32 %28, 1, !dbg !91
  store i32 %inc28, i32* %j, align 4, !dbg !91
  br label %for.cond6, !dbg !92, !llvm.loop !93

for.end29:                                        ; preds = %for.cond6
  br label %for.inc30, !dbg !95

for.inc30:                                        ; preds = %for.end29
  %29 = load i32, i32* %i, align 4, !dbg !96
  %inc31 = add nsw i32 %29, 1, !dbg !96
  store i32 %inc31, i32* %i, align 4, !dbg !96
  br label %for.cond1, !dbg !97, !llvm.loop !98

for.end32:                                        ; preds = %for.cond1
  ret void, !dbg !100
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "bicg-medium.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/bicg-medium")
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
!36 = !DILocation(line: 9, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !9, file: !1, line: 9, column: 3)
!38 = !DILocation(line: 9, column: 8, scope: !37)
!39 = !DILocation(line: 9, column: 15, scope: !40)
!40 = distinct !DILexicalBlock(scope: !37, file: !1, line: 9, column: 3)
!41 = !DILocation(line: 9, column: 17, scope: !40)
!42 = !DILocation(line: 9, column: 3, scope: !37)
!43 = !DILocation(line: 10, column: 5, scope: !44)
!44 = distinct !DILexicalBlock(scope: !40, file: !1, line: 9, column: 29)
!45 = !DILocation(line: 10, column: 7, scope: !44)
!46 = !DILocation(line: 10, column: 10, scope: !44)
!47 = !DILocation(line: 11, column: 3, scope: !44)
!48 = !DILocation(line: 9, column: 25, scope: !40)
!49 = !DILocation(line: 9, column: 3, scope: !40)
!50 = distinct !{!50, !42, !51, !52}
!51 = !DILocation(line: 11, column: 3, scope: !37)
!52 = !{!"llvm.loop.mustprogress"}
!53 = !DILocation(line: 18, column: 10, scope: !54)
!54 = distinct !DILexicalBlock(scope: !9, file: !1, line: 18, column: 3)
!55 = !DILocation(line: 18, column: 8, scope: !54)
!56 = !DILocation(line: 18, column: 15, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 18, column: 3)
!58 = !DILocation(line: 18, column: 17, scope: !57)
!59 = !DILocation(line: 18, column: 3, scope: !54)
!60 = !DILocation(line: 19, column: 5, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 18, column: 29)
!62 = !DILocation(line: 19, column: 7, scope: !61)
!63 = !DILocation(line: 19, column: 10, scope: !61)
!64 = !DILocation(line: 22, column: 12, scope: !65)
!65 = distinct !DILexicalBlock(scope: !61, file: !1, line: 22, column: 5)
!66 = !DILocation(line: 22, column: 10, scope: !65)
!67 = !DILocation(line: 22, column: 17, scope: !68)
!68 = distinct !DILexicalBlock(scope: !65, file: !1, line: 22, column: 5)
!69 = !DILocation(line: 22, column: 19, scope: !68)
!70 = !DILocation(line: 22, column: 5, scope: !65)
!71 = !DILocation(line: 23, column: 15, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !1, line: 22, column: 31)
!73 = !DILocation(line: 23, column: 17, scope: !72)
!74 = !DILocation(line: 23, column: 22, scope: !72)
!75 = !DILocation(line: 23, column: 24, scope: !72)
!76 = !DILocation(line: 23, column: 27, scope: !72)
!77 = !DILocation(line: 23, column: 20, scope: !72)
!78 = !DILocation(line: 23, column: 7, scope: !72)
!79 = !DILocation(line: 23, column: 9, scope: !72)
!80 = !DILocation(line: 23, column: 12, scope: !72)
!81 = !DILocation(line: 24, column: 15, scope: !72)
!82 = !DILocation(line: 24, column: 17, scope: !72)
!83 = !DILocation(line: 24, column: 20, scope: !72)
!84 = !DILocation(line: 24, column: 25, scope: !72)
!85 = !DILocation(line: 24, column: 27, scope: !72)
!86 = !DILocation(line: 24, column: 23, scope: !72)
!87 = !DILocation(line: 24, column: 7, scope: !72)
!88 = !DILocation(line: 24, column: 9, scope: !72)
!89 = !DILocation(line: 24, column: 12, scope: !72)
!90 = !DILocation(line: 25, column: 5, scope: !72)
!91 = !DILocation(line: 22, column: 27, scope: !68)
!92 = !DILocation(line: 22, column: 5, scope: !68)
!93 = distinct !{!93, !70, !94, !52}
!94 = !DILocation(line: 25, column: 5, scope: !65)
!95 = !DILocation(line: 26, column: 3, scope: !61)
!96 = !DILocation(line: 18, column: 25, scope: !57)
!97 = !DILocation(line: 18, column: 3, scope: !57)
!98 = distinct !{!98, !59, !99, !52}
!99 = !DILocation(line: 26, column: 3, scope: !54)
!100 = !DILocation(line: 27, column: 1, scope: !9)
