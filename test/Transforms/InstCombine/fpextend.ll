; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define float @test(float %x) nounwind  {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP34:%.*]] = fadd float [[X:%.*]], 0.000000e+00
; CHECK-NEXT:    ret float [[TMP34]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp3 = fadd double %tmp1, 0.000000e+00
  %tmp34 = fptrunc double %tmp3 to float
  ret float %tmp34
}

define float @test2(float %x, float %y) nounwind  {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP56:%.*]] = fmul float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp23 = fpext float %y to double
  %tmp5 = fmul double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test3(float %x, float %y) nounwind  {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP56:%.*]] = fdiv float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp23 = fpext float %y to double
  %tmp5 = fdiv double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test4(float %x) nounwind  {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP34:%.*]] = fsub float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[TMP34]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp2 = fsub double -0.000000e+00, %tmp1
  %tmp34 = fptrunc double %tmp2 to float
  ret float %tmp34
}

; Test with vector splat constant
define <2 x float> @test5(<2 x float> %x) nounwind  {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = fpext <2 x float> [[X:%.*]] to <2 x double>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <2 x double> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP34:%.*]] = fptrunc <2 x double> [[TMP3]] to <2 x float>
; CHECK-NEXT:    ret <2 x float> [[TMP34]]
;
entry:
  %tmp1 = fpext <2 x float> %x to <2 x double>
  %tmp3 = fadd <2 x double> %tmp1, <double 0.000000e+00, double 0.000000e+00>
  %tmp34 = fptrunc <2 x double> %tmp3 to <2 x float>
  ret <2 x float> %tmp34
}

; Test with a non-splat constant
define <2 x float> @test6(<2 x float> %x) nounwind  {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = fpext <2 x float> [[X:%.*]] to <2 x double>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <2 x double> [[TMP1]], <double 0.000000e+00, double -0.000000e+00>
; CHECK-NEXT:    [[TMP34:%.*]] = fptrunc <2 x double> [[TMP3]] to <2 x float>
; CHECK-NEXT:    ret <2 x float> [[TMP34]]
;
entry:
  %tmp1 = fpext <2 x float> %x to <2 x double>
  %tmp3 = fadd <2 x double> %tmp1, <double 0.000000e+00, double -0.000000e+00>
  %tmp34 = fptrunc <2 x double> %tmp3 to <2 x float>
  ret <2 x float> %tmp34
}

define <2 x float> @not_half_shrinkable(<2 x float> %x) {
; CHECK-LABEL: @not_half_shrinkable(
; CHECK-NEXT:    [[EXT:%.*]] = fpext <2 x float> [[X:%.*]] to <2 x double>
; CHECK-NEXT:    [[ADD:%.*]] = fadd <2 x double> [[EXT]], <double 0.000000e+00, double 2.049000e+03>
; CHECK-NEXT:    [[R:%.*]] = fptrunc <2 x double> [[ADD]] to <2 x float>
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %ext = fpext <2 x float> %x to <2 x double>
  %add = fadd <2 x double> %ext, <double 0.0, double 2049.0>
  %r = fptrunc <2 x double> %add to <2 x float>
  ret <2 x float>  %r
}

define half @test7(float %a) nounwind {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[Z:%.*]] = fptrunc float [[A:%.*]] to half
; CHECK-NEXT:    ret half [[Z]]
;
  %y = fpext float %a to double
  %z = fptrunc double %y to half
  ret half %z
}

define float @test8(half %a) nounwind {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[Z:%.*]] = fpext half [[A:%.*]] to float
; CHECK-NEXT:    ret float [[Z]]
;
  %y = fpext half %a to double
  %z = fptrunc double %y to float
  ret float %z
}

define float @test9(half %x, half %y) nounwind  {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP56:%.*]] = fmul float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext half %y to double
  %tmp5 = fmul double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test10(half %x, float %y) nounwind  {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP56:%.*]] = fmul float [[TMP0]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext float %y to double
  %tmp5 = fmul double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test11(half %x) nounwind  {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP34:%.*]] = fadd float [[TMP0]], 0.000000e+00
; CHECK-NEXT:    ret float [[TMP34]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp3 = fadd double %tmp1, 0.000000e+00
  %tmp34 = fptrunc double %tmp3 to float
  ret float %tmp34
}

define float @test12(float %x, half %y) nounwind  {
; CHECK-LABEL: @test12(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP34:%.*]] = fadd float [[TMP0]], [[X:%.*]]
; CHECK-NEXT:    ret float [[TMP34]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp2 = fpext half %y to double
  %tmp3 = fadd double %tmp1, %tmp2
  %tmp34 = fptrunc double %tmp3 to float
  ret float %tmp34
}

define float @test13(half %x, float %y) nounwind  {
; CHECK-LABEL: @test13(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP56:%.*]] = fdiv float [[TMP0]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext float %y to double
  %tmp5 = fdiv double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test14(float %x, half %y) nounwind  {
; CHECK-LABEL: @test14(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP56:%.*]] = fdiv float [[X:%.*]], [[TMP0]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp23 = fpext half %y to double
  %tmp5 = fdiv double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test15(half %x, half %y) nounwind  {
; CHECK-LABEL: @test15(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP1:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP56:%.*]] = fdiv float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext half %y to double
  %tmp5 = fdiv double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test16(half %x, float %y) nounwind  {
; CHECK-LABEL: @test16(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[X:%.*]] to float
; CHECK-NEXT:    [[TMP1:%.*]] = frem float [[TMP0]], [[Y:%.*]]
; CHECK-NEXT:    ret float [[TMP1]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext float %y to double
  %tmp5 = frem double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test17(float %x, half %y) nounwind  {
; CHECK-LABEL: @test17(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext half [[Y:%.*]] to float
; CHECK-NEXT:    [[TMP1:%.*]] = frem float [[X:%.*]], [[TMP0]]
; CHECK-NEXT:    ret float [[TMP1]]
;
entry:
  %tmp1 = fpext float %x to double
  %tmp23 = fpext half %y to double
  %tmp5 = frem double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}

define float @test18(half %x, half %y) nounwind  {
; CHECK-LABEL: @test18(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = frem half [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP56:%.*]] = fpext half [[TMP0]] to float
; CHECK-NEXT:    ret float [[TMP56]]
;
entry:
  %tmp1 = fpext half %x to double
  %tmp23 = fpext half %y to double
  %tmp5 = frem double %tmp1, %tmp23
  %tmp56 = fptrunc double %tmp5 to float
  ret float %tmp56
}
