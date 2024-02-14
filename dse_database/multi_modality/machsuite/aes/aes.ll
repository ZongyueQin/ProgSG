; ModuleID = 'aes.c'
source_filename = "aes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.aes256_context = type { [32 x i8], [32 x i8], [32 x i8] }

@sbox = dso_local constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aes256_encrypt_ecb(%struct.aes256_context* %ctx, i8* %k, i8* %buf) #0 !dbg !17 {
entry:
  %ctx.addr = alloca %struct.aes256_context*, align 8
  %k.addr = alloca i8*, align 8
  %buf.addr = alloca i8*, align 8
  %rcon = alloca i8, align 1
  %i = alloca i8, align 1
  %_s_i_0 = alloca i32, align 4
  %_s_i = alloca i32, align 4
  store %struct.aes256_context* %ctx, %struct.aes256_context** %ctx.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.aes256_context** %ctx.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i8* %k, i8** %k.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %k.addr, metadata !33, metadata !DIExpression()), !dbg !34
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata i8* %rcon, metadata !37, metadata !DIExpression()), !dbg !38
  store i8 1, i8* %rcon, align 1, !dbg !38
  call void @llvm.dbg.declare(metadata i8* %i, metadata !39, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata i32* %_s_i_0, metadata !41, metadata !DIExpression()), !dbg !42
  br label %ecb1, !dbg !43

ecb1:                                             ; preds = %entry
  call void @llvm.dbg.label(metadata !44), !dbg !45
  store i32 0, i32* %_s_i_0, align 4, !dbg !46
  br label %for.cond, !dbg !48

for.cond:                                         ; preds = %for.inc, %ecb1
  %0 = load i32, i32* %_s_i_0, align 4, !dbg !49
  %cmp = icmp sle i32 %0, 31, !dbg !51
  br i1 %cmp, label %for.body, label %for.end, !dbg !52

for.body:                                         ; preds = %for.cond
  %1 = load i8*, i8** %k.addr, align 8, !dbg !53
  %2 = load i32, i32* %_s_i_0, align 4, !dbg !55
  %idxprom = sext i32 %2 to i64, !dbg !53
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom, !dbg !53
  %3 = load i8, i8* %arrayidx, align 1, !dbg !53
  %4 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !56
  %deckey = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %4, i32 0, i32 2, !dbg !57
  %5 = load i32, i32* %_s_i_0, align 4, !dbg !58
  %idxprom1 = sext i32 %5 to i64, !dbg !56
  %arrayidx2 = getelementptr inbounds [32 x i8], [32 x i8]* %deckey, i64 0, i64 %idxprom1, !dbg !56
  store i8 %3, i8* %arrayidx2, align 1, !dbg !59
  %6 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !60
  %enckey = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %6, i32 0, i32 1, !dbg !61
  %7 = load i32, i32* %_s_i_0, align 4, !dbg !62
  %idxprom3 = sext i32 %7 to i64, !dbg !60
  %arrayidx4 = getelementptr inbounds [32 x i8], [32 x i8]* %enckey, i64 0, i64 %idxprom3, !dbg !60
  store i8 %3, i8* %arrayidx4, align 1, !dbg !63
  br label %for.inc, !dbg !64

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %_s_i_0, align 4, !dbg !65
  %inc = add nsw i32 %8, 1, !dbg !65
  store i32 %inc, i32* %_s_i_0, align 4, !dbg !65
  br label %for.cond, !dbg !66, !llvm.loop !67

for.end:                                          ; preds = %for.cond
  %9 = load i32, i32* %_s_i_0, align 4, !dbg !70
  %conv = trunc i32 %9 to i8, !dbg !70
  store i8 %conv, i8* %i, align 1, !dbg !71
  br label %ecb2, !dbg !72

ecb2:                                             ; preds = %for.end
  call void @llvm.dbg.label(metadata !73), !dbg !74
  store i8 8, i8* %i, align 1, !dbg !75
  br label %for.cond5, !dbg !77

for.cond5:                                        ; preds = %for.body6, %ecb2
  %10 = load i8, i8* %i, align 1, !dbg !78
  %dec = add i8 %10, -1, !dbg !78
  store i8 %dec, i8* %i, align 1, !dbg !78
  %tobool = icmp ne i8 %dec, 0, !dbg !80
  br i1 %tobool, label %for.body6, label %for.end8, !dbg !80

for.body6:                                        ; preds = %for.cond5
  %11 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !81
  %deckey7 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %11, i32 0, i32 2, !dbg !83
  %arraydecay = getelementptr inbounds [32 x i8], [32 x i8]* %deckey7, i64 0, i64 0, !dbg !81
  call void @aes_expandEncKey_1(i8* %arraydecay, i8* %rcon), !dbg !84
  br label %for.cond5, !dbg !85, !llvm.loop !86

for.end8:                                         ; preds = %for.cond5
  %12 = load i8*, i8** %buf.addr, align 8, !dbg !88
  %13 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !89
  %enckey9 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %13, i32 0, i32 1, !dbg !90
  %arraydecay10 = getelementptr inbounds [32 x i8], [32 x i8]* %enckey9, i64 0, i64 0, !dbg !89
  %14 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !91
  %key = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %14, i32 0, i32 0, !dbg !92
  %arraydecay11 = getelementptr inbounds [32 x i8], [32 x i8]* %key, i64 0, i64 0, !dbg !91
  call void @aes_addRoundKey_cpy_1(i8* %12, i8* %arraydecay10, i8* %arraydecay11), !dbg !93
  call void @llvm.dbg.declare(metadata i32* %_s_i, metadata !94, metadata !DIExpression()), !dbg !95
  store i8 1, i8* %rcon, align 1, !dbg !96
  br label %ecb3, !dbg !97

ecb3:                                             ; preds = %for.end8
  call void @llvm.dbg.label(metadata !98), !dbg !99
  store i32 1, i32* %_s_i, align 4, !dbg !100
  br label %for.cond12, !dbg !102

for.cond12:                                       ; preds = %for.inc23, %ecb3
  %15 = load i32, i32* %_s_i, align 4, !dbg !103
  %cmp13 = icmp sle i32 %15, 13, !dbg !105
  br i1 %cmp13, label %for.body15, label %for.end25, !dbg !106

for.body15:                                       ; preds = %for.cond12
  %16 = load i8*, i8** %buf.addr, align 8, !dbg !107
  call void @aes_subBytes_1(i8* %16), !dbg !109
  %17 = load i8*, i8** %buf.addr, align 8, !dbg !110
  call void @aes_shiftRows_1(i8* %17), !dbg !111
  %18 = load i8*, i8** %buf.addr, align 8, !dbg !112
  call void @aes_mixColumns_1(i8* %18), !dbg !113
  %19 = load i32, i32* %_s_i, align 4, !dbg !114
  %and = and i32 %19, 1, !dbg !116
  %tobool16 = icmp ne i32 %and, 0, !dbg !116
  br i1 %tobool16, label %if.then, label %if.else, !dbg !117

if.then:                                          ; preds = %for.body15
  %20 = load i8*, i8** %buf.addr, align 8, !dbg !118
  %21 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !120
  %key17 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %21, i32 0, i32 0, !dbg !121
  %arrayidx18 = getelementptr inbounds [32 x i8], [32 x i8]* %key17, i64 0, i64 16, !dbg !120
  call void @aes_addRoundKey_1(i8* %20, i8* %arrayidx18), !dbg !122
  br label %if.end, !dbg !123

if.else:                                          ; preds = %for.body15
  %22 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !124
  %key19 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %22, i32 0, i32 0, !dbg !126
  %arraydecay20 = getelementptr inbounds [32 x i8], [32 x i8]* %key19, i64 0, i64 0, !dbg !124
  call void @aes_expandEncKey_1(i8* %arraydecay20, i8* %rcon), !dbg !127
  %23 = load i8*, i8** %buf.addr, align 8, !dbg !128
  %24 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !129
  %key21 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %24, i32 0, i32 0, !dbg !130
  %arraydecay22 = getelementptr inbounds [32 x i8], [32 x i8]* %key21, i64 0, i64 0, !dbg !129
  call void @aes_addRoundKey_1(i8* %23, i8* %arraydecay22), !dbg !131
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc23, !dbg !132

for.inc23:                                        ; preds = %if.end
  %25 = load i32, i32* %_s_i, align 4, !dbg !133
  %inc24 = add nsw i32 %25, 1, !dbg !133
  store i32 %inc24, i32* %_s_i, align 4, !dbg !133
  br label %for.cond12, !dbg !134, !llvm.loop !135

for.end25:                                        ; preds = %for.cond12
  %26 = load i32, i32* %_s_i, align 4, !dbg !137
  %conv26 = trunc i32 %26 to i8, !dbg !137
  store i8 %conv26, i8* %i, align 1, !dbg !138
  %27 = load i8*, i8** %buf.addr, align 8, !dbg !139
  call void @aes_subBytes_1(i8* %27), !dbg !140
  %28 = load i8*, i8** %buf.addr, align 8, !dbg !141
  call void @aes_shiftRows_1(i8* %28), !dbg !142
  %29 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !143
  %key27 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %29, i32 0, i32 0, !dbg !144
  %arraydecay28 = getelementptr inbounds [32 x i8], [32 x i8]* %key27, i64 0, i64 0, !dbg !143
  call void @aes_expandEncKey_1(i8* %arraydecay28, i8* %rcon), !dbg !145
  %30 = load i8*, i8** %buf.addr, align 8, !dbg !146
  %31 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8, !dbg !147
  %key29 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %31, i32 0, i32 0, !dbg !148
  %arraydecay30 = getelementptr inbounds [32 x i8], [32 x i8]* %key29, i64 0, i64 0, !dbg !147
  call void @aes_addRoundKey_1(i8* %30, i8* %arraydecay30), !dbg !149
  ret void, !dbg !150
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_expandEncKey_1(i8* %k, i8* %rc) #0 !dbg !151 {
entry:
  %k.addr = alloca i8*, align 8
  %rc.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %k, i8** %k.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %k.addr, metadata !154, metadata !DIExpression()), !dbg !155
  store i8* %rc, i8** %rc.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %rc.addr, metadata !156, metadata !DIExpression()), !dbg !157
  call void @llvm.dbg.declare(metadata i8* %i, metadata !158, metadata !DIExpression()), !dbg !159
  %0 = load i8*, i8** %k.addr, align 8, !dbg !160
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 29, !dbg !160
  %1 = load i8, i8* %arrayidx, align 1, !dbg !160
  %idxprom = zext i8 %1 to i64, !dbg !161
  %arrayidx1 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom, !dbg !161
  %2 = load i8, i8* %arrayidx1, align 1, !dbg !161
  %conv = zext i8 %2 to i32, !dbg !162
  %3 = load i8*, i8** %rc.addr, align 8, !dbg !163
  %4 = load i8, i8* %3, align 1, !dbg !164
  %conv2 = zext i8 %4 to i32, !dbg !165
  %xor = xor i32 %conv, %conv2, !dbg !166
  %5 = load i8*, i8** %k.addr, align 8, !dbg !167
  %arrayidx3 = getelementptr inbounds i8, i8* %5, i64 0, !dbg !167
  %6 = load i8, i8* %arrayidx3, align 1, !dbg !168
  %conv4 = zext i8 %6 to i32, !dbg !168
  %xor5 = xor i32 %conv4, %xor, !dbg !168
  %conv6 = trunc i32 %xor5 to i8, !dbg !168
  store i8 %conv6, i8* %arrayidx3, align 1, !dbg !168
  %7 = load i8*, i8** %k.addr, align 8, !dbg !169
  %arrayidx7 = getelementptr inbounds i8, i8* %7, i64 30, !dbg !169
  %8 = load i8, i8* %arrayidx7, align 1, !dbg !169
  %idxprom8 = zext i8 %8 to i64, !dbg !170
  %arrayidx9 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom8, !dbg !170
  %9 = load i8, i8* %arrayidx9, align 1, !dbg !170
  %conv10 = zext i8 %9 to i32, !dbg !171
  %10 = load i8*, i8** %k.addr, align 8, !dbg !172
  %arrayidx11 = getelementptr inbounds i8, i8* %10, i64 1, !dbg !172
  %11 = load i8, i8* %arrayidx11, align 1, !dbg !173
  %conv12 = zext i8 %11 to i32, !dbg !173
  %xor13 = xor i32 %conv12, %conv10, !dbg !173
  %conv14 = trunc i32 %xor13 to i8, !dbg !173
  store i8 %conv14, i8* %arrayidx11, align 1, !dbg !173
  %12 = load i8*, i8** %k.addr, align 8, !dbg !174
  %arrayidx15 = getelementptr inbounds i8, i8* %12, i64 31, !dbg !174
  %13 = load i8, i8* %arrayidx15, align 1, !dbg !174
  %idxprom16 = zext i8 %13 to i64, !dbg !175
  %arrayidx17 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom16, !dbg !175
  %14 = load i8, i8* %arrayidx17, align 1, !dbg !175
  %conv18 = zext i8 %14 to i32, !dbg !176
  %15 = load i8*, i8** %k.addr, align 8, !dbg !177
  %arrayidx19 = getelementptr inbounds i8, i8* %15, i64 2, !dbg !177
  %16 = load i8, i8* %arrayidx19, align 1, !dbg !178
  %conv20 = zext i8 %16 to i32, !dbg !178
  %xor21 = xor i32 %conv20, %conv18, !dbg !178
  %conv22 = trunc i32 %xor21 to i8, !dbg !178
  store i8 %conv22, i8* %arrayidx19, align 1, !dbg !178
  %17 = load i8*, i8** %k.addr, align 8, !dbg !179
  %arrayidx23 = getelementptr inbounds i8, i8* %17, i64 28, !dbg !179
  %18 = load i8, i8* %arrayidx23, align 1, !dbg !179
  %idxprom24 = zext i8 %18 to i64, !dbg !180
  %arrayidx25 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom24, !dbg !180
  %19 = load i8, i8* %arrayidx25, align 1, !dbg !180
  %conv26 = zext i8 %19 to i32, !dbg !181
  %20 = load i8*, i8** %k.addr, align 8, !dbg !182
  %arrayidx27 = getelementptr inbounds i8, i8* %20, i64 3, !dbg !182
  %21 = load i8, i8* %arrayidx27, align 1, !dbg !183
  %conv28 = zext i8 %21 to i32, !dbg !183
  %xor29 = xor i32 %conv28, %conv26, !dbg !183
  %conv30 = trunc i32 %xor29 to i8, !dbg !183
  store i8 %conv30, i8* %arrayidx27, align 1, !dbg !183
  %22 = load i8*, i8** %rc.addr, align 8, !dbg !184
  %23 = load i8, i8* %22, align 1, !dbg !185
  %conv31 = zext i8 %23 to i32, !dbg !186
  %shl = shl i32 %conv31, 1, !dbg !187
  %24 = load i8*, i8** %rc.addr, align 8, !dbg !188
  %25 = load i8, i8* %24, align 1, !dbg !189
  %conv32 = zext i8 %25 to i32, !dbg !190
  %shr = ashr i32 %conv32, 7, !dbg !191
  %and = and i32 %shr, 1, !dbg !192
  %mul = mul nsw i32 %and, 27, !dbg !193
  %xor33 = xor i32 %shl, %mul, !dbg !194
  %conv34 = trunc i32 %xor33 to i8, !dbg !195
  %26 = load i8*, i8** %rc.addr, align 8, !dbg !196
  store i8 %conv34, i8* %26, align 1, !dbg !197
  br label %exp1, !dbg !198

exp1:                                             ; preds = %entry
  call void @llvm.dbg.label(metadata !199), !dbg !200
  store i8 4, i8* %i, align 1, !dbg !201
  br label %for.cond, !dbg !203

for.cond:                                         ; preds = %for.inc, %exp1
  %27 = load i8, i8* %i, align 1, !dbg !204
  %conv35 = zext i8 %27 to i32, !dbg !206
  %cmp = icmp slt i32 %conv35, 16, !dbg !207
  br i1 %cmp, label %for.body, label %for.end, !dbg !208

for.body:                                         ; preds = %for.cond
  %28 = load i8*, i8** %k.addr, align 8, !dbg !209
  %29 = load i8, i8* %i, align 1, !dbg !210
  %conv37 = zext i8 %29 to i32, !dbg !211
  %sub = sub nsw i32 %conv37, 4, !dbg !212
  %idxprom38 = sext i32 %sub to i64, !dbg !209
  %arrayidx39 = getelementptr inbounds i8, i8* %28, i64 %idxprom38, !dbg !209
  %30 = load i8, i8* %arrayidx39, align 1, !dbg !209
  %conv40 = zext i8 %30 to i32, !dbg !213
  %31 = load i8*, i8** %k.addr, align 8, !dbg !214
  %32 = load i8, i8* %i, align 1, !dbg !215
  %idxprom41 = zext i8 %32 to i64, !dbg !214
  %arrayidx42 = getelementptr inbounds i8, i8* %31, i64 %idxprom41, !dbg !214
  %33 = load i8, i8* %arrayidx42, align 1, !dbg !216
  %conv43 = zext i8 %33 to i32, !dbg !216
  %xor44 = xor i32 %conv43, %conv40, !dbg !216
  %conv45 = trunc i32 %xor44 to i8, !dbg !216
  store i8 %conv45, i8* %arrayidx42, align 1, !dbg !216
  %34 = load i8*, i8** %k.addr, align 8, !dbg !217
  %35 = load i8, i8* %i, align 1, !dbg !218
  %conv46 = zext i8 %35 to i32, !dbg !219
  %sub47 = sub nsw i32 %conv46, 3, !dbg !220
  %idxprom48 = sext i32 %sub47 to i64, !dbg !217
  %arrayidx49 = getelementptr inbounds i8, i8* %34, i64 %idxprom48, !dbg !217
  %36 = load i8, i8* %arrayidx49, align 1, !dbg !217
  %conv50 = zext i8 %36 to i32, !dbg !221
  %37 = load i8*, i8** %k.addr, align 8, !dbg !222
  %38 = load i8, i8* %i, align 1, !dbg !223
  %conv51 = zext i8 %38 to i32, !dbg !224
  %add = add nsw i32 %conv51, 1, !dbg !225
  %idxprom52 = sext i32 %add to i64, !dbg !222
  %arrayidx53 = getelementptr inbounds i8, i8* %37, i64 %idxprom52, !dbg !222
  %39 = load i8, i8* %arrayidx53, align 1, !dbg !226
  %conv54 = zext i8 %39 to i32, !dbg !226
  %xor55 = xor i32 %conv54, %conv50, !dbg !226
  %conv56 = trunc i32 %xor55 to i8, !dbg !226
  store i8 %conv56, i8* %arrayidx53, align 1, !dbg !226
  %40 = load i8*, i8** %k.addr, align 8, !dbg !227
  %41 = load i8, i8* %i, align 1, !dbg !228
  %conv57 = zext i8 %41 to i32, !dbg !229
  %sub58 = sub nsw i32 %conv57, 2, !dbg !230
  %idxprom59 = sext i32 %sub58 to i64, !dbg !227
  %arrayidx60 = getelementptr inbounds i8, i8* %40, i64 %idxprom59, !dbg !227
  %42 = load i8, i8* %arrayidx60, align 1, !dbg !227
  %conv61 = zext i8 %42 to i32, !dbg !231
  %43 = load i8*, i8** %k.addr, align 8, !dbg !232
  %44 = load i8, i8* %i, align 1, !dbg !233
  %conv62 = zext i8 %44 to i32, !dbg !234
  %add63 = add nsw i32 %conv62, 2, !dbg !235
  %idxprom64 = sext i32 %add63 to i64, !dbg !232
  %arrayidx65 = getelementptr inbounds i8, i8* %43, i64 %idxprom64, !dbg !232
  %45 = load i8, i8* %arrayidx65, align 1, !dbg !236
  %conv66 = zext i8 %45 to i32, !dbg !236
  %xor67 = xor i32 %conv66, %conv61, !dbg !236
  %conv68 = trunc i32 %xor67 to i8, !dbg !236
  store i8 %conv68, i8* %arrayidx65, align 1, !dbg !236
  %46 = load i8*, i8** %k.addr, align 8, !dbg !237
  %47 = load i8, i8* %i, align 1, !dbg !238
  %conv69 = zext i8 %47 to i32, !dbg !239
  %sub70 = sub nsw i32 %conv69, 1, !dbg !240
  %idxprom71 = sext i32 %sub70 to i64, !dbg !237
  %arrayidx72 = getelementptr inbounds i8, i8* %46, i64 %idxprom71, !dbg !237
  %48 = load i8, i8* %arrayidx72, align 1, !dbg !237
  %conv73 = zext i8 %48 to i32, !dbg !241
  %49 = load i8*, i8** %k.addr, align 8, !dbg !242
  %50 = load i8, i8* %i, align 1, !dbg !243
  %conv74 = zext i8 %50 to i32, !dbg !244
  %add75 = add nsw i32 %conv74, 3, !dbg !245
  %idxprom76 = sext i32 %add75 to i64, !dbg !242
  %arrayidx77 = getelementptr inbounds i8, i8* %49, i64 %idxprom76, !dbg !242
  %51 = load i8, i8* %arrayidx77, align 1, !dbg !246
  %conv78 = zext i8 %51 to i32, !dbg !246
  %xor79 = xor i32 %conv78, %conv73, !dbg !246
  %conv80 = trunc i32 %xor79 to i8, !dbg !246
  store i8 %conv80, i8* %arrayidx77, align 1, !dbg !246
  br label %for.inc, !dbg !247

for.inc:                                          ; preds = %for.body
  %52 = load i8, i8* %i, align 1, !dbg !248
  %conv81 = zext i8 %52 to i32, !dbg !248
  %add82 = add nsw i32 %conv81, 4, !dbg !248
  %conv83 = trunc i32 %add82 to i8, !dbg !248
  store i8 %conv83, i8* %i, align 1, !dbg !248
  br label %for.cond, !dbg !249, !llvm.loop !250

for.end:                                          ; preds = %for.cond
  %53 = load i8*, i8** %k.addr, align 8, !dbg !252
  %arrayidx84 = getelementptr inbounds i8, i8* %53, i64 12, !dbg !252
  %54 = load i8, i8* %arrayidx84, align 1, !dbg !252
  %idxprom85 = zext i8 %54 to i64, !dbg !253
  %arrayidx86 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom85, !dbg !253
  %55 = load i8, i8* %arrayidx86, align 1, !dbg !253
  %conv87 = zext i8 %55 to i32, !dbg !254
  %56 = load i8*, i8** %k.addr, align 8, !dbg !255
  %arrayidx88 = getelementptr inbounds i8, i8* %56, i64 16, !dbg !255
  %57 = load i8, i8* %arrayidx88, align 1, !dbg !256
  %conv89 = zext i8 %57 to i32, !dbg !256
  %xor90 = xor i32 %conv89, %conv87, !dbg !256
  %conv91 = trunc i32 %xor90 to i8, !dbg !256
  store i8 %conv91, i8* %arrayidx88, align 1, !dbg !256
  %58 = load i8*, i8** %k.addr, align 8, !dbg !257
  %arrayidx92 = getelementptr inbounds i8, i8* %58, i64 13, !dbg !257
  %59 = load i8, i8* %arrayidx92, align 1, !dbg !257
  %idxprom93 = zext i8 %59 to i64, !dbg !258
  %arrayidx94 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom93, !dbg !258
  %60 = load i8, i8* %arrayidx94, align 1, !dbg !258
  %conv95 = zext i8 %60 to i32, !dbg !259
  %61 = load i8*, i8** %k.addr, align 8, !dbg !260
  %arrayidx96 = getelementptr inbounds i8, i8* %61, i64 17, !dbg !260
  %62 = load i8, i8* %arrayidx96, align 1, !dbg !261
  %conv97 = zext i8 %62 to i32, !dbg !261
  %xor98 = xor i32 %conv97, %conv95, !dbg !261
  %conv99 = trunc i32 %xor98 to i8, !dbg !261
  store i8 %conv99, i8* %arrayidx96, align 1, !dbg !261
  %63 = load i8*, i8** %k.addr, align 8, !dbg !262
  %arrayidx100 = getelementptr inbounds i8, i8* %63, i64 14, !dbg !262
  %64 = load i8, i8* %arrayidx100, align 1, !dbg !262
  %idxprom101 = zext i8 %64 to i64, !dbg !263
  %arrayidx102 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom101, !dbg !263
  %65 = load i8, i8* %arrayidx102, align 1, !dbg !263
  %conv103 = zext i8 %65 to i32, !dbg !264
  %66 = load i8*, i8** %k.addr, align 8, !dbg !265
  %arrayidx104 = getelementptr inbounds i8, i8* %66, i64 18, !dbg !265
  %67 = load i8, i8* %arrayidx104, align 1, !dbg !266
  %conv105 = zext i8 %67 to i32, !dbg !266
  %xor106 = xor i32 %conv105, %conv103, !dbg !266
  %conv107 = trunc i32 %xor106 to i8, !dbg !266
  store i8 %conv107, i8* %arrayidx104, align 1, !dbg !266
  %68 = load i8*, i8** %k.addr, align 8, !dbg !267
  %arrayidx108 = getelementptr inbounds i8, i8* %68, i64 15, !dbg !267
  %69 = load i8, i8* %arrayidx108, align 1, !dbg !267
  %idxprom109 = zext i8 %69 to i64, !dbg !268
  %arrayidx110 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom109, !dbg !268
  %70 = load i8, i8* %arrayidx110, align 1, !dbg !268
  %conv111 = zext i8 %70 to i32, !dbg !269
  %71 = load i8*, i8** %k.addr, align 8, !dbg !270
  %arrayidx112 = getelementptr inbounds i8, i8* %71, i64 19, !dbg !270
  %72 = load i8, i8* %arrayidx112, align 1, !dbg !271
  %conv113 = zext i8 %72 to i32, !dbg !271
  %xor114 = xor i32 %conv113, %conv111, !dbg !271
  %conv115 = trunc i32 %xor114 to i8, !dbg !271
  store i8 %conv115, i8* %arrayidx112, align 1, !dbg !271
  br label %exp2, !dbg !270

exp2:                                             ; preds = %for.end
  call void @llvm.dbg.label(metadata !272), !dbg !273
  store i8 20, i8* %i, align 1, !dbg !274
  br label %for.cond116, !dbg !276

for.cond116:                                      ; preds = %for.inc167, %exp2
  %73 = load i8, i8* %i, align 1, !dbg !277
  %conv117 = zext i8 %73 to i32, !dbg !279
  %cmp118 = icmp slt i32 %conv117, 32, !dbg !280
  br i1 %cmp118, label %for.body120, label %for.end171, !dbg !281

for.body120:                                      ; preds = %for.cond116
  %74 = load i8*, i8** %k.addr, align 8, !dbg !282
  %75 = load i8, i8* %i, align 1, !dbg !283
  %conv121 = zext i8 %75 to i32, !dbg !284
  %sub122 = sub nsw i32 %conv121, 4, !dbg !285
  %idxprom123 = sext i32 %sub122 to i64, !dbg !282
  %arrayidx124 = getelementptr inbounds i8, i8* %74, i64 %idxprom123, !dbg !282
  %76 = load i8, i8* %arrayidx124, align 1, !dbg !282
  %conv125 = zext i8 %76 to i32, !dbg !286
  %77 = load i8*, i8** %k.addr, align 8, !dbg !287
  %78 = load i8, i8* %i, align 1, !dbg !288
  %idxprom126 = zext i8 %78 to i64, !dbg !287
  %arrayidx127 = getelementptr inbounds i8, i8* %77, i64 %idxprom126, !dbg !287
  %79 = load i8, i8* %arrayidx127, align 1, !dbg !289
  %conv128 = zext i8 %79 to i32, !dbg !289
  %xor129 = xor i32 %conv128, %conv125, !dbg !289
  %conv130 = trunc i32 %xor129 to i8, !dbg !289
  store i8 %conv130, i8* %arrayidx127, align 1, !dbg !289
  %80 = load i8*, i8** %k.addr, align 8, !dbg !290
  %81 = load i8, i8* %i, align 1, !dbg !291
  %conv131 = zext i8 %81 to i32, !dbg !292
  %sub132 = sub nsw i32 %conv131, 3, !dbg !293
  %idxprom133 = sext i32 %sub132 to i64, !dbg !290
  %arrayidx134 = getelementptr inbounds i8, i8* %80, i64 %idxprom133, !dbg !290
  %82 = load i8, i8* %arrayidx134, align 1, !dbg !290
  %conv135 = zext i8 %82 to i32, !dbg !294
  %83 = load i8*, i8** %k.addr, align 8, !dbg !295
  %84 = load i8, i8* %i, align 1, !dbg !296
  %conv136 = zext i8 %84 to i32, !dbg !297
  %add137 = add nsw i32 %conv136, 1, !dbg !298
  %idxprom138 = sext i32 %add137 to i64, !dbg !295
  %arrayidx139 = getelementptr inbounds i8, i8* %83, i64 %idxprom138, !dbg !295
  %85 = load i8, i8* %arrayidx139, align 1, !dbg !299
  %conv140 = zext i8 %85 to i32, !dbg !299
  %xor141 = xor i32 %conv140, %conv135, !dbg !299
  %conv142 = trunc i32 %xor141 to i8, !dbg !299
  store i8 %conv142, i8* %arrayidx139, align 1, !dbg !299
  %86 = load i8*, i8** %k.addr, align 8, !dbg !300
  %87 = load i8, i8* %i, align 1, !dbg !301
  %conv143 = zext i8 %87 to i32, !dbg !302
  %sub144 = sub nsw i32 %conv143, 2, !dbg !303
  %idxprom145 = sext i32 %sub144 to i64, !dbg !300
  %arrayidx146 = getelementptr inbounds i8, i8* %86, i64 %idxprom145, !dbg !300
  %88 = load i8, i8* %arrayidx146, align 1, !dbg !300
  %conv147 = zext i8 %88 to i32, !dbg !304
  %89 = load i8*, i8** %k.addr, align 8, !dbg !305
  %90 = load i8, i8* %i, align 1, !dbg !306
  %conv148 = zext i8 %90 to i32, !dbg !307
  %add149 = add nsw i32 %conv148, 2, !dbg !308
  %idxprom150 = sext i32 %add149 to i64, !dbg !305
  %arrayidx151 = getelementptr inbounds i8, i8* %89, i64 %idxprom150, !dbg !305
  %91 = load i8, i8* %arrayidx151, align 1, !dbg !309
  %conv152 = zext i8 %91 to i32, !dbg !309
  %xor153 = xor i32 %conv152, %conv147, !dbg !309
  %conv154 = trunc i32 %xor153 to i8, !dbg !309
  store i8 %conv154, i8* %arrayidx151, align 1, !dbg !309
  %92 = load i8*, i8** %k.addr, align 8, !dbg !310
  %93 = load i8, i8* %i, align 1, !dbg !311
  %conv155 = zext i8 %93 to i32, !dbg !312
  %sub156 = sub nsw i32 %conv155, 1, !dbg !313
  %idxprom157 = sext i32 %sub156 to i64, !dbg !310
  %arrayidx158 = getelementptr inbounds i8, i8* %92, i64 %idxprom157, !dbg !310
  %94 = load i8, i8* %arrayidx158, align 1, !dbg !310
  %conv159 = zext i8 %94 to i32, !dbg !314
  %95 = load i8*, i8** %k.addr, align 8, !dbg !315
  %96 = load i8, i8* %i, align 1, !dbg !316
  %conv160 = zext i8 %96 to i32, !dbg !317
  %add161 = add nsw i32 %conv160, 3, !dbg !318
  %idxprom162 = sext i32 %add161 to i64, !dbg !315
  %arrayidx163 = getelementptr inbounds i8, i8* %95, i64 %idxprom162, !dbg !315
  %97 = load i8, i8* %arrayidx163, align 1, !dbg !319
  %conv164 = zext i8 %97 to i32, !dbg !319
  %xor165 = xor i32 %conv164, %conv159, !dbg !319
  %conv166 = trunc i32 %xor165 to i8, !dbg !319
  store i8 %conv166, i8* %arrayidx163, align 1, !dbg !319
  br label %for.inc167, !dbg !320

for.inc167:                                       ; preds = %for.body120
  %98 = load i8, i8* %i, align 1, !dbg !321
  %conv168 = zext i8 %98 to i32, !dbg !321
  %add169 = add nsw i32 %conv168, 4, !dbg !321
  %conv170 = trunc i32 %add169 to i8, !dbg !321
  store i8 %conv170, i8* %i, align 1, !dbg !321
  br label %for.cond116, !dbg !322, !llvm.loop !323

for.end171:                                       ; preds = %for.cond116
  ret void, !dbg !325
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_addRoundKey_cpy_1(i8* %buf, i8* %key, i8* %cpk) #0 !dbg !326 {
entry:
  %buf.addr = alloca i8*, align 8
  %key.addr = alloca i8*, align 8
  %cpk.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !329, metadata !DIExpression()), !dbg !330
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !331, metadata !DIExpression()), !dbg !332
  store i8* %cpk, i8** %cpk.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %cpk.addr, metadata !333, metadata !DIExpression()), !dbg !334
  call void @llvm.dbg.declare(metadata i8* %i, metadata !335, metadata !DIExpression()), !dbg !336
  store i8 16, i8* %i, align 1, !dbg !336
  br label %cpkey, !dbg !337

cpkey:                                            ; preds = %entry
  call void @llvm.dbg.label(metadata !338), !dbg !339
  br label %while.cond, !dbg !340

while.cond:                                       ; preds = %while.body, %cpkey
  %0 = load i8, i8* %i, align 1, !dbg !341
  %dec = add i8 %0, -1, !dbg !341
  store i8 %dec, i8* %i, align 1, !dbg !341
  %tobool = icmp ne i8 %0, 0, !dbg !340
  br i1 %tobool, label %while.body, label %while.end, !dbg !340

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %key.addr, align 8, !dbg !342
  %2 = load i8, i8* %i, align 1, !dbg !343
  %idxprom = zext i8 %2 to i64, !dbg !342
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom, !dbg !342
  %3 = load i8, i8* %arrayidx, align 1, !dbg !342
  %4 = load i8*, i8** %cpk.addr, align 8, !dbg !344
  %5 = load i8, i8* %i, align 1, !dbg !345
  %idxprom1 = zext i8 %5 to i64, !dbg !344
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 %idxprom1, !dbg !344
  store i8 %3, i8* %arrayidx2, align 1, !dbg !346
  %conv = zext i8 %3 to i32, !dbg !347
  %6 = load i8*, i8** %buf.addr, align 8, !dbg !348
  %7 = load i8, i8* %i, align 1, !dbg !349
  %idxprom3 = zext i8 %7 to i64, !dbg !348
  %arrayidx4 = getelementptr inbounds i8, i8* %6, i64 %idxprom3, !dbg !348
  %8 = load i8, i8* %arrayidx4, align 1, !dbg !350
  %conv5 = zext i8 %8 to i32, !dbg !350
  %xor = xor i32 %conv5, %conv, !dbg !350
  %conv6 = trunc i32 %xor to i8, !dbg !350
  store i8 %conv6, i8* %arrayidx4, align 1, !dbg !350
  %9 = load i8*, i8** %key.addr, align 8, !dbg !351
  %10 = load i8, i8* %i, align 1, !dbg !352
  %conv7 = zext i8 %10 to i32, !dbg !353
  %add = add nsw i32 16, %conv7, !dbg !354
  %idxprom8 = sext i32 %add to i64, !dbg !351
  %arrayidx9 = getelementptr inbounds i8, i8* %9, i64 %idxprom8, !dbg !351
  %11 = load i8, i8* %arrayidx9, align 1, !dbg !351
  %12 = load i8*, i8** %cpk.addr, align 8, !dbg !355
  %13 = load i8, i8* %i, align 1, !dbg !356
  %conv10 = zext i8 %13 to i32, !dbg !357
  %add11 = add nsw i32 16, %conv10, !dbg !358
  %idxprom12 = sext i32 %add11 to i64, !dbg !355
  %arrayidx13 = getelementptr inbounds i8, i8* %12, i64 %idxprom12, !dbg !355
  store i8 %11, i8* %arrayidx13, align 1, !dbg !359
  br label %while.cond, !dbg !340, !llvm.loop !360

while.end:                                        ; preds = %while.cond
  ret void, !dbg !362
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_subBytes_1(i8* %buf) #0 !dbg !363 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !366, metadata !DIExpression()), !dbg !367
  call void @llvm.dbg.declare(metadata i8* %i, metadata !368, metadata !DIExpression()), !dbg !369
  store i8 16, i8* %i, align 1, !dbg !369
  br label %sub, !dbg !370

sub:                                              ; preds = %entry
  call void @llvm.dbg.label(metadata !371), !dbg !372
  br label %while.cond, !dbg !373

while.cond:                                       ; preds = %while.body, %sub
  %0 = load i8, i8* %i, align 1, !dbg !374
  %dec = add i8 %0, -1, !dbg !374
  store i8 %dec, i8* %i, align 1, !dbg !374
  %tobool = icmp ne i8 %0, 0, !dbg !373
  br i1 %tobool, label %while.body, label %while.end, !dbg !373

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %buf.addr, align 8, !dbg !375
  %2 = load i8, i8* %i, align 1, !dbg !376
  %idxprom = zext i8 %2 to i64, !dbg !375
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom, !dbg !375
  %3 = load i8, i8* %arrayidx, align 1, !dbg !375
  %idxprom1 = zext i8 %3 to i64, !dbg !377
  %arrayidx2 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom1, !dbg !377
  %4 = load i8, i8* %arrayidx2, align 1, !dbg !377
  %5 = load i8*, i8** %buf.addr, align 8, !dbg !378
  %6 = load i8, i8* %i, align 1, !dbg !379
  %idxprom3 = zext i8 %6 to i64, !dbg !378
  %arrayidx4 = getelementptr inbounds i8, i8* %5, i64 %idxprom3, !dbg !378
  store i8 %4, i8* %arrayidx4, align 1, !dbg !380
  br label %while.cond, !dbg !373, !llvm.loop !381

while.end:                                        ; preds = %while.cond
  ret void, !dbg !383
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_shiftRows_1(i8* %buf) #0 !dbg !384 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  %j = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !385, metadata !DIExpression()), !dbg !386
  call void @llvm.dbg.declare(metadata i8* %i, metadata !387, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.declare(metadata i8* %j, metadata !389, metadata !DIExpression()), !dbg !390
  %0 = load i8*, i8** %buf.addr, align 8, !dbg !391
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 1, !dbg !391
  %1 = load i8, i8* %arrayidx, align 1, !dbg !391
  store i8 %1, i8* %i, align 1, !dbg !392
  %2 = load i8*, i8** %buf.addr, align 8, !dbg !393
  %arrayidx1 = getelementptr inbounds i8, i8* %2, i64 5, !dbg !393
  %3 = load i8, i8* %arrayidx1, align 1, !dbg !393
  %4 = load i8*, i8** %buf.addr, align 8, !dbg !394
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 1, !dbg !394
  store i8 %3, i8* %arrayidx2, align 1, !dbg !395
  %5 = load i8*, i8** %buf.addr, align 8, !dbg !396
  %arrayidx3 = getelementptr inbounds i8, i8* %5, i64 9, !dbg !396
  %6 = load i8, i8* %arrayidx3, align 1, !dbg !396
  %7 = load i8*, i8** %buf.addr, align 8, !dbg !397
  %arrayidx4 = getelementptr inbounds i8, i8* %7, i64 5, !dbg !397
  store i8 %6, i8* %arrayidx4, align 1, !dbg !398
  %8 = load i8*, i8** %buf.addr, align 8, !dbg !399
  %arrayidx5 = getelementptr inbounds i8, i8* %8, i64 13, !dbg !399
  %9 = load i8, i8* %arrayidx5, align 1, !dbg !399
  %10 = load i8*, i8** %buf.addr, align 8, !dbg !400
  %arrayidx6 = getelementptr inbounds i8, i8* %10, i64 9, !dbg !400
  store i8 %9, i8* %arrayidx6, align 1, !dbg !401
  %11 = load i8, i8* %i, align 1, !dbg !402
  %12 = load i8*, i8** %buf.addr, align 8, !dbg !403
  %arrayidx7 = getelementptr inbounds i8, i8* %12, i64 13, !dbg !403
  store i8 %11, i8* %arrayidx7, align 1, !dbg !404
  %13 = load i8*, i8** %buf.addr, align 8, !dbg !405
  %arrayidx8 = getelementptr inbounds i8, i8* %13, i64 10, !dbg !405
  %14 = load i8, i8* %arrayidx8, align 1, !dbg !405
  store i8 %14, i8* %i, align 1, !dbg !406
  %15 = load i8*, i8** %buf.addr, align 8, !dbg !407
  %arrayidx9 = getelementptr inbounds i8, i8* %15, i64 2, !dbg !407
  %16 = load i8, i8* %arrayidx9, align 1, !dbg !407
  %17 = load i8*, i8** %buf.addr, align 8, !dbg !408
  %arrayidx10 = getelementptr inbounds i8, i8* %17, i64 10, !dbg !408
  store i8 %16, i8* %arrayidx10, align 1, !dbg !409
  %18 = load i8, i8* %i, align 1, !dbg !410
  %19 = load i8*, i8** %buf.addr, align 8, !dbg !411
  %arrayidx11 = getelementptr inbounds i8, i8* %19, i64 2, !dbg !411
  store i8 %18, i8* %arrayidx11, align 1, !dbg !412
  %20 = load i8*, i8** %buf.addr, align 8, !dbg !413
  %arrayidx12 = getelementptr inbounds i8, i8* %20, i64 3, !dbg !413
  %21 = load i8, i8* %arrayidx12, align 1, !dbg !413
  store i8 %21, i8* %j, align 1, !dbg !414
  %22 = load i8*, i8** %buf.addr, align 8, !dbg !415
  %arrayidx13 = getelementptr inbounds i8, i8* %22, i64 15, !dbg !415
  %23 = load i8, i8* %arrayidx13, align 1, !dbg !415
  %24 = load i8*, i8** %buf.addr, align 8, !dbg !416
  %arrayidx14 = getelementptr inbounds i8, i8* %24, i64 3, !dbg !416
  store i8 %23, i8* %arrayidx14, align 1, !dbg !417
  %25 = load i8*, i8** %buf.addr, align 8, !dbg !418
  %arrayidx15 = getelementptr inbounds i8, i8* %25, i64 11, !dbg !418
  %26 = load i8, i8* %arrayidx15, align 1, !dbg !418
  %27 = load i8*, i8** %buf.addr, align 8, !dbg !419
  %arrayidx16 = getelementptr inbounds i8, i8* %27, i64 15, !dbg !419
  store i8 %26, i8* %arrayidx16, align 1, !dbg !420
  %28 = load i8*, i8** %buf.addr, align 8, !dbg !421
  %arrayidx17 = getelementptr inbounds i8, i8* %28, i64 7, !dbg !421
  %29 = load i8, i8* %arrayidx17, align 1, !dbg !421
  %30 = load i8*, i8** %buf.addr, align 8, !dbg !422
  %arrayidx18 = getelementptr inbounds i8, i8* %30, i64 11, !dbg !422
  store i8 %29, i8* %arrayidx18, align 1, !dbg !423
  %31 = load i8, i8* %j, align 1, !dbg !424
  %32 = load i8*, i8** %buf.addr, align 8, !dbg !425
  %arrayidx19 = getelementptr inbounds i8, i8* %32, i64 7, !dbg !425
  store i8 %31, i8* %arrayidx19, align 1, !dbg !426
  %33 = load i8*, i8** %buf.addr, align 8, !dbg !427
  %arrayidx20 = getelementptr inbounds i8, i8* %33, i64 14, !dbg !427
  %34 = load i8, i8* %arrayidx20, align 1, !dbg !427
  store i8 %34, i8* %j, align 1, !dbg !428
  %35 = load i8*, i8** %buf.addr, align 8, !dbg !429
  %arrayidx21 = getelementptr inbounds i8, i8* %35, i64 6, !dbg !429
  %36 = load i8, i8* %arrayidx21, align 1, !dbg !429
  %37 = load i8*, i8** %buf.addr, align 8, !dbg !430
  %arrayidx22 = getelementptr inbounds i8, i8* %37, i64 14, !dbg !430
  store i8 %36, i8* %arrayidx22, align 1, !dbg !431
  %38 = load i8, i8* %j, align 1, !dbg !432
  %39 = load i8*, i8** %buf.addr, align 8, !dbg !433
  %arrayidx23 = getelementptr inbounds i8, i8* %39, i64 6, !dbg !433
  store i8 %38, i8* %arrayidx23, align 1, !dbg !434
  ret void, !dbg !435
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_mixColumns_1(i8* %buf) #0 !dbg !436 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  %a = alloca i8, align 1
  %b = alloca i8, align 1
  %c = alloca i8, align 1
  %d = alloca i8, align 1
  %e = alloca i8, align 1
  %_s_i = alloca i32, align 4
  %_in_s_i = alloca i32, align 4
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !437, metadata !DIExpression()), !dbg !438
  call void @llvm.dbg.declare(metadata i8* %i, metadata !439, metadata !DIExpression()), !dbg !440
  call void @llvm.dbg.declare(metadata i8* %a, metadata !441, metadata !DIExpression()), !dbg !442
  call void @llvm.dbg.declare(metadata i8* %b, metadata !443, metadata !DIExpression()), !dbg !444
  call void @llvm.dbg.declare(metadata i8* %c, metadata !445, metadata !DIExpression()), !dbg !446
  call void @llvm.dbg.declare(metadata i8* %d, metadata !447, metadata !DIExpression()), !dbg !448
  call void @llvm.dbg.declare(metadata i8* %e, metadata !449, metadata !DIExpression()), !dbg !450
  call void @llvm.dbg.declare(metadata i32* %_s_i, metadata !451, metadata !DIExpression()), !dbg !452
  br label %mix, !dbg !453

mix:                                              ; preds = %entry
  call void @llvm.dbg.label(metadata !454), !dbg !455
  store i32 0, i32* %_s_i, align 4, !dbg !456
  br label %for.cond, !dbg !458

for.cond:                                         ; preds = %for.inc, %mix
  %0 = load i32, i32* %_s_i, align 4, !dbg !459
  %cmp = icmp sle i32 %0, 3, !dbg !461
  br i1 %cmp, label %for.body, label %for.end, !dbg !462

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %_in_s_i, metadata !463, metadata !DIExpression()), !dbg !465
  %1 = load i32, i32* %_s_i, align 4, !dbg !466
  %conv = sext i32 %1 to i64, !dbg !466
  %mul = mul nsw i64 4, %conv, !dbg !467
  %add = add nsw i64 0, %mul, !dbg !468
  %conv1 = trunc i64 %add to i32, !dbg !469
  store i32 %conv1, i32* %_in_s_i, align 4, !dbg !465
  %2 = load i8*, i8** %buf.addr, align 8, !dbg !470
  %3 = load i32, i32* %_in_s_i, align 4, !dbg !471
  %idxprom = sext i32 %3 to i64, !dbg !470
  %arrayidx = getelementptr inbounds i8, i8* %2, i64 %idxprom, !dbg !470
  %4 = load i8, i8* %arrayidx, align 1, !dbg !470
  store i8 %4, i8* %a, align 1, !dbg !472
  %5 = load i8*, i8** %buf.addr, align 8, !dbg !473
  %6 = load i32, i32* %_in_s_i, align 4, !dbg !474
  %add2 = add nsw i32 %6, 1, !dbg !475
  %idxprom3 = sext i32 %add2 to i64, !dbg !473
  %arrayidx4 = getelementptr inbounds i8, i8* %5, i64 %idxprom3, !dbg !473
  %7 = load i8, i8* %arrayidx4, align 1, !dbg !473
  store i8 %7, i8* %b, align 1, !dbg !476
  %8 = load i8*, i8** %buf.addr, align 8, !dbg !477
  %9 = load i32, i32* %_in_s_i, align 4, !dbg !478
  %add5 = add nsw i32 %9, 2, !dbg !479
  %idxprom6 = sext i32 %add5 to i64, !dbg !477
  %arrayidx7 = getelementptr inbounds i8, i8* %8, i64 %idxprom6, !dbg !477
  %10 = load i8, i8* %arrayidx7, align 1, !dbg !477
  store i8 %10, i8* %c, align 1, !dbg !480
  %11 = load i8*, i8** %buf.addr, align 8, !dbg !481
  %12 = load i32, i32* %_in_s_i, align 4, !dbg !482
  %add8 = add nsw i32 %12, 3, !dbg !483
  %idxprom9 = sext i32 %add8 to i64, !dbg !481
  %arrayidx10 = getelementptr inbounds i8, i8* %11, i64 %idxprom9, !dbg !481
  %13 = load i8, i8* %arrayidx10, align 1, !dbg !481
  store i8 %13, i8* %d, align 1, !dbg !484
  %14 = load i8, i8* %a, align 1, !dbg !485
  %conv11 = zext i8 %14 to i32, !dbg !486
  %15 = load i8, i8* %b, align 1, !dbg !487
  %conv12 = zext i8 %15 to i32, !dbg !488
  %xor = xor i32 %conv11, %conv12, !dbg !489
  %16 = load i8, i8* %c, align 1, !dbg !490
  %conv13 = zext i8 %16 to i32, !dbg !491
  %xor14 = xor i32 %xor, %conv13, !dbg !492
  %17 = load i8, i8* %d, align 1, !dbg !493
  %conv15 = zext i8 %17 to i32, !dbg !494
  %xor16 = xor i32 %xor14, %conv15, !dbg !495
  %conv17 = trunc i32 %xor16 to i8, !dbg !496
  store i8 %conv17, i8* %e, align 1, !dbg !497
  %18 = load i8, i8* %e, align 1, !dbg !498
  %conv18 = zext i8 %18 to i32, !dbg !499
  %19 = load i8, i8* %a, align 1, !dbg !500
  %conv19 = zext i8 %19 to i32, !dbg !501
  %20 = load i8, i8* %b, align 1, !dbg !502
  %conv20 = zext i8 %20 to i32, !dbg !503
  %xor21 = xor i32 %conv19, %conv20, !dbg !504
  %conv22 = trunc i32 %xor21 to i8, !dbg !505
  %call = call zeroext i8 @rj_xtime_1(i8 zeroext %conv22), !dbg !506
  %conv23 = zext i8 %call to i32, !dbg !507
  %xor24 = xor i32 %conv18, %conv23, !dbg !508
  %21 = load i8*, i8** %buf.addr, align 8, !dbg !509
  %22 = load i32, i32* %_in_s_i, align 4, !dbg !510
  %idxprom25 = sext i32 %22 to i64, !dbg !509
  %arrayidx26 = getelementptr inbounds i8, i8* %21, i64 %idxprom25, !dbg !509
  %23 = load i8, i8* %arrayidx26, align 1, !dbg !511
  %conv27 = zext i8 %23 to i32, !dbg !511
  %xor28 = xor i32 %conv27, %xor24, !dbg !511
  %conv29 = trunc i32 %xor28 to i8, !dbg !511
  store i8 %conv29, i8* %arrayidx26, align 1, !dbg !511
  %24 = load i8, i8* %e, align 1, !dbg !512
  %conv30 = zext i8 %24 to i32, !dbg !513
  %25 = load i8, i8* %b, align 1, !dbg !514
  %conv31 = zext i8 %25 to i32, !dbg !515
  %26 = load i8, i8* %c, align 1, !dbg !516
  %conv32 = zext i8 %26 to i32, !dbg !517
  %xor33 = xor i32 %conv31, %conv32, !dbg !518
  %conv34 = trunc i32 %xor33 to i8, !dbg !519
  %call35 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv34), !dbg !520
  %conv36 = zext i8 %call35 to i32, !dbg !521
  %xor37 = xor i32 %conv30, %conv36, !dbg !522
  %27 = load i8*, i8** %buf.addr, align 8, !dbg !523
  %28 = load i32, i32* %_in_s_i, align 4, !dbg !524
  %add38 = add nsw i32 %28, 1, !dbg !525
  %idxprom39 = sext i32 %add38 to i64, !dbg !523
  %arrayidx40 = getelementptr inbounds i8, i8* %27, i64 %idxprom39, !dbg !523
  %29 = load i8, i8* %arrayidx40, align 1, !dbg !526
  %conv41 = zext i8 %29 to i32, !dbg !526
  %xor42 = xor i32 %conv41, %xor37, !dbg !526
  %conv43 = trunc i32 %xor42 to i8, !dbg !526
  store i8 %conv43, i8* %arrayidx40, align 1, !dbg !526
  %30 = load i8, i8* %e, align 1, !dbg !527
  %conv44 = zext i8 %30 to i32, !dbg !528
  %31 = load i8, i8* %c, align 1, !dbg !529
  %conv45 = zext i8 %31 to i32, !dbg !530
  %32 = load i8, i8* %d, align 1, !dbg !531
  %conv46 = zext i8 %32 to i32, !dbg !532
  %xor47 = xor i32 %conv45, %conv46, !dbg !533
  %conv48 = trunc i32 %xor47 to i8, !dbg !534
  %call49 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv48), !dbg !535
  %conv50 = zext i8 %call49 to i32, !dbg !536
  %xor51 = xor i32 %conv44, %conv50, !dbg !537
  %33 = load i8*, i8** %buf.addr, align 8, !dbg !538
  %34 = load i32, i32* %_in_s_i, align 4, !dbg !539
  %add52 = add nsw i32 %34, 2, !dbg !540
  %idxprom53 = sext i32 %add52 to i64, !dbg !538
  %arrayidx54 = getelementptr inbounds i8, i8* %33, i64 %idxprom53, !dbg !538
  %35 = load i8, i8* %arrayidx54, align 1, !dbg !541
  %conv55 = zext i8 %35 to i32, !dbg !541
  %xor56 = xor i32 %conv55, %xor51, !dbg !541
  %conv57 = trunc i32 %xor56 to i8, !dbg !541
  store i8 %conv57, i8* %arrayidx54, align 1, !dbg !541
  %36 = load i8, i8* %e, align 1, !dbg !542
  %conv58 = zext i8 %36 to i32, !dbg !543
  %37 = load i8, i8* %d, align 1, !dbg !544
  %conv59 = zext i8 %37 to i32, !dbg !545
  %38 = load i8, i8* %a, align 1, !dbg !546
  %conv60 = zext i8 %38 to i32, !dbg !547
  %xor61 = xor i32 %conv59, %conv60, !dbg !548
  %conv62 = trunc i32 %xor61 to i8, !dbg !549
  %call63 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv62), !dbg !550
  %conv64 = zext i8 %call63 to i32, !dbg !551
  %xor65 = xor i32 %conv58, %conv64, !dbg !552
  %39 = load i8*, i8** %buf.addr, align 8, !dbg !553
  %40 = load i32, i32* %_in_s_i, align 4, !dbg !554
  %add66 = add nsw i32 %40, 3, !dbg !555
  %idxprom67 = sext i32 %add66 to i64, !dbg !553
  %arrayidx68 = getelementptr inbounds i8, i8* %39, i64 %idxprom67, !dbg !553
  %41 = load i8, i8* %arrayidx68, align 1, !dbg !556
  %conv69 = zext i8 %41 to i32, !dbg !556
  %xor70 = xor i32 %conv69, %xor65, !dbg !556
  %conv71 = trunc i32 %xor70 to i8, !dbg !556
  store i8 %conv71, i8* %arrayidx68, align 1, !dbg !556
  br label %for.inc, !dbg !557

for.inc:                                          ; preds = %for.body
  %42 = load i32, i32* %_s_i, align 4, !dbg !558
  %inc = add nsw i32 %42, 1, !dbg !558
  store i32 %inc, i32* %_s_i, align 4, !dbg !558
  br label %for.cond, !dbg !559, !llvm.loop !560

for.end:                                          ; preds = %for.cond
  store i32 16, i32* %_s_i, align 4, !dbg !562
  %43 = load i32, i32* %_s_i, align 4, !dbg !563
  %conv72 = trunc i32 %43 to i8, !dbg !563
  store i8 %conv72, i8* %i, align 1, !dbg !564
  ret void, !dbg !565
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_addRoundKey_1(i8* %buf, i8* %key) #0 !dbg !566 {
entry:
  %buf.addr = alloca i8*, align 8
  %key.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buf.addr, metadata !567, metadata !DIExpression()), !dbg !568
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !569, metadata !DIExpression()), !dbg !570
  call void @llvm.dbg.declare(metadata i8* %i, metadata !571, metadata !DIExpression()), !dbg !572
  store i8 16, i8* %i, align 1, !dbg !572
  br label %addkey, !dbg !573

addkey:                                           ; preds = %entry
  call void @llvm.dbg.label(metadata !574), !dbg !575
  br label %while.cond, !dbg !576

while.cond:                                       ; preds = %while.body, %addkey
  %0 = load i8, i8* %i, align 1, !dbg !577
  %dec = add i8 %0, -1, !dbg !577
  store i8 %dec, i8* %i, align 1, !dbg !577
  %tobool = icmp ne i8 %0, 0, !dbg !576
  br i1 %tobool, label %while.body, label %while.end, !dbg !576

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %key.addr, align 8, !dbg !578
  %2 = load i8, i8* %i, align 1, !dbg !579
  %idxprom = zext i8 %2 to i64, !dbg !578
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom, !dbg !578
  %3 = load i8, i8* %arrayidx, align 1, !dbg !578
  %conv = zext i8 %3 to i32, !dbg !580
  %4 = load i8*, i8** %buf.addr, align 8, !dbg !581
  %5 = load i8, i8* %i, align 1, !dbg !582
  %idxprom1 = zext i8 %5 to i64, !dbg !581
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 %idxprom1, !dbg !581
  %6 = load i8, i8* %arrayidx2, align 1, !dbg !583
  %conv3 = zext i8 %6 to i32, !dbg !583
  %xor = xor i32 %conv3, %conv, !dbg !583
  %conv4 = trunc i32 %xor to i8, !dbg !583
  store i8 %conv4, i8* %arrayidx2, align 1, !dbg !583
  br label %while.cond, !dbg !576, !llvm.loop !584

while.end:                                        ; preds = %while.cond
  ret void, !dbg !586
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i8 @rj_xtime_1(i8 zeroext %x) #0 !dbg !587 {
entry:
  %x.addr = alloca i8, align 1
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !590, metadata !DIExpression()), !dbg !591
  %0 = load i8, i8* %x.addr, align 1, !dbg !592
  %conv = zext i8 %0 to i32, !dbg !593
  %and = and i32 %conv, 128, !dbg !594
  %tobool = icmp ne i32 %and, 0, !dbg !594
  br i1 %tobool, label %cond.true, label %cond.false, !dbg !595

cond.true:                                        ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1, !dbg !596
  %conv1 = zext i8 %1 to i32, !dbg !597
  %shl = shl i32 %conv1, 1, !dbg !598
  %xor = xor i32 %shl, 27, !dbg !599
  br label %cond.end, !dbg !595

cond.false:                                       ; preds = %entry
  %2 = load i8, i8* %x.addr, align 1, !dbg !600
  %conv2 = zext i8 %2 to i32, !dbg !601
  %shl3 = shl i32 %conv2, 1, !dbg !602
  br label %cond.end, !dbg !595

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %xor, %cond.true ], [ %shl3, %cond.false ], !dbg !595
  %conv4 = trunc i32 %cond to i8, !dbg !603
  ret i8 %conv4, !dbg !604
}

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sbox", scope: !2, file: !3, line: 1, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !8, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "aes.c", directory: "/share/atefehSZ/RL/original-software-gnn/software-gnn/dse_database/multi_modality/machsuite/aes")
!4 = !{}
!5 = !{!6, !7}
!6 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!0}
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 2048, elements: !11)
!10 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!11 = !{!12}
!12 = !DISubrange(count: 256)
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!17 = distinct !DISubprogram(name: "aes256_encrypt_ecb", scope: !3, file: !3, line: 112, type: !18, scopeLine: 113, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{null, !20, !30, !30}
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "aes256_context", file: !3, line: 2, baseType: !22)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 2, size: 768, elements: !23)
!23 = !{!24, !28, !29}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !22, file: !3, line: 2, baseType: !25, size: 256)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 256, elements: !26)
!26 = !{!27}
!27 = !DISubrange(count: 32)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "enckey", scope: !22, file: !3, line: 2, baseType: !25, size: 256, offset: 256)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "deckey", scope: !22, file: !3, line: 2, baseType: !25, size: 256, offset: 512)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!31 = !DILocalVariable(name: "ctx", arg: 1, scope: !17, file: !3, line: 112, type: !20)
!32 = !DILocation(line: 112, column: 41, scope: !17)
!33 = !DILocalVariable(name: "k", arg: 2, scope: !17, file: !3, line: 112, type: !30)
!34 = !DILocation(line: 112, column: 59, scope: !17)
!35 = !DILocalVariable(name: "buf", arg: 3, scope: !17, file: !3, line: 112, type: !30)
!36 = !DILocation(line: 112, column: 79, scope: !17)
!37 = !DILocalVariable(name: "rcon", scope: !17, file: !3, line: 115, type: !6)
!38 = !DILocation(line: 115, column: 17, scope: !17)
!39 = !DILocalVariable(name: "i", scope: !17, file: !3, line: 116, type: !6)
!40 = !DILocation(line: 116, column: 17, scope: !17)
!41 = !DILocalVariable(name: "_s_i_0", scope: !17, file: !3, line: 117, type: !7)
!42 = !DILocation(line: 117, column: 7, scope: !17)
!43 = !DILocation(line: 117, column: 3, scope: !17)
!44 = !DILabel(scope: !17, name: "ecb1", file: !3, line: 118)
!45 = !DILocation(line: 118, column: 3, scope: !17)
!46 = !DILocation(line: 120, column: 15, scope: !47)
!47 = distinct !DILexicalBlock(scope: !17, file: !3, line: 120, column: 3)
!48 = !DILocation(line: 120, column: 8, scope: !47)
!49 = !DILocation(line: 120, column: 38, scope: !50)
!50 = distinct !DILexicalBlock(scope: !47, file: !3, line: 120, column: 3)
!51 = !DILocation(line: 120, column: 45, scope: !50)
!52 = !DILocation(line: 120, column: 3, scope: !47)
!53 = !DILocation(line: 121, column: 53, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !3, line: 120, column: 62)
!55 = !DILocation(line: 121, column: 55, scope: !54)
!56 = !DILocation(line: 121, column: 29, scope: !54)
!57 = !DILocation(line: 121, column: 36, scope: !54)
!58 = !DILocation(line: 121, column: 43, scope: !54)
!59 = !DILocation(line: 121, column: 51, scope: !54)
!60 = !DILocation(line: 121, column: 5, scope: !54)
!61 = !DILocation(line: 121, column: 12, scope: !54)
!62 = !DILocation(line: 121, column: 19, scope: !54)
!63 = !DILocation(line: 121, column: 27, scope: !54)
!64 = !DILocation(line: 122, column: 3, scope: !54)
!65 = !DILocation(line: 120, column: 52, scope: !50)
!66 = !DILocation(line: 120, column: 3, scope: !50)
!67 = distinct !{!67, !52, !68, !69}
!68 = !DILocation(line: 122, column: 3, scope: !47)
!69 = !{!"llvm.loop.mustprogress"}
!70 = !DILocation(line: 123, column: 7, scope: !17)
!71 = !DILocation(line: 123, column: 5, scope: !17)
!72 = !DILocation(line: 123, column: 3, scope: !17)
!73 = !DILabel(scope: !17, name: "ecb2", file: !3, line: 126)
!74 = !DILocation(line: 126, column: 3, scope: !17)
!75 = !DILocation(line: 127, column: 10, scope: !76)
!76 = distinct !DILexicalBlock(scope: !17, file: !3, line: 127, column: 3)
!77 = !DILocation(line: 127, column: 8, scope: !76)
!78 = !DILocation(line: 127, column: 33, scope: !79)
!79 = distinct !DILexicalBlock(scope: !76, file: !3, line: 127, column: 3)
!80 = !DILocation(line: 127, column: 3, scope: !76)
!81 = !DILocation(line: 128, column: 24, scope: !82)
!82 = distinct !DILexicalBlock(scope: !79, file: !3, line: 127, column: 40)
!83 = !DILocation(line: 128, column: 31, scope: !82)
!84 = !DILocation(line: 128, column: 5, scope: !82)
!85 = !DILocation(line: 127, column: 3, scope: !79)
!86 = distinct !{!86, !80, !87, !69}
!87 = !DILocation(line: 129, column: 3, scope: !76)
!88 = !DILocation(line: 131, column: 25, scope: !17)
!89 = !DILocation(line: 131, column: 29, scope: !17)
!90 = !DILocation(line: 131, column: 36, scope: !17)
!91 = !DILocation(line: 131, column: 43, scope: !17)
!92 = !DILocation(line: 131, column: 50, scope: !17)
!93 = !DILocation(line: 131, column: 3, scope: !17)
!94 = !DILocalVariable(name: "_s_i", scope: !17, file: !3, line: 132, type: !7)
!95 = !DILocation(line: 132, column: 7, scope: !17)
!96 = !DILocation(line: 133, column: 8, scope: !17)
!97 = !DILocation(line: 133, column: 3, scope: !17)
!98 = !DILabel(scope: !17, name: "ecb3", file: !3, line: 138)
!99 = !DILocation(line: 138, column: 3, scope: !17)
!100 = !DILocation(line: 140, column: 13, scope: !101)
!101 = distinct !DILexicalBlock(scope: !17, file: !3, line: 140, column: 3)
!102 = !DILocation(line: 140, column: 8, scope: !101)
!103 = !DILocation(line: 140, column: 36, scope: !104)
!104 = distinct !DILexicalBlock(scope: !101, file: !3, line: 140, column: 3)
!105 = !DILocation(line: 140, column: 41, scope: !104)
!106 = !DILocation(line: 140, column: 3, scope: !101)
!107 = !DILocation(line: 141, column: 20, scope: !108)
!108 = distinct !DILexicalBlock(scope: !104, file: !3, line: 140, column: 56)
!109 = !DILocation(line: 141, column: 5, scope: !108)
!110 = !DILocation(line: 142, column: 21, scope: !108)
!111 = !DILocation(line: 142, column: 5, scope: !108)
!112 = !DILocation(line: 143, column: 22, scope: !108)
!113 = !DILocation(line: 143, column: 5, scope: !108)
!114 = !DILocation(line: 144, column: 16, scope: !115)
!115 = distinct !DILexicalBlock(scope: !108, file: !3, line: 144, column: 9)
!116 = !DILocation(line: 144, column: 22, scope: !115)
!117 = !DILocation(line: 144, column: 9, scope: !108)
!118 = !DILocation(line: 145, column: 25, scope: !119)
!119 = distinct !DILexicalBlock(scope: !115, file: !3, line: 144, column: 27)
!120 = !DILocation(line: 145, column: 30, scope: !119)
!121 = !DILocation(line: 145, column: 37, scope: !119)
!122 = !DILocation(line: 145, column: 7, scope: !119)
!123 = !DILocation(line: 146, column: 5, scope: !119)
!124 = !DILocation(line: 148, column: 27, scope: !125)
!125 = distinct !DILexicalBlock(scope: !115, file: !3, line: 147, column: 11)
!126 = !DILocation(line: 148, column: 34, scope: !125)
!127 = !DILocation(line: 148, column: 8, scope: !125)
!128 = !DILocation(line: 148, column: 65, scope: !125)
!129 = !DILocation(line: 148, column: 69, scope: !125)
!130 = !DILocation(line: 148, column: 76, scope: !125)
!131 = !DILocation(line: 148, column: 47, scope: !125)
!132 = !DILocation(line: 150, column: 3, scope: !108)
!133 = !DILocation(line: 140, column: 48, scope: !104)
!134 = !DILocation(line: 140, column: 3, scope: !104)
!135 = distinct !{!135, !106, !136, !69}
!136 = !DILocation(line: 150, column: 3, scope: !101)
!137 = !DILocation(line: 151, column: 7, scope: !17)
!138 = !DILocation(line: 151, column: 5, scope: !17)
!139 = !DILocation(line: 152, column: 18, scope: !17)
!140 = !DILocation(line: 152, column: 3, scope: !17)
!141 = !DILocation(line: 153, column: 19, scope: !17)
!142 = !DILocation(line: 153, column: 3, scope: !17)
!143 = !DILocation(line: 154, column: 22, scope: !17)
!144 = !DILocation(line: 154, column: 29, scope: !17)
!145 = !DILocation(line: 154, column: 3, scope: !17)
!146 = !DILocation(line: 155, column: 21, scope: !17)
!147 = !DILocation(line: 155, column: 25, scope: !17)
!148 = !DILocation(line: 155, column: 32, scope: !17)
!149 = !DILocation(line: 155, column: 3, scope: !17)
!150 = !DILocation(line: 157, column: 1, scope: !17)
!151 = distinct !DISubprogram(name: "aes_expandEncKey_1", scope: !3, file: !3, line: 4, type: !152, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!152 = !DISubroutineType(types: !153)
!153 = !{null, !30, !30}
!154 = !DILocalVariable(name: "k", arg: 1, scope: !151, file: !3, line: 4, type: !30)
!155 = !DILocation(line: 4, column: 47, scope: !151)
!156 = !DILocalVariable(name: "rc", arg: 2, scope: !151, file: !3, line: 4, type: !30)
!157 = !DILocation(line: 4, column: 64, scope: !151)
!158 = !DILocalVariable(name: "i", scope: !151, file: !3, line: 6, type: !6)
!159 = !DILocation(line: 6, column: 26, scope: !151)
!160 = !DILocation(line: 7, column: 23, scope: !151)
!161 = !DILocation(line: 7, column: 18, scope: !151)
!162 = !DILocation(line: 7, column: 12, scope: !151)
!163 = !DILocation(line: 7, column: 43, scope: !151)
!164 = !DILocation(line: 7, column: 42, scope: !151)
!165 = !DILocation(line: 7, column: 34, scope: !151)
!166 = !DILocation(line: 7, column: 31, scope: !151)
!167 = !DILocation(line: 7, column: 3, scope: !151)
!168 = !DILocation(line: 7, column: 8, scope: !151)
!169 = !DILocation(line: 8, column: 23, scope: !151)
!170 = !DILocation(line: 8, column: 18, scope: !151)
!171 = !DILocation(line: 8, column: 12, scope: !151)
!172 = !DILocation(line: 8, column: 3, scope: !151)
!173 = !DILocation(line: 8, column: 8, scope: !151)
!174 = !DILocation(line: 9, column: 23, scope: !151)
!175 = !DILocation(line: 9, column: 18, scope: !151)
!176 = !DILocation(line: 9, column: 12, scope: !151)
!177 = !DILocation(line: 9, column: 3, scope: !151)
!178 = !DILocation(line: 9, column: 8, scope: !151)
!179 = !DILocation(line: 10, column: 23, scope: !151)
!180 = !DILocation(line: 10, column: 18, scope: !151)
!181 = !DILocation(line: 10, column: 12, scope: !151)
!182 = !DILocation(line: 10, column: 3, scope: !151)
!183 = !DILocation(line: 10, column: 8, scope: !151)
!184 = !DILocation(line: 11, column: 38, scope: !151)
!185 = !DILocation(line: 11, column: 37, scope: !151)
!186 = !DILocation(line: 11, column: 29, scope: !151)
!187 = !DILocation(line: 11, column: 43, scope: !151)
!188 = !DILocation(line: 11, column: 61, scope: !151)
!189 = !DILocation(line: 11, column: 60, scope: !151)
!190 = !DILocation(line: 11, column: 52, scope: !151)
!191 = !DILocation(line: 11, column: 66, scope: !151)
!192 = !DILocation(line: 11, column: 71, scope: !151)
!193 = !DILocation(line: 11, column: 76, scope: !151)
!194 = !DILocation(line: 11, column: 48, scope: !151)
!195 = !DILocation(line: 11, column: 11, scope: !151)
!196 = !DILocation(line: 11, column: 5, scope: !151)
!197 = !DILocation(line: 11, column: 8, scope: !151)
!198 = !DILocation(line: 11, column: 4, scope: !151)
!199 = !DILabel(scope: !151, name: "exp1", file: !3, line: 12)
!200 = !DILocation(line: 12, column: 3, scope: !151)
!201 = !DILocation(line: 13, column: 10, scope: !202)
!202 = distinct !DILexicalBlock(scope: !151, file: !3, line: 13, column: 3)
!203 = !DILocation(line: 13, column: 8, scope: !202)
!204 = !DILocation(line: 13, column: 40, scope: !205)
!205 = distinct !DILexicalBlock(scope: !202, file: !3, line: 13, column: 3)
!206 = !DILocation(line: 13, column: 34, scope: !205)
!207 = !DILocation(line: 13, column: 43, scope: !205)
!208 = !DILocation(line: 13, column: 3, scope: !202)
!209 = !DILocation(line: 14, column: 23, scope: !205)
!210 = !DILocation(line: 14, column: 32, scope: !205)
!211 = !DILocation(line: 14, column: 26, scope: !205)
!212 = !DILocation(line: 14, column: 35, scope: !205)
!213 = !DILocation(line: 14, column: 17, scope: !205)
!214 = !DILocation(line: 14, column: 8, scope: !205)
!215 = !DILocation(line: 14, column: 10, scope: !205)
!216 = !DILocation(line: 14, column: 13, scope: !205)
!217 = !DILocation(line: 14, column: 70, scope: !205)
!218 = !DILocation(line: 14, column: 79, scope: !205)
!219 = !DILocation(line: 14, column: 73, scope: !205)
!220 = !DILocation(line: 14, column: 82, scope: !205)
!221 = !DILocation(line: 14, column: 64, scope: !205)
!222 = !DILocation(line: 14, column: 43, scope: !205)
!223 = !DILocation(line: 14, column: 52, scope: !205)
!224 = !DILocation(line: 14, column: 46, scope: !205)
!225 = !DILocation(line: 14, column: 55, scope: !205)
!226 = !DILocation(line: 14, column: 60, scope: !205)
!227 = !DILocation(line: 14, column: 118, scope: !205)
!228 = !DILocation(line: 14, column: 127, scope: !205)
!229 = !DILocation(line: 14, column: 121, scope: !205)
!230 = !DILocation(line: 14, column: 130, scope: !205)
!231 = !DILocation(line: 14, column: 112, scope: !205)
!232 = !DILocation(line: 14, column: 91, scope: !205)
!233 = !DILocation(line: 14, column: 100, scope: !205)
!234 = !DILocation(line: 14, column: 94, scope: !205)
!235 = !DILocation(line: 14, column: 103, scope: !205)
!236 = !DILocation(line: 14, column: 108, scope: !205)
!237 = !DILocation(line: 14, column: 166, scope: !205)
!238 = !DILocation(line: 14, column: 175, scope: !205)
!239 = !DILocation(line: 14, column: 169, scope: !205)
!240 = !DILocation(line: 14, column: 178, scope: !205)
!241 = !DILocation(line: 14, column: 160, scope: !205)
!242 = !DILocation(line: 14, column: 139, scope: !205)
!243 = !DILocation(line: 14, column: 148, scope: !205)
!244 = !DILocation(line: 14, column: 142, scope: !205)
!245 = !DILocation(line: 14, column: 151, scope: !205)
!246 = !DILocation(line: 14, column: 156, scope: !205)
!247 = !DILocation(line: 14, column: 5, scope: !205)
!248 = !DILocation(line: 13, column: 51, scope: !205)
!249 = !DILocation(line: 13, column: 3, scope: !205)
!250 = distinct !{!250, !208, !251, !69}
!251 = !DILocation(line: 14, column: 183, scope: !202)
!252 = !DILocation(line: 15, column: 24, scope: !151)
!253 = !DILocation(line: 15, column: 19, scope: !151)
!254 = !DILocation(line: 15, column: 13, scope: !151)
!255 = !DILocation(line: 15, column: 3, scope: !151)
!256 = !DILocation(line: 15, column: 9, scope: !151)
!257 = !DILocation(line: 16, column: 24, scope: !151)
!258 = !DILocation(line: 16, column: 19, scope: !151)
!259 = !DILocation(line: 16, column: 13, scope: !151)
!260 = !DILocation(line: 16, column: 3, scope: !151)
!261 = !DILocation(line: 16, column: 9, scope: !151)
!262 = !DILocation(line: 17, column: 24, scope: !151)
!263 = !DILocation(line: 17, column: 19, scope: !151)
!264 = !DILocation(line: 17, column: 13, scope: !151)
!265 = !DILocation(line: 17, column: 3, scope: !151)
!266 = !DILocation(line: 17, column: 9, scope: !151)
!267 = !DILocation(line: 18, column: 24, scope: !151)
!268 = !DILocation(line: 18, column: 19, scope: !151)
!269 = !DILocation(line: 18, column: 13, scope: !151)
!270 = !DILocation(line: 18, column: 3, scope: !151)
!271 = !DILocation(line: 18, column: 9, scope: !151)
!272 = !DILabel(scope: !151, name: "exp2", file: !3, line: 19)
!273 = !DILocation(line: 19, column: 3, scope: !151)
!274 = !DILocation(line: 20, column: 10, scope: !275)
!275 = distinct !DILexicalBlock(scope: !151, file: !3, line: 20, column: 3)
!276 = !DILocation(line: 20, column: 8, scope: !275)
!277 = !DILocation(line: 20, column: 41, scope: !278)
!278 = distinct !DILexicalBlock(scope: !275, file: !3, line: 20, column: 3)
!279 = !DILocation(line: 20, column: 35, scope: !278)
!280 = !DILocation(line: 20, column: 44, scope: !278)
!281 = !DILocation(line: 20, column: 3, scope: !275)
!282 = !DILocation(line: 21, column: 23, scope: !278)
!283 = !DILocation(line: 21, column: 32, scope: !278)
!284 = !DILocation(line: 21, column: 26, scope: !278)
!285 = !DILocation(line: 21, column: 35, scope: !278)
!286 = !DILocation(line: 21, column: 17, scope: !278)
!287 = !DILocation(line: 21, column: 8, scope: !278)
!288 = !DILocation(line: 21, column: 10, scope: !278)
!289 = !DILocation(line: 21, column: 13, scope: !278)
!290 = !DILocation(line: 21, column: 70, scope: !278)
!291 = !DILocation(line: 21, column: 79, scope: !278)
!292 = !DILocation(line: 21, column: 73, scope: !278)
!293 = !DILocation(line: 21, column: 82, scope: !278)
!294 = !DILocation(line: 21, column: 64, scope: !278)
!295 = !DILocation(line: 21, column: 43, scope: !278)
!296 = !DILocation(line: 21, column: 52, scope: !278)
!297 = !DILocation(line: 21, column: 46, scope: !278)
!298 = !DILocation(line: 21, column: 55, scope: !278)
!299 = !DILocation(line: 21, column: 60, scope: !278)
!300 = !DILocation(line: 21, column: 118, scope: !278)
!301 = !DILocation(line: 21, column: 127, scope: !278)
!302 = !DILocation(line: 21, column: 121, scope: !278)
!303 = !DILocation(line: 21, column: 130, scope: !278)
!304 = !DILocation(line: 21, column: 112, scope: !278)
!305 = !DILocation(line: 21, column: 91, scope: !278)
!306 = !DILocation(line: 21, column: 100, scope: !278)
!307 = !DILocation(line: 21, column: 94, scope: !278)
!308 = !DILocation(line: 21, column: 103, scope: !278)
!309 = !DILocation(line: 21, column: 108, scope: !278)
!310 = !DILocation(line: 21, column: 166, scope: !278)
!311 = !DILocation(line: 21, column: 175, scope: !278)
!312 = !DILocation(line: 21, column: 169, scope: !278)
!313 = !DILocation(line: 21, column: 178, scope: !278)
!314 = !DILocation(line: 21, column: 160, scope: !278)
!315 = !DILocation(line: 21, column: 139, scope: !278)
!316 = !DILocation(line: 21, column: 148, scope: !278)
!317 = !DILocation(line: 21, column: 142, scope: !278)
!318 = !DILocation(line: 21, column: 151, scope: !278)
!319 = !DILocation(line: 21, column: 156, scope: !278)
!320 = !DILocation(line: 21, column: 5, scope: !278)
!321 = !DILocation(line: 20, column: 52, scope: !278)
!322 = !DILocation(line: 20, column: 3, scope: !278)
!323 = distinct !{!323, !281, !324, !69}
!324 = !DILocation(line: 21, column: 183, scope: !275)
!325 = !DILocation(line: 23, column: 1, scope: !151)
!326 = distinct !DISubprogram(name: "aes_addRoundKey_cpy_1", scope: !3, file: !3, line: 25, type: !327, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!327 = !DISubroutineType(types: !328)
!328 = !{null, !30, !30, !30}
!329 = !DILocalVariable(name: "buf", arg: 1, scope: !326, file: !3, line: 25, type: !30)
!330 = !DILocation(line: 25, column: 50, scope: !326)
!331 = !DILocalVariable(name: "key", arg: 2, scope: !326, file: !3, line: 25, type: !30)
!332 = !DILocation(line: 25, column: 69, scope: !326)
!333 = !DILocalVariable(name: "cpk", arg: 3, scope: !326, file: !3, line: 25, type: !30)
!334 = !DILocation(line: 25, column: 88, scope: !326)
!335 = !DILocalVariable(name: "i", scope: !326, file: !3, line: 27, type: !6)
!336 = !DILocation(line: 27, column: 26, scope: !326)
!337 = !DILocation(line: 27, column: 3, scope: !326)
!338 = !DILabel(scope: !326, name: "cpkey", file: !3, line: 28)
!339 = !DILocation(line: 28, column: 3, scope: !326)
!340 = !DILocation(line: 29, column: 3, scope: !326)
!341 = !DILocation(line: 29, column: 10, scope: !326)
!342 = !DILocation(line: 30, column: 33, scope: !326)
!343 = !DILocation(line: 30, column: 37, scope: !326)
!344 = !DILocation(line: 30, column: 24, scope: !326)
!345 = !DILocation(line: 30, column: 28, scope: !326)
!346 = !DILocation(line: 30, column: 31, scope: !326)
!347 = !DILocation(line: 30, column: 17, scope: !326)
!348 = !DILocation(line: 30, column: 6, scope: !326)
!349 = !DILocation(line: 30, column: 10, scope: !326)
!350 = !DILocation(line: 30, column: 13, scope: !326)
!351 = !DILocation(line: 30, column: 66, scope: !326)
!352 = !DILocation(line: 30, column: 82, scope: !326)
!353 = !DILocation(line: 30, column: 76, scope: !326)
!354 = !DILocation(line: 30, column: 73, scope: !326)
!355 = !DILocation(line: 30, column: 44, scope: !326)
!356 = !DILocation(line: 30, column: 60, scope: !326)
!357 = !DILocation(line: 30, column: 54, scope: !326)
!358 = !DILocation(line: 30, column: 51, scope: !326)
!359 = !DILocation(line: 30, column: 64, scope: !326)
!360 = distinct !{!360, !340, !361, !69}
!361 = !DILocation(line: 30, column: 85, scope: !326)
!362 = !DILocation(line: 32, column: 1, scope: !326)
!363 = distinct !DISubprogram(name: "aes_subBytes_1", scope: !3, file: !3, line: 34, type: !364, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!364 = !DISubroutineType(types: !365)
!365 = !{null, !30}
!366 = !DILocalVariable(name: "buf", arg: 1, scope: !363, file: !3, line: 34, type: !30)
!367 = !DILocation(line: 34, column: 43, scope: !363)
!368 = !DILocalVariable(name: "i", scope: !363, file: !3, line: 36, type: !6)
!369 = !DILocation(line: 36, column: 26, scope: !363)
!370 = !DILocation(line: 36, column: 3, scope: !363)
!371 = !DILabel(scope: !363, name: "sub", file: !3, line: 37)
!372 = !DILocation(line: 37, column: 3, scope: !363)
!373 = !DILocation(line: 38, column: 3, scope: !363)
!374 = !DILocation(line: 38, column: 10, scope: !363)
!375 = !DILocation(line: 39, column: 19, scope: !363)
!376 = !DILocation(line: 39, column: 23, scope: !363)
!377 = !DILocation(line: 39, column: 14, scope: !363)
!378 = !DILocation(line: 39, column: 5, scope: !363)
!379 = !DILocation(line: 39, column: 9, scope: !363)
!380 = !DILocation(line: 39, column: 12, scope: !363)
!381 = distinct !{!381, !373, !382, !69}
!382 = !DILocation(line: 39, column: 25, scope: !363)
!383 = !DILocation(line: 41, column: 1, scope: !363)
!384 = distinct !DISubprogram(name: "aes_shiftRows_1", scope: !3, file: !3, line: 43, type: !364, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!385 = !DILocalVariable(name: "buf", arg: 1, scope: !384, file: !3, line: 43, type: !30)
!386 = !DILocation(line: 43, column: 44, scope: !384)
!387 = !DILocalVariable(name: "i", scope: !384, file: !3, line: 46, type: !6)
!388 = !DILocation(line: 46, column: 26, scope: !384)
!389 = !DILocalVariable(name: "j", scope: !384, file: !3, line: 47, type: !6)
!390 = !DILocation(line: 47, column: 26, scope: !384)
!391 = !DILocation(line: 48, column: 7, scope: !384)
!392 = !DILocation(line: 48, column: 5, scope: !384)
!393 = !DILocation(line: 49, column: 12, scope: !384)
!394 = !DILocation(line: 49, column: 3, scope: !384)
!395 = !DILocation(line: 49, column: 10, scope: !384)
!396 = !DILocation(line: 50, column: 12, scope: !384)
!397 = !DILocation(line: 50, column: 3, scope: !384)
!398 = !DILocation(line: 50, column: 10, scope: !384)
!399 = !DILocation(line: 51, column: 12, scope: !384)
!400 = !DILocation(line: 51, column: 3, scope: !384)
!401 = !DILocation(line: 51, column: 10, scope: !384)
!402 = !DILocation(line: 52, column: 13, scope: !384)
!403 = !DILocation(line: 52, column: 3, scope: !384)
!404 = !DILocation(line: 52, column: 11, scope: !384)
!405 = !DILocation(line: 53, column: 7, scope: !384)
!406 = !DILocation(line: 53, column: 5, scope: !384)
!407 = !DILocation(line: 54, column: 13, scope: !384)
!408 = !DILocation(line: 54, column: 3, scope: !384)
!409 = !DILocation(line: 54, column: 11, scope: !384)
!410 = !DILocation(line: 55, column: 12, scope: !384)
!411 = !DILocation(line: 55, column: 3, scope: !384)
!412 = !DILocation(line: 55, column: 10, scope: !384)
!413 = !DILocation(line: 56, column: 7, scope: !384)
!414 = !DILocation(line: 56, column: 5, scope: !384)
!415 = !DILocation(line: 57, column: 12, scope: !384)
!416 = !DILocation(line: 57, column: 3, scope: !384)
!417 = !DILocation(line: 57, column: 10, scope: !384)
!418 = !DILocation(line: 58, column: 13, scope: !384)
!419 = !DILocation(line: 58, column: 3, scope: !384)
!420 = !DILocation(line: 58, column: 11, scope: !384)
!421 = !DILocation(line: 59, column: 13, scope: !384)
!422 = !DILocation(line: 59, column: 3, scope: !384)
!423 = !DILocation(line: 59, column: 11, scope: !384)
!424 = !DILocation(line: 60, column: 12, scope: !384)
!425 = !DILocation(line: 60, column: 3, scope: !384)
!426 = !DILocation(line: 60, column: 10, scope: !384)
!427 = !DILocation(line: 61, column: 7, scope: !384)
!428 = !DILocation(line: 61, column: 5, scope: !384)
!429 = !DILocation(line: 62, column: 13, scope: !384)
!430 = !DILocation(line: 62, column: 3, scope: !384)
!431 = !DILocation(line: 62, column: 11, scope: !384)
!432 = !DILocation(line: 63, column: 12, scope: !384)
!433 = !DILocation(line: 63, column: 3, scope: !384)
!434 = !DILocation(line: 63, column: 10, scope: !384)
!435 = !DILocation(line: 65, column: 1, scope: !384)
!436 = distinct !DISubprogram(name: "aes_mixColumns_1", scope: !3, file: !3, line: 73, type: !364, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!437 = !DILocalVariable(name: "buf", arg: 1, scope: !436, file: !3, line: 73, type: !30)
!438 = !DILocation(line: 73, column: 45, scope: !436)
!439 = !DILocalVariable(name: "i", scope: !436, file: !3, line: 75, type: !6)
!440 = !DILocation(line: 75, column: 26, scope: !436)
!441 = !DILocalVariable(name: "a", scope: !436, file: !3, line: 76, type: !6)
!442 = !DILocation(line: 76, column: 26, scope: !436)
!443 = !DILocalVariable(name: "b", scope: !436, file: !3, line: 77, type: !6)
!444 = !DILocation(line: 77, column: 26, scope: !436)
!445 = !DILocalVariable(name: "c", scope: !436, file: !3, line: 78, type: !6)
!446 = !DILocation(line: 78, column: 26, scope: !436)
!447 = !DILocalVariable(name: "d", scope: !436, file: !3, line: 79, type: !6)
!448 = !DILocation(line: 79, column: 26, scope: !436)
!449 = !DILocalVariable(name: "e", scope: !436, file: !3, line: 80, type: !6)
!450 = !DILocation(line: 80, column: 26, scope: !436)
!451 = !DILocalVariable(name: "_s_i", scope: !436, file: !3, line: 81, type: !7)
!452 = !DILocation(line: 81, column: 7, scope: !436)
!453 = !DILocation(line: 81, column: 3, scope: !436)
!454 = !DILabel(scope: !436, name: "mix", file: !3, line: 82)
!455 = !DILocation(line: 82, column: 3, scope: !436)
!456 = !DILocation(line: 85, column: 13, scope: !457)
!457 = distinct !DILexicalBlock(scope: !436, file: !3, line: 85, column: 3)
!458 = !DILocation(line: 85, column: 8, scope: !457)
!459 = !DILocation(line: 85, column: 18, scope: !460)
!460 = distinct !DILexicalBlock(scope: !457, file: !3, line: 85, column: 3)
!461 = !DILocation(line: 85, column: 23, scope: !460)
!462 = !DILocation(line: 85, column: 3, scope: !457)
!463 = !DILocalVariable(name: "_in_s_i", scope: !464, file: !3, line: 86, type: !7)
!464 = distinct !DILexicalBlock(scope: !460, file: !3, line: 85, column: 37)
!465 = !DILocation(line: 86, column: 9, scope: !464)
!466 = !DILocation(line: 86, column: 28, scope: !464)
!467 = !DILocation(line: 86, column: 26, scope: !464)
!468 = !DILocation(line: 86, column: 21, scope: !464)
!469 = !DILocation(line: 86, column: 19, scope: !464)
!470 = !DILocation(line: 87, column: 9, scope: !464)
!471 = !DILocation(line: 87, column: 13, scope: !464)
!472 = !DILocation(line: 87, column: 7, scope: !464)
!473 = !DILocation(line: 88, column: 9, scope: !464)
!474 = !DILocation(line: 88, column: 20, scope: !464)
!475 = !DILocation(line: 88, column: 29, scope: !464)
!476 = !DILocation(line: 88, column: 7, scope: !464)
!477 = !DILocation(line: 89, column: 9, scope: !464)
!478 = !DILocation(line: 89, column: 20, scope: !464)
!479 = !DILocation(line: 89, column: 29, scope: !464)
!480 = !DILocation(line: 89, column: 7, scope: !464)
!481 = !DILocation(line: 90, column: 9, scope: !464)
!482 = !DILocation(line: 90, column: 20, scope: !464)
!483 = !DILocation(line: 90, column: 29, scope: !464)
!484 = !DILocation(line: 90, column: 7, scope: !464)
!485 = !DILocation(line: 91, column: 34, scope: !464)
!486 = !DILocation(line: 91, column: 28, scope: !464)
!487 = !DILocation(line: 91, column: 46, scope: !464)
!488 = !DILocation(line: 91, column: 40, scope: !464)
!489 = !DILocation(line: 91, column: 37, scope: !464)
!490 = !DILocation(line: 91, column: 58, scope: !464)
!491 = !DILocation(line: 91, column: 52, scope: !464)
!492 = !DILocation(line: 91, column: 49, scope: !464)
!493 = !DILocation(line: 91, column: 70, scope: !464)
!494 = !DILocation(line: 91, column: 64, scope: !464)
!495 = !DILocation(line: 91, column: 61, scope: !464)
!496 = !DILocation(line: 91, column: 10, scope: !464)
!497 = !DILocation(line: 91, column: 7, scope: !464)
!498 = !DILocation(line: 92, column: 28, scope: !464)
!499 = !DILocation(line: 92, column: 22, scope: !464)
!500 = !DILocation(line: 92, column: 76, scope: !464)
!501 = !DILocation(line: 92, column: 70, scope: !464)
!502 = !DILocation(line: 92, column: 88, scope: !464)
!503 = !DILocation(line: 92, column: 82, scope: !464)
!504 = !DILocation(line: 92, column: 79, scope: !464)
!505 = !DILocation(line: 92, column: 52, scope: !464)
!506 = !DILocation(line: 92, column: 41, scope: !464)
!507 = !DILocation(line: 92, column: 34, scope: !464)
!508 = !DILocation(line: 92, column: 31, scope: !464)
!509 = !DILocation(line: 92, column: 5, scope: !464)
!510 = !DILocation(line: 92, column: 9, scope: !464)
!511 = !DILocation(line: 92, column: 18, scope: !464)
!512 = !DILocation(line: 93, column: 40, scope: !464)
!513 = !DILocation(line: 93, column: 34, scope: !464)
!514 = !DILocation(line: 93, column: 88, scope: !464)
!515 = !DILocation(line: 93, column: 82, scope: !464)
!516 = !DILocation(line: 93, column: 100, scope: !464)
!517 = !DILocation(line: 93, column: 94, scope: !464)
!518 = !DILocation(line: 93, column: 91, scope: !464)
!519 = !DILocation(line: 93, column: 64, scope: !464)
!520 = !DILocation(line: 93, column: 53, scope: !464)
!521 = !DILocation(line: 93, column: 46, scope: !464)
!522 = !DILocation(line: 93, column: 43, scope: !464)
!523 = !DILocation(line: 93, column: 5, scope: !464)
!524 = !DILocation(line: 93, column: 16, scope: !464)
!525 = !DILocation(line: 93, column: 25, scope: !464)
!526 = !DILocation(line: 93, column: 30, scope: !464)
!527 = !DILocation(line: 94, column: 40, scope: !464)
!528 = !DILocation(line: 94, column: 34, scope: !464)
!529 = !DILocation(line: 94, column: 88, scope: !464)
!530 = !DILocation(line: 94, column: 82, scope: !464)
!531 = !DILocation(line: 94, column: 100, scope: !464)
!532 = !DILocation(line: 94, column: 94, scope: !464)
!533 = !DILocation(line: 94, column: 91, scope: !464)
!534 = !DILocation(line: 94, column: 64, scope: !464)
!535 = !DILocation(line: 94, column: 53, scope: !464)
!536 = !DILocation(line: 94, column: 46, scope: !464)
!537 = !DILocation(line: 94, column: 43, scope: !464)
!538 = !DILocation(line: 94, column: 5, scope: !464)
!539 = !DILocation(line: 94, column: 16, scope: !464)
!540 = !DILocation(line: 94, column: 25, scope: !464)
!541 = !DILocation(line: 94, column: 30, scope: !464)
!542 = !DILocation(line: 95, column: 40, scope: !464)
!543 = !DILocation(line: 95, column: 34, scope: !464)
!544 = !DILocation(line: 95, column: 88, scope: !464)
!545 = !DILocation(line: 95, column: 82, scope: !464)
!546 = !DILocation(line: 95, column: 100, scope: !464)
!547 = !DILocation(line: 95, column: 94, scope: !464)
!548 = !DILocation(line: 95, column: 91, scope: !464)
!549 = !DILocation(line: 95, column: 64, scope: !464)
!550 = !DILocation(line: 95, column: 53, scope: !464)
!551 = !DILocation(line: 95, column: 46, scope: !464)
!552 = !DILocation(line: 95, column: 43, scope: !464)
!553 = !DILocation(line: 95, column: 5, scope: !464)
!554 = !DILocation(line: 95, column: 16, scope: !464)
!555 = !DILocation(line: 95, column: 25, scope: !464)
!556 = !DILocation(line: 95, column: 30, scope: !464)
!557 = !DILocation(line: 96, column: 3, scope: !464)
!558 = !DILocation(line: 85, column: 33, scope: !460)
!559 = !DILocation(line: 85, column: 3, scope: !460)
!560 = distinct !{!560, !462, !561, !69}
!561 = !DILocation(line: 96, column: 3, scope: !457)
!562 = !DILocation(line: 97, column: 8, scope: !436)
!563 = !DILocation(line: 98, column: 7, scope: !436)
!564 = !DILocation(line: 98, column: 5, scope: !436)
!565 = !DILocation(line: 100, column: 1, scope: !436)
!566 = distinct !DISubprogram(name: "aes_addRoundKey_1", scope: !3, file: !3, line: 102, type: !152, scopeLine: 103, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!567 = !DILocalVariable(name: "buf", arg: 1, scope: !566, file: !3, line: 102, type: !30)
!568 = !DILocation(line: 102, column: 46, scope: !566)
!569 = !DILocalVariable(name: "key", arg: 2, scope: !566, file: !3, line: 102, type: !30)
!570 = !DILocation(line: 102, column: 65, scope: !566)
!571 = !DILocalVariable(name: "i", scope: !566, file: !3, line: 104, type: !6)
!572 = !DILocation(line: 104, column: 26, scope: !566)
!573 = !DILocation(line: 104, column: 3, scope: !566)
!574 = !DILabel(scope: !566, name: "addkey", file: !3, line: 105)
!575 = !DILocation(line: 105, column: 3, scope: !566)
!576 = !DILocation(line: 106, column: 3, scope: !566)
!577 = !DILocation(line: 106, column: 10, scope: !566)
!578 = !DILocation(line: 107, column: 22, scope: !566)
!579 = !DILocation(line: 107, column: 26, scope: !566)
!580 = !DILocation(line: 107, column: 16, scope: !566)
!581 = !DILocation(line: 107, column: 5, scope: !566)
!582 = !DILocation(line: 107, column: 9, scope: !566)
!583 = !DILocation(line: 107, column: 12, scope: !566)
!584 = distinct !{!584, !576, !585, !69}
!585 = !DILocation(line: 107, column: 28, scope: !566)
!586 = !DILocation(line: 109, column: 1, scope: !566)
!587 = distinct !DISubprogram(name: "rj_xtime_1", scope: !3, file: !3, line: 67, type: !588, scopeLine: 68, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!588 = !DISubroutineType(types: !589)
!589 = !{!6, !6}
!590 = !DILocalVariable(name: "x", arg: 1, scope: !587, file: !3, line: 67, type: !6)
!591 = !DILocation(line: 67, column: 47, scope: !587)
!592 = !DILocation(line: 69, column: 34, scope: !587)
!593 = !DILocation(line: 69, column: 28, scope: !587)
!594 = !DILocation(line: 69, column: 37, scope: !587)
!595 = !DILocation(line: 69, column: 27, scope: !587)
!596 = !DILocation(line: 69, column: 51, scope: !587)
!597 = !DILocation(line: 69, column: 45, scope: !587)
!598 = !DILocation(line: 69, column: 54, scope: !587)
!599 = !DILocation(line: 69, column: 59, scope: !587)
!600 = !DILocation(line: 69, column: 75, scope: !587)
!601 = !DILocation(line: 69, column: 69, scope: !587)
!602 = !DILocation(line: 69, column: 78, scope: !587)
!603 = !DILocation(line: 69, column: 10, scope: !587)
!604 = !DILocation(line: 69, column: 3, scope: !587)
