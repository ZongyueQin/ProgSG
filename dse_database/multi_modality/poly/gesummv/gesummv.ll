; ModuleID = 'gesummv.c'
source_filename = "gesummv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gesummv(i32 %n, double %alpha, double %beta, [90 x double]* %A, [90 x double]* %B, double* %tmp, double* %x, double* %y) #0 !dbg !7 {
entry:
  %n.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %A.addr = alloca [90 x double]*, align 8
  %B.addr = alloca [90 x double]*, align 8
  %tmp.addr = alloca double*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store double %beta, double* %beta.addr, align 8
  call void @llvm.dbg.declare(metadata double* %beta.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store [90 x double]* %A, [90 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [90 x double]** %A.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store [90 x double]* %B, [90 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [90 x double]** %B.addr, metadata !25, metadata !DIExpression()), !dbg !26
  store double* %tmp, double** %tmp.addr, align 8
  call void @llvm.dbg.declare(metadata double** %tmp.addr, metadata !27, metadata !DIExpression()), !dbg !28
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !29, metadata !DIExpression()), !dbg !30
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %i, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %j, metadata !35, metadata !DIExpression()), !dbg !36
  store i32 0, i32* %i, align 4, !dbg !37
  br label %for.cond, !dbg !39

for.cond:                                         ; preds = %for.inc37, %entry
  %0 = load i32, i32* %i, align 4, !dbg !40
  %cmp = icmp slt i32 %0, 90, !dbg !42
  br i1 %cmp, label %for.body, label %for.end39, !dbg !43

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %tmp.addr, align 8, !dbg !44
  %2 = load i32, i32* %i, align 4, !dbg !46
  %idxprom = sext i32 %2 to i64, !dbg !44
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !44
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !47
  %3 = load double*, double** %y.addr, align 8, !dbg !48
  %4 = load i32, i32* %i, align 4, !dbg !49
  %idxprom1 = sext i32 %4 to i64, !dbg !48
  %arrayidx2 = getelementptr inbounds double, double* %3, i64 %idxprom1, !dbg !48
  store double 0.000000e+00, double* %arrayidx2, align 8, !dbg !50
  store i32 0, i32* %j, align 4, !dbg !51
  br label %for.cond3, !dbg !53

for.cond3:                                        ; preds = %for.inc, %for.body
  %5 = load i32, i32* %j, align 4, !dbg !54
  %cmp4 = icmp slt i32 %5, 90, !dbg !56
  br i1 %cmp4, label %for.body5, label %for.end, !dbg !57

for.body5:                                        ; preds = %for.cond3
  %6 = load [90 x double]*, [90 x double]** %A.addr, align 8, !dbg !58
  %7 = load i32, i32* %i, align 4, !dbg !60
  %idxprom6 = sext i32 %7 to i64, !dbg !58
  %arrayidx7 = getelementptr inbounds [90 x double], [90 x double]* %6, i64 %idxprom6, !dbg !58
  %8 = load i32, i32* %j, align 4, !dbg !61
  %idxprom8 = sext i32 %8 to i64, !dbg !58
  %arrayidx9 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !58
  %9 = load double, double* %arrayidx9, align 8, !dbg !58
  %10 = load double*, double** %x.addr, align 8, !dbg !62
  %11 = load i32, i32* %j, align 4, !dbg !63
  %idxprom10 = sext i32 %11 to i64, !dbg !62
  %arrayidx11 = getelementptr inbounds double, double* %10, i64 %idxprom10, !dbg !62
  %12 = load double, double* %arrayidx11, align 8, !dbg !62
  %mul = fmul double %9, %12, !dbg !64
  %13 = load double*, double** %tmp.addr, align 8, !dbg !65
  %14 = load i32, i32* %i, align 4, !dbg !66
  %idxprom12 = sext i32 %14 to i64, !dbg !65
  %arrayidx13 = getelementptr inbounds double, double* %13, i64 %idxprom12, !dbg !65
  %15 = load double, double* %arrayidx13, align 8, !dbg !65
  %add = fadd double %mul, %15, !dbg !67
  %16 = load double*, double** %tmp.addr, align 8, !dbg !68
  %17 = load i32, i32* %i, align 4, !dbg !69
  %idxprom14 = sext i32 %17 to i64, !dbg !68
  %arrayidx15 = getelementptr inbounds double, double* %16, i64 %idxprom14, !dbg !68
  store double %add, double* %arrayidx15, align 8, !dbg !70
  %18 = load [90 x double]*, [90 x double]** %B.addr, align 8, !dbg !71
  %19 = load i32, i32* %i, align 4, !dbg !72
  %idxprom16 = sext i32 %19 to i64, !dbg !71
  %arrayidx17 = getelementptr inbounds [90 x double], [90 x double]* %18, i64 %idxprom16, !dbg !71
  %20 = load i32, i32* %j, align 4, !dbg !73
  %idxprom18 = sext i32 %20 to i64, !dbg !71
  %arrayidx19 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx17, i64 0, i64 %idxprom18, !dbg !71
  %21 = load double, double* %arrayidx19, align 8, !dbg !71
  %22 = load double*, double** %x.addr, align 8, !dbg !74
  %23 = load i32, i32* %j, align 4, !dbg !75
  %idxprom20 = sext i32 %23 to i64, !dbg !74
  %arrayidx21 = getelementptr inbounds double, double* %22, i64 %idxprom20, !dbg !74
  %24 = load double, double* %arrayidx21, align 8, !dbg !74
  %mul22 = fmul double %21, %24, !dbg !76
  %25 = load double*, double** %y.addr, align 8, !dbg !77
  %26 = load i32, i32* %i, align 4, !dbg !78
  %idxprom23 = sext i32 %26 to i64, !dbg !77
  %arrayidx24 = getelementptr inbounds double, double* %25, i64 %idxprom23, !dbg !77
  %27 = load double, double* %arrayidx24, align 8, !dbg !77
  %add25 = fadd double %mul22, %27, !dbg !79
  %28 = load double*, double** %y.addr, align 8, !dbg !80
  %29 = load i32, i32* %i, align 4, !dbg !81
  %idxprom26 = sext i32 %29 to i64, !dbg !80
  %arrayidx27 = getelementptr inbounds double, double* %28, i64 %idxprom26, !dbg !80
  store double %add25, double* %arrayidx27, align 8, !dbg !82
  br label %for.inc, !dbg !83

for.inc:                                          ; preds = %for.body5
  %30 = load i32, i32* %j, align 4, !dbg !84
  %inc = add nsw i32 %30, 1, !dbg !84
  store i32 %inc, i32* %j, align 4, !dbg !84
  br label %for.cond3, !dbg !85, !llvm.loop !86

for.end:                                          ; preds = %for.cond3
  %31 = load double, double* %alpha.addr, align 8, !dbg !89
  %32 = load double*, double** %tmp.addr, align 8, !dbg !90
  %33 = load i32, i32* %i, align 4, !dbg !91
  %idxprom28 = sext i32 %33 to i64, !dbg !90
  %arrayidx29 = getelementptr inbounds double, double* %32, i64 %idxprom28, !dbg !90
  %34 = load double, double* %arrayidx29, align 8, !dbg !90
  %mul30 = fmul double %31, %34, !dbg !92
  %35 = load double, double* %beta.addr, align 8, !dbg !93
  %36 = load double*, double** %y.addr, align 8, !dbg !94
  %37 = load i32, i32* %i, align 4, !dbg !95
  %idxprom31 = sext i32 %37 to i64, !dbg !94
  %arrayidx32 = getelementptr inbounds double, double* %36, i64 %idxprom31, !dbg !94
  %38 = load double, double* %arrayidx32, align 8, !dbg !94
  %mul33 = fmul double %35, %38, !dbg !96
  %add34 = fadd double %mul30, %mul33, !dbg !97
  %39 = load double*, double** %y.addr, align 8, !dbg !98
  %40 = load i32, i32* %i, align 4, !dbg !99
  %idxprom35 = sext i32 %40 to i64, !dbg !98
  %arrayidx36 = getelementptr inbounds double, double* %39, i64 %idxprom35, !dbg !98
  store double %add34, double* %arrayidx36, align 8, !dbg !100
  br label %for.inc37, !dbg !101

for.inc37:                                        ; preds = %for.end
  %41 = load i32, i32* %i, align 4, !dbg !102
  %inc38 = add nsw i32 %41, 1, !dbg !102
  store i32 %inc38, i32* %i, align 4, !dbg !102
  br label %for.cond, !dbg !103, !llvm.loop !104

for.end39:                                        ; preds = %for.cond
  ret void, !dbg !106
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "gesummv.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/gesummv")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_gesummv", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !11, !11, !12, !12, !16, !16, !16}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 5760, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 90)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!17 = !DILocalVariable(name: "n", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!18 = !DILocation(line: 3, column: 25, scope: !7)
!19 = !DILocalVariable(name: "alpha", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!20 = !DILocation(line: 3, column: 34, scope: !7)
!21 = !DILocalVariable(name: "beta", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!22 = !DILocation(line: 3, column: 47, scope: !7)
!23 = !DILocalVariable(name: "A", arg: 4, scope: !7, file: !1, line: 3, type: !12)
!24 = !DILocation(line: 3, column: 59, scope: !7)
!25 = !DILocalVariable(name: "B", arg: 5, scope: !7, file: !1, line: 3, type: !12)
!26 = !DILocation(line: 3, column: 76, scope: !7)
!27 = !DILocalVariable(name: "tmp", arg: 6, scope: !7, file: !1, line: 3, type: !16)
!28 = !DILocation(line: 3, column: 93, scope: !7)
!29 = !DILocalVariable(name: "x", arg: 7, scope: !7, file: !1, line: 3, type: !16)
!30 = !DILocation(line: 3, column: 108, scope: !7)
!31 = !DILocalVariable(name: "y", arg: 8, scope: !7, file: !1, line: 3, type: !16)
!32 = !DILocation(line: 3, column: 121, scope: !7)
!33 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !10)
!34 = !DILocation(line: 5, column: 7, scope: !7)
!35 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !10)
!36 = !DILocation(line: 6, column: 7, scope: !7)
!37 = !DILocation(line: 15, column: 10, scope: !38)
!38 = distinct !DILexicalBlock(scope: !7, file: !1, line: 15, column: 3)
!39 = !DILocation(line: 15, column: 8, scope: !38)
!40 = !DILocation(line: 15, column: 15, scope: !41)
!41 = distinct !DILexicalBlock(scope: !38, file: !1, line: 15, column: 3)
!42 = !DILocation(line: 15, column: 17, scope: !41)
!43 = !DILocation(line: 15, column: 3, scope: !38)
!44 = !DILocation(line: 16, column: 5, scope: !45)
!45 = distinct !DILexicalBlock(scope: !41, file: !1, line: 15, column: 28)
!46 = !DILocation(line: 16, column: 9, scope: !45)
!47 = !DILocation(line: 16, column: 12, scope: !45)
!48 = !DILocation(line: 17, column: 5, scope: !45)
!49 = !DILocation(line: 17, column: 7, scope: !45)
!50 = !DILocation(line: 17, column: 10, scope: !45)
!51 = !DILocation(line: 20, column: 12, scope: !52)
!52 = distinct !DILexicalBlock(scope: !45, file: !1, line: 20, column: 5)
!53 = !DILocation(line: 20, column: 10, scope: !52)
!54 = !DILocation(line: 20, column: 17, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !1, line: 20, column: 5)
!56 = !DILocation(line: 20, column: 19, scope: !55)
!57 = !DILocation(line: 20, column: 5, scope: !52)
!58 = !DILocation(line: 21, column: 16, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 20, column: 30)
!60 = !DILocation(line: 21, column: 18, scope: !59)
!61 = !DILocation(line: 21, column: 21, scope: !59)
!62 = !DILocation(line: 21, column: 26, scope: !59)
!63 = !DILocation(line: 21, column: 28, scope: !59)
!64 = !DILocation(line: 21, column: 24, scope: !59)
!65 = !DILocation(line: 21, column: 33, scope: !59)
!66 = !DILocation(line: 21, column: 37, scope: !59)
!67 = !DILocation(line: 21, column: 31, scope: !59)
!68 = !DILocation(line: 21, column: 7, scope: !59)
!69 = !DILocation(line: 21, column: 11, scope: !59)
!70 = !DILocation(line: 21, column: 14, scope: !59)
!71 = !DILocation(line: 22, column: 14, scope: !59)
!72 = !DILocation(line: 22, column: 16, scope: !59)
!73 = !DILocation(line: 22, column: 19, scope: !59)
!74 = !DILocation(line: 22, column: 24, scope: !59)
!75 = !DILocation(line: 22, column: 26, scope: !59)
!76 = !DILocation(line: 22, column: 22, scope: !59)
!77 = !DILocation(line: 22, column: 31, scope: !59)
!78 = !DILocation(line: 22, column: 33, scope: !59)
!79 = !DILocation(line: 22, column: 29, scope: !59)
!80 = !DILocation(line: 22, column: 7, scope: !59)
!81 = !DILocation(line: 22, column: 9, scope: !59)
!82 = !DILocation(line: 22, column: 12, scope: !59)
!83 = !DILocation(line: 23, column: 5, scope: !59)
!84 = !DILocation(line: 20, column: 26, scope: !55)
!85 = !DILocation(line: 20, column: 5, scope: !55)
!86 = distinct !{!86, !57, !87, !88}
!87 = !DILocation(line: 23, column: 5, scope: !52)
!88 = !{!"llvm.loop.mustprogress"}
!89 = !DILocation(line: 24, column: 12, scope: !45)
!90 = !DILocation(line: 24, column: 20, scope: !45)
!91 = !DILocation(line: 24, column: 24, scope: !45)
!92 = !DILocation(line: 24, column: 18, scope: !45)
!93 = !DILocation(line: 24, column: 29, scope: !45)
!94 = !DILocation(line: 24, column: 36, scope: !45)
!95 = !DILocation(line: 24, column: 38, scope: !45)
!96 = !DILocation(line: 24, column: 34, scope: !45)
!97 = !DILocation(line: 24, column: 27, scope: !45)
!98 = !DILocation(line: 24, column: 5, scope: !45)
!99 = !DILocation(line: 24, column: 7, scope: !45)
!100 = !DILocation(line: 24, column: 10, scope: !45)
!101 = !DILocation(line: 25, column: 3, scope: !45)
!102 = !DILocation(line: 15, column: 24, scope: !41)
!103 = !DILocation(line: 15, column: 3, scope: !41)
!104 = distinct !{!104, !43, !105, !88}
!105 = !DILocation(line: 25, column: 3, scope: !38)
!106 = !DILocation(line: 28, column: 1, scope: !7)
