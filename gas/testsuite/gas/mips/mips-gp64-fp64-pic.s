
	.sdata
shared:	.4byte	11

	.data
	.size	unshared,16
unshared:
	.4byte	1
	.4byte	2
	.4byte	3
	.4byte	4

	.text
	.ent	func
func:
	.set mips4
	.set noreorder
	.cpload $25		# 0000 lui	gp,hi(_gp_disp)
				# 0004 addiu	gp,gp,lo(_gp_disp)
				# 0008 addu	gp,gp,t9
	.set reorder
	.cprestore 8		# 000c sd	gp,8(sp)
	.cpadd $4		# 0010 daddu	a0,a0,gp
	li	$4, 0x12345678	# 0014 lui	a0,0x1234
				# 0018 ori	a0,a0,0x5678
	la	$4, shared	# 001c lw	a0,got(.sdata)(gp)
				# 0020 nop
				# 0024 daddiu	a0,a0,lo(shared)
	la	$4, unshared	# 0028 lw	a0,got(.data)(gp)
				# 002c nop
				# 0030 daddiu	a0,a0,lo(unshared)
	la	$4, end		# 0034 lw	a0,got(.text)(gp)
				# 0038 nop
				# 003c daddiu	a0,a0,lo(end)
	j	end		# 0040 b	end
				# 0044 nop
	jal	end		# 0048 ld	t9,got(.text)(gp)
				# 004c nop
				# 0050 daddiu	t9,t9,lo(end)
				# 0054 jalr	t9
				# 0058 nop
				# 005c ld	gp,8(sp)
	lw	$4, shared	# 0060 ld	a0,got(.sdata)(gp)
				# 0064 nop
				# 0068 daddiu	a0,a0,lo(shared)
				# 006c lw	a0,(a0)
	lw	$4, unshared	# 0070 ld	a0,got(.data)(gp)
				# 0074 nop
				# 0078 daddiu	a0,a0,lo(unshared)
				# 007c lw	a0,(a0)
	lw	$4, end		# 0080 ld	a0,got(.text)(gp)
				# 0084 nop
				# 0088 daddiu	a0,a0,lo(end)
				# 008c lw	a0,(a0)
	ld	$4, shared	# 0090 ld	a0,got(.sdata)(gp)
				# 0094 nop
				# 0098 daddiu	a0,a0,lo(shared)
				# 009c ld	a0,(a0)
	ld	$4, unshared	# 00a0 ld	a0,got(.data)(gp)
				# 00a4 nop
				# 00a8 daddiu	a0,a0,lo(unshared)
				# 00ac ld	a0,(a0)
	ld	$4, end		# 00b0 ld	a0,got(.text)(gp)
				# 00b4 nop
				# 00b8 daddiu	a0,a0,lo(end)
				# 00bc ld	a0,(a0)
	sw	$4, shared	# 00c0 ld	at,got(.sdata)(gp)
				# 00c4 nop
				# 00c8 daddiu	at,at,lo(shared)
				# 00cc sw	a0,0(at)
	sw	$4, unshared	# 00d0 ld	at,got(.data)(gp)
				# 00d4 nop
				# 00d8 daddiu	at,at,lo(unshared)
				# 00dc sw	a0,0(at)
	sd	$4, shared	# 00e0 ld	at,got(.sdata)(gp)
				# 00e4 nop
				# 00e8 daddiu	at,at,lo(shared)
				# 00ec sd	a0,(at)
	sd	$4, unshared	# 00f0 ld	at,got(.data)(gp)
				# 00f4 nop
				# 00f8 daddiu	at,at,lo(unshared)
				# 00fc sd	a0,(at)
	ulh	$4, unshared	# 0100 ld	at,got(.data)(gp)
				# 0104 nop
				# 0108 daddiu	at,at,lo(unshared)
				# 010c lb	a0,0(at)
				# 0110 lbu	at,1(at)
				# 0114 sll	a0,a0,8
				# 0118 or	a0,a0,at
	ush	$4, unshared	# 011c ld	at,got(.data)(gp)
				# 0120 nop
				# 0124 daddiu	at,at,lo(unshared)
				# 0128 sb	a0,0(at)
				# 012c srl	a0,a0,8
				# 0130 sb	a0,1(at)
				# 0134 lbu	at,0(at)
				# 0138 sll	a0,a0,8
				# 013c or	a0,a0,at
	ulw	$4, unshared	# 0140 ld	at,got(.data)(gp)
				# 0144 nop
				# 0148 daddiu	at,at,lo(unshared)
				# 014c lwl	a0,0(at)
				# 0150 lwr	a0,3(at)
	usw	$4, unshared	# 0154 ld	at,got(.data)(gp)
				# 0158 nop
				# 015c daddiu	at,at,lo(unshared)
				# 0160 swl	a0,0(at)
				# 0164 swr	a0,3(at)
	li.d	$4, 1.0		# 0168 li	a0,0xffc0
				# 016c dsll32	a0,a0,14
	li.d	$4, 1.9		# 0170 ld	at,got(.rodata)(gp)
				# 0174 ld	a0,lo(F1.9)(at)
	li.d	$f0, 1.0	# 0178 li	at,0xffc0
				# 017c dsll32	at,at,14
				# 0180 dmtc1	at,$f0
	li.d	$f0, 1.9	# 0184 ld	at,got(.rodata)(gp)
				# 0188 ldc1	$f0,lo(L1.9)(at)
	seq	$4, $5, -100	# 018c daddiu	a0,a1,100
				# 0190 sltiu	a0,a0,1
	sne	$4, $5, -100	# 0194 daddiu	a0,a1,100
				# 0198 sltu	a0,zero,a0
	move	$4, $5		# 019c move	a0,a1

	dla	$4, shared	# 01a0 ld	a0,got(.sdata)(gp)
				# 01a4 nop
				# 01a8 daddiu	a0,a0,lo(shared) 
	dla	$4, unshared	# 01ac ld	a0,got(.data)(gp)
				# 01b0 nop
				# 01b4 daddiu	a0,a0,lo(unshared)
	uld	$4, unshared	# 01b8 ld	at,got(.data)(gp)
				# 01bc nop
				# 01c0 daddiu	at,at,lo(unshared)
				# 01c4 ldl	a0,0(at)
				# 01c8 ldr	a0,7(at)
	usd	$4, unshared	# 01cc ld	at,got(.data)(gp)
				# 01d0 nop
				# 01d4 daddiu	at,at,lo(unshared)
				# 01d8 sdl	a0,0(at)
				# 01dc sdr	a0,7(at)

	bgt	$4, 0x7fffffff, end	# 01e0 lui	at,0x8000
					# 01e4 slt	at,a0,at
					# 01e8 beqz	at,end
					# 01ec nop
	bgtu	$4, 0xffffffff, end	# 01f0 li	at,0x8000
					# 01f4 dsll	at,at,17
					# 01f8 sltu	at,a0,at
					# 01fc beqz	at,end
					# 0200 nop
	ble	$4, 0x7fffffff, end	# 0204 lui	at,0x8000
					# 0208 slt	at,a0,at
					# 020c bnez	at,end
					# 0210 nop
	bleu	$4, 0xffffffff, end	# 0214 li	at,0x8000
					# 0218 dsll	at,at,17
					# 021c sltu	at,a0,at
					# 0220 bnez	at,end
					# 0224 nop

	add.d	$f1, $f2, $f3	# 0228 add.d	$f1,$f2,$f3

end:
