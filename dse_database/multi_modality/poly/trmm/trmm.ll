; ModuleID = 'trmm.c'
source_filename = "trmm.c"
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

for.cond:                                         ; preds = %for.inc30, %entry
  %0 = load i32, i32* %i, align 4, !dbg !30
  %cmp = icmp slt i32 %0, 60, !dbg !32
  br i1 %cmp, label %for.body, label %for.end32, !dbg !33

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !34, metadata !DIExpression()), !dbg !37
  store i32 0, i32* %j, align 4, !dbg !37
  br label %for.cond1, !dbg !38

for.cond1:                                        ; preds = %for.inc27, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !39
  %cmp2 = icmp slt i32 %1, 80, !dbg !41
  br i1 %cmp2, label %for.body3, label %for.end29, !dbg !42

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %k, metadata !43, metadata !DIExpression()), !dbg !46
  store i32 0, i32* %k, align 4, !dbg !46
  br label %for.cond4, !dbg !47

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !48
  %cmp5 = icmp slt i32 %2, 60, !dbg !50
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !51

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %k, align 4, !dbg !52
  %4 = load i32, i32* %i, align 4, !dbg !55
  %cmp7 = icmp sgt i32 %3, %4, !dbg !56
  br i1 %cmp7, label %if.then, label %if.end, !dbg !57

if.then:                                          ; preds = %for.body6
  %5 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !58
  %6 = load i32, i32* %k, align 4, !dbg !60
  %idxprom = sext i32 %6 to i64, !dbg !58
  %arrayidx = getelementptr inbounds [60 x double], [60 x double]* %5, i64 %idxprom, !dbg !58
  %7 = load i32, i32* %i, align 4, !dbg !61
  %idxprom8 = sext i32 %7 to i64, !dbg !58
  %arrayidx9 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx, i64 0, i64 %idxprom8, !dbg !58
  %8 = load double, double* %arrayidx9, align 8, !dbg !58
  %9 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !62
  %10 = load i32, i32* %k, align 4, !dbg !63
  %idxprom10 = sext i32 %10 to i64, !dbg !62
  %arrayidx11 = getelementptr inbounds [80 x double], [80 x double]* %9, i64 %idxprom10, !dbg !62
  %11 = load i32, i32* %j, align 4, !dbg !64
  %idxprom12 = sext i32 %11 to i64, !dbg !62
  %arrayidx13 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx11, i64 0, i64 %idxprom12, !dbg !62
  %12 = load double, double* %arrayidx13, align 8, !dbg !62
  %mul = fmul double %8, %12, !dbg !65
  %13 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !66
  %14 = load i32, i32* %i, align 4, !dbg !67
  %idxprom14 = sext i32 %14 to i64, !dbg !66
  %arrayidx15 = getelementptr inbounds [80 x double], [80 x double]* %13, i64 %idxprom14, !dbg !66
  %15 = load i32, i32* %j, align 4, !dbg !68
  %idxprom16 = sext i32 %15 to i64, !dbg !66
  %arrayidx17 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx15, i64 0, i64 %idxprom16, !dbg !66
  %16 = load double, double* %arrayidx17, align 8, !dbg !69
  %add = fadd double %16, %mul, !dbg !69
  store double %add, double* %arrayidx17, align 8, !dbg !69
  br label %if.end, !dbg !70

if.end:                                           ; preds = %if.then, %for.body6
  br label %for.inc, !dbg !71

for.inc:                                          ; preds = %if.end
  %17 = load i32, i32* %k, align 4, !dbg !72
  %inc = add nsw i32 %17, 1, !dbg !72
  store i32 %inc, i32* %k, align 4, !dbg !72
  br label %for.cond4, !dbg !73, !llvm.loop !74

for.end:                                          ; preds = %for.cond4
  %18 = load double, double* %alpha.addr, align 8, !dbg !77
  %19 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !78
  %20 = load i32, i32* %i, align 4, !dbg !79
  %idxprom18 = sext i32 %20 to i64, !dbg !78
  %arrayidx19 = getelementptr inbounds [80 x double], [80 x double]* %19, i64 %idxprom18, !dbg !78
  %21 = load i32, i32* %j, align 4, !dbg !80
  %idxprom20 = sext i32 %21 to i64, !dbg !78
  %arrayidx21 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx19, i64 0, i64 %idxprom20, !dbg !78
  %22 = load double, double* %arrayidx21, align 8, !dbg !78
  %mul22 = fmul double %18, %22, !dbg !81
  %23 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !82
  %24 = load i32, i32* %i, align 4, !dbg !83
  %idxprom23 = sext i32 %24 to i64, !dbg !82
  %arrayidx24 = getelementptr inbounds [80 x double], [80 x double]* %23, i64 %idxprom23, !dbg !82
  %25 = load i32, i32* %j, align 4, !dbg !84
  %idxprom25 = sext i32 %25 to i64, !dbg !82
  %arrayidx26 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !82
  store double %mul22, double* %arrayidx26, align 8, !dbg !85
  br label %for.inc27, !dbg !86

for.inc27:                                        ; preds = %for.end
  %26 = load i32, i32* %j, align 4, !dbg !87
  %inc28 = add nsw i32 %26, 1, !dbg !87
  store i32 %inc28, i32* %j, align 4, !dbg !87
  br label %for.cond1, !dbg !88, !llvm.loop !89

for.end29:                                        ; preds = %for.cond1
  br label %for.inc30, !dbg !91

for.inc30:                                        ; preds = %for.end29
  %27 = load i32, i32* %i, align 4, !dbg !92
  %inc31 = add nsw i32 %27, 1, !dbg !92
  store i32 %inc31, i32* %i, align 4, !dbg !92
  br label %for.cond, !dbg !93, !llvm.loop !94

for.end32:                                        ; preds = %for.cond
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
!1 = !DIFile(filename: "trmm.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/trmm")
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
!43 = !DILocalVariable(name: "k", scope: !44, file: !1, line: 29, type: !27)
!44 = distinct !DILexicalBlock(scope: !45, file: !1, line: 29, column: 7)
!45 = distinct !DILexicalBlock(scope: !40, file: !1, line: 26, column: 34)
!46 = !DILocation(line: 29, column: 16, scope: !44)
!47 = !DILocation(line: 29, column: 12, scope: !44)
!48 = !DILocation(line: 29, column: 23, scope: !49)
!49 = distinct !DILexicalBlock(scope: !44, file: !1, line: 29, column: 7)
!50 = !DILocation(line: 29, column: 25, scope: !49)
!51 = !DILocation(line: 29, column: 7, scope: !44)
!52 = !DILocation(line: 30, column: 13, scope: !53)
!53 = distinct !DILexicalBlock(scope: !54, file: !1, line: 30, column: 13)
!54 = distinct !DILexicalBlock(scope: !49, file: !1, line: 29, column: 36)
!55 = !DILocation(line: 30, column: 17, scope: !53)
!56 = !DILocation(line: 30, column: 15, scope: !53)
!57 = !DILocation(line: 30, column: 13, scope: !54)
!58 = !DILocation(line: 31, column: 22, scope: !59)
!59 = distinct !DILexicalBlock(scope: !53, file: !1, line: 30, column: 20)
!60 = !DILocation(line: 31, column: 24, scope: !59)
!61 = !DILocation(line: 31, column: 27, scope: !59)
!62 = !DILocation(line: 31, column: 32, scope: !59)
!63 = !DILocation(line: 31, column: 34, scope: !59)
!64 = !DILocation(line: 31, column: 37, scope: !59)
!65 = !DILocation(line: 31, column: 30, scope: !59)
!66 = !DILocation(line: 31, column: 11, scope: !59)
!67 = !DILocation(line: 31, column: 13, scope: !59)
!68 = !DILocation(line: 31, column: 16, scope: !59)
!69 = !DILocation(line: 31, column: 19, scope: !59)
!70 = !DILocation(line: 32, column: 9, scope: !59)
!71 = !DILocation(line: 33, column: 7, scope: !54)
!72 = !DILocation(line: 29, column: 32, scope: !49)
!73 = !DILocation(line: 29, column: 7, scope: !49)
!74 = distinct !{!74, !51, !75, !76}
!75 = !DILocation(line: 33, column: 7, scope: !44)
!76 = !{!"llvm.loop.mustprogress"}
!77 = !DILocation(line: 34, column: 17, scope: !45)
!78 = !DILocation(line: 34, column: 25, scope: !45)
!79 = !DILocation(line: 34, column: 27, scope: !45)
!80 = !DILocation(line: 34, column: 30, scope: !45)
!81 = !DILocation(line: 34, column: 23, scope: !45)
!82 = !DILocation(line: 34, column: 7, scope: !45)
!83 = !DILocation(line: 34, column: 9, scope: !45)
!84 = !DILocation(line: 34, column: 12, scope: !45)
!85 = !DILocation(line: 34, column: 15, scope: !45)
!86 = !DILocation(line: 35, column: 5, scope: !45)
!87 = !DILocation(line: 26, column: 30, scope: !40)
!88 = !DILocation(line: 26, column: 5, scope: !40)
!89 = distinct !{!89, !42, !90, !76}
!90 = !DILocation(line: 35, column: 5, scope: !35)
!91 = !DILocation(line: 36, column: 3, scope: !36)
!92 = !DILocation(line: 19, column: 28, scope: !31)
!93 = !DILocation(line: 19, column: 3, scope: !31)
!94 = distinct !{!94, !33, !95, !76}
!95 = !DILocation(line: 36, column: 3, scope: !26)
!96 = !DILocation(line: 37, column: 1, scope: !7)
