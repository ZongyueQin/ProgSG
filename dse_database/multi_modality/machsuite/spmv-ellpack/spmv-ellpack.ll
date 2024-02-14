; ModuleID = 'spmv-ellpack.c'
source_filename = "spmv-ellpack.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ellpack(double* %nzval, i32* %cols, double* %vec, double* %out) #0 !dbg !7 {
entry:
  %nzval.addr = alloca double*, align 8
  %cols.addr = alloca i32*, align 8
  %vec.addr = alloca double*, align 8
  %out.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %Si = alloca double, align 8
  %sum = alloca double, align 8
  store double* %nzval, double** %nzval.addr, align 8
  call void @llvm.dbg.declare(metadata double** %nzval.addr, metadata !14, metadata !DIExpression()), !dbg !15
  store i32* %cols, i32** %cols.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %cols.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store double* %vec, double** %vec.addr, align 8
  call void @llvm.dbg.declare(metadata double** %vec.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store double* %out, double** %out.addr, align 8
  call void @llvm.dbg.declare(metadata double** %out.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %j, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata double* %Si, metadata !26, metadata !DIExpression()), !dbg !27
  br label %ellpack_1, !dbg !28

ellpack_1:                                        ; preds = %entry
  call void @llvm.dbg.label(metadata !29), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc16, %ellpack_1
  %0 = load i32, i32* %i, align 4, !dbg !34
  %cmp = icmp slt i32 %0, 494, !dbg !36
  br i1 %cmp, label %for.body, label %for.end18, !dbg !37

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata double* %sum, metadata !38, metadata !DIExpression()), !dbg !40
  %1 = load double*, double** %out.addr, align 8, !dbg !41
  %2 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %2 to i64, !dbg !41
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !41
  %3 = load double, double* %arrayidx, align 8, !dbg !41
  store double %3, double* %sum, align 8, !dbg !40
  br label %ellpack_2, !dbg !43

ellpack_2:                                        ; preds = %for.body
  call void @llvm.dbg.label(metadata !44), !dbg !45
  store i32 0, i32* %j, align 4, !dbg !46
  br label %for.cond1, !dbg !48

for.cond1:                                        ; preds = %for.inc, %ellpack_2
  %4 = load i32, i32* %j, align 4, !dbg !49
  %cmp2 = icmp slt i32 %4, 10, !dbg !51
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !52

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %nzval.addr, align 8, !dbg !53
  %6 = load i32, i32* %j, align 4, !dbg !55
  %7 = load i32, i32* %i, align 4, !dbg !56
  %mul = mul nsw i32 %7, 10, !dbg !57
  %add = add nsw i32 %6, %mul, !dbg !58
  %idxprom4 = sext i32 %add to i64, !dbg !53
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !53
  %8 = load double, double* %arrayidx5, align 8, !dbg !53
  %9 = load double*, double** %vec.addr, align 8, !dbg !59
  %10 = load i32*, i32** %cols.addr, align 8, !dbg !60
  %11 = load i32, i32* %j, align 4, !dbg !61
  %12 = load i32, i32* %i, align 4, !dbg !62
  %mul6 = mul nsw i32 %12, 10, !dbg !63
  %add7 = add nsw i32 %11, %mul6, !dbg !64
  %idxprom8 = sext i32 %add7 to i64, !dbg !60
  %arrayidx9 = getelementptr inbounds i32, i32* %10, i64 %idxprom8, !dbg !60
  %13 = load i32, i32* %arrayidx9, align 4, !dbg !60
  %idxprom10 = sext i32 %13 to i64, !dbg !59
  %arrayidx11 = getelementptr inbounds double, double* %9, i64 %idxprom10, !dbg !59
  %14 = load double, double* %arrayidx11, align 8, !dbg !59
  %mul12 = fmul double %8, %14, !dbg !65
  store double %mul12, double* %Si, align 8, !dbg !66
  %15 = load double, double* %Si, align 8, !dbg !67
  %16 = load double, double* %sum, align 8, !dbg !68
  %add13 = fadd double %16, %15, !dbg !68
  store double %add13, double* %sum, align 8, !dbg !68
  br label %for.inc, !dbg !69

for.inc:                                          ; preds = %for.body3
  %17 = load i32, i32* %j, align 4, !dbg !70
  %inc = add nsw i32 %17, 1, !dbg !70
  store i32 %inc, i32* %j, align 4, !dbg !70
  br label %for.cond1, !dbg !71, !llvm.loop !72

for.end:                                          ; preds = %for.cond1
  %18 = load double, double* %sum, align 8, !dbg !75
  %19 = load double*, double** %out.addr, align 8, !dbg !76
  %20 = load i32, i32* %i, align 4, !dbg !77
  %idxprom14 = sext i32 %20 to i64, !dbg !76
  %arrayidx15 = getelementptr inbounds double, double* %19, i64 %idxprom14, !dbg !76
  store double %18, double* %arrayidx15, align 8, !dbg !78
  br label %for.inc16, !dbg !79

for.inc16:                                        ; preds = %for.end
  %21 = load i32, i32* %i, align 4, !dbg !80
  %inc17 = add nsw i32 %21, 1, !dbg !80
  store i32 %inc17, i32* %i, align 4, !dbg !80
  br label %for.cond, !dbg !81, !llvm.loop !82

for.end18:                                        ; preds = %for.cond
  ret void, !dbg !84
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "spmv-ellpack.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/machsuite/spmv-ellpack")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!7 = distinct !DISubprogram(name: "ellpack", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !12, !10, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "nzval", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 21, scope: !7)
!16 = !DILocalVariable(name: "cols", arg: 2, scope: !7, file: !1, line: 3, type: !12)
!17 = !DILocation(line: 3, column: 37, scope: !7)
!18 = !DILocalVariable(name: "vec", arg: 3, scope: !7, file: !1, line: 3, type: !10)
!19 = !DILocation(line: 3, column: 55, scope: !7)
!20 = !DILocalVariable(name: "out", arg: 4, scope: !7, file: !1, line: 3, type: !10)
!21 = !DILocation(line: 3, column: 71, scope: !7)
!22 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !13)
!23 = !DILocation(line: 5, column: 7, scope: !7)
!24 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 6, type: !13)
!25 = !DILocation(line: 6, column: 7, scope: !7)
!26 = !DILocalVariable(name: "Si", scope: !7, file: !1, line: 7, type: !11)
!27 = !DILocation(line: 7, column: 10, scope: !7)
!28 = !DILocation(line: 7, column: 3, scope: !7)
!29 = !DILabel(scope: !7, name: "ellpack_1", file: !1, line: 14)
!30 = !DILocation(line: 14, column: 3, scope: !7)
!31 = !DILocation(line: 15, column: 10, scope: !32)
!32 = distinct !DILexicalBlock(scope: !7, file: !1, line: 15, column: 3)
!33 = !DILocation(line: 15, column: 8, scope: !32)
!34 = !DILocation(line: 15, column: 15, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 15, column: 3)
!36 = !DILocation(line: 15, column: 17, scope: !35)
!37 = !DILocation(line: 15, column: 3, scope: !32)
!38 = !DILocalVariable(name: "sum", scope: !39, file: !1, line: 16, type: !11)
!39 = distinct !DILexicalBlock(scope: !35, file: !1, line: 15, column: 29)
!40 = !DILocation(line: 16, column: 12, scope: !39)
!41 = !DILocation(line: 16, column: 18, scope: !39)
!42 = !DILocation(line: 16, column: 22, scope: !39)
!43 = !DILocation(line: 16, column: 5, scope: !39)
!44 = !DILabel(scope: !39, name: "ellpack_2", file: !1, line: 17)
!45 = !DILocation(line: 17, column: 5, scope: !39)
!46 = !DILocation(line: 18, column: 12, scope: !47)
!47 = distinct !DILexicalBlock(scope: !39, file: !1, line: 18, column: 5)
!48 = !DILocation(line: 18, column: 10, scope: !47)
!49 = !DILocation(line: 18, column: 17, scope: !50)
!50 = distinct !DILexicalBlock(scope: !47, file: !1, line: 18, column: 5)
!51 = !DILocation(line: 18, column: 19, scope: !50)
!52 = !DILocation(line: 18, column: 5, scope: !47)
!53 = !DILocation(line: 19, column: 12, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !1, line: 18, column: 30)
!55 = !DILocation(line: 19, column: 18, scope: !54)
!56 = !DILocation(line: 19, column: 22, scope: !54)
!57 = !DILocation(line: 19, column: 24, scope: !54)
!58 = !DILocation(line: 19, column: 20, scope: !54)
!59 = !DILocation(line: 19, column: 32, scope: !54)
!60 = !DILocation(line: 19, column: 36, scope: !54)
!61 = !DILocation(line: 19, column: 41, scope: !54)
!62 = !DILocation(line: 19, column: 45, scope: !54)
!63 = !DILocation(line: 19, column: 47, scope: !54)
!64 = !DILocation(line: 19, column: 43, scope: !54)
!65 = !DILocation(line: 19, column: 30, scope: !54)
!66 = !DILocation(line: 19, column: 10, scope: !54)
!67 = !DILocation(line: 20, column: 14, scope: !54)
!68 = !DILocation(line: 20, column: 11, scope: !54)
!69 = !DILocation(line: 21, column: 5, scope: !54)
!70 = !DILocation(line: 18, column: 26, scope: !50)
!71 = !DILocation(line: 18, column: 5, scope: !50)
!72 = distinct !{!72, !52, !73, !74}
!73 = !DILocation(line: 21, column: 5, scope: !47)
!74 = !{!"llvm.loop.mustprogress"}
!75 = !DILocation(line: 22, column: 14, scope: !39)
!76 = !DILocation(line: 22, column: 5, scope: !39)
!77 = !DILocation(line: 22, column: 9, scope: !39)
!78 = !DILocation(line: 22, column: 12, scope: !39)
!79 = !DILocation(line: 23, column: 3, scope: !39)
!80 = !DILocation(line: 15, column: 25, scope: !35)
!81 = !DILocation(line: 15, column: 3, scope: !35)
!82 = distinct !{!82, !37, !83, !74}
!83 = !DILocation(line: 23, column: 3, scope: !32)
!84 = !DILocation(line: 24, column: 1, scope: !7)
