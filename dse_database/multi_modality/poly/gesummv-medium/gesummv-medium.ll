; ModuleID = 'gesummv-medium.c'
source_filename = "gesummv-medium.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gesummv(double %alpha, double %beta, [250 x double]* %A, [250 x double]* %B, double* %tmp, double* %x, double* %y) #0 !dbg !7 {
entry:
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %A.addr = alloca [250 x double]*, align 8
  %B.addr = alloca [250 x double]*, align 8
  %tmp.addr = alloca double*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store double %beta, double* %beta.addr, align 8
  call void @llvm.dbg.declare(metadata double* %beta.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store [250 x double]* %A, [250 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [250 x double]** %A.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store [250 x double]* %B, [250 x double]** %B.addr, align 8
  call void @llvm.dbg.declare(metadata [250 x double]** %B.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store double* %tmp, double** %tmp.addr, align 8
  call void @llvm.dbg.declare(metadata double** %tmp.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %i, metadata !30, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %j, metadata !33, metadata !DIExpression()), !dbg !34
  store i32 0, i32* %i, align 4, !dbg !35
  br label %for.cond, !dbg !37

for.cond:                                         ; preds = %for.inc33, %entry
  %0 = load i32, i32* %i, align 4, !dbg !38
  %cmp = icmp slt i32 %0, 250, !dbg !40
  br i1 %cmp, label %for.body, label %for.end35, !dbg !41

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %tmp.addr, align 8, !dbg !42
  %2 = load i32, i32* %i, align 4, !dbg !44
  %idxprom = sext i32 %2 to i64, !dbg !42
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !42
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !45
  %3 = load double*, double** %y.addr, align 8, !dbg !46
  %4 = load i32, i32* %i, align 4, !dbg !47
  %idxprom1 = sext i32 %4 to i64, !dbg !46
  %arrayidx2 = getelementptr inbounds double, double* %3, i64 %idxprom1, !dbg !46
  store double 0.000000e+00, double* %arrayidx2, align 8, !dbg !48
  store i32 0, i32* %j, align 4, !dbg !49
  br label %for.cond3, !dbg !51

for.cond3:                                        ; preds = %for.inc, %for.body
  %5 = load i32, i32* %j, align 4, !dbg !52
  %cmp4 = icmp slt i32 %5, 250, !dbg !54
  br i1 %cmp4, label %for.body5, label %for.end, !dbg !55

for.body5:                                        ; preds = %for.cond3
  %6 = load [250 x double]*, [250 x double]** %A.addr, align 8, !dbg !56
  %7 = load i32, i32* %i, align 4, !dbg !58
  %idxprom6 = sext i32 %7 to i64, !dbg !56
  %arrayidx7 = getelementptr inbounds [250 x double], [250 x double]* %6, i64 %idxprom6, !dbg !56
  %8 = load i32, i32* %j, align 4, !dbg !59
  %idxprom8 = sext i32 %8 to i64, !dbg !56
  %arrayidx9 = getelementptr inbounds [250 x double], [250 x double]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !56
  %9 = load double, double* %arrayidx9, align 8, !dbg !56
  %10 = load double*, double** %x.addr, align 8, !dbg !60
  %11 = load i32, i32* %j, align 4, !dbg !61
  %idxprom10 = sext i32 %11 to i64, !dbg !60
  %arrayidx11 = getelementptr inbounds double, double* %10, i64 %idxprom10, !dbg !60
  %12 = load double, double* %arrayidx11, align 8, !dbg !60
  %mul = fmul double %9, %12, !dbg !62
  %13 = load double*, double** %tmp.addr, align 8, !dbg !63
  %14 = load i32, i32* %i, align 4, !dbg !64
  %idxprom12 = sext i32 %14 to i64, !dbg !63
  %arrayidx13 = getelementptr inbounds double, double* %13, i64 %idxprom12, !dbg !63
  %15 = load double, double* %arrayidx13, align 8, !dbg !65
  %add = fadd double %15, %mul, !dbg !65
  store double %add, double* %arrayidx13, align 8, !dbg !65
  %16 = load [250 x double]*, [250 x double]** %B.addr, align 8, !dbg !66
  %17 = load i32, i32* %i, align 4, !dbg !67
  %idxprom14 = sext i32 %17 to i64, !dbg !66
  %arrayidx15 = getelementptr inbounds [250 x double], [250 x double]* %16, i64 %idxprom14, !dbg !66
  %18 = load i32, i32* %j, align 4, !dbg !68
  %idxprom16 = sext i32 %18 to i64, !dbg !66
  %arrayidx17 = getelementptr inbounds [250 x double], [250 x double]* %arrayidx15, i64 0, i64 %idxprom16, !dbg !66
  %19 = load double, double* %arrayidx17, align 8, !dbg !66
  %20 = load double*, double** %x.addr, align 8, !dbg !69
  %21 = load i32, i32* %j, align 4, !dbg !70
  %idxprom18 = sext i32 %21 to i64, !dbg !69
  %arrayidx19 = getelementptr inbounds double, double* %20, i64 %idxprom18, !dbg !69
  %22 = load double, double* %arrayidx19, align 8, !dbg !69
  %mul20 = fmul double %19, %22, !dbg !71
  %23 = load double*, double** %y.addr, align 8, !dbg !72
  %24 = load i32, i32* %i, align 4, !dbg !73
  %idxprom21 = sext i32 %24 to i64, !dbg !72
  %arrayidx22 = getelementptr inbounds double, double* %23, i64 %idxprom21, !dbg !72
  %25 = load double, double* %arrayidx22, align 8, !dbg !74
  %add23 = fadd double %25, %mul20, !dbg !74
  store double %add23, double* %arrayidx22, align 8, !dbg !74
  br label %for.inc, !dbg !75

for.inc:                                          ; preds = %for.body5
  %26 = load i32, i32* %j, align 4, !dbg !76
  %inc = add nsw i32 %26, 1, !dbg !76
  store i32 %inc, i32* %j, align 4, !dbg !76
  br label %for.cond3, !dbg !77, !llvm.loop !78

for.end:                                          ; preds = %for.cond3
  %27 = load double, double* %alpha.addr, align 8, !dbg !81
  %28 = load double*, double** %tmp.addr, align 8, !dbg !82
  %29 = load i32, i32* %i, align 4, !dbg !83
  %idxprom24 = sext i32 %29 to i64, !dbg !82
  %arrayidx25 = getelementptr inbounds double, double* %28, i64 %idxprom24, !dbg !82
  %30 = load double, double* %arrayidx25, align 8, !dbg !82
  %mul26 = fmul double %27, %30, !dbg !84
  %31 = load double, double* %beta.addr, align 8, !dbg !85
  %32 = load double*, double** %y.addr, align 8, !dbg !86
  %33 = load i32, i32* %i, align 4, !dbg !87
  %idxprom27 = sext i32 %33 to i64, !dbg !86
  %arrayidx28 = getelementptr inbounds double, double* %32, i64 %idxprom27, !dbg !86
  %34 = load double, double* %arrayidx28, align 8, !dbg !86
  %mul29 = fmul double %31, %34, !dbg !88
  %add30 = fadd double %mul26, %mul29, !dbg !89
  %35 = load double*, double** %y.addr, align 8, !dbg !90
  %36 = load i32, i32* %i, align 4, !dbg !91
  %idxprom31 = sext i32 %36 to i64, !dbg !90
  %arrayidx32 = getelementptr inbounds double, double* %35, i64 %idxprom31, !dbg !90
  store double %add30, double* %arrayidx32, align 8, !dbg !92
  br label %for.inc33, !dbg !93

for.inc33:                                        ; preds = %for.end
  %37 = load i32, i32* %i, align 4, !dbg !94
  %inc34 = add nsw i32 %37, 1, !dbg !94
  store i32 %inc34, i32* %i, align 4, !dbg !94
  br label %for.cond, !dbg !95, !llvm.loop !96

for.end35:                                        ; preds = %for.cond
  ret void, !dbg !98
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "gesummv-medium.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/gesummv-medium")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_gesummv", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !11, !11, !15, !15, !15}
!10 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 16000, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 250)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!16 = !DILocalVariable(name: "alpha", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 28, scope: !7)
!18 = !DILocalVariable(name: "beta", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!19 = !DILocation(line: 3, column: 41, scope: !7)
!20 = !DILocalVariable(name: "A", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!21 = !DILocation(line: 3, column: 53, scope: !7)
!22 = !DILocalVariable(name: "B", arg: 4, scope: !7, file: !1, line: 3, type: !11)
!23 = !DILocation(line: 3, column: 72, scope: !7)
!24 = !DILocalVariable(name: "tmp", arg: 5, scope: !7, file: !1, line: 3, type: !15)
!25 = !DILocation(line: 3, column: 91, scope: !7)
!26 = !DILocalVariable(name: "x", arg: 6, scope: !7, file: !1, line: 3, type: !15)
!27 = !DILocation(line: 3, column: 107, scope: !7)
!28 = !DILocalVariable(name: "y", arg: 7, scope: !7, file: !1, line: 3, type: !15)
!29 = !DILocation(line: 3, column: 121, scope: !7)
!30 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !31)
!31 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!32 = !DILocation(line: 5, column: 7, scope: !7)
!33 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !31)
!34 = !DILocation(line: 6, column: 7, scope: !7)
!35 = !DILocation(line: 13, column: 10, scope: !36)
!36 = distinct !DILexicalBlock(scope: !7, file: !1, line: 13, column: 3)
!37 = !DILocation(line: 13, column: 8, scope: !36)
!38 = !DILocation(line: 13, column: 15, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !1, line: 13, column: 3)
!40 = !DILocation(line: 13, column: 17, scope: !39)
!41 = !DILocation(line: 13, column: 3, scope: !36)
!42 = !DILocation(line: 14, column: 5, scope: !43)
!43 = distinct !DILexicalBlock(scope: !39, file: !1, line: 13, column: 29)
!44 = !DILocation(line: 14, column: 9, scope: !43)
!45 = !DILocation(line: 14, column: 12, scope: !43)
!46 = !DILocation(line: 15, column: 5, scope: !43)
!47 = !DILocation(line: 15, column: 7, scope: !43)
!48 = !DILocation(line: 15, column: 10, scope: !43)
!49 = !DILocation(line: 18, column: 12, scope: !50)
!50 = distinct !DILexicalBlock(scope: !43, file: !1, line: 18, column: 5)
!51 = !DILocation(line: 18, column: 10, scope: !50)
!52 = !DILocation(line: 18, column: 17, scope: !53)
!53 = distinct !DILexicalBlock(scope: !50, file: !1, line: 18, column: 5)
!54 = !DILocation(line: 18, column: 19, scope: !53)
!55 = !DILocation(line: 18, column: 5, scope: !50)
!56 = !DILocation(line: 19, column: 17, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 18, column: 31)
!58 = !DILocation(line: 19, column: 19, scope: !57)
!59 = !DILocation(line: 19, column: 22, scope: !57)
!60 = !DILocation(line: 19, column: 27, scope: !57)
!61 = !DILocation(line: 19, column: 29, scope: !57)
!62 = !DILocation(line: 19, column: 25, scope: !57)
!63 = !DILocation(line: 19, column: 7, scope: !57)
!64 = !DILocation(line: 19, column: 11, scope: !57)
!65 = !DILocation(line: 19, column: 14, scope: !57)
!66 = !DILocation(line: 20, column: 15, scope: !57)
!67 = !DILocation(line: 20, column: 17, scope: !57)
!68 = !DILocation(line: 20, column: 20, scope: !57)
!69 = !DILocation(line: 20, column: 25, scope: !57)
!70 = !DILocation(line: 20, column: 27, scope: !57)
!71 = !DILocation(line: 20, column: 23, scope: !57)
!72 = !DILocation(line: 20, column: 7, scope: !57)
!73 = !DILocation(line: 20, column: 9, scope: !57)
!74 = !DILocation(line: 20, column: 12, scope: !57)
!75 = !DILocation(line: 21, column: 5, scope: !57)
!76 = !DILocation(line: 18, column: 27, scope: !53)
!77 = !DILocation(line: 18, column: 5, scope: !53)
!78 = distinct !{!78, !55, !79, !80}
!79 = !DILocation(line: 21, column: 5, scope: !50)
!80 = !{!"llvm.loop.mustprogress"}
!81 = !DILocation(line: 22, column: 12, scope: !43)
!82 = !DILocation(line: 22, column: 20, scope: !43)
!83 = !DILocation(line: 22, column: 24, scope: !43)
!84 = !DILocation(line: 22, column: 18, scope: !43)
!85 = !DILocation(line: 22, column: 29, scope: !43)
!86 = !DILocation(line: 22, column: 36, scope: !43)
!87 = !DILocation(line: 22, column: 38, scope: !43)
!88 = !DILocation(line: 22, column: 34, scope: !43)
!89 = !DILocation(line: 22, column: 27, scope: !43)
!90 = !DILocation(line: 22, column: 5, scope: !43)
!91 = !DILocation(line: 22, column: 7, scope: !43)
!92 = !DILocation(line: 22, column: 10, scope: !43)
!93 = !DILocation(line: 23, column: 3, scope: !43)
!94 = !DILocation(line: 13, column: 25, scope: !39)
!95 = !DILocation(line: 13, column: 3, scope: !39)
!96 = distinct !{!96, !41, !97, !80}
!97 = !DILocation(line: 23, column: 3, scope: !36)
!98 = !DILocation(line: 24, column: 1, scope: !7)
