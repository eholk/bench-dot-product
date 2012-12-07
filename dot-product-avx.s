	.file	"main.cpp"
	.text
	.p2align 4,,15
.globl _Z10simple_dotiPfS_
	.type	_Z10simple_dotiPfS_, @function
_Z10simple_dotiPfS_:
.LFB1193:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	testl	%edi, %edi
	jle	.L8
	subl	$1, %edi
	xorps	%xmm0, %xmm0
	leaq	4(,%rdi,4), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movss	(%rsi,%rax), %xmm1
	mulss	(%rdx,%rax), %xmm1
	addq	$4, %rax
	cmpq	%rcx, %rax
	addss	%xmm1, %xmm0
	jne	.L4
	rep
	ret
.L8:
	xorps	%xmm0, %xmm0
	ret
	.cfi_endproc
.LFE1193:
	.size	_Z10simple_dotiPfS_, .-_Z10simple_dotiPfS_
	.p2align 4,,15
.globl _Z7sse_dotiPfS_
	.type	_Z7sse_dotiPfS_, @function
_Z7sse_dotiPfS_:
.LFB1194:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	leal	3(%rdi), %eax
	testl	%edi, %edi
	xorps	%xmm1, %xmm1
	cmovs	%eax, %edi
	sarl	$2, %edi
	testl	%edi, %edi
	jle	.L11
	subl	$1, %edi
	xorl	%eax, %eax
	addq	$1, %rdi
	salq	$4, %rdi
	.p2align 4,,10
	.p2align 3
.L12:
	movaps	(%rsi,%rax), %xmm0
	mulps	(%rdx,%rax), %xmm0
	addq	$16, %rax
	cmpq	%rdi, %rax
	addps	%xmm0, %xmm1
	jne	.L12
.L11:
	movaps	%xmm1, -24(%rsp)
	xorps	%xmm0, %xmm0
	addss	-24(%rsp), %xmm0
	addss	-20(%rsp), %xmm0
	addss	-16(%rsp), %xmm0
	addss	-12(%rsp), %xmm0
	ret
	.cfi_endproc
.LFE1194:
	.size	_Z7sse_dotiPfS_, .-_Z7sse_dotiPfS_
	.p2align 4,,15
.globl _Z7avx_dotiPfS_
	.type	_Z7avx_dotiPfS_, @function
_Z7avx_dotiPfS_:
.LFB1195:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	leal	7(%rdi), %eax
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	subq	$40, %rsp
	testl	%edi, %edi
	cmovs	%eax, %edi
	sarl	$3, %edi
	testl	%edi, %edi
	jle	.L21
	subl	$1, %edi
	xorl	%eax, %eax
	movq	$0, 8(%rsp)
	addq	$1, %rdi
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	salq	$5, %rdi
	movq	$0, 32(%rsp)
    vxorps  %ymm1, %ymm1, %ymm1
	.p2align 4,,10
	.p2align 3
.L18:
	vmovaps	(%rsi,%rax), %ymm0
	vmulps	(%rdx,%rax), %ymm0, %ymm0
	addq	$32, %rax
	cmpq	%rdi, %rax
	vaddps	%ymm0, %ymm1, %ymm1
	jne	.L18
.L17:
	vmovaps	%ymm1, -24(%rsp)
	movq	8(%rsp), %rax
	xorps	%xmm0, %xmm0
	movq	%rax, -24(%rsp)
	movq	16(%rsp), %rax
	addss	-24(%rsp), %xmm0
	movq	%rax, -16(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, -8(%rsp)
	movq	32(%rsp), %rax
	addss	-20(%rsp), %xmm0
	movq	%rax, (%rsp)
	addss	-16(%rsp), %xmm0
	addss	-12(%rsp), %xmm0
	addss	-8(%rsp), %xmm0
	addss	-4(%rsp), %xmm0
	addss	(%rsp), %xmm0
	addss	4(%rsp), %xmm0
	leave
	ret
.L21:
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	jmp	.L17
	.cfi_endproc
.LFE1195:
	.size	_Z7avx_dotiPfS_, .-_Z7avx_dotiPfS_
	.p2align 4,,15
	.type	_GLOBAL__I__Z15generate_vectori, @function
_GLOBAL__I__Z15generate_vectori:
.LFB1326:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	addq	$8, %rsp
	jmp	__cxa_atexit
	.cfi_endproc
.LFE1326:
	.size	_GLOBAL__I__Z15generate_vectori, .-_GLOBAL__I__Z15generate_vectori
	.section	.ctors,"aw",@progbits
	.align 8
	.quad	_GLOBAL__I__Z15generate_vectori
	.text
	.p2align 4,,15
.globl _Z15generate_vectori
	.type	_Z15generate_vectori, @function
_Z15generate_vectori:
.LFB1191:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%r13
	.cfi_def_cfa_offset 16
	movslq	%edi,%rsi
	salq	$2, %rsi
	pushq	%r12
	.cfi_def_cfa_offset 24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	movl	%edi, %ebx
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movl	$32, %edi
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	memalign
	testl	%ebx, %ebx
	movq	%rax, %r13
	jle	.L25
	movq	%rax, %r12
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L26:
	call	drand48
	unpcklpd	%xmm0, %xmm0
	addl	$1, %ebp
	cvtpd2ps	%xmm0, %xmm0
	movss	%xmm0, (%r12)
	addq	$4, %r12
	cmpl	%ebp, %ebx
	jg	.L26
.L25:
	addq	$8, %rsp
	movq	%r13, %rax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.cfi_endproc
.LFE1191:
	.size	_Z15generate_vectori, .-_Z15generate_vectori
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Generating "
.LC2:
	.string	" element vectors."
.LC3:
	.string	"main.cpp"
.LC4:
	.string	"A"
.LC5:
	.string	"B"
.LC6:
	.string	"Simple\t"
.LC8:
	.string	"SSE\t"
.LC9:
	.string	"AVX\t"
	.text
	.p2align 4,,15
.globl main
	.type	main, @function
main:
.LFB1192:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%r13
	.cfi_def_cfa_offset 16
	movl	$11, %edx
	movl	$.LC1, %esi
	movl	$_ZSt4cout, %edi
	pushq	%r12
	.cfi_def_cfa_offset 24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movl	$33554432, %esi
	movl	$_ZSt4cout, %edi
	call	_ZNSo9_M_insertImEERSoT_
	movl	$17, %edx
	movq	%rax, %rbx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	240(%rbx,%rax), %rbp
	testq	%rbp, %rbp
	je	.L50
	cmpb	$0, 56(%rbp)
	je	.L31
	movzbl	67(%rbp), %eax
.L32:
	movsbl	%al,%esi
	movq	%rbx, %rdi
	call	_ZNSo3putEc
	movq	%rax, %rdi
	call	_ZNSo5flushEv
	movl	$134217728, %esi
	movl	$32, %edi
	call	memalign
	leaq	134217728(%rax), %r12
	movq	%rax, %rbp
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L33:
	call	drand48
	unpcklpd	%xmm0, %xmm0
	cvtpd2ps	%xmm0, %xmm0
	movss	%xmm0, (%rbx)
	addq	$4, %rbx
	cmpq	%r12, %rbx
	jne	.L33
	movl	$134217728, %esi
	movl	$32, %edi
	call	memalign
	leaq	134217728(%rax), %r13
	movq	%rax, %rbx
	movq	%rax, %r12
	.p2align 4,,10
	.p2align 3
.L34:
	call	drand48
	unpcklpd	%xmm0, %xmm0
	cvtpd2ps	%xmm0, %xmm0
	movss	%xmm0, (%r12)
	addq	$4, %r12
	cmpq	%r13, %r12
	jne	.L34
	testq	%rbp, %rbp
	je	.L51
	testq	%rbx, %rbx
	je	.L52
	.p2align 4,,7
	.p2align 3
	call	PAPI_get_real_usec
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$33554432, %edi
	movq	%rax, %r12
	call	_Z10simple_dotiPfS_
	movss	%xmm0, (%rsp)
	call	PAPI_get_real_usec
	cvttss2siq	(%rsp), %rdi
	movq	%rax, %r13
	subq	%r12, %r13
	call	srand48
	movl	$7, %edx
	movl	$.LC6, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	cvtsi2ssq	%r13, %xmm0
	movl	$_ZSt4cout, %edi
	divss	.LC7(%rip), %xmm0
	unpcklps	%xmm0, %xmm0
	cvtps2pd	%xmm0, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_
	movq	%rax, %r12
	movq	(%rax), %rax
	movq	-24(%rax), %rax
	movq	240(%r12,%rax), %r13
	testq	%r13, %r13
	je	.L50
	cmpb	$0, 56(%r13)
	je	.L38
	movzbl	67(%r13), %eax
.L39:
	movsbl	%al,%esi
	movq	%r12, %rdi
	call	_ZNSo3putEc
	movq	%rax, %rdi
	call	_ZNSo5flushEv
	call	PAPI_get_real_usec
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$33554432, %edi
	movq	%rax, %r12
	call	_Z7sse_dotiPfS_
	movss	%xmm0, (%rsp)
	call	PAPI_get_real_usec
	cvttss2siq	(%rsp), %rdi
	movq	%rax, %r13
	subq	%r12, %r13
	call	srand48
	movl	$4, %edx
	movl	$.LC8, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	cvtsi2ssq	%r13, %xmm0
	movl	$_ZSt4cout, %edi
	divss	.LC7(%rip), %xmm0
	unpcklps	%xmm0, %xmm0
	cvtps2pd	%xmm0, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_
	movq	%rax, %r12
	movq	(%rax), %rax
	movq	-24(%rax), %rax
	movq	240(%r12,%rax), %r13
	testq	%r13, %r13
	je	.L50
	cmpb	$0, 56(%r13)
	je	.L41
	movzbl	67(%r13), %eax
.L42:
	movsbl	%al,%esi
	movq	%r12, %rdi
	call	_ZNSo3putEc
	movq	%rax, %rdi
	call	_ZNSo5flushEv
	call	PAPI_get_real_usec
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$33554432, %edi
	movq	%rax, %r12
	call	_Z7avx_dotiPfS_
	movss	%xmm0, (%rsp)
	call	PAPI_get_real_usec
	cvttss2siq	(%rsp), %rdi
	movq	%rax, %r13
	subq	%r12, %r13
	call	srand48
	movl	$4, %edx
	movl	$.LC9, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	cvtsi2ssq	%r13, %xmm0
	movl	$_ZSt4cout, %edi
	divss	.LC7(%rip), %xmm0
	unpcklps	%xmm0, %xmm0
	cvtps2pd	%xmm0, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_
	movq	%rax, %r12
	movq	(%rax), %rax
	movq	-24(%rax), %rax
	movq	240(%r12,%rax), %r13
	testq	%r13, %r13
	je	.L50
	cmpb	$0, 56(%r13)
	je	.L44
	movzbl	67(%r13), %eax
.L45:
	movsbl	%al,%esi
	movq	%r12, %rdi
	call	_ZNSo3putEc
	movq	%rax, %rdi
	call	_ZNSo5flushEv
	movq	%rbp, %rdi
	call	free
	movq	%rbx, %rdi
	call	free
	addq	$24, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	movq	%rbp, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	movq	(%rbp), %rax
	movl	$10, %esi
	movq	%rbp, %rdi
	call	*48(%rax)
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L44:
	movq	%r13, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	movq	(%r13), %rax
	movl	$10, %esi
	movq	%r13, %rdi
	call	*48(%rax)
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L41:
	movq	%r13, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	movq	(%r13), %rax
	movl	$10, %esi
	movq	%r13, %rdi
	call	*48(%rax)
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L38:
	movq	%r13, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	movq	(%r13), %rax
	movl	$10, %esi
	movq	%r13, %rdi
	call	*48(%rax)
	jmp	.L39
.L50:
	.p2align 4,,5
	call	_ZSt16__throw_bad_castv
.L52:
	movl	$_ZZ4mainE19__PRETTY_FUNCTION__, %ecx
	movl	$50, %edx
	movl	$.LC3, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L51:
	movl	$_ZZ4mainE19__PRETTY_FUNCTION__, %ecx
	movl	$49, %edx
	movl	$.LC3, %esi
	movl	$.LC4, %edi
	call	__assert_fail
	.cfi_endproc
.LFE1192:
	.size	main, .-main
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata
	.type	_ZZ4mainE19__PRETTY_FUNCTION__, @object
	.size	_ZZ4mainE19__PRETTY_FUNCTION__, 11
_ZZ4mainE19__PRETTY_FUNCTION__:
	.string	"int main()"
	.weakref	_ZL20__gthrw_pthread_oncePiPFvvE,pthread_once
	.weakref	_ZL27__gthrw_pthread_getspecificj,pthread_getspecific
	.weakref	_ZL27__gthrw_pthread_setspecificjPKv,pthread_setspecific
	.weakref	_ZL22__gthrw_pthread_createPmPK14pthread_attr_tPFPvS3_ES3_,pthread_create
	.weakref	_ZL20__gthrw_pthread_joinmPPv,pthread_join
	.weakref	_ZL21__gthrw_pthread_equalmm,pthread_equal
	.weakref	_ZL20__gthrw_pthread_selfv,pthread_self
	.weakref	_ZL22__gthrw_pthread_detachm,pthread_detach
	.weakref	_ZL22__gthrw_pthread_cancelm,pthread_cancel
	.weakref	_ZL19__gthrw_sched_yieldv,sched_yield
	.weakref	_ZL26__gthrw_pthread_mutex_lockP15pthread_mutex_t,pthread_mutex_lock
	.weakref	_ZL29__gthrw_pthread_mutex_trylockP15pthread_mutex_t,pthread_mutex_trylock
	.weakref	_ZL31__gthrw_pthread_mutex_timedlockP15pthread_mutex_tPK8timespec,pthread_mutex_timedlock
	.weakref	_ZL28__gthrw_pthread_mutex_unlockP15pthread_mutex_t,pthread_mutex_unlock
	.weakref	_ZL26__gthrw_pthread_mutex_initP15pthread_mutex_tPK19pthread_mutexattr_t,pthread_mutex_init
	.weakref	_ZL29__gthrw_pthread_mutex_destroyP15pthread_mutex_t,pthread_mutex_destroy
	.weakref	_ZL30__gthrw_pthread_cond_broadcastP14pthread_cond_t,pthread_cond_broadcast
	.weakref	_ZL27__gthrw_pthread_cond_signalP14pthread_cond_t,pthread_cond_signal
	.weakref	_ZL25__gthrw_pthread_cond_waitP14pthread_cond_tP15pthread_mutex_t,pthread_cond_wait
	.weakref	_ZL30__gthrw_pthread_cond_timedwaitP14pthread_cond_tP15pthread_mutex_tPK8timespec,pthread_cond_timedwait
	.weakref	_ZL28__gthrw_pthread_cond_destroyP14pthread_cond_t,pthread_cond_destroy
	.weakref	_ZL26__gthrw_pthread_key_createPjPFvPvE,pthread_key_create
	.weakref	_ZL26__gthrw_pthread_key_deletej,pthread_key_delete
	.weakref	_ZL30__gthrw_pthread_mutexattr_initP19pthread_mutexattr_t,pthread_mutexattr_init
	.weakref	_ZL33__gthrw_pthread_mutexattr_settypeP19pthread_mutexattr_ti,pthread_mutexattr_settype
	.weakref	_ZL33__gthrw_pthread_mutexattr_destroyP19pthread_mutexattr_t,pthread_mutexattr_destroy
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC7:
	.long	1232348160
	.ident	"GCC: (Gentoo 4.4.5 p1.2, pie-0.4.5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
