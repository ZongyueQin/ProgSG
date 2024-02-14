; ModuleID = 'jacobi-1d.c'
source_filename = "jacobi-1d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_jacobi_1d(i32 %tsteps, i32 %n, double* %A, double* %B) #0 !dbg !7 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca double*, align 8
  %B.addr = alloca double*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %tsteps.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store double* %A, double** %A.addr, align 8
  call void @llvm.dbg.declare(metadata double** %A.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store double* %B, double** %B.addr, align 8
  call void @llvm.dbg.declare(metadata double** %B.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %t, metadata !21, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %i, metadata !23, metadata !DIExpression()), !dbg !24
  store i32 0, i32* %t, align 4, !dbg !25
  br label %for.cond, !dbg !27

for.cond:                                         ; preds = %for.inc31, %entry
  %0 = load i32, i32* %t, align 4, !dbg !28
  %cmp = icmp slt i32 %0, 40, !dbg !30
  br i1 %cmp, label %for.body, label %for.end33, !dbg !31

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4, !dbg !32
  br label %for.cond1, !dbg !35

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %i, align 4, !dbg !36
  %cmp2 = icmp slt i32 %1, 119, !dbg !38
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !39

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %A.addr, align 8, !dbg !40
  %3 = load i32, i32* %i, align 4, !dbg !42
  %sub = sub nsw i32 %3, 1, !dbg !43
  %idxprom = sext i32 %sub to i64, !dbg !40
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !40
  %4 = load double, double* %arrayidx, align 8, !dbg !40
  %5 = load double*, double** %A.addr, align 8, !dbg !44
  %6 = load i32, i32* %i, align 4, !dbg !45
  %idxprom4 = sext i32 %6 to i64, !dbg !44
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !44
  %7 = load double, double* %arrayidx5, align 8, !dbg !44
  %add = fadd double %4, %7, !dbg !46
  %8 = load double*, double** %A.addr, align 8, !dbg !47
  %9 = load i32, i32* %i, align 4, !dbg !48
  %add6 = add nsw i32 %9, 1, !dbg !49
  %idxprom7 = sext i32 %add6 to i64, !dbg !47
  %arrayidx8 = getelementptr inbounds double, double* %8, i64 %idxprom7, !dbg !47
  %10 = load double, double* %arrayidx8, align 8, !dbg !47
  %add9 = fadd double %add, %10, !dbg !50
  %mul = fmul double 3.333300e-01, %add9, !dbg !51
  %11 = load double*, double** %B.addr, align 8, !dbg !52
  %12 = load i32, i32* %i, align 4, !dbg !53
  %idxprom10 = sext i32 %12 to i64, !dbg !52
  %arrayidx11 = getelementptr inbounds double, double* %11, i64 %idxprom10, !dbg !52
  store double %mul, double* %arrayidx11, align 8, !dbg !54
  br label %for.inc, !dbg !55

for.inc:                                          ; preds = %for.body3
  %13 = load i32, i32* %i, align 4, !dbg !56
  %inc = add nsw i32 %13, 1, !dbg !56
  store i32 %inc, i32* %i, align 4, !dbg !56
  br label %for.cond1, !dbg !57, !llvm.loop !58

for.end:                                          ; preds = %for.cond1
  store i32 1, i32* %i, align 4, !dbg !61
  br label %for.cond12, !dbg !63

for.cond12:                                       ; preds = %for.inc28, %for.end
  %14 = load i32, i32* %i, align 4, !dbg !64
  %cmp13 = icmp slt i32 %14, 119, !dbg !66
  br i1 %cmp13, label %for.body14, label %for.end30, !dbg !67

for.body14:                                       ; preds = %for.cond12
  %15 = load double*, double** %B.addr, align 8, !dbg !68
  %16 = load i32, i32* %i, align 4, !dbg !70
  %sub15 = sub nsw i32 %16, 1, !dbg !71
  %idxprom16 = sext i32 %sub15 to i64, !dbg !68
  %arrayidx17 = getelementptr inbounds double, double* %15, i64 %idxprom16, !dbg !68
  %17 = load double, double* %arrayidx17, align 8, !dbg !68
  %18 = load double*, double** %B.addr, align 8, !dbg !72
  %19 = load i32, i32* %i, align 4, !dbg !73
  %idxprom18 = sext i32 %19 to i64, !dbg !72
  %arrayidx19 = getelementptr inbounds double, double* %18, i64 %idxprom18, !dbg !72
  %20 = load double, double* %arrayidx19, align 8, !dbg !72
  %add20 = fadd double %17, %20, !dbg !74
  %21 = load double*, double** %B.addr, align 8, !dbg !75
  %22 = load i32, i32* %i, align 4, !dbg !76
  %add21 = add nsw i32 %22, 1, !dbg !77
  %idxprom22 = sext i32 %add21 to i64, !dbg !75
  %arrayidx23 = getelementptr inbounds double, double* %21, i64 %idxprom22, !dbg !75
  %23 = load double, double* %arrayidx23, align 8, !dbg !75
  %add24 = fadd double %add20, %23, !dbg !78
  %mul25 = fmul double 3.333300e-01, %add24, !dbg !79
  %24 = load double*, double** %A.addr, align 8, !dbg !80
  %25 = load i32, i32* %i, align 4, !dbg !81
  %idxprom26 = sext i32 %25 to i64, !dbg !80
  %arrayidx27 = getelementptr inbounds double, double* %24, i64 %idxprom26, !dbg !80
  store double %mul25, double* %arrayidx27, align 8, !dbg !82
  br label %for.inc28, !dbg !83

for.inc28:                                        ; preds = %for.body14
  %26 = load i32, i32* %i, align 4, !dbg !84
  %inc29 = add nsw i32 %26, 1, !dbg !84
  store i32 %inc29, i32* %i, align 4, !dbg !84
  br label %for.cond12, !dbg !85, !llvm.loop !86

for.end30:                                        ; preds = %for.cond12
  br label %for.inc31, !dbg !88

for.inc31:                                        ; preds = %for.end30
  %27 = load i32, i32* %t, align 4, !dbg !89
  %inc32 = add nsw i32 %27, 1, !dbg !89
  store i32 %inc32, i32* %t, align 4, !dbg !89
  br label %for.cond, !dbg !90, !llvm.loop !91

for.end33:                                        ; preds = %for.cond
  ret void, !dbg !93
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "jacobi-1d.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/jacobi-1d")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "kernel_jacobi_1d", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !11, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!13 = !DILocalVariable(name: "tsteps", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 27, scope: !7)
!15 = !DILocalVariable(name: "n", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!16 = !DILocation(line: 3, column: 38, scope: !7)
!17 = !DILocalVariable(name: "A", arg: 3, scope: !7, file: !1, line: 3, type: !11)
!18 = !DILocation(line: 3, column: 47, scope: !7)
!19 = !DILocalVariable(name: "B", arg: 4, scope: !7, file: !1, line: 3, type: !11)
!20 = !DILocation(line: 3, column: 61, scope: !7)
!21 = !DILocalVariable(name: "t", scope: !7, file: !1, line: 5, type: !10)
!22 = !DILocation(line: 5, column: 7, scope: !7)
!23 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 6, type: !10)
!24 = !DILocation(line: 6, column: 7, scope: !7)
!25 = !DILocation(line: 14, column: 10, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 3)
!27 = !DILocation(line: 14, column: 8, scope: !26)
!28 = !DILocation(line: 14, column: 15, scope: !29)
!29 = distinct !DILexicalBlock(scope: !26, file: !1, line: 14, column: 3)
!30 = !DILocation(line: 14, column: 17, scope: !29)
!31 = !DILocation(line: 14, column: 3, scope: !26)
!32 = !DILocation(line: 17, column: 12, scope: !33)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 17, column: 5)
!34 = distinct !DILexicalBlock(scope: !29, file: !1, line: 14, column: 28)
!35 = !DILocation(line: 17, column: 10, scope: !33)
!36 = !DILocation(line: 17, column: 17, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !1, line: 17, column: 5)
!38 = !DILocation(line: 17, column: 19, scope: !37)
!39 = !DILocation(line: 17, column: 5, scope: !33)
!40 = !DILocation(line: 18, column: 25, scope: !41)
!41 = distinct !DILexicalBlock(scope: !37, file: !1, line: 17, column: 31)
!42 = !DILocation(line: 18, column: 27, scope: !41)
!43 = !DILocation(line: 18, column: 29, scope: !41)
!44 = !DILocation(line: 18, column: 36, scope: !41)
!45 = !DILocation(line: 18, column: 38, scope: !41)
!46 = !DILocation(line: 18, column: 34, scope: !41)
!47 = !DILocation(line: 18, column: 43, scope: !41)
!48 = !DILocation(line: 18, column: 45, scope: !41)
!49 = !DILocation(line: 18, column: 47, scope: !41)
!50 = !DILocation(line: 18, column: 41, scope: !41)
!51 = !DILocation(line: 18, column: 22, scope: !41)
!52 = !DILocation(line: 18, column: 7, scope: !41)
!53 = !DILocation(line: 18, column: 9, scope: !41)
!54 = !DILocation(line: 18, column: 12, scope: !41)
!55 = !DILocation(line: 19, column: 5, scope: !41)
!56 = !DILocation(line: 17, column: 27, scope: !37)
!57 = !DILocation(line: 17, column: 5, scope: !37)
!58 = distinct !{!58, !39, !59, !60}
!59 = !DILocation(line: 19, column: 5, scope: !33)
!60 = !{!"llvm.loop.mustprogress"}
!61 = !DILocation(line: 22, column: 12, scope: !62)
!62 = distinct !DILexicalBlock(scope: !34, file: !1, line: 22, column: 5)
!63 = !DILocation(line: 22, column: 10, scope: !62)
!64 = !DILocation(line: 22, column: 17, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !1, line: 22, column: 5)
!66 = !DILocation(line: 22, column: 19, scope: !65)
!67 = !DILocation(line: 22, column: 5, scope: !62)
!68 = !DILocation(line: 23, column: 25, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 22, column: 31)
!70 = !DILocation(line: 23, column: 27, scope: !69)
!71 = !DILocation(line: 23, column: 29, scope: !69)
!72 = !DILocation(line: 23, column: 36, scope: !69)
!73 = !DILocation(line: 23, column: 38, scope: !69)
!74 = !DILocation(line: 23, column: 34, scope: !69)
!75 = !DILocation(line: 23, column: 43, scope: !69)
!76 = !DILocation(line: 23, column: 45, scope: !69)
!77 = !DILocation(line: 23, column: 47, scope: !69)
!78 = !DILocation(line: 23, column: 41, scope: !69)
!79 = !DILocation(line: 23, column: 22, scope: !69)
!80 = !DILocation(line: 23, column: 7, scope: !69)
!81 = !DILocation(line: 23, column: 9, scope: !69)
!82 = !DILocation(line: 23, column: 12, scope: !69)
!83 = !DILocation(line: 24, column: 5, scope: !69)
!84 = !DILocation(line: 22, column: 27, scope: !65)
!85 = !DILocation(line: 22, column: 5, scope: !65)
!86 = distinct !{!86, !67, !87, !60}
!87 = !DILocation(line: 24, column: 5, scope: !62)
!88 = !DILocation(line: 25, column: 3, scope: !34)
!89 = !DILocation(line: 14, column: 24, scope: !29)
!90 = !DILocation(line: 14, column: 3, scope: !29)
!91 = distinct !{!91, !31, !92, !60}
!92 = !DILocation(line: 25, column: 3, scope: !26)
!93 = !DILocation(line: 27, column: 1, scope: !7)
