; ModuleID = 'mvt-medium.c'
source_filename = "mvt-medium.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_mvt(double* %x1, double* %x2, double* %y_1, double* %y_2, [400 x double]* %A) #0 !dbg !7 {
entry:
  %x1.addr = alloca double*, align 8
  %x2.addr = alloca double*, align 8
  %y_1.addr = alloca double*, align 8
  %y_2.addr = alloca double*, align 8
  %A.addr = alloca [400 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %x1, double** %x1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x1.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store double* %x2, double** %x2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x2.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store double* %y_1, double** %y_1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y_1.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store double* %y_2, double** %y_2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y_2.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store [400 x double]* %A, [400 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [400 x double]** %A.addr, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %i, metadata !26, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %j, metadata !29, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc10, %entry
  %0 = load i32, i32* %i, align 4, !dbg !34
  %cmp = icmp slt i32 %0, 400, !dbg !36
  br i1 %cmp, label %for.body, label %for.end12, !dbg !37

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !38
  br label %for.cond1, !dbg !41

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !42
  %cmp2 = icmp slt i32 %1, 400, !dbg !44
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !45

for.body3:                                        ; preds = %for.cond1
  %2 = load [400 x double]*, [400 x double]** %A.addr, align 8, !dbg !46
  %3 = load i32, i32* %i, align 4, !dbg !48
  %idxprom = sext i32 %3 to i64, !dbg !46
  %arrayidx = getelementptr inbounds [400 x double], [400 x double]* %2, i64 %idxprom, !dbg !46
  %4 = load i32, i32* %j, align 4, !dbg !49
  %idxprom4 = sext i32 %4 to i64, !dbg !46
  %arrayidx5 = getelementptr inbounds [400 x double], [400 x double]* %arrayidx, i64 0, i64 %idxprom4, !dbg !46
  %5 = load double, double* %arrayidx5, align 8, !dbg !46
  %6 = load double*, double** %y_1.addr, align 8, !dbg !50
  %7 = load i32, i32* %j, align 4, !dbg !51
  %idxprom6 = sext i32 %7 to i64, !dbg !50
  %arrayidx7 = getelementptr inbounds double, double* %6, i64 %idxprom6, !dbg !50
  %8 = load double, double* %arrayidx7, align 8, !dbg !50
  %mul = fmul double %5, %8, !dbg !52
  %9 = load double*, double** %x1.addr, align 8, !dbg !53
  %10 = load i32, i32* %i, align 4, !dbg !54
  %idxprom8 = sext i32 %10 to i64, !dbg !53
  %arrayidx9 = getelementptr inbounds double, double* %9, i64 %idxprom8, !dbg !53
  %11 = load double, double* %arrayidx9, align 8, !dbg !55
  %add = fadd double %11, %mul, !dbg !55
  store double %add, double* %arrayidx9, align 8, !dbg !55
  br label %for.inc, !dbg !56

for.inc:                                          ; preds = %for.body3
  %12 = load i32, i32* %j, align 4, !dbg !57
  %inc = add nsw i32 %12, 1, !dbg !57
  store i32 %inc, i32* %j, align 4, !dbg !57
  br label %for.cond1, !dbg !58, !llvm.loop !59

for.end:                                          ; preds = %for.cond1
  br label %for.inc10, !dbg !62

for.inc10:                                        ; preds = %for.end
  %13 = load i32, i32* %i, align 4, !dbg !63
  %inc11 = add nsw i32 %13, 1, !dbg !63
  store i32 %inc11, i32* %i, align 4, !dbg !63
  br label %for.cond, !dbg !64, !llvm.loop !65

for.end12:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !67
  br label %for.cond13, !dbg !69

for.cond13:                                       ; preds = %for.inc32, %for.end12
  %14 = load i32, i32* %i, align 4, !dbg !70
  %cmp14 = icmp slt i32 %14, 400, !dbg !72
  br i1 %cmp14, label %for.body15, label %for.end34, !dbg !73

for.body15:                                       ; preds = %for.cond13
  store i32 0, i32* %j, align 4, !dbg !74
  br label %for.cond16, !dbg !77

for.cond16:                                       ; preds = %for.inc29, %for.body15
  %15 = load i32, i32* %j, align 4, !dbg !78
  %cmp17 = icmp slt i32 %15, 400, !dbg !80
  br i1 %cmp17, label %for.body18, label %for.end31, !dbg !81

for.body18:                                       ; preds = %for.cond16
  %16 = load [400 x double]*, [400 x double]** %A.addr, align 8, !dbg !82
  %17 = load i32, i32* %j, align 4, !dbg !84
  %idxprom19 = sext i32 %17 to i64, !dbg !82
  %arrayidx20 = getelementptr inbounds [400 x double], [400 x double]* %16, i64 %idxprom19, !dbg !82
  %18 = load i32, i32* %i, align 4, !dbg !85
  %idxprom21 = sext i32 %18 to i64, !dbg !82
  %arrayidx22 = getelementptr inbounds [400 x double], [400 x double]* %arrayidx20, i64 0, i64 %idxprom21, !dbg !82
  %19 = load double, double* %arrayidx22, align 8, !dbg !82
  %20 = load double*, double** %y_2.addr, align 8, !dbg !86
  %21 = load i32, i32* %j, align 4, !dbg !87
  %idxprom23 = sext i32 %21 to i64, !dbg !86
  %arrayidx24 = getelementptr inbounds double, double* %20, i64 %idxprom23, !dbg !86
  %22 = load double, double* %arrayidx24, align 8, !dbg !86
  %mul25 = fmul double %19, %22, !dbg !88
  %23 = load double*, double** %x2.addr, align 8, !dbg !89
  %24 = load i32, i32* %i, align 4, !dbg !90
  %idxprom26 = sext i32 %24 to i64, !dbg !89
  %arrayidx27 = getelementptr inbounds double, double* %23, i64 %idxprom26, !dbg !89
  %25 = load double, double* %arrayidx27, align 8, !dbg !91
  %add28 = fadd double %25, %mul25, !dbg !91
  store double %add28, double* %arrayidx27, align 8, !dbg !91
  br label %for.inc29, !dbg !92

for.inc29:                                        ; preds = %for.body18
  %26 = load i32, i32* %j, align 4, !dbg !93
  %inc30 = add nsw i32 %26, 1, !dbg !93
  store i32 %inc30, i32* %j, align 4, !dbg !93
  br label %for.cond16, !dbg !94, !llvm.loop !95

for.end31:                                        ; preds = %for.cond16
  br label %for.inc32, !dbg !97

for.inc32:                                        ; preds = %for.end31
  %27 = load i32, i32* %i, align 4, !dbg !98
  %inc33 = add nsw i32 %27, 1, !dbg !98
  store i32 %inc33, i32* %i, align 4, !dbg !98
  br label %for.cond13, !dbg !99, !llvm.loop !100

for.end34:                                        ; preds = %for.cond13
  ret void, !dbg !102
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "mvt-medium.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/mvt-medium")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_mvt", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !10, !10, !12}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 25600, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 400)
!16 = !DILocalVariable(name: "x1", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 24, scope: !7)
!18 = !DILocalVariable(name: "x2", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!19 = !DILocation(line: 3, column: 39, scope: !7)
!20 = !DILocalVariable(name: "y_1", arg: 3, scope: !7, file: !1, line: 3, type: !10)
!21 = !DILocation(line: 3, column: 54, scope: !7)
!22 = !DILocalVariable(name: "y_2", arg: 4, scope: !7, file: !1, line: 3, type: !10)
!23 = !DILocation(line: 3, column: 70, scope: !7)
!24 = !DILocalVariable(name: "A", arg: 5, scope: !7, file: !1, line: 3, type: !12)
!25 = !DILocation(line: 3, column: 86, scope: !7)
!26 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !27)
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DILocation(line: 5, column: 7, scope: !7)
!29 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !27)
!30 = !DILocation(line: 6, column: 7, scope: !7)
!31 = !DILocation(line: 13, column: 10, scope: !32)
!32 = distinct !DILexicalBlock(scope: !7, file: !1, line: 13, column: 3)
!33 = !DILocation(line: 13, column: 8, scope: !32)
!34 = !DILocation(line: 13, column: 15, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 13, column: 3)
!36 = !DILocation(line: 13, column: 17, scope: !35)
!37 = !DILocation(line: 13, column: 3, scope: !32)
!38 = !DILocation(line: 16, column: 12, scope: !39)
!39 = distinct !DILexicalBlock(scope: !40, file: !1, line: 16, column: 5)
!40 = distinct !DILexicalBlock(scope: !35, file: !1, line: 13, column: 29)
!41 = !DILocation(line: 16, column: 10, scope: !39)
!42 = !DILocation(line: 16, column: 17, scope: !43)
!43 = distinct !DILexicalBlock(scope: !39, file: !1, line: 16, column: 5)
!44 = !DILocation(line: 16, column: 19, scope: !43)
!45 = !DILocation(line: 16, column: 5, scope: !39)
!46 = !DILocation(line: 17, column: 16, scope: !47)
!47 = distinct !DILexicalBlock(scope: !43, file: !1, line: 16, column: 31)
!48 = !DILocation(line: 17, column: 18, scope: !47)
!49 = !DILocation(line: 17, column: 21, scope: !47)
!50 = !DILocation(line: 17, column: 26, scope: !47)
!51 = !DILocation(line: 17, column: 30, scope: !47)
!52 = !DILocation(line: 17, column: 24, scope: !47)
!53 = !DILocation(line: 17, column: 7, scope: !47)
!54 = !DILocation(line: 17, column: 10, scope: !47)
!55 = !DILocation(line: 17, column: 13, scope: !47)
!56 = !DILocation(line: 18, column: 5, scope: !47)
!57 = !DILocation(line: 16, column: 27, scope: !43)
!58 = !DILocation(line: 16, column: 5, scope: !43)
!59 = distinct !{!59, !45, !60, !61}
!60 = !DILocation(line: 18, column: 5, scope: !39)
!61 = !{!"llvm.loop.mustprogress"}
!62 = !DILocation(line: 19, column: 3, scope: !40)
!63 = !DILocation(line: 13, column: 25, scope: !35)
!64 = !DILocation(line: 13, column: 3, scope: !35)
!65 = distinct !{!65, !37, !66, !61}
!66 = !DILocation(line: 19, column: 3, scope: !32)
!67 = !DILocation(line: 26, column: 10, scope: !68)
!68 = distinct !DILexicalBlock(scope: !7, file: !1, line: 26, column: 3)
!69 = !DILocation(line: 26, column: 8, scope: !68)
!70 = !DILocation(line: 26, column: 15, scope: !71)
!71 = distinct !DILexicalBlock(scope: !68, file: !1, line: 26, column: 3)
!72 = !DILocation(line: 26, column: 17, scope: !71)
!73 = !DILocation(line: 26, column: 3, scope: !68)
!74 = !DILocation(line: 29, column: 12, scope: !75)
!75 = distinct !DILexicalBlock(scope: !76, file: !1, line: 29, column: 5)
!76 = distinct !DILexicalBlock(scope: !71, file: !1, line: 26, column: 29)
!77 = !DILocation(line: 29, column: 10, scope: !75)
!78 = !DILocation(line: 29, column: 17, scope: !79)
!79 = distinct !DILexicalBlock(scope: !75, file: !1, line: 29, column: 5)
!80 = !DILocation(line: 29, column: 19, scope: !79)
!81 = !DILocation(line: 29, column: 5, scope: !75)
!82 = !DILocation(line: 30, column: 16, scope: !83)
!83 = distinct !DILexicalBlock(scope: !79, file: !1, line: 29, column: 31)
!84 = !DILocation(line: 30, column: 18, scope: !83)
!85 = !DILocation(line: 30, column: 21, scope: !83)
!86 = !DILocation(line: 30, column: 26, scope: !83)
!87 = !DILocation(line: 30, column: 30, scope: !83)
!88 = !DILocation(line: 30, column: 24, scope: !83)
!89 = !DILocation(line: 30, column: 7, scope: !83)
!90 = !DILocation(line: 30, column: 10, scope: !83)
!91 = !DILocation(line: 30, column: 13, scope: !83)
!92 = !DILocation(line: 31, column: 5, scope: !83)
!93 = !DILocation(line: 29, column: 27, scope: !79)
!94 = !DILocation(line: 29, column: 5, scope: !79)
!95 = distinct !{!95, !81, !96, !61}
!96 = !DILocation(line: 31, column: 5, scope: !75)
!97 = !DILocation(line: 32, column: 3, scope: !76)
!98 = !DILocation(line: 26, column: 25, scope: !71)
!99 = !DILocation(line: 26, column: 3, scope: !71)
!100 = distinct !{!100, !73, !101, !61}
!101 = !DILocation(line: 32, column: 3, scope: !68)
!102 = !DILocation(line: 33, column: 1, scope: !7)
