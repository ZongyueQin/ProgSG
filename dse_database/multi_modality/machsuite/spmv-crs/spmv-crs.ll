; ModuleID = 'spmv-crs.c'
source_filename = "spmv-crs.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @spmv(double* %val, i32* %cols, i32* %rowDelimiters, double* %vec, double* %out) #0 !dbg !9 {
entry:
  %val.addr = alloca double*, align 8
  %cols.addr = alloca i32*, align 8
  %rowDelimiters.addr = alloca i32*, align 8
  %vec.addr = alloca double*, align 8
  %out.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %sum = alloca double, align 8
  %Si = alloca double, align 8
  %tmp_begin = alloca i32, align 4
  %tmp_end = alloca i32, align 4
  store double* %val, double** %val.addr, align 8
  call void @llvm.dbg.declare(metadata double** %val.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store i32* %cols, i32** %cols.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %cols.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32* %rowDelimiters, i32** %rowDelimiters.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %rowDelimiters.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store double* %vec, double** %vec.addr, align 8
  call void @llvm.dbg.declare(metadata double** %vec.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store double* %out, double** %out.addr, align 8
  call void @llvm.dbg.declare(metadata double** %out.addr, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %j, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata double* %sum, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata double* %Si, metadata !31, metadata !DIExpression()), !dbg !32
  br label %spmv_1, !dbg !33

spmv_1:                                           ; preds = %entry
  call void @llvm.dbg.label(metadata !34), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !38

for.cond:                                         ; preds = %for.inc15, %spmv_1
  %0 = load i32, i32* %i, align 4, !dbg !39
  %cmp = icmp slt i32 %0, 494, !dbg !41
  br i1 %cmp, label %for.body, label %for.end17, !dbg !42

for.body:                                         ; preds = %for.cond
  store double 0.000000e+00, double* %sum, align 8, !dbg !43
  store double 0.000000e+00, double* %Si, align 8, !dbg !45
  call void @llvm.dbg.declare(metadata i32* %tmp_begin, metadata !46, metadata !DIExpression()), !dbg !47
  %1 = load i32*, i32** %rowDelimiters.addr, align 8, !dbg !48
  %2 = load i32, i32* %i, align 4, !dbg !49
  %idxprom = sext i32 %2 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, i32* %1, i64 %idxprom, !dbg !48
  %3 = load i32, i32* %arrayidx, align 4, !dbg !48
  store i32 %3, i32* %tmp_begin, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata i32* %tmp_end, metadata !50, metadata !DIExpression()), !dbg !51
  %4 = load i32*, i32** %rowDelimiters.addr, align 8, !dbg !52
  %5 = load i32, i32* %i, align 4, !dbg !53
  %add = add nsw i32 %5, 1, !dbg !54
  %idxprom1 = sext i32 %add to i64, !dbg !52
  %arrayidx2 = getelementptr inbounds i32, i32* %4, i64 %idxprom1, !dbg !52
  %6 = load i32, i32* %arrayidx2, align 4, !dbg !52
  store i32 %6, i32* %tmp_end, align 4, !dbg !51
  br label %spmv_2, !dbg !55

spmv_2:                                           ; preds = %for.body
  call void @llvm.dbg.label(metadata !56), !dbg !57
  %7 = load i32, i32* %tmp_begin, align 4, !dbg !58
  store i32 %7, i32* %j, align 4, !dbg !60
  br label %for.cond3, !dbg !61

for.cond3:                                        ; preds = %for.inc, %spmv_2
  %8 = load i32, i32* %j, align 4, !dbg !62
  %9 = load i32, i32* %tmp_end, align 4, !dbg !64
  %cmp4 = icmp slt i32 %8, %9, !dbg !65
  br i1 %cmp4, label %for.body5, label %for.end, !dbg !66

for.body5:                                        ; preds = %for.cond3
  %10 = load double*, double** %val.addr, align 8, !dbg !67
  %11 = load i32, i32* %j, align 4, !dbg !69
  %idxprom6 = sext i32 %11 to i64, !dbg !67
  %arrayidx7 = getelementptr inbounds double, double* %10, i64 %idxprom6, !dbg !67
  %12 = load double, double* %arrayidx7, align 8, !dbg !67
  %13 = load double*, double** %vec.addr, align 8, !dbg !70
  %14 = load i32*, i32** %cols.addr, align 8, !dbg !71
  %15 = load i32, i32* %j, align 4, !dbg !72
  %idxprom8 = sext i32 %15 to i64, !dbg !71
  %arrayidx9 = getelementptr inbounds i32, i32* %14, i64 %idxprom8, !dbg !71
  %16 = load i32, i32* %arrayidx9, align 4, !dbg !71
  %idxprom10 = sext i32 %16 to i64, !dbg !70
  %arrayidx11 = getelementptr inbounds double, double* %13, i64 %idxprom10, !dbg !70
  %17 = load double, double* %arrayidx11, align 8, !dbg !70
  %mul = fmul double %12, %17, !dbg !73
  store double %mul, double* %Si, align 8, !dbg !74
  %18 = load double, double* %sum, align 8, !dbg !75
  %19 = load double, double* %Si, align 8, !dbg !76
  %add12 = fadd double %18, %19, !dbg !77
  store double %add12, double* %sum, align 8, !dbg !78
  br label %for.inc, !dbg !79

for.inc:                                          ; preds = %for.body5
  %20 = load i32, i32* %j, align 4, !dbg !80
  %inc = add nsw i32 %20, 1, !dbg !80
  store i32 %inc, i32* %j, align 4, !dbg !80
  br label %for.cond3, !dbg !81, !llvm.loop !82

for.end:                                          ; preds = %for.cond3
  %21 = load double, double* %sum, align 8, !dbg !85
  %22 = load double*, double** %out.addr, align 8, !dbg !86
  %23 = load i32, i32* %i, align 4, !dbg !87
  %idxprom13 = sext i32 %23 to i64, !dbg !86
  %arrayidx14 = getelementptr inbounds double, double* %22, i64 %idxprom13, !dbg !86
  store double %21, double* %arrayidx14, align 8, !dbg !88
  br label %for.inc15, !dbg !89

for.inc15:                                        ; preds = %for.end
  %24 = load i32, i32* %i, align 4, !dbg !90
  %inc16 = add nsw i32 %24, 1, !dbg !90
  store i32 %inc16, i32* %i, align 4, !dbg !90
  br label %for.cond, !dbg !91, !llvm.loop !92

for.end17:                                        ; preds = %for.cond
  ret void, !dbg !94
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "spmv-crs.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/machsuite/spmv-crs")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "spmv", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !13, !13, !12, !12}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "val", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!16 = !DILocation(line: 3, column: 18, scope: !9)
!17 = !DILocalVariable(name: "cols", arg: 2, scope: !9, file: !1, line: 3, type: !13)
!18 = !DILocation(line: 3, column: 32, scope: !9)
!19 = !DILocalVariable(name: "rowDelimiters", arg: 3, scope: !9, file: !1, line: 3, type: !13)
!20 = !DILocation(line: 3, column: 47, scope: !9)
!21 = !DILocalVariable(name: "vec", arg: 4, scope: !9, file: !1, line: 3, type: !12)
!22 = !DILocation(line: 3, column: 73, scope: !9)
!23 = !DILocalVariable(name: "out", arg: 5, scope: !9, file: !1, line: 3, type: !12)
!24 = !DILocation(line: 3, column: 89, scope: !9)
!25 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 5, type: !14)
!26 = !DILocation(line: 5, column: 7, scope: !9)
!27 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 6, type: !14)
!28 = !DILocation(line: 6, column: 7, scope: !9)
!29 = !DILocalVariable(name: "sum", scope: !9, file: !1, line: 7, type: !4)
!30 = !DILocation(line: 7, column: 10, scope: !9)
!31 = !DILocalVariable(name: "Si", scope: !9, file: !1, line: 8, type: !4)
!32 = !DILocation(line: 8, column: 10, scope: !9)
!33 = !DILocation(line: 8, column: 3, scope: !9)
!34 = !DILabel(scope: !9, name: "spmv_1", file: !1, line: 15)
!35 = !DILocation(line: 15, column: 3, scope: !9)
!36 = !DILocation(line: 16, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !9, file: !1, line: 16, column: 3)
!38 = !DILocation(line: 16, column: 8, scope: !37)
!39 = !DILocation(line: 16, column: 15, scope: !40)
!40 = distinct !DILexicalBlock(scope: !37, file: !1, line: 16, column: 3)
!41 = !DILocation(line: 16, column: 17, scope: !40)
!42 = !DILocation(line: 16, column: 3, scope: !37)
!43 = !DILocation(line: 17, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !40, file: !1, line: 16, column: 29)
!45 = !DILocation(line: 18, column: 8, scope: !44)
!46 = !DILocalVariable(name: "tmp_begin", scope: !44, file: !1, line: 19, type: !14)
!47 = !DILocation(line: 19, column: 9, scope: !44)
!48 = !DILocation(line: 19, column: 21, scope: !44)
!49 = !DILocation(line: 19, column: 35, scope: !44)
!50 = !DILocalVariable(name: "tmp_end", scope: !44, file: !1, line: 20, type: !14)
!51 = !DILocation(line: 20, column: 9, scope: !44)
!52 = !DILocation(line: 20, column: 19, scope: !44)
!53 = !DILocation(line: 20, column: 33, scope: !44)
!54 = !DILocation(line: 20, column: 35, scope: !44)
!55 = !DILocation(line: 20, column: 5, scope: !44)
!56 = !DILabel(scope: !44, name: "spmv_2", file: !1, line: 21)
!57 = !DILocation(line: 21, column: 5, scope: !44)
!58 = !DILocation(line: 22, column: 14, scope: !59)
!59 = distinct !DILexicalBlock(scope: !44, file: !1, line: 22, column: 5)
!60 = !DILocation(line: 22, column: 12, scope: !59)
!61 = !DILocation(line: 22, column: 10, scope: !59)
!62 = !DILocation(line: 22, column: 25, scope: !63)
!63 = distinct !DILexicalBlock(scope: !59, file: !1, line: 22, column: 5)
!64 = !DILocation(line: 22, column: 29, scope: !63)
!65 = !DILocation(line: 22, column: 27, scope: !63)
!66 = !DILocation(line: 22, column: 5, scope: !59)
!67 = !DILocation(line: 23, column: 12, scope: !68)
!68 = distinct !DILexicalBlock(scope: !63, file: !1, line: 22, column: 43)
!69 = !DILocation(line: 23, column: 16, scope: !68)
!70 = !DILocation(line: 23, column: 21, scope: !68)
!71 = !DILocation(line: 23, column: 25, scope: !68)
!72 = !DILocation(line: 23, column: 30, scope: !68)
!73 = !DILocation(line: 23, column: 19, scope: !68)
!74 = !DILocation(line: 23, column: 10, scope: !68)
!75 = !DILocation(line: 24, column: 13, scope: !68)
!76 = !DILocation(line: 24, column: 19, scope: !68)
!77 = !DILocation(line: 24, column: 17, scope: !68)
!78 = !DILocation(line: 24, column: 11, scope: !68)
!79 = !DILocation(line: 25, column: 5, scope: !68)
!80 = !DILocation(line: 22, column: 39, scope: !63)
!81 = !DILocation(line: 22, column: 5, scope: !63)
!82 = distinct !{!82, !66, !83, !84}
!83 = !DILocation(line: 25, column: 5, scope: !59)
!84 = !{!"llvm.loop.mustprogress"}
!85 = !DILocation(line: 26, column: 14, scope: !44)
!86 = !DILocation(line: 26, column: 5, scope: !44)
!87 = !DILocation(line: 26, column: 9, scope: !44)
!88 = !DILocation(line: 26, column: 12, scope: !44)
!89 = !DILocation(line: 27, column: 3, scope: !44)
!90 = !DILocation(line: 16, column: 25, scope: !40)
!91 = !DILocation(line: 16, column: 3, scope: !40)
!92 = distinct !{!92, !42, !93, !84}
!93 = !DILocation(line: 27, column: 3, scope: !37)
!94 = !DILocation(line: 28, column: 1, scope: !9)
