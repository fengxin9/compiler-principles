	.file	"factorial.cpp"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.section	.text._ZNKSt5ctypeIcE8do_widenEc,"axG",@progbits,_ZNKSt5ctypeIcE8do_widenEc,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt5ctypeIcE8do_widenEc
	.type	_ZNKSt5ctypeIcE8do_widenEc, @function
_ZNKSt5ctypeIcE8do_widenEc:
.LFB1797:
	.cfi_startproc
	endbr64
	movl	%esi, %eax
	ret
	.cfi_endproc
.LFE1797:
	.size	_ZNKSt5ctypeIcE8do_widenEc, .-_ZNKSt5ctypeIcE8do_widenEc
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.section	.text.startup,"ax",@progbits
.LHOTB0:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB2047:
	.cfi_startproc
	endbr64
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	_ZSt3cin(%rip), %rdi
	movq	%fs:40, %rsi
	movq	%rsi, 24(%rsp)
	leaq	20(%rsp), %rsi
	call	_ZNSirsERi@PLT
	movl	20(%rsp), %edx
	cmpl	$1, %edx
	jle	.L11
	leal	1(%rdx), %ecx
	andl	$1, %edx
	movl	$1, %esi
	movl	$2, %eax
	jne	.L5
	movl	$3, %eax
	movl	$2, %esi
	cmpl	%ecx, %eax
	je	.L4
	.p2align 4
	.p2align 4
	.p2align 3
.L5:
	imull	%eax, %esi
	leal	1(%rax), %edx
	addl	$2, %eax
	imull	%edx, %esi
	cmpl	%ecx, %eax
	jne	.L5
.L4:
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEi@PLT
	movq	%rax, %rdx
	movq	(%rax), %rax
	movq	-24(%rax), %rax
	movq	240(%rdx,%rax), %rdi
	testq	%rdi, %rdi
	je	.L18
	cmpb	$0, 56(%rdi)
	je	.L8
	movsbl	67(%rdi), %esi
.L9:
	movq	%rdx, %rdi
	call	_ZNSo3putEc@PLT
	movq	%rax, %rdi
	call	_ZNSo5flushEv@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L21
	xorl	%eax, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L8:
	.cfi_restore_state
	movq	%rdx, 8(%rsp)
	movq	%rdi, (%rsp)
	call	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	(%rsp), %rdi
	movq	8(%rsp), %rdx
	leaq	_ZNKSt5ctypeIcE8do_widenEc(%rip), %rcx
	movl	$10, %esi
	movq	(%rdi), %rax
	movq	48(%rax), %rax
	cmpq	%rcx, %rax
	je	.L9
	movq	%rdx, (%rsp)
	movl	$10, %esi
	call	*%rax
	movq	(%rsp), %rdx
	movsbl	%al, %esi
	jmp	.L9
.L11:
	movl	$1, %esi
	jmp	.L4
.L21:
	call	__stack_chk_fail@PLT
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB2047:
.L18:
	.cfi_def_cfa_offset 48
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L22
	call	_ZSt16__throw_bad_castv@PLT
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE2047:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE0:
	.section	.text.startup
.LHOTE0:
	.ident	"GCC: (Ubuntu 15.2.0-16ubuntu1) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
