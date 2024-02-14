; ModuleID = 'correlation.c'
source_filename = "correlation.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_correlation(double %float_n, [80 x double]* %data, [80 x double]* %corr, double* %mean, double* %stddev) #0 !dbg !9 {
entry:
  %float_n.addr = alloca double, align 8
  %data.addr = alloca [80 x double]*, align 8
  %corr.addr = alloca [80 x double]*, align 8
  %mean.addr = alloca double*, align 8
  %stddev.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %eps = alloca double, align 8
  store double %float_n, double* %float_n.addr, align 8
  call void @llvm.dbg.declare(metadata double* %float_n.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store [80 x double]* %data, [80 x double]** %data.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %data.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store [80 x double]* %corr, [80 x double]** %corr.addr, align 8
  call void @llvm.dbg.declare(metadata [80 x double]** %corr.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store double* %mean, double** %mean.addr, align 8
  call void @llvm.dbg.declare(metadata double** %mean.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store double* %stddev, double** %stddev.addr, align 8
  call void @llvm.dbg.declare(metadata double** %stddev.addr, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %i, metadata !27, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %j, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %k, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata double* %eps, metadata !34, metadata !DIExpression()), !dbg !35
  store double 1.000000e-01, double* %eps, align 8, !dbg !35
  store i32 0, i32* %j, align 4, !dbg !36
  br label %for.cond, !dbg !38

for.cond:                                         ; preds = %for.inc12, %entry
  %0 = load i32, i32* %j, align 4, !dbg !39
  %cmp = icmp slt i32 %0, 80, !dbg !41
  br i1 %cmp, label %for.body, label %for.end14, !dbg !42

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %mean.addr, align 8, !dbg !43
  %2 = load i32, i32* %j, align 4, !dbg !45
  %idxprom = sext i32 %2 to i64, !dbg !43
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !43
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !46
  store i32 0, i32* %i, align 4, !dbg !47
  br label %for.cond1, !dbg !49

for.cond1:                                        ; preds = %for.inc, %for.body
  %3 = load i32, i32* %i, align 4, !dbg !50
  %cmp2 = icmp slt i32 %3, 100, !dbg !52
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !53

for.body3:                                        ; preds = %for.cond1
  %4 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !54
  %5 = load i32, i32* %i, align 4, !dbg !56
  %idxprom4 = sext i32 %5 to i64, !dbg !54
  %arrayidx5 = getelementptr inbounds [80 x double], [80 x double]* %4, i64 %idxprom4, !dbg !54
  %6 = load i32, i32* %j, align 4, !dbg !57
  %idxprom6 = sext i32 %6 to i64, !dbg !54
  %arrayidx7 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx5, i64 0, i64 %idxprom6, !dbg !54
  %7 = load double, double* %arrayidx7, align 8, !dbg !54
  %8 = load double*, double** %mean.addr, align 8, !dbg !58
  %9 = load i32, i32* %j, align 4, !dbg !59
  %idxprom8 = sext i32 %9 to i64, !dbg !58
  %arrayidx9 = getelementptr inbounds double, double* %8, i64 %idxprom8, !dbg !58
  %10 = load double, double* %arrayidx9, align 8, !dbg !60
  %add = fadd double %10, %7, !dbg !60
  store double %add, double* %arrayidx9, align 8, !dbg !60
  br label %for.inc, !dbg !61

for.inc:                                          ; preds = %for.body3
  %11 = load i32, i32* %i, align 4, !dbg !62
  %inc = add nsw i32 %11, 1, !dbg !62
  store i32 %inc, i32* %i, align 4, !dbg !62
  br label %for.cond1, !dbg !63, !llvm.loop !64

for.end:                                          ; preds = %for.cond1
  %12 = load double, double* %float_n.addr, align 8, !dbg !67
  %13 = load double*, double** %mean.addr, align 8, !dbg !68
  %14 = load i32, i32* %j, align 4, !dbg !69
  %idxprom10 = sext i32 %14 to i64, !dbg !68
  %arrayidx11 = getelementptr inbounds double, double* %13, i64 %idxprom10, !dbg !68
  %15 = load double, double* %arrayidx11, align 8, !dbg !70
  %div = fdiv double %15, %12, !dbg !70
  store double %div, double* %arrayidx11, align 8, !dbg !70
  br label %for.inc12, !dbg !71

for.inc12:                                        ; preds = %for.end
  %16 = load i32, i32* %j, align 4, !dbg !72
  %inc13 = add nsw i32 %16, 1, !dbg !72
  store i32 %inc13, i32* %j, align 4, !dbg !72
  br label %for.cond, !dbg !73, !llvm.loop !74

for.end14:                                        ; preds = %for.cond
  store i32 0, i32* %j, align 4, !dbg !76
  br label %for.cond15, !dbg !78

for.cond15:                                       ; preds = %for.inc50, %for.end14
  %17 = load i32, i32* %j, align 4, !dbg !79
  %cmp16 = icmp slt i32 %17, 80, !dbg !81
  br i1 %cmp16, label %for.body17, label %for.end52, !dbg !82

for.body17:                                       ; preds = %for.cond15
  %18 = load double*, double** %stddev.addr, align 8, !dbg !83
  %19 = load i32, i32* %j, align 4, !dbg !85
  %idxprom18 = sext i32 %19 to i64, !dbg !83
  %arrayidx19 = getelementptr inbounds double, double* %18, i64 %idxprom18, !dbg !83
  store double 0.000000e+00, double* %arrayidx19, align 8, !dbg !86
  store i32 0, i32* %i, align 4, !dbg !87
  br label %for.cond20, !dbg !89

for.cond20:                                       ; preds = %for.inc32, %for.body17
  %20 = load i32, i32* %i, align 4, !dbg !90
  %cmp21 = icmp slt i32 %20, 100, !dbg !92
  br i1 %cmp21, label %for.body22, label %for.end34, !dbg !93

for.body22:                                       ; preds = %for.cond20
  %21 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !94
  %22 = load i32, i32* %i, align 4, !dbg !96
  %idxprom23 = sext i32 %22 to i64, !dbg !94
  %arrayidx24 = getelementptr inbounds [80 x double], [80 x double]* %21, i64 %idxprom23, !dbg !94
  %23 = load i32, i32* %j, align 4, !dbg !97
  %idxprom25 = sext i32 %23 to i64, !dbg !94
  %arrayidx26 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !94
  %24 = load double, double* %arrayidx26, align 8, !dbg !94
  %25 = load double*, double** %mean.addr, align 8, !dbg !98
  %26 = load i32, i32* %j, align 4, !dbg !99
  %idxprom27 = sext i32 %26 to i64, !dbg !98
  %arrayidx28 = getelementptr inbounds double, double* %25, i64 %idxprom27, !dbg !98
  %27 = load double, double* %arrayidx28, align 8, !dbg !98
  %sub = fsub double %24, %27, !dbg !100
  %call = call double @pow(double %sub, double 2.000000e+00) #3, !dbg !101
  %28 = load double*, double** %stddev.addr, align 8, !dbg !102
  %29 = load i32, i32* %j, align 4, !dbg !103
  %idxprom29 = sext i32 %29 to i64, !dbg !102
  %arrayidx30 = getelementptr inbounds double, double* %28, i64 %idxprom29, !dbg !102
  %30 = load double, double* %arrayidx30, align 8, !dbg !104
  %add31 = fadd double %30, %call, !dbg !104
  store double %add31, double* %arrayidx30, align 8, !dbg !104
  br label %for.inc32, !dbg !105

for.inc32:                                        ; preds = %for.body22
  %31 = load i32, i32* %i, align 4, !dbg !106
  %inc33 = add nsw i32 %31, 1, !dbg !106
  store i32 %inc33, i32* %i, align 4, !dbg !106
  br label %for.cond20, !dbg !107, !llvm.loop !108

for.end34:                                        ; preds = %for.cond20
  %32 = load double, double* %float_n.addr, align 8, !dbg !110
  %33 = load double*, double** %stddev.addr, align 8, !dbg !111
  %34 = load i32, i32* %j, align 4, !dbg !112
  %idxprom35 = sext i32 %34 to i64, !dbg !111
  %arrayidx36 = getelementptr inbounds double, double* %33, i64 %idxprom35, !dbg !111
  %35 = load double, double* %arrayidx36, align 8, !dbg !113
  %div37 = fdiv double %35, %32, !dbg !113
  store double %div37, double* %arrayidx36, align 8, !dbg !113
  %36 = load double*, double** %stddev.addr, align 8, !dbg !114
  %37 = load i32, i32* %j, align 4, !dbg !115
  %idxprom38 = sext i32 %37 to i64, !dbg !114
  %arrayidx39 = getelementptr inbounds double, double* %36, i64 %idxprom38, !dbg !114
  %38 = load double, double* %arrayidx39, align 8, !dbg !114
  %call40 = call double @sqrt(double %38) #3, !dbg !116
  %39 = load double*, double** %stddev.addr, align 8, !dbg !117
  %40 = load i32, i32* %j, align 4, !dbg !118
  %idxprom41 = sext i32 %40 to i64, !dbg !117
  %arrayidx42 = getelementptr inbounds double, double* %39, i64 %idxprom41, !dbg !117
  store double %call40, double* %arrayidx42, align 8, !dbg !119
  %41 = load double*, double** %stddev.addr, align 8, !dbg !120
  %42 = load i32, i32* %j, align 4, !dbg !121
  %idxprom43 = sext i32 %42 to i64, !dbg !120
  %arrayidx44 = getelementptr inbounds double, double* %41, i64 %idxprom43, !dbg !120
  %43 = load double, double* %arrayidx44, align 8, !dbg !120
  %44 = load double, double* %eps, align 8, !dbg !122
  %cmp45 = fcmp ole double %43, %44, !dbg !123
  br i1 %cmp45, label %cond.true, label %cond.false, !dbg !120

cond.true:                                        ; preds = %for.end34
  br label %cond.end, !dbg !120

cond.false:                                       ; preds = %for.end34
  %45 = load double*, double** %stddev.addr, align 8, !dbg !124
  %46 = load i32, i32* %j, align 4, !dbg !125
  %idxprom46 = sext i32 %46 to i64, !dbg !124
  %arrayidx47 = getelementptr inbounds double, double* %45, i64 %idxprom46, !dbg !124
  %47 = load double, double* %arrayidx47, align 8, !dbg !124
  br label %cond.end, !dbg !120

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi double [ 1.000000e+00, %cond.true ], [ %47, %cond.false ], !dbg !120
  %48 = load double*, double** %stddev.addr, align 8, !dbg !126
  %49 = load i32, i32* %j, align 4, !dbg !127
  %idxprom48 = sext i32 %49 to i64, !dbg !126
  %arrayidx49 = getelementptr inbounds double, double* %48, i64 %idxprom48, !dbg !126
  store double %cond, double* %arrayidx49, align 8, !dbg !128
  br label %for.inc50, !dbg !129

for.inc50:                                        ; preds = %cond.end
  %50 = load i32, i32* %j, align 4, !dbg !130
  %inc51 = add nsw i32 %50, 1, !dbg !130
  store i32 %inc51, i32* %j, align 4, !dbg !130
  br label %for.cond15, !dbg !131, !llvm.loop !132

for.end52:                                        ; preds = %for.cond15
  store i32 0, i32* %i, align 4, !dbg !134
  br label %for.cond53, !dbg !136

for.cond53:                                       ; preds = %for.inc77, %for.end52
  %51 = load i32, i32* %i, align 4, !dbg !137
  %cmp54 = icmp slt i32 %51, 100, !dbg !139
  br i1 %cmp54, label %for.body55, label %for.end79, !dbg !140

for.body55:                                       ; preds = %for.cond53
  store i32 0, i32* %j, align 4, !dbg !141
  br label %for.cond56, !dbg !144

for.cond56:                                       ; preds = %for.inc74, %for.body55
  %52 = load i32, i32* %j, align 4, !dbg !145
  %cmp57 = icmp slt i32 %52, 80, !dbg !147
  br i1 %cmp57, label %for.body58, label %for.end76, !dbg !148

for.body58:                                       ; preds = %for.cond56
  %53 = load double*, double** %mean.addr, align 8, !dbg !149
  %54 = load i32, i32* %j, align 4, !dbg !151
  %idxprom59 = sext i32 %54 to i64, !dbg !149
  %arrayidx60 = getelementptr inbounds double, double* %53, i64 %idxprom59, !dbg !149
  %55 = load double, double* %arrayidx60, align 8, !dbg !149
  %56 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !152
  %57 = load i32, i32* %i, align 4, !dbg !153
  %idxprom61 = sext i32 %57 to i64, !dbg !152
  %arrayidx62 = getelementptr inbounds [80 x double], [80 x double]* %56, i64 %idxprom61, !dbg !152
  %58 = load i32, i32* %j, align 4, !dbg !154
  %idxprom63 = sext i32 %58 to i64, !dbg !152
  %arrayidx64 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx62, i64 0, i64 %idxprom63, !dbg !152
  %59 = load double, double* %arrayidx64, align 8, !dbg !155
  %sub65 = fsub double %59, %55, !dbg !155
  store double %sub65, double* %arrayidx64, align 8, !dbg !155
  %60 = load double, double* %float_n.addr, align 8, !dbg !156
  %call66 = call double @sqrt(double %60) #3, !dbg !157
  %61 = load double*, double** %stddev.addr, align 8, !dbg !158
  %62 = load i32, i32* %j, align 4, !dbg !159
  %idxprom67 = sext i32 %62 to i64, !dbg !158
  %arrayidx68 = getelementptr inbounds double, double* %61, i64 %idxprom67, !dbg !158
  %63 = load double, double* %arrayidx68, align 8, !dbg !158
  %mul = fmul double %call66, %63, !dbg !160
  %64 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !161
  %65 = load i32, i32* %i, align 4, !dbg !162
  %idxprom69 = sext i32 %65 to i64, !dbg !161
  %arrayidx70 = getelementptr inbounds [80 x double], [80 x double]* %64, i64 %idxprom69, !dbg !161
  %66 = load i32, i32* %j, align 4, !dbg !163
  %idxprom71 = sext i32 %66 to i64, !dbg !161
  %arrayidx72 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx70, i64 0, i64 %idxprom71, !dbg !161
  %67 = load double, double* %arrayidx72, align 8, !dbg !164
  %div73 = fdiv double %67, %mul, !dbg !164
  store double %div73, double* %arrayidx72, align 8, !dbg !164
  br label %for.inc74, !dbg !165

for.inc74:                                        ; preds = %for.body58
  %68 = load i32, i32* %j, align 4, !dbg !166
  %inc75 = add nsw i32 %68, 1, !dbg !166
  store i32 %inc75, i32* %j, align 4, !dbg !166
  br label %for.cond56, !dbg !167, !llvm.loop !168

for.end76:                                        ; preds = %for.cond56
  br label %for.inc77, !dbg !170

for.inc77:                                        ; preds = %for.end76
  %69 = load i32, i32* %i, align 4, !dbg !171
  %inc78 = add nsw i32 %69, 1, !dbg !171
  store i32 %inc78, i32* %i, align 4, !dbg !171
  br label %for.cond53, !dbg !172, !llvm.loop !173

for.end79:                                        ; preds = %for.cond53
  store i32 0, i32* %i, align 4, !dbg !175
  br label %for.cond80, !dbg !177

for.cond80:                                       ; preds = %for.inc126, %for.end79
  %70 = load i32, i32* %i, align 4, !dbg !178
  %cmp81 = icmp slt i32 %70, 79, !dbg !180
  br i1 %cmp81, label %for.body82, label %for.end128, !dbg !181

for.body82:                                       ; preds = %for.cond80
  %71 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !182
  %72 = load i32, i32* %i, align 4, !dbg !184
  %idxprom83 = sext i32 %72 to i64, !dbg !182
  %arrayidx84 = getelementptr inbounds [80 x double], [80 x double]* %71, i64 %idxprom83, !dbg !182
  %73 = load i32, i32* %i, align 4, !dbg !185
  %idxprom85 = sext i32 %73 to i64, !dbg !182
  %arrayidx86 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx84, i64 0, i64 %idxprom85, !dbg !182
  store double 1.000000e+00, double* %arrayidx86, align 8, !dbg !186
  %74 = load i32, i32* %i, align 4, !dbg !187
  %add87 = add nsw i32 %74, 1, !dbg !189
  store i32 %add87, i32* %j, align 4, !dbg !190
  br label %for.cond88, !dbg !191

for.cond88:                                       ; preds = %for.inc123, %for.body82
  %75 = load i32, i32* %j, align 4, !dbg !192
  %cmp89 = icmp slt i32 %75, 80, !dbg !194
  br i1 %cmp89, label %for.body90, label %for.end125, !dbg !195

for.body90:                                       ; preds = %for.cond88
  %76 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !196
  %77 = load i32, i32* %i, align 4, !dbg !198
  %idxprom91 = sext i32 %77 to i64, !dbg !196
  %arrayidx92 = getelementptr inbounds [80 x double], [80 x double]* %76, i64 %idxprom91, !dbg !196
  %78 = load i32, i32* %j, align 4, !dbg !199
  %idxprom93 = sext i32 %78 to i64, !dbg !196
  %arrayidx94 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx92, i64 0, i64 %idxprom93, !dbg !196
  store double 0.000000e+00, double* %arrayidx94, align 8, !dbg !200
  store i32 0, i32* %k, align 4, !dbg !201
  br label %for.cond95, !dbg !203

for.cond95:                                       ; preds = %for.inc112, %for.body90
  %79 = load i32, i32* %k, align 4, !dbg !204
  %cmp96 = icmp slt i32 %79, 100, !dbg !206
  br i1 %cmp96, label %for.body97, label %for.end114, !dbg !207

for.body97:                                       ; preds = %for.cond95
  %80 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !208
  %81 = load i32, i32* %k, align 4, !dbg !210
  %idxprom98 = sext i32 %81 to i64, !dbg !208
  %arrayidx99 = getelementptr inbounds [80 x double], [80 x double]* %80, i64 %idxprom98, !dbg !208
  %82 = load i32, i32* %i, align 4, !dbg !211
  %idxprom100 = sext i32 %82 to i64, !dbg !208
  %arrayidx101 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx99, i64 0, i64 %idxprom100, !dbg !208
  %83 = load double, double* %arrayidx101, align 8, !dbg !208
  %84 = load [80 x double]*, [80 x double]** %data.addr, align 8, !dbg !212
  %85 = load i32, i32* %k, align 4, !dbg !213
  %idxprom102 = sext i32 %85 to i64, !dbg !212
  %arrayidx103 = getelementptr inbounds [80 x double], [80 x double]* %84, i64 %idxprom102, !dbg !212
  %86 = load i32, i32* %j, align 4, !dbg !214
  %idxprom104 = sext i32 %86 to i64, !dbg !212
  %arrayidx105 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx103, i64 0, i64 %idxprom104, !dbg !212
  %87 = load double, double* %arrayidx105, align 8, !dbg !212
  %mul106 = fmul double %83, %87, !dbg !215
  %88 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !216
  %89 = load i32, i32* %i, align 4, !dbg !217
  %idxprom107 = sext i32 %89 to i64, !dbg !216
  %arrayidx108 = getelementptr inbounds [80 x double], [80 x double]* %88, i64 %idxprom107, !dbg !216
  %90 = load i32, i32* %j, align 4, !dbg !218
  %idxprom109 = sext i32 %90 to i64, !dbg !216
  %arrayidx110 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx108, i64 0, i64 %idxprom109, !dbg !216
  %91 = load double, double* %arrayidx110, align 8, !dbg !219
  %add111 = fadd double %91, %mul106, !dbg !219
  store double %add111, double* %arrayidx110, align 8, !dbg !219
  br label %for.inc112, !dbg !220

for.inc112:                                       ; preds = %for.body97
  %92 = load i32, i32* %k, align 4, !dbg !221
  %inc113 = add nsw i32 %92, 1, !dbg !221
  store i32 %inc113, i32* %k, align 4, !dbg !221
  br label %for.cond95, !dbg !222, !llvm.loop !223

for.end114:                                       ; preds = %for.cond95
  %93 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !225
  %94 = load i32, i32* %i, align 4, !dbg !226
  %idxprom115 = sext i32 %94 to i64, !dbg !225
  %arrayidx116 = getelementptr inbounds [80 x double], [80 x double]* %93, i64 %idxprom115, !dbg !225
  %95 = load i32, i32* %j, align 4, !dbg !227
  %idxprom117 = sext i32 %95 to i64, !dbg !225
  %arrayidx118 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx116, i64 0, i64 %idxprom117, !dbg !225
  %96 = load double, double* %arrayidx118, align 8, !dbg !225
  %97 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !228
  %98 = load i32, i32* %j, align 4, !dbg !229
  %idxprom119 = sext i32 %98 to i64, !dbg !228
  %arrayidx120 = getelementptr inbounds [80 x double], [80 x double]* %97, i64 %idxprom119, !dbg !228
  %99 = load i32, i32* %i, align 4, !dbg !230
  %idxprom121 = sext i32 %99 to i64, !dbg !228
  %arrayidx122 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx120, i64 0, i64 %idxprom121, !dbg !228
  store double %96, double* %arrayidx122, align 8, !dbg !231
  br label %for.inc123, !dbg !232

for.inc123:                                       ; preds = %for.end114
  %100 = load i32, i32* %j, align 4, !dbg !233
  %inc124 = add nsw i32 %100, 1, !dbg !233
  store i32 %inc124, i32* %j, align 4, !dbg !233
  br label %for.cond88, !dbg !234, !llvm.loop !235

for.end125:                                       ; preds = %for.cond88
  br label %for.inc126, !dbg !237

for.inc126:                                       ; preds = %for.end125
  %101 = load i32, i32* %i, align 4, !dbg !238
  %inc127 = add nsw i32 %101, 1, !dbg !238
  store i32 %inc127, i32* %i, align 4, !dbg !238
  br label %for.cond80, !dbg !239, !llvm.loop !240

for.end128:                                       ; preds = %for.cond80
  %102 = load [80 x double]*, [80 x double]** %corr.addr, align 8, !dbg !242
  %arrayidx129 = getelementptr inbounds [80 x double], [80 x double]* %102, i64 79, !dbg !242
  %arrayidx130 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx129, i64 0, i64 79, !dbg !242
  store double 1.000000e+00, double* %arrayidx130, align 8, !dbg !243
  ret void, !dbg !244
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local double @pow(double, double) #2

; Function Attrs: nounwind
declare dso_local double @sqrt(double) #2

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "correlation.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/poly/correlation")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!9 = distinct !DISubprogram(name: "kernel_correlation", scope: !1, file: !1, line: 4, type: !10, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !4, !12, !12, !16, !16}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 5120, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 80)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!17 = !DILocalVariable(name: "float_n", arg: 1, scope: !9, file: !1, line: 4, type: !4)
!18 = !DILocation(line: 4, column: 32, scope: !9)
!19 = !DILocalVariable(name: "data", arg: 2, scope: !9, file: !1, line: 4, type: !12)
!20 = !DILocation(line: 4, column: 47, scope: !9)
!21 = !DILocalVariable(name: "corr", arg: 3, scope: !9, file: !1, line: 4, type: !12)
!22 = !DILocation(line: 4, column: 68, scope: !9)
!23 = !DILocalVariable(name: "mean", arg: 4, scope: !9, file: !1, line: 4, type: !16)
!24 = !DILocation(line: 4, column: 88, scope: !9)
!25 = !DILocalVariable(name: "stddev", arg: 5, scope: !9, file: !1, line: 4, type: !16)
!26 = !DILocation(line: 4, column: 104, scope: !9)
!27 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 6, type: !28)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !DILocation(line: 6, column: 7, scope: !9)
!30 = !DILocalVariable(name: "j", scope: !9, file: !1, line: 7, type: !28)
!31 = !DILocation(line: 7, column: 7, scope: !9)
!32 = !DILocalVariable(name: "k", scope: !9, file: !1, line: 8, type: !28)
!33 = !DILocation(line: 8, column: 7, scope: !9)
!34 = !DILocalVariable(name: "eps", scope: !9, file: !1, line: 9, type: !4)
!35 = !DILocation(line: 9, column: 10, scope: !9)
!36 = !DILocation(line: 16, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !9, file: !1, line: 16, column: 3)
!38 = !DILocation(line: 16, column: 8, scope: !37)
!39 = !DILocation(line: 16, column: 15, scope: !40)
!40 = distinct !DILexicalBlock(scope: !37, file: !1, line: 16, column: 3)
!41 = !DILocation(line: 16, column: 17, scope: !40)
!42 = !DILocation(line: 16, column: 3, scope: !37)
!43 = !DILocation(line: 17, column: 5, scope: !44)
!44 = distinct !DILexicalBlock(scope: !40, file: !1, line: 16, column: 28)
!45 = !DILocation(line: 17, column: 10, scope: !44)
!46 = !DILocation(line: 17, column: 13, scope: !44)
!47 = !DILocation(line: 20, column: 12, scope: !48)
!48 = distinct !DILexicalBlock(scope: !44, file: !1, line: 20, column: 5)
!49 = !DILocation(line: 20, column: 10, scope: !48)
!50 = !DILocation(line: 20, column: 17, scope: !51)
!51 = distinct !DILexicalBlock(scope: !48, file: !1, line: 20, column: 5)
!52 = !DILocation(line: 20, column: 19, scope: !51)
!53 = !DILocation(line: 20, column: 5, scope: !48)
!54 = !DILocation(line: 21, column: 18, scope: !55)
!55 = distinct !DILexicalBlock(scope: !51, file: !1, line: 20, column: 31)
!56 = !DILocation(line: 21, column: 23, scope: !55)
!57 = !DILocation(line: 21, column: 26, scope: !55)
!58 = !DILocation(line: 21, column: 7, scope: !55)
!59 = !DILocation(line: 21, column: 12, scope: !55)
!60 = !DILocation(line: 21, column: 15, scope: !55)
!61 = !DILocation(line: 22, column: 5, scope: !55)
!62 = !DILocation(line: 20, column: 27, scope: !51)
!63 = !DILocation(line: 20, column: 5, scope: !51)
!64 = distinct !{!64, !53, !65, !66}
!65 = !DILocation(line: 22, column: 5, scope: !48)
!66 = !{!"llvm.loop.mustprogress"}
!67 = !DILocation(line: 23, column: 16, scope: !44)
!68 = !DILocation(line: 23, column: 5, scope: !44)
!69 = !DILocation(line: 23, column: 10, scope: !44)
!70 = !DILocation(line: 23, column: 13, scope: !44)
!71 = !DILocation(line: 24, column: 3, scope: !44)
!72 = !DILocation(line: 16, column: 24, scope: !40)
!73 = !DILocation(line: 16, column: 3, scope: !40)
!74 = distinct !{!74, !42, !75, !66}
!75 = !DILocation(line: 24, column: 3, scope: !37)
!76 = !DILocation(line: 31, column: 10, scope: !77)
!77 = distinct !DILexicalBlock(scope: !9, file: !1, line: 31, column: 3)
!78 = !DILocation(line: 31, column: 8, scope: !77)
!79 = !DILocation(line: 31, column: 15, scope: !80)
!80 = distinct !DILexicalBlock(scope: !77, file: !1, line: 31, column: 3)
!81 = !DILocation(line: 31, column: 17, scope: !80)
!82 = !DILocation(line: 31, column: 3, scope: !77)
!83 = !DILocation(line: 32, column: 5, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 31, column: 28)
!85 = !DILocation(line: 32, column: 12, scope: !84)
!86 = !DILocation(line: 32, column: 15, scope: !84)
!87 = !DILocation(line: 35, column: 12, scope: !88)
!88 = distinct !DILexicalBlock(scope: !84, file: !1, line: 35, column: 5)
!89 = !DILocation(line: 35, column: 10, scope: !88)
!90 = !DILocation(line: 35, column: 17, scope: !91)
!91 = distinct !DILexicalBlock(scope: !88, file: !1, line: 35, column: 5)
!92 = !DILocation(line: 35, column: 19, scope: !91)
!93 = !DILocation(line: 35, column: 5, scope: !88)
!94 = !DILocation(line: 36, column: 24, scope: !95)
!95 = distinct !DILexicalBlock(scope: !91, file: !1, line: 35, column: 31)
!96 = !DILocation(line: 36, column: 29, scope: !95)
!97 = !DILocation(line: 36, column: 32, scope: !95)
!98 = !DILocation(line: 36, column: 37, scope: !95)
!99 = !DILocation(line: 36, column: 42, scope: !95)
!100 = !DILocation(line: 36, column: 35, scope: !95)
!101 = !DILocation(line: 36, column: 20, scope: !95)
!102 = !DILocation(line: 36, column: 7, scope: !95)
!103 = !DILocation(line: 36, column: 14, scope: !95)
!104 = !DILocation(line: 36, column: 17, scope: !95)
!105 = !DILocation(line: 37, column: 5, scope: !95)
!106 = !DILocation(line: 35, column: 27, scope: !91)
!107 = !DILocation(line: 35, column: 5, scope: !91)
!108 = distinct !{!108, !93, !109, !66}
!109 = !DILocation(line: 37, column: 5, scope: !88)
!110 = !DILocation(line: 38, column: 18, scope: !84)
!111 = !DILocation(line: 38, column: 5, scope: !84)
!112 = !DILocation(line: 38, column: 12, scope: !84)
!113 = !DILocation(line: 38, column: 15, scope: !84)
!114 = !DILocation(line: 39, column: 22, scope: !84)
!115 = !DILocation(line: 39, column: 29, scope: !84)
!116 = !DILocation(line: 39, column: 17, scope: !84)
!117 = !DILocation(line: 39, column: 5, scope: !84)
!118 = !DILocation(line: 39, column: 12, scope: !84)
!119 = !DILocation(line: 39, column: 15, scope: !84)
!120 = !DILocation(line: 43, column: 18, scope: !84)
!121 = !DILocation(line: 43, column: 25, scope: !84)
!122 = !DILocation(line: 43, column: 31, scope: !84)
!123 = !DILocation(line: 43, column: 28, scope: !84)
!124 = !DILocation(line: 43, column: 41, scope: !84)
!125 = !DILocation(line: 43, column: 48, scope: !84)
!126 = !DILocation(line: 43, column: 5, scope: !84)
!127 = !DILocation(line: 43, column: 12, scope: !84)
!128 = !DILocation(line: 43, column: 15, scope: !84)
!129 = !DILocation(line: 44, column: 3, scope: !84)
!130 = !DILocation(line: 31, column: 24, scope: !80)
!131 = !DILocation(line: 31, column: 3, scope: !80)
!132 = distinct !{!132, !82, !133, !66}
!133 = !DILocation(line: 44, column: 3, scope: !77)
!134 = !DILocation(line: 52, column: 10, scope: !135)
!135 = distinct !DILexicalBlock(scope: !9, file: !1, line: 52, column: 3)
!136 = !DILocation(line: 52, column: 8, scope: !135)
!137 = !DILocation(line: 52, column: 15, scope: !138)
!138 = distinct !DILexicalBlock(scope: !135, file: !1, line: 52, column: 3)
!139 = !DILocation(line: 52, column: 17, scope: !138)
!140 = !DILocation(line: 52, column: 3, scope: !135)
!141 = !DILocation(line: 55, column: 12, scope: !142)
!142 = distinct !DILexicalBlock(scope: !143, file: !1, line: 55, column: 5)
!143 = distinct !DILexicalBlock(scope: !138, file: !1, line: 52, column: 29)
!144 = !DILocation(line: 55, column: 10, scope: !142)
!145 = !DILocation(line: 55, column: 17, scope: !146)
!146 = distinct !DILexicalBlock(scope: !142, file: !1, line: 55, column: 5)
!147 = !DILocation(line: 55, column: 19, scope: !146)
!148 = !DILocation(line: 55, column: 5, scope: !142)
!149 = !DILocation(line: 56, column: 21, scope: !150)
!150 = distinct !DILexicalBlock(scope: !146, file: !1, line: 55, column: 30)
!151 = !DILocation(line: 56, column: 26, scope: !150)
!152 = !DILocation(line: 56, column: 7, scope: !150)
!153 = !DILocation(line: 56, column: 12, scope: !150)
!154 = !DILocation(line: 56, column: 15, scope: !150)
!155 = !DILocation(line: 56, column: 18, scope: !150)
!156 = !DILocation(line: 57, column: 26, scope: !150)
!157 = !DILocation(line: 57, column: 21, scope: !150)
!158 = !DILocation(line: 57, column: 37, scope: !150)
!159 = !DILocation(line: 57, column: 44, scope: !150)
!160 = !DILocation(line: 57, column: 35, scope: !150)
!161 = !DILocation(line: 57, column: 7, scope: !150)
!162 = !DILocation(line: 57, column: 12, scope: !150)
!163 = !DILocation(line: 57, column: 15, scope: !150)
!164 = !DILocation(line: 57, column: 18, scope: !150)
!165 = !DILocation(line: 58, column: 5, scope: !150)
!166 = !DILocation(line: 55, column: 26, scope: !146)
!167 = !DILocation(line: 55, column: 5, scope: !146)
!168 = distinct !{!168, !148, !169, !66}
!169 = !DILocation(line: 58, column: 5, scope: !142)
!170 = !DILocation(line: 59, column: 3, scope: !143)
!171 = !DILocation(line: 52, column: 25, scope: !138)
!172 = !DILocation(line: 52, column: 3, scope: !138)
!173 = distinct !{!173, !140, !174, !66}
!174 = !DILocation(line: 59, column: 3, scope: !135)
!175 = !DILocation(line: 67, column: 10, scope: !176)
!176 = distinct !DILexicalBlock(scope: !9, file: !1, line: 67, column: 3)
!177 = !DILocation(line: 67, column: 8, scope: !176)
!178 = !DILocation(line: 67, column: 15, scope: !179)
!179 = distinct !DILexicalBlock(scope: !176, file: !1, line: 67, column: 3)
!180 = !DILocation(line: 67, column: 17, scope: !179)
!181 = !DILocation(line: 67, column: 3, scope: !176)
!182 = !DILocation(line: 68, column: 5, scope: !183)
!183 = distinct !DILexicalBlock(scope: !179, file: !1, line: 67, column: 32)
!184 = !DILocation(line: 68, column: 10, scope: !183)
!185 = !DILocation(line: 68, column: 13, scope: !183)
!186 = !DILocation(line: 68, column: 16, scope: !183)
!187 = !DILocation(line: 71, column: 14, scope: !188)
!188 = distinct !DILexicalBlock(scope: !183, file: !1, line: 71, column: 5)
!189 = !DILocation(line: 71, column: 16, scope: !188)
!190 = !DILocation(line: 71, column: 12, scope: !188)
!191 = !DILocation(line: 71, column: 10, scope: !188)
!192 = !DILocation(line: 71, column: 21, scope: !193)
!193 = distinct !DILexicalBlock(scope: !188, file: !1, line: 71, column: 5)
!194 = !DILocation(line: 71, column: 23, scope: !193)
!195 = !DILocation(line: 71, column: 5, scope: !188)
!196 = !DILocation(line: 72, column: 7, scope: !197)
!197 = distinct !DILexicalBlock(scope: !193, file: !1, line: 71, column: 34)
!198 = !DILocation(line: 72, column: 12, scope: !197)
!199 = !DILocation(line: 72, column: 15, scope: !197)
!200 = !DILocation(line: 72, column: 18, scope: !197)
!201 = !DILocation(line: 75, column: 14, scope: !202)
!202 = distinct !DILexicalBlock(scope: !197, file: !1, line: 75, column: 7)
!203 = !DILocation(line: 75, column: 12, scope: !202)
!204 = !DILocation(line: 75, column: 19, scope: !205)
!205 = distinct !DILexicalBlock(scope: !202, file: !1, line: 75, column: 7)
!206 = !DILocation(line: 75, column: 21, scope: !205)
!207 = !DILocation(line: 75, column: 7, scope: !202)
!208 = !DILocation(line: 76, column: 23, scope: !209)
!209 = distinct !DILexicalBlock(scope: !205, file: !1, line: 75, column: 33)
!210 = !DILocation(line: 76, column: 28, scope: !209)
!211 = !DILocation(line: 76, column: 31, scope: !209)
!212 = !DILocation(line: 76, column: 36, scope: !209)
!213 = !DILocation(line: 76, column: 41, scope: !209)
!214 = !DILocation(line: 76, column: 44, scope: !209)
!215 = !DILocation(line: 76, column: 34, scope: !209)
!216 = !DILocation(line: 76, column: 9, scope: !209)
!217 = !DILocation(line: 76, column: 14, scope: !209)
!218 = !DILocation(line: 76, column: 17, scope: !209)
!219 = !DILocation(line: 76, column: 20, scope: !209)
!220 = !DILocation(line: 77, column: 7, scope: !209)
!221 = !DILocation(line: 75, column: 29, scope: !205)
!222 = !DILocation(line: 75, column: 7, scope: !205)
!223 = distinct !{!223, !207, !224, !66}
!224 = !DILocation(line: 77, column: 7, scope: !202)
!225 = !DILocation(line: 78, column: 20, scope: !197)
!226 = !DILocation(line: 78, column: 25, scope: !197)
!227 = !DILocation(line: 78, column: 28, scope: !197)
!228 = !DILocation(line: 78, column: 7, scope: !197)
!229 = !DILocation(line: 78, column: 12, scope: !197)
!230 = !DILocation(line: 78, column: 15, scope: !197)
!231 = !DILocation(line: 78, column: 18, scope: !197)
!232 = !DILocation(line: 79, column: 5, scope: !197)
!233 = !DILocation(line: 71, column: 30, scope: !193)
!234 = !DILocation(line: 71, column: 5, scope: !193)
!235 = distinct !{!235, !195, !236, !66}
!236 = !DILocation(line: 79, column: 5, scope: !188)
!237 = !DILocation(line: 80, column: 3, scope: !183)
!238 = !DILocation(line: 67, column: 28, scope: !179)
!239 = !DILocation(line: 67, column: 3, scope: !179)
!240 = distinct !{!240, !181, !241, !66}
!241 = !DILocation(line: 80, column: 3, scope: !176)
!242 = !DILocation(line: 81, column: 3, scope: !9)
!243 = !DILocation(line: 81, column: 24, scope: !9)
!244 = !DILocation(line: 82, column: 1, scope: !9)
