; RUN: llc < %s -mtriple=x86_64-apple-macosx -enable-misched \
; RUN:          -verify-machineinstrs | FileCheck %s
;
; Test MachineScheduler handling of DBG_VALUE.
; rdar://12776937.
;
; CHECK: %if.else581
; CHECK: DEBUG_VALUE: num1
; CHECK: call

%union.rec = type {}

@.str15 = external hidden unnamed_addr constant [6 x i8], align 1

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

define i32 @AttachGalley(%union.rec** nocapture %suspend_pt) nounwind uwtable ssp {
entry:
  %num14075 = alloca [20 x i8], align 16
  br label %if.end33

if.end33:                                         ; preds = %entry
  %cmp1733 = icmp eq i32 undef, 0
  br label %if.else581

if.else581:                                       ; preds = %if.end33
  %cmp586 = icmp eq i8 undef, -123
  br i1 %cmp586, label %if.then588, label %if.else594

if.then588:                                       ; preds = %if.else581
  br label %for.cond1710.preheader

if.else594:                                       ; preds = %if.else581
  unreachable

for.cond1710.preheader:                           ; preds = %if.then588
  br label %for.cond1710

for.cond1710:                                     ; preds = %for.cond1710, %for.cond1710.preheader
  br i1 undef, label %for.cond1710, label %if.then3344

if.then3344:
  br label %if.then4073

if.then4073:                                      ; preds = %if.then3344
  call void @llvm.dbg.declare(metadata !{[20 x i8]* %num14075}, metadata !4)
  %arraydecay4078 = getelementptr inbounds [20 x i8]* %num14075, i64 0, i64 0
  %0 = load i32* undef, align 4
  %add4093 = add nsw i32 %0, 0
  %conv4094 = sitofp i32 %add4093 to float
  %div4095 = fdiv float %conv4094, 5.670000e+02
  %conv4096 = fpext float %div4095 to double
  %call4097 = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay4078, i32 0, i64 20, i8* getelementptr inbounds ([6 x i8]* @.str15, i64 0, i64 0), double %conv4096) nounwind
  br i1 %cmp1733, label %if.then4107, label %if.else4114

if.then4107:                                      ; preds = %if.then4073
  unreachable

if.else4114:                                      ; preds = %if.then4073
  unreachable
}

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...)

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 12, metadata !"MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c", metadata !"MultiSource/Benchmarks/MiBench/consumer-typeset", metadata !"clang version 3.3 (trunk 168918) (llvm/trunk 168920)", i1 true, i1 true, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [MultiSource/Benchmarks/MiBench/consumer-typeset/MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c] [DW_LANG_C99]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{}
!4 = metadata !{i32 786688, metadata !5, metadata !"num1", metadata !14, i32 815, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [num1] [line 815]
!5 = metadata !{i32 786443, metadata !6, i32 815, i32 0, metadata !14, i32 177} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!6 = metadata !{i32 786443, metadata !7, i32 812, i32 0, metadata !14, i32 176} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!7 = metadata !{i32 786443, metadata !8, i32 807, i32 0, metadata !14, i32 175} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!8 = metadata !{i32 786443, metadata !9, i32 440, i32 0, metadata !14, i32 94} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!9 = metadata !{i32 786443, metadata !10, i32 435, i32 0, metadata !14, i32 91} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!10 = metadata !{i32 786443, metadata !11, i32 434, i32 0, metadata !14, i32 90} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!11 = metadata !{i32 786443, metadata !12, i32 250, i32 0, metadata !14, i32 24} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!12 = metadata !{i32 786443, metadata !13, i32 249, i32 0, metadata !14, i32 23} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!13 = metadata !{i32 786443, metadata !3, i32 221, i32 0, metadata !14, i32 19} ; [ DW_TAG_lexical_block ] [MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c]
!14 = metadata !{i32 786473, metadata !"MultiSource/Benchmarks/MiBench/consumer-typeset/z19.c", metadata !"MultiSource/Benchmarks/MiBench/consumer-typeset", null} ; [ DW_TAG_file_type ]
!15 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 160, i64 8, i32 0, i32 0, metadata !16, metadata !17, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 160, align 8, offset 0] [from char]
!16 = metadata !{i32 786468, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!17 = metadata !{metadata !18}
!18 = metadata !{i32 786465, i64 0, i64 20}       ; [ DW_TAG_subrange_type ] [0, 19]
