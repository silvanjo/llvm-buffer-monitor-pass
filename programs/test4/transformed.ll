; ModuleID = 'transformed.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_put"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%BufferNode = type { i8*, i64, %BufferNode* }
%class.Person = type <{ %"class.std::__cxx11::basic_string", i32, [4 x i8] }>
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%class.Group = type { %"class.std::vector" }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl" }
%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl" = type { %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data" }
%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data" = type { %class.Person*, %class.Person*, %class.Person* }
%"class.__gnu_cxx::__normal_iterator.3" = type { %class.Person* }

$_ZN5GroupD2Ev = comdat any

$_ZN6PersonD2Ev = comdat any

$_ZNSt6vectorI6PersonSaIS0_EED2Ev = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv = comdat any

$_ZSt8_DestroyIP6PersonS0_EvT_S2_RSaIT0_E = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EED2Ev = comdat any

$__clang_call_terminate = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE13_M_deallocateEPS0_m = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implD2Ev = comdat any

$_ZNSaI6PersonED2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonED2Ev = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE10deallocateERS1_PS0_m = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonE10deallocateEPS1_m = comdat any

$_ZSt8_DestroyIP6PersonEvT_S2_ = comdat any

$_ZNSt12_Destroy_auxILb0EE9__destroyIP6PersonEEvT_S4_ = comdat any

$_ZSt11__addressofI6PersonEPT_RS1_ = comdat any

$_ZSt8_DestroyI6PersonEvPT_ = comdat any

$_ZNSt6vectorI6PersonSaIS0_EEC2Ev = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EEC2Ev = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implC2Ev = comdat any

$_ZNSaI6PersonEC2Ev = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE17_Vector_impl_dataC2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonEC2Ev = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE9push_backERKS0_ = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JRKS0_EEEvRS1_PT_DpOT0_ = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE3endEv = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE17_M_realloc_insertIJRKS0_EEEvN9__gnu_cxx17__normal_iteratorIPS0_S2_EEDpOT_ = comdat any

$_ZNKSt6vectorI6PersonSaIS0_EE12_M_check_lenEmPKc = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE5beginEv = comdat any

$_ZN9__gnu_cxxmiIP6PersonSt6vectorIS1_SaIS1_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS9_SC_ = comdat any

$_ZNSt12_Vector_baseI6PersonSaIS0_EE11_M_allocateEm = comdat any

$_ZSt7forwardIRK6PersonEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE11_S_relocateEPS0_S3_S3_RS1_ = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE7destroyIS0_EEvRS1_PT_ = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonE7destroyIS1_EEvPT_ = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE14_S_do_relocateEPS0_S3_S3_RS1_St17integral_constantIbLb1EE = comdat any

$_ZSt12__relocate_aIP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_ = comdat any

$_ZSt12__niter_baseIP6PersonET_S2_ = comdat any

$_ZSt14__relocate_a_1IP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_ = comdat any

$_ZSt19__relocate_object_aI6PersonS0_SaIS0_EEvPT_PT0_RT1_ = comdat any

$_ZSt4moveIR6PersonEONSt16remove_referenceIT_E4typeEOS3_ = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JS0_EEEvRS1_PT_DpOT0_ = comdat any

$_ZSt7forwardI6PersonEOT_RNSt16remove_referenceIS1_E4typeE = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JS1_EEEvPT_DpOT0_ = comdat any

$_ZN6PersonC2EOS_ = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE8allocateERS1_m = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonE8allocateEmPKv = comdat any

$_ZNK9__gnu_cxx13new_allocatorI6PersonE11_M_max_sizeEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEEC2ERKS2_ = comdat any

$_ZNKSt6vectorI6PersonSaIS0_EE8max_sizeEv = comdat any

$_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv = comdat any

$_ZSt3maxImERKT_S2_S2_ = comdat any

$_ZNKSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv = comdat any

$_ZNSt6vectorI6PersonSaIS0_EE11_S_max_sizeERKS1_ = comdat any

$_ZNSt16allocator_traitsISaI6PersonEE8max_sizeERKS1_ = comdat any

$_ZSt3minImERKT_S2_S2_ = comdat any

$_ZNK9__gnu_cxx13new_allocatorI6PersonE8max_sizeEv = comdat any

$_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JRKS1_EEEvPT_DpOT0_ = comdat any

$_ZN6PersonC2ERKS_ = comdat any

$_ZNKSt6vectorI6PersonSaIS0_EE5beginEv = comdat any

$_ZNKSt6vectorI6PersonSaIS0_EE3endEv = comdat any

$_ZN9__gnu_cxxneIPK6PersonSt6vectorIS1_SaIS1_EEEEbRKNS_17__normal_iteratorIT_T0_EESC_ = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEdeEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEppEv = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEE4baseEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEC2ERKS3_ = comdat any

@llvm.global_ctors = appending global [3 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_main.cpp, i8* null }, { i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_person.cpp, i8* null }, { i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_group.cpp, i8* null }]
@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@.str = private unnamed_addr constant [6 x i8] c"Alice\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"Bob\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"Charlie\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"Group members (\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c" total):\00", align 1
@_ZStL8__ioinit.3 = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str.5 = private unnamed_addr constant [7 x i8] c"Name: \00", align 1
@.str.1.6 = private unnamed_addr constant [8 x i8] c", Age: \00", align 1
@_ZStL8__ioinit.11 = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@.str.14 = private unnamed_addr constant [26 x i8] c"vector::_M_realloc_insert\00", align 1
@BufferListHead = global %BufferNode* null
@globalFilePtr = global i8* null
@0 = private unnamed_addr constant [11 x i8] c"output.txt\00", align 1
@1 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@formatAddrString = private unnamed_addr constant [4 x i8] c"%p\0A\00", align 1
@formatSizeString = private unnamed_addr constant [11 x i8] c"Size: %ld\0A\00", align 1
@2 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@3 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@4 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@5 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@6 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@7 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@8 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@9 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@10 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@11 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@12 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@13 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@14 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@15 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@16 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@17 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@18 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@19 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@20 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@21 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@22 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@23 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@24 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@25 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@26 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@27 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@28 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@29 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@30 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@31 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@32 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@33 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@34 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@35 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@36 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@37 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@38 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@39 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@40 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@41 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@42 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@43 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@44 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@45 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@46 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@47 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@48 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@49 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@50 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@51 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@52 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@53 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@54 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@55 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@56 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@57 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@58 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@59 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@60 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@61 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@62 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@63 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@64 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@65 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@66 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@67 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@68 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@69 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@70 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@71 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@72 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@73 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@74 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@75 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@76 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@77 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@78 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@79 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@80 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@81 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@82 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@83 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@84 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@85 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@86 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@87 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@88 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@89 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@90 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@91 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@92 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@93 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@94 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@95 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@96 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@97 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@98 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@99 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@100 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@101 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@102 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@103 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@104 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@105 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@106 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@107 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@108 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@109 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@110 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@111 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@112 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@113 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@114 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@115 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@116 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@117 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@118 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@119 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@120 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@121 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@122 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@123 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@124 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@125 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@126 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@127 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@128 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@129 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@130 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@131 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@132 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@133 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@134 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@135 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@136 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@137 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@138 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@139 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@140 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@141 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@142 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@143 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@fileFormatString = private unnamed_addr constant [29 x i8] c"Heap allocation of size: %d\0A\00", align 1
@144 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@145 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@146 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@147 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@148 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@149 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@150 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@151 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@152 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@153 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@154 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@155 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@156 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@157 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@158 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@159 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@160 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@161 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@162 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@163 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@164 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@165 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@166 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@167 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@168 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@169 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@170 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@171 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@172 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@173 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@174 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@175 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@176 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@177 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@178 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@179 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@180 = private unnamed_addr constant [40 x i8] c"Buffer access: %d of size: %d (static)\0A\00", align 1
@181 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@182 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@183 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@184 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@185 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@186 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@187 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@188 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@189 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@190 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@191 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1
@192 = private unnamed_addr constant [41 x i8] c"Buffer access: %d of size: %d (dynamic)\0A\00", align 1

@_ZN6PersonC1ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi = dso_local unnamed_addr alias void (%class.Person*, %"class.std::__cxx11::basic_string"*, i32), void (%class.Person*, %"class.std::__cxx11::basic_string"*, i32)* @_ZN6PersonC2ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
@_ZN5GroupC1Ev = dso_local unnamed_addr alias void (%class.Group*), void (%class.Group*)* @_ZN5GroupC2Ev

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_main.cpp() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main() #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %1 = call i8* @fopen(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @0, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0))
  store i8* %1, i8** @globalFilePtr, align 8
  %2 = alloca i32, align 4
  %3 = alloca %class.Person, align 8
  %4 = alloca %"class.std::__cxx11::basic_string", align 8
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %class.Person, align 8
  %9 = alloca %"class.std::__cxx11::basic_string", align 8
  %10 = alloca %"class.std::ios_base::Init", align 1
  %11 = alloca %class.Person, align 8
  %12 = alloca %"class.std::__cxx11::basic_string", align 8
  %13 = alloca %"class.std::ios_base::Init", align 1
  %14 = alloca %class.Group, align 8
  store i32 0, i32* %2, align 4
  call void @_ZNSaIcEC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5) #3
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %4, i8* noundef getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5)
          to label %15 unwind label %37

15:                                               ; preds = %0
  invoke void @_ZN6PersonC1ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi(%class.Person* noundef nonnull align 8 dereferenceable(36) %3, %"class.std::__cxx11::basic_string"* noundef %4, i32 noundef 25)
          to label %16 unwind label %41

16:                                               ; preds = %15
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %4) #3
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5) #3
  call void @_ZNSaIcEC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %10) #3
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %9, i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %10)
          to label %17 unwind label %46

17:                                               ; preds = %16
  invoke void @_ZN6PersonC1ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi(%class.Person* noundef nonnull align 8 dereferenceable(36) %8, %"class.std::__cxx11::basic_string"* noundef %9, i32 noundef 30)
          to label %18 unwind label %50

18:                                               ; preds = %17
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %9) #3
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %10) #3
  call void @_ZNSaIcEC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13) #3
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %12, i8* noundef getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0), %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13)
          to label %19 unwind label %55

19:                                               ; preds = %18
  invoke void @_ZN6PersonC1ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi(%class.Person* noundef nonnull align 8 dereferenceable(36) %11, %"class.std::__cxx11::basic_string"* noundef %12, i32 noundef 35)
          to label %20 unwind label %59

20:                                               ; preds = %19
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %12) #3
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13) #3
  invoke void @_ZN5GroupC1Ev(%class.Group* noundef nonnull align 8 dereferenceable(24) %14)
          to label %21 unwind label %64

21:                                               ; preds = %20
  invoke void @_ZN5Group9addMemberERK6Person(%class.Group* noundef nonnull align 8 dereferenceable(24) %14, %class.Person* noundef nonnull align 8 dereferenceable(36) %3)
          to label %22 unwind label %68

22:                                               ; preds = %21
  invoke void @_ZN5Group9addMemberERK6Person(%class.Group* noundef nonnull align 8 dereferenceable(24) %14, %class.Person* noundef nonnull align 8 dereferenceable(36) %8)
          to label %23 unwind label %68

23:                                               ; preds = %22
  invoke void @_ZN5Group9addMemberERK6Person(%class.Group* noundef nonnull align 8 dereferenceable(24) %14, %class.Person* noundef nonnull align 8 dereferenceable(36) %11)
          to label %24 unwind label %68

24:                                               ; preds = %23
  %25 = invoke noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* noundef getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0))
          to label %26 unwind label %68

26:                                               ; preds = %24
  %27 = invoke noundef i32 @_ZNK5Group7getSizeEv(%class.Group* noundef nonnull align 8 dereferenceable(24) %14)
          to label %28 unwind label %68

28:                                               ; preds = %26
  %29 = invoke noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %25, i32 noundef %27)
          to label %30 unwind label %68

30:                                               ; preds = %28
  %31 = invoke noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %29, i8* noundef getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0))
          to label %32 unwind label %68

32:                                               ; preds = %30
  %33 = invoke noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %31, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* noundef @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
          to label %34 unwind label %68

34:                                               ; preds = %32
  invoke void @_ZNK5Group15printAllMembersEv(%class.Group* noundef nonnull align 8 dereferenceable(24) %14)
          to label %35 unwind label %68

35:                                               ; preds = %34
  store i32 0, i32* %2, align 4
  call void @_ZN5GroupD2Ev(%class.Group* noundef nonnull align 8 dereferenceable(24) %14) #3
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %11) #3
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %8) #3
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %3) #3
  %36 = load i32, i32* %2, align 4
  ret i32 %36

37:                                               ; preds = %0
  %38 = landingpad { i8*, i32 }
          cleanup
  %39 = extractvalue { i8*, i32 } %38, 0
  store i8* %39, i8** %6, align 8
  %40 = extractvalue { i8*, i32 } %38, 1
  store i32 %40, i32* %7, align 4
  br label %45

41:                                               ; preds = %15
  call void @printBufferList()
  %42 = landingpad { i8*, i32 }
          cleanup
  %43 = extractvalue { i8*, i32 } %42, 0
  store i8* %43, i8** %6, align 8
  %44 = extractvalue { i8*, i32 } %42, 1
  store i32 %44, i32* %7, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %4) #3
  br label %45

45:                                               ; preds = %41, %37
  call void @printBufferList()
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5) #3
  br label %75

46:                                               ; preds = %16
  call void @printBufferList()
  %47 = landingpad { i8*, i32 }
          cleanup
  %48 = extractvalue { i8*, i32 } %47, 0
  store i8* %48, i8** %6, align 8
  %49 = extractvalue { i8*, i32 } %47, 1
  store i32 %49, i32* %7, align 4
  br label %54

50:                                               ; preds = %17
  %51 = landingpad { i8*, i32 }
          cleanup
  %52 = extractvalue { i8*, i32 } %51, 0
  store i8* %52, i8** %6, align 8
  %53 = extractvalue { i8*, i32 } %51, 1
  store i32 %53, i32* %7, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %9) #3
  br label %54

54:                                               ; preds = %50, %46
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %10) #3
  br label %74

55:                                               ; preds = %18
  %56 = landingpad { i8*, i32 }
          cleanup
  %57 = extractvalue { i8*, i32 } %56, 0
  store i8* %57, i8** %6, align 8
  %58 = extractvalue { i8*, i32 } %56, 1
  store i32 %58, i32* %7, align 4
  br label %63

59:                                               ; preds = %19
  %60 = landingpad { i8*, i32 }
          cleanup
  %61 = extractvalue { i8*, i32 } %60, 0
  store i8* %61, i8** %6, align 8
  %62 = extractvalue { i8*, i32 } %60, 1
  store i32 %62, i32* %7, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %12) #3
  br label %63

63:                                               ; preds = %59, %55
  call void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13) #3
  br label %73

64:                                               ; preds = %20
  %65 = landingpad { i8*, i32 }
          cleanup
  %66 = extractvalue { i8*, i32 } %65, 0
  store i8* %66, i8** %6, align 8
  %67 = extractvalue { i8*, i32 } %65, 1
  store i32 %67, i32* %7, align 4
  br label %72

68:                                               ; preds = %34, %32, %30, %28, %26, %24, %23, %22, %21
  %69 = landingpad { i8*, i32 }
          cleanup
  %70 = extractvalue { i8*, i32 } %69, 0
  store i8* %70, i8** %6, align 8
  %71 = extractvalue { i8*, i32 } %69, 1
  store i32 %71, i32* %7, align 4
  call void @_ZN5GroupD2Ev(%class.Group* noundef nonnull align 8 dereferenceable(24) %14) #3
  br label %72

72:                                               ; preds = %68, %64
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %11) #3
  br label %73

73:                                               ; preds = %72, %63
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %8) #3
  br label %74

74:                                               ; preds = %73, %54
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %3) #3
  br label %75

75:                                               ; preds = %74, %45
  %76 = load i8*, i8** %6, align 8
  %77 = load i32, i32* %7, align 4
  %78 = insertvalue { i8*, i32 } undef, i8* %76, 0
  %79 = insertvalue { i8*, i32 } %78, i32 %77, 1
  call void @printBufferList()
  %80 = load i8*, i8** @globalFilePtr, align 8
  %81 = call i32 @fclose(i8* %80)
  resume { i8*, i32 } %79
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @_ZNSaIcEC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32), i8* noundef, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32)) unnamed_addr #2

; Function Attrs: nounwind
declare void @_ZNSaIcED1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

declare noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8), i8* noundef) #1

declare noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8), i32 noundef) #1

declare noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8)) #1

declare noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8), %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN5GroupD2Ev(%class.Group* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %class.Group*, align 8
  store %class.Group* %0, %class.Group** %2, align 8
  %3 = load %class.Group*, %class.Group** %2, align 8
  %4 = bitcast %class.Group* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @2, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @3, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %class.Group, %class.Group* %3, i32 0, i32 0
  call void @_ZNSt6vectorI6PersonSaIS0_EED2Ev(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %11) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  %4 = bitcast %class.Person* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @4, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @5, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %class.Person, %class.Person* %3, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %11) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt6vectorI6PersonSaIS0_EED2Ev(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::vector"*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store %"class.std::vector"* %0, %"class.std::vector"** %2, align 8
  %5 = load %"class.std::vector"*, %"class.std::vector"** %2, align 8
  %6 = bitcast %"class.std::vector"* %5 to %"struct.std::_Vector_base"*
  %7 = bitcast %"struct.std::_Vector_base"* %6 to i8*
  %8 = call i64 @getBufferSize(i8* %7)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @6, i32 0, i32 0), i32 0, i64 %8)
  %11 = call i64 @getBufferSize(i8* %7)
  %12 = load i8*, i8** @globalFilePtr, align 8
  %13 = call i32 (i8*, i8*, ...) @fprintf(i8* %12, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @7, i32 0, i32 0), i32 0, i64 %11)
  %14 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %6, i32 0, i32 0
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %14 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %16 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %15 to i8*
  %17 = call i64 @getBufferSize(i8* %16)
  %18 = load i8*, i8** @globalFilePtr, align 8
  %19 = call i32 (i8*, i8*, ...) @fprintf(i8* %18, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @8, i32 0, i32 0), i32 0, i64 %17)
  %20 = call i64 @getBufferSize(i8* %16)
  %21 = load i8*, i8** @globalFilePtr, align 8
  %22 = call i32 (i8*, i8*, ...) @fprintf(i8* %21, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @9, i32 0, i32 0), i32 0, i64 %20)
  %23 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %15, i32 0, i32 0
  %24 = load %class.Person*, %class.Person** %23, align 8
  %25 = bitcast %"class.std::vector"* %5 to %"struct.std::_Vector_base"*
  %26 = bitcast %"struct.std::_Vector_base"* %25 to i8*
  %27 = call i64 @getBufferSize(i8* %26)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @10, i32 0, i32 0), i32 0, i64 %27)
  %30 = call i64 @getBufferSize(i8* %26)
  %31 = load i8*, i8** @globalFilePtr, align 8
  %32 = call i32 (i8*, i8*, ...) @fprintf(i8* %31, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @11, i32 0, i32 0), i32 0, i64 %30)
  %33 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %25, i32 0, i32 0
  %34 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %33 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %35 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %34 to i8*
  %36 = call i64 @getBufferSize(i8* %35)
  %37 = load i8*, i8** @globalFilePtr, align 8
  %38 = call i32 (i8*, i8*, ...) @fprintf(i8* %37, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @12, i32 0, i32 0), i32 0, i64 %36)
  %39 = call i64 @getBufferSize(i8* %35)
  %40 = load i8*, i8** @globalFilePtr, align 8
  %41 = call i32 (i8*, i8*, ...) @fprintf(i8* %40, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @13, i32 0, i32 0), i32 1, i64 %39)
  %42 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %34, i32 0, i32 1
  %43 = load %class.Person*, %class.Person** %42, align 8
  %44 = bitcast %"class.std::vector"* %5 to %"struct.std::_Vector_base"*
  %45 = call noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %44) #3
  invoke void @_ZSt8_DestroyIP6PersonS0_EvT_S2_RSaIT0_E(%class.Person* noundef %24, %class.Person* noundef %43, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %45)
          to label %46 unwind label %48

46:                                               ; preds = %1
  %47 = bitcast %"class.std::vector"* %5 to %"struct.std::_Vector_base"*
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EED2Ev(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %47) #3
  ret void

48:                                               ; preds = %1
  %49 = landingpad { i8*, i32 }
          catch i8* null
  %50 = extractvalue { i8*, i32 } %49, 0
  store i8* %50, i8** %3, align 8
  %51 = extractvalue { i8*, i32 } %49, 1
  store i32 %51, i32* %4, align 4
  %52 = bitcast %"class.std::vector"* %5 to %"struct.std::_Vector_base"*
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EED2Ev(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %52) #3
  br label %53

53:                                               ; preds = %48
  %54 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %54) #13
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base"*, align 8
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %2, align 8
  %3 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @14, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @15, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %3, i32 0, i32 0
  %12 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %11 to %"class.std::ios_base::Init"*
  ret %"class.std::ios_base::Init"* %12
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyIP6PersonS0_EvT_S2_RSaIT0_E(%class.Person* noundef %0, %class.Person* noundef %1, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %2) #7 comdat {
  %4 = alloca %class.Person*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %"class.std::ios_base::Init"*, align 8
  store %class.Person* %0, %class.Person** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %"class.std::ios_base::Init"* %2, %"class.std::ios_base::Init"** %6, align 8
  %7 = load %class.Person*, %class.Person** %4, align 8
  %8 = load %class.Person*, %class.Person** %5, align 8
  call void @_ZSt8_DestroyIP6PersonEvT_S2_(%class.Person* noundef %7, %class.Person* noundef %8)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EED2Ev(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::_Vector_base"*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %2, align 8
  %5 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %2, align 8
  %6 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @16, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @17, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %13 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @18, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @19, i32 0, i32 0), i32 0, i64 %19)
  %22 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14, i32 0, i32 0
  %23 = load %class.Person*, %class.Person** %22, align 8
  %24 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %25 = call i64 @getBufferSize(i8* %24)
  %26 = load i8*, i8** @globalFilePtr, align 8
  %27 = call i32 (i8*, i8*, ...) @fprintf(i8* %26, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @20, i32 0, i32 0), i32 0, i64 %25)
  %28 = call i64 @getBufferSize(i8* %24)
  %29 = load i8*, i8** @globalFilePtr, align 8
  %30 = call i32 (i8*, i8*, ...) @fprintf(i8* %29, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @21, i32 0, i32 0), i32 0, i64 %28)
  %31 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %32 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %31 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %33 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %32 to i8*
  %34 = call i64 @getBufferSize(i8* %33)
  %35 = load i8*, i8** @globalFilePtr, align 8
  %36 = call i32 (i8*, i8*, ...) @fprintf(i8* %35, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @22, i32 0, i32 0), i32 0, i64 %34)
  %37 = call i64 @getBufferSize(i8* %33)
  %38 = load i8*, i8** @globalFilePtr, align 8
  %39 = call i32 (i8*, i8*, ...) @fprintf(i8* %38, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @23, i32 0, i32 0), i32 2, i64 %37)
  %40 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %32, i32 0, i32 2
  %41 = load %class.Person*, %class.Person** %40, align 8
  %42 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %43 = call i64 @getBufferSize(i8* %42)
  %44 = load i8*, i8** @globalFilePtr, align 8
  %45 = call i32 (i8*, i8*, ...) @fprintf(i8* %44, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @24, i32 0, i32 0), i32 0, i64 %43)
  %46 = call i64 @getBufferSize(i8* %42)
  %47 = load i8*, i8** @globalFilePtr, align 8
  %48 = call i32 (i8*, i8*, ...) @fprintf(i8* %47, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @25, i32 0, i32 0), i32 0, i64 %46)
  %49 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %50 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %49 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %51 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %50 to i8*
  %52 = call i64 @getBufferSize(i8* %51)
  %53 = load i8*, i8** @globalFilePtr, align 8
  %54 = call i32 (i8*, i8*, ...) @fprintf(i8* %53, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @26, i32 0, i32 0), i32 0, i64 %52)
  %55 = call i64 @getBufferSize(i8* %51)
  %56 = load i8*, i8** @globalFilePtr, align 8
  %57 = call i32 (i8*, i8*, ...) @fprintf(i8* %56, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @27, i32 0, i32 0), i32 0, i64 %55)
  %58 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %50, i32 0, i32 0
  %59 = load %class.Person*, %class.Person** %58, align 8
  %60 = ptrtoint %class.Person* %41 to i64
  %61 = ptrtoint %class.Person* %59 to i64
  %62 = sub i64 %60, %61
  %63 = sdiv exact i64 %62, 40
  invoke void @_ZNSt12_Vector_baseI6PersonSaIS0_EE13_M_deallocateEPS0_m(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %5, %class.Person* noundef %23, i64 noundef %63)
          to label %64 unwind label %73

64:                                               ; preds = %1
  %65 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %66 = call i64 @getBufferSize(i8* %65)
  %67 = load i8*, i8** @globalFilePtr, align 8
  %68 = call i32 (i8*, i8*, ...) @fprintf(i8* %67, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @28, i32 0, i32 0), i32 0, i64 %66)
  %69 = call i64 @getBufferSize(i8* %65)
  %70 = load i8*, i8** @globalFilePtr, align 8
  %71 = call i32 (i8*, i8*, ...) @fprintf(i8* %70, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @29, i32 0, i32 0), i32 0, i64 %69)
  %72 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* noundef nonnull align 8 dereferenceable(24) %72) #3
  ret void

73:                                               ; preds = %1
  %74 = landingpad { i8*, i32 }
          catch i8* null
  %75 = extractvalue { i8*, i32 } %74, 0
  store i8* %75, i8** %3, align 8
  %76 = extractvalue { i8*, i32 } %74, 1
  store i32 %76, i32* %4, align 4
  %77 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %78 = call i64 @getBufferSize(i8* %77)
  %79 = load i8*, i8** @globalFilePtr, align 8
  %80 = call i32 (i8*, i8*, ...) @fprintf(i8* %79, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @30, i32 0, i32 0), i32 0, i64 %78)
  %81 = call i64 @getBufferSize(i8* %77)
  %82 = load i8*, i8** @globalFilePtr, align 8
  %83 = call i32 (i8*, i8*, ...) @fprintf(i8* %82, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @31, i32 0, i32 0), i32 0, i64 %81)
  %84 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* noundef nonnull align 8 dereferenceable(24) %84) #3
  br label %85

85:                                               ; preds = %73
  %86 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %86) #13
  unreachable
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8* %0) #8 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #3
  call void @_ZSt9terminatev() #13
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EE13_M_deallocateEPS0_m(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0, %class.Person* noundef %1, i64 noundef %2) #7 comdat align 2 {
  %4 = alloca %"struct.std::_Vector_base"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca i64, align 8
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %4, align 8
  %8 = load %class.Person*, %class.Person** %5, align 8
  %9 = icmp ne %class.Person* %8, null
  br i1 %9, label %10, label %22

10:                                               ; preds = %3
  %11 = bitcast %"struct.std::_Vector_base"* %7 to i8*
  %12 = call i64 @getBufferSize(i8* %11)
  %13 = load i8*, i8** @globalFilePtr, align 8
  %14 = call i32 (i8*, i8*, ...) @fprintf(i8* %13, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @32, i32 0, i32 0), i32 0, i64 %12)
  %15 = call i64 @getBufferSize(i8* %11)
  %16 = load i8*, i8** @globalFilePtr, align 8
  %17 = call i32 (i8*, i8*, ...) @fprintf(i8* %16, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @33, i32 0, i32 0), i32 0, i64 %15)
  %18 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %7, i32 0, i32 0
  %19 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %18 to %"class.std::ios_base::Init"*
  %20 = load %class.Person*, %class.Person** %5, align 8
  %21 = load i64, i64* %6, align 8
  call void @_ZNSt16allocator_traitsISaI6PersonEE10deallocateERS1_PS0_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %19, %class.Person* noundef %20, i64 noundef %21)
  br label %22

22:                                               ; preds = %10, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %0, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"*, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %3 to %"class.std::ios_base::Init"*
  call void @_ZNSaI6PersonED2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSaI6PersonED2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"class.std::ios_base::Init"*
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonED2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonED2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaI6PersonEE10deallocateERS1_PS0_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, i64 noundef %2) #7 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca i64, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = bitcast %"class.std::ios_base::Init"* %7 to %"class.std::ios_base::Init"*
  %9 = load %class.Person*, %class.Person** %5, align 8
  %10 = load i64, i64* %6, align 8
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonE10deallocateEPS1_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %8, %class.Person* noundef %9, i64 noundef %10)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonE10deallocateEPS1_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, i64 noundef %2) #6 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca i64, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = load %class.Person*, %class.Person** %5, align 8
  %9 = bitcast %class.Person* %8 to i8*
  call void @_ZdlPv(i8* noundef %9) #3
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8* noundef) #9

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyIP6PersonEvT_S2_(%class.Person* noundef %0, %class.Person* noundef %1) #7 comdat {
  %3 = alloca %class.Person*, align 8
  %4 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %class.Person*, %class.Person** %3, align 8
  %6 = load %class.Person*, %class.Person** %4, align 8
  call void @_ZNSt12_Destroy_auxILb0EE9__destroyIP6PersonEEvT_S4_(%class.Person* noundef %5, %class.Person* noundef %6)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Destroy_auxILb0EE9__destroyIP6PersonEEvT_S4_(%class.Person* noundef %0, %class.Person* noundef %1) #7 comdat align 2 {
  %3 = alloca %class.Person*, align 8
  %4 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  br label %5

5:                                                ; preds = %12, %2
  %6 = load %class.Person*, %class.Person** %3, align 8
  %7 = load %class.Person*, %class.Person** %4, align 8
  %8 = icmp ne %class.Person* %6, %7
  br i1 %8, label %9, label %19

9:                                                ; preds = %5
  %10 = load %class.Person*, %class.Person** %3, align 8
  %11 = call noundef %class.Person* @_ZSt11__addressofI6PersonEPT_RS1_(%class.Person* noundef nonnull align 8 dereferenceable(36) %10) #3
  call void @_ZSt8_DestroyI6PersonEvPT_(%class.Person* noundef %11)
  br label %12

12:                                               ; preds = %9
  %13 = load %class.Person*, %class.Person** %3, align 8
  %14 = bitcast %class.Person* %13 to i8*
  %15 = call i64 @getBufferSize(i8* %14)
  %16 = load i8*, i8** @globalFilePtr, align 8
  %17 = call i32 (i8*, i8*, ...) @fprintf(i8* %16, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @34, i32 0, i32 0), i32 1, i64 %15)
  %18 = getelementptr inbounds %class.Person, %class.Person* %13, i32 1
  store %class.Person* %18, %class.Person** %3, align 8
  br label %5, !llvm.loop !6

19:                                               ; preds = %5
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZSt11__addressofI6PersonEPT_RS1_(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  ret %class.Person* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyI6PersonEvPT_(%class.Person* noundef %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %3) #3
  ret void
}

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_person.cpp() #0 section ".text.startup" {
  call void @__cxx_global_var_init.2()
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.2() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit.3)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit.3, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

; Function Attrs: noinline optnone uwtable
define dso_local void @_ZN6PersonC2ENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi(%class.Person* noundef nonnull align 8 dereferenceable(36) %0, %"class.std::__cxx11::basic_string"* noundef %1, i32 noundef %2) unnamed_addr #10 align 2 {
  %4 = alloca %class.Person*, align 8
  %5 = alloca i32, align 4
  store %class.Person* %0, %class.Person** %4, align 8
  store i32 %2, i32* %5, align 4
  %6 = load %class.Person*, %class.Person** %4, align 8
  %7 = bitcast %class.Person* %6 to i8*
  %8 = call i64 @getBufferSize(i8* %7)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @35, i32 0, i32 0), i32 0, i64 %8)
  %11 = call i64 @getBufferSize(i8* %7)
  %12 = load i8*, i8** @globalFilePtr, align 8
  %13 = call i32 (i8*, i8*, ...) @fprintf(i8* %12, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @36, i32 0, i32 0), i32 0, i64 %11)
  %14 = getelementptr inbounds %class.Person, %class.Person* %6, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %14, %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %1)
  %15 = bitcast %class.Person* %6 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @37, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @38, i32 0, i32 0), i32 1, i64 %19)
  %22 = getelementptr inbounds %class.Person, %class.Person* %6, i32 0, i32 1
  %23 = load i32, i32* %5, align 4
  store i32 %23, i32* %22, align 8
  ret void
}

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32), %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32)) unnamed_addr #1

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_ZNK6Person7getNameB5cxx11Ev(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, %class.Person* noundef nonnull align 8 dereferenceable(36) %1) #7 align 2 {
  %3 = alloca i8*, align 8
  %4 = alloca %class.Person*, align 8
  %5 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %5, i8** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %6 = load %class.Person*, %class.Person** %4, align 8
  %7 = bitcast %class.Person* %6 to i8*
  %8 = call i64 @getBufferSize(i8* %7)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @39, i32 0, i32 0), i32 0, i64 %8)
  %11 = call i64 @getBufferSize(i8* %7)
  %12 = load i8*, i8** @globalFilePtr, align 8
  %13 = call i32 (i8*, i8*, ...) @fprintf(i8* %12, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @40, i32 0, i32 0), i32 0, i64 %11)
  %14 = getelementptr inbounds %class.Person, %class.Person* %6, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %0, %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %14)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local noundef i32 @_ZNK6Person6getAgeEv(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #6 align 2 {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  %4 = bitcast %class.Person* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @41, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @42, i32 0, i32 0), i32 1, i64 %8)
  %11 = getelementptr inbounds %class.Person, %class.Person* %3, i32 0, i32 1
  %12 = load i32, i32* %11, align 8
  ret i32 %12
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_ZNK6Person9printInfoEv(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #7 align 2 {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i64 0, i64 0))
  %5 = bitcast %class.Person* %3 to i8*
  %6 = call i64 @getBufferSize(i8* %5)
  %7 = load i8*, i8** @globalFilePtr, align 8
  %8 = call i32 (i8*, i8*, ...) @fprintf(i8* %7, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @43, i32 0, i32 0), i32 0, i64 %6)
  %9 = call i64 @getBufferSize(i8* %5)
  %10 = load i8*, i8** @globalFilePtr, align 8
  %11 = call i32 (i8*, i8*, ...) @fprintf(i8* %10, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @44, i32 0, i32 0), i32 0, i64 %9)
  %12 = getelementptr inbounds %class.Person, %class.Person* %3, i32 0, i32 0
  %13 = call noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %4, %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %12)
  %14 = call noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %13, i8* noundef getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1.6, i64 0, i64 0))
  %15 = bitcast %class.Person* %3 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @45, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @46, i32 0, i32 0), i32 1, i64 %19)
  %22 = getelementptr inbounds %class.Person, %class.Person* %3, i32 0, i32 1
  %23 = load i32, i32* %22, align 8
  %24 = call noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %14, i32 noundef %23)
  %25 = call noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %24, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* noundef @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
  ret void
}

declare noundef nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* noundef nonnull align 8 dereferenceable(8), %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32)) #1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_group.cpp() #0 section ".text.startup" {
  call void @__cxx_global_var_init.10()
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.10() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit.11)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit.11, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_ZN5GroupC2Ev(%class.Group* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 align 2 {
  %2 = alloca %class.Group*, align 8
  store %class.Group* %0, %class.Group** %2, align 8
  %3 = load %class.Group*, %class.Group** %2, align 8
  %4 = bitcast %class.Group* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @47, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @48, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %class.Group, %class.Group* %3, i32 0, i32 0
  call void @_ZNSt6vectorI6PersonSaIS0_EEC2Ev(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %11) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt6vectorI6PersonSaIS0_EEC2Ev(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %2, align 8
  %3 = load %"class.std::vector"*, %"class.std::vector"** %2, align 8
  %4 = bitcast %"class.std::vector"* %3 to %"struct.std::_Vector_base"*
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EEC2Ev(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EEC2Ev(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base"*, align 8
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %2, align 8
  %3 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @49, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @50, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %3, i32 0, i32 0
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* noundef nonnull align 8 dereferenceable(24) %11) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %0, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"*, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %3 to %"class.std::ios_base::Init"*
  call void @_ZNSaI6PersonEC2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %4) #3
  %5 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %3 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EE17_Vector_impl_dataC2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* noundef nonnull align 8 dereferenceable(24) %5) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSaI6PersonEC2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"class.std::ios_base::Init"*
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonEC2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseI6PersonSaIS0_EE17_Vector_impl_dataC2Ev(%"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* noundef nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*, align 8
  store %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %0, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"** %2, align 8
  %3 = load %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*, %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @51, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @52, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3, i32 0, i32 0
  store %class.Person* null, %class.Person** %11, align 8
  %12 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3 to i8*
  %13 = call i64 @getBufferSize(i8* %12)
  %14 = load i8*, i8** @globalFilePtr, align 8
  %15 = call i32 (i8*, i8*, ...) @fprintf(i8* %14, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @53, i32 0, i32 0), i32 0, i64 %13)
  %16 = call i64 @getBufferSize(i8* %12)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @54, i32 0, i32 0), i32 1, i64 %16)
  %19 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3, i32 0, i32 1
  store %class.Person* null, %class.Person** %19, align 8
  %20 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3 to i8*
  %21 = call i64 @getBufferSize(i8* %20)
  %22 = load i8*, i8** @globalFilePtr, align 8
  %23 = call i32 (i8*, i8*, ...) @fprintf(i8* %22, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @55, i32 0, i32 0), i32 0, i64 %21)
  %24 = call i64 @getBufferSize(i8* %20)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @56, i32 0, i32 0), i32 2, i64 %24)
  %27 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %3, i32 0, i32 2
  store %class.Person* null, %class.Person** %27, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonEC2Ev(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_ZN5Group9addMemberERK6Person(%class.Group* noundef nonnull align 8 dereferenceable(24) %0, %class.Person* noundef nonnull align 8 dereferenceable(36) %1) #7 align 2 {
  %3 = alloca %class.Group*, align 8
  %4 = alloca %class.Person*, align 8
  store %class.Group* %0, %class.Group** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %class.Group*, %class.Group** %3, align 8
  %6 = bitcast %class.Group* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @57, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @58, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %class.Group, %class.Group* %5, i32 0, i32 0
  %14 = load %class.Person*, %class.Person** %4, align 8
  call void @_ZNSt6vectorI6PersonSaIS0_EE9push_backERKS0_(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %13, %class.Person* noundef nonnull align 8 dereferenceable(36) %14)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt6vectorI6PersonSaIS0_EE9push_backERKS0_(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0, %class.Person* noundef nonnull align 8 dereferenceable(36) %1) #7 comdat align 2 {
  %3 = alloca %"class.std::vector"*, align 8
  %4 = alloca %class.Person*, align 8
  %5 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %6 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %7 = bitcast %"class.std::vector"* %6 to %"struct.std::_Vector_base"*
  %8 = bitcast %"struct.std::_Vector_base"* %7 to i8*
  %9 = call i64 @getBufferSize(i8* %8)
  %10 = load i8*, i8** @globalFilePtr, align 8
  %11 = call i32 (i8*, i8*, ...) @fprintf(i8* %10, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @59, i32 0, i32 0), i32 0, i64 %9)
  %12 = call i64 @getBufferSize(i8* %8)
  %13 = load i8*, i8** @globalFilePtr, align 8
  %14 = call i32 (i8*, i8*, ...) @fprintf(i8* %13, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @60, i32 0, i32 0), i32 0, i64 %12)
  %15 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %7, i32 0, i32 0
  %16 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %15 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %17 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %16 to i8*
  %18 = call i64 @getBufferSize(i8* %17)
  %19 = load i8*, i8** @globalFilePtr, align 8
  %20 = call i32 (i8*, i8*, ...) @fprintf(i8* %19, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @61, i32 0, i32 0), i32 0, i64 %18)
  %21 = call i64 @getBufferSize(i8* %17)
  %22 = load i8*, i8** @globalFilePtr, align 8
  %23 = call i32 (i8*, i8*, ...) @fprintf(i8* %22, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @62, i32 0, i32 0), i32 1, i64 %21)
  %24 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %16, i32 0, i32 1
  %25 = load %class.Person*, %class.Person** %24, align 8
  %26 = bitcast %"class.std::vector"* %6 to %"struct.std::_Vector_base"*
  %27 = bitcast %"struct.std::_Vector_base"* %26 to i8*
  %28 = call i64 @getBufferSize(i8* %27)
  %29 = load i8*, i8** @globalFilePtr, align 8
  %30 = call i32 (i8*, i8*, ...) @fprintf(i8* %29, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @63, i32 0, i32 0), i32 0, i64 %28)
  %31 = call i64 @getBufferSize(i8* %27)
  %32 = load i8*, i8** @globalFilePtr, align 8
  %33 = call i32 (i8*, i8*, ...) @fprintf(i8* %32, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @64, i32 0, i32 0), i32 0, i64 %31)
  %34 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %26, i32 0, i32 0
  %35 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %34 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %36 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %35 to i8*
  %37 = call i64 @getBufferSize(i8* %36)
  %38 = load i8*, i8** @globalFilePtr, align 8
  %39 = call i32 (i8*, i8*, ...) @fprintf(i8* %38, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @65, i32 0, i32 0), i32 0, i64 %37)
  %40 = call i64 @getBufferSize(i8* %36)
  %41 = load i8*, i8** @globalFilePtr, align 8
  %42 = call i32 (i8*, i8*, ...) @fprintf(i8* %41, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @66, i32 0, i32 0), i32 2, i64 %40)
  %43 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %35, i32 0, i32 2
  %44 = load %class.Person*, %class.Person** %43, align 8
  %45 = icmp ne %class.Person* %25, %44
  br i1 %45, label %46, label %101

46:                                               ; preds = %2
  %47 = bitcast %"class.std::vector"* %6 to %"struct.std::_Vector_base"*
  %48 = bitcast %"struct.std::_Vector_base"* %47 to i8*
  %49 = call i64 @getBufferSize(i8* %48)
  %50 = load i8*, i8** @globalFilePtr, align 8
  %51 = call i32 (i8*, i8*, ...) @fprintf(i8* %50, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @67, i32 0, i32 0), i32 0, i64 %49)
  %52 = call i64 @getBufferSize(i8* %48)
  %53 = load i8*, i8** @globalFilePtr, align 8
  %54 = call i32 (i8*, i8*, ...) @fprintf(i8* %53, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @68, i32 0, i32 0), i32 0, i64 %52)
  %55 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %47, i32 0, i32 0
  %56 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %55 to %"class.std::ios_base::Init"*
  %57 = bitcast %"class.std::vector"* %6 to %"struct.std::_Vector_base"*
  %58 = bitcast %"struct.std::_Vector_base"* %57 to i8*
  %59 = call i64 @getBufferSize(i8* %58)
  %60 = load i8*, i8** @globalFilePtr, align 8
  %61 = call i32 (i8*, i8*, ...) @fprintf(i8* %60, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @69, i32 0, i32 0), i32 0, i64 %59)
  %62 = call i64 @getBufferSize(i8* %58)
  %63 = load i8*, i8** @globalFilePtr, align 8
  %64 = call i32 (i8*, i8*, ...) @fprintf(i8* %63, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @70, i32 0, i32 0), i32 0, i64 %62)
  %65 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %57, i32 0, i32 0
  %66 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %65 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %67 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %66 to i8*
  %68 = call i64 @getBufferSize(i8* %67)
  %69 = load i8*, i8** @globalFilePtr, align 8
  %70 = call i32 (i8*, i8*, ...) @fprintf(i8* %69, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @71, i32 0, i32 0), i32 0, i64 %68)
  %71 = call i64 @getBufferSize(i8* %67)
  %72 = load i8*, i8** @globalFilePtr, align 8
  %73 = call i32 (i8*, i8*, ...) @fprintf(i8* %72, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @72, i32 0, i32 0), i32 1, i64 %71)
  %74 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %66, i32 0, i32 1
  %75 = load %class.Person*, %class.Person** %74, align 8
  %76 = load %class.Person*, %class.Person** %4, align 8
  call void @_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JRKS0_EEEvRS1_PT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %56, %class.Person* noundef %75, %class.Person* noundef nonnull align 8 dereferenceable(36) %76)
  %77 = bitcast %"class.std::vector"* %6 to %"struct.std::_Vector_base"*
  %78 = bitcast %"struct.std::_Vector_base"* %77 to i8*
  %79 = call i64 @getBufferSize(i8* %78)
  %80 = load i8*, i8** @globalFilePtr, align 8
  %81 = call i32 (i8*, i8*, ...) @fprintf(i8* %80, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @73, i32 0, i32 0), i32 0, i64 %79)
  %82 = call i64 @getBufferSize(i8* %78)
  %83 = load i8*, i8** @globalFilePtr, align 8
  %84 = call i32 (i8*, i8*, ...) @fprintf(i8* %83, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @74, i32 0, i32 0), i32 0, i64 %82)
  %85 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %77, i32 0, i32 0
  %86 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %85 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %87 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %86 to i8*
  %88 = call i64 @getBufferSize(i8* %87)
  %89 = load i8*, i8** @globalFilePtr, align 8
  %90 = call i32 (i8*, i8*, ...) @fprintf(i8* %89, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @75, i32 0, i32 0), i32 0, i64 %88)
  %91 = call i64 @getBufferSize(i8* %87)
  %92 = load i8*, i8** @globalFilePtr, align 8
  %93 = call i32 (i8*, i8*, ...) @fprintf(i8* %92, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @76, i32 0, i32 0), i32 1, i64 %91)
  %94 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %86, i32 0, i32 1
  %95 = load %class.Person*, %class.Person** %94, align 8
  %96 = bitcast %class.Person* %95 to i8*
  %97 = call i64 @getBufferSize(i8* %96)
  %98 = load i8*, i8** @globalFilePtr, align 8
  %99 = call i32 (i8*, i8*, ...) @fprintf(i8* %98, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @77, i32 0, i32 0), i32 1, i64 %97)
  %100 = getelementptr inbounds %class.Person, %class.Person* %95, i32 1
  store %class.Person* %100, %class.Person** %94, align 8
  br label %121

101:                                              ; preds = %2
  %102 = call %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE3endEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %6) #3
  %103 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %5 to i8*
  %104 = call i64 @getBufferSize(i8* %103)
  %105 = load i8*, i8** @globalFilePtr, align 8
  %106 = call i32 (i8*, i8*, ...) @fprintf(i8* %105, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @78, i32 0, i32 0), i32 0, i64 %104)
  %107 = call i64 @getBufferSize(i8* %103)
  %108 = load i8*, i8** @globalFilePtr, align 8
  %109 = call i32 (i8*, i8*, ...) @fprintf(i8* %108, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @79, i32 0, i32 0), i32 0, i64 %107)
  %110 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %5, i32 0, i32 0
  store %class.Person* %102, %class.Person** %110, align 8
  %111 = load %class.Person*, %class.Person** %4, align 8
  %112 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %5 to i8*
  %113 = call i64 @getBufferSize(i8* %112)
  %114 = load i8*, i8** @globalFilePtr, align 8
  %115 = call i32 (i8*, i8*, ...) @fprintf(i8* %114, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @80, i32 0, i32 0), i32 0, i64 %113)
  %116 = call i64 @getBufferSize(i8* %112)
  %117 = load i8*, i8** @globalFilePtr, align 8
  %118 = call i32 (i8*, i8*, ...) @fprintf(i8* %117, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @81, i32 0, i32 0), i32 0, i64 %116)
  %119 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %5, i32 0, i32 0
  %120 = load %class.Person*, %class.Person** %119, align 8
  call void @_ZNSt6vectorI6PersonSaIS0_EE17_M_realloc_insertIJRKS0_EEEvN9__gnu_cxx17__normal_iteratorIPS0_S2_EEDpOT_(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %6, %class.Person* %120, %class.Person* noundef nonnull align 8 dereferenceable(36) %111)
  br label %121

121:                                              ; preds = %101, %46
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JRKS0_EEEvRS1_PT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, %class.Person* noundef nonnull align 8 dereferenceable(36) %2) #7 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %class.Person* %2, %class.Person** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = bitcast %"class.std::ios_base::Init"* %7 to %"class.std::ios_base::Init"*
  %9 = load %class.Person*, %class.Person** %5, align 8
  %10 = load %class.Person*, %class.Person** %6, align 8
  %11 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardIRK6PersonEOT_RNSt16remove_referenceIS3_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %10) #3
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JRKS1_EEEvPT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %8, %class.Person* noundef %9, %class.Person* noundef nonnull align 8 dereferenceable(36) %11)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE3endEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %3 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %3, align 8
  %4 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %5 = bitcast %"class.std::vector"* %4 to %"struct.std::_Vector_base"*
  %6 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @82, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @83, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %13 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @84, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @85, i32 0, i32 0), i32 1, i64 %19)
  %22 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14, i32 0, i32 1
  call void @_ZN9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEEC2ERKS2_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %2, %class.Person** noundef nonnull align 8 dereferenceable(8) %22) #3
  %23 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %2 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @86, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @87, i32 0, i32 0), i32 0, i64 %27)
  %30 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %2, i32 0, i32 0
  %31 = load %class.Person*, %class.Person** %30, align 8
  ret %class.Person* %31
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt6vectorI6PersonSaIS0_EE17_M_realloc_insertIJRKS0_EEEvN9__gnu_cxx17__normal_iteratorIPS0_S2_EEDpOT_(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0, %class.Person* %1, %class.Person* noundef nonnull align 8 dereferenceable(36) %2) #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %5 = alloca %"class.std::vector"*, align 8
  %6 = alloca %class.Person*, align 8
  %7 = alloca i64, align 8
  %8 = alloca %class.Person*, align 8
  %9 = alloca %class.Person*, align 8
  %10 = alloca i64, align 8
  %11 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %12 = alloca %class.Person*, align 8
  %13 = alloca %class.Person*, align 8
  %14 = alloca i8*, align 8
  %15 = alloca i32, align 4
  %16 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %4 to i8*
  %17 = call i64 @getBufferSize(i8* %16)
  %18 = load i8*, i8** @globalFilePtr, align 8
  %19 = call i32 (i8*, i8*, ...) @fprintf(i8* %18, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @88, i32 0, i32 0), i32 0, i64 %17)
  %20 = call i64 @getBufferSize(i8* %16)
  %21 = load i8*, i8** @globalFilePtr, align 8
  %22 = call i32 (i8*, i8*, ...) @fprintf(i8* %21, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @89, i32 0, i32 0), i32 0, i64 %20)
  %23 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %4, i32 0, i32 0
  store %class.Person* %1, %class.Person** %23, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %5, align 8
  store %class.Person* %2, %class.Person** %6, align 8
  %24 = load %"class.std::vector"*, %"class.std::vector"** %5, align 8
  %25 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE12_M_check_lenEmPKc(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %24, i64 noundef 1, i8* noundef getelementptr inbounds ([26 x i8], [26 x i8]* @.str.14, i64 0, i64 0))
  store i64 %25, i64* %7, align 8
  %26 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %27 = bitcast %"struct.std::_Vector_base"* %26 to i8*
  %28 = call i64 @getBufferSize(i8* %27)
  %29 = load i8*, i8** @globalFilePtr, align 8
  %30 = call i32 (i8*, i8*, ...) @fprintf(i8* %29, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @90, i32 0, i32 0), i32 0, i64 %28)
  %31 = call i64 @getBufferSize(i8* %27)
  %32 = load i8*, i8** @globalFilePtr, align 8
  %33 = call i32 (i8*, i8*, ...) @fprintf(i8* %32, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @91, i32 0, i32 0), i32 0, i64 %31)
  %34 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %26, i32 0, i32 0
  %35 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %34 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %36 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %35 to i8*
  %37 = call i64 @getBufferSize(i8* %36)
  %38 = load i8*, i8** @globalFilePtr, align 8
  %39 = call i32 (i8*, i8*, ...) @fprintf(i8* %38, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @92, i32 0, i32 0), i32 0, i64 %37)
  %40 = call i64 @getBufferSize(i8* %36)
  %41 = load i8*, i8** @globalFilePtr, align 8
  %42 = call i32 (i8*, i8*, ...) @fprintf(i8* %41, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @93, i32 0, i32 0), i32 0, i64 %40)
  %43 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %35, i32 0, i32 0
  %44 = load %class.Person*, %class.Person** %43, align 8
  store %class.Person* %44, %class.Person** %8, align 8
  %45 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %46 = bitcast %"struct.std::_Vector_base"* %45 to i8*
  %47 = call i64 @getBufferSize(i8* %46)
  %48 = load i8*, i8** @globalFilePtr, align 8
  %49 = call i32 (i8*, i8*, ...) @fprintf(i8* %48, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @94, i32 0, i32 0), i32 0, i64 %47)
  %50 = call i64 @getBufferSize(i8* %46)
  %51 = load i8*, i8** @globalFilePtr, align 8
  %52 = call i32 (i8*, i8*, ...) @fprintf(i8* %51, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @95, i32 0, i32 0), i32 0, i64 %50)
  %53 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %45, i32 0, i32 0
  %54 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %53 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %55 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %54 to i8*
  %56 = call i64 @getBufferSize(i8* %55)
  %57 = load i8*, i8** @globalFilePtr, align 8
  %58 = call i32 (i8*, i8*, ...) @fprintf(i8* %57, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @96, i32 0, i32 0), i32 0, i64 %56)
  %59 = call i64 @getBufferSize(i8* %55)
  %60 = load i8*, i8** @globalFilePtr, align 8
  %61 = call i32 (i8*, i8*, ...) @fprintf(i8* %60, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @97, i32 0, i32 0), i32 1, i64 %59)
  %62 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %54, i32 0, i32 1
  %63 = load %class.Person*, %class.Person** %62, align 8
  store %class.Person* %63, %class.Person** %9, align 8
  %64 = call %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE5beginEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %24) #3
  %65 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %11 to i8*
  %66 = call i64 @getBufferSize(i8* %65)
  %67 = load i8*, i8** @globalFilePtr, align 8
  %68 = call i32 (i8*, i8*, ...) @fprintf(i8* %67, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @98, i32 0, i32 0), i32 0, i64 %66)
  %69 = call i64 @getBufferSize(i8* %65)
  %70 = load i8*, i8** @globalFilePtr, align 8
  %71 = call i32 (i8*, i8*, ...) @fprintf(i8* %70, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @99, i32 0, i32 0), i32 0, i64 %69)
  %72 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %11, i32 0, i32 0
  store %class.Person* %64, %class.Person** %72, align 8
  %73 = call noundef i64 @_ZN9__gnu_cxxmiIP6PersonSt6vectorIS1_SaIS1_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS9_SC_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4, %"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %11) #3
  store i64 %73, i64* %10, align 8
  %74 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %75 = load i64, i64* %7, align 8
  %76 = call noundef %class.Person* @_ZNSt12_Vector_baseI6PersonSaIS0_EE11_M_allocateEm(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %74, i64 noundef %75)
  store %class.Person* %76, %class.Person** %12, align 8
  %77 = load %class.Person*, %class.Person** %12, align 8
  store %class.Person* %77, %class.Person** %13, align 8
  %78 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %79 = bitcast %"struct.std::_Vector_base"* %78 to i8*
  %80 = call i64 @getBufferSize(i8* %79)
  %81 = load i8*, i8** @globalFilePtr, align 8
  %82 = call i32 (i8*, i8*, ...) @fprintf(i8* %81, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @100, i32 0, i32 0), i32 0, i64 %80)
  %83 = call i64 @getBufferSize(i8* %79)
  %84 = load i8*, i8** @globalFilePtr, align 8
  %85 = call i32 (i8*, i8*, ...) @fprintf(i8* %84, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @101, i32 0, i32 0), i32 0, i64 %83)
  %86 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %78, i32 0, i32 0
  %87 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %86 to %"class.std::ios_base::Init"*
  %88 = load %class.Person*, %class.Person** %12, align 8
  %89 = load i64, i64* %10, align 8
  %90 = bitcast %class.Person* %88 to i8*
  %91 = call i64 @getBufferSize(i8* %90)
  %92 = load i8*, i8** @globalFilePtr, align 8
  %93 = call i32 (i8*, i8*, ...) @fprintf(i8* %92, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @102, i32 0, i32 0), i64 %89, i64 %91)
  %94 = getelementptr inbounds %class.Person, %class.Person* %88, i64 %89
  %95 = load %class.Person*, %class.Person** %6, align 8
  %96 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardIRK6PersonEOT_RNSt16remove_referenceIS3_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %95) #3
  invoke void @_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JRKS0_EEEvRS1_PT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %87, %class.Person* noundef %94, %class.Person* noundef nonnull align 8 dereferenceable(36) %96)
          to label %97 unwind label %118

97:                                               ; preds = %3
  store %class.Person* null, %class.Person** %13, align 8
  %98 = load %class.Person*, %class.Person** %8, align 8
  %99 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4) #3
  %100 = load %class.Person*, %class.Person** %99, align 8
  %101 = load %class.Person*, %class.Person** %12, align 8
  %102 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %103 = call noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %102) #3
  %104 = call noundef %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE11_S_relocateEPS0_S3_S3_RS1_(%class.Person* noundef %98, %class.Person* noundef %100, %class.Person* noundef %101, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %103) #3
  store %class.Person* %104, %class.Person** %13, align 8
  %105 = load %class.Person*, %class.Person** %13, align 8
  %106 = bitcast %class.Person* %105 to i8*
  %107 = call i64 @getBufferSize(i8* %106)
  %108 = load i8*, i8** @globalFilePtr, align 8
  %109 = call i32 (i8*, i8*, ...) @fprintf(i8* %108, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @103, i32 0, i32 0), i32 1, i64 %107)
  %110 = getelementptr inbounds %class.Person, %class.Person* %105, i32 1
  store %class.Person* %110, %class.Person** %13, align 8
  %111 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4) #3
  %112 = load %class.Person*, %class.Person** %111, align 8
  %113 = load %class.Person*, %class.Person** %9, align 8
  %114 = load %class.Person*, %class.Person** %13, align 8
  %115 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %116 = call noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %115) #3
  %117 = call noundef %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE11_S_relocateEPS0_S3_S3_RS1_(%class.Person* noundef %112, %class.Person* noundef %113, %class.Person* noundef %114, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %116) #3
  store %class.Person* %117, %class.Person** %13, align 8
  br label %161

118:                                              ; preds = %3
  %119 = landingpad { i8*, i32 }
          catch i8* null
  %120 = extractvalue { i8*, i32 } %119, 0
  store i8* %120, i8** %14, align 8
  %121 = extractvalue { i8*, i32 } %119, 1
  store i32 %121, i32* %15, align 4
  br label %122

122:                                              ; preds = %118
  %123 = load i8*, i8** %14, align 8
  %124 = call i8* @__cxa_begin_catch(i8* %123) #3
  %125 = load %class.Person*, %class.Person** %13, align 8
  %126 = icmp ne %class.Person* %125, null
  br i1 %126, label %145, label %127

127:                                              ; preds = %122
  %128 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %129 = bitcast %"struct.std::_Vector_base"* %128 to i8*
  %130 = call i64 @getBufferSize(i8* %129)
  %131 = load i8*, i8** @globalFilePtr, align 8
  %132 = call i32 (i8*, i8*, ...) @fprintf(i8* %131, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @104, i32 0, i32 0), i32 0, i64 %130)
  %133 = call i64 @getBufferSize(i8* %129)
  %134 = load i8*, i8** @globalFilePtr, align 8
  %135 = call i32 (i8*, i8*, ...) @fprintf(i8* %134, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @105, i32 0, i32 0), i32 0, i64 %133)
  %136 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %128, i32 0, i32 0
  %137 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %136 to %"class.std::ios_base::Init"*
  %138 = load %class.Person*, %class.Person** %12, align 8
  %139 = load i64, i64* %10, align 8
  %140 = bitcast %class.Person* %138 to i8*
  %141 = call i64 @getBufferSize(i8* %140)
  %142 = load i8*, i8** @globalFilePtr, align 8
  %143 = call i32 (i8*, i8*, ...) @fprintf(i8* %142, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @106, i32 0, i32 0), i64 %139, i64 %141)
  %144 = getelementptr inbounds %class.Person, %class.Person* %138, i64 %139
  call void @_ZNSt16allocator_traitsISaI6PersonEE7destroyIS0_EEvRS1_PT_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %137, %class.Person* noundef %144) #3
  br label %155

145:                                              ; preds = %122
  %146 = load %class.Person*, %class.Person** %12, align 8
  %147 = load %class.Person*, %class.Person** %13, align 8
  %148 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %149 = call noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %148) #3
  invoke void @_ZSt8_DestroyIP6PersonS0_EvT_S2_RSaIT0_E(%class.Person* noundef %146, %class.Person* noundef %147, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %149)
          to label %150 unwind label %151

150:                                              ; preds = %145
  br label %155

151:                                              ; preds = %159, %155, %145
  %152 = landingpad { i8*, i32 }
          cleanup
  %153 = extractvalue { i8*, i32 } %152, 0
  store i8* %153, i8** %14, align 8
  %154 = extractvalue { i8*, i32 } %152, 1
  store i32 %154, i32* %15, align 4
  invoke void @__cxa_end_catch()
          to label %160 unwind label %256

155:                                              ; preds = %150, %127
  %156 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %157 = load %class.Person*, %class.Person** %12, align 8
  %158 = load i64, i64* %7, align 8
  invoke void @_ZNSt12_Vector_baseI6PersonSaIS0_EE13_M_deallocateEPS0_m(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %156, %class.Person* noundef %157, i64 noundef %158)
          to label %159 unwind label %151

159:                                              ; preds = %155
  invoke void @__cxa_rethrow() #14
          to label %259 unwind label %151

160:                                              ; preds = %151
  br label %251

161:                                              ; preds = %97
  %162 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %163 = load %class.Person*, %class.Person** %8, align 8
  %164 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %165 = bitcast %"struct.std::_Vector_base"* %164 to i8*
  %166 = call i64 @getBufferSize(i8* %165)
  %167 = load i8*, i8** @globalFilePtr, align 8
  %168 = call i32 (i8*, i8*, ...) @fprintf(i8* %167, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @107, i32 0, i32 0), i32 0, i64 %166)
  %169 = call i64 @getBufferSize(i8* %165)
  %170 = load i8*, i8** @globalFilePtr, align 8
  %171 = call i32 (i8*, i8*, ...) @fprintf(i8* %170, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @108, i32 0, i32 0), i32 0, i64 %169)
  %172 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %164, i32 0, i32 0
  %173 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %172 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %174 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %173 to i8*
  %175 = call i64 @getBufferSize(i8* %174)
  %176 = load i8*, i8** @globalFilePtr, align 8
  %177 = call i32 (i8*, i8*, ...) @fprintf(i8* %176, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @109, i32 0, i32 0), i32 0, i64 %175)
  %178 = call i64 @getBufferSize(i8* %174)
  %179 = load i8*, i8** @globalFilePtr, align 8
  %180 = call i32 (i8*, i8*, ...) @fprintf(i8* %179, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @110, i32 0, i32 0), i32 2, i64 %178)
  %181 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %173, i32 0, i32 2
  %182 = load %class.Person*, %class.Person** %181, align 8
  %183 = load %class.Person*, %class.Person** %8, align 8
  %184 = ptrtoint %class.Person* %182 to i64
  %185 = ptrtoint %class.Person* %183 to i64
  %186 = sub i64 %184, %185
  %187 = sdiv exact i64 %186, 40
  call void @_ZNSt12_Vector_baseI6PersonSaIS0_EE13_M_deallocateEPS0_m(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %162, %class.Person* noundef %163, i64 noundef %187)
  %188 = load %class.Person*, %class.Person** %12, align 8
  %189 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %190 = bitcast %"struct.std::_Vector_base"* %189 to i8*
  %191 = call i64 @getBufferSize(i8* %190)
  %192 = load i8*, i8** @globalFilePtr, align 8
  %193 = call i32 (i8*, i8*, ...) @fprintf(i8* %192, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @111, i32 0, i32 0), i32 0, i64 %191)
  %194 = call i64 @getBufferSize(i8* %190)
  %195 = load i8*, i8** @globalFilePtr, align 8
  %196 = call i32 (i8*, i8*, ...) @fprintf(i8* %195, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @112, i32 0, i32 0), i32 0, i64 %194)
  %197 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %189, i32 0, i32 0
  %198 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %197 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %199 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %198 to i8*
  %200 = call i64 @getBufferSize(i8* %199)
  %201 = load i8*, i8** @globalFilePtr, align 8
  %202 = call i32 (i8*, i8*, ...) @fprintf(i8* %201, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @113, i32 0, i32 0), i32 0, i64 %200)
  %203 = call i64 @getBufferSize(i8* %199)
  %204 = load i8*, i8** @globalFilePtr, align 8
  %205 = call i32 (i8*, i8*, ...) @fprintf(i8* %204, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @114, i32 0, i32 0), i32 0, i64 %203)
  %206 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %198, i32 0, i32 0
  store %class.Person* %188, %class.Person** %206, align 8
  %207 = load %class.Person*, %class.Person** %13, align 8
  %208 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %209 = bitcast %"struct.std::_Vector_base"* %208 to i8*
  %210 = call i64 @getBufferSize(i8* %209)
  %211 = load i8*, i8** @globalFilePtr, align 8
  %212 = call i32 (i8*, i8*, ...) @fprintf(i8* %211, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @115, i32 0, i32 0), i32 0, i64 %210)
  %213 = call i64 @getBufferSize(i8* %209)
  %214 = load i8*, i8** @globalFilePtr, align 8
  %215 = call i32 (i8*, i8*, ...) @fprintf(i8* %214, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @116, i32 0, i32 0), i32 0, i64 %213)
  %216 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %208, i32 0, i32 0
  %217 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %216 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %218 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %217 to i8*
  %219 = call i64 @getBufferSize(i8* %218)
  %220 = load i8*, i8** @globalFilePtr, align 8
  %221 = call i32 (i8*, i8*, ...) @fprintf(i8* %220, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @117, i32 0, i32 0), i32 0, i64 %219)
  %222 = call i64 @getBufferSize(i8* %218)
  %223 = load i8*, i8** @globalFilePtr, align 8
  %224 = call i32 (i8*, i8*, ...) @fprintf(i8* %223, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @118, i32 0, i32 0), i32 1, i64 %222)
  %225 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %217, i32 0, i32 1
  store %class.Person* %207, %class.Person** %225, align 8
  %226 = load %class.Person*, %class.Person** %12, align 8
  %227 = load i64, i64* %7, align 8
  %228 = bitcast %class.Person* %226 to i8*
  %229 = call i64 @getBufferSize(i8* %228)
  %230 = load i8*, i8** @globalFilePtr, align 8
  %231 = call i32 (i8*, i8*, ...) @fprintf(i8* %230, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @119, i32 0, i32 0), i64 %227, i64 %229)
  %232 = getelementptr inbounds %class.Person, %class.Person* %226, i64 %227
  %233 = bitcast %"class.std::vector"* %24 to %"struct.std::_Vector_base"*
  %234 = bitcast %"struct.std::_Vector_base"* %233 to i8*
  %235 = call i64 @getBufferSize(i8* %234)
  %236 = load i8*, i8** @globalFilePtr, align 8
  %237 = call i32 (i8*, i8*, ...) @fprintf(i8* %236, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @120, i32 0, i32 0), i32 0, i64 %235)
  %238 = call i64 @getBufferSize(i8* %234)
  %239 = load i8*, i8** @globalFilePtr, align 8
  %240 = call i32 (i8*, i8*, ...) @fprintf(i8* %239, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @121, i32 0, i32 0), i32 0, i64 %238)
  %241 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %233, i32 0, i32 0
  %242 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %241 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %243 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %242 to i8*
  %244 = call i64 @getBufferSize(i8* %243)
  %245 = load i8*, i8** @globalFilePtr, align 8
  %246 = call i32 (i8*, i8*, ...) @fprintf(i8* %245, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @122, i32 0, i32 0), i32 0, i64 %244)
  %247 = call i64 @getBufferSize(i8* %243)
  %248 = load i8*, i8** @globalFilePtr, align 8
  %249 = call i32 (i8*, i8*, ...) @fprintf(i8* %248, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @123, i32 0, i32 0), i32 2, i64 %247)
  %250 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %242, i32 0, i32 2
  store %class.Person* %232, %class.Person** %250, align 8
  ret void

251:                                              ; preds = %160
  %252 = load i8*, i8** %14, align 8
  %253 = load i32, i32* %15, align 4
  %254 = insertvalue { i8*, i32 } undef, i8* %252, 0
  %255 = insertvalue { i8*, i32 } %254, i32 %253, 1
  resume { i8*, i32 } %255

256:                                              ; preds = %151
  %257 = landingpad { i8*, i32 }
          catch i8* null
  %258 = extractvalue { i8*, i32 } %257, 0
  call void @__clang_call_terminate(i8* %258) #13
  unreachable

259:                                              ; preds = %159
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE12_M_check_lenEmPKc(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0, i64 noundef %1, i8* noundef %2) #7 comdat align 2 {
  %4 = alloca %"class.std::vector"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %9 = load %"class.std::vector"*, %"class.std::vector"** %4, align 8
  %10 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE8max_sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  %11 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  %12 = sub i64 %10, %11
  %13 = load i64, i64* %5, align 8
  %14 = icmp ult i64 %12, %13
  br i1 %14, label %15, label %17

15:                                               ; preds = %3
  %16 = load i8*, i8** %6, align 8
  call void @_ZSt20__throw_length_errorPKc(i8* noundef %16) #14
  unreachable

17:                                               ; preds = %3
  %18 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  %19 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  store i64 %19, i64* %8, align 8
  %20 = call noundef nonnull align 8 dereferenceable(8) i64* @_ZSt3maxImERKT_S2_S2_(i64* noundef nonnull align 8 dereferenceable(8) %8, i64* noundef nonnull align 8 dereferenceable(8) %5)
  %21 = load i64, i64* %20, align 8
  %22 = add i64 %18, %21
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %7, align 8
  %24 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  %25 = icmp ult i64 %23, %24
  br i1 %25, label %30, label %26

26:                                               ; preds = %17
  %27 = load i64, i64* %7, align 8
  %28 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE8max_sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  %29 = icmp ugt i64 %27, %28
  br i1 %29, label %30, label %32

30:                                               ; preds = %26, %17
  %31 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE8max_sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %9) #3
  br label %34

32:                                               ; preds = %26
  %33 = load i64, i64* %7, align 8
  br label %34

34:                                               ; preds = %32, %30
  %35 = phi i64 [ %31, %30 ], [ %33, %32 ]
  ret i64 %35
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE5beginEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %3 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %3, align 8
  %4 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %5 = bitcast %"class.std::vector"* %4 to %"struct.std::_Vector_base"*
  %6 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @124, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @125, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %13 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @126, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @127, i32 0, i32 0), i32 0, i64 %19)
  %22 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14, i32 0, i32 0
  call void @_ZN9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEEC2ERKS2_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %2, %class.Person** noundef nonnull align 8 dereferenceable(8) %22) #3
  %23 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %2 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @128, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @129, i32 0, i32 0), i32 0, i64 %27)
  %30 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %2, i32 0, i32 0
  %31 = load %class.Person*, %class.Person** %30, align 8
  ret %class.Person* %31
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZN9__gnu_cxxmiIP6PersonSt6vectorIS1_SaIS1_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS9_SC_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0, %"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %1) #6 comdat {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %1, %"class.__gnu_cxx::__normal_iterator.3"** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  %6 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %5) #3
  %7 = load %class.Person*, %class.Person** %6, align 8
  %8 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %4, align 8
  %9 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %8) #3
  %10 = load %class.Person*, %class.Person** %9, align 8
  %11 = ptrtoint %class.Person* %7 to i64
  %12 = ptrtoint %class.Person* %10 to i64
  %13 = sub i64 %11, %12
  %14 = sdiv exact i64 %13, 40
  ret i64 %14
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZNSt12_Vector_baseI6PersonSaIS0_EE11_M_allocateEm(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0, i64 noundef %1) #7 comdat align 2 {
  %3 = alloca %"struct.std::_Vector_base"*, align 8
  %4 = alloca i64, align 8
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %8, label %20

8:                                                ; preds = %2
  %9 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %10 = call i64 @getBufferSize(i8* %9)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @130, i32 0, i32 0), i32 0, i64 %10)
  %13 = call i64 @getBufferSize(i8* %9)
  %14 = load i8*, i8** @globalFilePtr, align 8
  %15 = call i32 (i8*, i8*, ...) @fprintf(i8* %14, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @131, i32 0, i32 0), i32 0, i64 %13)
  %16 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %17 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %16 to %"class.std::ios_base::Init"*
  %18 = load i64, i64* %4, align 8
  %19 = call noundef %class.Person* @_ZNSt16allocator_traitsISaI6PersonEE8allocateERS1_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %17, i64 noundef %18)
  br label %21

20:                                               ; preds = %2
  br label %21

21:                                               ; preds = %20, %8
  %22 = phi %class.Person* [ %19, %8 ], [ null, %20 ]
  ret %class.Person* %22
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardIRK6PersonEOT_RNSt16remove_referenceIS3_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  ret %class.Person* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %4 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @132, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @133, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %3, i32 0, i32 0
  ret %class.Person** %11
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE11_S_relocateEPS0_S3_S3_RS1_(%class.Person* noundef %0, %class.Person* noundef %1, %class.Person* noundef %2, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %3) #6 comdat align 2 {
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  %7 = alloca %class.Person*, align 8
  %8 = alloca %"class.std::ios_base::Init"*, align 8
  %9 = alloca %"class.std::ios_base::Init", align 1
  store %class.Person* %0, %class.Person** %5, align 8
  store %class.Person* %1, %class.Person** %6, align 8
  store %class.Person* %2, %class.Person** %7, align 8
  store %"class.std::ios_base::Init"* %3, %"class.std::ios_base::Init"** %8, align 8
  %10 = load %class.Person*, %class.Person** %5, align 8
  %11 = load %class.Person*, %class.Person** %6, align 8
  %12 = load %class.Person*, %class.Person** %7, align 8
  %13 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %8, align 8
  %14 = call noundef %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE14_S_do_relocateEPS0_S3_S3_RS1_St17integral_constantIbLb1EE(%class.Person* noundef %10, %class.Person* noundef %11, %class.Person* noundef %12, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13) #3
  ret %class.Person* %14
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaI6PersonEE7destroyIS0_EEvRS1_PT_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1) #6 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = bitcast %"class.std::ios_base::Init"* %5 to %"class.std::ios_base::Init"*
  %7 = load %class.Person*, %class.Person** %4, align 8
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonE7destroyIS1_EEvPT_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %6, %class.Person* noundef %7) #3
  ret void
}

declare void @__cxa_end_catch()

declare void @__cxa_rethrow()

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonE7destroyIS1_EEvPT_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1) #6 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = load %class.Person*, %class.Person** %4, align 8
  call void @_ZN6PersonD2Ev(%class.Person* noundef nonnull align 8 dereferenceable(36) %6) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZNSt6vectorI6PersonSaIS0_EE14_S_do_relocateEPS0_S3_S3_RS1_St17integral_constantIbLb1EE(%class.Person* noundef %0, %class.Person* noundef %1, %class.Person* noundef %2, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %3) #6 comdat align 2 {
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca %class.Person*, align 8
  %7 = alloca %class.Person*, align 8
  %8 = alloca %class.Person*, align 8
  %9 = alloca %"class.std::ios_base::Init"*, align 8
  store %class.Person* %0, %class.Person** %6, align 8
  store %class.Person* %1, %class.Person** %7, align 8
  store %class.Person* %2, %class.Person** %8, align 8
  store %"class.std::ios_base::Init"* %3, %"class.std::ios_base::Init"** %9, align 8
  %10 = load %class.Person*, %class.Person** %6, align 8
  %11 = load %class.Person*, %class.Person** %7, align 8
  %12 = load %class.Person*, %class.Person** %8, align 8
  %13 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %9, align 8
  %14 = call noundef %class.Person* @_ZSt12__relocate_aIP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_(%class.Person* noundef %10, %class.Person* noundef %11, %class.Person* noundef %12, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %13) #3
  ret %class.Person* %14
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZSt12__relocate_aIP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_(%class.Person* noundef %0, %class.Person* noundef %1, %class.Person* noundef %2, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %3) #6 comdat {
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  %7 = alloca %class.Person*, align 8
  %8 = alloca %"class.std::ios_base::Init"*, align 8
  store %class.Person* %0, %class.Person** %5, align 8
  store %class.Person* %1, %class.Person** %6, align 8
  store %class.Person* %2, %class.Person** %7, align 8
  store %"class.std::ios_base::Init"* %3, %"class.std::ios_base::Init"** %8, align 8
  %9 = load %class.Person*, %class.Person** %5, align 8
  %10 = call noundef %class.Person* @_ZSt12__niter_baseIP6PersonET_S2_(%class.Person* noundef %9) #3
  %11 = load %class.Person*, %class.Person** %6, align 8
  %12 = call noundef %class.Person* @_ZSt12__niter_baseIP6PersonET_S2_(%class.Person* noundef %11) #3
  %13 = load %class.Person*, %class.Person** %7, align 8
  %14 = call noundef %class.Person* @_ZSt12__niter_baseIP6PersonET_S2_(%class.Person* noundef %13) #3
  %15 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %8, align 8
  %16 = call noundef %class.Person* @_ZSt14__relocate_a_1IP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_(%class.Person* noundef %10, %class.Person* noundef %12, %class.Person* noundef %14, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %15) #3
  ret %class.Person* %16
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZSt12__niter_baseIP6PersonET_S2_(%class.Person* noundef %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  ret %class.Person* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZSt14__relocate_a_1IP6PersonS1_SaIS0_EET0_T_S4_S3_RT1_(%class.Person* noundef %0, %class.Person* noundef %1, %class.Person* noundef %2, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %3) #6 comdat {
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  %7 = alloca %class.Person*, align 8
  %8 = alloca %"class.std::ios_base::Init"*, align 8
  %9 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %5, align 8
  store %class.Person* %1, %class.Person** %6, align 8
  store %class.Person* %2, %class.Person** %7, align 8
  store %"class.std::ios_base::Init"* %3, %"class.std::ios_base::Init"** %8, align 8
  %10 = load %class.Person*, %class.Person** %7, align 8
  store %class.Person* %10, %class.Person** %9, align 8
  br label %11

11:                                               ; preds = %21, %4
  %12 = load %class.Person*, %class.Person** %5, align 8
  %13 = load %class.Person*, %class.Person** %6, align 8
  %14 = icmp ne %class.Person* %12, %13
  br i1 %14, label %15, label %34

15:                                               ; preds = %11
  %16 = load %class.Person*, %class.Person** %9, align 8
  %17 = call noundef %class.Person* @_ZSt11__addressofI6PersonEPT_RS1_(%class.Person* noundef nonnull align 8 dereferenceable(36) %16) #3
  %18 = load %class.Person*, %class.Person** %5, align 8
  %19 = call noundef %class.Person* @_ZSt11__addressofI6PersonEPT_RS1_(%class.Person* noundef nonnull align 8 dereferenceable(36) %18) #3
  %20 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %8, align 8
  call void @_ZSt19__relocate_object_aI6PersonS0_SaIS0_EEvPT_PT0_RT1_(%class.Person* noundef %17, %class.Person* noundef %19, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %20) #3
  br label %21

21:                                               ; preds = %15
  %22 = load %class.Person*, %class.Person** %5, align 8
  %23 = bitcast %class.Person* %22 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @134, i32 0, i32 0), i32 1, i64 %24)
  %27 = getelementptr inbounds %class.Person, %class.Person* %22, i32 1
  store %class.Person* %27, %class.Person** %5, align 8
  %28 = load %class.Person*, %class.Person** %9, align 8
  %29 = bitcast %class.Person* %28 to i8*
  %30 = call i64 @getBufferSize(i8* %29)
  %31 = load i8*, i8** @globalFilePtr, align 8
  %32 = call i32 (i8*, i8*, ...) @fprintf(i8* %31, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @135, i32 0, i32 0), i32 1, i64 %30)
  %33 = getelementptr inbounds %class.Person, %class.Person* %28, i32 1
  store %class.Person* %33, %class.Person** %9, align 8
  br label %11, !llvm.loop !8

34:                                               ; preds = %11
  %35 = load %class.Person*, %class.Person** %9, align 8
  ret %class.Person* %35
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZSt19__relocate_object_aI6PersonS0_SaIS0_EEvPT_PT0_RT1_(%class.Person* noalias noundef %0, %class.Person* noalias noundef %1, %"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %2) #6 comdat {
  %4 = alloca %class.Person*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %"class.std::ios_base::Init"*, align 8
  store %class.Person* %0, %class.Person** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %"class.std::ios_base::Init"* %2, %"class.std::ios_base::Init"** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %6, align 8
  %8 = load %class.Person*, %class.Person** %4, align 8
  %9 = load %class.Person*, %class.Person** %5, align 8
  %10 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt4moveIR6PersonEONSt16remove_referenceIT_E4typeEOS3_(%class.Person* noundef nonnull align 8 dereferenceable(36) %9) #3
  call void @_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JS0_EEEvRS1_PT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %7, %class.Person* noundef %8, %class.Person* noundef nonnull align 8 dereferenceable(36) %10) #3
  %11 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %6, align 8
  %12 = load %class.Person*, %class.Person** %5, align 8
  %13 = call noundef %class.Person* @_ZSt11__addressofI6PersonEPT_RS1_(%class.Person* noundef nonnull align 8 dereferenceable(36) %12) #3
  call void @_ZNSt16allocator_traitsISaI6PersonEE7destroyIS0_EEvRS1_PT_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %11, %class.Person* noundef %13) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt4moveIR6PersonEONSt16remove_referenceIT_E4typeEOS3_(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  ret %class.Person* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaI6PersonEE9constructIS0_JS0_EEEvRS1_PT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, %class.Person* noundef nonnull align 8 dereferenceable(36) %2) #6 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %class.Person* %2, %class.Person** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = bitcast %"class.std::ios_base::Init"* %7 to %"class.std::ios_base::Init"*
  %9 = load %class.Person*, %class.Person** %5, align 8
  %10 = load %class.Person*, %class.Person** %6, align 8
  %11 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardI6PersonEOT_RNSt16remove_referenceIS1_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %10) #3
  call void @_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JS1_EEEvPT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %8, %class.Person* noundef %9, %class.Person* noundef nonnull align 8 dereferenceable(36) %11) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardI6PersonEOT_RNSt16remove_referenceIS1_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %0) #6 comdat {
  %2 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %2, align 8
  %3 = load %class.Person*, %class.Person** %2, align 8
  ret %class.Person* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JS1_EEEvPT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, %class.Person* noundef nonnull align 8 dereferenceable(36) %2) #6 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %class.Person* %2, %class.Person** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = load %class.Person*, %class.Person** %5, align 8
  %9 = bitcast %class.Person* %8 to i8*
  %10 = bitcast i8* %9 to %class.Person*
  %11 = load %class.Person*, %class.Person** %6, align 8
  %12 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardI6PersonEOT_RNSt16remove_referenceIS1_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %11) #3
  call void @_ZN6PersonC2EOS_(%class.Person* noundef nonnull align 8 dereferenceable(36) %10, %class.Person* noundef nonnull align 8 dereferenceable(36) %12) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN6PersonC2EOS_(%class.Person* noundef nonnull align 8 dereferenceable(36) %0, %class.Person* noundef nonnull align 8 dereferenceable(36) %1) unnamed_addr #5 comdat align 2 {
  %3 = alloca %class.Person*, align 8
  %4 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %class.Person*, %class.Person** %3, align 8
  %6 = bitcast %class.Person* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @136, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @137, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %class.Person, %class.Person* %5, i32 0, i32 0
  %14 = load %class.Person*, %class.Person** %4, align 8
  %15 = bitcast %class.Person* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @138, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @139, i32 0, i32 0), i32 0, i64 %19)
  %22 = getelementptr inbounds %class.Person, %class.Person* %14, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EOS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %13, %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %22) #3
  %23 = bitcast %class.Person* %5 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @140, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @141, i32 0, i32 0), i32 1, i64 %27)
  %30 = getelementptr inbounds %class.Person, %class.Person* %5, i32 0, i32 1
  %31 = load %class.Person*, %class.Person** %4, align 8
  %32 = bitcast %class.Person* %31 to i8*
  %33 = call i64 @getBufferSize(i8* %32)
  %34 = load i8*, i8** @globalFilePtr, align 8
  %35 = call i32 (i8*, i8*, ...) @fprintf(i8* %34, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @142, i32 0, i32 0), i32 0, i64 %33)
  %36 = call i64 @getBufferSize(i8* %32)
  %37 = load i8*, i8** @globalFilePtr, align 8
  %38 = call i32 (i8*, i8*, ...) @fprintf(i8* %37, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @143, i32 0, i32 0), i32 1, i64 %36)
  %39 = getelementptr inbounds %class.Person, %class.Person* %31, i32 0, i32 1
  %40 = load i32, i32* %39, align 8
  store i32 %40, i32* %30, align 8
  ret void
}

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EOS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32), %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32)) unnamed_addr #2

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZNSt16allocator_traitsISaI6PersonEE8allocateERS1_m(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca i64, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = bitcast %"class.std::ios_base::Init"* %5 to %"class.std::ios_base::Init"*
  %7 = load i64, i64* %4, align 8
  %8 = call noundef %class.Person* @_ZN9__gnu_cxx13new_allocatorI6PersonE8allocateEmPKv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %6, i64 noundef %7, i8* noundef null)
  ret %class.Person* %8
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef %class.Person* @_ZN9__gnu_cxx13new_allocatorI6PersonE8allocateEmPKv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1, i8* noundef %2) #7 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = call noundef i64 @_ZNK9__gnu_cxx13new_allocatorI6PersonE11_M_max_sizeEv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %7) #3
  %10 = icmp ugt i64 %8, %9
  br i1 %10, label %11, label %16

11:                                               ; preds = %3
  %12 = load i64, i64* %5, align 8
  %13 = icmp ugt i64 %12, 461168601842738790
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  call void @_ZSt28__throw_bad_array_new_lengthv() #14
  unreachable

15:                                               ; preds = %11
  call void @_ZSt17__throw_bad_allocv() #14
  unreachable

16:                                               ; preds = %3
  %17 = load i64, i64* %5, align 8
  %18 = mul i64 %17, 40
  %19 = call noalias noundef nonnull i8* @_Znwm(i64 noundef %18) #15
  %20 = call i8* @malloc(i64 24)
  %21 = bitcast i8* %20 to %BufferNode*
  %22 = getelementptr inbounds %BufferNode, %BufferNode* %21, i32 0, i32 0
  store i8* %19, i8** %22, align 8
  %23 = getelementptr inbounds %BufferNode, %BufferNode* %21, i32 0, i32 1
  store i64 %18, i64* %23, align 8
  %24 = getelementptr inbounds %BufferNode, %BufferNode* %21, i32 0, i32 2
  store %BufferNode* null, %BufferNode** %24, align 8
  %currentHead = load %BufferNode*, %BufferNode** @BufferListHead, align 8
  store %BufferNode* %21, %BufferNode** @BufferListHead, align 8
  %25 = getelementptr inbounds %BufferNode, %BufferNode* %21, i32 0, i32 2
  store %BufferNode* %currentHead, %BufferNode** %25, align 8
  %26 = load i8*, i8** @globalFilePtr, align 8
  %27 = call i32 (i8*, i8*, ...) @fprintf(i8* %26, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @fileFormatString, i32 0, i32 0), i64 %18)
  %28 = bitcast i8* %19 to %class.Person*
  ret %class.Person* %28
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNK9__gnu_cxx13new_allocatorI6PersonE11_M_max_sizeEv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) #6 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  ret i64 230584300921369395
}

; Function Attrs: noreturn
declare void @_ZSt28__throw_bad_array_new_lengthv() #11

; Function Attrs: noreturn
declare void @_ZSt17__throw_bad_allocv() #11

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull i8* @_Znwm(i64 noundef) #12

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx17__normal_iteratorIP6PersonSt6vectorIS1_SaIS1_EEEC2ERKS2_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0, %class.Person** noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #5 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  %4 = alloca %class.Person**, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  store %class.Person** %1, %class.Person*** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  %6 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @144, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @145, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %5, i32 0, i32 0
  %14 = load %class.Person**, %class.Person*** %4, align 8
  %15 = load %class.Person*, %class.Person** %14, align 8
  store %class.Person* %15, %class.Person** %13, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE8max_sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %2, align 8
  %3 = load %"class.std::vector"*, %"class.std::vector"** %2, align 8
  %4 = bitcast %"class.std::vector"* %3 to %"struct.std::_Vector_base"*
  %5 = call noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNKSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %4) #3
  %6 = call noundef i64 @_ZNSt6vectorI6PersonSaIS0_EE11_S_max_sizeERKS1_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5) #3
  ret i64 %6
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %2, align 8
  %3 = load %"class.std::vector"*, %"class.std::vector"** %2, align 8
  %4 = bitcast %"class.std::vector"* %3 to %"struct.std::_Vector_base"*
  %5 = bitcast %"struct.std::_Vector_base"* %4 to i8*
  %6 = call i64 @getBufferSize(i8* %5)
  %7 = load i8*, i8** @globalFilePtr, align 8
  %8 = call i32 (i8*, i8*, ...) @fprintf(i8* %7, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @146, i32 0, i32 0), i32 0, i64 %6)
  %9 = call i64 @getBufferSize(i8* %5)
  %10 = load i8*, i8** @globalFilePtr, align 8
  %11 = call i32 (i8*, i8*, ...) @fprintf(i8* %10, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @147, i32 0, i32 0), i32 0, i64 %9)
  %12 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %4, i32 0, i32 0
  %13 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %12 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %13 to i8*
  %15 = call i64 @getBufferSize(i8* %14)
  %16 = load i8*, i8** @globalFilePtr, align 8
  %17 = call i32 (i8*, i8*, ...) @fprintf(i8* %16, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @148, i32 0, i32 0), i32 0, i64 %15)
  %18 = call i64 @getBufferSize(i8* %14)
  %19 = load i8*, i8** @globalFilePtr, align 8
  %20 = call i32 (i8*, i8*, ...) @fprintf(i8* %19, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @149, i32 0, i32 0), i32 1, i64 %18)
  %21 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %13, i32 0, i32 1
  %22 = load %class.Person*, %class.Person** %21, align 8
  %23 = bitcast %"class.std::vector"* %3 to %"struct.std::_Vector_base"*
  %24 = bitcast %"struct.std::_Vector_base"* %23 to i8*
  %25 = call i64 @getBufferSize(i8* %24)
  %26 = load i8*, i8** @globalFilePtr, align 8
  %27 = call i32 (i8*, i8*, ...) @fprintf(i8* %26, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @150, i32 0, i32 0), i32 0, i64 %25)
  %28 = call i64 @getBufferSize(i8* %24)
  %29 = load i8*, i8** @globalFilePtr, align 8
  %30 = call i32 (i8*, i8*, ...) @fprintf(i8* %29, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @151, i32 0, i32 0), i32 0, i64 %28)
  %31 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %23, i32 0, i32 0
  %32 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %31 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %33 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %32 to i8*
  %34 = call i64 @getBufferSize(i8* %33)
  %35 = load i8*, i8** @globalFilePtr, align 8
  %36 = call i32 (i8*, i8*, ...) @fprintf(i8* %35, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @152, i32 0, i32 0), i32 0, i64 %34)
  %37 = call i64 @getBufferSize(i8* %33)
  %38 = load i8*, i8** @globalFilePtr, align 8
  %39 = call i32 (i8*, i8*, ...) @fprintf(i8* %38, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @153, i32 0, i32 0), i32 0, i64 %37)
  %40 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %32, i32 0, i32 0
  %41 = load %class.Person*, %class.Person** %40, align 8
  %42 = ptrtoint %class.Person* %22 to i64
  %43 = ptrtoint %class.Person* %41 to i64
  %44 = sub i64 %42, %43
  %45 = sdiv exact i64 %44, 40
  ret i64 %45
}

; Function Attrs: noreturn
declare void @_ZSt20__throw_length_errorPKc(i8* noundef) #11

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(8) i64* @_ZSt3maxImERKT_S2_S2_(i64* noundef nonnull align 8 dereferenceable(8) %0, i64* noundef nonnull align 8 dereferenceable(8) %1) #6 comdat {
  %3 = alloca i64*, align 8
  %4 = alloca i64*, align 8
  %5 = alloca i64*, align 8
  store i64* %0, i64** %4, align 8
  store i64* %1, i64** %5, align 8
  %6 = load i64*, i64** %4, align 8
  %7 = load i64, i64* %6, align 8
  %8 = load i64*, i64** %5, align 8
  %9 = load i64, i64* %8, align 8
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %13

11:                                               ; preds = %2
  %12 = load i64*, i64** %5, align 8
  store i64* %12, i64** %3, align 8
  br label %15

13:                                               ; preds = %2
  %14 = load i64*, i64** %4, align 8
  store i64* %14, i64** %3, align 8
  br label %15

15:                                               ; preds = %13, %11
  %16 = load i64*, i64** %3, align 8
  ret i64* %16
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZNKSt12_Vector_baseI6PersonSaIS0_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base"*, align 8
  store %"struct.std::_Vector_base"* %0, %"struct.std::_Vector_base"** %2, align 8
  %3 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @154, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @155, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %3, i32 0, i32 0
  %12 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %11 to %"class.std::ios_base::Init"*
  ret %"class.std::ios_base::Init"* %12
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNSt6vectorI6PersonSaIS0_EE11_S_max_sizeERKS1_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) #6 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  store i64 230584300921369395, i64* %3, align 8
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %6 = call noundef i64 @_ZNSt16allocator_traitsISaI6PersonEE8max_sizeERKS1_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %5) #3
  store i64 %6, i64* %4, align 8
  %7 = invoke noundef nonnull align 8 dereferenceable(8) i64* @_ZSt3minImERKT_S2_S2_(i64* noundef nonnull align 8 dereferenceable(8) %3, i64* noundef nonnull align 8 dereferenceable(8) %4)
          to label %8 unwind label %10

8:                                                ; preds = %1
  %9 = load i64, i64* %7, align 8
  ret i64 %9

10:                                               ; preds = %1
  %11 = landingpad { i8*, i32 }
          catch i8* null
  %12 = extractvalue { i8*, i32 } %11, 0
  call void @__clang_call_terminate(i8* %12) #13
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNSt16allocator_traitsISaI6PersonEE8max_sizeERKS1_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) #6 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"class.std::ios_base::Init"*
  %5 = call noundef i64 @_ZNK9__gnu_cxx13new_allocatorI6PersonE8max_sizeEv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %4) #3
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(8) i64* @_ZSt3minImERKT_S2_S2_(i64* noundef nonnull align 8 dereferenceable(8) %0, i64* noundef nonnull align 8 dereferenceable(8) %1) #6 comdat {
  %3 = alloca i64*, align 8
  %4 = alloca i64*, align 8
  %5 = alloca i64*, align 8
  store i64* %0, i64** %4, align 8
  store i64* %1, i64** %5, align 8
  %6 = load i64*, i64** %5, align 8
  %7 = load i64, i64* %6, align 8
  %8 = load i64*, i64** %4, align 8
  %9 = load i64, i64* %8, align 8
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %13

11:                                               ; preds = %2
  %12 = load i64*, i64** %5, align 8
  store i64* %12, i64** %3, align 8
  br label %15

13:                                               ; preds = %2
  %14 = load i64*, i64** %4, align 8
  store i64* %14, i64** %3, align 8
  br label %15

15:                                               ; preds = %13, %11
  %16 = load i64*, i64** %3, align 8
  ret i64* %16
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNK9__gnu_cxx13new_allocatorI6PersonE8max_sizeEv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0) #6 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = call noundef i64 @_ZNK9__gnu_cxx13new_allocatorI6PersonE11_M_max_sizeEv(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %3) #3
  ret i64 %4
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorI6PersonE9constructIS1_JRKS1_EEEvPT_DpOT0_(%"class.std::ios_base::Init"* noundef nonnull align 1 dereferenceable(1) %0, %class.Person* noundef %1, %class.Person* noundef nonnull align 8 dereferenceable(36) %2) #7 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %class.Person*, align 8
  %6 = alloca %class.Person*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store %class.Person* %1, %class.Person** %5, align 8
  store %class.Person* %2, %class.Person** %6, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = load %class.Person*, %class.Person** %5, align 8
  %9 = bitcast %class.Person* %8 to i8*
  %10 = bitcast i8* %9 to %class.Person*
  %11 = load %class.Person*, %class.Person** %6, align 8
  %12 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZSt7forwardIRK6PersonEOT_RNSt16remove_referenceIS3_E4typeE(%class.Person* noundef nonnull align 8 dereferenceable(36) %11) #3
  call void @_ZN6PersonC2ERKS_(%class.Person* noundef nonnull align 8 dereferenceable(36) %10, %class.Person* noundef nonnull align 8 dereferenceable(36) %12)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN6PersonC2ERKS_(%class.Person* noundef nonnull align 8 dereferenceable(36) %0, %class.Person* noundef nonnull align 8 dereferenceable(36) %1) unnamed_addr #10 comdat align 2 {
  %3 = alloca %class.Person*, align 8
  %4 = alloca %class.Person*, align 8
  store %class.Person* %0, %class.Person** %3, align 8
  store %class.Person* %1, %class.Person** %4, align 8
  %5 = load %class.Person*, %class.Person** %3, align 8
  %6 = bitcast %class.Person* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @156, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @157, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %class.Person, %class.Person* %5, i32 0, i32 0
  %14 = load %class.Person*, %class.Person** %4, align 8
  %15 = bitcast %class.Person* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @158, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @159, i32 0, i32 0), i32 0, i64 %19)
  %22 = getelementptr inbounds %class.Person, %class.Person* %14, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_(%"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %13, %"class.std::__cxx11::basic_string"* noundef nonnull align 8 dereferenceable(32) %22)
  %23 = bitcast %class.Person* %5 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @160, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @161, i32 0, i32 0), i32 1, i64 %27)
  %30 = getelementptr inbounds %class.Person, %class.Person* %5, i32 0, i32 1
  %31 = load %class.Person*, %class.Person** %4, align 8
  %32 = bitcast %class.Person* %31 to i8*
  %33 = call i64 @getBufferSize(i8* %32)
  %34 = load i8*, i8** @globalFilePtr, align 8
  %35 = call i32 (i8*, i8*, ...) @fprintf(i8* %34, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @162, i32 0, i32 0), i32 0, i64 %33)
  %36 = call i64 @getBufferSize(i8* %32)
  %37 = load i8*, i8** @globalFilePtr, align 8
  %38 = call i32 (i8*, i8*, ...) @fprintf(i8* %37, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @163, i32 0, i32 0), i32 1, i64 %36)
  %39 = getelementptr inbounds %class.Person, %class.Person* %31, i32 0, i32 1
  %40 = load i32, i32* %39, align 8
  store i32 %40, i32* %30, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_ZNK5Group15printAllMembersEv(%class.Group* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %class.Group*, align 8
  %3 = alloca %"class.std::vector"*, align 8
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %5 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %6 = alloca %class.Person*, align 8
  store %class.Group* %0, %class.Group** %2, align 8
  %7 = load %class.Group*, %class.Group** %2, align 8
  %8 = bitcast %class.Group* %7 to i8*
  %9 = call i64 @getBufferSize(i8* %8)
  %10 = load i8*, i8** @globalFilePtr, align 8
  %11 = call i32 (i8*, i8*, ...) @fprintf(i8* %10, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @164, i32 0, i32 0), i32 0, i64 %9)
  %12 = call i64 @getBufferSize(i8* %8)
  %13 = load i8*, i8** @globalFilePtr, align 8
  %14 = call i32 (i8*, i8*, ...) @fprintf(i8* %13, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @165, i32 0, i32 0), i32 0, i64 %12)
  %15 = getelementptr inbounds %class.Group, %class.Group* %7, i32 0, i32 0
  store %"class.std::vector"* %15, %"class.std::vector"** %3, align 8
  %16 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %17 = call %class.Person* @_ZNKSt6vectorI6PersonSaIS0_EE5beginEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %16) #3
  %18 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %4 to i8*
  %19 = call i64 @getBufferSize(i8* %18)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @166, i32 0, i32 0), i32 0, i64 %19)
  %22 = call i64 @getBufferSize(i8* %18)
  %23 = load i8*, i8** @globalFilePtr, align 8
  %24 = call i32 (i8*, i8*, ...) @fprintf(i8* %23, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @167, i32 0, i32 0), i32 0, i64 %22)
  %25 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %4, i32 0, i32 0
  store %class.Person* %17, %class.Person** %25, align 8
  %26 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %27 = call %class.Person* @_ZNKSt6vectorI6PersonSaIS0_EE3endEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %26) #3
  %28 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %5 to i8*
  %29 = call i64 @getBufferSize(i8* %28)
  %30 = load i8*, i8** @globalFilePtr, align 8
  %31 = call i32 (i8*, i8*, ...) @fprintf(i8* %30, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @168, i32 0, i32 0), i32 0, i64 %29)
  %32 = call i64 @getBufferSize(i8* %28)
  %33 = load i8*, i8** @globalFilePtr, align 8
  %34 = call i32 (i8*, i8*, ...) @fprintf(i8* %33, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @169, i32 0, i32 0), i32 0, i64 %32)
  %35 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %5, i32 0, i32 0
  store %class.Person* %27, %class.Person** %35, align 8
  br label %36

36:                                               ; preds = %41, %1
  %37 = call noundef zeroext i1 @_ZN9__gnu_cxxneIPK6PersonSt6vectorIS1_SaIS1_EEEEbRKNS_17__normal_iteratorIT_T0_EESC_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4, %"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %5) #3
  br i1 %37, label %38, label %43

38:                                               ; preds = %36
  %39 = call noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEdeEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4) #3
  store %class.Person* %39, %class.Person** %6, align 8
  %40 = load %class.Person*, %class.Person** %6, align 8
  call void @_ZNK6Person9printInfoEv(%class.Person* noundef nonnull align 8 dereferenceable(36) %40)
  br label %41

41:                                               ; preds = %38
  %42 = call noundef nonnull align 8 dereferenceable(8) %"class.__gnu_cxx::__normal_iterator.3"* @_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEppEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %4) #3
  br label %36

43:                                               ; preds = %36
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %class.Person* @_ZNKSt6vectorI6PersonSaIS0_EE5beginEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %3 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %3, align 8
  %4 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %5 = bitcast %"class.std::vector"* %4 to %"struct.std::_Vector_base"*
  %6 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @170, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @171, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %13 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @172, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @173, i32 0, i32 0), i32 0, i64 %19)
  %22 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14, i32 0, i32 0
  call void @_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %2, %class.Person** noundef nonnull align 8 dereferenceable(8) %22) #3
  %23 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %2 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @174, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @175, i32 0, i32 0), i32 0, i64 %27)
  %30 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %2, i32 0, i32 0
  %31 = load %class.Person*, %class.Person** %30, align 8
  ret %class.Person* %31
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %class.Person* @_ZNKSt6vectorI6PersonSaIS0_EE3endEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3", align 8
  %3 = alloca %"class.std::vector"*, align 8
  store %"class.std::vector"* %0, %"class.std::vector"** %3, align 8
  %4 = load %"class.std::vector"*, %"class.std::vector"** %3, align 8
  %5 = bitcast %"class.std::vector"* %4 to %"struct.std::_Vector_base"*
  %6 = bitcast %"struct.std::_Vector_base"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @176, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @177, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %5, i32 0, i32 0
  %14 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl"* %13 to %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"*
  %15 = bitcast %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14 to i8*
  %16 = call i64 @getBufferSize(i8* %15)
  %17 = load i8*, i8** @globalFilePtr, align 8
  %18 = call i32 (i8*, i8*, ...) @fprintf(i8* %17, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @178, i32 0, i32 0), i32 0, i64 %16)
  %19 = call i64 @getBufferSize(i8* %15)
  %20 = load i8*, i8** @globalFilePtr, align 8
  %21 = call i32 (i8*, i8*, ...) @fprintf(i8* %20, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @179, i32 0, i32 0), i32 1, i64 %19)
  %22 = getelementptr inbounds %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data", %"struct.std::_Vector_base<Person, std::allocator<Person>>::_Vector_impl_data"* %14, i32 0, i32 1
  call void @_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %2, %class.Person** noundef nonnull align 8 dereferenceable(8) %22) #3
  %23 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %2 to i8*
  %24 = call i64 @getBufferSize(i8* %23)
  %25 = load i8*, i8** @globalFilePtr, align 8
  %26 = call i32 (i8*, i8*, ...) @fprintf(i8* %25, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @180, i32 0, i32 0), i32 0, i64 %24)
  %27 = call i64 @getBufferSize(i8* %23)
  %28 = load i8*, i8** @globalFilePtr, align 8
  %29 = call i32 (i8*, i8*, ...) @fprintf(i8* %28, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @181, i32 0, i32 0), i32 0, i64 %27)
  %30 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %2, i32 0, i32 0
  %31 = load %class.Person*, %class.Person** %30, align 8
  ret %class.Person* %31
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef zeroext i1 @_ZN9__gnu_cxxneIPK6PersonSt6vectorIS1_SaIS1_EEEEbRKNS_17__normal_iteratorIT_T0_EESC_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0, %"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %1) #6 comdat {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %1, %"class.__gnu_cxx::__normal_iterator.3"** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  %6 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %5) #3
  %7 = load %class.Person*, %class.Person** %6, align 8
  %8 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %4, align 8
  %9 = call noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %8) #3
  %10 = load %class.Person*, %class.Person** %9, align 8
  %11 = icmp ne %class.Person* %7, %10
  ret i1 %11
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(36) %class.Person* @_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEdeEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %4 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @182, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @183, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %3, i32 0, i32 0
  %12 = load %class.Person*, %class.Person** %11, align 8
  ret %class.Person* %12
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(8) %"class.__gnu_cxx::__normal_iterator.3"* @_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEppEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %4 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @184, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @185, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %3, i32 0, i32 0
  %12 = load %class.Person*, %class.Person** %11, align 8
  %13 = bitcast %class.Person* %12 to i8*
  %14 = call i64 @getBufferSize(i8* %13)
  %15 = load i8*, i8** @globalFilePtr, align 8
  %16 = call i32 (i8*, i8*, ...) @fprintf(i8* %15, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @186, i32 0, i32 0), i32 1, i64 %14)
  %17 = getelementptr inbounds %class.Person, %class.Person* %12, i32 1
  store %class.Person* %17, %class.Person** %11, align 8
  ret %"class.__gnu_cxx::__normal_iterator.3"* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(8) %class.Person** @_ZNK9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0) #6 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %2, align 8
  %4 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @187, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @188, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %3, i32 0, i32 0
  ret %class.Person** %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx17__normal_iteratorIPK6PersonSt6vectorIS1_SaIS1_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.3"* noundef nonnull align 8 dereferenceable(8) %0, %class.Person** noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #5 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.3"*, align 8
  %4 = alloca %class.Person**, align 8
  store %"class.__gnu_cxx::__normal_iterator.3"* %0, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  store %class.Person** %1, %class.Person*** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.3"*, %"class.__gnu_cxx::__normal_iterator.3"** %3, align 8
  %6 = bitcast %"class.__gnu_cxx::__normal_iterator.3"* %5 to i8*
  %7 = call i64 @getBufferSize(i8* %6)
  %8 = load i8*, i8** @globalFilePtr, align 8
  %9 = call i32 (i8*, i8*, ...) @fprintf(i8* %8, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @189, i32 0, i32 0), i32 0, i64 %7)
  %10 = call i64 @getBufferSize(i8* %6)
  %11 = load i8*, i8** @globalFilePtr, align 8
  %12 = call i32 (i8*, i8*, ...) @fprintf(i8* %11, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @190, i32 0, i32 0), i32 0, i64 %10)
  %13 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.3", %"class.__gnu_cxx::__normal_iterator.3"* %5, i32 0, i32 0
  %14 = load %class.Person**, %class.Person*** %4, align 8
  %15 = load %class.Person*, %class.Person** %14, align 8
  store %class.Person* %15, %class.Person** %13, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local noundef i32 @_ZNK5Group7getSizeEv(%class.Group* noundef nonnull align 8 dereferenceable(24) %0) #6 align 2 {
  %2 = alloca %class.Group*, align 8
  store %class.Group* %0, %class.Group** %2, align 8
  %3 = load %class.Group*, %class.Group** %2, align 8
  %4 = bitcast %class.Group* %3 to i8*
  %5 = call i64 @getBufferSize(i8* %4)
  %6 = load i8*, i8** @globalFilePtr, align 8
  %7 = call i32 (i8*, i8*, ...) @fprintf(i8* %6, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @191, i32 0, i32 0), i32 0, i64 %5)
  %8 = call i64 @getBufferSize(i8* %4)
  %9 = load i8*, i8** @globalFilePtr, align 8
  %10 = call i32 (i8*, i8*, ...) @fprintf(i8* %9, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @192, i32 0, i32 0), i32 0, i64 %8)
  %11 = getelementptr inbounds %class.Group, %class.Group* %3, i32 0, i32 0
  %12 = call noundef i64 @_ZNKSt6vectorI6PersonSaIS0_EE4sizeEv(%"class.std::vector"* noundef nonnull align 8 dereferenceable(24) %11) #3
  %13 = trunc i64 %12 to i32
  ret i32 %13
}

declare i32 @printf(i8*, ...)

declare i8* @fopen(i8*, i8*)

declare i32 @fprintf(i8*, i8*, ...)

declare i8* @malloc(i64)

define i64 @getBufferSize(i8* %bufferAddress) {
entry:
  %current = load %BufferNode*, %BufferNode** @BufferListHead, align 8
  %currentNodeAlloca = alloca %BufferNode*, align 8
  store %BufferNode* %current, %BufferNode** %currentNodeAlloca, align 8
  br label %checkIfHeadIsNull

checkIfHeadIsNull:                                ; preds = %entry
  %isEnd = icmp eq %BufferNode* %current, null
  br i1 %isEnd, label %exitBlock, label %loopBody

loopBody:                                         ; preds = %nextIteration, %checkIfHeadIsNull
  %current1 = load %BufferNode*, %BufferNode** %currentNodeAlloca, align 8
  %nodeDataAddr = getelementptr inbounds %BufferNode, %BufferNode* %current1, i32 0, i32 0
  %nodeData = load i8*, i8** %nodeDataAddr, align 8
  %isMatch = icmp eq i8* %nodeData, %bufferAddress
  br i1 %isMatch, label %sizeFound, label %nextIteration

exitBlock:                                        ; preds = %nextIteration, %checkIfHeadIsNull
  ret i64 0

sizeFound:                                        ; preds = %loopBody
  %dataSizeAddr = getelementptr inbounds %BufferNode, %BufferNode* %current1, i32 0, i32 1
  %dataSize = load i64, i64* %dataSizeAddr, align 8
  ret i64 %dataSize

nextIteration:                                    ; preds = %loopBody
  %nextNodeAddr = getelementptr inbounds %BufferNode, %BufferNode* %current1, i32 0, i32 2
  %nextNode = load %BufferNode*, %BufferNode** %nextNodeAddr, align 8
  store %BufferNode* %nextNode, %BufferNode** %currentNodeAlloca, align 8
  %isEnd2 = icmp eq %BufferNode* %nextNode, null
  br i1 %isEnd2, label %exitBlock, label %loopBody
}

define void @printBufferList() {
entry:
  %head = load %BufferNode*, %BufferNode** @BufferListHead, align 8
  %currentNodeAlloca = alloca %BufferNode*, align 8
  store %BufferNode* %head, %BufferNode** %currentNodeAlloca, align 8
  br label %checkIfHeadIsNull

checkIfHeadIsNull:                                ; preds = %entry
  %isEnd = icmp eq %BufferNode* %head, null
  br i1 %isEnd, label %exit, label %loopBody

loopBody:                                         ; preds = %loopBody, %checkIfHeadIsNull
  %current = load %BufferNode*, %BufferNode** %currentNodeAlloca, align 8
  %dataPtr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 0
  %data = load i8*, i8** %dataPtr, align 8
  %0 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @formatAddrString, i32 0, i32 0), i8* %data)
  %dataSizePtr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 1
  %dataSize = load i64, i64* %dataSizePtr, align 8
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @formatSizeString, i32 0, i32 0), i64 %dataSize)
  %nextNodeAddr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 2
  %nextNode = load %BufferNode*, %BufferNode** %nextNodeAddr, align 8
  store %BufferNode* %nextNode, %BufferNode** %currentNodeAlloca, align 8
  %isEnd1 = icmp eq %BufferNode* %nextNode, null
  br i1 %isEnd1, label %exit, label %loopBody

exit:                                             ; preds = %loopBody, %checkIfHeadIsNull
  ret void
}

declare i32 @fclose(i8*)

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { noinline noreturn nounwind }
attributes #9 = { nobuiltin nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nobuiltin allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { noreturn nounwind }
attributes #14 = { noreturn }
attributes #15 = { allocsize(0) }

!llvm.ident = !{!0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
