.global _start
.text
_start:
	jmp main
_strlen:
	xor %rbx, %rbx
_strlen_loop:
	cmpb $0, 0(%rax)
	jz _strlen_exit
	inc %rax
	inc %rbx
	jmp _strlen_loop
_strlen_exit:
	ret
digit:
	mov %r12, %rax
	add $48, %rax
	mov $__digit, %r12
	mov %al, 0(%r12)
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
print_s:
__print_this_atom:
	cmp $0, %r12
	je __print_this_cons
	mov %r12, %rax
	call _strlen
	mov %r12, %rsi
	mov %rbx, %rdx
	mov $1, %rax
	mov $1, %rdi
	syscall
	ret
__print_this_cons:
	cmp $0, %r13
	je __print_this_nil
	cmp $0, %r14
	je __print_this_nil
	push %r14
	push %r13
	mov $1, %rax
	mov $1, %rdi
	mov $__lparen, %rsi
	mov $1, %rdx
	syscall
	pop %r8
	mov 0(%r8),%r12
	mov 8(%r8),%r13
	mov 16(%r8),%r14
	mov 24(%r8),%r15
	call print_s
	mov $1, %rax
	mov $1, %rdi
	mov $__space, %rsi
	mov $1, %rdx
	syscall
	pop %r8
	mov 0(%r8),%r12
	mov 8(%r8),%r13
	mov 16(%r8),%r14
	mov 24(%r8),%r15
	call print_s
	mov $1, %rax
	mov $1, %rdi
	mov $__rparen, %rsi
	mov $1, %rdx
	syscall
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
__print_this_nil:
	mov $1, %rax
	mov $1, %rdi
	mov $__nil_literal, %rsi
	mov $2, %rdx
	syscall
	ret
head:
	cmp $0, %r13
	je __head_is_nil
	mov 0(%r13),%r12
	mov 16(%r13),%r14
	mov 24(%r13),%r15
	mov 8(%r13),%r13
	ret
__head_is_nil:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
tail:
	cmp $0, %r13
	je __tail_is_nil
	mov 0(%r14),%r12
	mov 8(%r14),%r13
	mov 24(%r14),%r15
	mov 16(%r14),%r14
	ret
__tail_is_nil:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
not:
	cmp $0, %r12
	jne __not_is_some
	cmp $0, %r13
	jne __not_is_some
	cmp $0, %r14
	jne __not_is_some
	mov $__true, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
__not_is_some:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
_streq:
__streq_loop:
	cmp $0, %rax
	je __streq_false
	cmp $0, %rbx
	je __streq_false
	mov 0(%rax), %cl
	mov 0(%rbx), %dl
	cmp %cl, %dl
	jne __streq_false
	cmp $0, %cl
	je __streq_true
	inc %rax
	inc %rbx
	jmp __streq_loop
__streq_true:
	mov $__true, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
__streq_false:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
dump_i:
	mov %r12, %r8
	mov $__dump_i, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__dump_i, %r11
	cmp $0, %r8
	jge dump_i_positive
	jmp dump_i_negative
dump_i_positive:
	call dump_i_digits
	ret
dump_i_negative:
	neg %r8
	call dump_i_digits
	movb $45, 0(%r11)
	ret
dump_i_digits:
	rol $4, %r8
	call put8
	mov %cl, 0(%r11)
	rol $4, %r8
	call put8
	mov %cl, 1(%r11)
	rol $4, %r8
	call put8
	mov %cl, 2(%r11)
	rol $4, %r8
	call put8
	mov %cl, 3(%r11)
	rol $4, %r8
	call put8
	mov %cl, 4(%r11)
	rol $4, %r8
	call put8
	mov %cl, 5(%r11)
	rol $4, %r8
	call put8
	mov %cl, 6(%r11)
	rol $4, %r8
	call put8
	mov %cl, 7(%r11)
	rol $4, %r8
	call put8
	mov %cl, 8(%r11)
	rol $4, %r8
	call put8
	mov %cl, 9(%r11)
	rol $4, %r8
	call put8
	mov %cl, 10(%r11)
	rol $4, %r8
	call put8
	mov %cl, 11(%r11)
	rol $4, %r8
	call put8
	mov %cl, 12(%r11)
	rol $4, %r8
	call put8
	mov %cl, 13(%r11)
	rol $4, %r8
	call put8
	mov %cl, 14(%r11)
	rol $4, %r8
	call put8
	mov %cl, 15(%r11)
	ret
put8:
	mov %r8b, %al
	and $0xf, %al
	mov $__hex_buffer,%r10
	add %al, %r10b
	mov 0(%r10), %cl
	ret
inc:
	inc %r12
	ret
dec:
	dec %r12
	ret
inv:
	neg %r12
	ret
is:
	cmp %r8, %r12
	jne is_false
	cmp %r9, %r13
	jne is_false
	cmp %r10, %r14
	jne is_false
	cmp %r11, %r15
	jne is_false
	mov $__true, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
is_false:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
is_neg:
	cmp $0, %r12
	jge is_neg_ispos
	mov $1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
is_neg_ispos:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
mul:
	cmp $0, %r13
	je mul_err
	cmp $0, %r14
	je mul_err
	mov 0(%r13),%rax
	mov 0(%r14),%rbx
	imul %rax, %rbx
	mov %rbx, %r12
	ret
mul_err:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
add:
	cmp $0, %r13
	je add_err
	cmp $0, %r14
	je add_err
	mov 0(%r13),%rax
	mov 0(%r14),%rbx
	add %rax, %rbx
	mov %rbx, %r12
	ret
add_err:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
div:
	cmp $0, %r13
	je div_err
	cmp $0, %r14
	je div_err
	mov 0(%r13),%rax
	mov $0, %rdx
	mov 0(%r14),%rcx
	idiv %rcx
	mov %rax, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
div_err:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
mod:
	cmp $0, %r13
	je mod_err
	cmp $0, %r14
	je mod_err
	mov 0(%r13),%rax
	mov $0, %rdx
	mov 0(%r14),%rcx
	idiv %rcx
	mov %rdx, %r12
	ret
mod_err:
	mov $0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
clone_rope:
	mov $__a_section, %r8
	mov $__a_counter, %r10
	mov 0(%r10), %r11
	add %r11, %r8
	mov %r8, %r9
	call __clone_rope
	movb $0, 0(%r9)
	inc %r9
	mov $__a_section, %r10
	sub %r10, %r9
	mov $__a_counter, %r10
	mov %r9, 0(%r10)
	mov %r8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
__clone_rope:
	cmp $0, %r13
	je clone_rope_notcons
	cmp $0, %r14
	je clone_rope_notcons
	push %r12
	push %r13
	push %r14
	push %r15
	mov 0(%r13),%r12
	mov 16(%r13),%r14
	mov 24(%r13),%r15
	mov 8(%r13),%r13
	call __clone_rope
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov 0(%r14),%r12
	mov 24(%r14),%r15
	mov 8(%r14),%r13
	mov 16(%r14),%r14
	push %r12
	push %r13
	push %r14
	push %r15
	call __clone_rope
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	jmp clone_rope_end
clone_rope_notcons:
	cmp $0, %r12
	je clone_rope_end
clone_rope_small:
	cmpb $0, 0(%r12)
	je clone_rope_end
	movb 0(%r12), %bl
	movb %bl, 0(%r9)
	inc %r12
	inc %r9
	jmp clone_rope_small
clone_rope_end:
	ret
write_file:
	mov 0(%r13), %rdi
	pushq 0(%r14)
	mov $2, %rax
	mov $577, %rsi
	mov $420, %rdx
	syscall
	mov %rax, %r8
	pop %rax
	mov %rax, %r9
	call _strlen
	mov %rbx, %rdx
	mov %r9, %rsi
	mov %r8, %rdi
	mov $1, %rax
	syscall
	mov %r8, %rdi
	mov $3, %rax
	syscall
	ret
load_file:
	mov $2, %rax
	mov %r12, %rdi
	mov $0, %rsi
	syscall
	cmp $0, %rax
	jge load_file_contents
	mov $__err_fopen, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
load_file_contents:
	mov $__a_section, %r8
	mov $__a_counter, %r10
	mov 0(%r10), %r11
	add %r11, %r8
	mov %r8, %r9
	mov $0, %r10
	mov $load_file_buf, %r11
load_file_loop:
	cmp $0, %r10
	je load_file_bufempty
	movb 0(%r11), %bl
	mov %bl, 0(%r9)
	inc %r9
	inc %r11
	dec %r10
	jmp load_file_loop
load_file_bufempty:
	push %rax
	mov %rax, %rdi
	mov $0, %rax
	mov $load_file_buf, %rsi
	mov $load_file_bsz, %rdx
	mov 0(%rdx), %rdx
	syscall
	mov %rax, %r10
	pop %rax
	mov $load_file_buf, %r11
	cmp $0, %r10
	jne load_file_loop
	mov %rax, %rdi
	mov $3, %rax
	syscall
	movb $0, 0(%r9)
	inc %r9
	sub %r8, %r9
	mov $__a_counter, %r10
	mov %r9, 0(%r10)
	mov %r8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	ret
yield_foreach_char:
	push %rbp
	mov %rsp, %rbp
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -8(%rbp)
	mov %r13, -16(%rbp)
	mov %r14, -24(%rbp)
	mov %r15, -32(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -40(%rbp)
	mov %r13, -48(%rbp)
	mov %r14, -56(%rbp)
	mov %r15, -64(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -72(%rbp)
	mov %r13, -80(%rbp)
	mov %r14, -88(%rbp)
	mov %r15, -96(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -104(%rbp)
	mov %r13, -112(%rbp)
	mov %r14, -120(%rbp)
	mov %r15, -128(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -136(%rbp)
	mov %r13, -144(%rbp)
	mov %r14, -152(%rbp)
	mov %r15, -160(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -168(%rbp)
	mov %r13, -176(%rbp)
	mov %r14, -184(%rbp)
	mov %r15, -192(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, -200(%rbp)
	mov %r13, -208(%rbp)
	mov %r14, -216(%rbp)
	mov %r15, -224(%rbp)
	mov -168(%rbp),%r12
	mov -176(%rbp),%r13
	mov -184(%rbp),%r14
	mov -192(%rbp),%r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000001, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000002, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000003, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000004, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000005, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000006, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000007, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000008, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000009, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000000f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000010, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000011, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000012, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000013, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000014, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000015, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000016, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000017, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000018, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _head
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000019, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -168(%rbp),%r12
	mov -176(%rbp),%r13
	mov -184(%rbp),%r14
	mov -192(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _tail
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000001f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -168(%rbp),%r12
	mov -176(%rbp),%r13
	mov -184(%rbp),%r14
	mov -192(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000020, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000021, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000022, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000023, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000024, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000025, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000026, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000027, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000028, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000029, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000002f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000030, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000031, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000032, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000033, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000034, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000035, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000036, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -136(%rbp),%r12
	mov -144(%rbp),%r13
	mov -152(%rbp),%r14
	mov -160(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000037, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000038, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000039, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -40(%rbp),%r12
	mov -48(%rbp),%r13
	mov -56(%rbp),%r14
	mov -64(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -136(%rbp),%r12
	mov -144(%rbp),%r13
	mov -152(%rbp),%r14
	mov -160(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000003f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000040, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000041, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000042, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000043, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000044, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000045, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000046, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000047, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000048, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000049, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -104(%rbp),%r12
	mov -112(%rbp),%r13
	mov -120(%rbp),%r14
	mov -128(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000004f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000050, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000051, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000052, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000053, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000054, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000055, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000056, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000057, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -200(%rbp),%r12
	mov -208(%rbp),%r13
	mov -216(%rbp),%r14
	mov -224(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000058, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000059, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000005f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000060, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000061, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000062, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000063, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000064, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000065, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000066, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000067, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000068, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000069, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000006f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000070, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000071, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000072, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000073, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000074, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000075, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000076, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000077, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000078, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000079, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000007f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000080, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000081, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000082, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000083, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000084, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000085, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000086, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000087, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000088, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000089, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000008f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000090, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000091, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000092, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -40(%rbp),%r12
	mov -48(%rbp),%r13
	mov -56(%rbp),%r14
	mov -64(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000093, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000094, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000095, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000096, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000097, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000098, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000099, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000009f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -136(%rbp),%r12
	mov -144(%rbp),%r13
	mov -152(%rbp),%r14
	mov -160(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -104(%rbp),%r12
	mov -112(%rbp),%r13
	mov -120(%rbp),%r14
	mov -128(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -40(%rbp),%r12
	mov -48(%rbp),%r13
	mov -56(%rbp),%r14
	mov -64(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -8(%rbp),%r12
	mov -16(%rbp),%r13
	mov -24(%rbp),%r14
	mov -32(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	mov %rbp, %rsp
	pop %rbp
	ret
yield_foreach_atom:
	push %rbp
	mov %rsp, %rbp
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	pushq $0
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -8(%rbp)
	mov %r13, -16(%rbp)
	mov %r14, -24(%rbp)
	mov %r15, -32(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -40(%rbp)
	mov %r13, -48(%rbp)
	mov %r14, -56(%rbp)
	mov %r15, -64(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, %r8
	mov %r13, %r9
	mov %r14, %r10
	mov %r15, %r11
	call tail
	mov %r12, -72(%rbp)
	mov %r13, -80(%rbp)
	mov %r14, -88(%rbp)
	mov %r15, -96(%rbp)
	mov %r8, %r12
	mov %r9, %r13
	mov %r10, %r14
	mov %r11, %r15
	call head
	mov %r12, -104(%rbp)
	mov %r13, -112(%rbp)
	mov %r14, -120(%rbp)
	mov %r15, -128(%rbp)
	mov -104(%rbp),%r12
	mov -112(%rbp),%r13
	mov -120(%rbp),%r14
	mov -128(%rbp),%r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _head
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -104(%rbp),%r12
	mov -112(%rbp),%r13
	mov -120(%rbp),%r14
	mov -128(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _tail
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -104(%rbp),%r12
	mov -112(%rbp),%r13
	mov -120(%rbp),%r14
	mov -128(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -72(%rbp),%r12
	mov -80(%rbp),%r13
	mov -88(%rbp),%r14
	mov -96(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -40(%rbp),%r12
	mov -48(%rbp),%r13
	mov -56(%rbp),%r14
	mov -64(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _push_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -8(%rbp),%r12
	mov -16(%rbp),%r13
	mov -24(%rbp),%r14
	mov -32(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $0,%r12
	mov $0,%r13
	mov $0,%r14
	mov $0,%r15
	call _pop_this
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov -40(%rbp),%r12
	mov -48(%rbp),%r13
	mov -56(%rbp),%r14
	mov -64(%rbp),%r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	pop %r8
	mov %rbp, %rsp
	pop %rbp
	ret
_unshadow_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_00000000000000e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000000ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_shadow_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000100, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000101, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000102, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000103, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000104, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000105, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000106, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000107, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000108, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000109, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000010f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000110, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000111, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000112, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000113, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000114, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000115, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000116, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000117, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000118, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000119, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000011a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000011b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_exit_function:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_000000000000011c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000011d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000011e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000011f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000120, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000121, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000122, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000123, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000124, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000125, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000126, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000127, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000128, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000129, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000012a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_enter_function:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_000000000000012b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000012c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000012d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000012e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000012f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000130, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000131, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000132, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000133, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000134, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000135, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000136, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_tail:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000137, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000138, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000139, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000013f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000140, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000141, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000142, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000143, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000144, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000145, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000146, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000147, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000148, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000149, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000014f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000150, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000151, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000152, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000153, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000154, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000155, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000156, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000157, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000158, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000159, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000015f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000160, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000161, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000162, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_head:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000163, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000164, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000165, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000166, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000167, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000168, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000169, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000016f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000170, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000171, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000172, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000173, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000174, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000175, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000176, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000177, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000178, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000179, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000017f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000180, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000181, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000182, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000183, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000184, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000185, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000186, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000187, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000188, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000189, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000018a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000018b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000018c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000018d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000018e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_close_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_000000000000018f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000190, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000191, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000192, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000193, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000194, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000195, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000196, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000197, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000198, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000199, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000019f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_yield_nil:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_00000000000001e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000001ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000200, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000201, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000202, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000203, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_pop_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000204, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000205, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000206, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000207, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000208, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000209, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000020f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000210, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000211, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000212, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000213, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000214, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000215, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000216, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000217, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_unpush_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000218, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000219, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000021f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000220, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000221, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000222, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000223, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000224, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000225, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000226, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000227, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000228, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000229, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000022a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000022b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_push_zero:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_000000000000022c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000022d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000022e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000022f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000230, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000231, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000232, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000233, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000234, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000235, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000236, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000237, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000238, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000239, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000023f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_push_this:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000240, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000241, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000242, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000243, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000244, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000245, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000246, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000247, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000248, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000249, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000024f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000250, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000251, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000252, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000253, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	mov %rbp, %rsp
	pop %rbp
	ret
_program_header:
	push %rbp
	mov %rsp, %rbp
	mov $uuid_0000000000000254, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000255, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000256, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000257, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000258, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000259, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000025f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000260, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000261, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000262, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000263, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000264, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000265, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000266, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000267, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000268, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000269, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000026f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000270, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000271, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000272, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000273, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000274, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000275, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000276, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000277, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000278, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000279, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000027f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000280, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000281, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000282, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000283, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000284, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000285, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000286, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000287, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000288, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000289, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000028f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000290, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000291, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000292, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000293, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000294, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000295, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000296, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000297, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000298, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000299, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000029f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000002ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000300, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000301, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000302, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000303, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000304, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000305, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000306, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000307, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000308, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000309, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000030f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000310, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000311, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000312, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000313, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000314, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000315, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000316, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000317, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000318, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000319, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000031f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000320, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000321, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000322, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000323, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000324, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000325, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000326, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000327, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000328, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000329, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000032f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000330, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000331, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000332, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000333, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000334, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000335, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000336, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000337, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000338, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000339, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000033f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000340, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000341, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000342, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000343, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000344, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000345, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000346, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000347, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000348, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000349, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000034f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000350, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000351, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000352, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000353, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000354, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000355, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000356, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000357, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000358, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000359, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000035f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000360, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000361, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000362, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000363, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000364, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000365, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000366, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000367, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000368, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000369, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000036f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000370, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000371, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000372, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000373, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000374, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000375, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000376, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000377, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000378, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000379, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000037f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000380, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000381, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000382, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000383, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000384, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000385, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000386, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000387, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000388, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000389, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000038f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000390, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000391, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000392, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000393, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000394, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000395, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000396, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000397, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000398, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000399, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000039f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000003ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000400, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000401, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000402, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000403, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000404, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000405, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000406, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000407, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000408, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000409, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000040f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000410, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000411, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000412, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000413, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000414, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000415, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000416, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000417, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000418, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000419, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000041f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000420, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000421, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000422, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000423, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000424, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000425, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000426, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000427, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000428, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000429, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000042f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000430, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000431, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000432, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000433, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000434, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000435, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000436, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000437, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000438, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000439, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000043f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000440, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000441, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000442, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000443, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000444, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000445, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000446, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000447, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000448, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000449, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000044f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000450, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000451, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000452, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000453, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000454, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000455, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000456, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000457, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000458, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000459, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000045f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000460, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000461, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000462, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000463, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000464, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000465, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000466, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000467, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000468, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000469, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000046f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000470, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000471, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000472, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000473, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000474, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000475, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000476, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000477, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000478, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000479, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000047f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000480, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000481, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000482, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000483, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000484, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000485, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000486, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000487, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000488, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000489, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000048f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000490, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000491, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000492, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000493, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000494, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000495, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000496, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000497, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000498, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000499, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000049f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000004ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000500, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000501, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000502, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000503, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000504, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000505, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000506, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000507, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000508, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000509, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000050f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000510, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000511, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000512, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000513, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000514, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000515, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000516, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000517, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000518, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000519, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000051f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000520, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000521, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000522, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000523, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000524, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000525, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000526, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000527, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000528, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000529, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000052f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000530, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000531, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000532, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000533, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000534, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000535, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000536, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000537, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000538, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000539, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000053f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000540, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000541, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000542, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000543, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000544, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000545, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000546, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000547, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000548, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000549, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000054f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000550, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000551, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000552, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000553, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000554, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000555, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000556, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000557, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000558, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000559, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000055f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000560, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000561, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000562, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000563, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000564, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000565, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000566, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000567, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000568, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000569, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000056f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000570, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000571, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000572, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000573, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000574, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000575, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000576, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000577, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000578, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000579, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000057f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000580, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000581, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000582, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000583, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000584, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000585, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000586, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000587, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000588, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000589, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000058f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000590, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000591, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000592, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000593, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000594, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000595, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000596, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000597, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000598, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000599, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000059f, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005a9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005aa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ab, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ac, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ad, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ae, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005af, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005b9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ba, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005bb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005bc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005bd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005be, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005bf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005c9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ca, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005cb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005cc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005cd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ce, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005cf, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005d9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005da, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005db, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005dc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005dd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005de, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005df, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005e9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ea, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005eb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ec, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ed, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ee, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ef, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f0, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f1, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f2, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f3, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f4, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f5, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f6, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f7, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f8, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005f9, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005fa, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005fb, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005fc, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005fd, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005fe, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_00000000000005ff, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000600, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000601, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000602, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000603, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000604, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000605, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000606, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000607, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000608, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_0000000000000609, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000060a, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000060b, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000060c, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000060d, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov %rsi, %rdi
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	mov $__s_section, %rsi
	mov $__s_counter, %r8
	mov 0(%r8), %r10
	add %r10, %rsi
	add $32, %r10
	mov %r10, 0(%r8)
	mov %r12, 0(%rsi)
	mov %r13, 8(%rsi)
	mov %r14, 16(%rsi)
	mov %r15, 24(%rsi)
	mov $0, %r12
	mov %rsi, %r13
	mov %rdi, %r14
	mov $0, %r15
	push %r12
	push %r13
	push %r14
	push %r15
	mov $uuid_000000000000060e, %r12
	mov $0, %r13
	mov $0, %r14
	mov $0, %r15
	mov $__s_section, %rsi
	mov 0(%r8), %r10