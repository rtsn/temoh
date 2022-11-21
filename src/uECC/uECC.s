	.file	"uECC.c"
	.section	.rodata
.LC0:
	.string	"/dev/urandom"
.LC1:
	.string	"/dev/random"
	.text
	.type	default_RNG, @function
default_RNG:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movl	$524288, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	open
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L2
	movl	$524288, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	open
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	-44(%rbp), %eax
	movq	%rax, -24(%rbp)
	jmp	.L4
.L6:
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movl	-4(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jg	.L5
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$0, %eax
	jmp	.L3
.L5:
	movq	-32(%rbp), %rax
	subq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	addq	%rax, -16(%rbp)
.L4:
	cmpq	$0, -24(%rbp)
	jne	.L6
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	default_RNG, .-default_RNG
	.data
	.align 8
	.type	g_rng_function, @object
	.size	g_rng_function, 8
g_rng_function:
	.quad	default_RNG
	.text
	.globl	uECC_set_rng
	.type	uECC_set_rng, @function
uECC_set_rng:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, g_rng_function(%rip)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	uECC_set_rng, .-uECC_set_rng
	.type	uECC_vli_clear, @function
uECC_vli_clear:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, %eax
	movb	%al, -28(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L9
.L10:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L9:
	movzbl	-1(%rbp), %eax
	cmpb	-28(%rbp), %al
	jl	.L10
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	uECC_vli_clear, .-uECC_vli_clear
	.type	uECC_vli_isZero, @function
uECC_vli_isZero:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, %eax
	movb	%al, -28(%rbp)
	movq	$0, -8(%rbp)
	movb	$0, -9(%rbp)
	jmp	.L12
.L13:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	orq	%rax, -8(%rbp)
	movzbl	-9(%rbp), %eax
	addl	$1, %eax
	movb	%al, -9(%rbp)
.L12:
	movzbl	-9(%rbp), %eax
	cmpb	-28(%rbp), %al
	jl	.L13
	cmpq	$0, -8(%rbp)
	sete	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	uECC_vli_isZero, .-uECC_vli_isZero
	.type	uECC_vli_testBit, @function
uECC_vli_testBit:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, %eax
	movw	%ax, -12(%rbp)
	movzwl	-12(%rbp), %eax
	sarw	$6, %ax
	movswq	%ax, %rax
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movswl	-12(%rbp), %edx
	andl	$63, %edx
	movl	$1, %esi
	movl	%edx, %ecx
	salq	%cl, %rsi
	movq	%rsi, %rdx
	andq	%rdx, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	uECC_vli_testBit, .-uECC_vli_testBit
	.type	vli_numDigits, @function
vli_numDigits:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, %eax
	movb	%al, -28(%rbp)
	movzbl	-28(%rbp), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
	jmp	.L18
.L20:
	movzbl	-1(%rbp), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
.L18:
	cmpb	$0, -1(%rbp)
	js	.L19
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L20
.L19:
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	vli_numDigits, .-vli_numDigits
	.type	uECC_vli_numBits, @function
uECC_vli_numBits:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, %eax
	movb	%al, -44(%rbp)
	movsbl	-44(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	vli_numDigits
	movb	%al, -17(%rbp)
	cmpb	$0, -17(%rbp)
	jne	.L23
	movl	$0, %eax
	jmp	.L24
.L23:
	movsbq	-17(%rbp), %rax
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L25
.L26:
	shrq	-16(%rbp)
	addq	$1, -8(%rbp)
.L25:
	cmpq	$0, -16(%rbp)
	jne	.L26
	movsbw	-17(%rbp), %ax
	subl	$1, %eax
	sall	$6, %eax
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	addl	%edx, %eax
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	uECC_vli_numBits, .-uECC_vli_numBits
	.type	uECC_vli_set, @function
uECC_vli_set:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movb	%al, -36(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L28
.L29:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L28:
	movzbl	-1(%rbp), %eax
	cmpb	-36(%rbp), %al
	jl	.L29
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	uECC_vli_set, .-uECC_vli_set
	.type	uECC_vli_cmp_unsafe, @function
uECC_vli_cmp_unsafe:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movb	%al, -36(%rbp)
	movzbl	-36(%rbp), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
	jmp	.L31
.L35:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	jbe	.L32
	movl	$1, %eax
	jmp	.L33
.L32:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	jnb	.L34
	movl	$-1, %eax
	jmp	.L33
.L34:
	movzbl	-1(%rbp), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
.L31:
	cmpb	$0, -1(%rbp)
	jns	.L35
	movl	$0, %eax
.L33:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	uECC_vli_cmp_unsafe, .-uECC_vli_cmp_unsafe
	.type	uECC_vli_equal, @function
uECC_vli_equal:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movb	%al, -36(%rbp)
	movq	$0, -8(%rbp)
	movzbl	-36(%rbp), %eax
	subl	$1, %eax
	movb	%al, -9(%rbp)
	jmp	.L37
.L38:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	xorq	%rdx, %rax
	orq	%rax, -8(%rbp)
	movzbl	-9(%rbp), %eax
	subl	$1, %eax
	movb	%al, -9(%rbp)
.L37:
	cmpb	$0, -9(%rbp)
	jns	.L38
	cmpq	$0, -8(%rbp)
	sete	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	uECC_vli_equal, .-uECC_vli_equal
	.type	uECC_vli_cmp, @function
uECC_vli_cmp:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movl	%edx, %eax
	movb	%al, -68(%rbp)
	movsbl	-68(%rbp), %ecx
	movq	-64(%rbp), %rdx
	movq	-56(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	testq	%rax, %rax
	setne	%al
	movzbl	%al, %eax
	movq	%rax, -8(%rbp)
	movsbl	-68(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	sete	%al
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	addl	%eax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	uECC_vli_cmp, .-uECC_vli_cmp
	.type	uECC_vli_rshift1, @function
uECC_vli_rshift1:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movl	%esi, %eax
	movb	%al, -44(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	$0, -8(%rbp)
	movsbq	-44(%rbp), %rax
	salq	$3, %rax
	addq	%rax, -40(%rbp)
	jmp	.L43
.L44:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	shrq	%rax
	orq	-8(%rbp), %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-24(%rbp), %rax
	salq	$63, %rax
	movq	%rax, -8(%rbp)
.L43:
	movq	-40(%rbp), %rax
	leaq	-8(%rax), %rdx
	movq	%rdx, -40(%rbp)
	cmpq	-16(%rbp), %rax
	ja	.L44
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	uECC_vli_rshift1, .-uECC_vli_rshift1
	.type	uECC_vli_add, @function
uECC_vli_add:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, %eax
	movb	%al, -60(%rbp)
	movq	$0, -8(%rbp)
	movb	$0, -9(%rbp)
	jmp	.L46
.L48:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-56(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.L47
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	seta	%al
	movzbl	%al, %eax
	movq	%rax, -8(%rbp)
.L47:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	movzbl	-9(%rbp), %eax
	addl	$1, %eax
	movb	%al, -9(%rbp)
.L46:
	movzbl	-9(%rbp), %eax
	cmpb	-60(%rbp), %al
	jl	.L48
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	uECC_vli_add, .-uECC_vli_add
	.type	uECC_vli_sub, @function
uECC_vli_sub:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, %eax
	movb	%al, -60(%rbp)
	movq	$0, -8(%rbp)
	movb	$0, -9(%rbp)
	jmp	.L51
.L53:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-56(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	subq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.L52
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	setb	%al
	movzbl	%al, %eax
	movq	%rax, -8(%rbp)
.L52:
	movsbq	-9(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	movzbl	-9(%rbp), %eax
	addl	$1, %eax
	movb	%al, -9(%rbp)
.L51:
	movzbl	-9(%rbp), %eax
	cmpb	-60(%rbp), %al
	jl	.L53
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	uECC_vli_sub, .-uECC_vli_sub
	.type	muladd, @function
muladd:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%rcx, -96(%rbp)
	movq	%r8, -104(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %r11
	movl	$0, %r12d
	movq	-80(%rbp), %rax
	movq	%rax, %r9
	movl	$0, %r10d
	movq	%r12, %rdx
	imulq	%r9, %rdx
	movq	%r10, %rax
	imulq	%r11, %rax
	leaq	(%rdx,%rax), %rcx
	movq	%r11, %rax
	mulq	%r9
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	$0, -120(%rbp)
	movq	-128(%rbp), %rax
	movq	-120(%rbp), %rdx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	-88(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, %r13
	movl	$0, %r14d
	movq	%rax, %rcx
	orq	%r13, %rcx
	movq	%rcx, -64(%rbp)
	movq	%rdx, %rax
	orq	%r14, %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	addq	%rax, -64(%rbp)
	adcq	%rdx, -56(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rcx
	movl	$1, %esi
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	cmpq	-40(%rbp), %rdx
	jb	.L56
	cmpq	-40(%rbp), %rdx
	ja	.L57
	cmpq	-48(%rbp), %rax
	jb	.L56
.L57:
	movl	$0, %esi
.L56:
	movzbl	%sil, %eax
	leaq	(%rcx,%rax), %rdx
	movq	-104(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, %rax
	xorl	%edx, %edx
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-64(%rbp), %rdx
	movq	-88(%rbp), %rax
	movq	%rdx, (%rax)
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	muladd, .-muladd
	.type	uECC_vli_mult, @function
uECC_vli_mult:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, %eax
	movb	%al, -60(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movb	$0, -2(%rbp)
	jmp	.L59
.L62:
	movb	$0, -1(%rbp)
	jmp	.L60
.L61:
	movsbl	-2(%rbp), %edx
	movsbl	-1(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rsi
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-32(%rbp), %rdi
	leaq	-24(%rbp), %rcx
	leaq	-16(%rbp), %rdx
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	muladd
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L60:
	movzbl	-1(%rbp), %eax
	cmpb	-2(%rbp), %al
	jle	.L61
	movsbq	-2(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, -32(%rbp)
	movzbl	-2(%rbp), %eax
	addl	$1, %eax
	movb	%al, -2(%rbp)
.L59:
	movzbl	-2(%rbp), %eax
	cmpb	-60(%rbp), %al
	jl	.L62
	movzbl	-60(%rbp), %eax
	movb	%al, -2(%rbp)
	jmp	.L63
.L66:
	movzbl	-2(%rbp), %edx
	movzbl	-60(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
	jmp	.L64
.L65:
	movsbl	-2(%rbp), %edx
	movsbl	-1(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rsi
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-32(%rbp), %rdi
	leaq	-24(%rbp), %rcx
	leaq	-16(%rbp), %rdx
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	muladd
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L64:
	movzbl	-1(%rbp), %eax
	cmpb	-60(%rbp), %al
	jl	.L65
	movsbq	-2(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, -32(%rbp)
	movzbl	-2(%rbp), %eax
	addl	$1, %eax
	movb	%al, -2(%rbp)
.L63:
	movsbl	-2(%rbp), %eax
	movsbl	-60(%rbp), %edx
	addl	%edx, %edx
	subl	$1, %edx
	cmpl	%edx, %eax
	jl	.L66
	movsbq	-60(%rbp), %rax
	salq	$4, %rax
	leaq	-8(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	uECC_vli_mult, .-uECC_vli_mult
	.type	uECC_vli_modAdd, @function
uECC_vli_modAdd:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$56, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movl	%r8d, %eax
	movb	%al, -52(%rbp)
	movsbl	-52(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L68
	movsbl	-52(%rbp), %edx
	movq	-24(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	je	.L67
.L68:
	movsbl	-52(%rbp), %ecx
	movq	-48(%rbp), %rdx
	movq	-24(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
.L67:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	uECC_vli_modAdd, .-uECC_vli_modAdd
	.type	uECC_vli_modSub, @function
uECC_vli_modSub:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$56, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movl	%r8d, %eax
	movb	%al, -52(%rbp)
	movsbl	-52(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L70
	movsbl	-52(%rbp), %ecx
	movq	-48(%rbp), %rdx
	movq	-24(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
.L70:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	uECC_vli_modSub, .-uECC_vli_modSub
	.type	uECC_vli_mmod, @function
uECC_vli_mmod:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$224, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -208(%rbp)
	movq	%rsi, -216(%rbp)
	movq	%rdx, -224(%rbp)
	movl	%ecx, %eax
	movb	%al, -228(%rbp)
	leaq	-184(%rbp), %rax
	movq	%rax, -200(%rbp)
	movq	-216(%rbp), %rax
	movq	%rax, -192(%rbp)
	movsbw	-228(%rbp), %ax
	sall	$7, %eax
	movl	%eax, %ebx
	movsbl	-228(%rbp), %edx
	movq	-224(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	subl	%eax, %ebx
	movl	%ebx, %eax
	movw	%ax, -18(%rbp)
	movzwl	-18(%rbp), %eax
	leal	63(%rax), %edx
	testw	%ax, %ax
	cmovs	%edx, %eax
	sarw	$6, %ax
	movb	%al, -42(%rbp)
	movzwl	-18(%rbp), %eax
	movl	%eax, %edx
	sarw	$15, %dx
	shrw	$10, %dx
	addl	%edx, %eax
	andl	$63, %eax
	subl	%edx, %eax
	movb	%al, -43(%rbp)
	movq	$0, -32(%rbp)
	movsbl	-42(%rbp), %edx
	leaq	-120(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	cmpb	$0, -43(%rbp)
	jle	.L73
	movq	$0, -16(%rbp)
	jmp	.L74
.L75:
	movsbq	-42(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-224(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rsi
	movsbl	-43(%rbp), %eax
	movl	%eax, %ecx
	salq	%cl, %rsi
	movq	%rsi, %rax
	orq	-32(%rbp), %rax
	movq	%rax, -120(%rbp,%rdx,8)
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-224(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbl	-43(%rbp), %eax
	movl	$64, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %ecx
	shrq	%cl, %rdx
	movq	%rdx, %rax
	movq	%rax, -32(%rbp)
	addq	$1, -16(%rbp)
.L74:
	movsbq	-228(%rbp), %rax
	cmpq	-16(%rbp), %rax
	ja	.L75
	jmp	.L76
.L73:
	movsbl	-228(%rbp), %edx
	movsbq	-42(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	leaq	-120(%rbp), %rax
	addq	%rax, %rcx
	movq	-224(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_set
.L76:
	movq	$1, -16(%rbp)
	jmp	.L77
.L81:
	movq	$0, -40(%rbp)
	movb	$0, -41(%rbp)
	jmp	.L78
.L80:
	movq	-16(%rbp), %rax
	movq	-200(%rbp,%rax,8), %rax
	movsbq	-41(%rbp), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movsbl	-41(%rbp), %eax
	cltq
	movq	-120(%rbp,%rax,8), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	subq	-40(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	movq	-200(%rbp,%rax,8), %rax
	movsbq	-41(%rbp), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-56(%rbp), %rax
	je	.L79
	movq	-16(%rbp), %rax
	movq	-200(%rbp,%rax,8), %rax
	movsbq	-41(%rbp), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-56(%rbp), %rax
	setb	%al
	movzbl	%al, %eax
	movq	%rax, -40(%rbp)
.L79:
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	-200(%rbp,%rax,8), %rax
	movsbq	-41(%rbp), %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	%rax, (%rdx)
	movzbl	-41(%rbp), %eax
	addl	$1, %eax
	movb	%al, -41(%rbp)
.L78:
	movsbl	-41(%rbp), %eax
	movsbl	-228(%rbp), %edx
	addl	%edx, %edx
	cmpl	%edx, %eax
	jl	.L80
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	sete	%al
	movzbl	%al, %eax
	movq	%rax, -16(%rbp)
	movsbl	-228(%rbp), %edx
	leaq	-120(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbl	-228(%rbp), %eax
	leal	-1(%rax), %ecx
	movsbl	-228(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	-120(%rbp,%rax,8), %rdx
	movsbl	-228(%rbp), %eax
	cltq
	movq	-120(%rbp,%rax,8), %rax
	salq	$63, %rax
	orq	%rax, %rdx
	movslq	%ecx, %rax
	movq	%rdx, -120(%rbp,%rax,8)
	movsbl	-228(%rbp), %eax
	movsbq	-228(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-120(%rbp), %rdx
	addq	%rcx, %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	uECC_vli_rshift1
	movzwl	-18(%rbp), %eax
	subl	$1, %eax
	movw	%ax, -18(%rbp)
.L77:
	cmpw	$0, -18(%rbp)
	jns	.L81
	movsbl	-228(%rbp), %edx
	movq	-16(%rbp), %rax
	movq	-200(%rbp,%rax,8), %rcx
	movq	-208(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	addq	$224, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	uECC_vli_mmod, .-uECC_vli_mmod
	.type	uECC_vli_modMult, @function
uECC_vli_modMult:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%rcx, -96(%rbp)
	movl	%r8d, %eax
	movb	%al, -100(%rbp)
	movsbl	-100(%rbp), %ecx
	movq	-88(%rbp), %rdx
	movq	-80(%rbp), %rsi
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_mult
	movsbl	-100(%rbp), %ecx
	movq	-96(%rbp), %rdx
	leaq	-64(%rbp), %rsi
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_mmod
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	uECC_vli_modMult, .-uECC_vli_modMult
	.type	uECC_vli_modMult_fast, @function
uECC_vli_modMult_fast:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%rcx, -96(%rbp)
	movq	-96(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %ecx
	movq	-88(%rbp), %rdx
	movq	-80(%rbp), %rsi
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_mult
	movq	-96(%rbp), %rax
	movq	192(%rax), %rax
	leaq	-64(%rbp), %rcx
	movq	-72(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	call	*%rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	uECC_vli_modMult_fast, .-uECC_vli_modMult_fast
	.type	uECC_vli_modSquare_fast, @function
uECC_vli_modSquare_fast:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	uECC_vli_modSquare_fast, .-uECC_vli_modSquare_fast
	.type	vli_modInv_update, @function
vli_modInv_update:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$40, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movb	%al, -36(%rbp)
	movq	$0, -8(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	andl	$1, %eax
	testq	%rax, %rax
	je	.L86
	movsbl	-36(%rbp), %ecx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	%rax, -8(%rbp)
.L86:
	movsbl	-36(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	cmpq	$0, -8(%rbp)
	je	.L85
	movsbq	-36(%rbp), %rax
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsbq	-36(%rbp), %rdx
	salq	$3, %rdx
	leaq	-8(%rdx), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rdx), %rcx
	movabsq	$-9223372036854775808, %rdx
	orq	%rcx, %rdx
	movq	%rdx, (%rax)
.L85:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	vli_modInv_update, .-vli_modInv_update
	.type	uECC_vli_modInv, @function
uECC_vli_modInv:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movq	%rdi, -152(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%rdx, -168(%rbp)
	movl	%ecx, %eax
	movb	%al, -172(%rbp)
	movsbl	-172(%rbp), %edx
	movq	-160(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L89
	movsbl	-172(%rbp), %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	jmp	.L88
.L89:
	movsbl	-172(%rbp), %edx
	movq	-160(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-172(%rbp), %edx
	movq	-168(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-172(%rbp), %edx
	leaq	-112(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	$1, -112(%rbp)
	movsbl	-172(%rbp), %edx
	leaq	-144(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	jmp	.L91
.L97:
	movq	-48(%rbp), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L92
	movsbl	-172(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbl	-172(%rbp), %edx
	movq	-168(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	vli_modInv_update
	jmp	.L91
.L92:
	movq	-80(%rbp), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L93
	movsbl	-172(%rbp), %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbl	-172(%rbp), %edx
	movq	-168(%rbp), %rcx
	leaq	-144(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	vli_modInv_update
	jmp	.L91
.L93:
	cmpb	$0, -1(%rbp)
	jle	.L94
	movsbl	-172(%rbp), %ecx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	movsbl	-172(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbl	-172(%rbp), %edx
	leaq	-144(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	testb	%al, %al
	jns	.L95
	movsbl	-172(%rbp), %ecx
	movq	-168(%rbp), %rdx
	leaq	-112(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
.L95:
	movsbl	-172(%rbp), %ecx
	leaq	-144(%rbp), %rdx
	leaq	-112(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	movsbl	-172(%rbp), %edx
	movq	-168(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	vli_modInv_update
	jmp	.L91
.L94:
	movsbl	-172(%rbp), %ecx
	leaq	-48(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	movsbl	-172(%rbp), %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbl	-172(%rbp), %edx
	leaq	-112(%rbp), %rcx
	leaq	-144(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	testb	%al, %al
	jns	.L96
	movsbl	-172(%rbp), %ecx
	movq	-168(%rbp), %rdx
	leaq	-144(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
.L96:
	movsbl	-172(%rbp), %ecx
	leaq	-112(%rbp), %rdx
	leaq	-144(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
	movsbl	-172(%rbp), %edx
	movq	-168(%rbp), %rcx
	leaq	-144(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	vli_modInv_update
.L91:
	movsbl	-172(%rbp), %edx
	leaq	-80(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	movb	%al, -1(%rbp)
	cmpb	$0, -1(%rbp)
	jne	.L97
	movsbl	-172(%rbp), %edx
	leaq	-112(%rbp), %rcx
	movq	-152(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
.L88:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	uECC_vli_modInv, .-uECC_vli_modInv
	.type	double_jacobian_default, @function
double_jacobian_default:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%rdx, -104(%rbp)
	movq	%rcx, -112(%rbp)
	movq	-112(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	jne	.L98
	movq	-112(%rbp), %rdx
	movq	-96(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-88(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rdx
	movq	-104(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-104(%rbp), %rdx
	movq	-104(%rbp), %rsi
	movq	-104(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-104(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-88(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-104(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-88(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L101
	movsbl	-1(%rbp), %edx
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rdi
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	%rax, -16(%rbp)
	movsbl	-1(%rbp), %edx
	movq	-88(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movsbq	-1(%rbp), %rax
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-88(%rbp), %rax
	addq	%rdx, %rax
	movsbq	-1(%rbp), %rdx
	salq	$3, %rdx
	leaq	-8(%rdx), %rcx
	movq	-88(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rdx), %rdx
	movq	-16(%rbp), %rcx
	salq	$63, %rcx
	orq	%rcx, %rdx
	movq	%rdx, (%rax)
	jmp	.L102
.L101:
	movsbl	-1(%rbp), %edx
	movq	-88(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
.L102:
	movq	-112(%rbp), %rdx
	movq	-88(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	movq	-104(%rbp), %rsi
	movq	-104(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	movq	-104(%rbp), %rsi
	movq	-104(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-104(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-88(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edx
	movq	-104(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-1(%rbp), %edx
	movq	-96(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-1(%rbp), %edx
	leaq	-48(%rbp), %rcx
	movq	-96(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
.L98:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	double_jacobian_default, .-double_jacobian_default
	.type	x_side_default, @function
x_side_default:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	$3, -48(%rbp)
	movq	-72(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-72(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-72(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-72(%rbp), %rax
	leaq	136(%rax), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	x_side_default, .-x_side_default
	.type	mod_sqrt_default, @function
mod_sqrt_default:
.LFB28:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	$1, -48(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$1, -80(%rbp)
	movq	-96(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -3(%rbp)
	movsbl	-3(%rbp), %ecx
	movq	-96(%rbp), %rax
	leaq	8(%rax), %rsi
	leaq	-48(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_add
	movsbl	-3(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	subl	$1, %eax
	movw	%ax, -2(%rbp)
	jmp	.L105
.L107:
	movq	-96(%rbp), %rdx
	leaq	-80(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movswl	-2(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L106
	movq	-96(%rbp), %rcx
	movq	-88(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
.L106:
	movzwl	-2(%rbp), %eax
	subl	$1, %eax
	movw	%ax, -2(%rbp)
.L105:
	cmpw	$1, -2(%rbp)
	jg	.L107
	movsbl	-3(%rbp), %edx
	leaq	-80(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	mod_sqrt_default, .-mod_sqrt_default
	.section	.rodata
	.align 64
	.type	curve_secp160r1, @object
	.size	curve_secp160r1, 200
curve_secp160r1:
	.byte	3
	.byte	20
	.value	161
	.zero	4
	.quad	-2147483649
	.quad	-1
	.quad	4294967295
	.zero	8
	.quad	-493233409515773353
	.quad	128200
	.quad	4294967296
	.zero	8
	.quad	7549031027420429442
	.quad	-8145477734212802167
	.quad	1251390824
	.quad	298171299061431090
	.quad	3560258771535841554
	.quad	598091861
	.zero	16
	.quad	-9091407904947963323
	.quad	6106171408909138079
	.quad	479706876
	.zero	8
	.quad	double_jacobian_default
	.quad	mod_sqrt_default
	.quad	x_side_default
	.quad	vli_mmod_fast_secp160r1
	.text
	.globl	uECC_secp160r1
	.type	uECC_secp160r1, @function
uECC_secp160r1:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$curve_secp160r1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	uECC_secp160r1, .-uECC_secp160r1
	.type	vli_mmod_fast_secp160r1, @function
vli_mmod_fast_secp160r1:
.LFB30:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	leaq	-64(%rbp), %rax
	movl	$3, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	leaq	-64(%rbp), %rax
	addq	$24, %rax
	movl	$3, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	-80(%rbp), %rax
	leaq	16(%rax), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	omega_mult_secp160r1
	movq	-80(%rbp), %rax
	addq	$16, %rax
	movq	-80(%rbp), %rdx
	addq	$16, %rdx
	movq	(%rdx), %rdx
	movl	%edx, %edx
	movq	%rdx, (%rax)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-48(%rbp), %rax
	movl	%eax, %eax
	movq	%rax, -48(%rbp)
	leaq	-64(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-72(%rbp), %rax
	movl	$3, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	-80(%rbp), %rax
	movl	$3, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	-8(%rbp), %rax
	movq	%rax, -48(%rbp)
	leaq	-64(%rbp), %rax
	leaq	16(%rax), %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	omega_mult_secp160r1
	movq	-80(%rbp), %rdx
	movq	-72(%rbp), %rsi
	movq	-72(%rbp), %rax
	movl	$3, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	jmp	.L111
.L112:
	movq	-72(%rbp), %rsi
	movq	-72(%rbp), %rax
	movl	$3, %ecx
	movl	$curve_secp160r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L111:
	movq	-72(%rbp), %rax
	movl	$3, %edx
	movl	$curve_secp160r1+8, %esi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	testb	%al, %al
	jg	.L112
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	vli_mmod_fast_secp160r1, .-vli_mmod_fast_secp160r1
	.type	omega_mult_secp160r1, @function
omega_mult_secp160r1:
.LFB31:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L114
.L118:
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %eax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rcx
	salq	$31, %rcx
	movq	-16(%rbp), %rdx
	addq	%rdx, %rcx
	movl	-4(%rbp), %edx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	movq	-16(%rbp), %rax
	shrq	$33, %rax
	movl	%eax, %ecx
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	jb	.L115
	cmpl	$0, -4(%rbp)
	je	.L116
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	jne	.L116
.L115:
	movl	$1, %eax
	jmp	.L117
.L116:
	movl	$0, %eax
.L117:
	addl	%ecx, %eax
	movl	%eax, -4(%rbp)
	addl	$1, -8(%rbp)
.L114:
	cmpl	$2, -8(%rbp)
	jbe	.L118
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movq	%rax, (%rdx)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	omega_mult_secp160r1, .-omega_mult_secp160r1
	.section	.rodata
	.align 64
	.type	curve_secp192r1, @object
	.size	curve_secp192r1, 200
curve_secp192r1:
	.byte	3
	.byte	24
	.value	192
	.zero	4
	.quad	-1
	.quad	-2
	.quad	-1
	.zero	8
	.quad	1471491468346665009
	.quad	-1713440714
	.quad	-1
	.zero	8
	.quad	-792902925453160430
	.quad	8988939576078862336
	.quad	1769255009665454326
	.quad	8356842117447370769
	.quad	7138225120784731605
	.quad	511487955924736632
	.zero	16
	.quad	-92078683924809295
	.quad	1128127154243252297
	.quad	7215053686808805607
	.zero	8
	.quad	double_jacobian_default
	.quad	mod_sqrt_default
	.quad	x_side_default
	.quad	vli_mmod_fast_secp192r1
	.text
	.globl	uECC_secp192r1
	.type	uECC_secp192r1, @function
uECC_secp192r1:
.LFB32:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$curve_secp192r1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	uECC_secp192r1, .-uECC_secp192r1
	.type	vli_mmod_fast_secp192r1, @function
vli_mmod_fast_secp192r1:
.LFB33:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movl	$3, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-48(%rbp), %rax
	leaq	24(%rax), %rcx
	leaq	-32(%rbp), %rax
	movl	$3, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leaq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$3, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, -4(%rbp)
	movq	$0, -32(%rbp)
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-48(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, -16(%rbp)
	leaq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$3, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-48(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -16(%rbp)
	leaq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$3, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	jmp	.L122
.L123:
	movq	-40(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$3, %ecx
	movl	$curve_secp192r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
.L122:
	cmpl	$0, -4(%rbp)
	jne	.L123
	movq	-40(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rsi
	movl	$curve_secp192r1+8, %edi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	jne	.L123
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	vli_mmod_fast_secp192r1, .-vli_mmod_fast_secp192r1
	.section	.rodata
	.align 64
	.type	curve_secp224r1, @object
	.size	curve_secp224r1, 200
curve_secp224r1:
	.byte	4
	.byte	28
	.value	224
	.zero	4
	.quad	1
	.quad	-4294967296
	.quad	-1
	.quad	4294967295
	.quad	1431345634452711997
	.quad	-256586165981122
	.quad	-1
	.quad	4294967295
	.quad	3761210295710391585
	.quad	5333319497174618402
	.quad	7761038610888102073
	.quad	3071151293
	.quad	4960013060979850804
	.quad	-3655949140929067164
	.quad	-5334755671375945754
	.quad	3174523784
	.quad	2813405352741437364
	.quad	5783942125095737530
	.quad	866014579497448022
	.quad	3020229253
	.quad	double_jacobian_default
	.quad	mod_sqrt_secp224r1
	.quad	x_side_default
	.quad	vli_mmod_fast_secp224r1
	.text
	.globl	uECC_secp224r1
	.type	uECC_secp224r1, @function
uECC_secp224r1:
.LFB34:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$curve_secp224r1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	uECC_secp224r1, .-uECC_secp224r1
	.type	mod_sqrt_secp224r1_rs, @function
mod_sqrt_secp224r1_rs:
.LFB35:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -72(%rbp)
	movq	%r9, -80(%rbp)
	movq	-64(%rbp), %rcx
	leaq	-32(%rbp), %rax
	movl	$curve_secp224r1, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-80(%rbp), %rdx
	leaq	-32(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-48(%rbp), %rdx
	movq	-48(%rbp), %rsi
	movq	-48(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-80(%rbp), %rdx
	leaq	-32(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-56(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-56(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	mod_sqrt_secp224r1_rs, .-mod_sqrt_secp224r1_rs
	.type	mod_sqrt_secp224r1_rss, @function
mod_sqrt_secp224r1_rss:
.LFB36:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movl	16(%rbp), %eax
	movw	%ax, -68(%rbp)
	movq	-48(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-56(%rbp), %rcx
	movq	-32(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-64(%rbp), %rcx
	movq	-40(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movw	$1, -2(%rbp)
	jmp	.L128
.L129:
	movq	-40(%rbp), %r8
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rs
	movzwl	-2(%rbp), %eax
	addl	$1, %eax
	movw	%ax, -2(%rbp)
.L128:
	movzwl	-2(%rbp), %eax
	cmpw	-68(%rbp), %ax
	jle	.L129
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	mod_sqrt_secp224r1_rss, .-mod_sqrt_secp224r1_rss
	.type	mod_sqrt_secp224r1_rm, @function
mod_sqrt_secp224r1_rm:
.LFB37:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%rcx, -96(%rbp)
	movq	%r8, -104(%rbp)
	movq	%r9, -112(%rbp)
	movq	24(%rbp), %rdx
	movq	-112(%rbp), %rsi
	leaq	-32(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-96(%rbp), %rdx
	leaq	-32(%rbp), %rsi
	leaq	-32(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leaq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movl	$curve_secp224r1+8, %esi
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-104(%rbp), %rsi
	leaq	-64(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	16(%rbp), %rdx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rsi
	leaq	-64(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	24(%rbp), %rdx
	movq	-104(%rbp), %rsi
	leaq	-32(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rdx
	movq	-80(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	16(%rbp), %rsi
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leaq	-32(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-80(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-80(%rbp), %rcx
	movq	-88(%rbp), %rax
	movl	$curve_secp224r1, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-96(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-88(%rbp), %rdx
	movq	-88(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movl	$curve_secp224r1+8, %esi
	movq	%rax, %rdi
	call	uECC_vli_modSub
	leaq	-64(%rbp), %rcx
	movq	-72(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	mod_sqrt_secp224r1_rm, .-mod_sqrt_secp224r1_rm
	.type	mod_sqrt_secp224r1_rp, @function
mod_sqrt_secp224r1_rp:
.LFB38:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movq	%rdi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%rdx, -136(%rbp)
	movq	%rcx, -144(%rbp)
	movq	%r8, -152(%rbp)
	movb	$1, -2(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$1, -80(%rbp)
	movq	-152(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-144(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movl	$4, %r8d
	movl	$curve_secp224r1+8, %ecx
	movl	$curve_secp224r1+8, %esi
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movb	$0, -1(%rbp)
	jmp	.L132
.L133:
	movsbl	-2(%rbp), %edi
	subq	$8, %rsp
	leaq	-112(%rbp), %r9
	leaq	-80(%rbp), %r8
	leaq	-48(%rbp), %rcx
	movq	-136(%rbp), %rdx
	movq	-128(%rbp), %rsi
	movq	-120(%rbp), %rax
	pushq	%rdi
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rss
	addq	$16, %rsp
	movq	-128(%rbp), %r9
	movq	-120(%rbp), %r8
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rdx
	movq	-128(%rbp), %rsi
	movq	-120(%rbp), %rax
	leaq	-80(%rbp), %rdi
	pushq	%rdi
	leaq	-48(%rbp), %rdi
	pushq	%rdi
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rm
	addq	$16, %rsp
	movq	-120(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-128(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-136(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movzbl	-2(%rbp), %eax
	addl	%eax, %eax
	movb	%al, -2(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L132:
	cmpb	$6, -1(%rbp)
	jle	.L133
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	mod_sqrt_secp224r1_rp, .-mod_sqrt_secp224r1_rp
	.type	mod_sqrt_secp224r1, @function
mod_sqrt_secp224r1:
.LFB39:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movq	%rsi, -224(%rbp)
	movq	-216(%rbp), %rdi
	movq	-216(%rbp), %rcx
	leaq	-176(%rbp), %rdx
	leaq	-144(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rp
	leaq	-176(%rbp), %r8
	leaq	-144(%rbp), %rdi
	leaq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-208(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rs
	movw	$1, -2(%rbp)
	jmp	.L135
.L138:
	leaq	-208(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leaq	-48(%rbp), %rcx
	leaq	-144(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leaq	-80(%rbp), %rcx
	leaq	-176(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leaq	-176(%rbp), %r8
	leaq	-144(%rbp), %rdi
	leaq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-208(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	mod_sqrt_secp224r1_rs
	leaq	-208(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L136
	jmp	.L137
.L136:
	movzwl	-2(%rbp), %eax
	addl	$1, %eax
	movw	%ax, -2(%rbp)
.L135:
	cmpw	$95, -2(%rbp)
	jle	.L138
.L137:
	leaq	-144(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp224r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	leaq	-80(%rbp), %rdx
	leaq	-112(%rbp), %rsi
	movq	-216(%rbp), %rax
	movl	$curve_secp224r1, %ecx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	mod_sqrt_secp224r1, .-mod_sqrt_secp224r1
	.type	vli_mmod_fast_secp224r1, @function
vli_mmod_fast_secp224r1:
.LFB40:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$0, -4(%rbp)
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-56(%rbp), %rax
	addq	$24, %rax
	movq	-56(%rbp), %rdx
	addq	$24, %rdx
	movq	(%rdx), %rdx
	movl	%edx, %edx
	movq	%rdx, (%rax)
	movq	$0, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	movl	%eax, %eax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	-64(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, -40(%rbp)
	movq	$0, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jns	.L140
.L141:
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp224r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	js	.L141
	jmp	.L139
.L140:
	jmp	.L143
.L144:
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp224r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L143:
	movq	-56(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rsi
	movl	$curve_secp224r1+8, %edi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	jne	.L144
.L139:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	vli_mmod_fast_secp224r1, .-vli_mmod_fast_secp224r1
	.section	.rodata
	.align 64
	.type	curve_secp256r1, @object
	.size	curve_secp256r1, 200
curve_secp256r1:
	.byte	4
	.byte	32
	.value	256
	.zero	4
	.quad	-1
	.quad	4294967295
	.quad	0
	.quad	-4294967295
	.quad	-884452912994769583
	.quad	-4834901526196019580
	.quad	-1
	.quad	-4294967296
	.quad	-819310685055303018
	.quad	8575836109218198432
	.quad	-523289583788211982
	.quad	7716867327612699207
	.quad	-3767753221892779531
	.quad	3156516839386865358
	.quad	-8149286295562117610
	.quad	5756518291402817435
	.quad	4309448131093880907
	.quad	7285987128567378166
	.quad	-5482079946633869636
	.quad	6540974713487397863
	.quad	double_jacobian_default
	.quad	mod_sqrt_default
	.quad	x_side_default
	.quad	vli_mmod_fast_secp256r1
	.text
	.globl	uECC_secp256r1
	.type	uECC_secp256r1, @function
uECC_secp256r1:
.LFB41:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$curve_secp256r1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	uECC_secp256r1, .-uECC_secp256r1
	.type	vli_mmod_fast_secp256r1, @function
vli_mmod_fast_secp256r1:
.LFB42:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	$0, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, -4(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	movl	%eax, %eax
	movq	%rax, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	-64(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rcx
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	orq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rcx
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	orq	%rcx, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	orq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rax
	salq	$32, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movq	-64(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	addq	$48, %rax
	movq	(%rax), %rdx
	movabsq	$-4294967296, %rax
	andq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jns	.L148
.L149:
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp256r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_add
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	js	.L149
	jmp	.L147
.L148:
	jmp	.L151
.L152:
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp256r1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
.L151:
	cmpl	$0, -4(%rbp)
	jne	.L152
	movq	-56(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rsi
	movl	$curve_secp256r1+8, %edi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	jne	.L152
.L147:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE42:
	.size	vli_mmod_fast_secp256r1, .-vli_mmod_fast_secp256r1
	.section	.rodata
	.align 64
	.type	curve_secp256k1, @object
	.size	curve_secp256k1, 200
curve_secp256k1:
	.byte	4
	.byte	32
	.value	256
	.zero	4
	.quad	-4294968273
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-4624529908474429119
	.quad	-4994812053365940165
	.quad	-2
	.quad	-1
	.quad	6481385041966929816
	.quad	188021827762530521
	.quad	6170039885052185351
	.quad	8772561819708210092
	.quad	-7185545363635252040
	.quad	-209500633525038055
	.quad	6747795201694173352
	.quad	5204712524664259685
	.quad	7
	.quad	0
	.quad	0
	.quad	0
	.quad	double_jacobian_secp256k1
	.quad	mod_sqrt_default
	.quad	x_side_secp256k1
	.quad	vli_mmod_fast_secp256k1
	.text
	.globl	uECC_secp256k1
	.type	uECC_secp256k1, @function
uECC_secp256k1:
.LFB43:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$curve_secp256k1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE43:
	.size	uECC_secp256k1, .-uECC_secp256k1
	.type	double_jacobian_secp256k1, @function
double_jacobian_secp256k1:
.LFB44:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%rdx, -104(%rbp)
	movq	%rcx, -112(%rbp)
	movq	-104(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	jne	.L155
	movq	-112(%rbp), %rdx
	movq	-96(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movq	-88(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rdx
	movq	-88(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rdx
	leaq	-80(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-88(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-96(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-88(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-96(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-96(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L158
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rdx
	movq	-96(%rbp), %rsi
	movq	-96(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	%rax, -8(%rbp)
	movq	-96(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
	movq	-96(%rbp), %rax
	addq	$24, %rax
	movq	-96(%rbp), %rdx
	addq	$24, %rdx
	movq	(%rdx), %rdx
	movq	-8(%rbp), %rcx
	salq	$63, %rcx
	orq	%rcx, %rdx
	movq	%rdx, (%rax)
	jmp	.L159
.L158:
	movq	-96(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_rshift1
.L159:
	movq	-112(%rbp), %rdx
	movq	-96(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-88(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-112(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-112(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-96(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
.L155:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE44:
	.size	double_jacobian_secp256k1, .-double_jacobian_secp256k1
	.type	x_side_secp256k1, @function
x_side_secp256k1:
.LFB45:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-24(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-24(%rbp), %rax
	leaq	136(%rax), %rdx
	movq	-8(%rbp), %rsi
	movq	-8(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE45:
	.size	x_side_secp256k1, .-x_side_secp256k1
	.type	vli_mmod_fast_secp256k1, @function
vli_mmod_fast_secp256k1:
.LFB46:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	leaq	-80(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	leaq	-80(%rbp), %rax
	addq	$32, %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	-96(%rbp), %rax
	leaq	32(%rax), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	omega_mult_secp256k1
	leaq	-80(%rbp), %rdx
	movq	-96(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	%rax, -8(%rbp)
	movq	-96(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	leaq	-80(%rbp), %rax
	leaq	32(%rax), %rdx
	movq	-96(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	omega_mult_secp256k1
	movq	-96(%rbp), %rdx
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %ecx
	movq	%rax, %rdi
	call	uECC_vli_add
	addq	%rax, -8(%rbp)
	jmp	.L162
.L163:
	subq	$1, -8(%rbp)
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp256k1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L162:
	cmpq	$0, -8(%rbp)
	jne	.L163
	movq	-88(%rbp), %rax
	movl	$4, %edx
	movl	$curve_secp256k1+8, %esi
	movq	%rax, %rdi
	call	uECC_vli_cmp_unsafe
	testb	%al, %al
	jle	.L161
	movq	-88(%rbp), %rsi
	movq	-88(%rbp), %rax
	movl	$4, %ecx
	movl	$curve_secp256k1+8, %edx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L161:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE46:
	.size	vli_mmod_fast_secp256k1, .-vli_mmod_fast_secp256k1
	.type	omega_mult_secp256k1, @function
omega_mult_secp256k1:
.LFB47:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L166
.L167:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-32(%rbp), %rsi
	leaq	-24(%rbp), %rcx
	leaq	-16(%rbp), %rdx
	movq	%rsi, %r8
	movq	%rax, %rsi
	movabsq	$4294968273, %rdi
	call	muladd
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, -32(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L166:
	cmpb	$3, -1(%rbp)
	jle	.L167
	movq	-40(%rbp), %rax
	leaq	32(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE47:
	.size	omega_mult_secp256k1, .-omega_mult_secp256k1
	.type	apply_z, @function
apply_z:
.LFB48:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	-64(%rbp), %rdx
	movq	-56(%rbp), %rcx
	leaq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-64(%rbp), %rcx
	leaq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	leaq	-32(%rbp), %rsi
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-64(%rbp), %rcx
	leaq	-32(%rbp), %rdx
	movq	-48(%rbp), %rsi
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE48:
	.size	apply_z, .-apply_z
	.type	XYcZ_initial_double, @function
XYcZ_initial_double:
.LFB49:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%rcx, -80(%rbp)
	movq	%r8, -88(%rbp)
	movq	%r9, -96(%rbp)
	movq	-96(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	cmpq	$0, -88(%rbp)
	je	.L170
	movsbl	-1(%rbp), %edx
	movq	-88(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	jmp	.L171
.L170:
	movsbl	-1(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	$1, -48(%rbp)
.L171:
	movsbl	-1(%rbp), %edx
	movq	-56(%rbp), %rcx
	movq	-72(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-1(%rbp), %edx
	movq	-64(%rbp), %rcx
	movq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-96(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	movq	-96(%rbp), %rax
	movq	168(%rax), %rax
	movq	-96(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rdi
	call	*%rax
	movq	-96(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE49:
	.size	XYcZ_initial_double, .-XYcZ_initial_double
	.type	XYcZ_add, @function
XYcZ_add:
.LFB50:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%rcx, -80(%rbp)
	movq	%r8, -88(%rbp)
	movq	-88(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-56(%rbp), %rdx
	movq	-72(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-88(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-88(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-88(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-72(%rbp), %rsi
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-64(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-88(%rbp), %rdx
	movq	-80(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-56(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-72(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-56(%rbp), %rdx
	movq	-72(%rbp), %rsi
	movq	-72(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-88(%rbp), %rcx
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-72(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-88(%rbp), %rcx
	movq	-72(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-88(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-64(%rbp), %rdx
	movq	-80(%rbp), %rsi
	movq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edx
	leaq	-48(%rbp), %rcx
	movq	-72(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE50:
	.size	XYcZ_add, .-XYcZ_add
	.type	XYcZ_addC, @function
XYcZ_addC:
.LFB51:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movq	%rdi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%rdx, -136(%rbp)
	movq	%rcx, -144(%rbp)
	movq	%r8, -152(%rbp)
	movq	-152(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-120(%rbp), %rdx
	movq	-136(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-152(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-152(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-120(%rbp), %rsi
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-152(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	movq	-136(%rbp), %rsi
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-128(%rbp), %rdx
	movq	-144(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-128(%rbp), %rdx
	movq	-144(%rbp), %rsi
	movq	-144(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-120(%rbp), %rdx
	movq	-136(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-152(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movq	-128(%rbp), %rsi
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-136(%rbp), %rdx
	movq	-120(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movq	-152(%rbp), %rdx
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	movq	-136(%rbp), %rsi
	movq	-136(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-136(%rbp), %rdx
	movq	-120(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-152(%rbp), %rcx
	leaq	-112(%rbp), %rdx
	movq	-144(%rbp), %rsi
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-128(%rbp), %rdx
	movq	-144(%rbp), %rsi
	movq	-144(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-152(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-112(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-120(%rbp), %rdx
	leaq	-112(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-152(%rbp), %rcx
	leaq	-48(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-1(%rbp), %edi
	movq	-152(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-128(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	movq	-128(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbl	-1(%rbp), %edx
	leaq	-112(%rbp), %rcx
	movq	-120(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE51:
	.size	XYcZ_addC, .-XYcZ_addC
	.type	EccPoint_mult, @function
EccPoint_mult:
.LFB52:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -184(%rbp)
	movq	%rsi, -192(%rbp)
	movq	%rdx, -200(%rbp)
	movq	%rcx, -208(%rbp)
	movl	%r8d, %eax
	movq	%r9, -224(%rbp)
	movw	%ax, -212(%rbp)
	movq	-224(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -3(%rbp)
	movsbl	-3(%rbp), %edx
	movq	-192(%rbp), %rax
	leaq	-80(%rbp), %rcx
	addq	$32, %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_set
	movsbl	-3(%rbp), %eax
	movsbq	-3(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-192(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	leaq	-144(%rbp), %rdx
	leaq	32(%rdx), %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_set
	movq	-224(%rbp), %r8
	movq	-208(%rbp), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-80(%rbp), %rax
	leaq	-144(%rbp), %rsi
	addq	$32, %rsi
	leaq	-80(%rbp), %rdi
	addq	$32, %rdi
	movq	%r8, %r9
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	XYcZ_initial_double
	movzwl	-212(%rbp), %eax
	subl	$2, %eax
	movw	%ax, -2(%rbp)
	jmp	.L175
.L176:
	movswl	-2(%rbp), %edx
	movq	-200(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	sete	%al
	movzbl	%al, %eax
	movq	%rax, -16(%rbp)
	leaq	-144(%rbp), %rax
	movq	-16(%rbp), %rdx
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	-80(%rbp), %rax
	movq	-16(%rbp), %rdx
	salq	$5, %rdx
	addq	%rax, %rdx
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	-144(%rbp), %rax
	salq	$5, %rsi
	addq	%rax, %rsi
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdi
	leaq	-80(%rbp), %rax
	salq	$5, %rdi
	addq	%rdi, %rax
	movq	-224(%rbp), %rdi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_addC
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-144(%rbp), %rax
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rcx
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-80(%rbp), %rax
	salq	$5, %rdx
	addq	%rax, %rdx
	leaq	-144(%rbp), %rax
	movq	-16(%rbp), %rsi
	salq	$5, %rsi
	addq	%rax, %rsi
	leaq	-80(%rbp), %rax
	movq	-16(%rbp), %rdi
	salq	$5, %rdi
	addq	%rdi, %rax
	movq	-224(%rbp), %rdi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_add
	movzwl	-2(%rbp), %eax
	subl	$1, %eax
	movw	%ax, -2(%rbp)
.L175:
	cmpw	$0, -2(%rbp)
	jg	.L176
	movq	-200(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	sete	%al
	movzbl	%al, %eax
	movq	%rax, -16(%rbp)
	leaq	-144(%rbp), %rax
	movq	-16(%rbp), %rdx
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	-80(%rbp), %rax
	movq	-16(%rbp), %rdx
	salq	$5, %rdx
	addq	%rax, %rdx
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	-144(%rbp), %rax
	salq	$5, %rsi
	addq	%rax, %rsi
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdi
	leaq	-80(%rbp), %rax
	salq	$5, %rdi
	addq	%rdi, %rax
	movq	-224(%rbp), %rdi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_addC
	movsbl	-3(%rbp), %edi
	movq	-224(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-80(%rbp), %rax
	leaq	32(%rax), %rsi
	leaq	-176(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-144(%rbp), %rax
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rdi
	movq	-224(%rbp), %rdx
	leaq	-176(%rbp), %rsi
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movq	-224(%rbp), %rcx
	movq	-192(%rbp), %rdx
	leaq	-176(%rbp), %rsi
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movsbl	-3(%rbp), %edx
	movq	-224(%rbp), %rax
	leaq	8(%rax), %rdi
	leaq	-176(%rbp), %rsi
	leaq	-176(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	movsbq	-3(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-192(%rbp), %rax
	leaq	(%rdx,%rax), %rdi
	movq	-224(%rbp), %rdx
	leaq	-176(%rbp), %rsi
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-80(%rbp), %rax
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rdi
	movq	-224(%rbp), %rdx
	leaq	-176(%rbp), %rsi
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-144(%rbp), %rax
	salq	$5, %rdx
	leaq	(%rax,%rdx), %rcx
	movl	$1, %eax
	subq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	-80(%rbp), %rax
	salq	$5, %rdx
	addq	%rax, %rdx
	leaq	-144(%rbp), %rax
	movq	-16(%rbp), %rsi
	salq	$5, %rsi
	addq	%rax, %rsi
	leaq	-80(%rbp), %rax
	movq	-16(%rbp), %rdi
	salq	$5, %rdi
	addq	%rdi, %rax
	movq	-224(%rbp), %rdi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_add
	movq	-224(%rbp), %rcx
	leaq	-176(%rbp), %rdx
	leaq	-144(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	movsbl	-3(%rbp), %edx
	leaq	-80(%rbp), %rcx
	movq	-184(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-3(%rbp), %edx
	movsbq	-3(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-184(%rbp), %rax
	addq	%rax, %rcx
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_set
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE52:
	.size	EccPoint_mult, .-EccPoint_mult
	.type	regularize_k, @function
regularize_k:
.LFB53:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	-48(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movb	%al, -1(%rbp)
	movq	-48(%rbp), %rax
	movzwl	2(%rax), %eax
	movw	%ax, -4(%rbp)
	movsbl	-1(%rbp), %edx
	movq	-48(%rbp), %rax
	leaq	40(%rax), %rdi
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_add
	testq	%rax, %rax
	jne	.L178
	movswl	-4(%rbp), %eax
	movsbl	-1(%rbp), %edx
	sall	$6, %edx
	cmpl	%edx, %eax
	jge	.L179
	movswl	-4(%rbp), %edx
	movq	-32(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L179
.L178:
	movl	$1, %eax
	jmp	.L180
.L179:
	movl	$0, %eax
.L180:
	cltq
	movq	%rax, -16(%rbp)
	movsbl	-1(%rbp), %edx
	movq	-48(%rbp), %rax
	leaq	40(%rax), %rdi
	movq	-32(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_add
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE53:
	.size	regularize_k, .-regularize_k
	.type	EccPoint_compute_public_key, @function
EccPoint_compute_public_key:
.LFB54:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, -96(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-120(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	regularize_k
	movq	%rax, -8(%rbp)
	movq	-120(%rbp), %rax
	movzwl	2(%rax), %eax
	addl	$1, %eax
	movswl	%ax, %ecx
	cmpq	$0, -8(%rbp)
	sete	%al
	movzbl	%al, %eax
	cltq
	movq	-96(%rbp,%rax,8), %rdx
	movq	-120(%rbp), %rax
	leaq	72(%rax), %rsi
	movq	-120(%rbp), %rdi
	movq	-104(%rbp), %rax
	movq	%rdi, %r9
	movl	%ecx, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	EccPoint_mult
	movq	-120(%rbp), %rax
	movzbl	(%rax), %eax
	addl	%eax, %eax
	movsbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L183
	movl	$0, %eax
	jmp	.L185
.L183:
	movl	$1, %eax
.L185:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE54:
	.size	EccPoint_compute_public_key, .-EccPoint_compute_public_key
	.type	uECC_vli_nativeToBytes, @function
uECC_vli_nativeToBytes:
.LFB55:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	%rdx, -40(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L187
.L188:
	movl	-28(%rbp), %eax
	leal	-1(%rax), %edx
	movsbl	-1(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -8(%rbp)
	movsbq	-1(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	-8(%rbp), %edx
	shrl	$3, %edx
	movl	%edx, %edx
	leaq	0(,%rdx,8), %rcx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rdx), %rdx
	movl	-8(%rbp), %ecx
	andl	$7, %ecx
	sall	$3, %ecx
	shrq	%cl, %rdx
	movb	%dl, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L187:
	movsbl	-1(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L188
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE55:
	.size	uECC_vli_nativeToBytes, .-uECC_vli_nativeToBytes
	.type	uECC_vli_bytesToNative, @function
uECC_vli_bytesToNative:
.LFB56:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$40, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	-36(%rbp), %eax
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movsbl	%al, %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movb	$0, -1(%rbp)
	jmp	.L190
.L191:
	movl	-36(%rbp), %eax
	leal	-1(%rax), %edx
	movsbl	-1(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	shrl	$3, %eax
	movl	%eax, %edx
	leaq	0(,%rdx,8), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movl	%eax, %eax
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movsbq	-1(%rbp), %rsi
	movq	-32(%rbp), %rcx
	addq	%rsi, %rcx
	movzbl	(%rcx), %ecx
	movzbl	%cl, %esi
	movl	-8(%rbp), %ecx
	andl	$7, %ecx
	sall	$3, %ecx
	salq	%cl, %rsi
	movq	%rsi, %rcx
	orq	%rcx, %rax
	movq	%rax, (%rdx)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L190:
	movsbl	-1(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L191
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE56:
	.size	uECC_vli_bytesToNative, .-uECC_vli_bytesToNative
	.type	uECC_generate_random_int, @function
uECC_generate_random_int:
.LFB57:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, %eax
	movb	%al, -52(%rbp)
	movq	$-1, -16(%rbp)
	movsbl	-52(%rbp), %edx
	movq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	movw	%ax, -18(%rbp)
	movq	g_rng_function(%rip), %rax
	testq	%rax, %rax
	jne	.L193
	movl	$0, %eax
	jmp	.L194
.L193:
	movq	$0, -8(%rbp)
	jmp	.L195
.L198:
	movq	g_rng_function(%rip), %rax
	movsbl	-52(%rbp), %edx
	sall	$3, %edx
	movl	%edx, %ecx
	movq	-40(%rbp), %rdx
	movl	%ecx, %esi
	movq	%rdx, %rdi
	call	*%rax
	testl	%eax, %eax
	jne	.L196
	movl	$0, %eax
	jmp	.L194
.L196:
	movsbq	-52(%rbp), %rax
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movsbq	-52(%rbp), %rax
	salq	$3, %rax
	leaq	-8(%rax), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rsi
	movsbw	-52(%rbp), %ax
	sall	$6, %eax
	movl	%eax, %ecx
	movzwl	-18(%rbp), %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	cwtl
	movq	-16(%rbp), %rdi
	movl	%eax, %ecx
	shrq	%cl, %rdi
	movq	%rdi, %rax
	andq	%rsi, %rax
	movq	%rax, (%rdx)
	movsbl	-52(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	jne	.L197
	movsbl	-52(%rbp), %edx
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_cmp
	cmpb	$1, %al
	jne	.L197
	movl	$1, %eax
	jmp	.L194
.L197:
	addq	$1, -8(%rbp)
.L195:
	cmpq	$63, -8(%rbp)
	jbe	.L198
	movl	$0, %eax
.L194:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE57:
	.size	uECC_generate_random_int, .-uECC_generate_random_int
	.globl	uECC_make_key
	.type	uECC_make_key, @function
uECC_make_key:
.LFB58:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%rdi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%rdx, -136(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L200
.L204:
	movq	-136(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movsbl	%al, %edx
	movq	-136(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_generate_random_int
	testl	%eax, %eax
	jne	.L201
	movl	$0, %eax
	jmp	.L205
.L201:
	movq	-136(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	EccPoint_compute_public_key
	testq	%rax, %rax
	je	.L203
	movq	-136(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movl	%eax, %ecx
	leaq	-48(%rbp), %rdx
	movq	-128(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-136(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %ecx
	leaq	-112(%rbp), %rdx
	movq	-120(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-136(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	leaq	0(,%rax,8), %rdx
	leaq	-112(%rbp), %rax
	leaq	(%rax,%rdx), %rsi
	movq	-136(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-136(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-120(%rbp), %rdx
	addq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	uECC_vli_nativeToBytes
	movl	$1, %eax
	jmp	.L205
.L203:
	addq	$1, -8(%rbp)
.L200:
	cmpq	$63, -8(%rbp)
	jbe	.L204
	movl	$0, %eax
.L205:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE58:
	.size	uECC_make_key, .-uECC_make_key
	.globl	uECC_shared_secret
	.type	uECC_shared_secret, @function
uECC_shared_secret:
.LFB59:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -184(%rbp)
	movq	%rsi, -192(%rbp)
	movq	%rdx, -200(%rbp)
	movq	%rcx, -208(%rbp)
	leaq	-128(%rbp), %rax
	movq	%rax, -176(%rbp)
	leaq	-160(%rbp), %rax
	movq	%rax, -168(%rbp)
	movq	$0, -8(%rbp)
	movq	-208(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -9(%rbp)
	movq	-208(%rbp), %rax
	movzbl	1(%rax), %eax
	movb	%al, -10(%rbp)
	movq	-208(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movl	%eax, %edx
	movq	-192(%rbp), %rcx
	leaq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movsbl	-10(%rbp), %edx
	movq	-184(%rbp), %rcx
	leaq	-96(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movsbl	-10(%rbp), %eax
	movsbq	-10(%rbp), %rcx
	movq	-184(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movsbq	-9(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-96(%rbp), %rdx
	addq	%rdx, %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_bytesToNative
	movq	-208(%rbp), %rcx
	leaq	-160(%rbp), %rdx
	leaq	-128(%rbp), %rsi
	leaq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	regularize_k
	movq	%rax, -24(%rbp)
	movq	g_rng_function(%rip), %rax
	testq	%rax, %rax
	je	.L207
	movsbl	-9(%rbp), %edx
	movq	-208(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	-176(%rbp,%rax,8), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_generate_random_int
	testl	%eax, %eax
	jne	.L208
	movl	$0, %eax
	jmp	.L210
.L208:
	movq	-24(%rbp), %rax
	movq	-176(%rbp,%rax,8), %rax
	movq	%rax, -8(%rbp)
.L207:
	movq	-208(%rbp), %rax
	movzwl	2(%rax), %eax
	addl	$1, %eax
	movswl	%ax, %edi
	cmpq	$0, -24(%rbp)
	sete	%al
	movzbl	%al, %eax
	cltq
	movq	-176(%rbp,%rax,8), %rdx
	movq	-208(%rbp), %r8
	movq	-8(%rbp), %rcx
	leaq	-96(%rbp), %rsi
	leaq	-96(%rbp), %rax
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	EccPoint_mult
	movsbl	-10(%rbp), %ecx
	leaq	-96(%rbp), %rdx
	movq	-200(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-208(%rbp), %rax
	movzbl	(%rax), %eax
	addl	%eax, %eax
	movsbl	%al, %edx
	leaq	-96(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	sete	%al
	movzbl	%al, %eax
.L210:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE59:
	.size	uECC_shared_secret, .-uECC_shared_secret
	.globl	uECC_compress
	.type	uECC_compress, @function
uECC_compress:
.LFB60:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L212
.L213:
	movsbq	-1(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	movsbq	-1(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L212:
	movq	-40(%rbp), %rax
	movzbl	1(%rax), %eax
	cmpb	-1(%rbp), %al
	jg	.L213
	movq	-40(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	addl	%eax, %eax
	cltq
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	andl	$1, %eax
	leal	2(%rax), %edx
	movq	-32(%rbp), %rax
	movb	%dl, (%rax)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE60:
	.size	uECC_compress, .-uECC_compress
	.globl	uECC_decompress
	.type	uECC_decompress, @function
uECC_decompress:
.LFB61:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%rdx, -104(%rbp)
	movq	-104(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	leaq	0(,%rax,8), %rdx
	leaq	-80(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-104(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %edx
	movq	-88(%rbp), %rax
	leaq	1(%rax), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movq	-104(%rbp), %rax
	movq	184(%rax), %rax
	movq	-104(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	movq	-8(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	movq	-104(%rbp), %rax
	movq	176(%rax), %rax
	movq	-104(%rbp), %rcx
	movq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	call	*%rax
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-88(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	xorq	%rdx, %rax
	andl	$1, %eax
	testq	%rax, %rax
	je	.L215
	movq	-104(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %ecx
	movq	-104(%rbp), %rax
	leaq	8(%rax), %rsi
	movq	-8(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_sub
.L215:
	movq	-104(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %ecx
	leaq	-80(%rbp), %rdx
	movq	-96(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-104(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-104(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-96(%rbp), %rdx
	addq	%rdx, %rcx
	movq	-8(%rbp), %rdx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	uECC_vli_nativeToBytes
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE61:
	.size	uECC_decompress, .-uECC_decompress
	.globl	uECC_valid_point
	.type	uECC_valid_point, @function
uECC_valid_point:
.LFB62:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	-96(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-96(%rbp), %rax
	movzbl	(%rax), %eax
	addl	%eax, %eax
	movsbl	%al, %edx
	movq	-88(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L217
	movl	$0, %eax
	jmp	.L221
.L217:
	movsbl	-1(%rbp), %edx
	movq	-96(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	jne	.L219
	movsbl	-1(%rbp), %eax
	movsbq	-1(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-88(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movq	-96(%rbp), %rdx
	leaq	8(%rdx), %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	je	.L220
.L219:
	movl	$0, %eax
	jmp	.L221
.L220:
	movsbq	-1(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-88(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-96(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_modSquare_fast
	movq	-96(%rbp), %rax
	movq	184(%rax), %rax
	movq	-96(%rbp), %rdx
	movq	-88(%rbp), %rsi
	leaq	-80(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	movsbl	-1(%rbp), %edx
	leaq	-80(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_equal
.L221:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE62:
	.size	uECC_valid_point, .-uECC_valid_point
	.globl	uECC_valid_public_key
	.type	uECC_valid_public_key, @function
uECC_valid_public_key:
.LFB63:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	-80(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %edx
	movq	-72(%rbp), %rcx
	leaq	-64(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movq	-80(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-80(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-72(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movq	-80(%rbp), %rdx
	movzbl	(%rdx), %edx
	movsbq	%dl, %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-64(%rbp), %rdx
	addq	%rdx, %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_bytesToNative
	movq	-80(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	uECC_valid_point
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE63:
	.size	uECC_valid_public_key, .-uECC_valid_public_key
	.globl	uECC_compute_public_key
	.type	uECC_compute_public_key, @function
uECC_compute_public_key:
.LFB64:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	movq	-120(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movl	%eax, %edx
	movq	-104(%rbp), %rcx
	leaq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movq	-120(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movsbl	%al, %edx
	leaq	-32(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L225
	movl	$0, %eax
	jmp	.L229
.L225:
	movq	-120(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movsbl	%al, %edx
	movq	-120(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp
	cmpb	$1, %al
	je	.L227
	movl	$0, %eax
	jmp	.L229
.L227:
	movq	-120(%rbp), %rdx
	leaq	-32(%rbp), %rcx
	leaq	-96(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	EccPoint_compute_public_key
	testq	%rax, %rax
	jne	.L228
	movl	$0, %eax
	jmp	.L229
.L228:
	movq	-120(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %ecx
	leaq	-96(%rbp), %rdx
	movq	-112(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-120(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	leaq	0(,%rax,8), %rdx
	leaq	-96(%rbp), %rax
	leaq	(%rax,%rdx), %rsi
	movq	-120(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-120(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-112(%rbp), %rdx
	addq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	uECC_vli_nativeToBytes
	movl	$1, %eax
.L229:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE64:
	.size	uECC_compute_public_key, .-uECC_compute_public_key
	.type	bits2int, @function
bits2int:
.LFB65:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movl	%edx, -68(%rbp)
	movq	%rcx, -80(%rbp)
	movq	-80(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movl	%eax, -20(%rbp)
	movq	-80(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movl	%eax, -24(%rbp)
	movl	-68(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jbe	.L231
	movl	-20(%rbp), %eax
	movl	%eax, -68(%rbp)
.L231:
	movl	-24(%rbp), %eax
	movsbl	%al, %edx
	movq	-56(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movl	-68(%rbp), %edx
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movl	-68(%rbp), %eax
	leal	0(,%rax,8), %edx
	movq	-80(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	ja	.L232
	jmp	.L230
.L232:
	movl	-68(%rbp), %eax
	leal	0(,%rax,8), %edx
	movq	-80(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -28(%rbp)
	movq	$0, -8(%rbp)
	movl	-24(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	jmp	.L234
.L235:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movl	-28(%rbp), %eax
	movq	-40(%rbp), %rdx
	movl	%eax, %ecx
	shrq	%cl, %rdx
	movq	%rdx, %rax
	orq	-8(%rbp), %rax
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, (%rax)
	movl	$64, %eax
	subl	-28(%rbp), %eax
	movq	-40(%rbp), %rdx
	movl	%eax, %ecx
	salq	%cl, %rdx
	movq	%rdx, %rax
	movq	%rax, -8(%rbp)
.L234:
	movq	-16(%rbp), %rax
	leaq	-8(%rax), %rdx
	movq	%rdx, -16(%rbp)
	cmpq	-56(%rbp), %rax
	ja	.L235
	movl	-24(%rbp), %eax
	movsbl	%al, %edx
	movq	-80(%rbp), %rax
	leaq	40(%rax), %rcx
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	je	.L230
	movl	-24(%rbp), %eax
	movsbl	%al, %edx
	movq	-80(%rbp), %rax
	leaq	40(%rax), %rdi
	movq	-56(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L230:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE65:
	.size	bits2int, .-bits2int
	.type	uECC_sign_with_k, @function
uECC_sign_with_k:
.LFB66:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -168(%rbp)
	movq	%rsi, -176(%rbp)
	movl	%edx, -180(%rbp)
	movq	%rcx, -192(%rbp)
	movq	%r8, -200(%rbp)
	movq	%r9, -208(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, -96(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-208(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-208(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movb	%al, -2(%rbp)
	movq	-208(%rbp), %rax
	movzwl	2(%rax), %eax
	movw	%ax, -4(%rbp)
	movsbl	-1(%rbp), %edx
	movq	-192(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	jne	.L237
	movsbl	-2(%rbp), %edx
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	movq	-192(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp
	cmpb	$1, %al
	je	.L238
.L237:
	movl	$0, %eax
	jmp	.L244
.L238:
	movq	-208(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	movq	-192(%rbp), %rax
	movq	%rax, %rdi
	call	regularize_k
	movq	%rax, -16(%rbp)
	movzwl	-4(%rbp), %eax
	addl	$1, %eax
	movswl	%ax, %ecx
	cmpq	$0, -16(%rbp)
	sete	%al
	movzbl	%al, %eax
	cltq
	movq	-96(%rbp,%rax,8), %rdx
	movq	-208(%rbp), %rax
	leaq	72(%rax), %rsi
	movq	-208(%rbp), %rdi
	leaq	-160(%rbp), %rax
	movq	%rdi, %r9
	movl	%ecx, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	EccPoint_mult
	movsbl	-1(%rbp), %edx
	leaq	-160(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L240
	movl	$0, %eax
	jmp	.L244
.L240:
	movq	g_rng_function(%rip), %rax
	testq	%rax, %rax
	jne	.L241
	movsbl	-2(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	$1, -48(%rbp)
	jmp	.L242
.L241:
	movsbl	-2(%rbp), %edx
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_generate_random_int
	testl	%eax, %eax
	jne	.L242
	movl	$0, %eax
	jmp	.L244
.L242:
	movsbl	-2(%rbp), %edi
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-192(%rbp), %rsi
	movq	-192(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movsbl	-2(%rbp), %edx
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rdi
	movq	-192(%rbp), %rsi
	movq	-192(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	movsbl	-2(%rbp), %edi
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-48(%rbp), %rdx
	movq	-192(%rbp), %rsi
	movq	-192(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movq	-208(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %ecx
	leaq	-160(%rbp), %rdx
	movq	-200(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	uECC_vli_nativeToBytes
	movq	-208(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$7, %eax
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movl	%eax, %edx
	movq	-168(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movsbl	-2(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	$0, -80(%rbp,%rax,8)
	movsbl	-1(%rbp), %edx
	leaq	-160(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-2(%rbp), %edi
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movq	-208(%rbp), %rcx
	movl	-180(%rbp), %edx
	movq	-176(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	bits2int
	movsbl	-2(%rbp), %edi
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modAdd
	movsbl	-2(%rbp), %edi
	movq	-208(%rbp), %rax
	leaq	40(%rax), %rcx
	movq	-192(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movsbl	-2(%rbp), %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	movswl	%ax, %edx
	movq	-208(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	sall	$3, %eax
	cmpl	%eax, %edx
	jle	.L243
	movl	$0, %eax
	jmp	.L244
.L243:
	movq	-208(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-208(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-200(%rbp), %rdx
	addq	%rdx, %rcx
	leaq	-80(%rbp), %rdx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	uECC_vli_nativeToBytes
	movl	$1, %eax
.L244:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE66:
	.size	uECC_sign_with_k, .-uECC_sign_with_k
	.globl	uECC_sign
	.type	uECC_sign, @function
uECC_sign:
.LFB67:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movl	%edx, -68(%rbp)
	movq	%rcx, -80(%rbp)
	movq	%r8, -88(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L246
.L250:
	movq	-88(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movsbl	%al, %edx
	movq	-88(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_generate_random_int
	testl	%eax, %eax
	jne	.L247
	movl	$0, %eax
	jmp	.L251
.L247:
	movq	-88(%rbp), %r8
	movq	-80(%rbp), %rdi
	leaq	-48(%rbp), %rcx
	movl	-68(%rbp), %edx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	uECC_sign_with_k
	testl	%eax, %eax
	je	.L249
	movl	$1, %eax
	jmp	.L251
.L249:
	addq	$1, -8(%rbp)
.L246:
	cmpq	$63, -8(%rbp)
	jbe	.L250
	movl	$0, %eax
.L251:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE67:
	.size	uECC_sign, .-uECC_sign
	.type	HMAC_init, @function
HMAC_init:
.LFB68:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	32(%rax), %rdx
	movq	-24(%rbp), %rax
	movl	28(%rax), %eax
	addl	%eax, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L253
.L254:
	movl	-4(%rbp), %edx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	xorl	$54, %edx
	movb	%dl, (%rax)
	addl	$1, -4(%rbp)
.L253:
	movq	-24(%rbp), %rax
	movl	28(%rax), %eax
	cmpl	-4(%rbp), %eax
	ja	.L254
	jmp	.L255
.L256:
	movl	-4(%rbp), %edx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$54, (%rax)
	addl	$1, -4(%rbp)
.L255:
	movq	-24(%rbp), %rax
	movl	24(%rax), %eax
	cmpl	-4(%rbp), %eax
	ja	.L256
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rdx
	movl	24(%rdx), %edx
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE68:
	.size	HMAC_init, .-HMAC_init
	.type	HMAC_update, @function
HMAC_update:
.LFB69:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE69:
	.size	HMAC_update, .-HMAC_update
	.type	HMAC_finish, @function
HMAC_finish:
.LFB70:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	32(%rax), %rdx
	movq	-24(%rbp), %rax
	movl	28(%rax), %eax
	addl	%eax, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L259
.L260:
	movl	-4(%rbp), %edx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movl	-4(%rbp), %ecx
	movq	-32(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	xorl	$92, %edx
	movb	%dl, (%rax)
	addl	$1, -4(%rbp)
.L259:
	movq	-24(%rbp), %rax
	movl	28(%rax), %eax
	cmpl	-4(%rbp), %eax
	ja	.L260
	jmp	.L261
.L262:
	movl	-4(%rbp), %edx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$92, (%rax)
	addl	$1, -4(%rbp)
.L261:
	movq	-24(%rbp), %rax
	movl	24(%rax), %eax
	cmpl	-4(%rbp), %eax
	ja	.L262
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	call	*%rax
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rdx
	movl	24(%rdx), %edx
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	-24(%rbp), %rdx
	movl	28(%rdx), %edx
	movq	-40(%rbp), %rsi
	movq	-24(%rbp), %rcx
	movq	%rcx, %rdi
	call	*%rax
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	-40(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	call	*%rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE70:
	.size	HMAC_finish, .-HMAC_finish
	.type	update_V, @function
update_V:
.LFB71:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	HMAC_init
	movq	-8(%rbp), %rax
	movl	28(%rax), %edx
	movq	-24(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_finish
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE71:
	.size	update_V, .-update_V
	.globl	uECC_sign_deterministic
	.type	uECC_sign_deterministic, @function
uECC_sign_deterministic:
.LFB72:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movl	%edx, -116(%rbp)
	movq	%rcx, -128(%rbp)
	movq	%r8, -136(%rbp)
	movq	%r9, -144(%rbp)
	movq	-128(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-144(%rbp), %rax
	movzbl	1(%rax), %eax
	movb	%al, -33(%rbp)
	movq	-144(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movb	%al, -34(%rbp)
	movq	-144(%rbp), %rax
	movzwl	2(%rax), %eax
	movw	%ax, -36(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L265
.L266:
	movl	-12(%rbp), %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$1, (%rax)
	movl	-12(%rbp), %edx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	addl	$1, -12(%rbp)
.L265:
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	cmpl	-12(%rbp), %eax
	ja	.L266
	movq	-24(%rbp), %rdx
	movq	-128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	HMAC_init
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movsbl	-33(%rbp), %edx
	movq	-104(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movl	-116(%rbp), %edx
	movq	-112(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movq	-24(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_finish
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	update_V
	movq	-24(%rbp), %rdx
	movq	-128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	HMAC_init
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$1, (%rax)
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movsbl	-33(%rbp), %edx
	movq	-104(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movl	-116(%rbp), %edx
	movq	-112(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movq	-24(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_finish
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	update_V
	movq	$0, -8(%rbp)
	jmp	.L267
.L276:
	leaq	-96(%rbp), %rax
	movq	%rax, -48(%rbp)
	movb	$0, -13(%rbp)
.L272:
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	update_V
	movl	$0, -12(%rbp)
	jmp	.L268
.L271:
	movzbl	-13(%rbp), %eax
	movl	%eax, %edx
	addl	$1, %edx
	movb	%dl, -13(%rbp)
	movsbq	%al, %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %ecx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movsbl	-13(%rbp), %eax
	movsbl	-34(%rbp), %edx
	sall	$3, %edx
	cmpl	%edx, %eax
	jl	.L269
	nop
.L270:
	movsbl	-34(%rbp), %eax
	sall	$6, %eax
	movl	%eax, %edx
	movswl	-36(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L273
	jmp	.L277
.L269:
	addl	$1, -12(%rbp)
.L268:
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	cmpl	-12(%rbp), %eax
	ja	.L271
	jmp	.L272
.L277:
	movq	$-1, -56(%rbp)
	movsbl	-34(%rbp), %eax
	leal	-1(%rax), %edi
	movsbl	-34(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	-96(%rbp,%rax,8), %rdx
	movsbw	-34(%rbp), %ax
	sall	$6, %eax
	movl	%eax, %ecx
	movzwl	-36(%rbp), %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	cwtl
	movq	-56(%rbp), %rsi
	movl	%eax, %ecx
	shrq	%cl, %rsi
	movq	%rsi, %rax
	andq	%rax, %rdx
	movslq	%edi, %rax
	movq	%rdx, -96(%rbp,%rax,8)
.L273:
	movq	-144(%rbp), %r8
	movq	-136(%rbp), %rdi
	leaq	-96(%rbp), %rcx
	movl	-116(%rbp), %edx
	movq	-112(%rbp), %rsi
	movq	-104(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	uECC_sign_with_k
	testl	%eax, %eax
	je	.L274
	movl	$1, %eax
	jmp	.L275
.L274:
	movq	-24(%rbp), %rdx
	movq	-128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	HMAC_init
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-128(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_update
	movq	-24(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	HMAC_finish
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	update_V
	addq	$1, -8(%rbp)
.L267:
	cmpq	$63, -8(%rbp)
	jbe	.L276
	movl	$0, %eax
.L275:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE72:
	.size	uECC_sign_deterministic, .-uECC_sign_deterministic
	.type	smax, @function
smax:
.LFB73:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %edx
	movl	%esi, %eax
	movw	%dx, -4(%rbp)
	movw	%ax, -8(%rbp)
	movzwl	-4(%rbp), %eax
	cmpw	%ax, -8(%rbp)
	cmovge	-8(%rbp), %ax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE73:
	.size	smax, .-smax
	.globl	uECC_verify
	.type	uECC_verify, @function
uECC_verify:
.LFB74:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$568, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -536(%rbp)
	movq	%rsi, -544(%rbp)
	movl	%edx, -548(%rbp)
	movq	%rcx, -560(%rbp)
	movq	%r8, -568(%rbp)
	movq	-568(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -19(%rbp)
	movq	-568(%rbp), %rax
	movzwl	2(%rax), %eax
	cwtl
	addl	$63, %eax
	leal	63(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$6, %eax
	movb	%al, -20(%rbp)
	movsbl	-20(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	$0, -304(%rbp,%rax,8)
	movsbl	-20(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	$0, -496(%rbp,%rax,8)
	movsbl	-20(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	$0, -528(%rbp,%rax,8)
	movq	-568(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %edx
	movq	-536(%rbp), %rcx
	leaq	-208(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movq	-568(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %eax
	movq	-568(%rbp), %rdx
	movzbl	1(%rdx), %edx
	movsbq	%dl, %rcx
	movq	-536(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movsbq	-19(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-208(%rbp), %rdx
	addq	%rdx, %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_bytesToNative
	movq	-568(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %edx
	movq	-560(%rbp), %rcx
	leaq	-496(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movq	-568(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbl	%al, %edx
	movq	-568(%rbp), %rax
	movzbl	1(%rax), %eax
	movsbq	%al, %rcx
	movq	-560(%rbp), %rax
	addq	%rax, %rcx
	leaq	-528(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_bytesToNative
	movsbl	-19(%rbp), %edx
	leaq	-496(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	jne	.L281
	movsbl	-19(%rbp), %edx
	leaq	-528(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_isZero
	testq	%rax, %rax
	je	.L282
.L281:
	movl	$0, %eax
	jmp	.L294
.L282:
	movsbl	-20(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-496(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	jne	.L284
	movsbl	-20(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-528(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	je	.L285
.L284:
	movl	$0, %eax
	jmp	.L294
.L285:
	movsbl	-20(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rdi
	leaq	-528(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	movsbl	-20(%rbp), %eax
	subl	$1, %eax
	cltq
	movq	$0, -80(%rbp,%rax,8)
	movq	-568(%rbp), %rcx
	movl	-548(%rbp), %edx
	movq	-544(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	bits2int
	movsbl	-20(%rbp), %edi
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-80(%rbp), %rsi
	leaq	-80(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movsbl	-20(%rbp), %edi
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-496(%rbp), %rsi
	leaq	-112(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modMult
	movsbl	-19(%rbp), %edx
	leaq	-208(%rbp), %rcx
	leaq	-272(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %eax
	movsbq	-19(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-208(%rbp), %rdx
	leaq	(%rdx,%rcx), %rsi
	movsbq	-19(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	-272(%rbp), %rdx
	addq	%rdx, %rcx
	movl	%eax, %edx
	movq	%rcx, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	72(%rax), %rcx
	leaq	-368(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edx
	movsbq	-19(%rbp), %rax
	addq	$8, %rax
	leaq	0(,%rax,8), %rcx
	movq	-568(%rbp), %rax
	addq	%rcx, %rax
	leaq	8(%rax), %rcx
	leaq	-400(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edi
	movq	-568(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-368(%rbp), %rdx
	leaq	-272(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movsbq	-19(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	leaq	-272(%rbp), %rax
	leaq	(%rax,%rdx), %rcx
	movq	-568(%rbp), %rdi
	leaq	-272(%rbp), %rdx
	leaq	-400(%rbp), %rsi
	leaq	-368(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_add
	movsbl	-19(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	8(%rax), %rdi
	leaq	-144(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	movsbq	-19(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	leaq	-272(%rbp), %rax
	leaq	(%rax,%rdx), %rsi
	movq	-568(%rbp), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	movq	$0, -464(%rbp)
	movq	-568(%rbp), %rax
	addq	$72, %rax
	movq	%rax, -456(%rbp)
	leaq	-208(%rbp), %rax
	movq	%rax, -448(%rbp)
	leaq	-272(%rbp), %rax
	movq	%rax, -440(%rbp)
	movsbl	-20(%rbp), %edx
	leaq	-112(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	movswl	%ax, %ebx
	movsbl	-20(%rbp), %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_numBits
	cwtl
	movl	%ebx, %esi
	movl	%eax, %edi
	call	smax
	movw	%ax, -22(%rbp)
	movzwl	-22(%rbp), %eax
	subl	$1, %eax
	movswl	%ax, %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	setne	%al
	movzbl	%al, %ebx
	movzwl	-22(%rbp), %eax
	subl	$1, %eax
	movswl	%ax, %edx
	leaq	-112(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L286
	movl	$2, %eax
	jmp	.L287
.L286:
	movl	$0, %eax
.L287:
	orl	%ebx, %eax
	cltq
	movq	-464(%rbp,%rax,8), %rax
	movq	%rax, -32(%rbp)
	movsbl	-19(%rbp), %edx
	movq	-32(%rbp), %rcx
	leaq	-304(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edx
	movsbq	-19(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rax, %rcx
	leaq	-336(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edx
	leaq	-144(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_clear
	movq	$1, -144(%rbp)
	movzwl	-22(%rbp), %eax
	subl	$2, %eax
	movw	%ax, -18(%rbp)
	jmp	.L288
.L292:
	movq	-568(%rbp), %rax
	movq	168(%rax), %rax
	movq	-568(%rbp), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-336(%rbp), %rsi
	leaq	-304(%rbp), %rdi
	call	*%rax
	movswl	-18(%rbp), %edx
	leaq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	setne	%al
	movzbl	%al, %ebx
	movswl	-18(%rbp), %edx
	leaq	-112(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	uECC_vli_testBit
	testq	%rax, %rax
	je	.L289
	movl	$2, %eax
	jmp	.L290
.L289:
	movl	$0, %eax
.L290:
	orl	%ebx, %eax
	cltq
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-464(%rbp,%rax,8), %rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L291
	movsbl	-19(%rbp), %edx
	movq	-32(%rbp), %rcx
	leaq	-368(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movsbl	-19(%rbp), %edx
	movsbq	-19(%rbp), %rax
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rax, %rcx
	leaq	-400(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_set
	movq	-568(%rbp), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-400(%rbp), %rsi
	leaq	-368(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	movsbl	-19(%rbp), %edi
	movq	-568(%rbp), %rax
	leaq	8(%rax), %rcx
	leaq	-368(%rbp), %rdx
	leaq	-304(%rbp), %rsi
	leaq	-432(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	uECC_vli_modSub
	movq	-568(%rbp), %rdi
	leaq	-336(%rbp), %rcx
	leaq	-304(%rbp), %rdx
	leaq	-400(%rbp), %rsi
	leaq	-368(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	XYcZ_add
	movq	-568(%rbp), %rcx
	leaq	-432(%rbp), %rdx
	leaq	-144(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	uECC_vli_modMult_fast
.L291:
	movzwl	-18(%rbp), %eax
	subl	$1, %eax
	movw	%ax, -18(%rbp)
.L288:
	cmpw	$0, -18(%rbp)
	jns	.L292
	movsbl	-19(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	8(%rax), %rdi
	leaq	-144(%rbp), %rsi
	leaq	-144(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_modInv
	movq	-568(%rbp), %rcx
	leaq	-144(%rbp), %rdx
	leaq	-336(%rbp), %rsi
	leaq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	apply_z
	movsbl	-20(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rcx
	leaq	-304(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	uECC_vli_cmp_unsafe
	cmpb	$1, %al
	je	.L293
	movsbl	-20(%rbp), %edx
	movq	-568(%rbp), %rax
	leaq	40(%rax), %rdi
	leaq	-304(%rbp), %rsi
	leaq	-304(%rbp), %rax
	movl	%edx, %ecx
	movq	%rdi, %rdx
	movq	%rax, %rdi
	call	uECC_vli_sub
.L293:
	movsbl	-19(%rbp), %edx
	leaq	-496(%rbp), %rcx
	leaq	-304(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	uECC_vli_equal
.L294:
	addq	$568, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE74:
	.size	uECC_verify, .-uECC_verify
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
