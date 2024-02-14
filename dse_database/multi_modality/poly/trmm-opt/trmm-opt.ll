; ModuleID = 'trmm-opt.c'
source_filename = "trmm-opt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_trmm(double %alpha, [60 x double]* %A, [80 x double]* %B) #0 !dbg !7 {
entry:
  %alpha.addr = alloca double, align 8
  %A.addr = alloca [60 x double]*, align 8
  %B.addr = alloca [80 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %sum = alloca double, align 8
  %k = alloca i32, align 4
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store [60 x double]* %A, [60 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [60 x double]** %A.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store [80 x double]* %B, [80 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %B.addr, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !DIExpression()), !dbg !28
  store i32 0, i32* %i, align 4, !dbg !28
  br label %for.cond, !dbg !29

for.cond:                                         ; preds = %for.inc26, %entry
  %0 = load i32, i32* %i, align 4, !dbg !30
  %cmp = icmp slt i32 %0, 60, !dbg !32
  br i1 %cmp, label %for.body, label %for.end28, !dbg !33

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !34, metadata !DIExpression()), !dbg !37
  store i32 0, i32* %j, align 4, !dbg !37
  br label %for.cond1, !dbg !38

for.cond1:                                        ; preds = %for.inc23, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !39
  %cmp2 = icmp slt i32 %1, 80, !dbg !41
  br i1 %cmp2, label %for.body3, label %for.end25, !dbg !42

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata double* %sum, metadata !43, metadata !DIExpression()), !dbg !45
  %2 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !46
  %3 = load i32, i32* %i, align 4, !dbg !47
  %idxprom = sext i32 %3 to i64, !dbg !46
  %arrayidx = getelementptr inbounds [80 x double], [80 x double]* %2, i64 %idxprom, !dbg !46
  %4 = load i32, i32* %j, align 4, !dbg !48
  %idxprom4 = sext i32 %4 to i64, !dbg !46
  %arrayidx5 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx, i64 0, i64 %idxprom4, !dbg !46
  %5 = load double, double* %arrayidx5, align 8, !dbg !46
  store double %5, double* %sum, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i32* %k, metadata !49, metadata !DIExpression()), !dbg !51
  store i32 0, i32* %k, align 4, !dbg !51
  br label %for.cond6, !dbg !52

for.cond6:                                        ; preds = %for.inc, %for.body3
  %6 = load i32, i32* %k, align 4, !dbg !53
  %cmp7 = icmp slt i32 %6, 60, !dbg !55
  br i1 %cmp7, label %for.body8, label %for.end, !dbg !56

for.body8:                                        ; preds = %for.cond6
  %7 = load i32, i32* %k, align 4, !dbg !57
  %8 = load i32, i32* %i, align 4, !dbg !60
  %cmp9 = icmp sgt i32 %7, %8, !dbg !61
  br i1 %cmp9, label %if.then, label %if.end, !dbg !62

if.then:                                          ; preds = %for.body8
  %9 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !63
  %10 = load i32, i32* %k, align 4, !dbg !65
  %idxprom10 = sext i32 %10 to i64, !dbg !63
  %arrayidx11 = getelementptr inbounds [60 x double], [60 x double]* %9, i64 %idxprom10, !dbg !63
  %11 = load i32, i32* %i, align 4, !dbg !66
  %idxprom12 = sext i32 %11 to i64, !dbg !63
  %arrayidx13 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx11, i64 0, i64 %idxprom12, !dbg !63
  %12 = load double, double* %arrayidx13, align 8, !dbg !63
  %13 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !67
  %14 = load i32, i32* %k, align 4, !dbg !68
  %idxprom14 = sext i32 %14 to i64, !dbg !67
  %arrayidx15 = getelementptr inbounds [80 x double], [80 x double]* %13, i64 %idxprom14, !dbg !67
  %15 = load i32, i32* %j, align 4, !dbg !69
  %idxprom16 = sext i32 %15 to i64, !dbg !67
  %arrayidx17 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx15, i64 0, i64 %idxprom16, !dbg !67
  %16 = load double, double* %arrayidx17, align 8, !dbg !67
  %mul = fmul double %12, %16, !dbg !70
  %17 = load double, double* %sum, align 8, !dbg !71
  %add = fadd double %17, %mul, !dbg !71
  store double %add, double* %sum, align 8, !dbg !71
  br label %if.end, !dbg !72

if.end:                                           ; preds = %if.then, %for.body8
  br label %for.inc, !dbg !73

for.inc:                                          ; preds = %if.end
  %18 = load i32, i32* %k, align 4, !dbg !74
  %inc = add nsw i32 %18, 1, !dbg !74
  store i32 %inc, i32* %k, align 4, !dbg !74
  br label %for.cond6, !dbg !75, !llvm.loop !76

for.end:                                          ; preds = %for.cond6
  %19 = load double, double* %alpha.addr, align 8, !dbg !79
  %20 = load double, double* %sum, align 8, !dbg !80
  %mul18 = fmul double %19, %20, !dbg !81
  %21 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !82
  %22 = load i32, i32* %i, align 4, !dbg !83
  %idxprom19 = sext i32 %22 to i64, !dbg !82
  %arrayidx20 = getelementptr inbounds [80 x double], [80 x double]* %21, i64 %idxprom19, !dbg !82
  %23 = load i32, i32* %j, align 4, !dbg !84
  %idxprom21 = sext i32 %23 to i64, !dbg !82
  %arrayidx22 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx20, i64 0, i64 %idxprom21, !dbg !82
  store double %mul18, double* %arrayidx22, align 8, !dbg !85
  br label %for.inc23, !dbg !86

for.inc23:                                        ; preds = %for.end
  %24 = load i32, i32* %j, align 4, !dbg !87
  %inc24 = add nsw i32 %24, 1, !dbg !87
  store i32 %inc24, i32* %j, align 4, !dbg !87
  br label %for.cond1, !dbg !88, !llvm.loop !89

for.end25:                                        ; preds = %for.cond1
  br label %for.inc26, !dbg !91

for.inc26:                                        ; preds = %for.end25
  %25 = load i32, i32* %i, align 4, !dbg !92
  %inc27 = add nsw i32 %25, 1, !dbg !92
  store i32 %inc27, i32* %i, align 4, !dbg !92
  br label %for.cond, !dbg !93, !llvm.loop !94

for.end28:                                        ; preds = %for.cond
  ret void, !dbg !96
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "trmm-opt.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/trmm-opt")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_trmm", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !11, !15}
!10 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3840, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 60)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 5120, elements: !17)
!17 = !{!18}
!18 = !DISubrange(count: 80)
!19 = !DILocalVariable(name: "alpha", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!20 = !DILocation(line: 3, column: 25, scope: !7)
!21 = !DILocalVariable(name: "A", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!22 = !DILocation(line: 3, column: 38, scope: !7)
!23 = !DILocalVariable(name: "B", arg: 3, scope: !7, file: !1, line: 3, type: !15)
!24 = !DILocation(line: 3, column: 55, scope: !7)
!25 = !DILocalVariable(name: "i", scope: !26, file: !1, line: 19, type: !27)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 19, column: 3)
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DILocation(line: 19, column: 12, scope: !26)
!29 = !DILocation(line: 19, column: 8, scope: !26)
!30 = !DILocation(line: 19, column: 19, scope: !31)
!31 = distinct !DILexicalBlock(scope: !26, file: !1, line: 19, column: 3)
!32 = !DILocation(line: 19, column: 21, scope: !31)
!33 = !DILocation(line: 19, column: 3, scope: !26)
!34 = !DILocalVariable(name: "j", scope: !35, file: !1, line: 26, type: !27)
!35 = distinct !DILexicalBlock(scope: !36, file: !1, line: 26, column: 5)
!36 = distinct !DILexicalBlock(scope: !31, file: !1, line: 19, column: 32)
!37 = !DILocation(line: 26, column: 14, scope: !35)
!38 = !DILocation(line: 26, column: 10, scope: !35)
!39 = !DILocation(line: 26, column: 21, scope: !40)
!40 = distinct !DILexicalBlock(scope: !35, file: !1, line: 26, column: 5)
!41 = !DILocation(line: 26, column: 23, scope: !40)
!42 = !DILocation(line: 26, column: 5, scope: !35)
!43 = !DILocalVariable(name: "sum", scope: !44, file: !1, line: 27, type: !10)
!44 = distinct !DILexicalBlock(scope: !40, file: !1, line: 26, column: 34)
!45 = !DILocation(line: 27, column: 14, scope: !44)
!46 = !DILocation(line: 27, column: 20, scope: !44)
!47 = !DILocation(line: 27, column: 22, scope: !44)
!48 = !DILocation(line: 27, column: 25, scope: !44)
!49 = !DILocalVariable(name: "k", scope: !50, file: !1, line: 29, type: !27)
!50 = distinct !DILexicalBlock(scope: !44, file: !1, line: 29, column: 7)
!51 = !DILocation(line: 29, column: 16, scope: !50)
!52 = !DILocation(line: 29, column: 12, scope: !50)
!53 = !DILocation(line: 29, column: 23, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !1, line: 29, column: 7)
!55 = !DILocation(line: 29, column: 25, scope: !54)
!56 = !DILocation(line: 29, column: 7, scope: !50)
!57 = !DILocation(line: 30, column: 13, scope: !58)
!58 = distinct !DILexicalBlock(scope: !59, file: !1, line: 30, column: 13)
!59 = distinct !DILexicalBlock(scope: !54, file: !1, line: 29, column: 36)
!60 = !DILocation(line: 30, column: 17, scope: !58)
!61 = !DILocation(line: 30, column: 15, scope: !58)
!62 = !DILocation(line: 30, column: 13, scope: !59)
!63 = !DILocation(line: 31, column: 18, scope: !64)
!64 = distinct !DILexicalBlock(scope: !58, file: !1, line: 30, column: 20)
!65 = !DILocation(line: 31, column: 20, scope: !64)
!66 = !DILocation(line: 31, column: 23, scope: !64)
!67 = !DILocation(line: 31, column: 28, scope: !64)
!68 = !DILocation(line: 31, column: 30, scope: !64)
!69 = !DILocation(line: 31, column: 33, scope: !64)
!70 = !DILocation(line: 31, column: 26, scope: !64)
!71 = !DILocation(line: 31, column: 15, scope: !64)
!72 = !DILocation(line: 32, column: 9, scope: !64)
!73 = !DILocation(line: 33, column: 7, scope: !59)
!74 = !DILocation(line: 29, column: 32, scope: !54)
!75 = !DILocation(line: 29, column: 7, scope: !54)
!76 = distinct !{!76, !56, !77, !78}
!77 = !DILocation(line: 33, column: 7, scope: !50)
!78 = !{!"llvm.loop.mustprogress"}
!79 = !DILocation(line: 34, column: 17, scope: !44)
!80 = !DILocation(line: 34, column: 25, scope: !44)
!81 = !DILocation(line: 34, column: 23, scope: !44)
!82 = !DILocation(line: 34, column: 7, scope: !44)
!83 = !DILocation(line: 34, column: 9, scope: !44)
!84 = !DILocation(line: 34, column: 12, scope: !44)
!85 = !DILocation(line: 34, column: 15, scope: !44)
!86 = !DILocation(line: 35, column: 5, scope: !44)
!87 = !DILocation(line: 26, column: 30, scope: !40)
!88 = !DILocation(line: 26, column: 5, scope: !40)
!89 = distinct !{!89, !42, !90, !78}
!90 = !DILocation(line: 35, column: 5, scope: !35)
!91 = !DILocation(line: 36, column: 3, scope: !36)
!92 = !DILocation(line: 19, column: 28, scope: !31)
!93 = !DILocation(line: 19, column: 3, scope: !31)
!94 = distinct !{!94, !33, !95, !78}
!95 = !DILocation(line: 36, column: 3, scope: !26)
!96 = !DILocation(line: 37, column: 1, scope: !7)
