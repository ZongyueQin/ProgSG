; ModuleID = 'stencil_stencil2d.c'
source_filename = "stencil_stencil2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @stencil(i32* %orig, i32* %sol, i32* %filter) #0 !dbg !9 {
entry:
  %orig.addr = alloca i32*, align 8
  %sol.addr = alloca i32*, align 8
  %filter.addr = alloca i32*, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %k1 = alloca i32, align 4
  %k2 = alloca i32, align 4
  %temp = alloca i32, align 4
  %mul = alloca i32, align 4
  store i32* %orig, i32** %orig.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %orig.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store i32* %sol, i32** %sol.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %sol.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store i32* %filter, i32** %filter.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %filter.addr, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %r, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %c, metadata !21, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %k1, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %k2, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %temp, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %mul, metadata !29, metadata !DIExpression()), !dbg !30
  br label %stencil_label1, !dbg !31

stencil_label1:                                   ; preds = %entry
  call void @llvm.dbg.label(metadata !32), !dbg !33
  store i32 0, i32* %r, align 4, !dbg !34
  br label %for.cond, !dbg !36

for.cond:                                         ; preds = %for.inc29, %stencil_label1
  %0 = load i32, i32* %r, align 4, !dbg !37
  %cmp = icmp slt i32 %0, 126, !dbg !39
  br i1 %cmp, label %for.body, label %for.end31, !dbg !40

for.body:                                         ; preds = %for.cond
  br label %stencil_label2, !dbg !41

stencil_label2:                                   ; preds = %for.body
  call void @llvm.dbg.label(metadata !42), !dbg !44
  store i32 0, i32* %c, align 4, !dbg !45
  br label %for.cond1, !dbg !47

for.cond1:                                        ; preds = %for.inc26, %stencil_label2
  %1 = load i32, i32* %c, align 4, !dbg !48
  %cmp2 = icmp slt i32 %1, 62, !dbg !50
  br i1 %cmp2, label %for.body3, label %for.end28, !dbg !51

for.body3:                                        ; preds = %for.cond1
  store i32 0, i32* %temp, align 4, !dbg !52
  br label %stencil_label3, !dbg !54

stencil_label3:                                   ; preds = %for.body3
  call void @llvm.dbg.label(metadata !55), !dbg !56
  store i32 0, i32* %k1, align 4, !dbg !57
  br label %for.cond4, !dbg !59

for.cond4:                                        ; preds = %for.inc19, %stencil_label3
  %2 = load i32, i32* %k1, align 4, !dbg !60
  %cmp5 = icmp slt i32 %2, 3, !dbg !62
  br i1 %cmp5, label %for.body6, label %for.end21, !dbg !63

for.body6:                                        ; preds = %for.cond4
  br label %stencil_label4, !dbg !64

stencil_label4:                                   ; preds = %for.body6
  call void @llvm.dbg.label(metadata !65), !dbg !67
  store i32 0, i32* %k2, align 4, !dbg !68
  br label %for.cond7, !dbg !70

for.cond7:                                        ; preds = %for.inc, %stencil_label4
  %3 = load i32, i32* %k2, align 4, !dbg !71
  %cmp8 = icmp slt i32 %3, 3, !dbg !73
  br i1 %cmp8, label %for.body9, label %for.end, !dbg !74

for.body9:                                        ; preds = %for.cond7
  %4 = load i32*, i32** %filter.addr, align 8, !dbg !75
  %5 = load i32, i32* %k1, align 4, !dbg !77
  %mul10 = mul nsw i32 %5, 3, !dbg !78
  %6 = load i32, i32* %k2, align 4, !dbg !79
  %add = add nsw i32 %mul10, %6, !dbg !80
  %idxprom = sext i32 %add to i64, !dbg !75
  %arrayidx = getelementptr inbounds i32, i32* %4, i64 %idxprom, !dbg !75
  %7 = load i32, i32* %arrayidx, align 4, !dbg !75
  %8 = load i32*, i32** %orig.addr, align 8, !dbg !81
  %9 = load i32, i32* %r, align 4, !dbg !82
  %10 = load i32, i32* %k1, align 4, !dbg !83
  %add11 = add nsw i32 %9, %10, !dbg !84
  %mul12 = mul nsw i32 %add11, 64, !dbg !85
  %11 = load i32, i32* %c, align 4, !dbg !86
  %add13 = add nsw i32 %mul12, %11, !dbg !87
  %12 = load i32, i32* %k2, align 4, !dbg !88
  %add14 = add nsw i32 %add13, %12, !dbg !89
  %idxprom15 = sext i32 %add14 to i64, !dbg !81
  %arrayidx16 = getelementptr inbounds i32, i32* %8, i64 %idxprom15, !dbg !81
  %13 = load i32, i32* %arrayidx16, align 4, !dbg !81
  %mul17 = mul nsw i32 %7, %13, !dbg !90
  store i32 %mul17, i32* %mul, align 4, !dbg !91
  %14 = load i32, i32* %mul, align 4, !dbg !92
  %15 = load i32, i32* %temp, align 4, !dbg !93
  %add18 = add nsw i32 %15, %14, !dbg !93
  store i32 %add18, i32* %temp, align 4, !dbg !93
  br label %for.inc, !dbg !94

for.inc:                                          ; preds = %for.body9
  %16 = load i32, i32* %k2, align 4, !dbg !95
  %inc = add nsw i32 %16, 1, !dbg !95
  store i32 %inc, i32* %k2, align 4, !dbg !95
  br label %for.cond7, !dbg !96, !llvm.loop !97

for.end:                                          ; preds = %for.cond7
  br label %for.inc19, !dbg !100

for.inc19:                                        ; preds = %for.end
  %17 = load i32, i32* %k1, align 4, !dbg !101
  %inc20 = add nsw i32 %17, 1, !dbg !101
  store i32 %inc20, i32* %k1, align 4, !dbg !101
  br label %for.cond4, !dbg !102, !llvm.loop !103

for.end21:                                        ; preds = %for.cond4
  %18 = load i32, i32* %temp, align 4, !dbg !105
  %19 = load i32*, i32** %sol.addr, align 8, !dbg !106
  %20 = load i32, i32* %r, align 4, !dbg !107
  %mul22 = mul nsw i32 %20, 64, !dbg !108
  %21 = load i32, i32* %c, align 4, !dbg !109
  %add23 = add nsw i32 %mul22, %21, !dbg !110
  %idxprom24 = sext i32 %add23 to i64, !dbg !106
  %arrayidx25 = getelementptr inbounds i32, i32* %19, i64 %idxprom24, !dbg !106
  store i32 %18, i32* %arrayidx25, align 4, !dbg !111
  br label %for.inc26, !dbg !112

for.inc26:                                        ; preds = %for.end21
  %22 = load i32, i32* %c, align 4, !dbg !113
  %inc27 = add nsw i32 %22, 1, !dbg !113
  store i32 %inc27, i32* %c, align 4, !dbg !113
  br label %for.cond1, !dbg !114, !llvm.loop !115

for.end28:                                        ; preds = %for.cond1
  br label %for.inc29, !dbg !117

for.inc29:                                        ; preds = %for.end28
  %23 = load i32, i32* %r, align 4, !dbg !118
  %inc30 = add nsw i32 %23, 1, !dbg !118
  store i32 %inc30, i32* %r, align 4, !dbg !118
  br label %for.cond, !dbg !119, !llvm.loop !120

for.end31:                                        ; preds = %for.cond
  ret void, !dbg !122
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
!1 = !DIFile(filename: "stencil_stencil2d.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/machsuite/stencil_stencil2d")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "stencil", scope: !1, file: !1, line: 3, type: !10, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !12, !12}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!13 = !DILocalVariable(name: "orig", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!14 = !DILocation(line: 3, column: 18, scope: !9)
!15 = !DILocalVariable(name: "sol", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!16 = !DILocation(line: 3, column: 33, scope: !9)
!17 = !DILocalVariable(name: "filter", arg: 3, scope: !9, file: !1, line: 3, type: !12)
!18 = !DILocation(line: 3, column: 47, scope: !9)
!19 = !DILocalVariable(name: "r", scope: !9, file: !1, line: 5, type: !4)
!20 = !DILocation(line: 5, column: 7, scope: !9)
!21 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 6, type: !4)
!22 = !DILocation(line: 6, column: 7, scope: !9)
!23 = !DILocalVariable(name: "k1", scope: !9, file: !1, line: 7, type: !4)
!24 = !DILocation(line: 7, column: 7, scope: !9)
!25 = !DILocalVariable(name: "k2", scope: !9, file: !1, line: 8, type: !4)
!26 = !DILocation(line: 8, column: 7, scope: !9)
!27 = !DILocalVariable(name: "temp", scope: !9, file: !1, line: 9, type: !4)
!28 = !DILocation(line: 9, column: 7, scope: !9)
!29 = !DILocalVariable(name: "mul", scope: !9, file: !1, line: 10, type: !4)
!30 = !DILocation(line: 10, column: 7, scope: !9)
!31 = !DILocation(line: 10, column: 3, scope: !9)
!32 = !DILabel(scope: !9, name: "stencil_label1", file: !1, line: 17)
!33 = !DILocation(line: 17, column: 3, scope: !9)
!34 = !DILocation(line: 18, column: 10, scope: !35)
!35 = distinct !DILexicalBlock(scope: !9, file: !1, line: 18, column: 3)
!36 = !DILocation(line: 18, column: 8, scope: !35)
!37 = !DILocation(line: 18, column: 15, scope: !38)
!38 = distinct !DILexicalBlock(scope: !35, file: !1, line: 18, column: 3)
!39 = !DILocation(line: 18, column: 17, scope: !38)
!40 = !DILocation(line: 18, column: 3, scope: !35)
!41 = !DILocation(line: 18, column: 33, scope: !38)
!42 = !DILabel(scope: !43, name: "stencil_label2", file: !1, line: 25)
!43 = distinct !DILexicalBlock(scope: !38, file: !1, line: 18, column: 33)
!44 = !DILocation(line: 25, column: 5, scope: !43)
!45 = !DILocation(line: 26, column: 12, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !1, line: 26, column: 5)
!47 = !DILocation(line: 26, column: 10, scope: !46)
!48 = !DILocation(line: 26, column: 17, scope: !49)
!49 = distinct !DILexicalBlock(scope: !46, file: !1, line: 26, column: 5)
!50 = !DILocation(line: 26, column: 19, scope: !49)
!51 = !DILocation(line: 26, column: 5, scope: !46)
!52 = !DILocation(line: 27, column: 12, scope: !53)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 26, column: 34)
!54 = !DILocation(line: 27, column: 7, scope: !53)
!55 = !DILabel(scope: !53, name: "stencil_label3", file: !1, line: 30)
!56 = !DILocation(line: 30, column: 7, scope: !53)
!57 = !DILocation(line: 31, column: 15, scope: !58)
!58 = distinct !DILexicalBlock(scope: !53, file: !1, line: 31, column: 7)
!59 = !DILocation(line: 31, column: 12, scope: !58)
!60 = !DILocation(line: 31, column: 20, scope: !61)
!61 = distinct !DILexicalBlock(scope: !58, file: !1, line: 31, column: 7)
!62 = !DILocation(line: 31, column: 23, scope: !61)
!63 = !DILocation(line: 31, column: 7, scope: !58)
!64 = !DILocation(line: 31, column: 34, scope: !61)
!65 = !DILabel(scope: !66, name: "stencil_label4", file: !1, line: 32)
!66 = distinct !DILexicalBlock(scope: !61, file: !1, line: 31, column: 34)
!67 = !DILocation(line: 32, column: 9, scope: !66)
!68 = !DILocation(line: 33, column: 17, scope: !69)
!69 = distinct !DILexicalBlock(scope: !66, file: !1, line: 33, column: 9)
!70 = !DILocation(line: 33, column: 14, scope: !69)
!71 = !DILocation(line: 33, column: 22, scope: !72)
!72 = distinct !DILexicalBlock(scope: !69, file: !1, line: 33, column: 9)
!73 = !DILocation(line: 33, column: 25, scope: !72)
!74 = !DILocation(line: 33, column: 9, scope: !69)
!75 = !DILocation(line: 34, column: 17, scope: !76)
!76 = distinct !DILexicalBlock(scope: !72, file: !1, line: 33, column: 36)
!77 = !DILocation(line: 34, column: 24, scope: !76)
!78 = !DILocation(line: 34, column: 27, scope: !76)
!79 = !DILocation(line: 34, column: 33, scope: !76)
!80 = !DILocation(line: 34, column: 31, scope: !76)
!81 = !DILocation(line: 34, column: 39, scope: !76)
!82 = !DILocation(line: 34, column: 45, scope: !76)
!83 = !DILocation(line: 34, column: 49, scope: !76)
!84 = !DILocation(line: 34, column: 47, scope: !76)
!85 = !DILocation(line: 34, column: 53, scope: !76)
!86 = !DILocation(line: 34, column: 60, scope: !76)
!87 = !DILocation(line: 34, column: 58, scope: !76)
!88 = !DILocation(line: 34, column: 64, scope: !76)
!89 = !DILocation(line: 34, column: 62, scope: !76)
!90 = !DILocation(line: 34, column: 37, scope: !76)
!91 = !DILocation(line: 34, column: 15, scope: !76)
!92 = !DILocation(line: 35, column: 19, scope: !76)
!93 = !DILocation(line: 35, column: 16, scope: !76)
!94 = !DILocation(line: 36, column: 9, scope: !76)
!95 = !DILocation(line: 33, column: 32, scope: !72)
!96 = !DILocation(line: 33, column: 9, scope: !72)
!97 = distinct !{!97, !74, !98, !99}
!98 = !DILocation(line: 36, column: 9, scope: !69)
!99 = !{!"llvm.loop.mustprogress"}
!100 = !DILocation(line: 37, column: 7, scope: !66)
!101 = !DILocation(line: 31, column: 30, scope: !61)
!102 = !DILocation(line: 31, column: 7, scope: !61)
!103 = distinct !{!103, !63, !104, !99}
!104 = !DILocation(line: 37, column: 7, scope: !58)
!105 = !DILocation(line: 38, column: 25, scope: !53)
!106 = !DILocation(line: 38, column: 7, scope: !53)
!107 = !DILocation(line: 38, column: 11, scope: !53)
!108 = !DILocation(line: 38, column: 13, scope: !53)
!109 = !DILocation(line: 38, column: 20, scope: !53)
!110 = !DILocation(line: 38, column: 18, scope: !53)
!111 = !DILocation(line: 38, column: 23, scope: !53)
!112 = !DILocation(line: 39, column: 5, scope: !53)
!113 = !DILocation(line: 26, column: 30, scope: !49)
!114 = !DILocation(line: 26, column: 5, scope: !49)
!115 = distinct !{!115, !51, !116, !99}
!116 = !DILocation(line: 39, column: 5, scope: !46)
!117 = !DILocation(line: 40, column: 3, scope: !43)
!118 = !DILocation(line: 18, column: 29, scope: !38)
!119 = !DILocation(line: 18, column: 3, scope: !38)
!120 = distinct !{!120, !40, !121, !99}
!121 = !DILocation(line: 40, column: 3, scope: !35)
!122 = !DILocation(line: 41, column: 1, scope: !9)
