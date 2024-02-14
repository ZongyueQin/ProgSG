; ModuleID = 'symm.c'
source_filename = "symm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_symm(double %alpha, double %beta, [80 x double]* %C, [60 x double]* %A, [80 x double]* %B) #0 !dbg !9 {
entry:
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %C.addr = alloca [80 x double]*, align 8
  %A.addr = alloca [60 x double]*, align 8
  %B.addr = alloca [80 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %temp2 = alloca double, align 8
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store double %beta, double* %beta.addr, align 8
  call void @llvm.dbg.declare(metadata double* %beta.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store [80 x double]* %C, [80 x double]** %C.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %C.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store [60 x double]* %A, [60 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [60 x double]** %A.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store [80 x double]* %B, [80 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %B.addr, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %i, metadata !30, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %j, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %k, metadata !35, metadata !DIExpression()), !dbg !36
  store i32 0, i32* %i, align 4, !dbg !37
  br label %for.cond, !dbg !39

for.cond:                                         ; preds = %for.inc54, %entry
  %0 = load i32, i32* %i, align 4, !dbg !40
  %cmp = icmp slt i32 %0, 60, !dbg !42
  br i1 %cmp, label %for.body, label %for.end56, !dbg !43

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !44
  br label %for.cond1, !dbg !47

for.cond1:                                        ; preds = %for.inc51, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !48
  %cmp2 = icmp slt i32 %1, 80, !dbg !50
  br i1 %cmp2, label %for.body3, label %for.end53, !dbg !51

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata double* %temp2, metadata !52, metadata !DIExpression()), !dbg !54
  store double 0.000000e+00, double* %temp2, align 8, !dbg !54
  store i32 0, i32* %k, align 4, !dbg !55
  br label %for.cond4, !dbg !57

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !58
  %cmp5 = icmp slt i32 %2, 60, !dbg !60
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !61

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %k, align 4, !dbg !62
  %4 = load i32, i32* %i, align 4, !dbg !65
  %cmp7 = icmp slt i32 %3, %4, !dbg !66
  br i1 %cmp7, label %if.then, label %if.end, !dbg !67

if.then:                                          ; preds = %for.body6
  %5 = load double, double* %alpha.addr, align 8, !dbg !68
  %6 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !70
  %7 = load i32, i32* %i, align 4, !dbg !71
  %idxprom = sext i32 %7 to i64, !dbg !70
  %arrayidx = getelementptr inbounds [80 x double], [80 x double]* %6, i64 %idxprom, !dbg !70
  %8 = load i32, i32* %j, align 4, !dbg !72
  %idxprom8 = sext i32 %8 to i64, !dbg !70
  %arrayidx9 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx, i64 0, i64 %idxprom8, !dbg !70
  %9 = load double, double* %arrayidx9, align 8, !dbg !70
  %mul = fmul double %5, %9, !dbg !73
  %10 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !74
  %11 = load i32, i32* %i, align 4, !dbg !75
  %idxprom10 = sext i32 %11 to i64, !dbg !74
  %arrayidx11 = getelementptr inbounds [60 x double], [60 x double]* %10, i64 %idxprom10, !dbg !74
  %12 = load i32, i32* %k, align 4, !dbg !76
  %idxprom12 = sext i32 %12 to i64, !dbg !74
  %arrayidx13 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx11, i64 0, i64 %idxprom12, !dbg !74
  %13 = load double, double* %arrayidx13, align 8, !dbg !74
  %mul14 = fmul double %mul, %13, !dbg !77
  %14 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !78
  %15 = load i32, i32* %k, align 4, !dbg !79
  %idxprom15 = sext i32 %15 to i64, !dbg !78
  %arrayidx16 = getelementptr inbounds [80 x double], [80 x double]* %14, i64 %idxprom15, !dbg !78
  %16 = load i32, i32* %j, align 4, !dbg !80
  %idxprom17 = sext i32 %16 to i64, !dbg !78
  %arrayidx18 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx16, i64 0, i64 %idxprom17, !dbg !78
  %17 = load double, double* %arrayidx18, align 8, !dbg !81
  %add = fadd double %17, %mul14, !dbg !81
  store double %add, double* %arrayidx18, align 8, !dbg !81
  %18 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !82
  %19 = load i32, i32* %k, align 4, !dbg !83
  %idxprom19 = sext i32 %19 to i64, !dbg !82
  %arrayidx20 = getelementptr inbounds [80 x double], [80 x double]* %18, i64 %idxprom19, !dbg !82
  %20 = load i32, i32* %j, align 4, !dbg !84
  %idxprom21 = sext i32 %20 to i64, !dbg !82
  %arrayidx22 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx20, i64 0, i64 %idxprom21, !dbg !82
  %21 = load double, double* %arrayidx22, align 8, !dbg !82
  %22 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !85
  %23 = load i32, i32* %i, align 4, !dbg !86
  %idxprom23 = sext i32 %23 to i64, !dbg !85
  %arrayidx24 = getelementptr inbounds [60 x double], [60 x double]* %22, i64 %idxprom23, !dbg !85
  %24 = load i32, i32* %k, align 4, !dbg !87
  %idxprom25 = sext i32 %24 to i64, !dbg !85
  %arrayidx26 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !85
  %25 = load double, double* %arrayidx26, align 8, !dbg !85
  %mul27 = fmul double %21, %25, !dbg !88
  %26 = load double, double* %temp2, align 8, !dbg !89
  %add28 = fadd double %26, %mul27, !dbg !89
  store double %add28, double* %temp2, align 8, !dbg !89
  br label %if.end, !dbg !90

if.end:                                           ; preds = %if.then, %for.body6
  br label %for.inc, !dbg !91

for.inc:                                          ; preds = %if.end
  %27 = load i32, i32* %k, align 4, !dbg !92
  %inc = add nsw i32 %27, 1, !dbg !92
  store i32 %inc, i32* %k, align 4, !dbg !92
  br label %for.cond4, !dbg !93, !llvm.loop !94

for.end:                                          ; preds = %for.cond4
  %28 = load double, double* %beta.addr, align 8, !dbg !97
  %29 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !98
  %30 = load i32, i32* %i, align 4, !dbg !99
  %idxprom29 = sext i32 %30 to i64, !dbg !98
  %arrayidx30 = getelementptr inbounds [80 x double], [80 x double]* %29, i64 %idxprom29, !dbg !98
  %31 = load i32, i32* %j, align 4, !dbg !100
  %idxprom31 = sext i32 %31 to i64, !dbg !98
  %arrayidx32 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx30, i64 0, i64 %idxprom31, !dbg !98
  %32 = load double, double* %arrayidx32, align 8, !dbg !98
  %mul33 = fmul double %28, %32, !dbg !101
  %33 = load double, double* %alpha.addr, align 8, !dbg !102
  %34 = load [80 x double]*, [80 x double]** %B.addr, align 8, !dbg !103
  %35 = load i32, i32* %i, align 4, !dbg !104
  %idxprom34 = sext i32 %35 to i64, !dbg !103
  %arrayidx35 = getelementptr inbounds [80 x double], [80 x double]* %34, i64 %idxprom34, !dbg !103
  %36 = load i32, i32* %j, align 4, !dbg !105
  %idxprom36 = sext i32 %36 to i64, !dbg !103
  %arrayidx37 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx35, i64 0, i64 %idxprom36, !dbg !103
  %37 = load double, double* %arrayidx37, align 8, !dbg !103
  %mul38 = fmul double %33, %37, !dbg !106
  %38 = load [60 x double]*, [60 x double]** %A.addr, align 8, !dbg !107
  %39 = load i32, i32* %i, align 4, !dbg !108
  %idxprom39 = sext i32 %39 to i64, !dbg !107
  %arrayidx40 = getelementptr inbounds [60 x double], [60 x double]* %38, i64 %idxprom39, !dbg !107
  %40 = load i32, i32* %i, align 4, !dbg !109
  %idxprom41 = sext i32 %40 to i64, !dbg !107
  %arrayidx42 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx40, i64 0, i64 %idxprom41, !dbg !107
  %41 = load double, double* %arrayidx42, align 8, !dbg !107
  %mul43 = fmul double %mul38, %41, !dbg !110
  %add44 = fadd double %mul33, %mul43, !dbg !111
  %42 = load double, double* %alpha.addr, align 8, !dbg !112
  %43 = load double, double* %temp2, align 8, !dbg !113
  %mul45 = fmul double %42, %43, !dbg !114
  %add46 = fadd double %add44, %mul45, !dbg !115
  %44 = load [80 x double]*, [80 x double]** %C.addr, align 8, !dbg !116
  %45 = load i32, i32* %i, align 4, !dbg !117
  %idxprom47 = sext i32 %45 to i64, !dbg !116
  %arrayidx48 = getelementptr inbounds [80 x double], [80 x double]* %44, i64 %idxprom47, !dbg !116
  %46 = load i32, i32* %j, align 4, !dbg !118
  %idxprom49 = sext i32 %46 to i64, !dbg !116
  %arrayidx50 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx48, i64 0, i64 %idxprom49, !dbg !116
  store double %add46, double* %arrayidx50, align 8, !dbg !119
  br label %for.inc51, !dbg !120

for.inc51:                                        ; preds = %for.end
  %47 = load i32, i32* %j, align 4, !dbg !121
  %inc52 = add nsw i32 %47, 1, !dbg !121
  store i32 %inc52, i32* %j, align 4, !dbg !121
  br label %for.cond1, !dbg !122, !llvm.loop !123

for.end53:                                        ; preds = %for.cond1
  br label %for.inc54, !dbg !125

for.inc54:                                        ; preds = %for.end53
  %48 = load i32, i32* %i, align 4, !dbg !126
  %inc55 = add nsw i32 %48, 1, !dbg !126
  store i32 %inc55, i32* %i, align 4, !dbg !126
  br label %for.cond, !dbg !127, !llvm.loop !128

for.end56:                                        ; preds = %for.cond
  ret void, !dbg !130
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "symm.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/symm")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "kernel_symm", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !4, !4, !12, !16, !12}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 5120, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 80)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 3840, elements: !18)
!18 = !{!19}
!19 = !DISubrange(count: 60)
!20 = !DILocalVariable(name: "alpha", arg: 1, scope: !9, file: !1, line: 3, type: !4)
!21 = !DILocation(line: 3, column: 25, scope: !9)
!22 = !DILocalVariable(name: "beta", arg: 2, scope: !9, file: !1, line: 3, type: !4)
!23 = !DILocation(line: 3, column: 38, scope: !9)
!24 = !DILocalVariable(name: "C", arg: 3, scope: !9, file: !1, line: 3, type: !12)
!25 = !DILocation(line: 3, column: 50, scope: !9)
!26 = !DILocalVariable(name: "A", arg: 4, scope: !9, file: !1, line: 3, type: !16)
!27 = !DILocation(line: 3, column: 67, scope: !9)
!28 = !DILocalVariable(name: "B", arg: 5, scope: !9, file: !1, line: 3, type: !12)
!29 = !DILocation(line: 3, column: 84, scope: !9)
!30 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 5, type: !31)
!31 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!32 = !DILocation(line: 5, column: 7, scope: !9)
!33 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 6, type: !31)
!34 = !DILocation(line: 6, column: 7, scope: !9)
!35 = !DILocalVariable(name: "k", scope: !9, file: !1, line: 7, type: !31)
!36 = !DILocation(line: 7, column: 7, scope: !9)
!37 = !DILocation(line: 22, column: 10, scope: !38)
!38 = distinct !DILexicalBlock(scope: !9, file: !1, line: 22, column: 3)
!39 = !DILocation(line: 22, column: 8, scope: !38)
!40 = !DILocation(line: 22, column: 15, scope: !41)
!41 = distinct !DILexicalBlock(scope: !38, file: !1, line: 22, column: 3)
!42 = !DILocation(line: 22, column: 17, scope: !41)
!43 = !DILocation(line: 22, column: 3, scope: !38)
!44 = !DILocation(line: 29, column: 12, scope: !45)
!45 = distinct !DILexicalBlock(scope: !46, file: !1, line: 29, column: 5)
!46 = distinct !DILexicalBlock(scope: !41, file: !1, line: 22, column: 28)
!47 = !DILocation(line: 29, column: 10, scope: !45)
!48 = !DILocation(line: 29, column: 17, scope: !49)
!49 = distinct !DILexicalBlock(scope: !45, file: !1, line: 29, column: 5)
!50 = !DILocation(line: 29, column: 19, scope: !49)
!51 = !DILocation(line: 29, column: 5, scope: !45)
!52 = !DILocalVariable(name: "temp2", scope: !53, file: !1, line: 30, type: !4)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 29, column: 30)
!54 = !DILocation(line: 30, column: 14, scope: !53)
!55 = !DILocation(line: 33, column: 14, scope: !56)
!56 = distinct !DILexicalBlock(scope: !53, file: !1, line: 33, column: 7)
!57 = !DILocation(line: 33, column: 12, scope: !56)
!58 = !DILocation(line: 33, column: 19, scope: !59)
!59 = distinct !DILexicalBlock(scope: !56, file: !1, line: 33, column: 7)
!60 = !DILocation(line: 33, column: 21, scope: !59)
!61 = !DILocation(line: 33, column: 7, scope: !56)
!62 = !DILocation(line: 34, column: 13, scope: !63)
!63 = distinct !DILexicalBlock(scope: !64, file: !1, line: 34, column: 13)
!64 = distinct !DILexicalBlock(scope: !59, file: !1, line: 33, column: 32)
!65 = !DILocation(line: 34, column: 17, scope: !63)
!66 = !DILocation(line: 34, column: 15, scope: !63)
!67 = !DILocation(line: 34, column: 13, scope: !64)
!68 = !DILocation(line: 35, column: 22, scope: !69)
!69 = distinct !DILexicalBlock(scope: !63, file: !1, line: 34, column: 20)
!70 = !DILocation(line: 35, column: 30, scope: !69)
!71 = !DILocation(line: 35, column: 32, scope: !69)
!72 = !DILocation(line: 35, column: 35, scope: !69)
!73 = !DILocation(line: 35, column: 28, scope: !69)
!74 = !DILocation(line: 35, column: 40, scope: !69)
!75 = !DILocation(line: 35, column: 42, scope: !69)
!76 = !DILocation(line: 35, column: 45, scope: !69)
!77 = !DILocation(line: 35, column: 38, scope: !69)
!78 = !DILocation(line: 35, column: 11, scope: !69)
!79 = !DILocation(line: 35, column: 13, scope: !69)
!80 = !DILocation(line: 35, column: 16, scope: !69)
!81 = !DILocation(line: 35, column: 19, scope: !69)
!82 = !DILocation(line: 36, column: 20, scope: !69)
!83 = !DILocation(line: 36, column: 22, scope: !69)
!84 = !DILocation(line: 36, column: 25, scope: !69)
!85 = !DILocation(line: 36, column: 30, scope: !69)
!86 = !DILocation(line: 36, column: 32, scope: !69)
!87 = !DILocation(line: 36, column: 35, scope: !69)
!88 = !DILocation(line: 36, column: 28, scope: !69)
!89 = !DILocation(line: 36, column: 17, scope: !69)
!90 = !DILocation(line: 37, column: 9, scope: !69)
!91 = !DILocation(line: 38, column: 7, scope: !64)
!92 = !DILocation(line: 33, column: 28, scope: !59)
!93 = !DILocation(line: 33, column: 7, scope: !59)
!94 = distinct !{!94, !61, !95, !96}
!95 = !DILocation(line: 38, column: 7, scope: !56)
!96 = !{!"llvm.loop.mustprogress"}
!97 = !DILocation(line: 39, column: 17, scope: !53)
!98 = !DILocation(line: 39, column: 24, scope: !53)
!99 = !DILocation(line: 39, column: 26, scope: !53)
!100 = !DILocation(line: 39, column: 29, scope: !53)
!101 = !DILocation(line: 39, column: 22, scope: !53)
!102 = !DILocation(line: 39, column: 34, scope: !53)
!103 = !DILocation(line: 39, column: 42, scope: !53)
!104 = !DILocation(line: 39, column: 44, scope: !53)
!105 = !DILocation(line: 39, column: 47, scope: !53)
!106 = !DILocation(line: 39, column: 40, scope: !53)
!107 = !DILocation(line: 39, column: 52, scope: !53)
!108 = !DILocation(line: 39, column: 54, scope: !53)
!109 = !DILocation(line: 39, column: 57, scope: !53)
!110 = !DILocation(line: 39, column: 50, scope: !53)
!111 = !DILocation(line: 39, column: 32, scope: !53)
!112 = !DILocation(line: 39, column: 62, scope: !53)
!113 = !DILocation(line: 39, column: 70, scope: !53)
!114 = !DILocation(line: 39, column: 68, scope: !53)
!115 = !DILocation(line: 39, column: 60, scope: !53)
!116 = !DILocation(line: 39, column: 7, scope: !53)
!117 = !DILocation(line: 39, column: 9, scope: !53)
!118 = !DILocation(line: 39, column: 12, scope: !53)
!119 = !DILocation(line: 39, column: 15, scope: !53)
!120 = !DILocation(line: 40, column: 5, scope: !53)
!121 = !DILocation(line: 29, column: 26, scope: !49)
!122 = !DILocation(line: 29, column: 5, scope: !49)
!123 = distinct !{!123, !51, !124, !96}
!124 = !DILocation(line: 40, column: 5, scope: !45)
!125 = !DILocation(line: 41, column: 3, scope: !46)
!126 = !DILocation(line: 22, column: 24, scope: !41)
!127 = !DILocation(line: 22, column: 3, scope: !41)
!128 = distinct !{!128, !43, !129, !96}
!129 = !DILocation(line: 41, column: 3, scope: !38)
!130 = !DILocation(line: 42, column: 1, scope: !9)
