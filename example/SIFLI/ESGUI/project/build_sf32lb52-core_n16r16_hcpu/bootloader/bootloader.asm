
build_sf32lb52-core_n16r16_hcpu\bootloader\bootloader.elf:     file format elf32-littlearm


Disassembly of section .text:

20020208 <deregister_tm_clones>:
20020208:	4803      	ldr	r0, [pc, #12]	@ (20020218 <deregister_tm_clones+0x10>)
2002020a:	4b04      	ldr	r3, [pc, #16]	@ (2002021c <deregister_tm_clones+0x14>)
2002020c:	4283      	cmp	r3, r0
2002020e:	d002      	beq.n	20020216 <deregister_tm_clones+0xe>
20020210:	4b03      	ldr	r3, [pc, #12]	@ (20020220 <deregister_tm_clones+0x18>)
20020212:	b103      	cbz	r3, 20020216 <deregister_tm_clones+0xe>
20020214:	4718      	bx	r3
20020216:	4770      	bx	lr
20020218:	20044960 	.word	0x20044960
2002021c:	20044960 	.word	0x20044960
20020220:	00000000 	.word	0x00000000

20020224 <register_tm_clones>:
20020224:	4b06      	ldr	r3, [pc, #24]	@ (20020240 <register_tm_clones+0x1c>)
20020226:	4907      	ldr	r1, [pc, #28]	@ (20020244 <register_tm_clones+0x20>)
20020228:	1ac9      	subs	r1, r1, r3
2002022a:	1089      	asrs	r1, r1, #2
2002022c:	bf48      	it	mi
2002022e:	3101      	addmi	r1, #1
20020230:	1049      	asrs	r1, r1, #1
20020232:	d003      	beq.n	2002023c <register_tm_clones+0x18>
20020234:	4b04      	ldr	r3, [pc, #16]	@ (20020248 <register_tm_clones+0x24>)
20020236:	b10b      	cbz	r3, 2002023c <register_tm_clones+0x18>
20020238:	4801      	ldr	r0, [pc, #4]	@ (20020240 <register_tm_clones+0x1c>)
2002023a:	4718      	bx	r3
2002023c:	4770      	bx	lr
2002023e:	bf00      	nop
20020240:	20044960 	.word	0x20044960
20020244:	20044960 	.word	0x20044960
20020248:	00000000 	.word	0x00000000

2002024c <__do_global_dtors_aux>:
2002024c:	b510      	push	{r4, lr}
2002024e:	4c06      	ldr	r4, [pc, #24]	@ (20020268 <__do_global_dtors_aux+0x1c>)
20020250:	7823      	ldrb	r3, [r4, #0]
20020252:	b943      	cbnz	r3, 20020266 <__do_global_dtors_aux+0x1a>
20020254:	f7ff ffd8 	bl	20020208 <deregister_tm_clones>
20020258:	4b04      	ldr	r3, [pc, #16]	@ (2002026c <__do_global_dtors_aux+0x20>)
2002025a:	b113      	cbz	r3, 20020262 <__do_global_dtors_aux+0x16>
2002025c:	4804      	ldr	r0, [pc, #16]	@ (20020270 <__do_global_dtors_aux+0x24>)
2002025e:	f3af 8000 	nop.w
20020262:	2301      	movs	r3, #1
20020264:	7023      	strb	r3, [r4, #0]
20020266:	bd10      	pop	{r4, pc}
20020268:	20044960 	.word	0x20044960
2002026c:	00000000 	.word	0x00000000
20020270:	2002c2dc 	.word	0x2002c2dc

20020274 <frame_dummy>:
20020274:	b508      	push	{r3, lr}
20020276:	4b05      	ldr	r3, [pc, #20]	@ (2002028c <frame_dummy+0x18>)
20020278:	b11b      	cbz	r3, 20020282 <frame_dummy+0xe>
2002027a:	4905      	ldr	r1, [pc, #20]	@ (20020290 <frame_dummy+0x1c>)
2002027c:	4805      	ldr	r0, [pc, #20]	@ (20020294 <frame_dummy+0x20>)
2002027e:	f3af 8000 	nop.w
20020282:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
20020286:	f7ff bfcd 	b.w	20020224 <register_tm_clones>
2002028a:	bf00      	nop
2002028c:	00000000 	.word	0x00000000
20020290:	20044964 	.word	0x20044964
20020294:	2002c2dc 	.word	0x2002c2dc

20020298 <boot_uart_tx>:
20020298:	2300      	movs	r3, #0
2002029a:	b510      	push	{r4, lr}
2002029c:	4293      	cmp	r3, r2
2002029e:	db00      	blt.n	200202a2 <boot_uart_tx+0xa>
200202a0:	bd10      	pop	{r4, pc}
200202a2:	69c4      	ldr	r4, [r0, #28]
200202a4:	0624      	lsls	r4, r4, #24
200202a6:	d5fc      	bpl.n	200202a2 <boot_uart_tx+0xa>
200202a8:	5ccc      	ldrb	r4, [r1, r3]
200202aa:	3301      	adds	r3, #1
200202ac:	6284      	str	r4, [r0, #40]	@ 0x28
200202ae:	e7f5      	b.n	2002029c <boot_uart_tx+0x4>

200202b0 <boot_error>:
200202b0:	b507      	push	{r0, r1, r2, lr}
200202b2:	2201      	movs	r2, #1
200202b4:	f88d 0007 	strb.w	r0, [sp, #7]
200202b8:	f10d 0107 	add.w	r1, sp, #7
200202bc:	480e      	ldr	r0, [pc, #56]	@ (200202f8 <boot_error+0x48>)
200202be:	f7ff ffeb 	bl	20020298 <boot_uart_tx>
200202c2:	4b0e      	ldr	r3, [pc, #56]	@ (200202fc <boot_error+0x4c>)
200202c4:	f8d3 2088 	ldr.w	r2, [r3, #136]	@ 0x88
200202c8:	f002 0203 	and.w	r2, r2, #3
200202cc:	2a03      	cmp	r2, #3
200202ce:	f102 0101 	add.w	r1, r2, #1
200202d2:	d00f      	beq.n	200202f4 <boot_error+0x44>
200202d4:	f8d3 2088 	ldr.w	r2, [r3, #136]	@ 0x88
200202d8:	f022 0203 	bic.w	r2, r2, #3
200202dc:	f8c3 2088 	str.w	r2, [r3, #136]	@ 0x88
200202e0:	f8d3 2088 	ldr.w	r2, [r3, #136]	@ 0x88
200202e4:	430a      	orrs	r2, r1
200202e6:	f8c3 2088 	str.w	r2, [r3, #136]	@ 0x88
200202ea:	f00c f823 	bl	2002c334 <HAL_PMU_Reboot>
200202ee:	b003      	add	sp, #12
200202f0:	f85d fb04 	ldr.w	pc, [sp], #4
200202f4:	e7fe      	b.n	200202f4 <boot_error+0x44>
200202f6:	bf00      	nop
200202f8:	50084000 	.word	0x50084000
200202fc:	500ca000 	.word	0x500ca000

20020300 <HAL_MspInit>:
20020300:	2234      	movs	r2, #52	@ 0x34
20020302:	4b01      	ldr	r3, [pc, #4]	@ (20020308 <HAL_MspInit+0x8>)
20020304:	60da      	str	r2, [r3, #12]
20020306:	4770      	bx	lr
20020308:	50094000 	.word	0x50094000

2002030c <mpu_config>:
2002030c:	4770      	bx	lr

2002030e <cache_enable>:
2002030e:	4770      	bx	lr

20020310 <board_pinmux_mpi1_puya_base>:
20020310:	b510      	push	{r4, lr}
20020312:	2301      	movs	r3, #1
20020314:	2200      	movs	r2, #0
20020316:	2103      	movs	r1, #3
20020318:	2002      	movs	r0, #2
2002031a:	f004 fc17 	bl	20024b4c <HAL_PIN_Set>
2002031e:	2301      	movs	r3, #1
20020320:	2200      	movs	r2, #0
20020322:	4619      	mov	r1, r3
20020324:	200a      	movs	r0, #10
20020326:	f004 fc11 	bl	20024b4c <HAL_PIN_Set>
2002032a:	2301      	movs	r3, #1
2002032c:	2210      	movs	r2, #16
2002032e:	2109      	movs	r1, #9
20020330:	2008      	movs	r0, #8
20020332:	f004 fc0b 	bl	20024b4c <HAL_PIN_Set>
20020336:	2301      	movs	r3, #1
20020338:	2210      	movs	r2, #16
2002033a:	210a      	movs	r1, #10
2002033c:	2003      	movs	r0, #3
2002033e:	f004 fc05 	bl	20024b4c <HAL_PIN_Set>
20020342:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20020346:	2301      	movs	r3, #1
20020348:	2200      	movs	r2, #0
2002034a:	210c      	movs	r1, #12
2002034c:	200b      	movs	r0, #11
2002034e:	f004 bbfd 	b.w	20024b4c <HAL_PIN_Set>

20020352 <board_pinmux_mpi1_puya_ext>:
20020352:	b510      	push	{r4, lr}
20020354:	4604      	mov	r4, r0
20020356:	2101      	movs	r1, #1
20020358:	2005      	movs	r0, #5
2002035a:	f004 fd3b 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002035e:	2101      	movs	r1, #1
20020360:	2006      	movs	r0, #6
20020362:	f004 fd37 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020366:	2101      	movs	r1, #1
20020368:	2007      	movs	r0, #7
2002036a:	f004 fd33 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002036e:	2101      	movs	r1, #1
20020370:	2009      	movs	r0, #9
20020372:	f004 fd2f 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020376:	2101      	movs	r1, #1
20020378:	200c      	movs	r0, #12
2002037a:	f004 fd2b 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002037e:	2101      	movs	r1, #1
20020380:	200d      	movs	r0, #13
20020382:	f004 fd27 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020386:	2101      	movs	r1, #1
20020388:	b154      	cbz	r4, 200203a0 <board_pinmux_mpi1_puya_ext+0x4e>
2002038a:	4608      	mov	r0, r1
2002038c:	f004 fd22 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020390:	2301      	movs	r3, #1
20020392:	2230      	movs	r2, #48	@ 0x30
20020394:	210b      	movs	r1, #11
20020396:	2004      	movs	r0, #4
20020398:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
2002039c:	f004 bbd6 	b.w	20024b4c <HAL_PIN_Set>
200203a0:	2004      	movs	r0, #4
200203a2:	f004 fd17 	bl	20024dd4 <HAL_PIN_Set_Analog>
200203a6:	2301      	movs	r3, #1
200203a8:	2230      	movs	r2, #48	@ 0x30
200203aa:	210b      	movs	r1, #11
200203ac:	4618      	mov	r0, r3
200203ae:	e7f3      	b.n	20020398 <board_pinmux_mpi1_puya_ext+0x46>

200203b0 <board_pinmux_mpi1_gd>:
200203b0:	b508      	push	{r3, lr}
200203b2:	2200      	movs	r2, #0
200203b4:	2301      	movs	r3, #1
200203b6:	2103      	movs	r1, #3
200203b8:	2005      	movs	r0, #5
200203ba:	f004 fbc7 	bl	20024b4c <HAL_PIN_Set>
200203be:	2301      	movs	r3, #1
200203c0:	2200      	movs	r2, #0
200203c2:	4619      	mov	r1, r3
200203c4:	200a      	movs	r0, #10
200203c6:	f004 fbc1 	bl	20024b4c <HAL_PIN_Set>
200203ca:	2301      	movs	r3, #1
200203cc:	2210      	movs	r2, #16
200203ce:	2109      	movs	r1, #9
200203d0:	200c      	movs	r0, #12
200203d2:	f004 fbbb 	bl	20024b4c <HAL_PIN_Set>
200203d6:	2301      	movs	r3, #1
200203d8:	2210      	movs	r2, #16
200203da:	210a      	movs	r1, #10
200203dc:	2003      	movs	r0, #3
200203de:	f004 fbb5 	bl	20024b4c <HAL_PIN_Set>
200203e2:	2301      	movs	r3, #1
200203e4:	2230      	movs	r2, #48	@ 0x30
200203e6:	210b      	movs	r1, #11
200203e8:	4618      	mov	r0, r3
200203ea:	f004 fbaf 	bl	20024b4c <HAL_PIN_Set>
200203ee:	2301      	movs	r3, #1
200203f0:	2230      	movs	r2, #48	@ 0x30
200203f2:	210c      	movs	r1, #12
200203f4:	2009      	movs	r0, #9
200203f6:	f004 fba9 	bl	20024b4c <HAL_PIN_Set>
200203fa:	2101      	movs	r1, #1
200203fc:	2002      	movs	r0, #2
200203fe:	f004 fce9 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020402:	2101      	movs	r1, #1
20020404:	2004      	movs	r0, #4
20020406:	f004 fce5 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002040a:	2101      	movs	r1, #1
2002040c:	2006      	movs	r0, #6
2002040e:	f004 fce1 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020412:	2101      	movs	r1, #1
20020414:	2007      	movs	r0, #7
20020416:	f004 fcdd 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002041a:	2101      	movs	r1, #1
2002041c:	2008      	movs	r0, #8
2002041e:	f004 fcd9 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020422:	2101      	movs	r1, #1
20020424:	200b      	movs	r0, #11
20020426:	f004 fcd5 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002042a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
2002042e:	2101      	movs	r1, #1
20020430:	200d      	movs	r0, #13
20020432:	f004 bccf 	b.w	20024dd4 <HAL_PIN_Set_Analog>

20020436 <board_pinmux_mpi2>:
20020436:	b510      	push	{r4, lr}
20020438:	2301      	movs	r3, #1
2002043a:	2200      	movs	r2, #0
2002043c:	2119      	movs	r1, #25
2002043e:	201e      	movs	r0, #30
20020440:	f004 fb84 	bl	20024b4c <HAL_PIN_Set>
20020444:	2301      	movs	r3, #1
20020446:	2200      	movs	r2, #0
20020448:	211b      	movs	r1, #27
2002044a:	201a      	movs	r0, #26
2002044c:	f004 fb7e 	bl	20024b4c <HAL_PIN_Set>
20020450:	2301      	movs	r3, #1
20020452:	2210      	movs	r2, #16
20020454:	2121      	movs	r1, #33	@ 0x21
20020456:	201d      	movs	r0, #29
20020458:	f004 fb78 	bl	20024b4c <HAL_PIN_Set>
2002045c:	2301      	movs	r3, #1
2002045e:	2210      	movs	r2, #16
20020460:	2122      	movs	r1, #34	@ 0x22
20020462:	201b      	movs	r0, #27
20020464:	f004 fb72 	bl	20024b4c <HAL_PIN_Set>
20020468:	2301      	movs	r3, #1
2002046a:	2230      	movs	r2, #48	@ 0x30
2002046c:	2123      	movs	r1, #35	@ 0x23
2002046e:	201c      	movs	r0, #28
20020470:	f004 fb6c 	bl	20024b4c <HAL_PIN_Set>
20020474:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20020478:	2301      	movs	r3, #1
2002047a:	2230      	movs	r2, #48	@ 0x30
2002047c:	2124      	movs	r1, #36	@ 0x24
2002047e:	201f      	movs	r0, #31
20020480:	f004 bb64 	b.w	20024b4c <HAL_PIN_Set>

20020484 <board_pinmux_sd>:
20020484:	b510      	push	{r4, lr}
20020486:	2301      	movs	r3, #1
20020488:	2230      	movs	r2, #48	@ 0x30
2002048a:	f44f 71da 	mov.w	r1, #436	@ 0x1b4
2002048e:	201d      	movs	r0, #29
20020490:	f004 fb5c 	bl	20024b4c <HAL_PIN_Set>
20020494:	2014      	movs	r0, #20
20020496:	f001 fd30 	bl	20021efa <HAL_Delay_us>
2002049a:	2301      	movs	r3, #1
2002049c:	2200      	movs	r2, #0
2002049e:	f44f 71d9 	mov.w	r1, #434	@ 0x1b2
200204a2:	201c      	movs	r0, #28
200204a4:	f004 fb52 	bl	20024b4c <HAL_PIN_Set>
200204a8:	2301      	movs	r3, #1
200204aa:	2230      	movs	r2, #48	@ 0x30
200204ac:	f240 11b5 	movw	r1, #437	@ 0x1b5
200204b0:	201e      	movs	r0, #30
200204b2:	f004 fb4b 	bl	20024b4c <HAL_PIN_Set>
200204b6:	2301      	movs	r3, #1
200204b8:	2230      	movs	r2, #48	@ 0x30
200204ba:	f44f 71db 	mov.w	r1, #438	@ 0x1b6
200204be:	201f      	movs	r0, #31
200204c0:	f004 fb44 	bl	20024b4c <HAL_PIN_Set>
200204c4:	2301      	movs	r3, #1
200204c6:	2230      	movs	r2, #48	@ 0x30
200204c8:	f240 11b7 	movw	r1, #439	@ 0x1b7
200204cc:	201a      	movs	r0, #26
200204ce:	f004 fb3d 	bl	20024b4c <HAL_PIN_Set>
200204d2:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
200204d6:	2301      	movs	r3, #1
200204d8:	2230      	movs	r2, #48	@ 0x30
200204da:	f44f 71dc 	mov.w	r1, #440	@ 0x1b8
200204de:	201b      	movs	r0, #27
200204e0:	f004 bb34 	b.w	20024b4c <HAL_PIN_Set>

200204e4 <board_boot_from>:
200204e4:	b510      	push	{r4, lr}
200204e6:	4b0d      	ldr	r3, [pc, #52]	@ (2002051c <board_boot_from+0x38>)
200204e8:	685b      	ldr	r3, [r3, #4]
200204ea:	f3c3 2302 	ubfx	r3, r3, #8, #3
200204ee:	2b07      	cmp	r3, #7
200204f0:	d10c      	bne.n	2002050c <board_boot_from+0x28>
200204f2:	2400      	movs	r4, #0
200204f4:	3401      	adds	r4, #1
200204f6:	2101      	movs	r1, #1
200204f8:	4620      	mov	r0, r4
200204fa:	f004 fc6b 	bl	20024dd4 <HAL_PIN_Set_Analog>
200204fe:	2c0d      	cmp	r4, #13
20020500:	d1f8      	bne.n	200204f4 <board_boot_from+0x10>
20020502:	2000      	movs	r0, #0
20020504:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20020508:	f002 badc 	b.w	20022ac4 <HAL_Get_backup>
2002050c:	b11b      	cbz	r3, 20020516 <board_boot_from+0x32>
2002050e:	2b01      	cmp	r3, #1
20020510:	d1f7      	bne.n	20020502 <board_boot_from+0x1e>
20020512:	2002      	movs	r0, #2
20020514:	bd10      	pop	{r4, pc}
20020516:	2001      	movs	r0, #1
20020518:	e7fc      	b.n	20020514 <board_boot_from+0x30>
2002051a:	bf00      	nop
2002051c:	5000b000 	.word	0x5000b000

20020520 <board_flash_power_on>:
20020520:	4770      	bx	lr

20020522 <board_pinmux_psram_func0>:
20020522:	b508      	push	{r3, lr}
20020524:	2210      	movs	r2, #16
20020526:	2301      	movs	r3, #1
20020528:	2109      	movs	r1, #9
2002052a:	2002      	movs	r0, #2
2002052c:	f004 fb0e 	bl	20024b4c <HAL_PIN_Set>
20020530:	2301      	movs	r3, #1
20020532:	2210      	movs	r2, #16
20020534:	210a      	movs	r1, #10
20020536:	2003      	movs	r0, #3
20020538:	f004 fb08 	bl	20024b4c <HAL_PIN_Set>
2002053c:	2301      	movs	r3, #1
2002053e:	2210      	movs	r2, #16
20020540:	210b      	movs	r1, #11
20020542:	2004      	movs	r0, #4
20020544:	f004 fb02 	bl	20024b4c <HAL_PIN_Set>
20020548:	2301      	movs	r3, #1
2002054a:	2210      	movs	r2, #16
2002054c:	210c      	movs	r1, #12
2002054e:	2005      	movs	r0, #5
20020550:	f004 fafc 	bl	20024b4c <HAL_PIN_Set>
20020554:	2301      	movs	r3, #1
20020556:	2210      	movs	r2, #16
20020558:	210d      	movs	r1, #13
2002055a:	2006      	movs	r0, #6
2002055c:	f004 faf6 	bl	20024b4c <HAL_PIN_Set>
20020560:	2301      	movs	r3, #1
20020562:	2210      	movs	r2, #16
20020564:	210e      	movs	r1, #14
20020566:	2007      	movs	r0, #7
20020568:	f004 faf0 	bl	20024b4c <HAL_PIN_Set>
2002056c:	2301      	movs	r3, #1
2002056e:	2210      	movs	r2, #16
20020570:	210f      	movs	r1, #15
20020572:	2008      	movs	r0, #8
20020574:	f004 faea 	bl	20024b4c <HAL_PIN_Set>
20020578:	2210      	movs	r2, #16
2002057a:	2301      	movs	r3, #1
2002057c:	4611      	mov	r1, r2
2002057e:	2009      	movs	r0, #9
20020580:	f004 fae4 	bl	20024b4c <HAL_PIN_Set>
20020584:	2301      	movs	r3, #1
20020586:	2210      	movs	r2, #16
20020588:	2106      	movs	r1, #6
2002058a:	200a      	movs	r0, #10
2002058c:	f004 fade 	bl	20024b4c <HAL_PIN_Set>
20020590:	2301      	movs	r3, #1
20020592:	2200      	movs	r2, #0
20020594:	4619      	mov	r1, r3
20020596:	200b      	movs	r0, #11
20020598:	f004 fad8 	bl	20024b4c <HAL_PIN_Set>
2002059c:	2301      	movs	r3, #1
2002059e:	2200      	movs	r2, #0
200205a0:	2103      	movs	r1, #3
200205a2:	200c      	movs	r0, #12
200205a4:	f004 fad2 	bl	20024b4c <HAL_PIN_Set>
200205a8:	2101      	movs	r1, #1
200205aa:	4608      	mov	r0, r1
200205ac:	f004 fc12 	bl	20024dd4 <HAL_PIN_Set_Analog>
200205b0:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
200205b4:	2101      	movs	r1, #1
200205b6:	200d      	movs	r0, #13
200205b8:	f004 bc0c 	b.w	20024dd4 <HAL_PIN_Set_Analog>

200205bc <board_pinmux_psram_func1_2_4>:
200205bc:	b510      	push	{r4, lr}
200205be:	2301      	movs	r3, #1
200205c0:	4604      	mov	r4, r0
200205c2:	2210      	movs	r2, #16
200205c4:	2109      	movs	r1, #9
200205c6:	2002      	movs	r0, #2
200205c8:	f004 fac0 	bl	20024b4c <HAL_PIN_Set>
200205cc:	2301      	movs	r3, #1
200205ce:	2210      	movs	r2, #16
200205d0:	210a      	movs	r1, #10
200205d2:	2003      	movs	r0, #3
200205d4:	f004 faba 	bl	20024b4c <HAL_PIN_Set>
200205d8:	2301      	movs	r3, #1
200205da:	2210      	movs	r2, #16
200205dc:	210b      	movs	r1, #11
200205de:	2004      	movs	r0, #4
200205e0:	f004 fab4 	bl	20024b4c <HAL_PIN_Set>
200205e4:	2301      	movs	r3, #1
200205e6:	2210      	movs	r2, #16
200205e8:	210c      	movs	r1, #12
200205ea:	2005      	movs	r0, #5
200205ec:	f004 faae 	bl	20024b4c <HAL_PIN_Set>
200205f0:	2301      	movs	r3, #1
200205f2:	2210      	movs	r2, #16
200205f4:	210d      	movs	r1, #13
200205f6:	2009      	movs	r0, #9
200205f8:	f004 faa8 	bl	20024b4c <HAL_PIN_Set>
200205fc:	2301      	movs	r3, #1
200205fe:	2210      	movs	r2, #16
20020600:	210e      	movs	r1, #14
20020602:	200a      	movs	r0, #10
20020604:	f004 faa2 	bl	20024b4c <HAL_PIN_Set>
20020608:	2301      	movs	r3, #1
2002060a:	2210      	movs	r2, #16
2002060c:	210f      	movs	r1, #15
2002060e:	200b      	movs	r0, #11
20020610:	f004 fa9c 	bl	20024b4c <HAL_PIN_Set>
20020614:	2210      	movs	r2, #16
20020616:	2301      	movs	r3, #1
20020618:	4611      	mov	r1, r2
2002061a:	200c      	movs	r0, #12
2002061c:	f004 fa96 	bl	20024b4c <HAL_PIN_Set>
20020620:	2301      	movs	r3, #1
20020622:	2200      	movs	r2, #0
20020624:	4619      	mov	r1, r3
20020626:	2008      	movs	r0, #8
20020628:	f004 fa90 	bl	20024b4c <HAL_PIN_Set>
2002062c:	2301      	movs	r3, #1
2002062e:	2200      	movs	r2, #0
20020630:	2103      	movs	r1, #3
20020632:	2006      	movs	r0, #6
20020634:	f004 fa8a 	bl	20024b4c <HAL_PIN_Set>
20020638:	2c02      	cmp	r4, #2
2002063a:	d013      	beq.n	20020664 <board_pinmux_psram_func1_2_4+0xa8>
2002063c:	2c04      	cmp	r4, #4
2002063e:	d025      	beq.n	2002068c <board_pinmux_psram_func1_2_4+0xd0>
20020640:	2c01      	cmp	r4, #1
20020642:	d12c      	bne.n	2002069e <board_pinmux_psram_func1_2_4+0xe2>
20020644:	2106      	movs	r1, #6
20020646:	4623      	mov	r3, r4
20020648:	2210      	movs	r2, #16
2002064a:	200d      	movs	r0, #13
2002064c:	f004 fa7e 	bl	20024b4c <HAL_PIN_Set>
20020650:	4621      	mov	r1, r4
20020652:	4620      	mov	r0, r4
20020654:	f004 fbbe 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020658:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
2002065c:	2101      	movs	r1, #1
2002065e:	2007      	movs	r0, #7
20020660:	f004 bbb8 	b.w	20024dd4 <HAL_PIN_Set_Analog>
20020664:	2301      	movs	r3, #1
20020666:	2210      	movs	r2, #16
20020668:	2104      	movs	r1, #4
2002066a:	4618      	mov	r0, r3
2002066c:	f004 fa6e 	bl	20024b4c <HAL_PIN_Set>
20020670:	2301      	movs	r3, #1
20020672:	2210      	movs	r2, #16
20020674:	2105      	movs	r1, #5
20020676:	200d      	movs	r0, #13
20020678:	f004 fa68 	bl	20024b4c <HAL_PIN_Set>
2002067c:	4621      	mov	r1, r4
2002067e:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20020682:	2301      	movs	r3, #1
20020684:	2200      	movs	r2, #0
20020686:	2007      	movs	r0, #7
20020688:	f004 ba60 	b.w	20024b4c <HAL_PIN_Set>
2002068c:	2106      	movs	r1, #6
2002068e:	2301      	movs	r3, #1
20020690:	2200      	movs	r2, #0
20020692:	200d      	movs	r0, #13
20020694:	f004 fa5a 	bl	20024b4c <HAL_PIN_Set>
20020698:	2101      	movs	r1, #1
2002069a:	4608      	mov	r0, r1
2002069c:	e7da      	b.n	20020654 <board_pinmux_psram_func1_2_4+0x98>
2002069e:	bd10      	pop	{r4, pc}

200206a0 <board_pinmux_psram_func3>:
200206a0:	b508      	push	{r3, lr}
200206a2:	2301      	movs	r3, #1
200206a4:	2200      	movs	r2, #0
200206a6:	4619      	mov	r1, r3
200206a8:	200a      	movs	r0, #10
200206aa:	f004 fa4f 	bl	20024b4c <HAL_PIN_Set>
200206ae:	2301      	movs	r3, #1
200206b0:	2200      	movs	r2, #0
200206b2:	2103      	movs	r1, #3
200206b4:	2009      	movs	r0, #9
200206b6:	f004 fa49 	bl	20024b4c <HAL_PIN_Set>
200206ba:	2301      	movs	r3, #1
200206bc:	2210      	movs	r2, #16
200206be:	2109      	movs	r1, #9
200206c0:	2006      	movs	r0, #6
200206c2:	f004 fa43 	bl	20024b4c <HAL_PIN_Set>
200206c6:	2301      	movs	r3, #1
200206c8:	2210      	movs	r2, #16
200206ca:	210a      	movs	r1, #10
200206cc:	2008      	movs	r0, #8
200206ce:	f004 fa3d 	bl	20024b4c <HAL_PIN_Set>
200206d2:	2301      	movs	r3, #1
200206d4:	2230      	movs	r2, #48	@ 0x30
200206d6:	210b      	movs	r1, #11
200206d8:	2007      	movs	r0, #7
200206da:	f004 fa37 	bl	20024b4c <HAL_PIN_Set>
200206de:	2301      	movs	r3, #1
200206e0:	2230      	movs	r2, #48	@ 0x30
200206e2:	210c      	movs	r1, #12
200206e4:	200b      	movs	r0, #11
200206e6:	f004 fa31 	bl	20024b4c <HAL_PIN_Set>
200206ea:	2101      	movs	r1, #1
200206ec:	4608      	mov	r0, r1
200206ee:	f004 fb71 	bl	20024dd4 <HAL_PIN_Set_Analog>
200206f2:	2101      	movs	r1, #1
200206f4:	2002      	movs	r0, #2
200206f6:	f004 fb6d 	bl	20024dd4 <HAL_PIN_Set_Analog>
200206fa:	2101      	movs	r1, #1
200206fc:	2003      	movs	r0, #3
200206fe:	f004 fb69 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020702:	2101      	movs	r1, #1
20020704:	2004      	movs	r0, #4
20020706:	f004 fb65 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002070a:	2101      	movs	r1, #1
2002070c:	2005      	movs	r0, #5
2002070e:	f004 fb61 	bl	20024dd4 <HAL_PIN_Set_Analog>
20020712:	2101      	movs	r1, #1
20020714:	200c      	movs	r0, #12
20020716:	f004 fb5d 	bl	20024dd4 <HAL_PIN_Set_Analog>
2002071a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
2002071e:	2101      	movs	r1, #1
20020720:	200d      	movs	r0, #13
20020722:	f004 bb57 	b.w	20024dd4 <HAL_PIN_Set_Analog>

20020726 <bootloader_switch_clock>:
20020726:	2102      	movs	r1, #2
20020728:	2004      	movs	r0, #4
2002072a:	f004 bc85 	b.w	20025038 <HAL_RCC_HCPU_ClockSelect>
	...

20020730 <boot_psram_init>:
20020730:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20020734:	2400      	movs	r4, #0
20020736:	b08a      	sub	sp, #40	@ 0x28
20020738:	4605      	mov	r5, r0
2002073a:	2230      	movs	r2, #48	@ 0x30
2002073c:	4621      	mov	r1, r4
2002073e:	4863      	ldr	r0, [pc, #396]	@ (200208cc <boot_psram_init+0x19c>)
20020740:	f00a f888 	bl	2002a854 <memset>
20020744:	4b62      	ldr	r3, [pc, #392]	@ (200208d0 <boot_psram_init+0x1a0>)
20020746:	1ea8      	subs	r0, r5, #2
20020748:	9305      	str	r3, [sp, #20]
2002074a:	f04f 5380 	mov.w	r3, #268435456	@ 0x10000000
2002074e:	9307      	str	r3, [sp, #28]
20020750:	2303      	movs	r3, #3
20020752:	9406      	str	r4, [sp, #24]
20020754:	9309      	str	r3, [sp, #36]	@ 0x24
20020756:	2804      	cmp	r0, #4
20020758:	d804      	bhi.n	20020764 <boot_psram_init+0x34>
2002075a:	e8df f000 	tbb	[pc, r0]
2002075e:	6264      	.short	0x6264
20020760:	5d04      	.short	0x5d04
20020762:	60          	.byte	0x60
20020763:	00          	.byte	0x00
20020764:	e7fe      	b.n	20020764 <boot_psram_init+0x34>
20020766:	2305      	movs	r3, #5
20020768:	9309      	str	r3, [sp, #36]	@ 0x24
2002076a:	2304      	movs	r3, #4
2002076c:	9d09      	ldr	r5, [sp, #36]	@ 0x24
2002076e:	9308      	str	r3, [sp, #32]
20020770:	2d03      	cmp	r5, #3
20020772:	d162      	bne.n	2002083a <boot_psram_init+0x10a>
20020774:	f001 fae2 	bl	20021d3c <BSP_GetFlash1DIV>
20020778:	a905      	add	r1, sp, #20
2002077a:	4602      	mov	r2, r0
2002077c:	4853      	ldr	r0, [pc, #332]	@ (200208cc <boot_psram_init+0x19c>)
2002077e:	f003 ff81 	bl	20024684 <HAL_OPI_PSRAM_Init>
20020782:	462a      	mov	r2, r5
20020784:	2108      	movs	r1, #8
20020786:	4851      	ldr	r0, [pc, #324]	@ (200208cc <boot_psram_init+0x19c>)
20020788:	f003 fe6e 	bl	20024468 <HAL_MPI_MR_WRITE>
2002078c:	484f      	ldr	r0, [pc, #316]	@ (200208cc <boot_psram_init+0x19c>)
2002078e:	f003 fb79 	bl	20023e84 <HAL_QSPI_GET_CLK>
20020792:	4b50      	ldr	r3, [pc, #320]	@ (200208d4 <boot_psram_init+0x1a4>)
20020794:	4298      	cmp	r0, r3
20020796:	d948      	bls.n	2002082a <boot_psram_init+0xfa>
20020798:	f103 63a4 	add.w	r3, r3, #85983232	@ 0x5200000
2002079c:	f503 4383 	add.w	r3, r3, #16768	@ 0x4180
200207a0:	4298      	cmp	r0, r3
200207a2:	d944      	bls.n	2002082e <boot_psram_init+0xfe>
200207a4:	f103 7337 	add.w	r3, r3, #47972352	@ 0x2dc0000
200207a8:	f503 43d8 	add.w	r3, r3, #27648	@ 0x6c00
200207ac:	4298      	cmp	r0, r3
200207ae:	d940      	bls.n	20020832 <boot_psram_init+0x102>
200207b0:	4b49      	ldr	r3, [pc, #292]	@ (200208d8 <boot_psram_init+0x1a8>)
200207b2:	4298      	cmp	r0, r3
200207b4:	d93f      	bls.n	20020836 <boot_psram_init+0x106>
200207b6:	4b49      	ldr	r3, [pc, #292]	@ (200208dc <boot_psram_init+0x1ac>)
200207b8:	4298      	cmp	r0, r3
200207ba:	bf98      	it	ls
200207bc:	2407      	movls	r4, #7
200207be:	2600      	movs	r6, #0
200207c0:	2507      	movs	r5, #7
200207c2:	f04f 0803 	mov.w	r8, #3
200207c6:	0067      	lsls	r7, r4, #1
200207c8:	b2ff      	uxtb	r7, r7
200207ca:	1e7a      	subs	r2, r7, #1
200207cc:	4633      	mov	r3, r6
200207ce:	b252      	sxtb	r2, r2
200207d0:	4629      	mov	r1, r5
200207d2:	483e      	ldr	r0, [pc, #248]	@ (200208cc <boot_psram_init+0x19c>)
200207d4:	e9cd 5502 	strd	r5, r5, [sp, #8]
200207d8:	e9cd 6800 	strd	r6, r8, [sp]
200207dc:	f002 f9e2 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200207e0:	4631      	mov	r1, r6
200207e2:	483a      	ldr	r0, [pc, #232]	@ (200208cc <boot_psram_init+0x19c>)
200207e4:	f002 f9d3 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
200207e8:	1e62      	subs	r2, r4, #1
200207ea:	4633      	mov	r3, r6
200207ec:	b252      	sxtb	r2, r2
200207ee:	4629      	mov	r1, r5
200207f0:	4836      	ldr	r0, [pc, #216]	@ (200208cc <boot_psram_init+0x19c>)
200207f2:	e9cd 5502 	strd	r5, r5, [sp, #8]
200207f6:	e9cd 6800 	strd	r6, r8, [sp]
200207fa:	f002 f9fc 	bl	20022bf6 <HAL_FLASH_CFG_AHB_WCMD>
200207fe:	2180      	movs	r1, #128	@ 0x80
20020800:	4832      	ldr	r0, [pc, #200]	@ (200208cc <boot_psram_init+0x19c>)
20020802:	f002 f9ec 	bl	20022bde <HAL_FLASH_SET_AHB_WCMD>
20020806:	4623      	mov	r3, r4
20020808:	463a      	mov	r2, r7
2002080a:	2101      	movs	r1, #1
2002080c:	482f      	ldr	r0, [pc, #188]	@ (200208cc <boot_psram_init+0x19c>)
2002080e:	f003 fe4f 	bl	200244b0 <HAL_MPI_SET_FIXLAT>
20020812:	b00a      	add	sp, #40	@ 0x28
20020814:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20020818:	2302      	movs	r3, #2
2002081a:	9309      	str	r3, [sp, #36]	@ 0x24
2002081c:	e7a6      	b.n	2002076c <boot_psram_init+0x3c>
2002081e:	2306      	movs	r3, #6
20020820:	9309      	str	r3, [sp, #36]	@ 0x24
20020822:	2308      	movs	r3, #8
20020824:	e7a2      	b.n	2002076c <boot_psram_init+0x3c>
20020826:	2310      	movs	r3, #16
20020828:	e7a0      	b.n	2002076c <boot_psram_init+0x3c>
2002082a:	462c      	mov	r4, r5
2002082c:	e7c7      	b.n	200207be <boot_psram_init+0x8e>
2002082e:	2404      	movs	r4, #4
20020830:	e7c5      	b.n	200207be <boot_psram_init+0x8e>
20020832:	2405      	movs	r4, #5
20020834:	e7c3      	b.n	200207be <boot_psram_init+0x8e>
20020836:	2406      	movs	r4, #6
20020838:	e7c1      	b.n	200207be <boot_psram_init+0x8e>
2002083a:	2d05      	cmp	r5, #5
2002083c:	d10d      	bne.n	2002085a <boot_psram_init+0x12a>
2002083e:	f001 fa7d 	bl	20021d3c <BSP_GetFlash1DIV>
20020842:	a905      	add	r1, sp, #20
20020844:	4602      	mov	r2, r0
20020846:	4821      	ldr	r0, [pc, #132]	@ (200208cc <boot_psram_init+0x19c>)
20020848:	f003 ff98 	bl	2002477c <HAL_LEGACY_PSRAM_Init>
2002084c:	481f      	ldr	r0, [pc, #124]	@ (200208cc <boot_psram_init+0x19c>)
2002084e:	f003 fea1 	bl	20024594 <HAL_LEGACY_CFG_READ>
20020852:	481e      	ldr	r0, [pc, #120]	@ (200208cc <boot_psram_init+0x19c>)
20020854:	f003 feb9 	bl	200245ca <HAL_LEGACY_CFG_WRITE>
20020858:	e7db      	b.n	20020812 <boot_psram_init+0xe2>
2002085a:	2d06      	cmp	r5, #6
2002085c:	d10d      	bne.n	2002087a <boot_psram_init+0x14a>
2002085e:	f001 fa6d 	bl	20021d3c <BSP_GetFlash1DIV>
20020862:	a905      	add	r1, sp, #20
20020864:	4602      	mov	r2, r0
20020866:	4819      	ldr	r0, [pc, #100]	@ (200208cc <boot_psram_init+0x19c>)
20020868:	f004 f854 	bl	20024914 <HAL_HYPER_PSRAM_Init>
2002086c:	4817      	ldr	r0, [pc, #92]	@ (200208cc <boot_psram_init+0x19c>)
2002086e:	f004 f88b 	bl	20024988 <HAL_HYPER_CFG_READ>
20020872:	4816      	ldr	r0, [pc, #88]	@ (200208cc <boot_psram_init+0x19c>)
20020874:	f004 f89a 	bl	200249ac <HAL_HYPER_CFG_WRITE>
20020878:	e7cb      	b.n	20020812 <boot_psram_init+0xe2>
2002087a:	f001 fa5f 	bl	20021d3c <BSP_GetFlash1DIV>
2002087e:	2500      	movs	r5, #0
20020880:	2403      	movs	r4, #3
20020882:	2701      	movs	r7, #1
20020884:	2602      	movs	r6, #2
20020886:	4602      	mov	r2, r0
20020888:	a905      	add	r1, sp, #20
2002088a:	4810      	ldr	r0, [pc, #64]	@ (200208cc <boot_psram_init+0x19c>)
2002088c:	f003 fd96 	bl	200243bc <HAL_SPI_PSRAM_Init>
20020890:	462b      	mov	r3, r5
20020892:	2206      	movs	r2, #6
20020894:	4621      	mov	r1, r4
20020896:	e9cd 4702 	strd	r4, r7, [sp, #8]
2002089a:	e9cd 5600 	strd	r5, r6, [sp]
2002089e:	480b      	ldr	r0, [pc, #44]	@ (200208cc <boot_psram_init+0x19c>)
200208a0:	f002 f980 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200208a4:	21eb      	movs	r1, #235	@ 0xeb
200208a6:	4809      	ldr	r0, [pc, #36]	@ (200208cc <boot_psram_init+0x19c>)
200208a8:	f002 f971 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
200208ac:	4621      	mov	r1, r4
200208ae:	462b      	mov	r3, r5
200208b0:	462a      	mov	r2, r5
200208b2:	e9cd 4702 	strd	r4, r7, [sp, #8]
200208b6:	e9cd 5600 	strd	r5, r6, [sp]
200208ba:	4804      	ldr	r0, [pc, #16]	@ (200208cc <boot_psram_init+0x19c>)
200208bc:	f002 f99b 	bl	20022bf6 <HAL_FLASH_CFG_AHB_WCMD>
200208c0:	2138      	movs	r1, #56	@ 0x38
200208c2:	4802      	ldr	r0, [pc, #8]	@ (200208cc <boot_psram_init+0x19c>)
200208c4:	f002 f98b 	bl	20022bde <HAL_FLASH_SET_AHB_WCMD>
200208c8:	e7a3      	b.n	20020812 <boot_psram_init+0xe2>
200208ca:	bf00      	nop
200208cc:	2004497c 	.word	0x2004497c
200208d0:	50041000 	.word	0x50041000
200208d4:	07de2901 	.word	0x07de2901
200208d8:	13c9eb01 	.word	0x13c9eb01
200208dc:	17d78401 	.word	0x17d78401

200208e0 <board_init_psram>:
200208e0:	b510      	push	{r4, lr}
200208e2:	4b15      	ldr	r3, [pc, #84]	@ (20020938 <board_init_psram+0x58>)
200208e4:	685c      	ldr	r4, [r3, #4]
200208e6:	f3c4 2402 	ubfx	r4, r4, #8, #3
200208ea:	1ea3      	subs	r3, r4, #2
200208ec:	2b04      	cmp	r3, #4
200208ee:	d821      	bhi.n	20020934 <board_init_psram+0x54>
200208f0:	e8df f003 	tbb	[pc, r3]
200208f4:	03151b1d 	.word	0x03151b1d
200208f8:	19          	.byte	0x19
200208f9:	00          	.byte	0x00
200208fa:	f7ff fed1 	bl	200206a0 <board_pinmux_psram_func3>
200208fe:	2201      	movs	r2, #1
20020900:	2000      	movs	r0, #0
20020902:	4611      	mov	r1, r2
20020904:	f00b fcec 	bl	2002c2e0 <HAL_PMU_ConfigPeriLdo>
20020908:	2001      	movs	r0, #1
2002090a:	f7ff ff0c 	bl	20020726 <bootloader_switch_clock>
2002090e:	2002      	movs	r0, #2
20020910:	f001 fa20 	bl	20021d54 <BSP_SetFlash1DIV>
20020914:	4620      	mov	r0, r4
20020916:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
2002091a:	f7ff bf09 	b.w	20020730 <boot_psram_init>
2002091e:	2002      	movs	r0, #2
20020920:	f7ff fe4c 	bl	200205bc <board_pinmux_psram_func1_2_4>
20020924:	e7eb      	b.n	200208fe <board_init_psram+0x1e>
20020926:	2004      	movs	r0, #4
20020928:	e7fa      	b.n	20020920 <board_init_psram+0x40>
2002092a:	2001      	movs	r0, #1
2002092c:	e7f8      	b.n	20020920 <board_init_psram+0x40>
2002092e:	f7ff fdf8 	bl	20020522 <board_pinmux_psram_func0>
20020932:	e7e4      	b.n	200208fe <board_init_psram+0x1e>
20020934:	bd10      	pop	{r4, pc}
20020936:	bf00      	nop
20020938:	5000b000 	.word	0x5000b000

2002093c <erase_nor>:
2002093c:	4b15      	ldr	r3, [pc, #84]	@ (20020994 <erase_nor+0x58>)
2002093e:	b570      	push	{r4, r5, r6, lr}
20020940:	f103 0644 	add.w	r6, r3, #68	@ 0x44
20020944:	f1b0 5f90 	cmp.w	r0, #301989888	@ 0x12000000
20020948:	bf38      	it	cc
2002094a:	461e      	movcc	r6, r3
2002094c:	6933      	ldr	r3, [r6, #16]
2002094e:	460c      	mov	r4, r1
20020950:	4283      	cmp	r3, r0
20020952:	d901      	bls.n	20020958 <erase_nor+0x1c>
20020954:	2001      	movs	r0, #1
20020956:	bd70      	pop	{r4, r5, r6, pc}
20020958:	6972      	ldr	r2, [r6, #20]
2002095a:	441a      	add	r2, r3
2002095c:	4282      	cmp	r2, r0
2002095e:	d3f9      	bcc.n	20020954 <erase_nor+0x18>
20020960:	1ac0      	subs	r0, r0, r3
20020962:	f3c0 030b 	ubfx	r3, r0, #0, #12
20020966:	b97b      	cbnz	r3, 20020988 <erase_nor+0x4c>
20020968:	f3c1 030b 	ubfx	r3, r1, #0, #12
2002096c:	b97b      	cbnz	r3, 2002098e <erase_nor+0x52>
2002096e:	1845      	adds	r5, r0, r1
20020970:	1b29      	subs	r1, r5, r4
20020972:	b90c      	cbnz	r4, 20020978 <erase_nor+0x3c>
20020974:	4620      	mov	r0, r4
20020976:	e7ee      	b.n	20020956 <erase_nor+0x1a>
20020978:	4630      	mov	r0, r6
2002097a:	f003 fa37 	bl	20023dec <HAL_QSPIEX_SECT_ERASE>
2002097e:	2800      	cmp	r0, #0
20020980:	d1e8      	bne.n	20020954 <erase_nor+0x18>
20020982:	f5a4 5480 	sub.w	r4, r4, #4096	@ 0x1000
20020986:	e7f3      	b.n	20020970 <erase_nor+0x34>
20020988:	f04f 30ff 	mov.w	r0, #4294967295
2002098c:	e7e3      	b.n	20020956 <erase_nor+0x1a>
2002098e:	f06f 0001 	mvn.w	r0, #1
20020992:	e7e0      	b.n	20020956 <erase_nor+0x1a>
20020994:	20046ecc 	.word	0x20046ecc

20020998 <write_nor>:
20020998:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
2002099c:	4b20      	ldr	r3, [pc, #128]	@ (20020a20 <write_nor+0x88>)
2002099e:	460f      	mov	r7, r1
200209a0:	f103 0844 	add.w	r8, r3, #68	@ 0x44
200209a4:	f1b0 5f90 	cmp.w	r0, #301989888	@ 0x12000000
200209a8:	bf38      	it	cc
200209aa:	4698      	movcc	r8, r3
200209ac:	f8d8 5010 	ldr.w	r5, [r8, #16]
200209b0:	4616      	mov	r6, r2
200209b2:	4285      	cmp	r5, r0
200209b4:	d902      	bls.n	200209bc <write_nor+0x24>
200209b6:	2000      	movs	r0, #0
200209b8:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
200209bc:	f8d8 2014 	ldr.w	r2, [r8, #20]
200209c0:	442a      	add	r2, r5
200209c2:	4282      	cmp	r2, r0
200209c4:	d3f7      	bcc.n	200209b6 <write_nor+0x1e>
200209c6:	1b45      	subs	r5, r0, r5
200209c8:	f015 04ff 	ands.w	r4, r5, #255	@ 0xff
200209cc:	d012      	beq.n	200209f4 <write_nor+0x5c>
200209ce:	f5c4 7480 	rsb	r4, r4, #256	@ 0x100
200209d2:	42b4      	cmp	r4, r6
200209d4:	bf28      	it	cs
200209d6:	4634      	movcs	r4, r6
200209d8:	460a      	mov	r2, r1
200209da:	4623      	mov	r3, r4
200209dc:	4629      	mov	r1, r5
200209de:	4640      	mov	r0, r8
200209e0:	f003 f91f 	bl	20023c22 <HAL_QSPIEX_WRITE_PAGE>
200209e4:	4284      	cmp	r4, r0
200209e6:	d1e6      	bne.n	200209b6 <write_nor+0x1e>
200209e8:	4425      	add	r5, r4
200209ea:	4427      	add	r7, r4
200209ec:	1b34      	subs	r4, r6, r4
200209ee:	b91c      	cbnz	r4, 200209f8 <write_nor+0x60>
200209f0:	4630      	mov	r0, r6
200209f2:	e7e1      	b.n	200209b8 <write_nor+0x20>
200209f4:	4634      	mov	r4, r6
200209f6:	e7fa      	b.n	200209ee <write_nor+0x56>
200209f8:	f5b4 7f80 	cmp.w	r4, #256	@ 0x100
200209fc:	46a1      	mov	r9, r4
200209fe:	bf28      	it	cs
20020a00:	f44f 7980 	movcs.w	r9, #256	@ 0x100
20020a04:	463a      	mov	r2, r7
20020a06:	464b      	mov	r3, r9
20020a08:	4629      	mov	r1, r5
20020a0a:	4640      	mov	r0, r8
20020a0c:	f003 f909 	bl	20023c22 <HAL_QSPIEX_WRITE_PAGE>
20020a10:	4581      	cmp	r9, r0
20020a12:	d1d0      	bne.n	200209b6 <write_nor+0x1e>
20020a14:	444d      	add	r5, r9
20020a16:	444f      	add	r7, r9
20020a18:	eba4 0409 	sub.w	r4, r4, r9
20020a1c:	e7e7      	b.n	200209ee <write_nor+0x56>
20020a1e:	bf00      	nop
20020a20:	20046ecc 	.word	0x20046ecc

20020a24 <read_nor>:
20020a24:	460b      	mov	r3, r1
20020a26:	b510      	push	{r4, lr}
20020a28:	4614      	mov	r4, r2
20020a2a:	4601      	mov	r1, r0
20020a2c:	4618      	mov	r0, r3
20020a2e:	f009 ff2b 	bl	2002a888 <memcpy>
20020a32:	4620      	mov	r0, r4
20020a34:	bd10      	pop	{r4, pc}
	...

20020a38 <read_nand>:
20020a38:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20020a3c:	2600      	movs	r6, #0
20020a3e:	460f      	mov	r7, r1
20020a40:	4615      	mov	r5, r2
20020a42:	46b0      	mov	r8, r6
20020a44:	4b19      	ldr	r3, [pc, #100]	@ (20020aac <read_nand+0x74>)
20020a46:	f8df a068 	ldr.w	sl, [pc, #104]	@ 20020ab0 <read_nand+0x78>
20020a4a:	681b      	ldr	r3, [r3, #0]
20020a4c:	f8df b064 	ldr.w	fp, [pc, #100]	@ 20020ab4 <read_nand+0x7c>
20020a50:	691b      	ldr	r3, [r3, #16]
20020a52:	4604      	mov	r4, r0
20020a54:	4283      	cmp	r3, r0
20020a56:	b085      	sub	sp, #20
20020a58:	bf98      	it	ls
20020a5a:	1ac4      	subls	r4, r0, r3
20020a5c:	b91d      	cbnz	r5, 20020a66 <read_nand+0x2e>
20020a5e:	4630      	mov	r0, r6
20020a60:	b005      	add	sp, #20
20020a62:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20020a66:	f8da 1000 	ldr.w	r1, [sl]
20020a6a:	f8db 0000 	ldr.w	r0, [fp]
20020a6e:	42a9      	cmp	r1, r5
20020a70:	fbb0 fcf1 	udiv	ip, r0, r1
20020a74:	4689      	mov	r9, r1
20020a76:	f101 32ff 	add.w	r2, r1, #4294967295
20020a7a:	bf28      	it	cs
20020a7c:	46a9      	movcs	r9, r5
20020a7e:	fbb4 f1f1 	udiv	r1, r4, r1
20020a82:	f10c 3cff 	add.w	ip, ip, #4294967295
20020a86:	fbb4 f0f0 	udiv	r0, r4, r0
20020a8a:	e9cd 8801 	strd	r8, r8, [sp, #4]
20020a8e:	f8cd 9000 	str.w	r9, [sp]
20020a92:	19bb      	adds	r3, r7, r6
20020a94:	4022      	ands	r2, r4
20020a96:	ea0c 0101 	and.w	r1, ip, r1
20020a9a:	f004 fee3 	bl	20025864 <bbm_read_page>
20020a9e:	4548      	cmp	r0, r9
20020aa0:	d1dd      	bne.n	20020a5e <read_nand+0x26>
20020aa2:	4406      	add	r6, r0
20020aa4:	1a2d      	subs	r5, r5, r0
20020aa6:	4404      	add	r4, r0
20020aa8:	e7d8      	b.n	20020a5c <read_nand+0x24>
20020aaa:	bf00      	nop
20020aac:	20046cb4 	.word	0x20046cb4
20020ab0:	20042c04 	.word	0x20042c04
20020ab4:	20042c00 	.word	0x20042c00

20020ab8 <read_sdnand>:
20020ab8:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
20020abc:	f100 461e 	add.w	r6, r0, #2650800128	@ 0x9e000000
20020ac0:	460d      	mov	r5, r1
20020ac2:	4614      	mov	r4, r2
20020ac4:	4617      	mov	r7, r2
20020ac6:	46b0      	mov	r8, r6
20020ac8:	eb02 0901 	add.w	r9, r2, r1
20020acc:	f5b7 7f00 	cmp.w	r7, #512	@ 0x200
20020ad0:	eba9 0107 	sub.w	r1, r9, r7
20020ad4:	d218      	bcs.n	20020b08 <read_sdnand+0x50>
20020ad6:	f3c4 0708 	ubfx	r7, r4, #0, #9
20020ada:	b197      	cbz	r7, 20020b02 <read_sdnand+0x4a>
20020adc:	f424 70ff 	bic.w	r0, r4, #510	@ 0x1fe
20020ae0:	f020 0001 	bic.w	r0, r0, #1
20020ae4:	f44f 7200 	mov.w	r2, #512	@ 0x200
20020ae8:	490c      	ldr	r1, [pc, #48]	@ (20020b1c <read_sdnand+0x64>)
20020aea:	4430      	add	r0, r6
20020aec:	f001 f80a 	bl	20021b04 <sd_read_data>
20020af0:	f424 70ff 	bic.w	r0, r4, #510	@ 0x1fe
20020af4:	f020 0001 	bic.w	r0, r0, #1
20020af8:	463a      	mov	r2, r7
20020afa:	4908      	ldr	r1, [pc, #32]	@ (20020b1c <read_sdnand+0x64>)
20020afc:	4428      	add	r0, r5
20020afe:	f009 fec3 	bl	2002a888 <memcpy>
20020b02:	4620      	mov	r0, r4
20020b04:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
20020b08:	4640      	mov	r0, r8
20020b0a:	f44f 7200 	mov.w	r2, #512	@ 0x200
20020b0e:	f000 fff9 	bl	20021b04 <sd_read_data>
20020b12:	f5a7 7700 	sub.w	r7, r7, #512	@ 0x200
20020b16:	f508 7800 	add.w	r8, r8, #512	@ 0x200
20020b1a:	e7d7      	b.n	20020acc <read_sdnand+0x14>
20020b1c:	20046ab0 	.word	0x20046ab0

20020b20 <read_sdemmc>:
20020b20:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
20020b24:	f100 461e 	add.w	r6, r0, #2650800128	@ 0x9e000000
20020b28:	460d      	mov	r5, r1
20020b2a:	4614      	mov	r4, r2
20020b2c:	4617      	mov	r7, r2
20020b2e:	46b0      	mov	r8, r6
20020b30:	eb02 0901 	add.w	r9, r2, r1
20020b34:	f5b7 7f00 	cmp.w	r7, #512	@ 0x200
20020b38:	eba9 0107 	sub.w	r1, r9, r7
20020b3c:	d218      	bcs.n	20020b70 <read_sdemmc+0x50>
20020b3e:	f3c4 0708 	ubfx	r7, r4, #0, #9
20020b42:	b197      	cbz	r7, 20020b6a <read_sdemmc+0x4a>
20020b44:	f424 70ff 	bic.w	r0, r4, #510	@ 0x1fe
20020b48:	f020 0001 	bic.w	r0, r0, #1
20020b4c:	f44f 7200 	mov.w	r2, #512	@ 0x200
20020b50:	490c      	ldr	r1, [pc, #48]	@ (20020b84 <read_sdemmc+0x64>)
20020b52:	4430      	add	r0, r6
20020b54:	f000 fdc0 	bl	200216d8 <emmc_read_data>
20020b58:	f424 70ff 	bic.w	r0, r4, #510	@ 0x1fe
20020b5c:	f020 0001 	bic.w	r0, r0, #1
20020b60:	463a      	mov	r2, r7
20020b62:	4908      	ldr	r1, [pc, #32]	@ (20020b84 <read_sdemmc+0x64>)
20020b64:	4428      	add	r0, r5
20020b66:	f009 fe8f 	bl	2002a888 <memcpy>
20020b6a:	4620      	mov	r0, r4
20020b6c:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
20020b70:	4640      	mov	r0, r8
20020b72:	f44f 7200 	mov.w	r2, #512	@ 0x200
20020b76:	f000 fdaf 	bl	200216d8 <emmc_read_data>
20020b7a:	f5a7 7700 	sub.w	r7, r7, #512	@ 0x200
20020b7e:	f508 7800 	add.w	r8, r8, #512	@ 0x200
20020b82:	e7d7      	b.n	20020b34 <read_sdemmc+0x14>
20020b84:	20046ab0 	.word	0x20046ab0

20020b88 <port_read_page>:
20020b88:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20020b8c:	4615      	mov	r5, r2
20020b8e:	f8df 90e8 	ldr.w	r9, [pc, #232]	@ 20020c78 <port_read_page+0xf0>
20020b92:	460e      	mov	r6, r1
20020b94:	f8d9 7000 	ldr.w	r7, [r9]
20020b98:	461a      	mov	r2, r3
20020b9a:	e9dd 3c09 	ldrd	r3, ip, [sp, #36]	@ 0x24
20020b9e:	18e9      	adds	r1, r5, r3
20020ba0:	428f      	cmp	r7, r1
20020ba2:	f8dd e02c 	ldr.w	lr, [sp, #44]	@ 0x2c
20020ba6:	d200      	bcs.n	20020baa <port_read_page+0x22>
20020ba8:	e7fe      	b.n	20020ba8 <port_read_page+0x20>
20020baa:	4930      	ldr	r1, [pc, #192]	@ (20020c6c <port_read_page+0xe4>)
20020bac:	2b00      	cmp	r3, #0
20020bae:	6809      	ldr	r1, [r1, #0]
20020bb0:	dd15      	ble.n	20020bde <port_read_page+0x56>
20020bb2:	f002 041f 	and.w	r4, r2, #31
20020bb6:	441c      	add	r4, r3
20020bb8:	f3bf 8f4f 	dsb	sy
20020bbc:	4690      	mov	r8, r2
20020bbe:	f8df a0bc 	ldr.w	sl, [pc, #188]	@ 20020c7c <port_read_page+0xf4>
20020bc2:	4414      	add	r4, r2
20020bc4:	f8ca 825c 	str.w	r8, [sl, #604]	@ 0x25c
20020bc8:	f108 0820 	add.w	r8, r8, #32
20020bcc:	eba4 0b08 	sub.w	fp, r4, r8
20020bd0:	f1bb 0f00 	cmp.w	fp, #0
20020bd4:	dcf6      	bgt.n	20020bc4 <port_read_page+0x3c>
20020bd6:	f3bf 8f4f 	dsb	sy
20020bda:	f3bf 8f6f 	isb	sy
20020bde:	f8d9 4000 	ldr.w	r4, [r9]
20020be2:	f104 0980 	add.w	r9, r4, #128	@ 0x80
20020be6:	f1b9 0f00 	cmp.w	r9, #0
20020bea:	dd15      	ble.n	20020c18 <port_read_page+0x90>
20020bec:	4c20      	ldr	r4, [pc, #128]	@ (20020c70 <port_read_page+0xe8>)
20020bee:	6d64      	ldr	r4, [r4, #84]	@ 0x54
20020bf0:	f004 081f 	and.w	r8, r4, #31
20020bf4:	44c8      	add	r8, r9
20020bf6:	f3bf 8f4f 	dsb	sy
20020bfa:	f8df a080 	ldr.w	sl, [pc, #128]	@ 20020c7c <port_read_page+0xf4>
20020bfe:	44a0      	add	r8, r4
20020c00:	f8ca 425c 	str.w	r4, [sl, #604]	@ 0x25c
20020c04:	3420      	adds	r4, #32
20020c06:	eba8 0904 	sub.w	r9, r8, r4
20020c0a:	f1b9 0f00 	cmp.w	r9, #0
20020c0e:	dcf7      	bgt.n	20020c00 <port_read_page+0x78>
20020c10:	f3bf 8f4f 	dsb	sy
20020c14:	f3bf 8f6f 	isb	sy
20020c18:	07c4      	lsls	r4, r0, #31
20020c1a:	d51b      	bpl.n	20020c54 <port_read_page+0xcc>
20020c1c:	4c14      	ldr	r4, [pc, #80]	@ (20020c70 <port_read_page+0xe8>)
20020c1e:	f894 806b 	ldrb.w	r8, [r4, #107]	@ 0x6b
20020c22:	f1b8 0f00 	cmp.w	r8, #0
20020c26:	d015      	beq.n	20020c54 <port_read_page+0xcc>
20020c28:	6d64      	ldr	r4, [r4, #84]	@ 0x54
20020c2a:	f504 5880 	add.w	r8, r4, #4096	@ 0x1000
20020c2e:	f004 041f 	and.w	r4, r4, #31
20020c32:	f504 6408 	add.w	r4, r4, #2176	@ 0x880
20020c36:	f3bf 8f4f 	dsb	sy
20020c3a:	f8df 9040 	ldr.w	r9, [pc, #64]	@ 20020c7c <port_read_page+0xf4>
20020c3e:	3c20      	subs	r4, #32
20020c40:	2c00      	cmp	r4, #0
20020c42:	f8c9 825c 	str.w	r8, [r9, #604]	@ 0x25c
20020c46:	f108 0820 	add.w	r8, r8, #32
20020c4a:	dcf8      	bgt.n	20020c3e <port_read_page+0xb6>
20020c4c:	f3bf 8f4f 	dsb	sy
20020c50:	f3bf 8f6f 	isb	sy
20020c54:	fb07 5506 	mla	r5, r7, r6, r5
20020c58:	e9cd ce09 	strd	ip, lr, [sp, #36]	@ 0x24
20020c5c:	fb01 5100 	mla	r1, r1, r0, r5
20020c60:	e8bd 4ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20020c64:	4803      	ldr	r0, [pc, #12]	@ (20020c74 <port_read_page+0xec>)
20020c66:	f002 bebb 	b.w	200239e0 <HAL_NAND_READ_WITHOOB>
20020c6a:	bf00      	nop
20020c6c:	20042c00 	.word	0x20042c00
20020c70:	20046ecc 	.word	0x20046ecc
20020c74:	20046f10 	.word	0x20046f10
20020c78:	20042c04 	.word	0x20042c04
20020c7c:	e000ed00 	.word	0xe000ed00

20020c80 <bbm_get_bb>:
20020c80:	b410      	push	{r4}
20020c82:	4b1c      	ldr	r3, [pc, #112]	@ (20020cf4 <bbm_get_bb+0x74>)
20020c84:	4601      	mov	r1, r0
20020c86:	6818      	ldr	r0, [r3, #0]
20020c88:	3080      	adds	r0, #128	@ 0x80
20020c8a:	2800      	cmp	r0, #0
20020c8c:	dd12      	ble.n	20020cb4 <bbm_get_bb+0x34>
20020c8e:	4b1a      	ldr	r3, [pc, #104]	@ (20020cf8 <bbm_get_bb+0x78>)
20020c90:	6d5b      	ldr	r3, [r3, #84]	@ 0x54
20020c92:	f003 021f 	and.w	r2, r3, #31
20020c96:	4402      	add	r2, r0
20020c98:	f3bf 8f4f 	dsb	sy
20020c9c:	4c17      	ldr	r4, [pc, #92]	@ (20020cfc <bbm_get_bb+0x7c>)
20020c9e:	441a      	add	r2, r3
20020ca0:	f8c4 325c 	str.w	r3, [r4, #604]	@ 0x25c
20020ca4:	3320      	adds	r3, #32
20020ca6:	1ad0      	subs	r0, r2, r3
20020ca8:	2800      	cmp	r0, #0
20020caa:	dcf9      	bgt.n	20020ca0 <bbm_get_bb+0x20>
20020cac:	f3bf 8f4f 	dsb	sy
20020cb0:	f3bf 8f6f 	isb	sy
20020cb4:	07cb      	lsls	r3, r1, #31
20020cb6:	d518      	bpl.n	20020cea <bbm_get_bb+0x6a>
20020cb8:	4b0f      	ldr	r3, [pc, #60]	@ (20020cf8 <bbm_get_bb+0x78>)
20020cba:	f893 206b 	ldrb.w	r2, [r3, #107]	@ 0x6b
20020cbe:	b1a2      	cbz	r2, 20020cea <bbm_get_bb+0x6a>
20020cc0:	6d5b      	ldr	r3, [r3, #84]	@ 0x54
20020cc2:	f503 5280 	add.w	r2, r3, #4096	@ 0x1000
20020cc6:	f003 031f 	and.w	r3, r3, #31
20020cca:	f503 6308 	add.w	r3, r3, #2176	@ 0x880
20020cce:	f3bf 8f4f 	dsb	sy
20020cd2:	480a      	ldr	r0, [pc, #40]	@ (20020cfc <bbm_get_bb+0x7c>)
20020cd4:	3b20      	subs	r3, #32
20020cd6:	2b00      	cmp	r3, #0
20020cd8:	f8c0 225c 	str.w	r2, [r0, #604]	@ 0x25c
20020cdc:	f102 0220 	add.w	r2, r2, #32
20020ce0:	dcf8      	bgt.n	20020cd4 <bbm_get_bb+0x54>
20020ce2:	f3bf 8f4f 	dsb	sy
20020ce6:	f3bf 8f6f 	isb	sy
20020cea:	4805      	ldr	r0, [pc, #20]	@ (20020d00 <bbm_get_bb+0x80>)
20020cec:	f85d 4b04 	ldr.w	r4, [sp], #4
20020cf0:	f002 bf76 	b.w	20023be0 <HAL_NAND_GET_BADBLK>
20020cf4:	20042c04 	.word	0x20042c04
20020cf8:	20046ecc 	.word	0x20046ecc
20020cfc:	e000ed00 	.word	0xe000ed00
20020d00:	20046f10 	.word	0x20046f10

20020d04 <dfu_flash_init>:
20020d04:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20020d08:	b08c      	sub	sp, #48	@ 0x30
20020d0a:	f001 ff0b 	bl	20022b24 <HAL_HPAON_EnableXT48>
20020d0e:	2101      	movs	r1, #1
20020d10:	2000      	movs	r0, #0
20020d12:	f004 f991 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20020d16:	2101      	movs	r1, #1
20020d18:	200c      	movs	r0, #12
20020d1a:	f004 f98d 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20020d1e:	2001      	movs	r0, #1
20020d20:	f004 f888 	bl	20024e34 <HAL_PMU_EnableDLL>
20020d24:	4f97      	ldr	r7, [pc, #604]	@ (20020f84 <dfu_flash_init+0x280>)
20020d26:	2090      	movs	r0, #144	@ 0x90
20020d28:	f004 fae8 	bl	200252fc <HAL_RCC_HCPU_ConfigHCLK>
20020d2c:	2000      	movs	r0, #0
20020d2e:	f001 f8e4 	bl	20021efa <HAL_Delay_us>
20020d32:	683b      	ldr	r3, [r7, #0]
20020d34:	4d94      	ldr	r5, [pc, #592]	@ (20020f88 <dfu_flash_init+0x284>)
20020d36:	3b01      	subs	r3, #1
20020d38:	2b05      	cmp	r3, #5
20020d3a:	f200 8113 	bhi.w	20020f64 <dfu_flash_init+0x260>
20020d3e:	e8df f013 	tbh	[pc, r3, lsl #1]
20020d42:	0006      	.short	0x0006
20020d44:	00780006 	.word	0x00780006
20020d48:	00ee0078 	.word	0x00ee0078
20020d4c:	0102      	.short	0x0102
20020d4e:	488f      	ldr	r0, [pc, #572]	@ (20020f8c <dfu_flash_init+0x288>)
20020d50:	f004 f93a 	bl	20024fc8 <HAL_RCC_HCPU_EnableDLL2>
20020d54:	4c8e      	ldr	r4, [pc, #568]	@ (20020f90 <dfu_flash_init+0x28c>)
20020d56:	2006      	movs	r0, #6
20020d58:	f000 fffc 	bl	20021d54 <BSP_SetFlash1DIV>
20020d5c:	ae07      	add	r6, sp, #28
20020d5e:	2102      	movs	r1, #2
20020d60:	2004      	movs	r0, #4
20020d62:	f004 f969 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20020d66:	cc0f      	ldmia	r4!, {r0, r1, r2, r3}
20020d68:	c60f      	stmia	r6!, {r0, r1, r2, r3}
20020d6a:	f854 3b04 	ldr.w	r3, [r4], #4
20020d6e:	6033      	str	r3, [r6, #0]
20020d70:	ae03      	add	r6, sp, #12
20020d72:	e894 000f 	ldmia.w	r4, {r0, r1, r2, r3}
20020d76:	e886 000f 	stmia.w	r6, {r0, r1, r2, r3}
20020d7a:	2301      	movs	r3, #1
20020d7c:	4c85      	ldr	r4, [pc, #532]	@ (20020f94 <dfu_flash_init+0x290>)
20020d7e:	f884 3035 	strb.w	r3, [r4, #53]	@ 0x35
20020d82:	2300      	movs	r3, #0
20020d84:	9308      	str	r3, [sp, #32]
20020d86:	683b      	ldr	r3, [r7, #0]
20020d88:	2b01      	cmp	r3, #1
20020d8a:	d14d      	bne.n	20020e28 <dfu_flash_init+0x124>
20020d8c:	f7ff fac0 	bl	20020310 <board_pinmux_mpi1_puya_base>
20020d90:	f000 ffd4 	bl	20021d3c <BSP_GetFlash1DIV>
20020d94:	4633      	mov	r3, r6
20020d96:	9000      	str	r0, [sp, #0]
20020d98:	4a7f      	ldr	r2, [pc, #508]	@ (20020f98 <dfu_flash_init+0x294>)
20020d9a:	487e      	ldr	r0, [pc, #504]	@ (20020f94 <dfu_flash_init+0x290>)
20020d9c:	a907      	add	r1, sp, #28
20020d9e:	f003 f8f7 	bl	20023f90 <HAL_FLASH_Init>
20020da2:	683e      	ldr	r6, [r7, #0]
20020da4:	2e01      	cmp	r6, #1
20020da6:	d10d      	bne.n	20020dc4 <dfu_flash_init+0xc0>
20020da8:	6b20      	ldr	r0, [r4, #48]	@ 0x30
20020daa:	4b7c      	ldr	r3, [pc, #496]	@ (20020f9c <dfu_flash_init+0x298>)
20020dac:	1ac3      	subs	r3, r0, r3
20020dae:	4258      	negs	r0, r3
20020db0:	4158      	adcs	r0, r3
20020db2:	f7ff face 	bl	20020352 <board_pinmux_mpi1_puya_ext>
20020db6:	4631      	mov	r1, r6
20020db8:	4876      	ldr	r0, [pc, #472]	@ (20020f94 <dfu_flash_init+0x290>)
20020dba:	f002 fb1e 	bl	200233fa <HAL_FLASH_SET_QUAL_SPI>
20020dbe:	2302      	movs	r3, #2
20020dc0:	f884 3020 	strb.w	r3, [r4, #32]
20020dc4:	4b76      	ldr	r3, [pc, #472]	@ (20020fa0 <dfu_flash_init+0x29c>)
20020dc6:	4a77      	ldr	r2, [pc, #476]	@ (20020fa4 <dfu_flash_init+0x2a0>)
20020dc8:	602b      	str	r3, [r5, #0]
20020dca:	4b77      	ldr	r3, [pc, #476]	@ (20020fa8 <dfu_flash_init+0x2a4>)
20020dcc:	601a      	str	r2, [r3, #0]
20020dce:	4b77      	ldr	r3, [pc, #476]	@ (20020fac <dfu_flash_init+0x2a8>)
20020dd0:	4a77      	ldr	r2, [pc, #476]	@ (20020fb0 <dfu_flash_init+0x2ac>)
20020dd2:	601a      	str	r2, [r3, #0]
20020dd4:	4b77      	ldr	r3, [pc, #476]	@ (20020fb4 <dfu_flash_init+0x2b0>)
20020dd6:	6ba2      	ldr	r2, [r4, #56]	@ 0x38
20020dd8:	601a      	str	r2, [r3, #0]
20020dda:	4b77      	ldr	r3, [pc, #476]	@ (20020fb8 <dfu_flash_init+0x2b4>)
20020ddc:	601c      	str	r4, [r3, #0]
20020dde:	2405      	movs	r4, #5
20020de0:	f8df 81d8 	ldr.w	r8, [pc, #472]	@ 20020fbc <dfu_flash_init+0x2b8>
20020de4:	4e73      	ldr	r6, [pc, #460]	@ (20020fb4 <dfu_flash_init+0x2b0>)
20020de6:	f8df 9208 	ldr.w	r9, [pc, #520]	@ 20020ff0 <dfu_flash_init+0x2ec>
20020dea:	682b      	ldr	r3, [r5, #0]
20020dec:	f642 4210 	movw	r2, #11280	@ 0x2c10
20020df0:	4972      	ldr	r1, [pc, #456]	@ (20020fbc <dfu_flash_init+0x2b8>)
20020df2:	6830      	ldr	r0, [r6, #0]
20020df4:	4798      	blx	r3
20020df6:	f8d8 3000 	ldr.w	r3, [r8]
20020dfa:	454b      	cmp	r3, r9
20020dfc:	f040 80b6 	bne.w	20020f6c <dfu_flash_init+0x268>
20020e00:	683b      	ldr	r3, [r7, #0]
20020e02:	2b04      	cmp	r3, #4
20020e04:	f040 8085 	bne.w	20020f12 <dfu_flash_init+0x20e>
20020e08:	f8d8 30a4 	ldr.w	r3, [r8, #164]	@ 0xa4
20020e0c:	1e5a      	subs	r2, r3, #1
20020e0e:	3203      	adds	r2, #3
20020e10:	d87f      	bhi.n	20020f12 <dfu_flash_init+0x20e>
20020e12:	4a6b      	ldr	r2, [pc, #428]	@ (20020fc0 <dfu_flash_init+0x2bc>)
20020e14:	4969      	ldr	r1, [pc, #420]	@ (20020fbc <dfu_flash_init+0x2b8>)
20020e16:	6013      	str	r3, [r2, #0]
20020e18:	f642 4210 	movw	r2, #11280	@ 0x2c10
20020e1c:	682b      	ldr	r3, [r5, #0]
20020e1e:	6830      	ldr	r0, [r6, #0]
20020e20:	b00c      	add	sp, #48	@ 0x30
20020e22:	e8bd 47f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20020e26:	4718      	bx	r3
20020e28:	f7ff fac2 	bl	200203b0 <board_pinmux_mpi1_gd>
20020e2c:	2302      	movs	r3, #2
20020e2e:	9308      	str	r3, [sp, #32]
20020e30:	e7ae      	b.n	20020d90 <dfu_flash_init+0x8c>
20020e32:	4856      	ldr	r0, [pc, #344]	@ (20020f8c <dfu_flash_init+0x288>)
20020e34:	f004 f8c8 	bl	20024fc8 <HAL_RCC_HCPU_EnableDLL2>
20020e38:	4c62      	ldr	r4, [pc, #392]	@ (20020fc4 <dfu_flash_init+0x2c0>)
20020e3a:	2006      	movs	r0, #6
20020e3c:	f000 ff90 	bl	20021d60 <BSP_SetFlash2DIV>
20020e40:	ae07      	add	r6, sp, #28
20020e42:	2102      	movs	r1, #2
20020e44:	2006      	movs	r0, #6
20020e46:	f004 f8f7 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20020e4a:	cc0f      	ldmia	r4!, {r0, r1, r2, r3}
20020e4c:	c60f      	stmia	r6!, {r0, r1, r2, r3}
20020e4e:	f854 3b04 	ldr.w	r3, [r4], #4
20020e52:	f8d7 8000 	ldr.w	r8, [r7]
20020e56:	6033      	str	r3, [r6, #0]
20020e58:	ae03      	add	r6, sp, #12
20020e5a:	e894 000f 	ldmia.w	r4, {r0, r1, r2, r3}
20020e5e:	f1b8 0903 	subs.w	r9, r8, #3
20020e62:	e886 000f 	stmia.w	r6, {r0, r1, r2, r3}
20020e66:	bf18      	it	ne
20020e68:	f04f 0901 	movne.w	r9, #1
20020e6c:	f7ff fae3 	bl	20020436 <board_pinmux_mpi2>
20020e70:	2302      	movs	r3, #2
20020e72:	f1b8 0f03 	cmp.w	r8, #3
20020e76:	4c47      	ldr	r4, [pc, #284]	@ (20020f94 <dfu_flash_init+0x290>)
20020e78:	9308      	str	r3, [sp, #32]
20020e7a:	d04d      	beq.n	20020f18 <dfu_flash_init+0x214>
20020e7c:	4b52      	ldr	r3, [pc, #328]	@ (20020fc8 <dfu_flash_init+0x2c4>)
20020e7e:	602b      	str	r3, [r5, #0]
20020e80:	9b09      	ldr	r3, [sp, #36]	@ 0x24
20020e82:	f103 43a0 	add.w	r3, r3, #1342177280	@ 0x50000000
20020e86:	9309      	str	r3, [sp, #36]	@ 0x24
20020e88:	2301      	movs	r3, #1
20020e8a:	930b      	str	r3, [sp, #44]	@ 0x2c
20020e8c:	4b4f      	ldr	r3, [pc, #316]	@ (20020fcc <dfu_flash_init+0x2c8>)
20020e8e:	6623      	str	r3, [r4, #96]	@ 0x60
20020e90:	f04f 0a01 	mov.w	sl, #1
20020e94:	2000      	movs	r0, #0
20020e96:	f001 f830 	bl	20021efa <HAL_Delay_us>
20020e9a:	f884 a079 	strb.w	sl, [r4, #121]	@ 0x79
20020e9e:	f884 9078 	strb.w	r9, [r4, #120]	@ 0x78
20020ea2:	f000 ff51 	bl	20021d48 <BSP_GetFlash2DIV>
20020ea6:	4633      	mov	r3, r6
20020ea8:	9000      	str	r0, [sp, #0]
20020eaa:	4a49      	ldr	r2, [pc, #292]	@ (20020fd0 <dfu_flash_init+0x2cc>)
20020eac:	4849      	ldr	r0, [pc, #292]	@ (20020fd4 <dfu_flash_init+0x2d0>)
20020eae:	a907      	add	r1, sp, #28
20020eb0:	f003 f86e 	bl	20023f90 <HAL_FLASH_Init>
20020eb4:	4e47      	ldr	r6, [pc, #284]	@ (20020fd4 <dfu_flash_init+0x2d0>)
20020eb6:	bb18      	cbnz	r0, 20020f00 <dfu_flash_init+0x1fc>
20020eb8:	f1b8 0f03 	cmp.w	r8, #3
20020ebc:	d020      	beq.n	20020f00 <dfu_flash_init+0x1fc>
20020ebe:	4630      	mov	r0, r6
20020ec0:	f002 fd82 	bl	200239c8 <HAL_NAND_PAGE_SIZE>
20020ec4:	f8df 90f8 	ldr.w	r9, [pc, #248]	@ 20020fc0 <dfu_flash_init+0x2bc>
20020ec8:	f8df 8128 	ldr.w	r8, [pc, #296]	@ 20020ff4 <dfu_flash_init+0x2f0>
20020ecc:	f8c9 0000 	str.w	r0, [r9]
20020ed0:	4630      	mov	r0, r6
20020ed2:	f002 fe79 	bl	20023bc8 <HAL_NAND_BLOCK_SIZE>
20020ed6:	4651      	mov	r1, sl
20020ed8:	f8c8 0000 	str.w	r0, [r8]
20020edc:	4630      	mov	r0, r6
20020ede:	f884 a06a 	strb.w	sl, [r4, #106]	@ 0x6a
20020ee2:	f002 fc4a 	bl	2002377a <HAL_NAND_CONF_ECC>
20020ee6:	f8d9 0000 	ldr.w	r0, [r9]
20020eea:	f004 ffa3 	bl	20025e34 <bbm_set_page_size>
20020eee:	f8d8 0000 	ldr.w	r0, [r8]
20020ef2:	f004 ffa5 	bl	20025e40 <bbm_set_blk_size>
20020ef6:	4938      	ldr	r1, [pc, #224]	@ (20020fd8 <dfu_flash_init+0x2d4>)
20020ef8:	f8d4 0080 	ldr.w	r0, [r4, #128]	@ 0x80
20020efc:	f004 fe3c 	bl	20025b78 <sif_bbm_init>
20020f00:	4b2c      	ldr	r3, [pc, #176]	@ (20020fb4 <dfu_flash_init+0x2b0>)
20020f02:	6fe2      	ldr	r2, [r4, #124]	@ 0x7c
20020f04:	601a      	str	r2, [r3, #0]
20020f06:	4b2c      	ldr	r3, [pc, #176]	@ (20020fb8 <dfu_flash_init+0x2b4>)
20020f08:	601e      	str	r6, [r3, #0]
20020f0a:	682b      	ldr	r3, [r5, #0]
20020f0c:	2b00      	cmp	r3, #0
20020f0e:	f47f af66 	bne.w	20020dde <dfu_flash_init+0xda>
20020f12:	b00c      	add	sp, #48	@ 0x30
20020f14:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
20020f18:	4b21      	ldr	r3, [pc, #132]	@ (20020fa0 <dfu_flash_init+0x29c>)
20020f1a:	602b      	str	r3, [r5, #0]
20020f1c:	e7b8      	b.n	20020e90 <dfu_flash_init+0x18c>
20020f1e:	481b      	ldr	r0, [pc, #108]	@ (20020f8c <dfu_flash_init+0x288>)
20020f20:	f004 f852 	bl	20024fc8 <HAL_RCC_HCPU_EnableDLL2>
20020f24:	f7ff faae 	bl	20020484 <board_pinmux_sd>
20020f28:	f000 fcc0 	bl	200218ac <sdmmc1_sdnand>
20020f2c:	2801      	cmp	r0, #1
20020f2e:	d001      	beq.n	20020f34 <dfu_flash_init+0x230>
20020f30:	f7ff f9be 	bl	200202b0 <boot_error>
20020f34:	4b29      	ldr	r3, [pc, #164]	@ (20020fdc <dfu_flash_init+0x2d8>)
20020f36:	4a2a      	ldr	r2, [pc, #168]	@ (20020fe0 <dfu_flash_init+0x2dc>)
20020f38:	602b      	str	r3, [r5, #0]
20020f3a:	4b1e      	ldr	r3, [pc, #120]	@ (20020fb4 <dfu_flash_init+0x2b0>)
20020f3c:	601a      	str	r2, [r3, #0]
20020f3e:	2200      	movs	r2, #0
20020f40:	4b1d      	ldr	r3, [pc, #116]	@ (20020fb8 <dfu_flash_init+0x2b4>)
20020f42:	601a      	str	r2, [r3, #0]
20020f44:	e74b      	b.n	20020dde <dfu_flash_init+0xda>
20020f46:	4811      	ldr	r0, [pc, #68]	@ (20020f8c <dfu_flash_init+0x288>)
20020f48:	f004 f83e 	bl	20024fc8 <HAL_RCC_HCPU_EnableDLL2>
20020f4c:	f7ff fa9a 	bl	20020484 <board_pinmux_sd>
20020f50:	f000 fa9c 	bl	2002148c <sdio_emmc_init>
20020f54:	4b23      	ldr	r3, [pc, #140]	@ (20020fe4 <dfu_flash_init+0x2e0>)
20020f56:	6018      	str	r0, [r3, #0]
20020f58:	b110      	cbz	r0, 20020f60 <dfu_flash_init+0x25c>
20020f5a:	b2c0      	uxtb	r0, r0
20020f5c:	f7ff f9a8 	bl	200202b0 <boot_error>
20020f60:	4b21      	ldr	r3, [pc, #132]	@ (20020fe8 <dfu_flash_init+0x2e4>)
20020f62:	e7e8      	b.n	20020f36 <dfu_flash_init+0x232>
20020f64:	2053      	movs	r0, #83	@ 0x53
20020f66:	f7ff f9a3 	bl	200202b0 <boot_error>
20020f6a:	e7ce      	b.n	20020f0a <dfu_flash_init+0x206>
20020f6c:	481f      	ldr	r0, [pc, #124]	@ (20020fec <dfu_flash_init+0x2e8>)
20020f6e:	f000 ffc4 	bl	20021efa <HAL_Delay_us>
20020f72:	3c01      	subs	r4, #1
20020f74:	f47f af39 	bne.w	20020dea <dfu_flash_init+0xe6>
20020f78:	2043      	movs	r0, #67	@ 0x43
20020f7a:	b00c      	add	sp, #48	@ 0x30
20020f7c:	e8bd 47f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20020f80:	f7ff b996 	b.w	200202b0 <boot_error>
20020f84:	20049ed0 	.word	0x20049ed0
20020f88:	20046cc0 	.word	0x20046cc0
20020f8c:	112a8800 	.word	0x112a8800
20020f90:	2002a958 	.word	0x2002a958
20020f94:	20046ecc 	.word	0x20046ecc
20020f98:	20046cc4 	.word	0x20046cc4
20020f9c:	00176085 	.word	0x00176085
20020fa0:	20020a25 	.word	0x20020a25
20020fa4:	20020999 	.word	0x20020999
20020fa8:	20046cbc 	.word	0x20046cbc
20020fac:	20046cb8 	.word	0x20046cb8
20020fb0:	2002093d 	.word	0x2002093d
20020fb4:	20046cb0 	.word	0x20046cb0
20020fb8:	20046cb4 	.word	0x20046cb4
20020fbc:	200472c0 	.word	0x200472c0
20020fc0:	20042c04 	.word	0x20042c04
20020fc4:	2002a97c 	.word	0x2002a97c
20020fc8:	20020a39 	.word	0x20020a39
20020fcc:	20045a30 	.word	0x20045a30
20020fd0:	20046d2c 	.word	0x20046d2c
20020fd4:	20046f10 	.word	0x20046f10
20020fd8:	200449b0 	.word	0x200449b0
20020fdc:	20020ab9 	.word	0x20020ab9
20020fe0:	62001000 	.word	0x62001000
20020fe4:	200449ac 	.word	0x200449ac
20020fe8:	20020b21 	.word	0x20020b21
20020fec:	000f4240 	.word	0x000f4240
20020ff0:	53454346 	.word	0x53454346
20020ff4:	20042c00 	.word	0x20042c00

20020ff8 <sifli_hw_efuse_read_bank>:
20020ff8:	2803      	cmp	r0, #3
20020ffa:	b508      	push	{r3, lr}
20020ffc:	d80c      	bhi.n	20021018 <sifli_hw_efuse_read_bank+0x20>
20020ffe:	0200      	lsls	r0, r0, #8
20021000:	2220      	movs	r2, #32
20021002:	4907      	ldr	r1, [pc, #28]	@ (20021020 <sifli_hw_efuse_read_bank+0x28>)
20021004:	f400 407f 	and.w	r0, r0, #65280	@ 0xff00
20021008:	f001 fc50 	bl	200228ac <HAL_EFUSE_Read>
2002100c:	2800      	cmp	r0, #0
2002100e:	bf0c      	ite	eq
20021010:	f06f 0001 	mvneq.w	r0, #1
20021014:	2000      	movne	r0, #0
20021016:	bd08      	pop	{r3, pc}
20021018:	f04f 30ff 	mov.w	r0, #4294967295
2002101c:	e7fb      	b.n	20021016 <sifli_hw_efuse_read_bank+0x1e>
2002101e:	bf00      	nop
20021020:	20047240 	.word	0x20047240

20021024 <sifli_hw_efuse_read>:
20021024:	b513      	push	{r0, r1, r4, lr}
20021026:	3801      	subs	r0, #1
20021028:	460c      	mov	r4, r1
2002102a:	2803      	cmp	r0, #3
2002102c:	d81e      	bhi.n	2002106c <sifli_hw_efuse_read+0x48>
2002102e:	e8df f000 	tbb	[pc, r0]
20021032:	0c02      	.short	0x0c02
20021034:	1009      	.short	0x1009
20021036:	2210      	movs	r2, #16
20021038:	2000      	movs	r0, #0
2002103a:	b002      	add	sp, #8
2002103c:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20021040:	f001 bc34 	b.w	200228ac <HAL_EFUSE_Read>
20021044:	2208      	movs	r2, #8
20021046:	2080      	movs	r0, #128	@ 0x80
20021048:	e7f7      	b.n	2002103a <sifli_hw_efuse_read+0x16>
2002104a:	2220      	movs	r2, #32
2002104c:	f44f 7040 	mov.w	r0, #768	@ 0x300
20021050:	e7f3      	b.n	2002103a <sifli_hw_efuse_read+0x16>
20021052:	2204      	movs	r2, #4
20021054:	20c0      	movs	r0, #192	@ 0xc0
20021056:	eb0d 0102 	add.w	r1, sp, r2
2002105a:	f001 fc27 	bl	200228ac <HAL_EFUSE_Read>
2002105e:	2804      	cmp	r0, #4
20021060:	d104      	bne.n	2002106c <sifli_hw_efuse_read+0x48>
20021062:	2001      	movs	r0, #1
20021064:	9b01      	ldr	r3, [sp, #4]
20021066:	7023      	strb	r3, [r4, #0]
20021068:	b002      	add	sp, #8
2002106a:	bd10      	pop	{r4, pc}
2002106c:	2000      	movs	r0, #0
2002106e:	e7fb      	b.n	20021068 <sifli_hw_efuse_read+0x44>

20021070 <sifli_hw_init_xip_key>:
20021070:	b538      	push	{r3, r4, r5, lr}
20021072:	4605      	mov	r5, r0
20021074:	4c0f      	ldr	r4, [pc, #60]	@ (200210b4 <sifli_hw_init_xip_key+0x44>)
20021076:	2210      	movs	r2, #16
20021078:	68e3      	ldr	r3, [r4, #12]
2002107a:	490f      	ldr	r1, [pc, #60]	@ (200210b8 <sifli_hw_init_xip_key+0x48>)
2002107c:	f043 0301 	orr.w	r3, r3, #1
20021080:	60e3      	str	r3, [r4, #12]
20021082:	2001      	movs	r0, #1
20021084:	f7ff ffce 	bl	20021024 <sifli_hw_efuse_read>
20021088:	2220      	movs	r2, #32
2002108a:	2100      	movs	r1, #0
2002108c:	480b      	ldr	r0, [pc, #44]	@ (200210bc <sifli_hw_init_xip_key+0x4c>)
2002108e:	f009 fbe1 	bl	2002a854 <memset>
20021092:	2302      	movs	r3, #2
20021094:	2120      	movs	r1, #32
20021096:	4a08      	ldr	r2, [pc, #32]	@ (200210b8 <sifli_hw_init_xip_key+0x48>)
20021098:	2000      	movs	r0, #0
2002109a:	f000 ffa7 	bl	20021fec <HAL_AES_init>
2002109e:	2320      	movs	r3, #32
200210a0:	4629      	mov	r1, r5
200210a2:	2000      	movs	r0, #0
200210a4:	4a05      	ldr	r2, [pc, #20]	@ (200210bc <sifli_hw_init_xip_key+0x4c>)
200210a6:	f000 ffe5 	bl	20022074 <HAL_AES_run>
200210aa:	68e3      	ldr	r3, [r4, #12]
200210ac:	f023 0301 	bic.w	r3, r3, #1
200210b0:	60e3      	str	r3, [r4, #12]
200210b2:	bd38      	pop	{r3, r4, r5, pc}
200210b4:	5000b000 	.word	0x5000b000
200210b8:	20047270 	.word	0x20047270
200210bc:	20047220 	.word	0x20047220

200210c0 <sifli_hw_dec_key>:
200210c0:	b538      	push	{r3, r4, r5, lr}
200210c2:	4604      	mov	r4, r0
200210c4:	460d      	mov	r5, r1
200210c6:	2210      	movs	r2, #16
200210c8:	4908      	ldr	r1, [pc, #32]	@ (200210ec <sifli_hw_dec_key+0x2c>)
200210ca:	2001      	movs	r0, #1
200210cc:	f7ff ffaa 	bl	20021024 <sifli_hw_efuse_read>
200210d0:	2302      	movs	r3, #2
200210d2:	2120      	movs	r1, #32
200210d4:	4a05      	ldr	r2, [pc, #20]	@ (200210ec <sifli_hw_dec_key+0x2c>)
200210d6:	2000      	movs	r0, #0
200210d8:	f000 ff88 	bl	20021fec <HAL_AES_init>
200210dc:	2320      	movs	r3, #32
200210de:	462a      	mov	r2, r5
200210e0:	4621      	mov	r1, r4
200210e2:	2000      	movs	r0, #0
200210e4:	f000 ffc6 	bl	20022074 <HAL_AES_run>
200210e8:	2000      	movs	r0, #0
200210ea:	bd38      	pop	{r3, r4, r5, pc}
200210ec:	20047270 	.word	0x20047270

200210f0 <dfu_get_counter>:
200210f0:	b538      	push	{r3, r4, r5, lr}
200210f2:	4d0a      	ldr	r5, [pc, #40]	@ (2002111c <dfu_get_counter+0x2c>)
200210f4:	4604      	mov	r4, r0
200210f6:	2208      	movs	r2, #8
200210f8:	4629      	mov	r1, r5
200210fa:	2003      	movs	r0, #3
200210fc:	f7ff ff92 	bl	20021024 <sifli_hw_efuse_read>
20021100:	2300      	movs	r3, #0
20021102:	e9c5 3302 	strd	r3, r3, [r5, #8]
20021106:	230f      	movs	r3, #15
20021108:	0924      	lsrs	r4, r4, #4
2002110a:	b12c      	cbz	r4, 20021118 <dfu_get_counter+0x28>
2002110c:	54ec      	strb	r4, [r5, r3]
2002110e:	3b01      	subs	r3, #1
20021110:	2b0b      	cmp	r3, #11
20021112:	ea4f 2414 	mov.w	r4, r4, lsr #8
20021116:	d1f8      	bne.n	2002110a <dfu_get_counter+0x1a>
20021118:	4800      	ldr	r0, [pc, #0]	@ (2002111c <dfu_get_counter+0x2c>)
2002111a:	bd38      	pop	{r3, r4, r5, pc}
2002111c:	20047260 	.word	0x20047260

20021120 <sifli_hw_dec>:
20021120:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20021124:	4680      	mov	r8, r0
20021126:	4689      	mov	r9, r1
20021128:	4692      	mov	sl, r2
2002112a:	2100      	movs	r1, #0
2002112c:	f44f 7200 	mov.w	r2, #512	@ 0x200
20021130:	4814      	ldr	r0, [pc, #80]	@ (20021184 <sifli_hw_dec+0x64>)
20021132:	461e      	mov	r6, r3
20021134:	9f08      	ldr	r7, [sp, #32]
20021136:	2400      	movs	r4, #0
20021138:	f009 fb8c 	bl	2002a854 <memset>
2002113c:	42a6      	cmp	r6, r4
2002113e:	d802      	bhi.n	20021146 <sifli_hw_dec+0x26>
20021140:	4620      	mov	r0, r4
20021142:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
20021146:	1b35      	subs	r5, r6, r4
20021148:	f5b5 7f00 	cmp.w	r5, #512	@ 0x200
2002114c:	bf28      	it	cs
2002114e:	f44f 7500 	movcs.w	r5, #512	@ 0x200
20021152:	eb09 0104 	add.w	r1, r9, r4
20021156:	462a      	mov	r2, r5
20021158:	480a      	ldr	r0, [pc, #40]	@ (20021184 <sifli_hw_dec+0x64>)
2002115a:	f009 fb95 	bl	2002a888 <memcpy>
2002115e:	19e0      	adds	r0, r4, r7
20021160:	f7ff ffc6 	bl	200210f0 <dfu_get_counter>
20021164:	2301      	movs	r3, #1
20021166:	4602      	mov	r2, r0
20021168:	2120      	movs	r1, #32
2002116a:	4640      	mov	r0, r8
2002116c:	f000 ff3e 	bl	20021fec <HAL_AES_init>
20021170:	eb0a 0204 	add.w	r2, sl, r4
20021174:	462b      	mov	r3, r5
20021176:	2000      	movs	r0, #0
20021178:	4902      	ldr	r1, [pc, #8]	@ (20021184 <sifli_hw_dec+0x64>)
2002117a:	f000 ff7b 	bl	20022074 <HAL_AES_run>
2002117e:	442c      	add	r4, r5
20021180:	e7dc      	b.n	2002113c <sifli_hw_dec+0x1c>
20021182:	bf00      	nop
20021184:	20047020 	.word	0x20047020

20021188 <boot_ram>:
20021188:	4b05      	ldr	r3, [pc, #20]	@ (200211a0 <boot_ram+0x18>)
2002118a:	b082      	sub	sp, #8
2002118c:	6b9b      	ldr	r3, [r3, #56]	@ 0x38
2002118e:	9301      	str	r3, [sp, #4]
20021190:	9b01      	ldr	r3, [sp, #4]
20021192:	b113      	cbz	r3, 2002119a <boot_ram+0x12>
20021194:	9b01      	ldr	r3, [sp, #4]
20021196:	b002      	add	sp, #8
20021198:	4718      	bx	r3
2002119a:	b002      	add	sp, #8
2002119c:	4770      	bx	lr
2002119e:	bf00      	nop
200211a0:	500c0000 	.word	0x500c0000

200211a4 <is_addr_in_nor>:
200211a4:	4b09      	ldr	r3, [pc, #36]	@ (200211cc <is_addr_in_nor+0x28>)
200211a6:	4602      	mov	r2, r0
200211a8:	681b      	ldr	r3, [r3, #0]
200211aa:	b163      	cbz	r3, 200211c6 <is_addr_in_nor+0x22>
200211ac:	f893 0023 	ldrb.w	r0, [r3, #35]	@ 0x23
200211b0:	b948      	cbnz	r0, 200211c6 <is_addr_in_nor+0x22>
200211b2:	6919      	ldr	r1, [r3, #16]
200211b4:	4291      	cmp	r1, r2
200211b6:	d807      	bhi.n	200211c8 <is_addr_in_nor+0x24>
200211b8:	695b      	ldr	r3, [r3, #20]
200211ba:	4419      	add	r1, r3
200211bc:	4291      	cmp	r1, r2
200211be:	bf94      	ite	ls
200211c0:	2000      	movls	r0, #0
200211c2:	2001      	movhi	r0, #1
200211c4:	4770      	bx	lr
200211c6:	2000      	movs	r0, #0
200211c8:	4770      	bx	lr
200211ca:	bf00      	nop
200211cc:	20046cb4 	.word	0x20046cb4

200211d0 <dfu_boot_img_in_flash>:
200211d0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200211d4:	4f5e      	ldr	r7, [pc, #376]	@ (20021350 <dfu_boot_img_in_flash+0x180>)
200211d6:	1e84      	subs	r4, r0, #2
200211d8:	eb07 1300 	add.w	r3, r7, r0, lsl #4
200211dc:	eb07 2040 	add.w	r0, r7, r0, lsl #9
200211e0:	f8d3 8004 	ldr.w	r8, [r3, #4]
200211e4:	68dd      	ldr	r5, [r3, #12]
200211e6:	f8b0 3c06 	ldrh.w	r3, [r0, #3078]	@ 0xc06
200211ea:	b085      	sub	sp, #20
200211ec:	07db      	lsls	r3, r3, #31
200211ee:	f140 8095 	bpl.w	2002131c <dfu_boot_img_in_flash+0x14c>
200211f2:	f44f 7193 	mov.w	r1, #294	@ 0x126
200211f6:	f507 7082 	add.w	r0, r7, #260	@ 0x104
200211fa:	f000 fd38 	bl	20021c6e <sifli_sigkey_pub_verify>
200211fe:	b110      	cbz	r0, 20021206 <dfu_boot_img_in_flash+0x36>
20021200:	2001      	movs	r0, #1
20021202:	f000 fd81 	bl	20021d08 <sifli_secboot_exception>
20021206:	2c07      	cmp	r4, #7
20021208:	f300 8093 	bgt.w	20021332 <dfu_boot_img_in_flash+0x162>
2002120c:	2003      	movs	r0, #3
2002120e:	f7ff fef3 	bl	20020ff8 <sifli_hw_efuse_read_bank>
20021212:	4262      	negs	r2, r4
20021214:	f002 0203 	and.w	r2, r2, #3
20021218:	f004 0303 	and.w	r3, r4, #3
2002121c:	bf58      	it	pl
2002121e:	4253      	negpl	r3, r2
20021220:	2b02      	cmp	r3, #2
20021222:	f200 8086 	bhi.w	20021332 <dfu_boot_img_in_flash+0x162>
20021226:	4628      	mov	r0, r5
20021228:	f7ff ffbc 	bl	200211a4 <is_addr_in_nor>
2002122c:	f241 0308 	movw	r3, #4104	@ 0x1008
20021230:	4682      	mov	sl, r0
20021232:	ea4f 2944 	mov.w	r9, r4, lsl #9
20021236:	f8df c12c 	ldr.w	ip, [pc, #300]	@ 20021364 <dfu_boot_img_in_flash+0x194>
2002123a:	eb07 0609 	add.w	r6, r7, r9
2002123e:	441e      	add	r6, r3
20021240:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
20021242:	e8ac 000f 	stmia.w	ip!, {r0, r1, r2, r3}
20021246:	e896 000f 	ldmia.w	r6, {r0, r1, r2, r3}
2002124a:	e88c 000f 	stmia.w	ip, {r0, r1, r2, r3}
2002124e:	f1ba 0f00 	cmp.w	sl, #0
20021252:	d04b      	beq.n	200212ec <dfu_boot_img_in_flash+0x11c>
20021254:	f104 0608 	add.w	r6, r4, #8
20021258:	f1ac 0010 	sub.w	r0, ip, #16
2002125c:	0276      	lsls	r6, r6, #9
2002125e:	f7ff ff07 	bl	20021070 <sifli_hw_init_xip_key>
20021262:	59ba      	ldr	r2, [r7, r6]
20021264:	f8df a0f0 	ldr.w	sl, [pc, #240]	@ 20021358 <dfu_boot_img_in_flash+0x188>
20021268:	442a      	add	r2, r5
2002126a:	2000      	movs	r0, #0
2002126c:	f8da b000 	ldr.w	fp, [sl]
20021270:	9203      	str	r2, [sp, #12]
20021272:	f7ff ff3d 	bl	200210f0 <dfu_get_counter>
20021276:	4629      	mov	r1, r5
20021278:	4603      	mov	r3, r0
2002127a:	9a03      	ldr	r2, [sp, #12]
2002127c:	4658      	mov	r0, fp
2002127e:	f002 fa2a 	bl	200236d6 <HAL_FLASH_NONCE_CFG>
20021282:	4629      	mov	r1, r5
20021284:	f8da 0000 	ldr.w	r0, [sl]
20021288:	59ba      	ldr	r2, [r7, r6]
2002128a:	eba8 0305 	sub.w	r3, r8, r5
2002128e:	f002 fa11 	bl	200236b4 <HAL_FLASH_ALIAS_CFG>
20021292:	2101      	movs	r1, #1
20021294:	f8da 0000 	ldr.w	r0, [sl]
20021298:	f002 fa35 	bl	20023706 <HAL_FLASH_AES_CFG>
2002129c:	f104 0308 	add.w	r3, r4, #8
200212a0:	f509 5081 	add.w	r0, r9, #4128	@ 0x1020
200212a4:	025b      	lsls	r3, r3, #9
200212a6:	3008      	adds	r0, #8
200212a8:	462a      	mov	r2, r5
200212aa:	58fb      	ldr	r3, [r7, r3]
200212ac:	4929      	ldr	r1, [pc, #164]	@ (20021354 <dfu_boot_img_in_flash+0x184>)
200212ae:	4438      	add	r0, r7
200212b0:	f000 fcf5 	bl	20021c9e <sifli_img_sig_hash_verify>
200212b4:	b110      	cbz	r0, 200212bc <dfu_boot_img_in_flash+0xec>
200212b6:	2002      	movs	r0, #2
200212b8:	f000 fd26 	bl	20021d08 <sifli_secboot_exception>
200212bc:	f8d5 d000 	ldr.w	sp, [r5]
200212c0:	f8d5 f004 	ldr.w	pc, [r5, #4]
200212c4:	4628      	mov	r0, r5
200212c6:	f7ff ff6d 	bl	200211a4 <is_addr_in_nor>
200212ca:	2800      	cmp	r0, #0
200212cc:	d034      	beq.n	20021338 <dfu_boot_img_in_flash+0x168>
200212ce:	4822      	ldr	r0, [pc, #136]	@ (20021358 <dfu_boot_img_in_flash+0x188>)
200212d0:	3408      	adds	r4, #8
200212d2:	0264      	lsls	r4, r4, #9
200212d4:	4629      	mov	r1, r5
200212d6:	593a      	ldr	r2, [r7, r4]
200212d8:	6800      	ldr	r0, [r0, #0]
200212da:	eba8 0305 	sub.w	r3, r8, r5
200212de:	f002 f9e9 	bl	200236b4 <HAL_FLASH_ALIAS_CFG>
200212e2:	f8d5 d000 	ldr.w	sp, [r5]
200212e6:	f8d5 f004 	ldr.w	pc, [r5, #4]
200212ea:	e022      	b.n	20021332 <dfu_boot_img_in_flash+0x162>
200212ec:	f1ac 0010 	sub.w	r0, ip, #16
200212f0:	2220      	movs	r2, #32
200212f2:	491a      	ldr	r1, [pc, #104]	@ (2002135c <dfu_boot_img_in_flash+0x18c>)
200212f4:	f7ff fee4 	bl	200210c0 <sifli_hw_dec_key>
200212f8:	f104 0608 	add.w	r6, r4, #8
200212fc:	4b18      	ldr	r3, [pc, #96]	@ (20021360 <dfu_boot_img_in_flash+0x190>)
200212fe:	0276      	lsls	r6, r6, #9
20021300:	4629      	mov	r1, r5
20021302:	59ba      	ldr	r2, [r7, r6]
20021304:	4640      	mov	r0, r8
20021306:	681b      	ldr	r3, [r3, #0]
20021308:	4798      	blx	r3
2002130a:	f8cd a000 	str.w	sl, [sp]
2002130e:	462a      	mov	r2, r5
20021310:	4629      	mov	r1, r5
20021312:	59bb      	ldr	r3, [r7, r6]
20021314:	4811      	ldr	r0, [pc, #68]	@ (2002135c <dfu_boot_img_in_flash+0x18c>)
20021316:	f7ff ff03 	bl	20021120 <sifli_hw_dec>
2002131a:	e7bf      	b.n	2002129c <dfu_boot_img_in_flash+0xcc>
2002131c:	2c07      	cmp	r4, #7
2002131e:	dc08      	bgt.n	20021332 <dfu_boot_img_in_flash+0x162>
20021320:	4262      	negs	r2, r4
20021322:	f002 0203 	and.w	r2, r2, #3
20021326:	f004 0303 	and.w	r3, r4, #3
2002132a:	bf58      	it	pl
2002132c:	4253      	negpl	r3, r2
2002132e:	2b02      	cmp	r3, #2
20021330:	d9c8      	bls.n	200212c4 <dfu_boot_img_in_flash+0xf4>
20021332:	b005      	add	sp, #20
20021334:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20021338:	45a8      	cmp	r8, r5
2002133a:	d0d2      	beq.n	200212e2 <dfu_boot_img_in_flash+0x112>
2002133c:	4b08      	ldr	r3, [pc, #32]	@ (20021360 <dfu_boot_img_in_flash+0x190>)
2002133e:	3408      	adds	r4, #8
20021340:	0264      	lsls	r4, r4, #9
20021342:	4629      	mov	r1, r5
20021344:	4640      	mov	r0, r8
20021346:	681b      	ldr	r3, [r3, #0]
20021348:	593a      	ldr	r2, [r7, r4]
2002134a:	4798      	blx	r3
2002134c:	e7c9      	b.n	200212e2 <dfu_boot_img_in_flash+0x112>
2002134e:	bf00      	nop
20021350:	200472c0 	.word	0x200472c0
20021354:	200473c4 	.word	0x200473c4
20021358:	20046cb4 	.word	0x20046cb4
2002135c:	20047280 	.word	0x20047280
20021360:	20046cc0 	.word	0x20046cc0
20021364:	200472a0 	.word	0x200472a0

20021368 <boot_images_help>:
20021368:	b537      	push	{r0, r1, r2, r4, r5, lr}
2002136a:	4c18      	ldr	r4, [pc, #96]	@ (200213cc <boot_images_help+0x64>)
2002136c:	4b18      	ldr	r3, [pc, #96]	@ (200213d0 <boot_images_help+0x68>)
2002136e:	6825      	ldr	r5, [r4, #0]
20021370:	429d      	cmp	r5, r3
20021372:	d129      	bne.n	200213c8 <boot_images_help+0x60>
20021374:	2300      	movs	r3, #0
20021376:	e9cd 3300 	strd	r3, r3, [sp]
2002137a:	4b16      	ldr	r3, [pc, #88]	@ (200213d4 <boot_images_help+0x6c>)
2002137c:	2208      	movs	r2, #8
2002137e:	4669      	mov	r1, sp
20021380:	681b      	ldr	r3, [r3, #0]
20021382:	4815      	ldr	r0, [pc, #84]	@ (200213d8 <boot_images_help+0x70>)
20021384:	4798      	blx	r3
20021386:	2005      	movs	r0, #5
20021388:	f001 fb9c 	bl	20022ac4 <HAL_Get_backup>
2002138c:	2802      	cmp	r0, #2
2002138e:	f504 5400 	add.w	r4, r4, #8192	@ 0x2000
20021392:	d006      	beq.n	200213a2 <boot_images_help+0x3a>
20021394:	9b00      	ldr	r3, [sp, #0]
20021396:	42ab      	cmp	r3, r5
20021398:	d106      	bne.n	200213a8 <boot_images_help+0x40>
2002139a:	f89d 3005 	ldrb.w	r3, [sp, #5]
2002139e:	2b7f      	cmp	r3, #127	@ 0x7f
200213a0:	d102      	bne.n	200213a8 <boot_images_help+0x40>
200213a2:	4b0e      	ldr	r3, [pc, #56]	@ (200213dc <boot_images_help+0x74>)
200213a4:	f8c4 3c08 	str.w	r3, [r4, #3080]	@ 0xc08
200213a8:	f8d4 3c08 	ldr.w	r3, [r4, #3080]	@ 0xc08
200213ac:	1c5a      	adds	r2, r3, #1
200213ae:	d00b      	beq.n	200213c8 <boot_images_help+0x60>
200213b0:	4a0b      	ldr	r2, [pc, #44]	@ (200213e0 <boot_images_help+0x78>)
200213b2:	6814      	ldr	r4, [r2, #0]
200213b4:	1b1c      	subs	r4, r3, r4
200213b6:	f5a4 5480 	sub.w	r4, r4, #4096	@ 0x1000
200213ba:	0a64      	lsrs	r4, r4, #9
200213bc:	3402      	adds	r4, #2
200213be:	f7ff fa8f 	bl	200208e0 <board_init_psram>
200213c2:	4620      	mov	r0, r4
200213c4:	f7ff ff04 	bl	200211d0 <dfu_boot_img_in_flash>
200213c8:	b003      	add	sp, #12
200213ca:	bd30      	pop	{r4, r5, pc}
200213cc:	200472c0 	.word	0x200472c0
200213d0:	53454346 	.word	0x53454346
200213d4:	20046cc0 	.word	0x20046cc0
200213d8:	12780000 	.word	0x12780000
200213dc:	12001000 	.word	0x12001000
200213e0:	20046cb0 	.word	0x20046cb0

200213e4 <hw_preinit0>:
200213e4:	b508      	push	{r3, lr}
200213e6:	4b0e      	ldr	r3, [pc, #56]	@ (20021420 <hw_preinit0+0x3c>)
200213e8:	685b      	ldr	r3, [r3, #4]
200213ea:	b2db      	uxtb	r3, r3
200213ec:	2b06      	cmp	r3, #6
200213ee:	d80a      	bhi.n	20021406 <hw_preinit0+0x22>
200213f0:	4a0c      	ldr	r2, [pc, #48]	@ (20021424 <hw_preinit0+0x40>)
200213f2:	6a93      	ldr	r3, [r2, #40]	@ 0x28
200213f4:	f023 037f 	bic.w	r3, r3, #127	@ 0x7f
200213f8:	f043 0306 	orr.w	r3, r3, #6
200213fc:	6293      	str	r3, [r2, #40]	@ 0x28
200213fe:	6853      	ldr	r3, [r2, #4]
20021400:	f043 0380 	orr.w	r3, r3, #128	@ 0x80
20021404:	6053      	str	r3, [r2, #4]
20021406:	2000      	movs	r0, #0
20021408:	f000 fd77 	bl	20021efa <HAL_Delay_us>
2002140c:	4b06      	ldr	r3, [pc, #24]	@ (20021428 <hw_preinit0+0x44>)
2002140e:	4a07      	ldr	r2, [pc, #28]	@ (2002142c <hw_preinit0+0x48>)
20021410:	2000      	movs	r0, #0
20021412:	605a      	str	r2, [r3, #4]
20021414:	f7ff fdf0 	bl	20020ff8 <sifli_hw_efuse_read_bank>
20021418:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
2002141c:	f7ff beb4 	b.w	20021188 <boot_ram>
20021420:	5000b000 	.word	0x5000b000
20021424:	500ca000 	.word	0x500ca000
20021428:	5000c000 	.word	0x5000c000
2002142c:	0002d08f 	.word	0x0002d08f

20021430 <entry>:
20021430:	4c14      	ldr	r4, [pc, #80]	@ (20021484 <entry+0x54>)
20021432:	b508      	push	{r3, lr}
20021434:	2000      	movs	r0, #0
20021436:	f000 fd60 	bl	20021efa <HAL_Delay_us>
2002143a:	6863      	ldr	r3, [r4, #4]
2002143c:	4d12      	ldr	r5, [pc, #72]	@ (20021488 <entry+0x58>)
2002143e:	b2db      	uxtb	r3, r3
20021440:	2b06      	cmp	r3, #6
20021442:	d90f      	bls.n	20021464 <entry+0x34>
20021444:	f7ff f86c 	bl	20020520 <board_flash_power_on>
20021448:	f7fe ff5a 	bl	20020300 <HAL_MspInit>
2002144c:	f7ff f84a 	bl	200204e4 <board_boot_from>
20021450:	6028      	str	r0, [r5, #0]
20021452:	68e3      	ldr	r3, [r4, #12]
20021454:	f023 0301 	bic.w	r3, r3, #1
20021458:	60e3      	str	r3, [r4, #12]
2002145a:	f7ff fc53 	bl	20020d04 <dfu_flash_init>
2002145e:	f7ff ff83 	bl	20021368 <boot_images_help>
20021462:	e7fe      	b.n	20021462 <entry+0x32>
20021464:	f7ff f83e 	bl	200204e4 <board_boot_from>
20021468:	6028      	str	r0, [r5, #0]
2002146a:	f7ff f859 	bl	20020520 <board_flash_power_on>
2002146e:	f7fe ff47 	bl	20020300 <HAL_MspInit>
20021472:	68e3      	ldr	r3, [r4, #12]
20021474:	f023 0301 	bic.w	r3, r3, #1
20021478:	60e3      	str	r3, [r4, #12]
2002147a:	f7ff fc43 	bl	20020d04 <dfu_flash_init>
2002147e:	f7ff ff73 	bl	20021368 <boot_images_help>
20021482:	e7ee      	b.n	20021462 <entry+0x32>
20021484:	5000b000 	.word	0x5000b000
20021488:	20049ed0 	.word	0x20049ed0

2002148c <sdio_emmc_init>:
2002148c:	b570      	push	{r4, r5, r6, lr}
2002148e:	b08c      	sub	sp, #48	@ 0x30
20021490:	f000 f968 	bl	20021764 <sd1_init>
20021494:	4c8d      	ldr	r4, [pc, #564]	@ (200216cc <sdio_emmc_init+0x240>)
20021496:	4b8e      	ldr	r3, [pc, #568]	@ (200216d0 <sdio_emmc_init+0x244>)
20021498:	2500      	movs	r5, #0
2002149a:	6323      	str	r3, [r4, #48]	@ 0x30
2002149c:	6b23      	ldr	r3, [r4, #48]	@ 0x30
2002149e:	f44f 70fa 	mov.w	r0, #500	@ 0x1f4
200214a2:	f043 0302 	orr.w	r3, r3, #2
200214a6:	6323      	str	r3, [r4, #48]	@ 0x30
200214a8:	f04f 7300 	mov.w	r3, #33554432	@ 0x2000000
200214ac:	62e5      	str	r5, [r4, #44]	@ 0x2c
200214ae:	6223      	str	r3, [r4, #32]
200214b0:	f000 fd23 	bl	20021efa <HAL_Delay_us>
200214b4:	4629      	mov	r1, r5
200214b6:	4628      	mov	r0, r5
200214b8:	f000 f986 	bl	200217c8 <sd1_send_cmd>
200214bc:	2301      	movs	r3, #1
200214be:	65e3      	str	r3, [r4, #92]	@ 0x5c
200214c0:	6de3      	ldr	r3, [r4, #92]	@ 0x5c
200214c2:	079d      	lsls	r5, r3, #30
200214c4:	d5fc      	bpl.n	200214c0 <sdio_emmc_init+0x34>
200214c6:	6be3      	ldr	r3, [r4, #60]	@ 0x3c
200214c8:	f043 0320 	orr.w	r3, r3, #32
200214cc:	63e3      	str	r3, [r4, #60]	@ 0x3c
200214ce:	4981      	ldr	r1, [pc, #516]	@ (200216d4 <sdio_emmc_init+0x248>)
200214d0:	2001      	movs	r0, #1
200214d2:	ad07      	add	r5, sp, #28
200214d4:	f000 f978 	bl	200217c8 <sd1_send_cmd>
200214d8:	ab06      	add	r3, sp, #24
200214da:	aa05      	add	r2, sp, #20
200214dc:	a904      	add	r1, sp, #16
200214de:	f10d 000f 	add.w	r0, sp, #15
200214e2:	9500      	str	r5, [sp, #0]
200214e4:	f000 f9ae 	bl	20021844 <sd1_get_rsp>
200214e8:	2014      	movs	r0, #20
200214ea:	f000 fd06 	bl	20021efa <HAL_Delay_us>
200214ee:	9b04      	ldr	r3, [sp, #16]
200214f0:	2b00      	cmp	r3, #0
200214f2:	daec      	bge.n	200214ce <sdio_emmc_init+0x42>
200214f4:	2014      	movs	r0, #20
200214f6:	f000 fd00 	bl	20021efa <HAL_Delay_us>
200214fa:	2100      	movs	r1, #0
200214fc:	2002      	movs	r0, #2
200214fe:	f000 f963 	bl	200217c8 <sd1_send_cmd>
20021502:	2801      	cmp	r0, #1
20021504:	f000 8081 	beq.w	2002160a <sdio_emmc_init+0x17e>
20021508:	2802      	cmp	r0, #2
2002150a:	d07e      	beq.n	2002160a <sdio_emmc_init+0x17e>
2002150c:	ab08      	add	r3, sp, #32
2002150e:	aa0a      	add	r2, sp, #40	@ 0x28
20021510:	a90b      	add	r1, sp, #44	@ 0x2c
20021512:	9300      	str	r3, [sp, #0]
20021514:	f10d 000f 	add.w	r0, sp, #15
20021518:	ab09      	add	r3, sp, #36	@ 0x24
2002151a:	f000 f993 	bl	20021844 <sd1_get_rsp>
2002151e:	2014      	movs	r0, #20
20021520:	f000 fceb 	bl	20021efa <HAL_Delay_us>
20021524:	f44f 3180 	mov.w	r1, #65536	@ 0x10000
20021528:	2003      	movs	r0, #3
2002152a:	f000 f94d 	bl	200217c8 <sd1_send_cmd>
2002152e:	2801      	cmp	r0, #1
20021530:	f000 80ab 	beq.w	2002168a <sdio_emmc_init+0x1fe>
20021534:	2802      	cmp	r0, #2
20021536:	f000 80aa 	beq.w	2002168e <sdio_emmc_init+0x202>
2002153a:	ab06      	add	r3, sp, #24
2002153c:	9500      	str	r5, [sp, #0]
2002153e:	aa05      	add	r2, sp, #20
20021540:	a904      	add	r1, sp, #16
20021542:	f10d 000f 	add.w	r0, sp, #15
20021546:	f000 f97d 	bl	20021844 <sd1_get_rsp>
2002154a:	f89d 300f 	ldrb.w	r3, [sp, #15]
2002154e:	2b03      	cmp	r3, #3
20021550:	f040 809f 	bne.w	20021692 <sdio_emmc_init+0x206>
20021554:	4c5d      	ldr	r4, [pc, #372]	@ (200216cc <sdio_emmc_init+0x240>)
20021556:	2014      	movs	r0, #20
20021558:	6be3      	ldr	r3, [r4, #60]	@ 0x3c
2002155a:	f023 0320 	bic.w	r3, r3, #32
2002155e:	63e3      	str	r3, [r4, #60]	@ 0x3c
20021560:	f000 fccb 	bl	20021efa <HAL_Delay_us>
20021564:	f44f 3180 	mov.w	r1, #65536	@ 0x10000
20021568:	2009      	movs	r0, #9
2002156a:	f000 f92d 	bl	200217c8 <sd1_send_cmd>
2002156e:	2801      	cmp	r0, #1
20021570:	f000 8091 	beq.w	20021696 <sdio_emmc_init+0x20a>
20021574:	2802      	cmp	r0, #2
20021576:	f000 8090 	beq.w	2002169a <sdio_emmc_init+0x20e>
2002157a:	aa05      	add	r2, sp, #20
2002157c:	a904      	add	r1, sp, #16
2002157e:	ab06      	add	r3, sp, #24
20021580:	f10d 000f 	add.w	r0, sp, #15
20021584:	9500      	str	r5, [sp, #0]
20021586:	f000 f95d 	bl	20021844 <sd1_get_rsp>
2002158a:	f44f 53b8 	mov.w	r3, #5888	@ 0x1700
2002158e:	6323      	str	r3, [r4, #48]	@ 0x30
20021590:	6b23      	ldr	r3, [r4, #48]	@ 0x30
20021592:	2014      	movs	r0, #20
20021594:	f043 0302 	orr.w	r3, r3, #2
20021598:	6323      	str	r3, [r4, #48]	@ 0x30
2002159a:	f04f 7300 	mov.w	r3, #33554432	@ 0x2000000
2002159e:	6223      	str	r3, [r4, #32]
200215a0:	2302      	movs	r3, #2
200215a2:	63e3      	str	r3, [r4, #60]	@ 0x3c
200215a4:	f000 fca9 	bl	20021efa <HAL_Delay_us>
200215a8:	f44f 3180 	mov.w	r1, #65536	@ 0x10000
200215ac:	2007      	movs	r0, #7
200215ae:	f000 f90b 	bl	200217c8 <sd1_send_cmd>
200215b2:	2801      	cmp	r0, #1
200215b4:	d073      	beq.n	2002169e <sdio_emmc_init+0x212>
200215b6:	2802      	cmp	r0, #2
200215b8:	d073      	beq.n	200216a2 <sdio_emmc_init+0x216>
200215ba:	ab06      	add	r3, sp, #24
200215bc:	9500      	str	r5, [sp, #0]
200215be:	aa05      	add	r2, sp, #20
200215c0:	a904      	add	r1, sp, #16
200215c2:	f10d 000f 	add.w	r0, sp, #15
200215c6:	f000 f93d 	bl	20021844 <sd1_get_rsp>
200215ca:	f89d 300f 	ldrb.w	r3, [sp, #15]
200215ce:	2b07      	cmp	r3, #7
200215d0:	d169      	bne.n	200216a6 <sdio_emmc_init+0x21a>
200215d2:	f04f 33ff 	mov.w	r3, #4294967295
200215d6:	2101      	movs	r1, #1
200215d8:	2000      	movs	r0, #0
200215da:	6023      	str	r3, [r4, #0]
200215dc:	f000 f942 	bl	20021864 <sd1_read>
200215e0:	2100      	movs	r1, #0
200215e2:	2008      	movs	r0, #8
200215e4:	f000 f8f0 	bl	200217c8 <sd1_send_cmd>
200215e8:	2801      	cmp	r0, #1
200215ea:	d05e      	beq.n	200216aa <sdio_emmc_init+0x21e>
200215ec:	2802      	cmp	r0, #2
200215ee:	d05e      	beq.n	200216ae <sdio_emmc_init+0x222>
200215f0:	ab06      	add	r3, sp, #24
200215f2:	9500      	str	r5, [sp, #0]
200215f4:	aa05      	add	r2, sp, #20
200215f6:	a904      	add	r1, sp, #16
200215f8:	f10d 000f 	add.w	r0, sp, #15
200215fc:	f000 f922 	bl	20021844 <sd1_get_rsp>
20021600:	f89d 300f 	ldrb.w	r3, [sp, #15]
20021604:	2b08      	cmp	r3, #8
20021606:	d002      	beq.n	2002160e <sdio_emmc_init+0x182>
20021608:	200d      	movs	r0, #13
2002160a:	b00c      	add	sp, #48	@ 0x30
2002160c:	bd70      	pop	{r4, r5, r6, pc}
2002160e:	2320      	movs	r3, #32
20021610:	62e3      	str	r3, [r4, #44]	@ 0x2c
20021612:	f000 f937 	bl	20021884 <sd1_wait_read>
20021616:	6823      	ldr	r3, [r4, #0]
20021618:	0618      	lsls	r0, r3, #24
2002161a:	d4f5      	bmi.n	20021608 <sdio_emmc_init+0x17c>
2002161c:	6823      	ldr	r3, [r4, #0]
2002161e:	0659      	lsls	r1, r3, #25
20021620:	d447      	bmi.n	200216b2 <sdio_emmc_init+0x226>
20021622:	2680      	movs	r6, #128	@ 0x80
20021624:	3e01      	subs	r6, #1
20021626:	f8d4 3200 	ldr.w	r3, [r4, #512]	@ 0x200
2002162a:	d1fb      	bne.n	20021624 <sdio_emmc_init+0x198>
2002162c:	2101      	movs	r1, #1
2002162e:	4630      	mov	r0, r6
20021630:	f000 f918 	bl	20021864 <sd1_read>
20021634:	2014      	movs	r0, #20
20021636:	f000 fc60 	bl	20021efa <HAL_Delay_us>
2002163a:	f04f 33ff 	mov.w	r3, #4294967295
2002163e:	4631      	mov	r1, r6
20021640:	2011      	movs	r0, #17
20021642:	6023      	str	r3, [r4, #0]
20021644:	f000 f8c0 	bl	200217c8 <sd1_send_cmd>
20021648:	2801      	cmp	r0, #1
2002164a:	d034      	beq.n	200216b6 <sdio_emmc_init+0x22a>
2002164c:	2802      	cmp	r0, #2
2002164e:	d034      	beq.n	200216ba <sdio_emmc_init+0x22e>
20021650:	ab06      	add	r3, sp, #24
20021652:	9500      	str	r5, [sp, #0]
20021654:	aa05      	add	r2, sp, #20
20021656:	a904      	add	r1, sp, #16
20021658:	f10d 000f 	add.w	r0, sp, #15
2002165c:	f000 f8f2 	bl	20021844 <sd1_get_rsp>
20021660:	f89d 300f 	ldrb.w	r3, [sp, #15]
20021664:	2b11      	cmp	r3, #17
20021666:	d12a      	bne.n	200216be <sdio_emmc_init+0x232>
20021668:	2320      	movs	r3, #32
2002166a:	62e3      	str	r3, [r4, #44]	@ 0x2c
2002166c:	f000 f90a 	bl	20021884 <sd1_wait_read>
20021670:	6823      	ldr	r3, [r4, #0]
20021672:	061a      	lsls	r2, r3, #24
20021674:	d425      	bmi.n	200216c2 <sdio_emmc_init+0x236>
20021676:	6823      	ldr	r3, [r4, #0]
20021678:	065b      	lsls	r3, r3, #25
2002167a:	d424      	bmi.n	200216c6 <sdio_emmc_init+0x23a>
2002167c:	2080      	movs	r0, #128	@ 0x80
2002167e:	4b13      	ldr	r3, [pc, #76]	@ (200216cc <sdio_emmc_init+0x240>)
20021680:	3801      	subs	r0, #1
20021682:	f8d3 2200 	ldr.w	r2, [r3, #512]	@ 0x200
20021686:	d1fb      	bne.n	20021680 <sdio_emmc_init+0x1f4>
20021688:	e7bf      	b.n	2002160a <sdio_emmc_init+0x17e>
2002168a:	2003      	movs	r0, #3
2002168c:	e7bd      	b.n	2002160a <sdio_emmc_init+0x17e>
2002168e:	2004      	movs	r0, #4
20021690:	e7bb      	b.n	2002160a <sdio_emmc_init+0x17e>
20021692:	2005      	movs	r0, #5
20021694:	e7b9      	b.n	2002160a <sdio_emmc_init+0x17e>
20021696:	2006      	movs	r0, #6
20021698:	e7b7      	b.n	2002160a <sdio_emmc_init+0x17e>
2002169a:	2007      	movs	r0, #7
2002169c:	e7b5      	b.n	2002160a <sdio_emmc_init+0x17e>
2002169e:	2008      	movs	r0, #8
200216a0:	e7b3      	b.n	2002160a <sdio_emmc_init+0x17e>
200216a2:	2009      	movs	r0, #9
200216a4:	e7b1      	b.n	2002160a <sdio_emmc_init+0x17e>
200216a6:	200a      	movs	r0, #10
200216a8:	e7af      	b.n	2002160a <sdio_emmc_init+0x17e>
200216aa:	200b      	movs	r0, #11
200216ac:	e7ad      	b.n	2002160a <sdio_emmc_init+0x17e>
200216ae:	200c      	movs	r0, #12
200216b0:	e7ab      	b.n	2002160a <sdio_emmc_init+0x17e>
200216b2:	200e      	movs	r0, #14
200216b4:	e7a9      	b.n	2002160a <sdio_emmc_init+0x17e>
200216b6:	2011      	movs	r0, #17
200216b8:	e7a7      	b.n	2002160a <sdio_emmc_init+0x17e>
200216ba:	2012      	movs	r0, #18
200216bc:	e7a5      	b.n	2002160a <sdio_emmc_init+0x17e>
200216be:	2013      	movs	r0, #19
200216c0:	e7a3      	b.n	2002160a <sdio_emmc_init+0x17e>
200216c2:	2014      	movs	r0, #20
200216c4:	e7a1      	b.n	2002160a <sdio_emmc_init+0x17e>
200216c6:	2015      	movs	r0, #21
200216c8:	e79f      	b.n	2002160a <sdio_emmc_init+0x17e>
200216ca:	bf00      	nop
200216cc:	50045000 	.word	0x50045000
200216d0:	00016700 	.word	0x00016700
200216d4:	40000080 	.word	0x40000080

200216d8 <emmc_read_data>:
200216d8:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
200216dc:	4607      	mov	r7, r0
200216de:	f04f 38ff 	mov.w	r8, #4294967295
200216e2:	b088      	sub	sp, #32
200216e4:	2000      	movs	r0, #0
200216e6:	460d      	mov	r5, r1
200216e8:	4e1d      	ldr	r6, [pc, #116]	@ (20021760 <emmc_read_data+0x88>)
200216ea:	2101      	movs	r1, #1
200216ec:	4614      	mov	r4, r2
200216ee:	f000 f8b9 	bl	20021864 <sd1_read>
200216f2:	2014      	movs	r0, #20
200216f4:	f000 fc01 	bl	20021efa <HAL_Delay_us>
200216f8:	2011      	movs	r0, #17
200216fa:	f8c6 8000 	str.w	r8, [r6]
200216fe:	0a79      	lsrs	r1, r7, #9
20021700:	f000 f862 	bl	200217c8 <sd1_send_cmd>
20021704:	4440      	add	r0, r8
20021706:	b2c0      	uxtb	r0, r0
20021708:	2801      	cmp	r0, #1
2002170a:	d803      	bhi.n	20021714 <emmc_read_data+0x3c>
2002170c:	2000      	movs	r0, #0
2002170e:	b008      	add	sp, #32
20021710:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20021714:	ab07      	add	r3, sp, #28
20021716:	9300      	str	r3, [sp, #0]
20021718:	aa05      	add	r2, sp, #20
2002171a:	ab06      	add	r3, sp, #24
2002171c:	a904      	add	r1, sp, #16
2002171e:	f10d 000f 	add.w	r0, sp, #15
20021722:	f000 f88f 	bl	20021844 <sd1_get_rsp>
20021726:	f89d 300f 	ldrb.w	r3, [sp, #15]
2002172a:	2b11      	cmp	r3, #17
2002172c:	d1ee      	bne.n	2002170c <emmc_read_data+0x34>
2002172e:	2320      	movs	r3, #32
20021730:	f8c6 8000 	str.w	r8, [r6]
20021734:	62f3      	str	r3, [r6, #44]	@ 0x2c
20021736:	f000 f8a5 	bl	20021884 <sd1_wait_read>
2002173a:	6833      	ldr	r3, [r6, #0]
2002173c:	061a      	lsls	r2, r3, #24
2002173e:	d4e5      	bmi.n	2002170c <emmc_read_data+0x34>
20021740:	6833      	ldr	r3, [r6, #0]
20021742:	065b      	lsls	r3, r3, #25
20021744:	d4e2      	bmi.n	2002170c <emmc_read_data+0x34>
20021746:	f024 0303 	bic.w	r3, r4, #3
2002174a:	442b      	add	r3, r5
2002174c:	429d      	cmp	r5, r3
2002174e:	d101      	bne.n	20021754 <emmc_read_data+0x7c>
20021750:	4620      	mov	r0, r4
20021752:	e7dc      	b.n	2002170e <emmc_read_data+0x36>
20021754:	f8d6 2200 	ldr.w	r2, [r6, #512]	@ 0x200
20021758:	f845 2b04 	str.w	r2, [r5], #4
2002175c:	e7f6      	b.n	2002174c <emmc_read_data+0x74>
2002175e:	bf00      	nop
20021760:	50045000 	.word	0x50045000

20021764 <sd1_init>:
20021764:	b510      	push	{r4, lr}
20021766:	f04f 44a0 	mov.w	r4, #1342177280	@ 0x50000000
2002176a:	68e3      	ldr	r3, [r4, #12]
2002176c:	2064      	movs	r0, #100	@ 0x64
2002176e:	f023 0310 	bic.w	r3, r3, #16
20021772:	60e3      	str	r3, [r4, #12]
20021774:	f000 fbc1 	bl	20021efa <HAL_Delay_us>
20021778:	68e3      	ldr	r3, [r4, #12]
2002177a:	4a07      	ldr	r2, [pc, #28]	@ (20021798 <sd1_init+0x34>)
2002177c:	f043 0310 	orr.w	r3, r3, #16
20021780:	60e3      	str	r3, [r4, #12]
20021782:	6913      	ldr	r3, [r2, #16]
20021784:	f043 0302 	orr.w	r3, r3, #2
20021788:	6113      	str	r3, [r2, #16]
2002178a:	f44f 7280 	mov.w	r2, #256	@ 0x100
2002178e:	4b03      	ldr	r3, [pc, #12]	@ (2002179c <sd1_init+0x38>)
20021790:	631a      	str	r2, [r3, #48]	@ 0x30
20021792:	2200      	movs	r2, #0
20021794:	63da      	str	r2, [r3, #60]	@ 0x3c
20021796:	bd10      	pop	{r4, pc}
20021798:	5000b000 	.word	0x5000b000
2002179c:	50045000 	.word	0x50045000

200217a0 <sd1_wait_cmd>:
200217a0:	4b08      	ldr	r3, [pc, #32]	@ (200217c4 <sd1_wait_cmd+0x24>)
200217a2:	681a      	ldr	r2, [r3, #0]
200217a4:	f012 0f0a 	tst.w	r2, #10
200217a8:	d0fb      	beq.n	200217a2 <sd1_wait_cmd+0x2>
200217aa:	2202      	movs	r2, #2
200217ac:	601a      	str	r2, [r3, #0]
200217ae:	681a      	ldr	r2, [r3, #0]
200217b0:	0712      	lsls	r2, r2, #28
200217b2:	bf5f      	itttt	pl
200217b4:	6818      	ldrpl	r0, [r3, #0]
200217b6:	f3c0 0080 	ubfxpl	r0, r0, #2, #1
200217ba:	0040      	lslpl	r0, r0, #1
200217bc:	b2c0      	uxtbpl	r0, r0
200217be:	bf48      	it	mi
200217c0:	2001      	movmi	r0, #1
200217c2:	4770      	bx	lr
200217c4:	50045000 	.word	0x50045000

200217c8 <sd1_send_cmd>:
200217c8:	4b0e      	ldr	r3, [pc, #56]	@ (20021804 <sd1_send_cmd+0x3c>)
200217ca:	280f      	cmp	r0, #15
200217cc:	6099      	str	r1, [r3, #8]
200217ce:	ea4f 4380 	mov.w	r3, r0, lsl #18
200217d2:	d813      	bhi.n	200217fc <sd1_send_cmd+0x34>
200217d4:	2201      	movs	r2, #1
200217d6:	f248 0111 	movw	r1, #32785	@ 0x8011
200217da:	4082      	lsls	r2, r0
200217dc:	420a      	tst	r2, r1
200217de:	d105      	bne.n	200217ec <sd1_send_cmd+0x24>
200217e0:	f240 6104 	movw	r1, #1540	@ 0x604
200217e4:	420a      	tst	r2, r1
200217e6:	d009      	beq.n	200217fc <sd1_send_cmd+0x34>
200217e8:	f443 3340 	orr.w	r3, r3, #196608	@ 0x30000
200217ec:	4a05      	ldr	r2, [pc, #20]	@ (20021804 <sd1_send_cmd+0x3c>)
200217ee:	f443 7380 	orr.w	r3, r3, #256	@ 0x100
200217f2:	f043 0301 	orr.w	r3, r3, #1
200217f6:	6053      	str	r3, [r2, #4]
200217f8:	f7ff bfd2 	b.w	200217a0 <sd1_wait_cmd>
200217fc:	f443 3380 	orr.w	r3, r3, #65536	@ 0x10000
20021800:	e7f4      	b.n	200217ec <sd1_send_cmd+0x24>
20021802:	bf00      	nop
20021804:	50045000 	.word	0x50045000

20021808 <sd1_send_acmd>:
20021808:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
2002180a:	4605      	mov	r5, r0
2002180c:	460f      	mov	r7, r1
2002180e:	2037      	movs	r0, #55	@ 0x37
20021810:	0411      	lsls	r1, r2, #16
20021812:	f7ff ffd9 	bl	200217c8 <sd1_send_cmd>
20021816:	4604      	mov	r4, r0
20021818:	b968      	cbnz	r0, 20021836 <sd1_send_acmd+0x2e>
2002181a:	4b08      	ldr	r3, [pc, #32]	@ (2002183c <sd1_send_acmd+0x34>)
2002181c:	4e08      	ldr	r6, [pc, #32]	@ (20021840 <sd1_send_acmd+0x38>)
2002181e:	ea43 4385 	orr.w	r3, r3, r5, lsl #18
20021822:	60b7      	str	r7, [r6, #8]
20021824:	6073      	str	r3, [r6, #4]
20021826:	f7ff ffbb 	bl	200217a0 <sd1_wait_cmd>
2002182a:	2802      	cmp	r0, #2
2002182c:	d104      	bne.n	20021838 <sd1_send_acmd+0x30>
2002182e:	2d29      	cmp	r5, #41	@ 0x29
20021830:	d102      	bne.n	20021838 <sd1_send_acmd+0x30>
20021832:	2304      	movs	r3, #4
20021834:	6033      	str	r3, [r6, #0]
20021836:	4620      	mov	r0, r4
20021838:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
2002183a:	bf00      	nop
2002183c:	00010101 	.word	0x00010101
20021840:	50045000 	.word	0x50045000

20021844 <sd1_get_rsp>:
20021844:	b530      	push	{r4, r5, lr}
20021846:	4c06      	ldr	r4, [pc, #24]	@ (20021860 <sd1_get_rsp+0x1c>)
20021848:	68e5      	ldr	r5, [r4, #12]
2002184a:	7005      	strb	r5, [r0, #0]
2002184c:	6920      	ldr	r0, [r4, #16]
2002184e:	6008      	str	r0, [r1, #0]
20021850:	6961      	ldr	r1, [r4, #20]
20021852:	6011      	str	r1, [r2, #0]
20021854:	69a2      	ldr	r2, [r4, #24]
20021856:	601a      	str	r2, [r3, #0]
20021858:	69e2      	ldr	r2, [r4, #28]
2002185a:	9b03      	ldr	r3, [sp, #12]
2002185c:	601a      	str	r2, [r3, #0]
2002185e:	bd30      	pop	{r4, r5, pc}
20021860:	50045000 	.word	0x50045000

20021864 <sd1_read>:
20021864:	f04f 33ff 	mov.w	r3, #4294967295
20021868:	4a04      	ldr	r2, [pc, #16]	@ (2002187c <sd1_read+0x18>)
2002186a:	eb03 2341 	add.w	r3, r3, r1, lsl #9
2002186e:	6293      	str	r3, [r2, #40]	@ 0x28
20021870:	4b03      	ldr	r3, [pc, #12]	@ (20021880 <sd1_read+0x1c>)
20021872:	ea43 23c0 	orr.w	r3, r3, r0, lsl #11
20021876:	6253      	str	r3, [r2, #36]	@ 0x24
20021878:	4770      	bx	lr
2002187a:	bf00      	nop
2002187c:	50045000 	.word	0x50045000
20021880:	01ff0301 	.word	0x01ff0301

20021884 <sd1_wait_read>:
20021884:	4b08      	ldr	r3, [pc, #32]	@ (200218a8 <sd1_wait_read+0x24>)
20021886:	681a      	ldr	r2, [r3, #0]
20021888:	f012 0fe0 	tst.w	r2, #224	@ 0xe0
2002188c:	d0fb      	beq.n	20021886 <sd1_wait_read+0x2>
2002188e:	2220      	movs	r2, #32
20021890:	601a      	str	r2, [r3, #0]
20021892:	681a      	ldr	r2, [r3, #0]
20021894:	0612      	lsls	r2, r2, #24
20021896:	bf5f      	itttt	pl
20021898:	6818      	ldrpl	r0, [r3, #0]
2002189a:	f3c0 1080 	ubfxpl	r0, r0, #6, #1
2002189e:	0040      	lslpl	r0, r0, #1
200218a0:	b2c0      	uxtbpl	r0, r0
200218a2:	bf48      	it	mi
200218a4:	2001      	movmi	r0, #1
200218a6:	4770      	bx	lr
200218a8:	50045000 	.word	0x50045000

200218ac <sdmmc1_sdnand>:
200218ac:	b5f0      	push	{r4, r5, r6, r7, lr}
200218ae:	b08d      	sub	sp, #52	@ 0x34
200218b0:	f7ff ff58 	bl	20021764 <sd1_init>
200218b4:	4c8f      	ldr	r4, [pc, #572]	@ (20021af4 <sdmmc1_sdnand+0x248>)
200218b6:	4b90      	ldr	r3, [pc, #576]	@ (20021af8 <sdmmc1_sdnand+0x24c>)
200218b8:	2500      	movs	r5, #0
200218ba:	6323      	str	r3, [r4, #48]	@ 0x30
200218bc:	6b23      	ldr	r3, [r4, #48]	@ 0x30
200218be:	f44f 70fa 	mov.w	r0, #500	@ 0x1f4
200218c2:	f043 0302 	orr.w	r3, r3, #2
200218c6:	6323      	str	r3, [r4, #48]	@ 0x30
200218c8:	f44f 1380 	mov.w	r3, #1048576	@ 0x100000
200218cc:	62e5      	str	r5, [r4, #44]	@ 0x2c
200218ce:	6223      	str	r3, [r4, #32]
200218d0:	f000 fb13 	bl	20021efa <HAL_Delay_us>
200218d4:	4629      	mov	r1, r5
200218d6:	4628      	mov	r0, r5
200218d8:	f7ff ff76 	bl	200217c8 <sd1_send_cmd>
200218dc:	2301      	movs	r3, #1
200218de:	65e3      	str	r3, [r4, #92]	@ 0x5c
200218e0:	6de3      	ldr	r3, [r4, #92]	@ 0x5c
200218e2:	079a      	lsls	r2, r3, #30
200218e4:	d5fc      	bpl.n	200218e0 <sdmmc1_sdnand+0x34>
200218e6:	2014      	movs	r0, #20
200218e8:	f000 fb07 	bl	20021efa <HAL_Delay_us>
200218ec:	f44f 71d5 	mov.w	r1, #426	@ 0x1aa
200218f0:	2008      	movs	r0, #8
200218f2:	f7ff ff69 	bl	200217c8 <sd1_send_cmd>
200218f6:	3801      	subs	r0, #1
200218f8:	b2c0      	uxtb	r0, r0
200218fa:	2801      	cmp	r0, #1
200218fc:	d802      	bhi.n	20021904 <sdmmc1_sdnand+0x58>
200218fe:	2038      	movs	r0, #56	@ 0x38
20021900:	b00d      	add	sp, #52	@ 0x34
20021902:	bdf0      	pop	{r4, r5, r6, r7, pc}
20021904:	ac07      	add	r4, sp, #28
20021906:	ab06      	add	r3, sp, #24
20021908:	9400      	str	r4, [sp, #0]
2002190a:	aa05      	add	r2, sp, #20
2002190c:	a904      	add	r1, sp, #16
2002190e:	f10d 000f 	add.w	r0, sp, #15
20021912:	f7ff ff97 	bl	20021844 <sd1_get_rsp>
20021916:	f89d 300f 	ldrb.w	r3, [sp, #15]
2002191a:	2b08      	cmp	r3, #8
2002191c:	d1ef      	bne.n	200218fe <sdmmc1_sdnand+0x52>
2002191e:	9b04      	ldr	r3, [sp, #16]
20021920:	f5b3 7fd5 	cmp.w	r3, #426	@ 0x1aa
20021924:	d1eb      	bne.n	200218fe <sdmmc1_sdnand+0x52>
20021926:	2014      	movs	r0, #20
20021928:	f000 fae7 	bl	20021efa <HAL_Delay_us>
2002192c:	2200      	movs	r2, #0
2002192e:	2029      	movs	r0, #41	@ 0x29
20021930:	4972      	ldr	r1, [pc, #456]	@ (20021afc <sdmmc1_sdnand+0x250>)
20021932:	f7ff ff69 	bl	20021808 <sd1_send_acmd>
20021936:	2801      	cmp	r0, #1
20021938:	f000 80d0 	beq.w	20021adc <sdmmc1_sdnand+0x230>
2002193c:	ab06      	add	r3, sp, #24
2002193e:	9400      	str	r4, [sp, #0]
20021940:	aa05      	add	r2, sp, #20
20021942:	a904      	add	r1, sp, #16
20021944:	f10d 000f 	add.w	r0, sp, #15
20021948:	f7ff ff7c 	bl	20021844 <sd1_get_rsp>
2002194c:	9b04      	ldr	r3, [sp, #16]
2002194e:	2b00      	cmp	r3, #0
20021950:	db03      	blt.n	2002195a <sdmmc1_sdnand+0xae>
20021952:	2002      	movs	r0, #2
20021954:	f000 fad1 	bl	20021efa <HAL_Delay_us>
20021958:	e7e5      	b.n	20021926 <sdmmc1_sdnand+0x7a>
2002195a:	2014      	movs	r0, #20
2002195c:	f000 facd 	bl	20021efa <HAL_Delay_us>
20021960:	2100      	movs	r1, #0
20021962:	2002      	movs	r0, #2
20021964:	f7ff ff30 	bl	200217c8 <sd1_send_cmd>
20021968:	3801      	subs	r0, #1
2002196a:	b2c0      	uxtb	r0, r0
2002196c:	2801      	cmp	r0, #1
2002196e:	f240 80b7 	bls.w	20021ae0 <sdmmc1_sdnand+0x234>
20021972:	ab08      	add	r3, sp, #32
20021974:	aa0a      	add	r2, sp, #40	@ 0x28
20021976:	a90b      	add	r1, sp, #44	@ 0x2c
20021978:	9300      	str	r3, [sp, #0]
2002197a:	f10d 000f 	add.w	r0, sp, #15
2002197e:	ab09      	add	r3, sp, #36	@ 0x24
20021980:	f7ff ff60 	bl	20021844 <sd1_get_rsp>
20021984:	2014      	movs	r0, #20
20021986:	f000 fab8 	bl	20021efa <HAL_Delay_us>
2002198a:	2100      	movs	r1, #0
2002198c:	2003      	movs	r0, #3
2002198e:	f7ff ff1b 	bl	200217c8 <sd1_send_cmd>
20021992:	3801      	subs	r0, #1
20021994:	b2c0      	uxtb	r0, r0
20021996:	2801      	cmp	r0, #1
20021998:	d801      	bhi.n	2002199e <sdmmc1_sdnand+0xf2>
2002199a:	2033      	movs	r0, #51	@ 0x33
2002199c:	e7b0      	b.n	20021900 <sdmmc1_sdnand+0x54>
2002199e:	ab06      	add	r3, sp, #24
200219a0:	9400      	str	r4, [sp, #0]
200219a2:	aa05      	add	r2, sp, #20
200219a4:	a904      	add	r1, sp, #16
200219a6:	f10d 000f 	add.w	r0, sp, #15
200219aa:	f7ff ff4b 	bl	20021844 <sd1_get_rsp>
200219ae:	f89d 300f 	ldrb.w	r3, [sp, #15]
200219b2:	2b03      	cmp	r3, #3
200219b4:	d1f1      	bne.n	2002199a <sdmmc1_sdnand+0xee>
200219b6:	9e04      	ldr	r6, [sp, #16]
200219b8:	2014      	movs	r0, #20
200219ba:	0c35      	lsrs	r5, r6, #16
200219bc:	042d      	lsls	r5, r5, #16
200219be:	f000 fa9c 	bl	20021efa <HAL_Delay_us>
200219c2:	4629      	mov	r1, r5
200219c4:	2009      	movs	r0, #9
200219c6:	f7ff feff 	bl	200217c8 <sd1_send_cmd>
200219ca:	3801      	subs	r0, #1
200219cc:	b2c0      	uxtb	r0, r0
200219ce:	2801      	cmp	r0, #1
200219d0:	f240 8088 	bls.w	20021ae4 <sdmmc1_sdnand+0x238>
200219d4:	9400      	str	r4, [sp, #0]
200219d6:	ab06      	add	r3, sp, #24
200219d8:	aa05      	add	r2, sp, #20
200219da:	a904      	add	r1, sp, #16
200219dc:	f10d 000f 	add.w	r0, sp, #15
200219e0:	f7ff ff30 	bl	20021844 <sd1_get_rsp>
200219e4:	e9dd 2004 	ldrd	r2, r0, [sp, #16]
200219e8:	9c06      	ldr	r4, [sp, #24]
200219ea:	9907      	ldr	r1, [sp, #28]
200219ec:	0e23      	lsrs	r3, r4, #24
200219ee:	ea43 2301 	orr.w	r3, r3, r1, lsl #8
200219f2:	0e01      	lsrs	r1, r0, #24
200219f4:	ea41 2104 	orr.w	r1, r1, r4, lsl #8
200219f8:	9105      	str	r1, [sp, #20]
200219fa:	0e11      	lsrs	r1, r2, #24
200219fc:	9304      	str	r3, [sp, #16]
200219fe:	ea41 2100 	orr.w	r1, r1, r0, lsl #8
20021a02:	0212      	lsls	r2, r2, #8
20021a04:	0f9b      	lsrs	r3, r3, #30
20021a06:	9106      	str	r1, [sp, #24]
20021a08:	9207      	str	r2, [sp, #28]
20021a0a:	d01e      	beq.n	20021a4a <sdmmc1_sdnand+0x19e>
20021a0c:	2b01      	cmp	r3, #1
20021a0e:	d16b      	bne.n	20021ae8 <sdmmc1_sdnand+0x23c>
20021a10:	2300      	movs	r3, #0
20021a12:	4a3b      	ldr	r2, [pc, #236]	@ (20021b00 <sdmmc1_sdnand+0x254>)
20021a14:	4c37      	ldr	r4, [pc, #220]	@ (20021af4 <sdmmc1_sdnand+0x248>)
20021a16:	7013      	strb	r3, [r2, #0]
20021a18:	f44f 63a0 	mov.w	r3, #1280	@ 0x500
20021a1c:	6323      	str	r3, [r4, #48]	@ 0x30
20021a1e:	6b23      	ldr	r3, [r4, #48]	@ 0x30
20021a20:	2702      	movs	r7, #2
20021a22:	f043 0302 	orr.w	r3, r3, #2
20021a26:	6323      	str	r3, [r4, #48]	@ 0x30
20021a28:	f04f 7300 	mov.w	r3, #33554432	@ 0x2000000
20021a2c:	2014      	movs	r0, #20
20021a2e:	6223      	str	r3, [r4, #32]
20021a30:	63e7      	str	r7, [r4, #60]	@ 0x3c
20021a32:	f000 fa62 	bl	20021efa <HAL_Delay_us>
20021a36:	4629      	mov	r1, r5
20021a38:	2007      	movs	r0, #7
20021a3a:	f7ff fec5 	bl	200217c8 <sd1_send_cmd>
20021a3e:	3801      	subs	r0, #1
20021a40:	b2c0      	uxtb	r0, r0
20021a42:	2801      	cmp	r0, #1
20021a44:	d803      	bhi.n	20021a4e <sdmmc1_sdnand+0x1a2>
20021a46:	2037      	movs	r0, #55	@ 0x37
20021a48:	e75a      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021a4a:	2301      	movs	r3, #1
20021a4c:	e7e1      	b.n	20021a12 <sdmmc1_sdnand+0x166>
20021a4e:	ad07      	add	r5, sp, #28
20021a50:	ab06      	add	r3, sp, #24
20021a52:	9500      	str	r5, [sp, #0]
20021a54:	aa05      	add	r2, sp, #20
20021a56:	a904      	add	r1, sp, #16
20021a58:	f10d 000f 	add.w	r0, sp, #15
20021a5c:	f7ff fef2 	bl	20021844 <sd1_get_rsp>
20021a60:	f89d 300f 	ldrb.w	r3, [sp, #15]
20021a64:	2b07      	cmp	r3, #7
20021a66:	d1ee      	bne.n	20021a46 <sdmmc1_sdnand+0x19a>
20021a68:	2014      	movs	r0, #20
20021a6a:	f000 fa46 	bl	20021efa <HAL_Delay_us>
20021a6e:	4639      	mov	r1, r7
20021a70:	2006      	movs	r0, #6
20021a72:	0c32      	lsrs	r2, r6, #16
20021a74:	f7ff fec8 	bl	20021808 <sd1_send_acmd>
20021a78:	3801      	subs	r0, #1
20021a7a:	b2c0      	uxtb	r0, r0
20021a7c:	2801      	cmp	r0, #1
20021a7e:	d935      	bls.n	20021aec <sdmmc1_sdnand+0x240>
20021a80:	2101      	movs	r1, #1
20021a82:	4608      	mov	r0, r1
20021a84:	f7ff feee 	bl	20021864 <sd1_read>
20021a88:	2014      	movs	r0, #20
20021a8a:	f000 fa36 	bl	20021efa <HAL_Delay_us>
20021a8e:	2100      	movs	r1, #0
20021a90:	2011      	movs	r0, #17
20021a92:	f7ff fe99 	bl	200217c8 <sd1_send_cmd>
20021a96:	3801      	subs	r0, #1
20021a98:	b2c0      	uxtb	r0, r0
20021a9a:	2801      	cmp	r0, #1
20021a9c:	d801      	bhi.n	20021aa2 <sdmmc1_sdnand+0x1f6>
20021a9e:	2052      	movs	r0, #82	@ 0x52
20021aa0:	e72e      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021aa2:	ab06      	add	r3, sp, #24
20021aa4:	9500      	str	r5, [sp, #0]
20021aa6:	aa05      	add	r2, sp, #20
20021aa8:	a904      	add	r1, sp, #16
20021aaa:	f10d 000f 	add.w	r0, sp, #15
20021aae:	f7ff fec9 	bl	20021844 <sd1_get_rsp>
20021ab2:	f89d 300f 	ldrb.w	r3, [sp, #15]
20021ab6:	2b11      	cmp	r3, #17
20021ab8:	d1f1      	bne.n	20021a9e <sdmmc1_sdnand+0x1f2>
20021aba:	f04f 33ff 	mov.w	r3, #4294967295
20021abe:	6023      	str	r3, [r4, #0]
20021ac0:	2320      	movs	r3, #32
20021ac2:	62e3      	str	r3, [r4, #44]	@ 0x2c
20021ac4:	f7ff fede 	bl	20021884 <sd1_wait_read>
20021ac8:	6823      	ldr	r3, [r4, #0]
20021aca:	061b      	lsls	r3, r3, #24
20021acc:	d410      	bmi.n	20021af0 <sdmmc1_sdnand+0x244>
20021ace:	6823      	ldr	r3, [r4, #0]
20021ad0:	f013 0f40 	tst.w	r3, #64	@ 0x40
20021ad4:	bf14      	ite	ne
20021ad6:	2044      	movne	r0, #68	@ 0x44
20021ad8:	2001      	moveq	r0, #1
20021ada:	e711      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021adc:	2034      	movs	r0, #52	@ 0x34
20021ade:	e70f      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021ae0:	2032      	movs	r0, #50	@ 0x32
20021ae2:	e70d      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021ae4:	2039      	movs	r0, #57	@ 0x39
20021ae6:	e70b      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021ae8:	2054      	movs	r0, #84	@ 0x54
20021aea:	e709      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021aec:	2036      	movs	r0, #54	@ 0x36
20021aee:	e707      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021af0:	204f      	movs	r0, #79	@ 0x4f
20021af2:	e705      	b.n	20021900 <sdmmc1_sdnand+0x54>
20021af4:	50045000 	.word	0x50045000
20021af8:	00016700 	.word	0x00016700
20021afc:	40ff8000 	.word	0x40ff8000
20021b00:	20042c08 	.word	0x20042c08

20021b04 <sd_read_data>:
20021b04:	b570      	push	{r4, r5, r6, lr}
20021b06:	460d      	mov	r5, r1
20021b08:	2101      	movs	r1, #1
20021b0a:	b088      	sub	sp, #32
20021b0c:	4606      	mov	r6, r0
20021b0e:	4608      	mov	r0, r1
20021b10:	4614      	mov	r4, r2
20021b12:	f7ff fea7 	bl	20021864 <sd1_read>
20021b16:	2014      	movs	r0, #20
20021b18:	f000 f9ef 	bl	20021efa <HAL_Delay_us>
20021b1c:	4b1a      	ldr	r3, [pc, #104]	@ (20021b88 <sd_read_data+0x84>)
20021b1e:	781b      	ldrb	r3, [r3, #0]
20021b20:	b903      	cbnz	r3, 20021b24 <sd_read_data+0x20>
20021b22:	0a76      	lsrs	r6, r6, #9
20021b24:	4631      	mov	r1, r6
20021b26:	2011      	movs	r0, #17
20021b28:	f7ff fe4e 	bl	200217c8 <sd1_send_cmd>
20021b2c:	3801      	subs	r0, #1
20021b2e:	b2c0      	uxtb	r0, r0
20021b30:	2801      	cmp	r0, #1
20021b32:	d802      	bhi.n	20021b3a <sd_read_data+0x36>
20021b34:	2000      	movs	r0, #0
20021b36:	b008      	add	sp, #32
20021b38:	bd70      	pop	{r4, r5, r6, pc}
20021b3a:	ab07      	add	r3, sp, #28
20021b3c:	9300      	str	r3, [sp, #0]
20021b3e:	aa05      	add	r2, sp, #20
20021b40:	ab06      	add	r3, sp, #24
20021b42:	a904      	add	r1, sp, #16
20021b44:	f10d 000f 	add.w	r0, sp, #15
20021b48:	f7ff fe7c 	bl	20021844 <sd1_get_rsp>
20021b4c:	f89d 300f 	ldrb.w	r3, [sp, #15]
20021b50:	2b11      	cmp	r3, #17
20021b52:	d1ef      	bne.n	20021b34 <sd_read_data+0x30>
20021b54:	f04f 33ff 	mov.w	r3, #4294967295
20021b58:	4e0c      	ldr	r6, [pc, #48]	@ (20021b8c <sd_read_data+0x88>)
20021b5a:	6033      	str	r3, [r6, #0]
20021b5c:	2320      	movs	r3, #32
20021b5e:	62f3      	str	r3, [r6, #44]	@ 0x2c
20021b60:	f7ff fe90 	bl	20021884 <sd1_wait_read>
20021b64:	6833      	ldr	r3, [r6, #0]
20021b66:	061a      	lsls	r2, r3, #24
20021b68:	d4e4      	bmi.n	20021b34 <sd_read_data+0x30>
20021b6a:	6833      	ldr	r3, [r6, #0]
20021b6c:	065b      	lsls	r3, r3, #25
20021b6e:	d4e1      	bmi.n	20021b34 <sd_read_data+0x30>
20021b70:	f024 0303 	bic.w	r3, r4, #3
20021b74:	442b      	add	r3, r5
20021b76:	429d      	cmp	r5, r3
20021b78:	d101      	bne.n	20021b7e <sd_read_data+0x7a>
20021b7a:	4620      	mov	r0, r4
20021b7c:	e7db      	b.n	20021b36 <sd_read_data+0x32>
20021b7e:	f8d6 2200 	ldr.w	r2, [r6, #512]	@ 0x200
20021b82:	f845 2b04 	str.w	r2, [r5], #4
20021b86:	e7f6      	b.n	20021b76 <sd_read_data+0x72>
20021b88:	20042c08 	.word	0x20042c08
20021b8c:	50045000 	.word	0x50045000

20021b90 <sifli_hash_calculate>:
20021b90:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20021b94:	460c      	mov	r4, r1
20021b96:	4615      	mov	r5, r2
20021b98:	4699      	mov	r9, r3
20021b9a:	4680      	mov	r8, r0
20021b9c:	2800      	cmp	r0, #0
20021b9e:	d03f      	beq.n	20021c20 <sifli_hash_calculate+0x90>
20021ba0:	2900      	cmp	r1, #0
20021ba2:	d03d      	beq.n	20021c20 <sifli_hash_calculate+0x90>
20021ba4:	2a00      	cmp	r2, #0
20021ba6:	d03b      	beq.n	20021c20 <sifli_hash_calculate+0x90>
20021ba8:	2b03      	cmp	r3, #3
20021baa:	d839      	bhi.n	20021c20 <sifli_hash_calculate+0x90>
20021bac:	f000 fab8 	bl	20022120 <HAL_HASH_reset>
20021bb0:	2200      	movs	r2, #0
20021bb2:	4649      	mov	r1, r9
20021bb4:	4610      	mov	r0, r2
20021bb6:	f000 fabb 	bl	20022130 <HAL_HASH_init>
20021bba:	f5b4 7f80 	cmp.w	r4, #256	@ 0x100
20021bbe:	d929      	bls.n	20021c14 <sifli_hash_calculate+0x84>
20021bc0:	2600      	movs	r6, #0
20021bc2:	4637      	mov	r7, r6
20021bc4:	f506 7680 	add.w	r6, r6, #256	@ 0x100
20021bc8:	42a6      	cmp	r6, r4
20021bca:	bf34      	ite	cc
20021bcc:	f04f 0a00 	movcc.w	sl, #0
20021bd0:	f04f 0a01 	movcs.w	sl, #1
20021bd4:	b14f      	cbz	r7, 20021bea <sifli_hash_calculate+0x5a>
20021bd6:	f000 faa3 	bl	20022120 <HAL_HASH_reset>
20021bda:	42a6      	cmp	r6, r4
20021bdc:	bf2c      	ite	cs
20021bde:	463a      	movcs	r2, r7
20021be0:	2200      	movcc	r2, #0
20021be2:	4649      	mov	r1, r9
20021be4:	4628      	mov	r0, r5
20021be6:	f000 faa3 	bl	20022130 <HAL_HASH_init>
20021bea:	42a6      	cmp	r6, r4
20021bec:	bf34      	ite	cc
20021bee:	f44f 7180 	movcc.w	r1, #256	@ 0x100
20021bf2:	1be1      	subcs	r1, r4, r7
20021bf4:	4652      	mov	r2, sl
20021bf6:	eb08 0007 	add.w	r0, r8, r7
20021bfa:	f000 fa73 	bl	200220e4 <HAL_HASH_run>
20021bfe:	4628      	mov	r0, r5
20021c00:	f000 fac4 	bl	2002218c <HAL_HASH_result>
20021c04:	42a6      	cmp	r6, r4
20021c06:	d3dc      	bcc.n	20021bc2 <sifli_hash_calculate+0x32>
20021c08:	4628      	mov	r0, r5
20021c0a:	f000 fabf 	bl	2002218c <HAL_HASH_result>
20021c0e:	2000      	movs	r0, #0
20021c10:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
20021c14:	2201      	movs	r2, #1
20021c16:	4621      	mov	r1, r4
20021c18:	4640      	mov	r0, r8
20021c1a:	f000 fa63 	bl	200220e4 <HAL_HASH_run>
20021c1e:	e7f3      	b.n	20021c08 <sifli_hash_calculate+0x78>
20021c20:	f04f 30ff 	mov.w	r0, #4294967295
20021c24:	e7f4      	b.n	20021c10 <sifli_hash_calculate+0x80>

20021c26 <sifli_hash_verify>:
20021c26:	b5f0      	push	{r4, r5, r6, r7, lr}
20021c28:	4605      	mov	r5, r0
20021c2a:	b089      	sub	sp, #36	@ 0x24
20021c2c:	460f      	mov	r7, r1
20021c2e:	4614      	mov	r4, r2
20021c30:	2100      	movs	r1, #0
20021c32:	2220      	movs	r2, #32
20021c34:	4668      	mov	r0, sp
20021c36:	461e      	mov	r6, r3
20021c38:	f008 fe0c 	bl	2002a854 <memset>
20021c3c:	b91d      	cbnz	r5, 20021c46 <sifli_hash_verify+0x20>
20021c3e:	f04f 30ff 	mov.w	r0, #4294967295
20021c42:	b009      	add	sp, #36	@ 0x24
20021c44:	bdf0      	pop	{r4, r5, r6, r7, pc}
20021c46:	2c00      	cmp	r4, #0
20021c48:	d0f9      	beq.n	20021c3e <sifli_hash_verify+0x18>
20021c4a:	2302      	movs	r3, #2
20021c4c:	466a      	mov	r2, sp
20021c4e:	4639      	mov	r1, r7
20021c50:	4628      	mov	r0, r5
20021c52:	f7ff ff9d 	bl	20021b90 <sifli_hash_calculate>
20021c56:	2800      	cmp	r0, #0
20021c58:	d1f1      	bne.n	20021c3e <sifli_hash_verify+0x18>
20021c5a:	4632      	mov	r2, r6
20021c5c:	4621      	mov	r1, r4
20021c5e:	4668      	mov	r0, sp
20021c60:	f008 fde8 	bl	2002a834 <memcmp>
20021c64:	3800      	subs	r0, #0
20021c66:	bf18      	it	ne
20021c68:	2001      	movne	r0, #1
20021c6a:	4240      	negs	r0, r0
20021c6c:	e7e9      	b.n	20021c42 <sifli_hash_verify+0x1c>

20021c6e <sifli_sigkey_pub_verify>:
20021c6e:	2300      	movs	r3, #0
20021c70:	b537      	push	{r0, r1, r2, r4, r5, lr}
20021c72:	4604      	mov	r4, r0
20021c74:	460d      	mov	r5, r1
20021c76:	2208      	movs	r2, #8
20021c78:	4669      	mov	r1, sp
20021c7a:	2003      	movs	r0, #3
20021c7c:	e9cd 3300 	strd	r3, r3, [sp]
20021c80:	f7ff f9d0 	bl	20021024 <sifli_hw_efuse_read>
20021c84:	2808      	cmp	r0, #8
20021c86:	4603      	mov	r3, r0
20021c88:	d106      	bne.n	20021c98 <sifli_sigkey_pub_verify+0x2a>
20021c8a:	466a      	mov	r2, sp
20021c8c:	4629      	mov	r1, r5
20021c8e:	4620      	mov	r0, r4
20021c90:	f7ff ffc9 	bl	20021c26 <sifli_hash_verify>
20021c94:	b003      	add	sp, #12
20021c96:	bd30      	pop	{r4, r5, pc}
20021c98:	f04f 30ff 	mov.w	r0, #4294967295
20021c9c:	e7fa      	b.n	20021c94 <sifli_sigkey_pub_verify+0x26>

20021c9e <sifli_img_sig_hash_verify>:
20021c9e:	b5f0      	push	{r4, r5, r6, r7, lr}
20021ca0:	461f      	mov	r7, r3
20021ca2:	4616      	mov	r6, r2
20021ca4:	b08d      	sub	sp, #52	@ 0x34
20021ca6:	2220      	movs	r2, #32
20021ca8:	4604      	mov	r4, r0
20021caa:	460d      	mov	r5, r1
20021cac:	a804      	add	r0, sp, #16
20021cae:	2100      	movs	r1, #0
20021cb0:	f008 fdd0 	bl	2002a854 <memset>
20021cb4:	2302      	movs	r3, #2
20021cb6:	4639      	mov	r1, r7
20021cb8:	4630      	mov	r0, r6
20021cba:	aa04      	add	r2, sp, #16
20021cbc:	f7ff ff68 	bl	20021b90 <sifli_hash_calculate>
20021cc0:	b118      	cbz	r0, 20021cca <sifli_img_sig_hash_verify+0x2c>
20021cc2:	f04f 30ff 	mov.w	r0, #4294967295
20021cc6:	b00d      	add	sp, #52	@ 0x34
20021cc8:	bdf0      	pop	{r4, r5, r6, r7, pc}
20021cca:	a802      	add	r0, sp, #8
20021ccc:	f007 fb36 	bl	2002933c <mbedtls_pk_init>
20021cd0:	4629      	mov	r1, r5
20021cd2:	f44f 7293 	mov.w	r2, #294	@ 0x126
20021cd6:	a802      	add	r0, sp, #8
20021cd8:	f007 fc3c 	bl	20029554 <mbedtls_pk_parse_public_key>
20021cdc:	4601      	mov	r1, r0
20021cde:	2800      	cmp	r0, #0
20021ce0:	d1ef      	bne.n	20021cc2 <sifli_img_sig_hash_verify+0x24>
20021ce2:	2206      	movs	r2, #6
20021ce4:	9803      	ldr	r0, [sp, #12]
20021ce6:	f007 fcdc 	bl	200296a2 <mbedtls_rsa_set_padding>
20021cea:	f44f 7380 	mov.w	r3, #256	@ 0x100
20021cee:	2106      	movs	r1, #6
20021cf0:	e9cd 4300 	strd	r4, r3, [sp]
20021cf4:	aa04      	add	r2, sp, #16
20021cf6:	2320      	movs	r3, #32
20021cf8:	a802      	add	r0, sp, #8
20021cfa:	f007 fb53 	bl	200293a4 <mbedtls_pk_verify>
20021cfe:	3800      	subs	r0, #0
20021d00:	bf18      	it	ne
20021d02:	2001      	movne	r0, #1
20021d04:	4240      	negs	r0, r0
20021d06:	e7de      	b.n	20021cc6 <sifli_img_sig_hash_verify+0x28>

20021d08 <sifli_secboot_exception>:
20021d08:	2801      	cmp	r0, #1
20021d0a:	b508      	push	{r3, lr}
20021d0c:	d004      	beq.n	20021d18 <sifli_secboot_exception+0x10>
20021d0e:	2802      	cmp	r0, #2
20021d10:	d009      	beq.n	20021d26 <sifli_secboot_exception+0x1e>
20021d12:	2213      	movs	r2, #19
20021d14:	4905      	ldr	r1, [pc, #20]	@ (20021d2c <sifli_secboot_exception+0x24>)
20021d16:	e001      	b.n	20021d1c <sifli_secboot_exception+0x14>
20021d18:	2217      	movs	r2, #23
20021d1a:	4905      	ldr	r1, [pc, #20]	@ (20021d30 <sifli_secboot_exception+0x28>)
20021d1c:	4805      	ldr	r0, [pc, #20]	@ (20021d34 <sifli_secboot_exception+0x2c>)
20021d1e:	f7fe fabb 	bl	20020298 <boot_uart_tx>
20021d22:	e7fe      	b.n	20021d22 <sifli_secboot_exception+0x1a>
20021d24:	bd08      	pop	{r3, pc}
20021d26:	2219      	movs	r2, #25
20021d28:	4903      	ldr	r1, [pc, #12]	@ (20021d38 <sifli_secboot_exception+0x30>)
20021d2a:	e7f7      	b.n	20021d1c <sifli_secboot_exception+0x14>
20021d2c:	2002a9d2 	.word	0x2002a9d2
20021d30:	2002a9a0 	.word	0x2002a9a0
20021d34:	50084000 	.word	0x50084000
20021d38:	2002a9b8 	.word	0x2002a9b8

20021d3c <BSP_GetFlash1DIV>:
20021d3c:	4b01      	ldr	r3, [pc, #4]	@ (20021d44 <BSP_GetFlash1DIV+0x8>)
20021d3e:	8818      	ldrh	r0, [r3, #0]
20021d40:	4770      	bx	lr
20021d42:	bf00      	nop
20021d44:	20042c0c 	.word	0x20042c0c

20021d48 <BSP_GetFlash2DIV>:
20021d48:	4b01      	ldr	r3, [pc, #4]	@ (20021d50 <BSP_GetFlash2DIV+0x8>)
20021d4a:	8818      	ldrh	r0, [r3, #0]
20021d4c:	4770      	bx	lr
20021d4e:	bf00      	nop
20021d50:	20042c0a 	.word	0x20042c0a

20021d54 <BSP_SetFlash1DIV>:
20021d54:	4b01      	ldr	r3, [pc, #4]	@ (20021d5c <BSP_SetFlash1DIV+0x8>)
20021d56:	8018      	strh	r0, [r3, #0]
20021d58:	4770      	bx	lr
20021d5a:	bf00      	nop
20021d5c:	20042c0c 	.word	0x20042c0c

20021d60 <BSP_SetFlash2DIV>:
20021d60:	4b01      	ldr	r3, [pc, #4]	@ (20021d68 <BSP_SetFlash2DIV+0x8>)
20021d62:	8018      	strh	r0, [r3, #0]
20021d64:	4770      	bx	lr
20021d66:	bf00      	nop
20021d68:	20042c0a 	.word	0x20042c0a

20021d6c <boot_images>:
20021d6c:	4770      	bx	lr

20021d6e <SystemPowerOnModeInit>:
20021d6e:	4770      	bx	lr

20021d70 <SystemInit>:
20021d70:	b508      	push	{r3, lr}
20021d72:	4a10      	ldr	r2, [pc, #64]	@ (20021db4 <SystemInit+0x44>)
20021d74:	4b10      	ldr	r3, [pc, #64]	@ (20021db8 <SystemInit+0x48>)
20021d76:	609a      	str	r2, [r3, #8]
20021d78:	f8d3 2088 	ldr.w	r2, [r3, #136]	@ 0x88
20021d7c:	f042 023f 	orr.w	r2, r2, #63	@ 0x3f
20021d80:	f8c3 2088 	str.w	r2, [r3, #136]	@ 0x88
20021d84:	f8d3 2088 	ldr.w	r2, [r3, #136]	@ 0x88
20021d88:	f442 0270 	orr.w	r2, r2, #15728640	@ 0xf00000
20021d8c:	f8c3 2088 	str.w	r2, [r3, #136]	@ 0x88
20021d90:	f7ff fb28 	bl	200213e4 <hw_preinit0>
20021d94:	f7fe faba 	bl	2002030c <mpu_config>
20021d98:	4b08      	ldr	r3, [pc, #32]	@ (20021dbc <SystemInit+0x4c>)
20021d9a:	681b      	ldr	r3, [r3, #0]
20021d9c:	07db      	lsls	r3, r3, #31
20021d9e:	d401      	bmi.n	20021da4 <SystemInit+0x34>
20021da0:	f7ff ffe4 	bl	20021d6c <boot_images>
20021da4:	f7fe fab3 	bl	2002030e <cache_enable>
20021da8:	f7ff ffe1 	bl	20021d6e <SystemPowerOnModeInit>
20021dac:	4b04      	ldr	r3, [pc, #16]	@ (20021dc0 <SystemInit+0x50>)
20021dae:	4a05      	ldr	r2, [pc, #20]	@ (20021dc4 <SystemInit+0x54>)
20021db0:	601a      	str	r2, [r3, #0]
20021db2:	bd08      	pop	{r3, pc}
20021db4:	20020000 	.word	0x20020000
20021db8:	e000ed00 	.word	0xe000ed00
20021dbc:	5000b000 	.word	0x5000b000
20021dc0:	20042c10 	.word	0x20042c10
20021dc4:	017d7840 	.word	0x017d7840

20021dc8 <Reset_Handler>:
20021dc8:	f8df d048 	ldr.w	sp, [pc, #72]	@ 20021e14 <AES_IRQHandler+0x2>
20021dcc:	4812      	ldr	r0, [pc, #72]	@ (20021e18 <AES_IRQHandler+0x6>)
20021dce:	f380 880a 	msr	MSPLIM, r0
20021dd2:	f7ff ffcd 	bl	20021d70 <SystemInit>
20021dd6:	4c11      	ldr	r4, [pc, #68]	@ (20021e1c <AES_IRQHandler+0xa>)
20021dd8:	4d11      	ldr	r5, [pc, #68]	@ (20021e20 <AES_IRQHandler+0xe>)
20021dda:	42ac      	cmp	r4, r5
20021ddc:	da09      	bge.n	20021df2 <Reset_Handler+0x2a>
20021dde:	6821      	ldr	r1, [r4, #0]
20021de0:	6862      	ldr	r2, [r4, #4]
20021de2:	68a3      	ldr	r3, [r4, #8]
20021de4:	3b04      	subs	r3, #4
20021de6:	bfa2      	ittt	ge
20021de8:	58c8      	ldrge	r0, [r1, r3]
20021dea:	50d0      	strge	r0, [r2, r3]
20021dec:	e7fa      	bge.n	20021de4 <Reset_Handler+0x1c>
20021dee:	340c      	adds	r4, #12
20021df0:	e7f3      	b.n	20021dda <Reset_Handler+0x12>
20021df2:	4b0c      	ldr	r3, [pc, #48]	@ (20021e24 <AES_IRQHandler+0x12>)
20021df4:	4c0c      	ldr	r4, [pc, #48]	@ (20021e28 <AES_IRQHandler+0x16>)
20021df6:	42a3      	cmp	r3, r4
20021df8:	da08      	bge.n	20021e0c <Reset_Handler+0x44>
20021dfa:	6819      	ldr	r1, [r3, #0]
20021dfc:	685a      	ldr	r2, [r3, #4]
20021dfe:	2000      	movs	r0, #0
20021e00:	3a04      	subs	r2, #4
20021e02:	bfa4      	itt	ge
20021e04:	5088      	strge	r0, [r1, r2]
20021e06:	e7fb      	bge.n	20021e00 <Reset_Handler+0x38>
20021e08:	3308      	adds	r3, #8
20021e0a:	e7f4      	b.n	20021df6 <Reset_Handler+0x2e>
20021e0c:	f7ff fb10 	bl	20021430 <entry>

20021e10 <HardFault_Handler>:
20021e10:	e7fe      	b.n	20021e10 <HardFault_Handler>

20021e12 <AES_IRQHandler>:
20021e12:	e7fe      	b.n	20021e12 <AES_IRQHandler>
20021e14:	20042000 	.word	0x20042000
20021e18:	20040000 	.word	0x20040000
20021e1c:	2002c3f0 	.word	0x2002c3f0
20021e20:	2002c3fc 	.word	0x2002c3fc
20021e24:	2002c3fc 	.word	0x2002c3fc
20021e28:	2002c404 	.word	0x2002c404

20021e2c <__aeabi_unwind_cpp_pr0>:
20021e2c:	2000      	movs	r0, #0
20021e2e:	4770      	bx	lr

20021e30 <HAL_GetTick>:
20021e30:	4b01      	ldr	r3, [pc, #4]	@ (20021e38 <HAL_GetTick+0x8>)
20021e32:	6818      	ldr	r0, [r3, #0]
20021e34:	4770      	bx	lr
20021e36:	bf00      	nop
20021e38:	20049ed8 	.word	0x20049ed8

20021e3c <HAL_Delay_us_>:
20021e3c:	b513      	push	{r0, r1, r4, lr}
20021e3e:	9001      	str	r0, [sp, #4]
20021e40:	9b01      	ldr	r3, [sp, #4]
20021e42:	4c1a      	ldr	r4, [pc, #104]	@ (20021eac <HAL_Delay_us_+0x70>)
20021e44:	b133      	cbz	r3, 20021e54 <HAL_Delay_us_+0x18>
20021e46:	6823      	ldr	r3, [r4, #0]
20021e48:	b123      	cbz	r3, 20021e54 <HAL_Delay_us_+0x18>
20021e4a:	9b01      	ldr	r3, [sp, #4]
20021e4c:	f1b3 7f80 	cmp.w	r3, #16777216	@ 0x1000000
20021e50:	d90c      	bls.n	20021e6c <HAL_Delay_us_+0x30>
20021e52:	e7fe      	b.n	20021e52 <HAL_Delay_us_+0x16>
20021e54:	2000      	movs	r0, #0
20021e56:	f003 f8d3 	bl	20025000 <HAL_RCC_GetHCLKFreq>
20021e5a:	4b15      	ldr	r3, [pc, #84]	@ (20021eb0 <HAL_Delay_us_+0x74>)
20021e5c:	fbb0 f0f3 	udiv	r0, r0, r3
20021e60:	9b01      	ldr	r3, [sp, #4]
20021e62:	6020      	str	r0, [r4, #0]
20021e64:	2b00      	cmp	r3, #0
20021e66:	d1f0      	bne.n	20021e4a <HAL_Delay_us_+0xe>
20021e68:	b002      	add	sp, #8
20021e6a:	bd10      	pop	{r4, pc}
20021e6c:	9b01      	ldr	r3, [sp, #4]
20021e6e:	2b00      	cmp	r3, #0
20021e70:	d0fa      	beq.n	20021e68 <HAL_Delay_us_+0x2c>
20021e72:	4a10      	ldr	r2, [pc, #64]	@ (20021eb4 <HAL_Delay_us_+0x78>)
20021e74:	6813      	ldr	r3, [r2, #0]
20021e76:	f013 0301 	ands.w	r3, r3, #1
20021e7a:	d10d      	bne.n	20021e98 <HAL_Delay_us_+0x5c>
20021e7c:	480e      	ldr	r0, [pc, #56]	@ (20021eb8 <HAL_Delay_us_+0x7c>)
20021e7e:	f8d0 10fc 	ldr.w	r1, [r0, #252]	@ 0xfc
20021e82:	f041 7180 	orr.w	r1, r1, #16777216	@ 0x1000000
20021e86:	f8c0 10fc 	str.w	r1, [r0, #252]	@ 0xfc
20021e8a:	6053      	str	r3, [r2, #4]
20021e8c:	6813      	ldr	r3, [r2, #0]
20021e8e:	f443 3300 	orr.w	r3, r3, #131072	@ 0x20000
20021e92:	f043 0301 	orr.w	r3, r3, #1
20021e96:	6013      	str	r3, [r2, #0]
20021e98:	9b01      	ldr	r3, [sp, #4]
20021e9a:	6822      	ldr	r2, [r4, #0]
20021e9c:	4905      	ldr	r1, [pc, #20]	@ (20021eb4 <HAL_Delay_us_+0x78>)
20021e9e:	4353      	muls	r3, r2
20021ea0:	6848      	ldr	r0, [r1, #4]
20021ea2:	684a      	ldr	r2, [r1, #4]
20021ea4:	1a12      	subs	r2, r2, r0
20021ea6:	429a      	cmp	r2, r3
20021ea8:	d3fb      	bcc.n	20021ea2 <HAL_Delay_us_+0x66>
20021eaa:	e7dd      	b.n	20021e68 <HAL_Delay_us_+0x2c>
20021eac:	20049ed4 	.word	0x20049ed4
20021eb0:	000f4240 	.word	0x000f4240
20021eb4:	e0001000 	.word	0xe0001000
20021eb8:	e000ed00 	.word	0xe000ed00

20021ebc <HAL_Delay_us2_>:
20021ebc:	b537      	push	{r0, r1, r2, r4, r5, lr}
20021ebe:	9001      	str	r0, [sp, #4]
20021ec0:	f04f 20e0 	mov.w	r0, #3758153728	@ 0xe000e000
20021ec4:	f44f 727a 	mov.w	r2, #1000	@ 0x3e8
20021ec8:	6944      	ldr	r4, [r0, #20]
20021eca:	9b01      	ldr	r3, [sp, #4]
20021ecc:	4363      	muls	r3, r4
20021ece:	fbb3 f3f2 	udiv	r3, r3, r2
20021ed2:	9301      	str	r3, [sp, #4]
20021ed4:	2300      	movs	r3, #0
20021ed6:	6981      	ldr	r1, [r0, #24]
20021ed8:	6982      	ldr	r2, [r0, #24]
20021eda:	428a      	cmp	r2, r1
20021edc:	d0fc      	beq.n	20021ed8 <HAL_Delay_us2_+0x1c>
20021ede:	bf25      	ittet	cs
20021ee0:	1aa5      	subcs	r5, r4, r2
20021ee2:	195b      	addcs	r3, r3, r5
20021ee4:	185b      	addcc	r3, r3, r1
20021ee6:	185b      	addcs	r3, r3, r1
20021ee8:	9901      	ldr	r1, [sp, #4]
20021eea:	bf38      	it	cc
20021eec:	1a9b      	subcc	r3, r3, r2
20021eee:	4299      	cmp	r1, r3
20021ef0:	d801      	bhi.n	20021ef6 <HAL_Delay_us2_+0x3a>
20021ef2:	b003      	add	sp, #12
20021ef4:	bd30      	pop	{r4, r5, pc}
20021ef6:	4611      	mov	r1, r2
20021ef8:	e7ee      	b.n	20021ed8 <HAL_Delay_us2_+0x1c>

20021efa <HAL_Delay_us>:
20021efa:	4603      	mov	r3, r0
20021efc:	b570      	push	{r4, r5, r6, lr}
20021efe:	b1b8      	cbz	r0, 20021f30 <HAL_Delay_us+0x36>
20021f00:	f242 7510 	movw	r5, #10000	@ 0x2710
20021f04:	f04f 26e0 	mov.w	r6, #3758153728	@ 0xe000e000
20021f08:	42ab      	cmp	r3, r5
20021f0a:	bf84      	itt	hi
20021f0c:	f5a3 541c 	subhi.w	r4, r3, #9984	@ 0x2700
20021f10:	f242 7310 	movwhi	r3, #10000	@ 0x2710
20021f14:	6932      	ldr	r2, [r6, #16]
20021f16:	bf98      	it	ls
20021f18:	2400      	movls	r4, #0
20021f1a:	4618      	mov	r0, r3
20021f1c:	bf88      	it	hi
20021f1e:	3c10      	subhi	r4, #16
20021f20:	07d3      	lsls	r3, r2, #31
20021f22:	d408      	bmi.n	20021f36 <HAL_Delay_us+0x3c>
20021f24:	f7ff ff8a 	bl	20021e3c <HAL_Delay_us_>
20021f28:	4623      	mov	r3, r4
20021f2a:	2c00      	cmp	r4, #0
20021f2c:	d1ec      	bne.n	20021f08 <HAL_Delay_us+0xe>
20021f2e:	e001      	b.n	20021f34 <HAL_Delay_us+0x3a>
20021f30:	f7ff ff84 	bl	20021e3c <HAL_Delay_us_>
20021f34:	bd70      	pop	{r4, r5, r6, pc}
20021f36:	f7ff ffc1 	bl	20021ebc <HAL_Delay_us2_>
20021f3a:	e7f5      	b.n	20021f28 <HAL_Delay_us+0x2e>

20021f3c <WDT_IRQHandler>:
20021f3c:	4770      	bx	lr

20021f3e <DBG_Trigger_IRQHandler>:
20021f3e:	4770      	bx	lr

20021f40 <NMI_Handler>:
20021f40:	b508      	push	{r3, lr}
20021f42:	4b05      	ldr	r3, [pc, #20]	@ (20021f58 <NMI_Handler+0x18>)
20021f44:	6a1b      	ldr	r3, [r3, #32]
20021f46:	005b      	lsls	r3, r3, #1
20021f48:	d502      	bpl.n	20021f50 <NMI_Handler+0x10>
20021f4a:	f7ff fff8 	bl	20021f3e <DBG_Trigger_IRQHandler>
20021f4e:	bd08      	pop	{r3, pc}
20021f50:	f7ff fff4 	bl	20021f3c <WDT_IRQHandler>
20021f54:	e7fb      	b.n	20021f4e <NMI_Handler+0xe>
20021f56:	bf00      	nop
20021f58:	5000b000 	.word	0x5000b000

20021f5c <HAL_AES_run_help>:
20021f5c:	b510      	push	{r4, lr}
20021f5e:	f101 4470 	add.w	r4, r1, #4026531840	@ 0xf0000000
20021f62:	f1b4 5f80 	cmp.w	r4, #268435456	@ 0x10000000
20021f66:	4c0e      	ldr	r4, [pc, #56]	@ (20021fa0 <HAL_AES_run_help+0x44>)
20021f68:	bf38      	it	cc
20021f6a:	f101 41a0 	addcc.w	r1, r1, #1342177280	@ 0x50000000
20021f6e:	6161      	str	r1, [r4, #20]
20021f70:	f102 4170 	add.w	r1, r2, #4026531840	@ 0xf0000000
20021f74:	f1b1 5f80 	cmp.w	r1, #268435456	@ 0x10000000
20021f78:	f103 030f 	add.w	r3, r3, #15
20021f7c:	ea4f 1323 	mov.w	r3, r3, asr #4
20021f80:	bf38      	it	cc
20021f82:	f102 42a0 	addcc.w	r2, r2, #1342177280	@ 0x50000000
20021f86:	61a2      	str	r2, [r4, #24]
20021f88:	61e3      	str	r3, [r4, #28]
20021f8a:	6923      	ldr	r3, [r4, #16]
20021f8c:	b108      	cbz	r0, 20021f92 <HAL_AES_run_help+0x36>
20021f8e:	ea43 13c0 	orr.w	r3, r3, r0, lsl #7
20021f92:	4a03      	ldr	r2, [pc, #12]	@ (20021fa0 <HAL_AES_run_help+0x44>)
20021f94:	6123      	str	r3, [r4, #16]
20021f96:	6813      	ldr	r3, [r2, #0]
20021f98:	f043 0301 	orr.w	r3, r3, #1
20021f9c:	6013      	str	r3, [r2, #0]
20021f9e:	bd10      	pop	{r4, pc}
20021fa0:	5000d000 	.word	0x5000d000

20021fa4 <HAL_HASH_run_help.isra.0>:
20021fa4:	f100 4370 	add.w	r3, r0, #4026531840	@ 0xf0000000
20021fa8:	b510      	push	{r4, lr}
20021faa:	f1b3 5f80 	cmp.w	r3, #268435456	@ 0x10000000
20021fae:	4c09      	ldr	r4, [pc, #36]	@ (20021fd4 <HAL_HASH_run_help.isra.0+0x30>)
20021fb0:	bf38      	it	cc
20021fb2:	f100 40a0 	addcc.w	r0, r0, #1342177280	@ 0x50000000
20021fb6:	6560      	str	r0, [r4, #84]	@ 0x54
20021fb8:	65a1      	str	r1, [r4, #88]	@ 0x58
20021fba:	b11a      	cbz	r2, 20021fc4 <HAL_HASH_run_help.isra.0+0x20>
20021fbc:	6d23      	ldr	r3, [r4, #80]	@ 0x50
20021fbe:	f043 0308 	orr.w	r3, r3, #8
20021fc2:	6523      	str	r3, [r4, #80]	@ 0x50
20021fc4:	6d21      	ldr	r1, [r4, #80]	@ 0x50
20021fc6:	4804      	ldr	r0, [pc, #16]	@ (20021fd8 <HAL_HASH_run_help.isra.0+0x34>)
20021fc8:	f000 fd79 	bl	20022abe <HAL_DBG_printf>
20021fcc:	2304      	movs	r3, #4
20021fce:	6023      	str	r3, [r4, #0]
20021fd0:	bd10      	pop	{r4, pc}
20021fd2:	bf00      	nop
20021fd4:	5000d000 	.word	0x5000d000
20021fd8:	2002a9e6 	.word	0x2002a9e6

20021fdc <HAL_AES_reset>:
20021fdc:	2202      	movs	r2, #2
20021fde:	2000      	movs	r0, #0
20021fe0:	4b01      	ldr	r3, [pc, #4]	@ (20021fe8 <HAL_AES_reset+0xc>)
20021fe2:	601a      	str	r2, [r3, #0]
20021fe4:	6018      	str	r0, [r3, #0]
20021fe6:	4770      	bx	lr
20021fe8:	5000d000 	.word	0x5000d000

20021fec <HAL_AES_init>:
20021fec:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20021fee:	461f      	mov	r7, r3
20021ff0:	4b1e      	ldr	r3, [pc, #120]	@ (2002206c <HAL_AES_init+0x80>)
20021ff2:	4604      	mov	r4, r0
20021ff4:	685b      	ldr	r3, [r3, #4]
20021ff6:	4616      	mov	r6, r2
20021ff8:	07db      	lsls	r3, r3, #31
20021ffa:	d501      	bpl.n	20022000 <HAL_AES_init+0x14>
20021ffc:	f7ff ffee 	bl	20021fdc <HAL_AES_reset>
20022000:	fab4 f084 	clz	r0, r4
20022004:	2918      	cmp	r1, #24
20022006:	ea4f 1050 	mov.w	r0, r0, lsr #5
2002200a:	ea4f 1540 	mov.w	r5, r0, lsl #5
2002200e:	d01c      	beq.n	2002204a <HAL_AES_init+0x5e>
20022010:	2920      	cmp	r1, #32
20022012:	d01c      	beq.n	2002204e <HAL_AES_init+0x62>
20022014:	2910      	cmp	r1, #16
20022016:	d125      	bne.n	20022064 <HAL_AES_init+0x78>
20022018:	2300      	movs	r3, #0
2002201a:	b164      	cbz	r4, 20022036 <HAL_AES_init+0x4a>
2002201c:	4620      	mov	r0, r4
2002201e:	4a14      	ldr	r2, [pc, #80]	@ (20022070 <HAL_AES_init+0x84>)
20022020:	f021 0103 	bic.w	r1, r1, #3
20022024:	4421      	add	r1, r4
20022026:	1b12      	subs	r2, r2, r4
20022028:	1814      	adds	r4, r2, r0
2002202a:	f850 cb04 	ldr.w	ip, [r0], #4
2002202e:	4281      	cmp	r1, r0
20022030:	f8c4 c000 	str.w	ip, [r4]
20022034:	d1f8      	bne.n	20022028 <HAL_AES_init+0x3c>
20022036:	ea47 0005 	orr.w	r0, r7, r5
2002203a:	ea40 00c3 	orr.w	r0, r0, r3, lsl #3
2002203e:	4b0b      	ldr	r3, [pc, #44]	@ (2002206c <HAL_AES_init+0x80>)
20022040:	6118      	str	r0, [r3, #16]
20022042:	b107      	cbz	r7, 20022046 <HAL_AES_init+0x5a>
20022044:	b92e      	cbnz	r6, 20022052 <HAL_AES_init+0x66>
20022046:	2000      	movs	r0, #0
20022048:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
2002204a:	2301      	movs	r3, #1
2002204c:	e7e5      	b.n	2002201a <HAL_AES_init+0x2e>
2002204e:	2302      	movs	r3, #2
20022050:	e7e3      	b.n	2002201a <HAL_AES_init+0x2e>
20022052:	6832      	ldr	r2, [r6, #0]
20022054:	621a      	str	r2, [r3, #32]
20022056:	6872      	ldr	r2, [r6, #4]
20022058:	625a      	str	r2, [r3, #36]	@ 0x24
2002205a:	68b2      	ldr	r2, [r6, #8]
2002205c:	629a      	str	r2, [r3, #40]	@ 0x28
2002205e:	68f2      	ldr	r2, [r6, #12]
20022060:	62da      	str	r2, [r3, #44]	@ 0x2c
20022062:	e7f0      	b.n	20022046 <HAL_AES_init+0x5a>
20022064:	f04f 30ff 	mov.w	r0, #4294967295
20022068:	e7ee      	b.n	20022048 <HAL_AES_init+0x5c>
2002206a:	bf00      	nop
2002206c:	5000d000 	.word	0x5000d000
20022070:	5000d030 	.word	0x5000d030

20022074 <HAL_AES_run>:
20022074:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20022076:	2708      	movs	r7, #8
20022078:	4e17      	ldr	r6, [pc, #92]	@ (200220d8 <HAL_AES_run+0x64>)
2002207a:	4614      	mov	r4, r2
2002207c:	461d      	mov	r5, r3
2002207e:	f8c6 7088 	str.w	r7, [r6, #136]	@ 0x88
20022082:	f3bf 8f4f 	dsb	sy
20022086:	f3bf 8f6f 	isb	sy
2002208a:	2700      	movs	r7, #0
2002208c:	4e13      	ldr	r6, [pc, #76]	@ (200220dc <HAL_AES_run+0x68>)
2002208e:	60f7      	str	r7, [r6, #12]
20022090:	f7ff ff64 	bl	20021f5c <HAL_AES_run_help>
20022094:	6873      	ldr	r3, [r6, #4]
20022096:	07db      	lsls	r3, r3, #31
20022098:	d4fc      	bmi.n	20022094 <HAL_AES_run+0x20>
2002209a:	68b0      	ldr	r0, [r6, #8]
2002209c:	f000 0006 	and.w	r0, r0, #6
200220a0:	3800      	subs	r0, #0
200220a2:	bf18      	it	ne
200220a4:	2001      	movne	r0, #1
200220a6:	f1b4 4fc0 	cmp.w	r4, #1610612736	@ 0x60000000
200220aa:	d313      	bcc.n	200220d4 <HAL_AES_run+0x60>
200220ac:	2d00      	cmp	r5, #0
200220ae:	dd11      	ble.n	200220d4 <HAL_AES_run+0x60>
200220b0:	f004 031f 	and.w	r3, r4, #31
200220b4:	442b      	add	r3, r5
200220b6:	f3bf 8f4f 	dsb	sy
200220ba:	4622      	mov	r2, r4
200220bc:	4c08      	ldr	r4, [pc, #32]	@ (200220e0 <HAL_AES_run+0x6c>)
200220be:	4413      	add	r3, r2
200220c0:	f8c4 225c 	str.w	r2, [r4, #604]	@ 0x25c
200220c4:	3220      	adds	r2, #32
200220c6:	1a99      	subs	r1, r3, r2
200220c8:	2900      	cmp	r1, #0
200220ca:	dcf9      	bgt.n	200220c0 <HAL_AES_run+0x4c>
200220cc:	f3bf 8f4f 	dsb	sy
200220d0:	f3bf 8f6f 	isb	sy
200220d4:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
200220d6:	bf00      	nop
200220d8:	e000e100 	.word	0xe000e100
200220dc:	5000d000 	.word	0x5000d000
200220e0:	e000ed00 	.word	0xe000ed00

200220e4 <HAL_HASH_run>:
200220e4:	b510      	push	{r4, lr}
200220e6:	2408      	movs	r4, #8
200220e8:	4b0b      	ldr	r3, [pc, #44]	@ (20022118 <HAL_HASH_run+0x34>)
200220ea:	f8c3 4088 	str.w	r4, [r3, #136]	@ 0x88
200220ee:	f3bf 8f4f 	dsb	sy
200220f2:	f3bf 8f6f 	isb	sy
200220f6:	f7ff ff55 	bl	20021fa4 <HAL_HASH_run_help.isra.0>
200220fa:	4b08      	ldr	r3, [pc, #32]	@ (2002211c <HAL_HASH_run+0x38>)
200220fc:	685a      	ldr	r2, [r3, #4]
200220fe:	0752      	lsls	r2, r2, #29
20022100:	d4fc      	bmi.n	200220fc <HAL_HASH_run+0x18>
20022102:	689a      	ldr	r2, [r3, #8]
20022104:	f002 0238 	and.w	r2, r2, #56	@ 0x38
20022108:	609a      	str	r2, [r3, #8]
2002210a:	6898      	ldr	r0, [r3, #8]
2002210c:	f000 0030 	and.w	r0, r0, #48	@ 0x30
20022110:	3800      	subs	r0, #0
20022112:	bf18      	it	ne
20022114:	2001      	movne	r0, #1
20022116:	bd10      	pop	{r4, pc}
20022118:	e000e100 	.word	0xe000e100
2002211c:	5000d000 	.word	0x5000d000

20022120 <HAL_HASH_reset>:
20022120:	2208      	movs	r2, #8
20022122:	2000      	movs	r0, #0
20022124:	4b01      	ldr	r3, [pc, #4]	@ (2002212c <HAL_HASH_reset+0xc>)
20022126:	601a      	str	r2, [r3, #0]
20022128:	6018      	str	r0, [r3, #0]
2002212a:	4770      	bx	lr
2002212c:	5000d000 	.word	0x5000d000

20022130 <HAL_HASH_init>:
20022130:	0693      	lsls	r3, r2, #26
20022132:	b570      	push	{r4, r5, r6, lr}
20022134:	4606      	mov	r6, r0
20022136:	460c      	mov	r4, r1
20022138:	4615      	mov	r5, r2
2002213a:	d11c      	bne.n	20022176 <HAL_HASH_init+0x46>
2002213c:	2903      	cmp	r1, #3
2002213e:	d81a      	bhi.n	20022176 <HAL_HASH_init+0x46>
20022140:	f7ff ffee 	bl	20022120 <HAL_HASH_reset>
20022144:	b13e      	cbz	r6, 20022156 <HAL_HASH_init+0x26>
20022146:	4b0d      	ldr	r3, [pc, #52]	@ (2002217c <HAL_HASH_init+0x4c>)
20022148:	480d      	ldr	r0, [pc, #52]	@ (20022180 <HAL_HASH_init+0x50>)
2002214a:	5c5a      	ldrb	r2, [r3, r1]
2002214c:	4631      	mov	r1, r6
2002214e:	f008 fb9b 	bl	2002a888 <memcpy>
20022152:	f044 0420 	orr.w	r4, r4, #32
20022156:	4b0b      	ldr	r3, [pc, #44]	@ (20022184 <HAL_HASH_init+0x54>)
20022158:	f044 0180 	orr.w	r1, r4, #128	@ 0x80
2002215c:	6519      	str	r1, [r3, #80]	@ 0x50
2002215e:	b11d      	cbz	r5, 20022168 <HAL_HASH_init+0x38>
20022160:	f8c3 509c 	str.w	r5, [r3, #156]	@ 0x9c
20022164:	f444 71c0 	orr.w	r1, r4, #384	@ 0x180
20022168:	4807      	ldr	r0, [pc, #28]	@ (20022188 <HAL_HASH_init+0x58>)
2002216a:	462a      	mov	r2, r5
2002216c:	6519      	str	r1, [r3, #80]	@ 0x50
2002216e:	f000 fca6 	bl	20022abe <HAL_DBG_printf>
20022172:	2000      	movs	r0, #0
20022174:	bd70      	pop	{r4, r5, r6, pc}
20022176:	f04f 30ff 	mov.w	r0, #4294967295
2002217a:	e7fb      	b.n	20022174 <HAL_HASH_init+0x44>
2002217c:	2002b87c 	.word	0x2002b87c
20022180:	5000d05c 	.word	0x5000d05c
20022184:	5000d000 	.word	0x5000d000
20022188:	2002a9f9 	.word	0x2002a9f9

2002218c <HAL_HASH_result>:
2002218c:	b510      	push	{r4, lr}
2002218e:	4c08      	ldr	r4, [pc, #32]	@ (200221b0 <HAL_HASH_result+0x24>)
20022190:	4a08      	ldr	r2, [pc, #32]	@ (200221b4 <HAL_HASH_result+0x28>)
20022192:	6d23      	ldr	r3, [r4, #80]	@ 0x50
20022194:	f104 017c 	add.w	r1, r4, #124	@ 0x7c
20022198:	f003 0307 	and.w	r3, r3, #7
2002219c:	5cd2      	ldrb	r2, [r2, r3]
2002219e:	f008 fb73 	bl	2002a888 <memcpy>
200221a2:	f8d4 10a4 	ldr.w	r1, [r4, #164]	@ 0xa4
200221a6:	4804      	ldr	r0, [pc, #16]	@ (200221b8 <HAL_HASH_result+0x2c>)
200221a8:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
200221ac:	f000 bc87 	b.w	20022abe <HAL_DBG_printf>
200221b0:	5000d000 	.word	0x5000d000
200221b4:	2002b87c 	.word	0x2002b87c
200221b8:	2002aa2d 	.word	0x2002aa2d

200221bc <HAL_NVIC_SetPriority>:
200221bc:	2a0f      	cmp	r2, #15
200221be:	b530      	push	{r4, r5, lr}
200221c0:	d900      	bls.n	200221c4 <HAL_NVIC_SetPriority+0x8>
200221c2:	e7fe      	b.n	200221c2 <HAL_NVIC_SetPriority+0x6>
200221c4:	290f      	cmp	r1, #15
200221c6:	d900      	bls.n	200221ca <HAL_NVIC_SetPriority+0xe>
200221c8:	e7fe      	b.n	200221c8 <HAL_NVIC_SetPriority+0xc>
200221ca:	4b15      	ldr	r3, [pc, #84]	@ (20022220 <HAL_NVIC_SetPriority+0x64>)
200221cc:	68dc      	ldr	r4, [r3, #12]
200221ce:	f3c4 2402 	ubfx	r4, r4, #8, #3
200221d2:	f1c4 0307 	rsb	r3, r4, #7
200221d6:	1ce5      	adds	r5, r4, #3
200221d8:	2b03      	cmp	r3, #3
200221da:	bf28      	it	cs
200221dc:	2303      	movcs	r3, #3
200221de:	2d06      	cmp	r5, #6
200221e0:	f04f 35ff 	mov.w	r5, #4294967295
200221e4:	bf94      	ite	ls
200221e6:	2400      	movls	r4, #0
200221e8:	3c04      	subhi	r4, #4
200221ea:	fa05 f303 	lsl.w	r3, r5, r3
200221ee:	ea21 0303 	bic.w	r3, r1, r3
200221f2:	40a5      	lsls	r5, r4
200221f4:	ea22 0205 	bic.w	r2, r2, r5
200221f8:	40a3      	lsls	r3, r4
200221fa:	2800      	cmp	r0, #0
200221fc:	ea43 0302 	orr.w	r3, r3, r2
20022200:	bfac      	ite	ge
20022202:	f100 4060 	addge.w	r0, r0, #3758096384	@ 0xe0000000
20022206:	4a07      	ldrlt	r2, [pc, #28]	@ (20022224 <HAL_NVIC_SetPriority+0x68>)
20022208:	ea4f 1343 	mov.w	r3, r3, lsl #5
2002220c:	b2db      	uxtb	r3, r3
2002220e:	bfab      	itete	ge
20022210:	f500 4061 	addge.w	r0, r0, #57600	@ 0xe100
20022214:	f000 000f 	andlt.w	r0, r0, #15
20022218:	f880 3300 	strbge.w	r3, [r0, #768]	@ 0x300
2002221c:	5413      	strblt	r3, [r2, r0]
2002221e:	bd30      	pop	{r4, r5, pc}
20022220:	e000ed00 	.word	0xe000ed00
20022224:	e000ed14 	.word	0xe000ed14

20022228 <HAL_NVIC_EnableIRQ>:
20022228:	2800      	cmp	r0, #0
2002222a:	da00      	bge.n	2002222e <HAL_NVIC_EnableIRQ+0x6>
2002222c:	e7fe      	b.n	2002222c <HAL_NVIC_EnableIRQ+0x4>
2002222e:	2301      	movs	r3, #1
20022230:	0941      	lsrs	r1, r0, #5
20022232:	4a03      	ldr	r2, [pc, #12]	@ (20022240 <HAL_NVIC_EnableIRQ+0x18>)
20022234:	f000 001f 	and.w	r0, r0, #31
20022238:	4083      	lsls	r3, r0
2002223a:	f842 3021 	str.w	r3, [r2, r1, lsl #2]
2002223e:	4770      	bx	lr
20022240:	e000e100 	.word	0xe000e100

20022244 <HAL_NVIC_DisableIRQ>:
20022244:	2800      	cmp	r0, #0
20022246:	da00      	bge.n	2002224a <HAL_NVIC_DisableIRQ+0x6>
20022248:	e7fe      	b.n	20022248 <HAL_NVIC_DisableIRQ+0x4>
2002224a:	2201      	movs	r2, #1
2002224c:	4906      	ldr	r1, [pc, #24]	@ (20022268 <HAL_NVIC_DisableIRQ+0x24>)
2002224e:	0943      	lsrs	r3, r0, #5
20022250:	f000 001f 	and.w	r0, r0, #31
20022254:	4082      	lsls	r2, r0
20022256:	3320      	adds	r3, #32
20022258:	f841 2023 	str.w	r2, [r1, r3, lsl #2]
2002225c:	f3bf 8f4f 	dsb	sy
20022260:	f3bf 8f6f 	isb	sy
20022264:	4770      	bx	lr
20022266:	bf00      	nop
20022268:	e000e100 	.word	0xe000e100

2002226c <DMA_Init>:
2002226c:	2302      	movs	r3, #2
2002226e:	b530      	push	{r4, r5, lr}
20022270:	6a42      	ldr	r2, [r0, #36]	@ 0x24
20022272:	f880 302d 	strb.w	r3, [r0, #45]	@ 0x2d
20022276:	6803      	ldr	r3, [r0, #0]
20022278:	611a      	str	r2, [r3, #16]
2002227a:	e9d0 3402 	ldrd	r3, r4, [r0, #8]
2002227e:	4323      	orrs	r3, r4
20022280:	6904      	ldr	r4, [r0, #16]
20022282:	6801      	ldr	r1, [r0, #0]
20022284:	4323      	orrs	r3, r4
20022286:	6944      	ldr	r4, [r0, #20]
20022288:	680a      	ldr	r2, [r1, #0]
2002228a:	4323      	orrs	r3, r4
2002228c:	6984      	ldr	r4, [r0, #24]
2002228e:	f36f 120e 	bfc	r2, #4, #11
20022292:	4323      	orrs	r3, r4
20022294:	69c4      	ldr	r4, [r0, #28]
20022296:	4323      	orrs	r3, r4
20022298:	6a04      	ldr	r4, [r0, #32]
2002229a:	4323      	orrs	r3, r4
2002229c:	4313      	orrs	r3, r2
2002229e:	600b      	str	r3, [r1, #0]
200222a0:	6883      	ldr	r3, [r0, #8]
200222a2:	f5b3 4f80 	cmp.w	r3, #16384	@ 0x4000
200222a6:	d018      	beq.n	200222da <DMA_Init+0x6e>
200222a8:	6cc1      	ldr	r1, [r0, #76]	@ 0x4c
200222aa:	6c82      	ldr	r2, [r0, #72]	@ 0x48
200222ac:	f3c1 0387 	ubfx	r3, r1, #2, #8
200222b0:	06c9      	lsls	r1, r1, #27
200222b2:	d41b      	bmi.n	200222ec <DMA_Init+0x80>
200222b4:	243f      	movs	r4, #63	@ 0x3f
200222b6:	f003 0307 	and.w	r3, r3, #7
200222ba:	f8d2 10a8 	ldr.w	r1, [r2, #168]	@ 0xa8
200222be:	00db      	lsls	r3, r3, #3
200222c0:	409c      	lsls	r4, r3
200222c2:	ea21 0104 	bic.w	r1, r1, r4
200222c6:	f8c2 10a8 	str.w	r1, [r2, #168]	@ 0xa8
200222ca:	6c81      	ldr	r1, [r0, #72]	@ 0x48
200222cc:	6842      	ldr	r2, [r0, #4]
200222ce:	f8d1 40a8 	ldr.w	r4, [r1, #168]	@ 0xa8
200222d2:	409a      	lsls	r2, r3
200222d4:	4322      	orrs	r2, r4
200222d6:	f8c1 20a8 	str.w	r2, [r1, #168]	@ 0xa8
200222da:	6982      	ldr	r2, [r0, #24]
200222dc:	f5b2 6f80 	cmp.w	r2, #1024	@ 0x400
200222e0:	d018      	beq.n	20022314 <DMA_Init+0xa8>
200222e2:	f5b2 6f00 	cmp.w	r2, #2048	@ 0x800
200222e6:	d01f      	beq.n	20022328 <DMA_Init+0xbc>
200222e8:	b1aa      	cbz	r2, 20022316 <DMA_Init+0xaa>
200222ea:	e7fe      	b.n	200222ea <DMA_Init+0x7e>
200222ec:	243f      	movs	r4, #63	@ 0x3f
200222ee:	f003 0303 	and.w	r3, r3, #3
200222f2:	f8d2 10ac 	ldr.w	r1, [r2, #172]	@ 0xac
200222f6:	00db      	lsls	r3, r3, #3
200222f8:	409c      	lsls	r4, r3
200222fa:	ea21 0104 	bic.w	r1, r1, r4
200222fe:	f8c2 10ac 	str.w	r1, [r2, #172]	@ 0xac
20022302:	6c81      	ldr	r1, [r0, #72]	@ 0x48
20022304:	6842      	ldr	r2, [r0, #4]
20022306:	f8d1 40ac 	ldr.w	r4, [r1, #172]	@ 0xac
2002230a:	409a      	lsls	r2, r3
2002230c:	4322      	orrs	r2, r4
2002230e:	f8c1 20ac 	str.w	r2, [r1, #172]	@ 0xac
20022312:	e7e2      	b.n	200222da <DMA_Init+0x6e>
20022314:	2201      	movs	r2, #1
20022316:	6943      	ldr	r3, [r0, #20]
20022318:	f5b3 7f80 	cmp.w	r3, #256	@ 0x100
2002231c:	d006      	beq.n	2002232c <DMA_Init+0xc0>
2002231e:	f5b3 7f00 	cmp.w	r3, #512	@ 0x200
20022322:	d02b      	beq.n	2002237c <DMA_Init+0x110>
20022324:	b11b      	cbz	r3, 2002232e <DMA_Init+0xc2>
20022326:	e7fe      	b.n	20022326 <DMA_Init+0xba>
20022328:	2202      	movs	r2, #2
2002232a:	e7f4      	b.n	20022316 <DMA_Init+0xaa>
2002232c:	2301      	movs	r3, #1
2002232e:	6901      	ldr	r1, [r0, #16]
20022330:	f1a1 0480 	sub.w	r4, r1, #128	@ 0x80
20022334:	4261      	negs	r1, r4
20022336:	4161      	adcs	r1, r4
20022338:	68c4      	ldr	r4, [r0, #12]
2002233a:	f1a4 0540 	sub.w	r5, r4, #64	@ 0x40
2002233e:	426c      	negs	r4, r5
20022340:	416c      	adcs	r4, r5
20022342:	6885      	ldr	r5, [r0, #8]
20022344:	2d10      	cmp	r5, #16
20022346:	bf1f      	itttt	ne
20022348:	f880 1065 	strbne.w	r1, [r0, #101]	@ 0x65
2002234c:	4619      	movne	r1, r3
2002234e:	4613      	movne	r3, r2
20022350:	460a      	movne	r2, r1
20022352:	f880 3067 	strb.w	r3, [r0, #103]	@ 0x67
20022356:	f880 2066 	strb.w	r2, [r0, #102]	@ 0x66
2002235a:	f04f 0300 	mov.w	r3, #0
2002235e:	f04f 0201 	mov.w	r2, #1
20022362:	6443      	str	r3, [r0, #68]	@ 0x44
20022364:	bf06      	itte	eq
20022366:	f880 4065 	strbeq.w	r4, [r0, #101]	@ 0x65
2002236a:	f880 1064 	strbeq.w	r1, [r0, #100]	@ 0x64
2002236e:	f880 4064 	strbne.w	r4, [r0, #100]	@ 0x64
20022372:	f880 202d 	strb.w	r2, [r0, #45]	@ 0x2d
20022376:	f880 302c 	strb.w	r3, [r0, #44]	@ 0x2c
2002237a:	bd30      	pop	{r4, r5, pc}
2002237c:	2302      	movs	r3, #2
2002237e:	e7d6      	b.n	2002232e <DMA_Init+0xc2>

20022380 <DMA_AllocChannel>:
20022380:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20022382:	4b2c      	ldr	r3, [pc, #176]	@ (20022434 <DMA_AllocChannel+0xb4>)
20022384:	6802      	ldr	r2, [r0, #0]
20022386:	4413      	add	r3, r2
20022388:	2ba0      	cmp	r3, #160	@ 0xa0
2002238a:	d904      	bls.n	20022396 <DMA_AllocChannel+0x16>
2002238c:	4b2a      	ldr	r3, [pc, #168]	@ (20022438 <DMA_AllocChannel+0xb8>)
2002238e:	4413      	add	r3, r2
20022390:	2ba0      	cmp	r3, #160	@ 0xa0
20022392:	d90f      	bls.n	200223b4 <DMA_AllocChannel+0x34>
20022394:	e7fe      	b.n	20022394 <DMA_AllocChannel+0x14>
20022396:	2632      	movs	r6, #50	@ 0x32
20022398:	f8df c0a8 	ldr.w	ip, [pc, #168]	@ 20022444 <DMA_AllocChannel+0xc4>
2002239c:	4b27      	ldr	r3, [pc, #156]	@ (2002243c <DMA_AllocChannel+0xbc>)
2002239e:	f3ef 8710 	mrs	r7, PRIMASK
200223a2:	2201      	movs	r2, #1
200223a4:	f382 8810 	msr	PRIMASK, r2
200223a8:	6cc5      	ldr	r5, [r0, #76]	@ 0x4c
200223aa:	2d1f      	cmp	r5, #31
200223ac:	ea4f 0495 	mov.w	r4, r5, lsr #2
200223b0:	d905      	bls.n	200223be <DMA_AllocChannel+0x3e>
200223b2:	e7fe      	b.n	200223b2 <DMA_AllocChannel+0x32>
200223b4:	2602      	movs	r6, #2
200223b6:	f8df c090 	ldr.w	ip, [pc, #144]	@ 20022448 <DMA_AllocChannel+0xc8>
200223ba:	4b21      	ldr	r3, [pc, #132]	@ (20022440 <DMA_AllocChannel+0xc0>)
200223bc:	e7ef      	b.n	2002239e <DMA_AllocChannel+0x1e>
200223be:	eb03 05c4 	add.w	r5, r3, r4, lsl #3
200223c2:	f895 e004 	ldrb.w	lr, [r5, #4]
200223c6:	f1be 0f00 	cmp.w	lr, #0
200223ca:	d02e      	beq.n	2002242a <DMA_AllocChannel+0xaa>
200223cc:	f853 2034 	ldr.w	r2, [r3, r4, lsl #3]
200223d0:	4282      	cmp	r2, r0
200223d2:	d103      	bne.n	200223dc <DMA_AllocChannel+0x5c>
200223d4:	f387 8810 	msr	PRIMASK, r7
200223d8:	2002      	movs	r0, #2
200223da:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
200223dc:	2200      	movs	r2, #0
200223de:	791c      	ldrb	r4, [r3, #4]
200223e0:	461d      	mov	r5, r3
200223e2:	b9e4      	cbnz	r4, 2002241e <DMA_AllocChannel+0x9e>
200223e4:	2301      	movs	r3, #1
200223e6:	712b      	strb	r3, [r5, #4]
200223e8:	2314      	movs	r3, #20
200223ea:	fb03 c302 	mla	r3, r3, r2, ip
200223ee:	4416      	add	r6, r2
200223f0:	0092      	lsls	r2, r2, #2
200223f2:	b274      	sxtb	r4, r6
200223f4:	6003      	str	r3, [r0, #0]
200223f6:	64c2      	str	r2, [r0, #76]	@ 0x4c
200223f8:	f387 8810 	msr	PRIMASK, r7
200223fc:	b121      	cbz	r1, 20022408 <DMA_AllocChannel+0x88>
200223fe:	682b      	ldr	r3, [r5, #0]
20022400:	4283      	cmp	r3, r0
20022402:	d001      	beq.n	20022408 <DMA_AllocChannel+0x88>
20022404:	f7ff ff32 	bl	2002226c <DMA_Init>
20022408:	2200      	movs	r2, #0
2002240a:	6028      	str	r0, [r5, #0]
2002240c:	4611      	mov	r1, r2
2002240e:	4620      	mov	r0, r4
20022410:	f7ff fed4 	bl	200221bc <HAL_NVIC_SetPriority>
20022414:	4620      	mov	r0, r4
20022416:	f7ff ff07 	bl	20022228 <HAL_NVIC_EnableIRQ>
2002241a:	2000      	movs	r0, #0
2002241c:	e7dd      	b.n	200223da <DMA_AllocChannel+0x5a>
2002241e:	3201      	adds	r2, #1
20022420:	2a08      	cmp	r2, #8
20022422:	f103 0308 	add.w	r3, r3, #8
20022426:	d1da      	bne.n	200223de <DMA_AllocChannel+0x5e>
20022428:	e7d4      	b.n	200223d4 <DMA_AllocChannel+0x54>
2002242a:	4434      	add	r4, r6
2002242c:	712a      	strb	r2, [r5, #4]
2002242e:	b264      	sxtb	r4, r4
20022430:	e7e2      	b.n	200223f8 <DMA_AllocChannel+0x78>
20022432:	bf00      	nop
20022434:	aff7eff8 	.word	0xaff7eff8
20022438:	bfffeff8 	.word	0xbfffeff8
2002243c:	20049f1c 	.word	0x20049f1c
20022440:	20049edc 	.word	0x20049edc
20022444:	50081008 	.word	0x50081008
20022448:	40001008 	.word	0x40001008

2002244c <DMA_FreeChannel.isra.0>:
2002244c:	b538      	push	{r3, r4, r5, lr}
2002244e:	4a13      	ldr	r2, [pc, #76]	@ (2002249c <DMA_FreeChannel.isra.0+0x50>)
20022450:	6c83      	ldr	r3, [r0, #72]	@ 0x48
20022452:	4293      	cmp	r3, r2
20022454:	d003      	beq.n	2002245e <DMA_FreeChannel.isra.0+0x12>
20022456:	4a12      	ldr	r2, [pc, #72]	@ (200224a0 <DMA_FreeChannel.isra.0+0x54>)
20022458:	4293      	cmp	r3, r2
2002245a:	d008      	beq.n	2002246e <DMA_FreeChannel.isra.0+0x22>
2002245c:	e7fe      	b.n	2002245c <DMA_FreeChannel.isra.0+0x10>
2002245e:	2132      	movs	r1, #50	@ 0x32
20022460:	4a10      	ldr	r2, [pc, #64]	@ (200224a4 <DMA_FreeChannel.isra.0+0x58>)
20022462:	6cc4      	ldr	r4, [r0, #76]	@ 0x4c
20022464:	2c1f      	cmp	r4, #31
20022466:	ea4f 0394 	mov.w	r3, r4, lsr #2
2002246a:	d903      	bls.n	20022474 <DMA_FreeChannel.isra.0+0x28>
2002246c:	e7fe      	b.n	2002246c <DMA_FreeChannel.isra.0+0x20>
2002246e:	2102      	movs	r1, #2
20022470:	4a0d      	ldr	r2, [pc, #52]	@ (200224a8 <DMA_FreeChannel.isra.0+0x5c>)
20022472:	e7f6      	b.n	20022462 <DMA_FreeChannel.isra.0+0x16>
20022474:	f3ef 8410 	mrs	r4, PRIMASK
20022478:	2501      	movs	r5, #1
2002247a:	f385 8810 	msr	PRIMASK, r5
2002247e:	eb02 05c3 	add.w	r5, r2, r3, lsl #3
20022482:	f852 2033 	ldr.w	r2, [r2, r3, lsl #3]
20022486:	4290      	cmp	r0, r2
20022488:	d105      	bne.n	20022496 <DMA_FreeChannel.isra.0+0x4a>
2002248a:	1858      	adds	r0, r3, r1
2002248c:	b240      	sxtb	r0, r0
2002248e:	f7ff fed9 	bl	20022244 <HAL_NVIC_DisableIRQ>
20022492:	2300      	movs	r3, #0
20022494:	712b      	strb	r3, [r5, #4]
20022496:	f384 8810 	msr	PRIMASK, r4
2002249a:	bd38      	pop	{r3, r4, r5, pc}
2002249c:	50081000 	.word	0x50081000
200224a0:	40001000 	.word	0x40001000
200224a4:	20049f1c 	.word	0x20049f1c
200224a8:	20049edc 	.word	0x20049edc

200224ac <HAL_DMA_Init>:
200224ac:	b538      	push	{r3, r4, r5, lr}
200224ae:	4604      	mov	r4, r0
200224b0:	2800      	cmp	r0, #0
200224b2:	d053      	beq.n	2002255c <HAL_DMA_Init+0xb0>
200224b4:	6883      	ldr	r3, [r0, #8]
200224b6:	f033 0210 	bics.w	r2, r3, #16
200224ba:	d003      	beq.n	200224c4 <HAL_DMA_Init+0x18>
200224bc:	f5b3 4f80 	cmp.w	r3, #16384	@ 0x4000
200224c0:	d000      	beq.n	200224c4 <HAL_DMA_Init+0x18>
200224c2:	e7fe      	b.n	200224c2 <HAL_DMA_Init+0x16>
200224c4:	68e3      	ldr	r3, [r4, #12]
200224c6:	f033 0340 	bics.w	r3, r3, #64	@ 0x40
200224ca:	d000      	beq.n	200224ce <HAL_DMA_Init+0x22>
200224cc:	e7fe      	b.n	200224cc <HAL_DMA_Init+0x20>
200224ce:	6923      	ldr	r3, [r4, #16]
200224d0:	f033 0380 	bics.w	r3, r3, #128	@ 0x80
200224d4:	d000      	beq.n	200224d8 <HAL_DMA_Init+0x2c>
200224d6:	e7fe      	b.n	200224d6 <HAL_DMA_Init+0x2a>
200224d8:	6963      	ldr	r3, [r4, #20]
200224da:	f433 7280 	bics.w	r2, r3, #256	@ 0x100
200224de:	d003      	beq.n	200224e8 <HAL_DMA_Init+0x3c>
200224e0:	f5b3 7f00 	cmp.w	r3, #512	@ 0x200
200224e4:	d000      	beq.n	200224e8 <HAL_DMA_Init+0x3c>
200224e6:	e7fe      	b.n	200224e6 <HAL_DMA_Init+0x3a>
200224e8:	69a3      	ldr	r3, [r4, #24]
200224ea:	f433 6280 	bics.w	r2, r3, #1024	@ 0x400
200224ee:	d003      	beq.n	200224f8 <HAL_DMA_Init+0x4c>
200224f0:	f5b3 6f00 	cmp.w	r3, #2048	@ 0x800
200224f4:	d000      	beq.n	200224f8 <HAL_DMA_Init+0x4c>
200224f6:	e7fe      	b.n	200224f6 <HAL_DMA_Init+0x4a>
200224f8:	69e3      	ldr	r3, [r4, #28]
200224fa:	f033 0320 	bics.w	r3, r3, #32
200224fe:	d000      	beq.n	20022502 <HAL_DMA_Init+0x56>
20022500:	e7fe      	b.n	20022500 <HAL_DMA_Init+0x54>
20022502:	6a23      	ldr	r3, [r4, #32]
20022504:	f433 5340 	bics.w	r3, r3, #12288	@ 0x3000
20022508:	d000      	beq.n	2002250c <HAL_DMA_Init+0x60>
2002250a:	e7fe      	b.n	2002250a <HAL_DMA_Init+0x5e>
2002250c:	6863      	ldr	r3, [r4, #4]
2002250e:	2b3f      	cmp	r3, #63	@ 0x3f
20022510:	d900      	bls.n	20022514 <HAL_DMA_Init+0x68>
20022512:	e7fe      	b.n	20022512 <HAL_DMA_Init+0x66>
20022514:	6822      	ldr	r2, [r4, #0]
20022516:	4b13      	ldr	r3, [pc, #76]	@ (20022564 <HAL_DMA_Init+0xb8>)
20022518:	4413      	add	r3, r2
2002251a:	2b8c      	cmp	r3, #140	@ 0x8c
2002251c:	d813      	bhi.n	20022546 <HAL_DMA_Init+0x9a>
2002251e:	2214      	movs	r2, #20
20022520:	fbb3 f3f2 	udiv	r3, r3, r2
20022524:	009b      	lsls	r3, r3, #2
20022526:	64e3      	str	r3, [r4, #76]	@ 0x4c
20022528:	4b0f      	ldr	r3, [pc, #60]	@ (20022568 <HAL_DMA_Init+0xbc>)
2002252a:	64a3      	str	r3, [r4, #72]	@ 0x48
2002252c:	2100      	movs	r1, #0
2002252e:	4620      	mov	r0, r4
20022530:	f7ff ff26 	bl	20022380 <DMA_AllocChannel>
20022534:	4605      	mov	r5, r0
20022536:	b998      	cbnz	r0, 20022560 <HAL_DMA_Init+0xb4>
20022538:	4620      	mov	r0, r4
2002253a:	f7ff fe97 	bl	2002226c <DMA_Init>
2002253e:	f7ff ff85 	bl	2002244c <DMA_FreeChannel.isra.0>
20022542:	4628      	mov	r0, r5
20022544:	bd38      	pop	{r3, r4, r5, pc}
20022546:	4b09      	ldr	r3, [pc, #36]	@ (2002256c <HAL_DMA_Init+0xc0>)
20022548:	4413      	add	r3, r2
2002254a:	2b8c      	cmp	r3, #140	@ 0x8c
2002254c:	d8ee      	bhi.n	2002252c <HAL_DMA_Init+0x80>
2002254e:	2214      	movs	r2, #20
20022550:	fbb3 f3f2 	udiv	r3, r3, r2
20022554:	009b      	lsls	r3, r3, #2
20022556:	64e3      	str	r3, [r4, #76]	@ 0x4c
20022558:	4b05      	ldr	r3, [pc, #20]	@ (20022570 <HAL_DMA_Init+0xc4>)
2002255a:	e7e6      	b.n	2002252a <HAL_DMA_Init+0x7e>
2002255c:	2501      	movs	r5, #1
2002255e:	e7f0      	b.n	20022542 <HAL_DMA_Init+0x96>
20022560:	2502      	movs	r5, #2
20022562:	e7ee      	b.n	20022542 <HAL_DMA_Init+0x96>
20022564:	aff7eff8 	.word	0xaff7eff8
20022568:	50081000 	.word	0x50081000
2002256c:	bfffeff8 	.word	0xbfffeff8
20022570:	40001000 	.word	0x40001000

20022574 <HAL_DMA_DeInit>:
20022574:	b510      	push	{r4, lr}
20022576:	4604      	mov	r4, r0
20022578:	2800      	cmp	r0, #0
2002257a:	d051      	beq.n	20022620 <HAL_DMA_DeInit+0xac>
2002257c:	6802      	ldr	r2, [r0, #0]
2002257e:	6813      	ldr	r3, [r2, #0]
20022580:	f023 0301 	bic.w	r3, r3, #1
20022584:	6013      	str	r3, [r2, #0]
20022586:	6802      	ldr	r2, [r0, #0]
20022588:	4b26      	ldr	r3, [pc, #152]	@ (20022624 <HAL_DMA_DeInit+0xb0>)
2002258a:	4413      	add	r3, r2
2002258c:	2b8c      	cmp	r3, #140	@ 0x8c
2002258e:	d82f      	bhi.n	200225f0 <HAL_DMA_DeInit+0x7c>
20022590:	2114      	movs	r1, #20
20022592:	fbb3 f3f1 	udiv	r3, r3, r1
20022596:	009b      	lsls	r3, r3, #2
20022598:	64c3      	str	r3, [r0, #76]	@ 0x4c
2002259a:	4b23      	ldr	r3, [pc, #140]	@ (20022628 <HAL_DMA_DeInit+0xb4>)
2002259c:	64a3      	str	r3, [r4, #72]	@ 0x48
2002259e:	2300      	movs	r3, #0
200225a0:	6013      	str	r3, [r2, #0]
200225a2:	e9d4 1312 	ldrd	r1, r3, [r4, #72]	@ 0x48
200225a6:	f003 021c 	and.w	r2, r3, #28
200225aa:	2301      	movs	r3, #1
200225ac:	4093      	lsls	r3, r2
200225ae:	604b      	str	r3, [r1, #4]
200225b0:	6ce3      	ldr	r3, [r4, #76]	@ 0x4c
200225b2:	6ca1      	ldr	r1, [r4, #72]	@ 0x48
200225b4:	2b0f      	cmp	r3, #15
200225b6:	ea4f 0293 	mov.w	r2, r3, lsr #2
200225ba:	d824      	bhi.n	20022606 <HAL_DMA_DeInit+0x92>
200225bc:	203f      	movs	r0, #63	@ 0x3f
200225be:	005b      	lsls	r3, r3, #1
200225c0:	f8d1 20a8 	ldr.w	r2, [r1, #168]	@ 0xa8
200225c4:	f003 0338 	and.w	r3, r3, #56	@ 0x38
200225c8:	fa00 f303 	lsl.w	r3, r0, r3
200225cc:	ea22 0303 	bic.w	r3, r2, r3
200225d0:	f8c1 30a8 	str.w	r3, [r1, #168]	@ 0xa8
200225d4:	4620      	mov	r0, r4
200225d6:	f7ff ff39 	bl	2002244c <DMA_FreeChannel.isra.0>
200225da:	2000      	movs	r0, #0
200225dc:	e9c4 000d 	strd	r0, r0, [r4, #52]	@ 0x34
200225e0:	e9c4 000f 	strd	r0, r0, [r4, #60]	@ 0x3c
200225e4:	6460      	str	r0, [r4, #68]	@ 0x44
200225e6:	f884 002c 	strb.w	r0, [r4, #44]	@ 0x2c
200225ea:	f884 002d 	strb.w	r0, [r4, #45]	@ 0x2d
200225ee:	bd10      	pop	{r4, pc}
200225f0:	4b0e      	ldr	r3, [pc, #56]	@ (2002262c <HAL_DMA_DeInit+0xb8>)
200225f2:	4413      	add	r3, r2
200225f4:	2b8c      	cmp	r3, #140	@ 0x8c
200225f6:	d8d2      	bhi.n	2002259e <HAL_DMA_DeInit+0x2a>
200225f8:	2114      	movs	r1, #20
200225fa:	fbb3 f3f1 	udiv	r3, r3, r1
200225fe:	009b      	lsls	r3, r3, #2
20022600:	64c3      	str	r3, [r0, #76]	@ 0x4c
20022602:	4b0b      	ldr	r3, [pc, #44]	@ (20022630 <HAL_DMA_DeInit+0xbc>)
20022604:	e7ca      	b.n	2002259c <HAL_DMA_DeInit+0x28>
20022606:	f002 0303 	and.w	r3, r2, #3
2002260a:	223f      	movs	r2, #63	@ 0x3f
2002260c:	f8d1 00ac 	ldr.w	r0, [r1, #172]	@ 0xac
20022610:	00db      	lsls	r3, r3, #3
20022612:	fa02 f303 	lsl.w	r3, r2, r3
20022616:	ea20 0303 	bic.w	r3, r0, r3
2002261a:	f8c1 30ac 	str.w	r3, [r1, #172]	@ 0xac
2002261e:	e7d9      	b.n	200225d4 <HAL_DMA_DeInit+0x60>
20022620:	2001      	movs	r0, #1
20022622:	e7e4      	b.n	200225ee <HAL_DMA_DeInit+0x7a>
20022624:	aff7eff8 	.word	0xaff7eff8
20022628:	50081000 	.word	0x50081000
2002262c:	bfffeff8 	.word	0xbfffeff8
20022630:	40001000 	.word	0x40001000

20022634 <HAL_DMA_PollForTransfer>:
20022634:	e92d 4ff8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
20022638:	f890 302d 	ldrb.w	r3, [r0, #45]	@ 0x2d
2002263c:	4617      	mov	r7, r2
2002263e:	2b02      	cmp	r3, #2
20022640:	4604      	mov	r4, r0
20022642:	4688      	mov	r8, r1
20022644:	b2da      	uxtb	r2, r3
20022646:	d005      	beq.n	20022654 <HAL_DMA_PollForTransfer+0x20>
20022648:	2304      	movs	r3, #4
2002264a:	6443      	str	r3, [r0, #68]	@ 0x44
2002264c:	2300      	movs	r3, #0
2002264e:	f884 302c 	strb.w	r3, [r4, #44]	@ 0x2c
20022652:	e006      	b.n	20022662 <HAL_DMA_PollForTransfer+0x2e>
20022654:	6803      	ldr	r3, [r0, #0]
20022656:	681b      	ldr	r3, [r3, #0]
20022658:	0699      	lsls	r1, r3, #26
2002265a:	d505      	bpl.n	20022668 <HAL_DMA_PollForTransfer+0x34>
2002265c:	f44f 7380 	mov.w	r3, #256	@ 0x100
20022660:	6443      	str	r3, [r0, #68]	@ 0x44
20022662:	2001      	movs	r0, #1
20022664:	e8bd 8ff8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
20022668:	6cc5      	ldr	r5, [r0, #76]	@ 0x4c
2002266a:	f005 051c 	and.w	r5, r5, #28
2002266e:	f1b8 0f00 	cmp.w	r8, #0
20022672:	d123      	bne.n	200226bc <HAL_DMA_PollForTransfer+0x88>
20022674:	fa02 f505 	lsl.w	r5, r2, r5
20022678:	f7ff fbda 	bl	20021e30 <HAL_GetTick>
2002267c:	f04f 0a08 	mov.w	sl, #8
20022680:	4681      	mov	r9, r0
20022682:	e9d4 6312 	ldrd	r6, r3, [r4, #72]	@ 0x48
20022686:	f003 031c 	and.w	r3, r3, #28
2002268a:	fa0a f103 	lsl.w	r1, sl, r3
2002268e:	6832      	ldr	r2, [r6, #0]
20022690:	ea12 0b05 	ands.w	fp, r2, r5
20022694:	d016      	beq.n	200226c4 <HAL_DMA_PollForTransfer+0x90>
20022696:	f1b8 0f00 	cmp.w	r8, #0
2002269a:	d136      	bne.n	2002270a <HAL_DMA_PollForTransfer+0xd6>
2002269c:	2202      	movs	r2, #2
2002269e:	fa02 f303 	lsl.w	r3, r2, r3
200226a2:	6073      	str	r3, [r6, #4]
200226a4:	6d23      	ldr	r3, [r4, #80]	@ 0x50
200226a6:	b92b      	cbnz	r3, 200226b4 <HAL_DMA_PollForTransfer+0x80>
200226a8:	4620      	mov	r0, r4
200226aa:	f7ff fecf 	bl	2002244c <DMA_FreeChannel.isra.0>
200226ae:	2301      	movs	r3, #1
200226b0:	f884 302d 	strb.w	r3, [r4, #45]	@ 0x2d
200226b4:	2000      	movs	r0, #0
200226b6:	f884 002c 	strb.w	r0, [r4, #44]	@ 0x2c
200226ba:	e7d3      	b.n	20022664 <HAL_DMA_PollForTransfer+0x30>
200226bc:	2304      	movs	r3, #4
200226be:	fa03 f505 	lsl.w	r5, r3, r5
200226c2:	e7d9      	b.n	20022678 <HAL_DMA_PollForTransfer+0x44>
200226c4:	6832      	ldr	r2, [r6, #0]
200226c6:	4211      	tst	r1, r2
200226c8:	d00c      	beq.n	200226e4 <HAL_DMA_PollForTransfer+0xb0>
200226ca:	2501      	movs	r5, #1
200226cc:	fa05 f303 	lsl.w	r3, r5, r3
200226d0:	6073      	str	r3, [r6, #4]
200226d2:	4620      	mov	r0, r4
200226d4:	6465      	str	r5, [r4, #68]	@ 0x44
200226d6:	f7ff feb9 	bl	2002244c <DMA_FreeChannel.isra.0>
200226da:	f884 502d 	strb.w	r5, [r4, #45]	@ 0x2d
200226de:	f884 b02c 	strb.w	fp, [r4, #44]	@ 0x2c
200226e2:	e7be      	b.n	20022662 <HAL_DMA_PollForTransfer+0x2e>
200226e4:	1c7a      	adds	r2, r7, #1
200226e6:	d0d2      	beq.n	2002268e <HAL_DMA_PollForTransfer+0x5a>
200226e8:	f7ff fba2 	bl	20021e30 <HAL_GetTick>
200226ec:	eba0 0009 	sub.w	r0, r0, r9
200226f0:	42b8      	cmp	r0, r7
200226f2:	d801      	bhi.n	200226f8 <HAL_DMA_PollForTransfer+0xc4>
200226f4:	2f00      	cmp	r7, #0
200226f6:	d1c4      	bne.n	20022682 <HAL_DMA_PollForTransfer+0x4e>
200226f8:	2320      	movs	r3, #32
200226fa:	4620      	mov	r0, r4
200226fc:	6463      	str	r3, [r4, #68]	@ 0x44
200226fe:	f7ff fea5 	bl	2002244c <DMA_FreeChannel.isra.0>
20022702:	2301      	movs	r3, #1
20022704:	f884 302d 	strb.w	r3, [r4, #45]	@ 0x2d
20022708:	e7a0      	b.n	2002264c <HAL_DMA_PollForTransfer+0x18>
2002270a:	2204      	movs	r2, #4
2002270c:	fa02 f303 	lsl.w	r3, r2, r3
20022710:	6073      	str	r3, [r6, #4]
20022712:	e7cf      	b.n	200226b4 <HAL_DMA_PollForTransfer+0x80>

20022714 <DMA_Remap>:
20022714:	b530      	push	{r4, r5, lr}
20022716:	4b15      	ldr	r3, [pc, #84]	@ (2002276c <DMA_Remap+0x58>)
20022718:	6c84      	ldr	r4, [r0, #72]	@ 0x48
2002271a:	429c      	cmp	r4, r3
2002271c:	d11b      	bne.n	20022756 <DMA_Remap+0x42>
2002271e:	6883      	ldr	r3, [r0, #8]
20022720:	2b10      	cmp	r3, #16
20022722:	d002      	beq.n	2002272a <DMA_Remap+0x16>
20022724:	f5b3 4f80 	cmp.w	r3, #16384	@ 0x4000
20022728:	d108      	bne.n	2002273c <DMA_Remap+0x28>
2002272a:	680b      	ldr	r3, [r1, #0]
2002272c:	4c10      	ldr	r4, [pc, #64]	@ (20022770 <DMA_Remap+0x5c>)
2002272e:	f103 4560 	add.w	r5, r3, #3758096384	@ 0xe0000000
20022732:	42a5      	cmp	r5, r4
20022734:	bf98      	it	ls
20022736:	f103 6320 	addls.w	r3, r3, #167772160	@ 0xa000000
2002273a:	600b      	str	r3, [r1, #0]
2002273c:	6883      	ldr	r3, [r0, #8]
2002273e:	f433 4380 	bics.w	r3, r3, #16384	@ 0x4000
20022742:	d108      	bne.n	20022756 <DMA_Remap+0x42>
20022744:	6813      	ldr	r3, [r2, #0]
20022746:	480a      	ldr	r0, [pc, #40]	@ (20022770 <DMA_Remap+0x5c>)
20022748:	f103 4460 	add.w	r4, r3, #3758096384	@ 0xe0000000
2002274c:	4284      	cmp	r4, r0
2002274e:	bf98      	it	ls
20022750:	f103 6320 	addls.w	r3, r3, #167772160	@ 0xa000000
20022754:	6013      	str	r3, [r2, #0]
20022756:	680b      	ldr	r3, [r1, #0]
20022758:	f103 4270 	add.w	r2, r3, #4026531840	@ 0xf0000000
2002275c:	f1b2 5f80 	cmp.w	r2, #268435456	@ 0x10000000
20022760:	bf3c      	itt	cc
20022762:	f103 43a0 	addcc.w	r3, r3, #1342177280	@ 0x50000000
20022766:	600b      	strcc	r3, [r1, #0]
20022768:	bd30      	pop	{r4, r5, pc}
2002276a:	bf00      	nop
2002276c:	40001000 	.word	0x40001000
20022770:	0007fffe 	.word	0x0007fffe

20022774 <DMA_Start>:
20022774:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
20022778:	f64f 75ff 	movw	r5, #65535	@ 0xffff
2002277c:	6d03      	ldr	r3, [r0, #80]	@ 0x50
2002277e:	6802      	ldr	r2, [r0, #0]
20022780:	429d      	cmp	r5, r3
20022782:	bf28      	it	cs
20022784:	461d      	movcs	r5, r3
20022786:	1b5b      	subs	r3, r3, r5
20022788:	6503      	str	r3, [r0, #80]	@ 0x50
2002278a:	6585      	str	r5, [r0, #88]	@ 0x58
2002278c:	6813      	ldr	r3, [r2, #0]
2002278e:	f890 7066 	ldrb.w	r7, [r0, #102]	@ 0x66
20022792:	f023 0301 	bic.w	r3, r3, #1
20022796:	f890 8067 	ldrb.w	r8, [r0, #103]	@ 0x67
2002279a:	6013      	str	r3, [r2, #0]
2002279c:	e9d0 2317 	ldrd	r2, r3, [r0, #92]	@ 0x5c
200227a0:	460e      	mov	r6, r1
200227a2:	e9cd 2300 	strd	r2, r3, [sp]
200227a6:	e9d0 2312 	ldrd	r2, r3, [r0, #72]	@ 0x48
200227aa:	f003 011c 	and.w	r1, r3, #28
200227ae:	2301      	movs	r3, #1
200227b0:	4604      	mov	r4, r0
200227b2:	408b      	lsls	r3, r1
200227b4:	6053      	str	r3, [r2, #4]
200227b6:	6803      	ldr	r3, [r0, #0]
200227b8:	4669      	mov	r1, sp
200227ba:	605d      	str	r5, [r3, #4]
200227bc:	aa01      	add	r2, sp, #4
200227be:	f7ff ffa9 	bl	20022714 <DMA_Remap>
200227c2:	e9dd 0300 	ldrd	r0, r3, [sp]
200227c6:	68a1      	ldr	r1, [r4, #8]
200227c8:	6822      	ldr	r2, [r4, #0]
200227ca:	2910      	cmp	r1, #16
200227cc:	bf0b      	itete	eq
200227ce:	6093      	streq	r3, [r2, #8]
200227d0:	6090      	strne	r0, [r2, #8]
200227d2:	6823      	ldreq	r3, [r4, #0]
200227d4:	6822      	ldrne	r2, [r4, #0]
200227d6:	bf0c      	ite	eq
200227d8:	60d8      	streq	r0, [r3, #12]
200227da:	60d3      	strne	r3, [r2, #12]
200227dc:	f894 3064 	ldrb.w	r3, [r4, #100]	@ 0x64
200227e0:	b123      	cbz	r3, 200227ec <DMA_Start+0x78>
200227e2:	6de3      	ldr	r3, [r4, #92]	@ 0x5c
200227e4:	fa05 f707 	lsl.w	r7, r5, r7
200227e8:	443b      	add	r3, r7
200227ea:	65e3      	str	r3, [r4, #92]	@ 0x5c
200227ec:	f894 3065 	ldrb.w	r3, [r4, #101]	@ 0x65
200227f0:	b123      	cbz	r3, 200227fc <DMA_Start+0x88>
200227f2:	6e23      	ldr	r3, [r4, #96]	@ 0x60
200227f4:	fa05 f508 	lsl.w	r5, r5, r8
200227f8:	442b      	add	r3, r5
200227fa:	6623      	str	r3, [r4, #96]	@ 0x60
200227fc:	b136      	cbz	r6, 2002280c <DMA_Start+0x98>
200227fe:	6ba2      	ldr	r2, [r4, #56]	@ 0x38
20022800:	6823      	ldr	r3, [r4, #0]
20022802:	b15a      	cbz	r2, 2002281c <DMA_Start+0xa8>
20022804:	681a      	ldr	r2, [r3, #0]
20022806:	f042 020e 	orr.w	r2, r2, #14
2002280a:	601a      	str	r2, [r3, #0]
2002280c:	6822      	ldr	r2, [r4, #0]
2002280e:	6813      	ldr	r3, [r2, #0]
20022810:	f043 0301 	orr.w	r3, r3, #1
20022814:	6013      	str	r3, [r2, #0]
20022816:	b002      	add	sp, #8
20022818:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
2002281c:	681a      	ldr	r2, [r3, #0]
2002281e:	f022 0204 	bic.w	r2, r2, #4
20022822:	601a      	str	r2, [r3, #0]
20022824:	6822      	ldr	r2, [r4, #0]
20022826:	6813      	ldr	r3, [r2, #0]
20022828:	f043 030a 	orr.w	r3, r3, #10
2002282c:	6013      	str	r3, [r2, #0]
2002282e:	e7ed      	b.n	2002280c <DMA_Start+0x98>

20022830 <HAL_DMA_Start>:
20022830:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20022832:	461d      	mov	r5, r3
20022834:	69c3      	ldr	r3, [r0, #28]
20022836:	4604      	mov	r4, r0
20022838:	2b20      	cmp	r3, #32
2002283a:	460f      	mov	r7, r1
2002283c:	4616      	mov	r6, r2
2002283e:	d105      	bne.n	2002284c <HAL_DMA_Start+0x1c>
20022840:	f64f 73fe 	movw	r3, #65534	@ 0xfffe
20022844:	1e6a      	subs	r2, r5, #1
20022846:	429a      	cmp	r2, r3
20022848:	d900      	bls.n	2002284c <HAL_DMA_Start+0x1c>
2002284a:	e7fe      	b.n	2002284a <HAL_DMA_Start+0x1a>
2002284c:	f894 302c 	ldrb.w	r3, [r4, #44]	@ 0x2c
20022850:	2b01      	cmp	r3, #1
20022852:	d00e      	beq.n	20022872 <HAL_DMA_Start+0x42>
20022854:	2301      	movs	r3, #1
20022856:	f884 302c 	strb.w	r3, [r4, #44]	@ 0x2c
2002285a:	f894 302d 	ldrb.w	r3, [r4, #45]	@ 0x2d
2002285e:	2b01      	cmp	r3, #1
20022860:	b2d9      	uxtb	r1, r3
20022862:	d103      	bne.n	2002286c <HAL_DMA_Start+0x3c>
20022864:	4620      	mov	r0, r4
20022866:	f7ff fd8b 	bl	20022380 <DMA_AllocChannel>
2002286a:	b120      	cbz	r0, 20022876 <HAL_DMA_Start+0x46>
2002286c:	2300      	movs	r3, #0
2002286e:	f884 302c 	strb.w	r3, [r4, #44]	@ 0x2c
20022872:	2002      	movs	r0, #2
20022874:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20022876:	2302      	movs	r3, #2
20022878:	e9c4 5514 	strd	r5, r5, [r4, #80]	@ 0x50
2002287c:	e9c4 7617 	strd	r7, r6, [r4, #92]	@ 0x5c
20022880:	f884 302d 	strb.w	r3, [r4, #45]	@ 0x2d
20022884:	6460      	str	r0, [r4, #68]	@ 0x44
20022886:	6d20      	ldr	r0, [r4, #80]	@ 0x50
20022888:	2800      	cmp	r0, #0
2002288a:	d0f3      	beq.n	20022874 <HAL_DMA_Start+0x44>
2002288c:	2100      	movs	r1, #0
2002288e:	4620      	mov	r0, r4
20022890:	f7ff ff70 	bl	20022774 <DMA_Start>
20022894:	6d23      	ldr	r3, [r4, #80]	@ 0x50
20022896:	2b00      	cmp	r3, #0
20022898:	d0f5      	beq.n	20022886 <HAL_DMA_Start+0x56>
2002289a:	f44f 727a 	mov.w	r2, #1000	@ 0x3e8
2002289e:	2100      	movs	r1, #0
200228a0:	4620      	mov	r0, r4
200228a2:	f7ff fec7 	bl	20022634 <HAL_DMA_PollForTransfer>
200228a6:	2800      	cmp	r0, #0
200228a8:	d0ed      	beq.n	20022886 <HAL_DMA_Start+0x56>
200228aa:	e7e3      	b.n	20022874 <HAL_DMA_Start+0x44>

200228ac <HAL_EFUSE_Read>:
200228ac:	2a20      	cmp	r2, #32
200228ae:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
200228b2:	4606      	mov	r6, r0
200228b4:	460c      	mov	r4, r1
200228b6:	4615      	mov	r5, r2
200228b8:	dc30      	bgt.n	2002291c <HAL_EFUSE_Read+0x70>
200228ba:	f3c0 08c4 	ubfx	r8, r0, #3, #5
200228be:	eb08 0302 	add.w	r3, r8, r2
200228c2:	2b20      	cmp	r3, #32
200228c4:	dc2a      	bgt.n	2002291c <HAL_EFUSE_Read+0x70>
200228c6:	0797      	lsls	r7, r2, #30
200228c8:	d128      	bne.n	2002291c <HAL_EFUSE_Read+0x70>
200228ca:	f010 091f 	ands.w	r9, r0, #31
200228ce:	d125      	bne.n	2002291c <HAL_EFUSE_Read+0x70>
200228d0:	4a25      	ldr	r2, [pc, #148]	@ (20022968 <HAL_EFUSE_Read+0xbc>)
200228d2:	2014      	movs	r0, #20
200228d4:	f8d2 7094 	ldr.w	r7, [r2, #148]	@ 0x94
200228d8:	0a36      	lsrs	r6, r6, #8
200228da:	1cfb      	adds	r3, r7, #3
200228dc:	2b0e      	cmp	r3, #14
200228de:	bf38      	it	cc
200228e0:	230e      	movcc	r3, #14
200228e2:	2b0f      	cmp	r3, #15
200228e4:	bf28      	it	cs
200228e6:	230f      	movcs	r3, #15
200228e8:	f8c2 3094 	str.w	r3, [r2, #148]	@ 0x94
200228ec:	f7ff fb05 	bl	20021efa <HAL_Delay_us>
200228f0:	4a1e      	ldr	r2, [pc, #120]	@ (2002296c <HAL_EFUSE_Read+0xc0>)
200228f2:	00b3      	lsls	r3, r6, #2
200228f4:	6013      	str	r3, [r2, #0]
200228f6:	6813      	ldr	r3, [r2, #0]
200228f8:	491d      	ldr	r1, [pc, #116]	@ (20022970 <HAL_EFUSE_Read+0xc4>)
200228fa:	f043 0301 	orr.w	r3, r3, #1
200228fe:	6013      	str	r3, [r2, #0]
20022900:	464b      	mov	r3, r9
20022902:	4369      	muls	r1, r5
20022904:	6890      	ldr	r0, [r2, #8]
20022906:	07c0      	lsls	r0, r0, #31
20022908:	d50c      	bpl.n	20022924 <HAL_EFUSE_Read+0x78>
2002290a:	6890      	ldr	r0, [r2, #8]
2002290c:	428b      	cmp	r3, r1
2002290e:	f040 0001 	orr.w	r0, r0, #1
20022912:	6090      	str	r0, [r2, #8]
20022914:	d30a      	bcc.n	2002292c <HAL_EFUSE_Read+0x80>
20022916:	4b14      	ldr	r3, [pc, #80]	@ (20022968 <HAL_EFUSE_Read+0xbc>)
20022918:	f8c3 7094 	str.w	r7, [r3, #148]	@ 0x94
2002291c:	2500      	movs	r5, #0
2002291e:	4628      	mov	r0, r5
20022920:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
20022924:	428b      	cmp	r3, r1
20022926:	d2f0      	bcs.n	2002290a <HAL_EFUSE_Read+0x5e>
20022928:	3301      	adds	r3, #1
2002292a:	e7eb      	b.n	20022904 <HAL_EFUSE_Read+0x58>
2002292c:	4a11      	ldr	r2, [pc, #68]	@ (20022974 <HAL_EFUSE_Read+0xc8>)
2002292e:	f008 001c 	and.w	r0, r8, #28
20022932:	eb00 1046 	add.w	r0, r0, r6, lsl #5
20022936:	f025 0103 	bic.w	r1, r5, #3
2002293a:	4402      	add	r2, r0
2002293c:	4421      	add	r1, r4
2002293e:	428c      	cmp	r4, r1
20022940:	d103      	bne.n	2002294a <HAL_EFUSE_Read+0x9e>
20022942:	4b09      	ldr	r3, [pc, #36]	@ (20022968 <HAL_EFUSE_Read+0xbc>)
20022944:	f8c3 7094 	str.w	r7, [r3, #148]	@ 0x94
20022948:	e7e9      	b.n	2002291e <HAL_EFUSE_Read+0x72>
2002294a:	f852 3b04 	ldr.w	r3, [r2], #4
2002294e:	3404      	adds	r4, #4
20022950:	0a18      	lsrs	r0, r3, #8
20022952:	f804 3c04 	strb.w	r3, [r4, #-4]
20022956:	f804 0c03 	strb.w	r0, [r4, #-3]
2002295a:	0c18      	lsrs	r0, r3, #16
2002295c:	0e1b      	lsrs	r3, r3, #24
2002295e:	f804 0c02 	strb.w	r0, [r4, #-2]
20022962:	f804 3c01 	strb.w	r3, [r4, #-1]
20022966:	e7ea      	b.n	2002293e <HAL_EFUSE_Read+0x92>
20022968:	500ca000 	.word	0x500ca000
2002296c:	5000c000 	.word	0x5000c000
20022970:	0005dc00 	.word	0x0005dc00
20022974:	5000c030 	.word	0x5000c030

20022978 <EXT_DMA_SetConfig>:
20022978:	b530      	push	{r4, r5, lr}
2002297a:	2501      	movs	r5, #1
2002297c:	6804      	ldr	r4, [r0, #0]
2002297e:	6065      	str	r5, [r4, #4]
20022980:	6804      	ldr	r4, [r0, #0]
20022982:	60e3      	str	r3, [r4, #12]
20022984:	f101 4370 	add.w	r3, r1, #4026531840	@ 0xf0000000
20022988:	f1b3 5f80 	cmp.w	r3, #268435456	@ 0x10000000
2002298c:	6803      	ldr	r3, [r0, #0]
2002298e:	bf38      	it	cc
20022990:	f101 41a0 	addcc.w	r1, r1, #1342177280	@ 0x50000000
20022994:	6119      	str	r1, [r3, #16]
20022996:	f102 4370 	add.w	r3, r2, #4026531840	@ 0xf0000000
2002299a:	f1b3 5f80 	cmp.w	r3, #268435456	@ 0x10000000
2002299e:	6803      	ldr	r3, [r0, #0]
200229a0:	bf38      	it	cc
200229a2:	f102 42a0 	addcc.w	r2, r2, #1342177280	@ 0x50000000
200229a6:	615a      	str	r2, [r3, #20]
200229a8:	7b03      	ldrb	r3, [r0, #12]
200229aa:	b103      	cbz	r3, 200229ae <EXT_DMA_SetConfig+0x36>
200229ac:	e7fe      	b.n	200229ac <EXT_DMA_SetConfig+0x34>
200229ae:	bd30      	pop	{r4, r5, pc}

200229b0 <HAL_EXT_DMA_Init>:
200229b0:	b510      	push	{r4, lr}
200229b2:	b1c0      	cbz	r0, 200229e6 <HAL_EXT_DMA_Init+0x36>
200229b4:	2302      	movs	r3, #2
200229b6:	4a0d      	ldr	r2, [pc, #52]	@ (200229ec <HAL_EXT_DMA_Init+0x3c>)
200229b8:	7643      	strb	r3, [r0, #25]
200229ba:	6002      	str	r2, [r0, #0]
200229bc:	e9d0 3101 	ldrd	r3, r1, [r0, #4]
200229c0:	6894      	ldr	r4, [r2, #8]
200229c2:	430b      	orrs	r3, r1
200229c4:	490a      	ldr	r1, [pc, #40]	@ (200229f0 <HAL_EXT_DMA_Init+0x40>)
200229c6:	4021      	ands	r1, r4
200229c8:	430b      	orrs	r3, r1
200229ca:	f443 6320 	orr.w	r3, r3, #2560	@ 0xa00
200229ce:	6093      	str	r3, [r2, #8]
200229d0:	7b03      	ldrb	r3, [r0, #12]
200229d2:	b103      	cbz	r3, 200229d6 <HAL_EXT_DMA_Init+0x26>
200229d4:	e7fe      	b.n	200229d4 <HAL_EXT_DMA_Init+0x24>
200229d6:	6802      	ldr	r2, [r0, #0]
200229d8:	6213      	str	r3, [r2, #32]
200229da:	2201      	movs	r2, #1
200229dc:	62c3      	str	r3, [r0, #44]	@ 0x2c
200229de:	7603      	strb	r3, [r0, #24]
200229e0:	7642      	strb	r2, [r0, #25]
200229e2:	4618      	mov	r0, r3
200229e4:	bd10      	pop	{r4, pc}
200229e6:	2001      	movs	r0, #1
200229e8:	e7fc      	b.n	200229e4 <HAL_EXT_DMA_Init+0x34>
200229ea:	bf00      	nop
200229ec:	50001000 	.word	0x50001000
200229f0:	fff0f020 	.word	0xfff0f020

200229f4 <HAL_EXT_DMA_Start>:
200229f4:	f5b3 1f80 	cmp.w	r3, #1048576	@ 0x100000
200229f8:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
200229fa:	d304      	bcc.n	20022a06 <HAL_EXT_DMA_Start+0x12>
200229fc:	f44f 7300 	mov.w	r3, #512	@ 0x200
20022a00:	62c3      	str	r3, [r0, #44]	@ 0x2c
20022a02:	2001      	movs	r0, #1
20022a04:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20022a06:	7e05      	ldrb	r5, [r0, #24]
20022a08:	2d01      	cmp	r5, #1
20022a0a:	d018      	beq.n	20022a3e <HAL_EXT_DMA_Start+0x4a>
20022a0c:	2501      	movs	r5, #1
20022a0e:	7605      	strb	r5, [r0, #24]
20022a10:	7e45      	ldrb	r5, [r0, #25]
20022a12:	2d01      	cmp	r5, #1
20022a14:	f04f 0500 	mov.w	r5, #0
20022a18:	d110      	bne.n	20022a3c <HAL_EXT_DMA_Start+0x48>
20022a1a:	2602      	movs	r6, #2
20022a1c:	6807      	ldr	r7, [r0, #0]
20022a1e:	7646      	strb	r6, [r0, #25]
20022a20:	62c5      	str	r5, [r0, #44]	@ 0x2c
20022a22:	68be      	ldr	r6, [r7, #8]
20022a24:	f026 0601 	bic.w	r6, r6, #1
20022a28:	60be      	str	r6, [r7, #8]
20022a2a:	f7ff ffa5 	bl	20022978 <EXT_DMA_SetConfig>
20022a2e:	6802      	ldr	r2, [r0, #0]
20022a30:	4628      	mov	r0, r5
20022a32:	6893      	ldr	r3, [r2, #8]
20022a34:	f043 0301 	orr.w	r3, r3, #1
20022a38:	6093      	str	r3, [r2, #8]
20022a3a:	e7e3      	b.n	20022a04 <HAL_EXT_DMA_Start+0x10>
20022a3c:	7605      	strb	r5, [r0, #24]
20022a3e:	2002      	movs	r0, #2
20022a40:	e7e0      	b.n	20022a04 <HAL_EXT_DMA_Start+0x10>

20022a42 <HAL_EXT_DMA_PollForTransfer>:
20022a42:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20022a46:	7e43      	ldrb	r3, [r0, #25]
20022a48:	4604      	mov	r4, r0
20022a4a:	2b02      	cmp	r3, #2
20022a4c:	460e      	mov	r6, r1
20022a4e:	4615      	mov	r5, r2
20022a50:	d006      	beq.n	20022a60 <HAL_EXT_DMA_PollForTransfer+0x1e>
20022a52:	2304      	movs	r3, #4
20022a54:	62c3      	str	r3, [r0, #44]	@ 0x2c
20022a56:	2001      	movs	r0, #1
20022a58:	2300      	movs	r3, #0
20022a5a:	7623      	strb	r3, [r4, #24]
20022a5c:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20022a60:	2900      	cmp	r1, #0
20022a62:	bf14      	ite	ne
20022a64:	f04f 0804 	movne.w	r8, #4
20022a68:	f04f 0802 	moveq.w	r8, #2
20022a6c:	f7ff f9e0 	bl	20021e30 <HAL_GetTick>
20022a70:	4607      	mov	r7, r0
20022a72:	6823      	ldr	r3, [r4, #0]
20022a74:	681a      	ldr	r2, [r3, #0]
20022a76:	ea12 0f08 	tst.w	r2, r8
20022a7a:	d006      	beq.n	20022a8a <HAL_EXT_DMA_PollForTransfer+0x48>
20022a7c:	b9e6      	cbnz	r6, 20022ab8 <HAL_EXT_DMA_PollForTransfer+0x76>
20022a7e:	2202      	movs	r2, #2
20022a80:	605a      	str	r2, [r3, #4]
20022a82:	2301      	movs	r3, #1
20022a84:	7663      	strb	r3, [r4, #25]
20022a86:	2000      	movs	r0, #0
20022a88:	e7e6      	b.n	20022a58 <HAL_EXT_DMA_PollForTransfer+0x16>
20022a8a:	681a      	ldr	r2, [r3, #0]
20022a8c:	f012 0f18 	tst.w	r2, #24
20022a90:	d004      	beq.n	20022a9c <HAL_EXT_DMA_PollForTransfer+0x5a>
20022a92:	2201      	movs	r2, #1
20022a94:	605a      	str	r2, [r3, #4]
20022a96:	62e2      	str	r2, [r4, #44]	@ 0x2c
20022a98:	7662      	strb	r2, [r4, #25]
20022a9a:	e7dc      	b.n	20022a56 <HAL_EXT_DMA_PollForTransfer+0x14>
20022a9c:	1c6a      	adds	r2, r5, #1
20022a9e:	d0e9      	beq.n	20022a74 <HAL_EXT_DMA_PollForTransfer+0x32>
20022aa0:	f7ff f9c6 	bl	20021e30 <HAL_GetTick>
20022aa4:	1bc0      	subs	r0, r0, r7
20022aa6:	42a8      	cmp	r0, r5
20022aa8:	d801      	bhi.n	20022aae <HAL_EXT_DMA_PollForTransfer+0x6c>
20022aaa:	2d00      	cmp	r5, #0
20022aac:	d1e1      	bne.n	20022a72 <HAL_EXT_DMA_PollForTransfer+0x30>
20022aae:	2320      	movs	r3, #32
20022ab0:	62e3      	str	r3, [r4, #44]	@ 0x2c
20022ab2:	2301      	movs	r3, #1
20022ab4:	7663      	strb	r3, [r4, #25]
20022ab6:	e7ce      	b.n	20022a56 <HAL_EXT_DMA_PollForTransfer+0x14>
20022ab8:	2204      	movs	r2, #4
20022aba:	605a      	str	r2, [r3, #4]
20022abc:	e7e3      	b.n	20022a86 <HAL_EXT_DMA_PollForTransfer+0x44>

20022abe <HAL_DBG_printf>:
20022abe:	b40f      	push	{r0, r1, r2, r3}
20022ac0:	b004      	add	sp, #16
20022ac2:	4770      	bx	lr

20022ac4 <HAL_Get_backup>:
20022ac4:	4b01      	ldr	r3, [pc, #4]	@ (20022acc <HAL_Get_backup+0x8>)
20022ac6:	f853 0020 	ldr.w	r0, [r3, r0, lsl #2]
20022aca:	4770      	bx	lr
20022acc:	500cb030 	.word	0x500cb030

20022ad0 <HAL_HPAON_WakeCore>:
20022ad0:	2802      	cmp	r0, #2
20022ad2:	b510      	push	{r4, lr}
20022ad4:	d120      	bne.n	20022b18 <HAL_HPAON_WakeCore+0x48>
20022ad6:	4c11      	ldr	r4, [pc, #68]	@ (20022b1c <HAL_HPAON_WakeCore+0x4c>)
20022ad8:	20e6      	movs	r0, #230	@ 0xe6
20022ada:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
20022adc:	f043 0301 	orr.w	r3, r3, #1
20022ae0:	62e3      	str	r3, [r4, #44]	@ 0x2c
20022ae2:	f7ff fa0a 	bl	20021efa <HAL_Delay_us>
20022ae6:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
20022ae8:	069a      	lsls	r2, r3, #26
20022aea:	d5fc      	bpl.n	20022ae6 <HAL_HPAON_WakeCore+0x16>
20022aec:	201e      	movs	r0, #30
20022aee:	f7ff fa04 	bl	20021efa <HAL_Delay_us>
20022af2:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
20022af4:	069b      	lsls	r3, r3, #26
20022af6:	d5fc      	bpl.n	20022af2 <HAL_HPAON_WakeCore+0x22>
20022af8:	f3ef 8110 	mrs	r1, PRIMASK
20022afc:	2301      	movs	r3, #1
20022afe:	f383 8810 	msr	PRIMASK, r3
20022b02:	4a07      	ldr	r2, [pc, #28]	@ (20022b20 <HAL_HPAON_WakeCore+0x50>)
20022b04:	7813      	ldrb	r3, [r2, #0]
20022b06:	2b13      	cmp	r3, #19
20022b08:	d900      	bls.n	20022b0c <HAL_HPAON_WakeCore+0x3c>
20022b0a:	e7fe      	b.n	20022b0a <HAL_HPAON_WakeCore+0x3a>
20022b0c:	3301      	adds	r3, #1
20022b0e:	7013      	strb	r3, [r2, #0]
20022b10:	f381 8810 	msr	PRIMASK, r1
20022b14:	2000      	movs	r0, #0
20022b16:	bd10      	pop	{r4, pc}
20022b18:	2001      	movs	r0, #1
20022b1a:	e7fc      	b.n	20022b16 <HAL_HPAON_WakeCore+0x46>
20022b1c:	500c0000 	.word	0x500c0000
20022b20:	20049f5c 	.word	0x20049f5c

20022b24 <HAL_HPAON_EnableXT48>:
20022b24:	4b04      	ldr	r3, [pc, #16]	@ (20022b38 <HAL_HPAON_EnableXT48+0x14>)
20022b26:	691a      	ldr	r2, [r3, #16]
20022b28:	f042 0202 	orr.w	r2, r2, #2
20022b2c:	611a      	str	r2, [r3, #16]
20022b2e:	691a      	ldr	r2, [r3, #16]
20022b30:	2a00      	cmp	r2, #0
20022b32:	dafc      	bge.n	20022b2e <HAL_HPAON_EnableXT48+0xa>
20022b34:	4770      	bx	lr
20022b36:	bf00      	nop
20022b38:	500c0000 	.word	0x500c0000

20022b3c <HAL_HPAON_DisableXT48>:
20022b3c:	4a02      	ldr	r2, [pc, #8]	@ (20022b48 <HAL_HPAON_DisableXT48+0xc>)
20022b3e:	6913      	ldr	r3, [r2, #16]
20022b40:	f023 0302 	bic.w	r3, r3, #2
20022b44:	6113      	str	r3, [r2, #16]
20022b46:	4770      	bx	lr
20022b48:	500c0000 	.word	0x500c0000

20022b4c <HAL_QSPI_Init>:
20022b4c:	b510      	push	{r4, lr}
20022b4e:	b1e0      	cbz	r0, 20022b8a <HAL_QSPI_Init+0x3e>
20022b50:	b1d9      	cbz	r1, 20022b8a <HAL_QSPI_Init+0x3e>
20022b52:	2300      	movs	r3, #0
20022b54:	2201      	movs	r2, #1
20022b56:	6043      	str	r3, [r0, #4]
20022b58:	f880 2022 	strb.w	r2, [r0, #34]	@ 0x22
20022b5c:	680c      	ldr	r4, [r1, #0]
20022b5e:	6004      	str	r4, [r0, #0]
20022b60:	684a      	ldr	r2, [r1, #4]
20022b62:	f880 2020 	strb.w	r2, [r0, #32]
20022b66:	688a      	ldr	r2, [r1, #8]
20022b68:	6102      	str	r2, [r0, #16]
20022b6a:	68ca      	ldr	r2, [r1, #12]
20022b6c:	0512      	lsls	r2, r2, #20
20022b6e:	6142      	str	r2, [r0, #20]
20022b70:	22ff      	movs	r2, #255	@ 0xff
20022b72:	f8c4 2084 	str.w	r2, [r4, #132]	@ 0x84
20022b76:	f04f 2450 	mov.w	r4, #1342197760	@ 0x50005000
20022b7a:	6801      	ldr	r1, [r0, #0]
20022b7c:	678c      	str	r4, [r1, #120]	@ 0x78
20022b7e:	6801      	ldr	r1, [r0, #0]
20022b80:	620a      	str	r2, [r1, #32]
20022b82:	6801      	ldr	r1, [r0, #0]
20022b84:	4618      	mov	r0, r3
20022b86:	644a      	str	r2, [r1, #68]	@ 0x44
20022b88:	bd10      	pop	{r4, pc}
20022b8a:	2001      	movs	r0, #1
20022b8c:	e7fc      	b.n	20022b88 <HAL_QSPI_Init+0x3c>

20022b8e <HAL_FLASH_SET_AHB_RCMD>:
20022b8e:	b138      	cbz	r0, 20022ba0 <HAL_FLASH_SET_AHB_RCMD+0x12>
20022b90:	6802      	ldr	r2, [r0, #0]
20022b92:	2000      	movs	r0, #0
20022b94:	6c13      	ldr	r3, [r2, #64]	@ 0x40
20022b96:	f023 03ff 	bic.w	r3, r3, #255	@ 0xff
20022b9a:	4319      	orrs	r1, r3
20022b9c:	6411      	str	r1, [r2, #64]	@ 0x40
20022b9e:	4770      	bx	lr
20022ba0:	2001      	movs	r0, #1
20022ba2:	4770      	bx	lr

20022ba4 <HAL_FLASH_CFG_AHB_RCMD>:
20022ba4:	b570      	push	{r4, r5, r6, lr}
20022ba6:	b1c8      	cbz	r0, 20022bdc <HAL_FLASH_CFG_AHB_RCMD+0x38>
20022ba8:	6805      	ldr	r5, [r0, #0]
20022baa:	f99d 6018 	ldrsb.w	r6, [sp, #24]
20022bae:	f99d 001c 	ldrsb.w	r0, [sp, #28]
20022bb2:	6cac      	ldr	r4, [r5, #72]	@ 0x48
20022bb4:	ea40 00c6 	orr.w	r0, r0, r6, lsl #3
20022bb8:	ea40 23c3 	orr.w	r3, r0, r3, lsl #11
20022bbc:	f99d 0010 	ldrsb.w	r0, [sp, #16]
20022bc0:	f36f 0414 	bfc	r4, #0, #21
20022bc4:	ea43 2300 	orr.w	r3, r3, r0, lsl #8
20022bc8:	f99d 0014 	ldrsb.w	r0, [sp, #20]
20022bcc:	ea43 1380 	orr.w	r3, r3, r0, lsl #6
20022bd0:	ea43 3242 	orr.w	r2, r3, r2, lsl #13
20022bd4:	ea42 4181 	orr.w	r1, r2, r1, lsl #18
20022bd8:	4321      	orrs	r1, r4
20022bda:	64a9      	str	r1, [r5, #72]	@ 0x48
20022bdc:	bd70      	pop	{r4, r5, r6, pc}

20022bde <HAL_FLASH_SET_AHB_WCMD>:
20022bde:	b140      	cbz	r0, 20022bf2 <HAL_FLASH_SET_AHB_WCMD+0x14>
20022be0:	6802      	ldr	r2, [r0, #0]
20022be2:	2000      	movs	r0, #0
20022be4:	6c13      	ldr	r3, [r2, #64]	@ 0x40
20022be6:	f423 437f 	bic.w	r3, r3, #65280	@ 0xff00
20022bea:	ea43 2101 	orr.w	r1, r3, r1, lsl #8
20022bee:	6411      	str	r1, [r2, #64]	@ 0x40
20022bf0:	4770      	bx	lr
20022bf2:	2001      	movs	r0, #1
20022bf4:	4770      	bx	lr

20022bf6 <HAL_FLASH_CFG_AHB_WCMD>:
20022bf6:	b570      	push	{r4, r5, r6, lr}
20022bf8:	b1c8      	cbz	r0, 20022c2e <HAL_FLASH_CFG_AHB_WCMD+0x38>
20022bfa:	6805      	ldr	r5, [r0, #0]
20022bfc:	f99d 6018 	ldrsb.w	r6, [sp, #24]
20022c00:	f99d 001c 	ldrsb.w	r0, [sp, #28]
20022c04:	6d2c      	ldr	r4, [r5, #80]	@ 0x50
20022c06:	ea40 00c6 	orr.w	r0, r0, r6, lsl #3
20022c0a:	ea40 23c3 	orr.w	r3, r0, r3, lsl #11
20022c0e:	f99d 0010 	ldrsb.w	r0, [sp, #16]
20022c12:	f36f 0414 	bfc	r4, #0, #21
20022c16:	ea43 2300 	orr.w	r3, r3, r0, lsl #8
20022c1a:	f99d 0014 	ldrsb.w	r0, [sp, #20]
20022c1e:	ea43 1380 	orr.w	r3, r3, r0, lsl #6
20022c22:	ea43 3242 	orr.w	r2, r3, r2, lsl #13
20022c26:	ea42 4181 	orr.w	r1, r2, r1, lsl #18
20022c2a:	4321      	orrs	r1, r4
20022c2c:	6529      	str	r1, [r5, #80]	@ 0x50
20022c2e:	bd70      	pop	{r4, r5, r6, pc}

20022c30 <HAL_FLASH_WRITE_WORD>:
20022c30:	b118      	cbz	r0, 20022c3a <HAL_FLASH_WRITE_WORD+0xa>
20022c32:	6803      	ldr	r3, [r0, #0]
20022c34:	2000      	movs	r0, #0
20022c36:	6059      	str	r1, [r3, #4]
20022c38:	4770      	bx	lr
20022c3a:	2001      	movs	r0, #1
20022c3c:	4770      	bx	lr

20022c3e <HAL_FLASH_WRITE_DLEN>:
20022c3e:	b130      	cbz	r0, 20022c4e <HAL_FLASH_WRITE_DLEN+0x10>
20022c40:	6803      	ldr	r3, [r0, #0]
20022c42:	3901      	subs	r1, #1
20022c44:	f3c1 0113 	ubfx	r1, r1, #0, #20
20022c48:	2000      	movs	r0, #0
20022c4a:	6259      	str	r1, [r3, #36]	@ 0x24
20022c4c:	4770      	bx	lr
20022c4e:	2001      	movs	r0, #1
20022c50:	4770      	bx	lr

20022c52 <HAL_FLASH_WRITE_DLEN2>:
20022c52:	b130      	cbz	r0, 20022c62 <HAL_FLASH_WRITE_DLEN2+0x10>
20022c54:	6803      	ldr	r3, [r0, #0]
20022c56:	3901      	subs	r1, #1
20022c58:	f3c1 0113 	ubfx	r1, r1, #0, #20
20022c5c:	2000      	movs	r0, #0
20022c5e:	6399      	str	r1, [r3, #56]	@ 0x38
20022c60:	4770      	bx	lr
20022c62:	2001      	movs	r0, #1
20022c64:	4770      	bx	lr

20022c66 <HAL_FLASH_WRITE_ABYTE>:
20022c66:	b108      	cbz	r0, 20022c6c <HAL_FLASH_WRITE_ABYTE+0x6>
20022c68:	6803      	ldr	r3, [r0, #0]
20022c6a:	6219      	str	r1, [r3, #32]
20022c6c:	4770      	bx	lr

20022c6e <HAL_FLASH_IS_CMD_DONE>:
20022c6e:	b118      	cbz	r0, 20022c78 <HAL_FLASH_IS_CMD_DONE+0xa>
20022c70:	6803      	ldr	r3, [r0, #0]
20022c72:	6918      	ldr	r0, [r3, #16]
20022c74:	f000 0001 	and.w	r0, r0, #1
20022c78:	4770      	bx	lr

20022c7a <HAL_FLASH_CLR_CMD_DONE>:
20022c7a:	b120      	cbz	r0, 20022c86 <HAL_FLASH_CLR_CMD_DONE+0xc>
20022c7c:	6802      	ldr	r2, [r0, #0]
20022c7e:	6953      	ldr	r3, [r2, #20]
20022c80:	f043 0301 	orr.w	r3, r3, #1
20022c84:	6153      	str	r3, [r2, #20]
20022c86:	4770      	bx	lr

20022c88 <HAL_FLASH_SET_CMD>:
20022c88:	b538      	push	{r3, r4, r5, lr}
20022c8a:	460d      	mov	r5, r1
20022c8c:	4604      	mov	r4, r0
20022c8e:	b1a8      	cbz	r0, 20022cbc <HAL_FLASH_SET_CMD+0x34>
20022c90:	6803      	ldr	r3, [r0, #0]
20022c92:	61da      	str	r2, [r3, #28]
20022c94:	6ac3      	ldr	r3, [r0, #44]	@ 0x2c
20022c96:	b10b      	cbz	r3, 20022c9c <HAL_FLASH_SET_CMD+0x14>
20022c98:	2001      	movs	r0, #1
20022c9a:	4798      	blx	r3
20022c9c:	6823      	ldr	r3, [r4, #0]
20022c9e:	619d      	str	r5, [r3, #24]
20022ca0:	4620      	mov	r0, r4
20022ca2:	f7ff ffe4 	bl	20022c6e <HAL_FLASH_IS_CMD_DONE>
20022ca6:	2800      	cmp	r0, #0
20022ca8:	d0fa      	beq.n	20022ca0 <HAL_FLASH_SET_CMD+0x18>
20022caa:	4620      	mov	r0, r4
20022cac:	f7ff ffe5 	bl	20022c7a <HAL_FLASH_CLR_CMD_DONE>
20022cb0:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
20022cb2:	b10b      	cbz	r3, 20022cb8 <HAL_FLASH_SET_CMD+0x30>
20022cb4:	2000      	movs	r0, #0
20022cb6:	4798      	blx	r3
20022cb8:	2000      	movs	r0, #0
20022cba:	bd38      	pop	{r3, r4, r5, pc}
20022cbc:	2001      	movs	r0, #1
20022cbe:	e7fc      	b.n	20022cba <HAL_FLASH_SET_CMD+0x32>

20022cc0 <HAL_FLASH_CLR_STATUS>:
20022cc0:	b118      	cbz	r0, 20022cca <HAL_FLASH_CLR_STATUS+0xa>
20022cc2:	6802      	ldr	r2, [r0, #0]
20022cc4:	6953      	ldr	r3, [r2, #20]
20022cc6:	4319      	orrs	r1, r3
20022cc8:	6151      	str	r1, [r2, #20]
20022cca:	4770      	bx	lr

20022ccc <HAL_FLASH_STATUS_MATCH>:
20022ccc:	b118      	cbz	r0, 20022cd6 <HAL_FLASH_STATUS_MATCH+0xa>
20022cce:	6803      	ldr	r3, [r0, #0]
20022cd0:	6918      	ldr	r0, [r3, #16]
20022cd2:	f3c0 00c0 	ubfx	r0, r0, #3, #1
20022cd6:	4770      	bx	lr

20022cd8 <HAL_FLASH_IS_PROG_DONE>:
20022cd8:	b128      	cbz	r0, 20022ce6 <HAL_FLASH_IS_PROG_DONE+0xe>
20022cda:	6803      	ldr	r3, [r0, #0]
20022cdc:	6858      	ldr	r0, [r3, #4]
20022cde:	43c0      	mvns	r0, r0
20022ce0:	f000 0001 	and.w	r0, r0, #1
20022ce4:	4770      	bx	lr
20022ce6:	2001      	movs	r0, #1
20022ce8:	4770      	bx	lr

20022cea <HAL_FLASH_READ32>:
20022cea:	b108      	cbz	r0, 20022cf0 <HAL_FLASH_READ32+0x6>
20022cec:	6803      	ldr	r3, [r0, #0]
20022cee:	6858      	ldr	r0, [r3, #4]
20022cf0:	4770      	bx	lr

20022cf2 <HAL_FLASH_SET_TXSLOT>:
20022cf2:	b120      	cbz	r0, 20022cfe <HAL_FLASH_SET_TXSLOT+0xc>
20022cf4:	6802      	ldr	r2, [r0, #0]
20022cf6:	6d53      	ldr	r3, [r2, #84]	@ 0x54
20022cf8:	f361 238e 	bfi	r3, r1, #10, #5
20022cfc:	6553      	str	r3, [r2, #84]	@ 0x54
20022cfe:	4770      	bx	lr

20022d00 <HAL_FLASH_SET_CLK_rom>:
20022d00:	b108      	cbz	r0, 20022d06 <HAL_FLASH_SET_CLK_rom+0x6>
20022d02:	6803      	ldr	r3, [r0, #0]
20022d04:	60d9      	str	r1, [r3, #12]
20022d06:	4770      	bx	lr

20022d08 <HAL_FLASH_GET_DIV>:
20022d08:	b110      	cbz	r0, 20022d10 <HAL_FLASH_GET_DIV+0x8>
20022d0a:	6803      	ldr	r3, [r0, #0]
20022d0c:	68d8      	ldr	r0, [r3, #12]
20022d0e:	b2c0      	uxtb	r0, r0
20022d10:	4770      	bx	lr

20022d12 <HAL_FLASH_MANUAL_CMD>:
20022d12:	b570      	push	{r4, r5, r6, lr}
20022d14:	b1e8      	cbz	r0, 20022d52 <HAL_FLASH_MANUAL_CMD+0x40>
20022d16:	6805      	ldr	r5, [r0, #0]
20022d18:	f99d 601c 	ldrsb.w	r6, [sp, #28]
20022d1c:	f99d 0020 	ldrsb.w	r0, [sp, #32]
20022d20:	6aac      	ldr	r4, [r5, #40]	@ 0x28
20022d22:	ea40 00c6 	orr.w	r0, r0, r6, lsl #3
20022d26:	f99d 6010 	ldrsb.w	r6, [sp, #16]
20022d2a:	f36f 0415 	bfc	r4, #0, #22
20022d2e:	ea40 20c6 	orr.w	r0, r0, r6, lsl #11
20022d32:	f99d 6014 	ldrsb.w	r6, [sp, #20]
20022d36:	ea40 2006 	orr.w	r0, r0, r6, lsl #8
20022d3a:	f99d 6018 	ldrsb.w	r6, [sp, #24]
20022d3e:	ea40 1086 	orr.w	r0, r0, r6, lsl #6
20022d42:	ea40 3343 	orr.w	r3, r0, r3, lsl #13
20022d46:	ea43 4282 	orr.w	r2, r3, r2, lsl #18
20022d4a:	ea42 5141 	orr.w	r1, r2, r1, lsl #21
20022d4e:	4321      	orrs	r1, r4
20022d50:	62a9      	str	r1, [r5, #40]	@ 0x28
20022d52:	bd70      	pop	{r4, r5, r6, pc}

20022d54 <HAL_FLASH_MANUAL_CMD2>:
20022d54:	b570      	push	{r4, r5, r6, lr}
20022d56:	b1e8      	cbz	r0, 20022d94 <HAL_FLASH_MANUAL_CMD2+0x40>
20022d58:	6805      	ldr	r5, [r0, #0]
20022d5a:	f99d 601c 	ldrsb.w	r6, [sp, #28]
20022d5e:	f99d 0020 	ldrsb.w	r0, [sp, #32]
20022d62:	6bec      	ldr	r4, [r5, #60]	@ 0x3c
20022d64:	ea40 00c6 	orr.w	r0, r0, r6, lsl #3
20022d68:	f99d 6010 	ldrsb.w	r6, [sp, #16]
20022d6c:	f36f 0415 	bfc	r4, #0, #22
20022d70:	ea40 20c6 	orr.w	r0, r0, r6, lsl #11
20022d74:	f99d 6014 	ldrsb.w	r6, [sp, #20]
20022d78:	ea40 2006 	orr.w	r0, r0, r6, lsl #8
20022d7c:	f99d 6018 	ldrsb.w	r6, [sp, #24]
20022d80:	ea40 1086 	orr.w	r0, r0, r6, lsl #6
20022d84:	ea40 3343 	orr.w	r3, r0, r3, lsl #13
20022d88:	ea43 4282 	orr.w	r2, r3, r2, lsl #18
20022d8c:	ea42 5141 	orr.w	r1, r2, r1, lsl #21
20022d90:	4321      	orrs	r1, r4
20022d92:	63e9      	str	r1, [r5, #60]	@ 0x3c
20022d94:	bd70      	pop	{r4, r5, r6, pc}
	...

20022d98 <HAL_FLASH_SET_ALIAS_RANGE>:
20022d98:	b510      	push	{r4, lr}
20022d9a:	b158      	cbz	r0, 20022db4 <HAL_FLASH_SET_ALIAS_RANGE+0x1c>
20022d9c:	4b06      	ldr	r3, [pc, #24]	@ (20022db8 <HAL_FLASH_SET_ALIAS_RANGE+0x20>)
20022d9e:	6804      	ldr	r4, [r0, #0]
20022da0:	f202 32ff 	addw	r2, r2, #1023	@ 0x3ff
20022da4:	440a      	add	r2, r1
20022da6:	4019      	ands	r1, r3
20022da8:	66e1      	str	r1, [r4, #108]	@ 0x6c
20022daa:	401a      	ands	r2, r3
20022dac:	6803      	ldr	r3, [r0, #0]
20022dae:	2000      	movs	r0, #0
20022db0:	671a      	str	r2, [r3, #112]	@ 0x70
20022db2:	bd10      	pop	{r4, pc}
20022db4:	2001      	movs	r0, #1
20022db6:	e7fc      	b.n	20022db2 <HAL_FLASH_SET_ALIAS_RANGE+0x1a>
20022db8:	fffffc00 	.word	0xfffffc00

20022dbc <HAL_FLASH_SET_ALIAS_OFFSET>:
20022dbc:	b128      	cbz	r0, 20022dca <HAL_FLASH_SET_ALIAS_OFFSET+0xe>
20022dbe:	6803      	ldr	r3, [r0, #0]
20022dc0:	f36f 0109 	bfc	r1, #0, #10
20022dc4:	2000      	movs	r0, #0
20022dc6:	6759      	str	r1, [r3, #116]	@ 0x74
20022dc8:	4770      	bx	lr
20022dca:	2001      	movs	r0, #1
20022dcc:	4770      	bx	lr
	...

20022dd0 <HAL_FLASH_SET_CTR>:
20022dd0:	b510      	push	{r4, lr}
20022dd2:	b150      	cbz	r0, 20022dea <HAL_FLASH_SET_CTR+0x1a>
20022dd4:	4b06      	ldr	r3, [pc, #24]	@ (20022df0 <HAL_FLASH_SET_CTR+0x20>)
20022dd6:	6804      	ldr	r4, [r0, #0]
20022dd8:	4019      	ands	r1, r3
20022dda:	65e1      	str	r1, [r4, #92]	@ 0x5c
20022ddc:	6801      	ldr	r1, [r0, #0]
20022dde:	2000      	movs	r0, #0
20022de0:	f202 32ff 	addw	r2, r2, #1023	@ 0x3ff
20022de4:	401a      	ands	r2, r3
20022de6:	660a      	str	r2, [r1, #96]	@ 0x60
20022de8:	bd10      	pop	{r4, pc}
20022dea:	2001      	movs	r0, #1
20022dec:	e7fc      	b.n	20022de8 <HAL_FLASH_SET_CTR+0x18>
20022dee:	bf00      	nop
20022df0:	fffffc00 	.word	0xfffffc00

20022df4 <HAL_FLASH_SET_NONCE>:
20022df4:	b150      	cbz	r0, 20022e0c <HAL_FLASH_SET_NONCE+0x18>
20022df6:	b149      	cbz	r1, 20022e0c <HAL_FLASH_SET_NONCE+0x18>
20022df8:	680b      	ldr	r3, [r1, #0]
20022dfa:	6802      	ldr	r2, [r0, #0]
20022dfc:	ba1b      	rev	r3, r3
20022dfe:	6653      	str	r3, [r2, #100]	@ 0x64
20022e00:	684b      	ldr	r3, [r1, #4]
20022e02:	6802      	ldr	r2, [r0, #0]
20022e04:	ba1b      	rev	r3, r3
20022e06:	2000      	movs	r0, #0
20022e08:	6693      	str	r3, [r2, #104]	@ 0x68
20022e0a:	4770      	bx	lr
20022e0c:	2001      	movs	r0, #1
20022e0e:	4770      	bx	lr

20022e10 <HAL_FLASH_SET_AES>:
20022e10:	b158      	cbz	r0, 20022e2a <HAL_FLASH_SET_AES+0x1a>
20022e12:	6803      	ldr	r3, [r0, #0]
20022e14:	2901      	cmp	r1, #1
20022e16:	681a      	ldr	r2, [r3, #0]
20022e18:	d104      	bne.n	20022e24 <HAL_FLASH_SET_AES+0x14>
20022e1a:	f042 0280 	orr.w	r2, r2, #128	@ 0x80
20022e1e:	2000      	movs	r0, #0
20022e20:	601a      	str	r2, [r3, #0]
20022e22:	4770      	bx	lr
20022e24:	f022 0280 	bic.w	r2, r2, #128	@ 0x80
20022e28:	e7f9      	b.n	20022e1e <HAL_FLASH_SET_AES+0xe>
20022e2a:	2001      	movs	r0, #1
20022e2c:	4770      	bx	lr

20022e2e <HAL_FLASH_ENABLE_AES>:
20022e2e:	b150      	cbz	r0, 20022e46 <HAL_FLASH_ENABLE_AES+0x18>
20022e30:	6803      	ldr	r3, [r0, #0]
20022e32:	681a      	ldr	r2, [r3, #0]
20022e34:	b121      	cbz	r1, 20022e40 <HAL_FLASH_ENABLE_AES+0x12>
20022e36:	f042 0240 	orr.w	r2, r2, #64	@ 0x40
20022e3a:	2000      	movs	r0, #0
20022e3c:	601a      	str	r2, [r3, #0]
20022e3e:	4770      	bx	lr
20022e40:	f022 0240 	bic.w	r2, r2, #64	@ 0x40
20022e44:	e7f9      	b.n	20022e3a <HAL_FLASH_ENABLE_AES+0xc>
20022e46:	2001      	movs	r0, #1
20022e48:	4770      	bx	lr

20022e4a <HAL_FLASH_ENABLE_QSPI>:
20022e4a:	b150      	cbz	r0, 20022e62 <HAL_FLASH_ENABLE_QSPI+0x18>
20022e4c:	6803      	ldr	r3, [r0, #0]
20022e4e:	681a      	ldr	r2, [r3, #0]
20022e50:	b121      	cbz	r1, 20022e5c <HAL_FLASH_ENABLE_QSPI+0x12>
20022e52:	f042 0201 	orr.w	r2, r2, #1
20022e56:	2000      	movs	r0, #0
20022e58:	601a      	str	r2, [r3, #0]
20022e5a:	4770      	bx	lr
20022e5c:	f022 0201 	bic.w	r2, r2, #1
20022e60:	e7f9      	b.n	20022e56 <HAL_FLASH_ENABLE_QSPI+0xc>
20022e62:	2001      	movs	r0, #1
20022e64:	4770      	bx	lr

20022e66 <HAL_FLASH_ENABLE_OPI>:
20022e66:	b150      	cbz	r0, 20022e7e <HAL_FLASH_ENABLE_OPI+0x18>
20022e68:	6803      	ldr	r3, [r0, #0]
20022e6a:	681a      	ldr	r2, [r3, #0]
20022e6c:	b121      	cbz	r1, 20022e78 <HAL_FLASH_ENABLE_OPI+0x12>
20022e6e:	f442 1200 	orr.w	r2, r2, #2097152	@ 0x200000
20022e72:	2000      	movs	r0, #0
20022e74:	601a      	str	r2, [r3, #0]
20022e76:	4770      	bx	lr
20022e78:	f422 1200 	bic.w	r2, r2, #2097152	@ 0x200000
20022e7c:	e7f9      	b.n	20022e72 <HAL_FLASH_ENABLE_OPI+0xc>
20022e7e:	2001      	movs	r0, #1
20022e80:	4770      	bx	lr

20022e82 <HAL_FLASH_ENABLE_HYPER>:
20022e82:	b150      	cbz	r0, 20022e9a <HAL_FLASH_ENABLE_HYPER+0x18>
20022e84:	6803      	ldr	r3, [r0, #0]
20022e86:	689a      	ldr	r2, [r3, #8]
20022e88:	b121      	cbz	r1, 20022e94 <HAL_FLASH_ENABLE_HYPER+0x12>
20022e8a:	f042 0210 	orr.w	r2, r2, #16
20022e8e:	2000      	movs	r0, #0
20022e90:	609a      	str	r2, [r3, #8]
20022e92:	4770      	bx	lr
20022e94:	f022 0210 	bic.w	r2, r2, #16
20022e98:	e7f9      	b.n	20022e8e <HAL_FLASH_ENABLE_HYPER+0xc>
20022e9a:	2001      	movs	r0, #1
20022e9c:	4770      	bx	lr

20022e9e <HAL_FLASH_ENABLE_CMD2>:
20022e9e:	b150      	cbz	r0, 20022eb6 <HAL_FLASH_ENABLE_CMD2+0x18>
20022ea0:	6803      	ldr	r3, [r0, #0]
20022ea2:	681a      	ldr	r2, [r3, #0]
20022ea4:	b121      	cbz	r1, 20022eb0 <HAL_FLASH_ENABLE_CMD2+0x12>
20022ea6:	f442 3280 	orr.w	r2, r2, #65536	@ 0x10000
20022eaa:	2000      	movs	r0, #0
20022eac:	601a      	str	r2, [r3, #0]
20022eae:	4770      	bx	lr
20022eb0:	f422 3280 	bic.w	r2, r2, #65536	@ 0x10000
20022eb4:	e7f9      	b.n	20022eaa <HAL_FLASH_ENABLE_CMD2+0xc>
20022eb6:	2001      	movs	r0, #1
20022eb8:	4770      	bx	lr

20022eba <HAL_FLASH_STAUS_MATCH_CMD2>:
20022eba:	b150      	cbz	r0, 20022ed2 <HAL_FLASH_STAUS_MATCH_CMD2+0x18>
20022ebc:	6803      	ldr	r3, [r0, #0]
20022ebe:	681a      	ldr	r2, [r3, #0]
20022ec0:	b121      	cbz	r1, 20022ecc <HAL_FLASH_STAUS_MATCH_CMD2+0x12>
20022ec2:	f442 2280 	orr.w	r2, r2, #262144	@ 0x40000
20022ec6:	2000      	movs	r0, #0
20022ec8:	601a      	str	r2, [r3, #0]
20022eca:	4770      	bx	lr
20022ecc:	f422 2280 	bic.w	r2, r2, #262144	@ 0x40000
20022ed0:	e7f9      	b.n	20022ec6 <HAL_FLASH_STAUS_MATCH_CMD2+0xc>
20022ed2:	2001      	movs	r0, #1
20022ed4:	4770      	bx	lr

20022ed6 <HAL_FLASH_SET_CS_TIME>:
20022ed6:	b530      	push	{r4, r5, lr}
20022ed8:	b180      	cbz	r0, 20022efc <HAL_FLASH_SET_CS_TIME+0x26>
20022eda:	6805      	ldr	r5, [r0, #0]
20022edc:	f8bd 000c 	ldrh.w	r0, [sp, #12]
20022ee0:	68ac      	ldr	r4, [r5, #8]
20022ee2:	0680      	lsls	r0, r0, #26
20022ee4:	ea40 5383 	orr.w	r3, r0, r3, lsl #22
20022ee8:	2000      	movs	r0, #0
20022eea:	ea43 4181 	orr.w	r1, r3, r1, lsl #18
20022eee:	f36f 149e 	bfc	r4, #6, #25
20022ef2:	ea41 1282 	orr.w	r2, r1, r2, lsl #6
20022ef6:	4322      	orrs	r2, r4
20022ef8:	60aa      	str	r2, [r5, #8]
20022efa:	bd30      	pop	{r4, r5, pc}
20022efc:	2001      	movs	r0, #1
20022efe:	e7fc      	b.n	20022efa <HAL_FLASH_SET_CS_TIME+0x24>

20022f00 <HAL_FLASH_SET_ROW_BOUNDARY>:
20022f00:	b130      	cbz	r0, 20022f10 <HAL_FLASH_SET_ROW_BOUNDARY+0x10>
20022f02:	6802      	ldr	r2, [r0, #0]
20022f04:	2000      	movs	r0, #0
20022f06:	6893      	ldr	r3, [r2, #8]
20022f08:	f361 0302 	bfi	r3, r1, #0, #3
20022f0c:	6093      	str	r3, [r2, #8]
20022f0e:	4770      	bx	lr
20022f10:	2001      	movs	r0, #1
20022f12:	4770      	bx	lr

20022f14 <HAL_FLASH_SET_LEGACY>:
20022f14:	b150      	cbz	r0, 20022f2c <HAL_FLASH_SET_LEGACY+0x18>
20022f16:	6803      	ldr	r3, [r0, #0]
20022f18:	689a      	ldr	r2, [r3, #8]
20022f1a:	b121      	cbz	r1, 20022f26 <HAL_FLASH_SET_LEGACY+0x12>
20022f1c:	f042 0220 	orr.w	r2, r2, #32
20022f20:	2000      	movs	r0, #0
20022f22:	609a      	str	r2, [r3, #8]
20022f24:	4770      	bx	lr
20022f26:	f022 0220 	bic.w	r2, r2, #32
20022f2a:	e7f9      	b.n	20022f20 <HAL_FLASH_SET_LEGACY+0xc>
20022f2c:	2001      	movs	r0, #1
20022f2e:	4770      	bx	lr

20022f30 <HAL_FLASH_SET_DUAL_MODE>:
20022f30:	b150      	cbz	r0, 20022f48 <HAL_FLASH_SET_DUAL_MODE+0x18>
20022f32:	6803      	ldr	r3, [r0, #0]
20022f34:	681a      	ldr	r2, [r3, #0]
20022f36:	b121      	cbz	r1, 20022f42 <HAL_FLASH_SET_DUAL_MODE+0x12>
20022f38:	f042 7280 	orr.w	r2, r2, #16777216	@ 0x1000000
20022f3c:	2000      	movs	r0, #0
20022f3e:	601a      	str	r2, [r3, #0]
20022f40:	4770      	bx	lr
20022f42:	f022 7280 	bic.w	r2, r2, #16777216	@ 0x1000000
20022f46:	e7f9      	b.n	20022f3c <HAL_FLASH_SET_DUAL_MODE+0xc>
20022f48:	2001      	movs	r0, #1
20022f4a:	4770      	bx	lr

20022f4c <HAL_MPI_EN_FIXLAT>:
20022f4c:	b150      	cbz	r0, 20022f64 <HAL_MPI_EN_FIXLAT+0x18>
20022f4e:	6803      	ldr	r3, [r0, #0]
20022f50:	689a      	ldr	r2, [r3, #8]
20022f52:	b121      	cbz	r1, 20022f5e <HAL_MPI_EN_FIXLAT+0x12>
20022f54:	f042 4200 	orr.w	r2, r2, #2147483648	@ 0x80000000
20022f58:	2000      	movs	r0, #0
20022f5a:	609a      	str	r2, [r3, #8]
20022f5c:	4770      	bx	lr
20022f5e:	f022 4200 	bic.w	r2, r2, #2147483648	@ 0x80000000
20022f62:	e7f9      	b.n	20022f58 <HAL_MPI_EN_FIXLAT+0xc>
20022f64:	2001      	movs	r0, #1
20022f66:	4770      	bx	lr

20022f68 <HAL_MPI_ENABLE_DQS>:
20022f68:	b150      	cbz	r0, 20022f80 <HAL_MPI_ENABLE_DQS+0x18>
20022f6a:	6803      	ldr	r3, [r0, #0]
20022f6c:	689a      	ldr	r2, [r3, #8]
20022f6e:	b121      	cbz	r1, 20022f7a <HAL_MPI_ENABLE_DQS+0x12>
20022f70:	f042 0208 	orr.w	r2, r2, #8
20022f74:	2000      	movs	r0, #0
20022f76:	609a      	str	r2, [r3, #8]
20022f78:	4770      	bx	lr
20022f7a:	f022 0208 	bic.w	r2, r2, #8
20022f7e:	e7f9      	b.n	20022f74 <HAL_MPI_ENABLE_DQS+0xc>
20022f80:	2001      	movs	r0, #1
20022f82:	4770      	bx	lr

20022f84 <HAL_MPI_SET_DQS_DELAY>:
20022f84:	b140      	cbz	r0, 20022f98 <HAL_MPI_SET_DQS_DELAY+0x14>
20022f86:	6802      	ldr	r2, [r0, #0]
20022f88:	2000      	movs	r0, #0
20022f8a:	6d93      	ldr	r3, [r2, #88]	@ 0x58
20022f8c:	f423 037f 	bic.w	r3, r3, #16711680	@ 0xff0000
20022f90:	ea43 4101 	orr.w	r1, r3, r1, lsl #16
20022f94:	6591      	str	r1, [r2, #88]	@ 0x58
20022f96:	4770      	bx	lr
20022f98:	2001      	movs	r0, #1
20022f9a:	4770      	bx	lr

20022f9c <HAL_MPI_SET_SCK>:
20022f9c:	b160      	cbz	r0, 20022fb8 <HAL_MPI_SET_SCK+0x1c>
20022f9e:	6800      	ldr	r0, [r0, #0]
20022fa0:	0652      	lsls	r2, r2, #25
20022fa2:	6d83      	ldr	r3, [r0, #88]	@ 0x58
20022fa4:	ea42 2101 	orr.w	r1, r2, r1, lsl #8
20022fa8:	f023 7300 	bic.w	r3, r3, #33554432	@ 0x2000000
20022fac:	f423 437f 	bic.w	r3, r3, #65280	@ 0xff00
20022fb0:	4319      	orrs	r1, r3
20022fb2:	6581      	str	r1, [r0, #88]	@ 0x58
20022fb4:	2000      	movs	r0, #0
20022fb6:	4770      	bx	lr
20022fb8:	2001      	movs	r0, #1
20022fba:	4770      	bx	lr

20022fbc <HAL_MPI_CFG_DTR>:
20022fbc:	b510      	push	{r4, lr}
20022fbe:	b1f0      	cbz	r0, 20022ffe <HAL_MPI_CFG_DTR+0x42>
20022fc0:	6804      	ldr	r4, [r0, #0]
20022fc2:	6da0      	ldr	r0, [r4, #88]	@ 0x58
20022fc4:	b1b1      	cbz	r1, 20022ff4 <HAL_MPI_CFG_DTR+0x38>
20022fc6:	2a02      	cmp	r2, #2
20022fc8:	bf84      	itt	hi
20022fca:	3a02      	subhi	r2, #2
20022fcc:	b2d2      	uxtbhi	r2, r2
20022fce:	0213      	lsls	r3, r2, #8
20022fd0:	f36f 000f 	bfc	r0, #0, #16
20022fd4:	f403 43fe 	and.w	r3, r3, #32512	@ 0x7f00
20022fd8:	4303      	orrs	r3, r0
20022fda:	0612      	lsls	r2, r2, #24
20022fdc:	bf54      	ite	pl
20022fde:	f043 6380 	orrpl.w	r3, r3, #67108864	@ 0x4000000
20022fe2:	f043 63a0 	orrmi.w	r3, r3, #83886080	@ 0x5000000
20022fe6:	f043 030a 	orr.w	r3, r3, #10
20022fea:	f023 7300 	bic.w	r3, r3, #33554432	@ 0x2000000
20022fee:	2000      	movs	r0, #0
20022ff0:	65a3      	str	r3, [r4, #88]	@ 0x58
20022ff2:	bd10      	pop	{r4, pc}
20022ff4:	4b03      	ldr	r3, [pc, #12]	@ (20023004 <HAL_MPI_CFG_DTR+0x48>)
20022ff6:	4003      	ands	r3, r0
20022ff8:	f043 7300 	orr.w	r3, r3, #33554432	@ 0x2000000
20022ffc:	e7f7      	b.n	20022fee <HAL_MPI_CFG_DTR+0x32>
20022ffe:	2001      	movs	r0, #1
20023000:	e7f7      	b.n	20022ff2 <HAL_MPI_CFG_DTR+0x36>
20023002:	bf00      	nop
20023004:	faff0000 	.word	0xfaff0000

20023008 <HAL_MPI_MODIFY_RCMD_DELAY>:
20023008:	b130      	cbz	r0, 20023018 <HAL_MPI_MODIFY_RCMD_DELAY+0x10>
2002300a:	6802      	ldr	r2, [r0, #0]
2002300c:	6c93      	ldr	r3, [r2, #72]	@ 0x48
2002300e:	f423 3378 	bic.w	r3, r3, #253952	@ 0x3e000
20023012:	ea43 3141 	orr.w	r1, r3, r1, lsl #13
20023016:	6491      	str	r1, [r2, #72]	@ 0x48
20023018:	4770      	bx	lr

2002301a <HAL_MPI_MODIFY_WCMD_DELAY>:
2002301a:	b130      	cbz	r0, 2002302a <HAL_MPI_MODIFY_WCMD_DELAY+0x10>
2002301c:	6802      	ldr	r2, [r0, #0]
2002301e:	6d13      	ldr	r3, [r2, #80]	@ 0x50
20023020:	f423 3378 	bic.w	r3, r3, #253952	@ 0x3e000
20023024:	ea43 3141 	orr.w	r1, r3, r1, lsl #13
20023028:	6511      	str	r1, [r2, #80]	@ 0x50
2002302a:	4770      	bx	lr

2002302c <HAL_FLASH_CONFIG_AHB_READ>:
2002302c:	b57f      	push	{r0, r1, r2, r3, r4, r5, r6, lr}
2002302e:	4605      	mov	r5, r0
20023030:	2800      	cmp	r0, #0
20023032:	d03d      	beq.n	200230b0 <HAL_FLASH_CONFIG_AHB_READ+0x84>
20023034:	68c4      	ldr	r4, [r0, #12]
20023036:	b301      	cbz	r1, 2002307a <HAL_FLASH_CONFIG_AHB_READ+0x4e>
20023038:	f894 306a 	ldrb.w	r3, [r4, #106]	@ 0x6a
2002303c:	2b00      	cmp	r3, #0
2002303e:	d037      	beq.n	200230b0 <HAL_FLASH_CONFIG_AHB_READ+0x84>
20023040:	f994 6072 	ldrsb.w	r6, [r4, #114]	@ 0x72
20023044:	f994 306e 	ldrsb.w	r3, [r4, #110]	@ 0x6e
20023048:	f994 106c 	ldrsb.w	r1, [r4, #108]	@ 0x6c
2002304c:	f994 206d 	ldrsb.w	r2, [r4, #109]	@ 0x6d
20023050:	9603      	str	r6, [sp, #12]
20023052:	f994 6071 	ldrsb.w	r6, [r4, #113]	@ 0x71
20023056:	9602      	str	r6, [sp, #8]
20023058:	f994 6070 	ldrsb.w	r6, [r4, #112]	@ 0x70
2002305c:	9601      	str	r6, [sp, #4]
2002305e:	f994 406f 	ldrsb.w	r4, [r4, #111]	@ 0x6f
20023062:	9400      	str	r4, [sp, #0]
20023064:	f7ff fd9e 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
20023068:	68eb      	ldr	r3, [r5, #12]
2002306a:	f893 106a 	ldrb.w	r1, [r3, #106]	@ 0x6a
2002306e:	4628      	mov	r0, r5
20023070:	f7ff fd8d 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
20023074:	2000      	movs	r0, #0
20023076:	b004      	add	sp, #16
20023078:	bd70      	pop	{r4, r5, r6, pc}
2002307a:	f894 3046 	ldrb.w	r3, [r4, #70]	@ 0x46
2002307e:	b1bb      	cbz	r3, 200230b0 <HAL_FLASH_CONFIG_AHB_READ+0x84>
20023080:	f994 604e 	ldrsb.w	r6, [r4, #78]	@ 0x4e
20023084:	f994 304a 	ldrsb.w	r3, [r4, #74]	@ 0x4a
20023088:	f994 1048 	ldrsb.w	r1, [r4, #72]	@ 0x48
2002308c:	f994 2049 	ldrsb.w	r2, [r4, #73]	@ 0x49
20023090:	9603      	str	r6, [sp, #12]
20023092:	f994 604d 	ldrsb.w	r6, [r4, #77]	@ 0x4d
20023096:	9602      	str	r6, [sp, #8]
20023098:	f994 604c 	ldrsb.w	r6, [r4, #76]	@ 0x4c
2002309c:	9601      	str	r6, [sp, #4]
2002309e:	f994 404b 	ldrsb.w	r4, [r4, #75]	@ 0x4b
200230a2:	9400      	str	r4, [sp, #0]
200230a4:	f7ff fd7e 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200230a8:	68eb      	ldr	r3, [r5, #12]
200230aa:	f893 1046 	ldrb.w	r1, [r3, #70]	@ 0x46
200230ae:	e7de      	b.n	2002306e <HAL_FLASH_CONFIG_AHB_READ+0x42>
200230b0:	2001      	movs	r0, #1
200230b2:	e7e0      	b.n	20023076 <HAL_FLASH_CONFIG_AHB_READ+0x4a>

200230b4 <HAL_FLASH_CONFIG_FULL_AHB_READ>:
200230b4:	b57f      	push	{r0, r1, r2, r3, r4, r5, r6, lr}
200230b6:	4605      	mov	r5, r0
200230b8:	2800      	cmp	r0, #0
200230ba:	d036      	beq.n	2002312a <HAL_FLASH_CONFIG_FULL_AHB_READ+0x76>
200230bc:	68c4      	ldr	r4, [r0, #12]
200230be:	b1e1      	cbz	r1, 200230fa <HAL_FLASH_CONFIG_FULL_AHB_READ+0x46>
200230c0:	f994 616e 	ldrsb.w	r6, [r4, #366]	@ 0x16e
200230c4:	f994 316a 	ldrsb.w	r3, [r4, #362]	@ 0x16a
200230c8:	f994 1168 	ldrsb.w	r1, [r4, #360]	@ 0x168
200230cc:	f994 2169 	ldrsb.w	r2, [r4, #361]	@ 0x169
200230d0:	9603      	str	r6, [sp, #12]
200230d2:	f994 616d 	ldrsb.w	r6, [r4, #365]	@ 0x16d
200230d6:	9602      	str	r6, [sp, #8]
200230d8:	f994 616c 	ldrsb.w	r6, [r4, #364]	@ 0x16c
200230dc:	9601      	str	r6, [sp, #4]
200230de:	f994 416b 	ldrsb.w	r4, [r4, #363]	@ 0x16b
200230e2:	9400      	str	r4, [sp, #0]
200230e4:	f7ff fd5e 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200230e8:	68eb      	ldr	r3, [r5, #12]
200230ea:	f893 1166 	ldrb.w	r1, [r3, #358]	@ 0x166
200230ee:	4628      	mov	r0, r5
200230f0:	f7ff fd4d 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
200230f4:	2000      	movs	r0, #0
200230f6:	b004      	add	sp, #16
200230f8:	bd70      	pop	{r4, r5, r6, pc}
200230fa:	f994 615c 	ldrsb.w	r6, [r4, #348]	@ 0x15c
200230fe:	f994 3158 	ldrsb.w	r3, [r4, #344]	@ 0x158
20023102:	f994 1156 	ldrsb.w	r1, [r4, #342]	@ 0x156
20023106:	f994 2157 	ldrsb.w	r2, [r4, #343]	@ 0x157
2002310a:	9603      	str	r6, [sp, #12]
2002310c:	f994 615b 	ldrsb.w	r6, [r4, #347]	@ 0x15b
20023110:	9602      	str	r6, [sp, #8]
20023112:	f994 615a 	ldrsb.w	r6, [r4, #346]	@ 0x15a
20023116:	9601      	str	r6, [sp, #4]
20023118:	f994 4159 	ldrsb.w	r4, [r4, #345]	@ 0x159
2002311c:	9400      	str	r4, [sp, #0]
2002311e:	f7ff fd41 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
20023122:	68eb      	ldr	r3, [r5, #12]
20023124:	f893 1154 	ldrb.w	r1, [r3, #340]	@ 0x154
20023128:	e7e1      	b.n	200230ee <HAL_FLASH_CONFIG_FULL_AHB_READ+0x3a>
2002312a:	2001      	movs	r0, #1
2002312c:	e7e3      	b.n	200230f6 <HAL_FLASH_CONFIG_FULL_AHB_READ+0x42>

2002312e <HAL_FLASH_PRE_CMD>:
2002312e:	b530      	push	{r4, r5, lr}
20023130:	68c4      	ldr	r4, [r0, #12]
20023132:	b087      	sub	sp, #28
20023134:	b304      	cbz	r4, 20023178 <HAL_FLASH_PRE_CMD+0x4a>
20023136:	2938      	cmp	r1, #56	@ 0x38
20023138:	d81e      	bhi.n	20023178 <HAL_FLASH_PRE_CMD+0x4a>
2002313a:	eb01 01c1 	add.w	r1, r1, r1, lsl #3
2002313e:	440c      	add	r4, r1
20023140:	7c23      	ldrb	r3, [r4, #16]
20023142:	b1cb      	cbz	r3, 20023178 <HAL_FLASH_PRE_CMD+0x4a>
20023144:	f994 5018 	ldrsb.w	r5, [r4, #24]
20023148:	f994 3013 	ldrsb.w	r3, [r4, #19]
2002314c:	f994 2012 	ldrsb.w	r2, [r4, #18]
20023150:	f994 1011 	ldrsb.w	r1, [r4, #17]
20023154:	9504      	str	r5, [sp, #16]
20023156:	f994 5017 	ldrsb.w	r5, [r4, #23]
2002315a:	9503      	str	r5, [sp, #12]
2002315c:	f994 5016 	ldrsb.w	r5, [r4, #22]
20023160:	9502      	str	r5, [sp, #8]
20023162:	f994 5015 	ldrsb.w	r5, [r4, #21]
20023166:	9501      	str	r5, [sp, #4]
20023168:	f994 4014 	ldrsb.w	r4, [r4, #20]
2002316c:	9400      	str	r4, [sp, #0]
2002316e:	f7ff fdd0 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
20023172:	2000      	movs	r0, #0
20023174:	b007      	add	sp, #28
20023176:	bd30      	pop	{r4, r5, pc}
20023178:	2001      	movs	r0, #1
2002317a:	e7fb      	b.n	20023174 <HAL_FLASH_PRE_CMD+0x46>

2002317c <HAL_FLASH_ISSUE_CMD>:
2002317c:	b5f0      	push	{r4, r5, r6, r7, lr}
2002317e:	68c4      	ldr	r4, [r0, #12]
20023180:	4606      	mov	r6, r0
20023182:	4617      	mov	r7, r2
20023184:	b087      	sub	sp, #28
20023186:	b354      	cbz	r4, 200231de <HAL_FLASH_ISSUE_CMD+0x62>
20023188:	2938      	cmp	r1, #56	@ 0x38
2002318a:	d828      	bhi.n	200231de <HAL_FLASH_ISSUE_CMD+0x62>
2002318c:	eb01 05c1 	add.w	r5, r1, r1, lsl #3
20023190:	442c      	add	r4, r5
20023192:	7c23      	ldrb	r3, [r4, #16]
20023194:	b31b      	cbz	r3, 200231de <HAL_FLASH_ISSUE_CMD+0x62>
20023196:	f994 c018 	ldrsb.w	ip, [r4, #24]
2002319a:	f994 3013 	ldrsb.w	r3, [r4, #19]
2002319e:	f994 2012 	ldrsb.w	r2, [r4, #18]
200231a2:	f994 1011 	ldrsb.w	r1, [r4, #17]
200231a6:	f8cd c010 	str.w	ip, [sp, #16]
200231aa:	f994 c017 	ldrsb.w	ip, [r4, #23]
200231ae:	f8cd c00c 	str.w	ip, [sp, #12]
200231b2:	f994 c016 	ldrsb.w	ip, [r4, #22]
200231b6:	f8cd c008 	str.w	ip, [sp, #8]
200231ba:	f994 c015 	ldrsb.w	ip, [r4, #21]
200231be:	f8cd c004 	str.w	ip, [sp, #4]
200231c2:	f994 4014 	ldrsb.w	r4, [r4, #20]
200231c6:	9400      	str	r4, [sp, #0]
200231c8:	f7ff fda3 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
200231cc:	68f3      	ldr	r3, [r6, #12]
200231ce:	463a      	mov	r2, r7
200231d0:	442b      	add	r3, r5
200231d2:	4630      	mov	r0, r6
200231d4:	7c19      	ldrb	r1, [r3, #16]
200231d6:	f7ff fd57 	bl	20022c88 <HAL_FLASH_SET_CMD>
200231da:	b007      	add	sp, #28
200231dc:	bdf0      	pop	{r4, r5, r6, r7, pc}
200231de:	2001      	movs	r0, #1
200231e0:	e7fb      	b.n	200231da <HAL_FLASH_ISSUE_CMD+0x5e>

200231e2 <HAL_FLASH_ISSUE_CMD_SEQ>:
200231e2:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
200231e6:	4690      	mov	r8, r2
200231e8:	68c2      	ldr	r2, [r0, #12]
200231ea:	4604      	mov	r4, r0
200231ec:	b086      	sub	sp, #24
200231ee:	2a00      	cmp	r2, #0
200231f0:	d072      	beq.n	200232d8 <HAL_FLASH_ISSUE_CMD_SEQ+0xf6>
200231f2:	2938      	cmp	r1, #56	@ 0x38
200231f4:	d870      	bhi.n	200232d8 <HAL_FLASH_ISSUE_CMD_SEQ+0xf6>
200231f6:	eb01 07c1 	add.w	r7, r1, r1, lsl #3
200231fa:	19d6      	adds	r6, r2, r7
200231fc:	7c31      	ldrb	r1, [r6, #16]
200231fe:	2900      	cmp	r1, #0
20023200:	d06a      	beq.n	200232d8 <HAL_FLASH_ISSUE_CMD_SEQ+0xf6>
20023202:	2b38      	cmp	r3, #56	@ 0x38
20023204:	d868      	bhi.n	200232d8 <HAL_FLASH_ISSUE_CMD_SEQ+0xf6>
20023206:	eb03 05c3 	add.w	r5, r3, r3, lsl #3
2002320a:	442a      	add	r2, r5
2002320c:	7c13      	ldrb	r3, [r2, #16]
2002320e:	2b00      	cmp	r3, #0
20023210:	d062      	beq.n	200232d8 <HAL_FLASH_ISSUE_CMD_SEQ+0xf6>
20023212:	f996 c018 	ldrsb.w	ip, [r6, #24]
20023216:	f996 3013 	ldrsb.w	r3, [r6, #19]
2002321a:	f996 2012 	ldrsb.w	r2, [r6, #18]
2002321e:	f996 1011 	ldrsb.w	r1, [r6, #17]
20023222:	f8cd c010 	str.w	ip, [sp, #16]
20023226:	f996 c017 	ldrsb.w	ip, [r6, #23]
2002322a:	f8cd c00c 	str.w	ip, [sp, #12]
2002322e:	f996 c016 	ldrsb.w	ip, [r6, #22]
20023232:	f8cd c008 	str.w	ip, [sp, #8]
20023236:	f996 c015 	ldrsb.w	ip, [r6, #21]
2002323a:	f8cd c004 	str.w	ip, [sp, #4]
2002323e:	f996 6014 	ldrsb.w	r6, [r6, #20]
20023242:	9600      	str	r6, [sp, #0]
20023244:	f7ff fd65 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
20023248:	68e0      	ldr	r0, [r4, #12]
2002324a:	4428      	add	r0, r5
2002324c:	f990 6018 	ldrsb.w	r6, [r0, #24]
20023250:	f990 3013 	ldrsb.w	r3, [r0, #19]
20023254:	f990 2012 	ldrsb.w	r2, [r0, #18]
20023258:	f990 1011 	ldrsb.w	r1, [r0, #17]
2002325c:	9604      	str	r6, [sp, #16]
2002325e:	f990 6017 	ldrsb.w	r6, [r0, #23]
20023262:	9603      	str	r6, [sp, #12]
20023264:	f990 6016 	ldrsb.w	r6, [r0, #22]
20023268:	9602      	str	r6, [sp, #8]
2002326a:	f990 6015 	ldrsb.w	r6, [r0, #21]
2002326e:	9601      	str	r6, [sp, #4]
20023270:	f990 0014 	ldrsb.w	r0, [r0, #20]
20023274:	9000      	str	r0, [sp, #0]
20023276:	4620      	mov	r0, r4
20023278:	f7ff fd6c 	bl	20022d54 <HAL_FLASH_MANUAL_CMD2>
2002327c:	2200      	movs	r2, #0
2002327e:	6823      	ldr	r3, [r4, #0]
20023280:	2101      	movs	r1, #1
20023282:	67da      	str	r2, [r3, #124]	@ 0x7c
20023284:	68e3      	ldr	r3, [r4, #12]
20023286:	6822      	ldr	r2, [r4, #0]
20023288:	442b      	add	r3, r5
2002328a:	7c1b      	ldrb	r3, [r3, #16]
2002328c:	4620      	mov	r0, r4
2002328e:	62d3      	str	r3, [r2, #44]	@ 0x2c
20023290:	6823      	ldr	r3, [r4, #0]
20023292:	9a0c      	ldr	r2, [sp, #48]	@ 0x30
20023294:	f8c3 2080 	str.w	r2, [r3, #128]	@ 0x80
20023298:	f7ff fe01 	bl	20022e9e <HAL_FLASH_ENABLE_CMD2>
2002329c:	4620      	mov	r0, r4
2002329e:	f7ff fe0c 	bl	20022eba <HAL_FLASH_STAUS_MATCH_CMD2>
200232a2:	6823      	ldr	r3, [r4, #0]
200232a4:	f8c3 801c 	str.w	r8, [r3, #28]
200232a8:	68e3      	ldr	r3, [r4, #12]
200232aa:	6822      	ldr	r2, [r4, #0]
200232ac:	443b      	add	r3, r7
200232ae:	7c1b      	ldrb	r3, [r3, #16]
200232b0:	6193      	str	r3, [r2, #24]
200232b2:	4620      	mov	r0, r4
200232b4:	f7ff fd0a 	bl	20022ccc <HAL_FLASH_STATUS_MATCH>
200232b8:	2800      	cmp	r0, #0
200232ba:	d0fa      	beq.n	200232b2 <HAL_FLASH_ISSUE_CMD_SEQ+0xd0>
200232bc:	2109      	movs	r1, #9
200232be:	4620      	mov	r0, r4
200232c0:	f7ff fcfe 	bl	20022cc0 <HAL_FLASH_CLR_STATUS>
200232c4:	2100      	movs	r1, #0
200232c6:	f7ff fdea 	bl	20022e9e <HAL_FLASH_ENABLE_CMD2>
200232ca:	4620      	mov	r0, r4
200232cc:	f7ff fdf5 	bl	20022eba <HAL_FLASH_STAUS_MATCH_CMD2>
200232d0:	4608      	mov	r0, r1
200232d2:	b006      	add	sp, #24
200232d4:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
200232d8:	2001      	movs	r0, #1
200232da:	e7fa      	b.n	200232d2 <HAL_FLASH_ISSUE_CMD_SEQ+0xf0>

200232dc <nor_qspi_switch>:
200232dc:	b570      	push	{r4, r5, r6, lr}
200232de:	4604      	mov	r4, r0
200232e0:	b3e0      	cbz	r0, 2002335c <nor_qspi_switch+0x80>
200232e2:	68c3      	ldr	r3, [r0, #12]
200232e4:	b3d3      	cbz	r3, 2002335c <nor_qspi_switch+0x80>
200232e6:	b3c9      	cbz	r1, 2002335c <nor_qspi_switch+0x80>
200232e8:	f893 5193 	ldrb.w	r5, [r3, #403]	@ 0x193
200232ec:	2101      	movs	r1, #1
200232ee:	b3b5      	cbz	r5, 2002335e <nor_qspi_switch+0x82>
200232f0:	f7ff fca5 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200232f4:	2200      	movs	r2, #0
200232f6:	2114      	movs	r1, #20
200232f8:	4620      	mov	r0, r4
200232fa:	f7ff ff3f 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200232fe:	4620      	mov	r0, r4
20023300:	f7ff fcf3 	bl	20022cea <HAL_FLASH_READ32>
20023304:	f010 0501 	ands.w	r5, r0, #1
20023308:	d000      	beq.n	2002330c <nor_qspi_switch+0x30>
2002330a:	e7fe      	b.n	2002330a <nor_qspi_switch+0x2e>
2002330c:	462a      	mov	r2, r5
2002330e:	2115      	movs	r1, #21
20023310:	4620      	mov	r0, r4
20023312:	f7ff ff33 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023316:	4606      	mov	r6, r0
20023318:	b120      	cbz	r0, 20023324 <nor_qspi_switch+0x48>
2002331a:	462a      	mov	r2, r5
2002331c:	4629      	mov	r1, r5
2002331e:	4620      	mov	r0, r4
20023320:	f7ff ff2c 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023324:	2102      	movs	r1, #2
20023326:	4620      	mov	r0, r4
20023328:	f7ff fc82 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
2002332c:	2101      	movs	r1, #1
2002332e:	4620      	mov	r0, r4
20023330:	f7ff fc85 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023334:	2200      	movs	r2, #0
20023336:	212b      	movs	r1, #43	@ 0x2b
20023338:	4620      	mov	r0, r4
2002333a:	f7ff ff1f 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002333e:	b16e      	cbz	r6, 2002335c <nor_qspi_switch+0x80>
20023340:	2101      	movs	r1, #1
20023342:	4620      	mov	r0, r4
20023344:	f7ff fc7b 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023348:	2200      	movs	r2, #0
2002334a:	2102      	movs	r1, #2
2002334c:	4620      	mov	r0, r4
2002334e:	f7ff ff15 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023352:	4620      	mov	r0, r4
20023354:	f7ff fcc0 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
20023358:	2800      	cmp	r0, #0
2002335a:	d0f5      	beq.n	20023348 <nor_qspi_switch+0x6c>
2002335c:	bd70      	pop	{r4, r5, r6, pc}
2002335e:	f7ff fc6e 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023362:	462a      	mov	r2, r5
20023364:	2102      	movs	r1, #2
20023366:	4620      	mov	r0, r4
20023368:	f7ff ff08 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002336c:	4620      	mov	r0, r4
2002336e:	f7ff fcbc 	bl	20022cea <HAL_FLASH_READ32>
20023372:	462a      	mov	r2, r5
20023374:	2114      	movs	r1, #20
20023376:	4620      	mov	r0, r4
20023378:	f7ff ff00 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002337c:	b910      	cbnz	r0, 20023384 <nor_qspi_switch+0xa8>
2002337e:	4620      	mov	r0, r4
20023380:	f7ff fcb3 	bl	20022cea <HAL_FLASH_READ32>
20023384:	68e3      	ldr	r3, [r4, #12]
20023386:	7a1b      	ldrb	r3, [r3, #8]
20023388:	b3ab      	cbz	r3, 200233f6 <nor_qspi_switch+0x11a>
2002338a:	2101      	movs	r1, #1
2002338c:	f003 050f 	and.w	r5, r3, #15
20023390:	091b      	lsrs	r3, r3, #4
20023392:	fa01 f303 	lsl.w	r3, r1, r3
20023396:	b2db      	uxtb	r3, r3
20023398:	b10d      	cbz	r5, 2002339e <nor_qspi_switch+0xc2>
2002339a:	461d      	mov	r5, r3
2002339c:	2300      	movs	r3, #0
2002339e:	2200      	movs	r2, #0
200233a0:	2115      	movs	r1, #21
200233a2:	4620      	mov	r0, r4
200233a4:	ea43 2505 	orr.w	r5, r3, r5, lsl #8
200233a8:	f7ff fee8 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200233ac:	4606      	mov	r6, r0
200233ae:	b120      	cbz	r0, 200233ba <nor_qspi_switch+0xde>
200233b0:	2200      	movs	r2, #0
200233b2:	4620      	mov	r0, r4
200233b4:	4611      	mov	r1, r2
200233b6:	f7ff fee1 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200233ba:	4629      	mov	r1, r5
200233bc:	4620      	mov	r0, r4
200233be:	f7ff fc37 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200233c2:	2102      	movs	r1, #2
200233c4:	4620      	mov	r0, r4
200233c6:	f7ff fc3a 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200233ca:	2200      	movs	r2, #0
200233cc:	2103      	movs	r1, #3
200233ce:	4620      	mov	r0, r4
200233d0:	f7ff fed4 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200233d4:	2e00      	cmp	r6, #0
200233d6:	d0c1      	beq.n	2002335c <nor_qspi_switch+0x80>
200233d8:	2101      	movs	r1, #1
200233da:	4620      	mov	r0, r4
200233dc:	f7ff fc2f 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200233e0:	2200      	movs	r2, #0
200233e2:	2102      	movs	r1, #2
200233e4:	4620      	mov	r0, r4
200233e6:	f7ff fec9 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200233ea:	4620      	mov	r0, r4
200233ec:	f7ff fc74 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
200233f0:	2800      	cmp	r0, #0
200233f2:	d0f5      	beq.n	200233e0 <nor_qspi_switch+0x104>
200233f4:	e7b2      	b.n	2002335c <nor_qspi_switch+0x80>
200233f6:	2502      	movs	r5, #2
200233f8:	e7d1      	b.n	2002339e <nor_qspi_switch+0xc2>

200233fa <HAL_FLASH_SET_QUAL_SPI>:
200233fa:	b538      	push	{r3, r4, r5, lr}
200233fc:	4604      	mov	r4, r0
200233fe:	460d      	mov	r5, r1
20023400:	f7ff ff6c 	bl	200232dc <nor_qspi_switch>
20023404:	4629      	mov	r1, r5
20023406:	4620      	mov	r0, r4
20023408:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
2002340c:	f7ff be0e 	b.w	2002302c <HAL_FLASH_CONFIG_AHB_READ>

20023410 <HAL_FLASH_FADDR_SET_QSPI>:
20023410:	b538      	push	{r3, r4, r5, lr}
20023412:	4604      	mov	r4, r0
20023414:	460d      	mov	r5, r1
20023416:	f7ff ff61 	bl	200232dc <nor_qspi_switch>
2002341a:	4629      	mov	r1, r5
2002341c:	4620      	mov	r0, r4
2002341e:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
20023422:	f7ff be47 	b.w	200230b4 <HAL_FLASH_CONFIG_FULL_AHB_READ>

20023426 <HAL_FLASH_GET_NOR_ID>:
20023426:	b510      	push	{r4, lr}
20023428:	4604      	mov	r4, r0
2002342a:	b140      	cbz	r0, 2002343e <HAL_FLASH_GET_NOR_ID+0x18>
2002342c:	6802      	ldr	r2, [r0, #0]
2002342e:	6a93      	ldr	r3, [r2, #40]	@ 0x28
20023430:	f36f 0315 	bfc	r3, #0, #22
20023434:	f443 2380 	orr.w	r3, r3, #262144	@ 0x40000
20023438:	f043 0301 	orr.w	r3, r3, #1
2002343c:	6293      	str	r3, [r2, #40]	@ 0x28
2002343e:	2103      	movs	r1, #3
20023440:	4620      	mov	r0, r4
20023442:	f7ff fbfc 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023446:	2200      	movs	r2, #0
20023448:	219f      	movs	r1, #159	@ 0x9f
2002344a:	4620      	mov	r0, r4
2002344c:	f7ff fc1c 	bl	20022c88 <HAL_FLASH_SET_CMD>
20023450:	4620      	mov	r0, r4
20023452:	f7ff fc4a 	bl	20022cea <HAL_FLASH_READ32>
20023456:	f020 407f 	bic.w	r0, r0, #4278190080	@ 0xff000000
2002345a:	bd10      	pop	{r4, pc}

2002345c <HAL_FLASH_CLR_PROTECT>:
2002345c:	b570      	push	{r4, r5, r6, lr}
2002345e:	4604      	mov	r4, r0
20023460:	2800      	cmp	r0, #0
20023462:	d03e      	beq.n	200234e2 <HAL_FLASH_CLR_PROTECT+0x86>
20023464:	68c3      	ldr	r3, [r0, #12]
20023466:	2101      	movs	r1, #1
20023468:	f893 5193 	ldrb.w	r5, [r3, #403]	@ 0x193
2002346c:	2d00      	cmp	r5, #0
2002346e:	d03b      	beq.n	200234e8 <HAL_FLASH_CLR_PROTECT+0x8c>
20023470:	f7ff fbe5 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023474:	2200      	movs	r2, #0
20023476:	2102      	movs	r1, #2
20023478:	4620      	mov	r0, r4
2002347a:	f7ff fe7f 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002347e:	bb88      	cbnz	r0, 200234e4 <HAL_FLASH_CLR_PROTECT+0x88>
20023480:	4620      	mov	r0, r4
20023482:	f7ff fc32 	bl	20022cea <HAL_FLASH_READ32>
20023486:	b2c0      	uxtb	r0, r0
20023488:	68e3      	ldr	r3, [r4, #12]
2002348a:	79dd      	ldrb	r5, [r3, #7]
2002348c:	b10d      	cbz	r5, 20023492 <HAL_FLASH_CLR_PROTECT+0x36>
2002348e:	ea20 0505 	bic.w	r5, r0, r5
20023492:	2200      	movs	r2, #0
20023494:	2115      	movs	r1, #21
20023496:	4620      	mov	r0, r4
20023498:	f7ff fe70 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002349c:	4606      	mov	r6, r0
2002349e:	b120      	cbz	r0, 200234aa <HAL_FLASH_CLR_PROTECT+0x4e>
200234a0:	2200      	movs	r2, #0
200234a2:	4620      	mov	r0, r4
200234a4:	4611      	mov	r1, r2
200234a6:	f7ff fe69 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200234aa:	4629      	mov	r1, r5
200234ac:	4620      	mov	r0, r4
200234ae:	f7ff fbbf 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200234b2:	2101      	movs	r1, #1
200234b4:	4620      	mov	r0, r4
200234b6:	f7ff fbc2 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200234ba:	2200      	movs	r2, #0
200234bc:	2103      	movs	r1, #3
200234be:	4620      	mov	r0, r4
200234c0:	f7ff fe5c 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200234c4:	b16e      	cbz	r6, 200234e2 <HAL_FLASH_CLR_PROTECT+0x86>
200234c6:	2101      	movs	r1, #1
200234c8:	4620      	mov	r0, r4
200234ca:	f7ff fbb8 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200234ce:	2200      	movs	r2, #0
200234d0:	2102      	movs	r1, #2
200234d2:	4620      	mov	r0, r4
200234d4:	f7ff fe52 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200234d8:	4620      	mov	r0, r4
200234da:	f7ff fbfd 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
200234de:	2800      	cmp	r0, #0
200234e0:	d0f5      	beq.n	200234ce <HAL_FLASH_CLR_PROTECT+0x72>
200234e2:	bd70      	pop	{r4, r5, r6, pc}
200234e4:	2000      	movs	r0, #0
200234e6:	e7cf      	b.n	20023488 <HAL_FLASH_CLR_PROTECT+0x2c>
200234e8:	f7ff fba9 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200234ec:	462a      	mov	r2, r5
200234ee:	2102      	movs	r1, #2
200234f0:	4620      	mov	r0, r4
200234f2:	f7ff fe43 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200234f6:	2800      	cmp	r0, #0
200234f8:	d13e      	bne.n	20023578 <HAL_FLASH_CLR_PROTECT+0x11c>
200234fa:	4620      	mov	r0, r4
200234fc:	f7ff fbf5 	bl	20022cea <HAL_FLASH_READ32>
20023500:	b2c6      	uxtb	r6, r0
20023502:	2200      	movs	r2, #0
20023504:	2114      	movs	r1, #20
20023506:	4620      	mov	r0, r4
20023508:	f7ff fe38 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002350c:	b918      	cbnz	r0, 20023516 <HAL_FLASH_CLR_PROTECT+0xba>
2002350e:	4620      	mov	r0, r4
20023510:	f7ff fbeb 	bl	20022cea <HAL_FLASH_READ32>
20023514:	b2c5      	uxtb	r5, r0
20023516:	68e3      	ldr	r3, [r4, #12]
20023518:	79d9      	ldrb	r1, [r3, #7]
2002351a:	b109      	cbz	r1, 20023520 <HAL_FLASH_CLR_PROTECT+0xc4>
2002351c:	ea26 0101 	bic.w	r1, r6, r1
20023520:	2200      	movs	r2, #0
20023522:	4620      	mov	r0, r4
20023524:	ea41 2505 	orr.w	r5, r1, r5, lsl #8
20023528:	2115      	movs	r1, #21
2002352a:	f7ff fe27 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002352e:	4606      	mov	r6, r0
20023530:	b120      	cbz	r0, 2002353c <HAL_FLASH_CLR_PROTECT+0xe0>
20023532:	2200      	movs	r2, #0
20023534:	4620      	mov	r0, r4
20023536:	4611      	mov	r1, r2
20023538:	f7ff fe20 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002353c:	4629      	mov	r1, r5
2002353e:	4620      	mov	r0, r4
20023540:	f7ff fb76 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
20023544:	2102      	movs	r1, #2
20023546:	4620      	mov	r0, r4
20023548:	f7ff fb79 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
2002354c:	2200      	movs	r2, #0
2002354e:	2103      	movs	r1, #3
20023550:	4620      	mov	r0, r4
20023552:	f7ff fe13 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023556:	2e00      	cmp	r6, #0
20023558:	d0c3      	beq.n	200234e2 <HAL_FLASH_CLR_PROTECT+0x86>
2002355a:	2101      	movs	r1, #1
2002355c:	4620      	mov	r0, r4
2002355e:	f7ff fb6e 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023562:	2200      	movs	r2, #0
20023564:	2102      	movs	r1, #2
20023566:	4620      	mov	r0, r4
20023568:	f7ff fe08 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002356c:	4620      	mov	r0, r4
2002356e:	f7ff fbb3 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
20023572:	2800      	cmp	r0, #0
20023574:	d0f5      	beq.n	20023562 <HAL_FLASH_CLR_PROTECT+0x106>
20023576:	e7b4      	b.n	200234e2 <HAL_FLASH_CLR_PROTECT+0x86>
20023578:	462e      	mov	r6, r5
2002357a:	e7c2      	b.n	20023502 <HAL_FLASH_CLR_PROTECT+0xa6>

2002357c <HAL_QSPI_SET_CLK_INV>:
2002357c:	b160      	cbz	r0, 20023598 <HAL_QSPI_SET_CLK_INV+0x1c>
2002357e:	6800      	ldr	r0, [r0, #0]
20023580:	b150      	cbz	r0, 20023598 <HAL_QSPI_SET_CLK_INV+0x1c>
20023582:	6d83      	ldr	r3, [r0, #88]	@ 0x58
20023584:	0609      	lsls	r1, r1, #24
20023586:	f023 7380 	bic.w	r3, r3, #16777216	@ 0x1000000
2002358a:	f001 7180 	and.w	r1, r1, #16777216	@ 0x1000000
2002358e:	f023 03ff 	bic.w	r3, r3, #255	@ 0xff
20023592:	4311      	orrs	r1, r2
20023594:	4319      	orrs	r1, r3
20023596:	6581      	str	r1, [r0, #88]	@ 0x58
20023598:	4770      	bx	lr

2002359a <HAL_FLASH_RELEASE_DPD>:
2002359a:	b538      	push	{r3, r4, r5, lr}
2002359c:	4604      	mov	r4, r0
2002359e:	b1d0      	cbz	r0, 200235d6 <HAL_FLASH_RELEASE_DPD+0x3c>
200235a0:	6803      	ldr	r3, [r0, #0]
200235a2:	21ab      	movs	r1, #171	@ 0xab
200235a4:	681d      	ldr	r5, [r3, #0]
200235a6:	f015 0501 	ands.w	r5, r5, #1
200235aa:	bf02      	ittt	eq
200235ac:	681a      	ldreq	r2, [r3, #0]
200235ae:	f042 0201 	orreq.w	r2, r2, #1
200235b2:	601a      	streq	r2, [r3, #0]
200235b4:	6802      	ldr	r2, [r0, #0]
200235b6:	6a93      	ldr	r3, [r2, #40]	@ 0x28
200235b8:	f36f 0315 	bfc	r3, #0, #22
200235bc:	f043 0301 	orr.w	r3, r3, #1
200235c0:	6293      	str	r3, [r2, #40]	@ 0x28
200235c2:	2200      	movs	r2, #0
200235c4:	f7ff fb60 	bl	20022c88 <HAL_FLASH_SET_CMD>
200235c8:	b925      	cbnz	r5, 200235d4 <HAL_FLASH_RELEASE_DPD+0x3a>
200235ca:	6822      	ldr	r2, [r4, #0]
200235cc:	6813      	ldr	r3, [r2, #0]
200235ce:	f023 0301 	bic.w	r3, r3, #1
200235d2:	6013      	str	r3, [r2, #0]
200235d4:	bd38      	pop	{r3, r4, r5, pc}
200235d6:	2001      	movs	r0, #1
200235d8:	e7fc      	b.n	200235d4 <HAL_FLASH_RELEASE_DPD+0x3a>

200235da <flash_handle_valid>:
200235da:	b118      	cbz	r0, 200235e4 <flash_handle_valid+0xa>
200235dc:	68c0      	ldr	r0, [r0, #12]
200235de:	3800      	subs	r0, #0
200235e0:	bf18      	it	ne
200235e2:	2001      	movne	r0, #1
200235e4:	4770      	bx	lr

200235e6 <HAL_GET_FLASH_MID>:
200235e6:	2000      	movs	r0, #0
200235e8:	4770      	bx	lr

200235ea <HAL_FLASH_DMA_START>:
200235ea:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
200235ee:	4688      	mov	r8, r1
200235f0:	4699      	mov	r9, r3
200235f2:	4604      	mov	r4, r0
200235f4:	2800      	cmp	r0, #0
200235f6:	d045      	beq.n	20023684 <HAL_FLASH_DMA_START+0x9a>
200235f8:	6883      	ldr	r3, [r0, #8]
200235fa:	2b00      	cmp	r3, #0
200235fc:	d042      	beq.n	20023684 <HAL_FLASH_DMA_START+0x9a>
200235fe:	f1b9 0f00 	cmp.w	r9, #0
20023602:	d03f      	beq.n	20023684 <HAL_FLASH_DMA_START+0x9a>
20023604:	6801      	ldr	r1, [r0, #0]
20023606:	680f      	ldr	r7, [r1, #0]
20023608:	b332      	cbz	r2, 20023658 <HAL_FLASH_DMA_START+0x6e>
2002360a:	2210      	movs	r2, #16
2002360c:	609a      	str	r2, [r3, #8]
2002360e:	2300      	movs	r3, #0
20023610:	6882      	ldr	r2, [r0, #8]
20023612:	464e      	mov	r6, r9
20023614:	6153      	str	r3, [r2, #20]
20023616:	6882      	ldr	r2, [r0, #8]
20023618:	6193      	str	r3, [r2, #24]
2002361a:	6882      	ldr	r2, [r0, #8]
2002361c:	60d3      	str	r3, [r2, #12]
2002361e:	2280      	movs	r2, #128	@ 0x80
20023620:	6883      	ldr	r3, [r0, #8]
20023622:	611a      	str	r2, [r3, #16]
20023624:	6805      	ldr	r5, [r0, #0]
20023626:	3504      	adds	r5, #4
20023628:	68a0      	ldr	r0, [r4, #8]
2002362a:	f7fe ffa3 	bl	20022574 <HAL_DMA_DeInit>
2002362e:	bb50      	cbnz	r0, 20023686 <HAL_FLASH_DMA_START+0x9c>
20023630:	68a0      	ldr	r0, [r4, #8]
20023632:	f7fe ff3b 	bl	200224ac <HAL_DMA_Init>
20023636:	bb30      	cbnz	r0, 20023686 <HAL_FLASH_DMA_START+0x9c>
20023638:	6823      	ldr	r3, [r4, #0]
2002363a:	f047 0720 	orr.w	r7, r7, #32
2002363e:	601f      	str	r7, [r3, #0]
20023640:	6822      	ldr	r2, [r4, #0]
20023642:	f109 33ff 	add.w	r3, r9, #4294967295
20023646:	6253      	str	r3, [r2, #36]	@ 0x24
20023648:	4641      	mov	r1, r8
2002364a:	4633      	mov	r3, r6
2002364c:	462a      	mov	r2, r5
2002364e:	68a0      	ldr	r0, [r4, #8]
20023650:	e8bd 47f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
20023654:	f7ff b8ec 	b.w	20022830 <HAL_DMA_Start>
20023658:	f44f 7100 	mov.w	r1, #512	@ 0x200
2002365c:	609a      	str	r2, [r3, #8]
2002365e:	6883      	ldr	r3, [r0, #8]
20023660:	f109 0603 	add.w	r6, r9, #3
20023664:	6159      	str	r1, [r3, #20]
20023666:	f44f 6100 	mov.w	r1, #2048	@ 0x800
2002366a:	6883      	ldr	r3, [r0, #8]
2002366c:	4645      	mov	r5, r8
2002366e:	6199      	str	r1, [r3, #24]
20023670:	6883      	ldr	r3, [r0, #8]
20023672:	08b6      	lsrs	r6, r6, #2
20023674:	60da      	str	r2, [r3, #12]
20023676:	2280      	movs	r2, #128	@ 0x80
20023678:	6883      	ldr	r3, [r0, #8]
2002367a:	611a      	str	r2, [r3, #16]
2002367c:	6803      	ldr	r3, [r0, #0]
2002367e:	f103 0804 	add.w	r8, r3, #4
20023682:	e7d1      	b.n	20023628 <HAL_FLASH_DMA_START+0x3e>
20023684:	2001      	movs	r0, #1
20023686:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}

2002368a <HAL_FLASH_DMA_WAIT_DONE>:
2002368a:	b510      	push	{r4, lr}
2002368c:	460a      	mov	r2, r1
2002368e:	4604      	mov	r4, r0
20023690:	b170      	cbz	r0, 200236b0 <HAL_FLASH_DMA_WAIT_DONE+0x26>
20023692:	6880      	ldr	r0, [r0, #8]
20023694:	b160      	cbz	r0, 200236b0 <HAL_FLASH_DMA_WAIT_DONE+0x26>
20023696:	6ae1      	ldr	r1, [r4, #44]	@ 0x2c
20023698:	b111      	cbz	r1, 200236a0 <HAL_FLASH_DMA_WAIT_DONE+0x16>
2002369a:	f04f 32ff 	mov.w	r2, #4294967295
2002369e:	2100      	movs	r1, #0
200236a0:	f7fe ffc8 	bl	20022634 <HAL_DMA_PollForTransfer>
200236a4:	6822      	ldr	r2, [r4, #0]
200236a6:	6813      	ldr	r3, [r2, #0]
200236a8:	f023 0320 	bic.w	r3, r3, #32
200236ac:	6013      	str	r3, [r2, #0]
200236ae:	bd10      	pop	{r4, pc}
200236b0:	2001      	movs	r0, #1
200236b2:	e7fc      	b.n	200236ae <HAL_FLASH_DMA_WAIT_DONE+0x24>

200236b4 <HAL_FLASH_ALIAS_CFG>:
200236b4:	b538      	push	{r3, r4, r5, lr}
200236b6:	461d      	mov	r5, r3
200236b8:	4604      	mov	r4, r0
200236ba:	b158      	cbz	r0, 200236d4 <HAL_FLASH_ALIAS_CFG+0x20>
200236bc:	6903      	ldr	r3, [r0, #16]
200236be:	428b      	cmp	r3, r1
200236c0:	bf98      	it	ls
200236c2:	1ac9      	subls	r1, r1, r3
200236c4:	f7ff fb68 	bl	20022d98 <HAL_FLASH_SET_ALIAS_RANGE>
200236c8:	4629      	mov	r1, r5
200236ca:	4620      	mov	r0, r4
200236cc:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
200236d0:	f7ff bb74 	b.w	20022dbc <HAL_FLASH_SET_ALIAS_OFFSET>
200236d4:	bd38      	pop	{r3, r4, r5, pc}

200236d6 <HAL_FLASH_NONCE_CFG>:
200236d6:	b570      	push	{r4, r5, r6, lr}
200236d8:	460c      	mov	r4, r1
200236da:	4615      	mov	r5, r2
200236dc:	4619      	mov	r1, r3
200236de:	4606      	mov	r6, r0
200236e0:	b180      	cbz	r0, 20023704 <HAL_FLASH_NONCE_CFG+0x2e>
200236e2:	b17b      	cbz	r3, 20023704 <HAL_FLASH_NONCE_CFG+0x2e>
200236e4:	f7ff fb86 	bl	20022df4 <HAL_FLASH_SET_NONCE>
200236e8:	6933      	ldr	r3, [r6, #16]
200236ea:	4630      	mov	r0, r6
200236ec:	42a3      	cmp	r3, r4
200236ee:	bf98      	it	ls
200236f0:	1ae4      	subls	r4, r4, r3
200236f2:	42ab      	cmp	r3, r5
200236f4:	bf98      	it	ls
200236f6:	1aed      	subls	r5, r5, r3
200236f8:	462a      	mov	r2, r5
200236fa:	4621      	mov	r1, r4
200236fc:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
20023700:	f7ff bb66 	b.w	20022dd0 <HAL_FLASH_SET_CTR>
20023704:	bd70      	pop	{r4, r5, r6, pc}

20023706 <HAL_FLASH_AES_CFG>:
20023706:	b510      	push	{r4, lr}
20023708:	4604      	mov	r4, r0
2002370a:	b148      	cbz	r0, 20023720 <HAL_FLASH_AES_CFG+0x1a>
2002370c:	b101      	cbz	r1, 20023710 <HAL_FLASH_AES_CFG+0xa>
2002370e:	2101      	movs	r1, #1
20023710:	f7ff fb7e 	bl	20022e10 <HAL_FLASH_SET_AES>
20023714:	4620      	mov	r0, r4
20023716:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
2002371a:	2101      	movs	r1, #1
2002371c:	f7ff bb87 	b.w	20022e2e <HAL_FLASH_ENABLE_AES>
20023720:	bd10      	pop	{r4, pc}

20023722 <nand_read_id>:
20023722:	b510      	push	{r4, lr}
20023724:	460b      	mov	r3, r1
20023726:	4604      	mov	r4, r0
20023728:	b086      	sub	sp, #24
2002372a:	b320      	cbz	r0, 20023776 <nand_read_id+0x54>
2002372c:	2908      	cmp	r1, #8
2002372e:	f04f 0100 	mov.w	r1, #0
20023732:	f04f 0201 	mov.w	r2, #1
20023736:	bf83      	ittte	hi
20023738:	460b      	movhi	r3, r1
2002373a:	e9cd 1202 	strdhi	r1, r2, [sp, #8]
2002373e:	e9cd 1100 	strdhi	r1, r1, [sp]
20023742:	e9cd 1102 	strdls	r1, r1, [sp, #8]
20023746:	bf8e      	itee	hi
20023748:	4619      	movhi	r1, r3
2002374a:	e9cd 1100 	strdls	r1, r1, [sp]
2002374e:	b25b      	sxtbls	r3, r3
20023750:	9204      	str	r2, [sp, #16]
20023752:	f7ff fade 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
20023756:	2103      	movs	r1, #3
20023758:	4620      	mov	r0, r4
2002375a:	f7ff fa70 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
2002375e:	2200      	movs	r2, #0
20023760:	219f      	movs	r1, #159	@ 0x9f
20023762:	4620      	mov	r0, r4
20023764:	f7ff fa90 	bl	20022c88 <HAL_FLASH_SET_CMD>
20023768:	4620      	mov	r0, r4
2002376a:	f7ff fabe 	bl	20022cea <HAL_FLASH_READ32>
2002376e:	f020 407f 	bic.w	r0, r0, #4278190080	@ 0xff000000
20023772:	b006      	add	sp, #24
20023774:	bd10      	pop	{r4, pc}
20023776:	20ff      	movs	r0, #255	@ 0xff
20023778:	e7fb      	b.n	20023772 <nand_read_id+0x50>

2002377a <HAL_NAND_CONF_ECC>:
2002377a:	b538      	push	{r3, r4, r5, lr}
2002377c:	460d      	mov	r5, r1
2002377e:	4604      	mov	r4, r0
20023780:	b398      	cbz	r0, 200237ea <HAL_NAND_CONF_ECC+0x70>
20023782:	68c3      	ldr	r3, [r0, #12]
20023784:	b38b      	cbz	r3, 200237ea <HAL_NAND_CONF_ECC+0x70>
20023786:	799a      	ldrb	r2, [r3, #6]
20023788:	b392      	cbz	r2, 200237f0 <HAL_NAND_CONF_ECC+0x76>
2002378a:	7a9b      	ldrb	r3, [r3, #10]
2002378c:	b383      	cbz	r3, 200237f0 <HAL_NAND_CONF_ECC+0x76>
2002378e:	2101      	movs	r1, #1
20023790:	f7ff fa55 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023794:	68e3      	ldr	r3, [r4, #12]
20023796:	2102      	movs	r1, #2
20023798:	799a      	ldrb	r2, [r3, #6]
2002379a:	4620      	mov	r0, r4
2002379c:	f7ff fcee 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200237a0:	4620      	mov	r0, r4
200237a2:	f7ff faa2 	bl	20022cea <HAL_FLASH_READ32>
200237a6:	68e3      	ldr	r3, [r4, #12]
200237a8:	7a9b      	ldrb	r3, [r3, #10]
200237aa:	b1dd      	cbz	r5, 200237e4 <HAL_NAND_CONF_ECC+0x6a>
200237ac:	ea43 0100 	orr.w	r1, r3, r0
200237b0:	4620      	mov	r0, r4
200237b2:	f7ff fa3d 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200237b6:	2101      	movs	r1, #1
200237b8:	4620      	mov	r0, r4
200237ba:	f7ff fa40 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200237be:	68e3      	ldr	r3, [r4, #12]
200237c0:	2103      	movs	r1, #3
200237c2:	799a      	ldrb	r2, [r3, #6]
200237c4:	4620      	mov	r0, r4
200237c6:	f7ff fcd9 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200237ca:	68e3      	ldr	r3, [r4, #12]
200237cc:	f884 5025 	strb.w	r5, [r4, #37]	@ 0x25
200237d0:	2102      	movs	r1, #2
200237d2:	799a      	ldrb	r2, [r3, #6]
200237d4:	4620      	mov	r0, r4
200237d6:	f7ff fcd1 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200237da:	4620      	mov	r0, r4
200237dc:	f7ff fa85 	bl	20022cea <HAL_FLASH_READ32>
200237e0:	2000      	movs	r0, #0
200237e2:	bd38      	pop	{r3, r4, r5, pc}
200237e4:	ea20 0103 	bic.w	r1, r0, r3
200237e8:	e7e2      	b.n	200237b0 <HAL_NAND_CONF_ECC+0x36>
200237ea:	f04f 30ff 	mov.w	r0, #4294967295
200237ee:	e7f8      	b.n	200237e2 <HAL_NAND_CONF_ECC+0x68>
200237f0:	f06f 0001 	mvn.w	r0, #1
200237f4:	e7f5      	b.n	200237e2 <HAL_NAND_CONF_ECC+0x68>

200237f6 <HAL_NAND_GET_ECC_STATUS>:
200237f6:	b510      	push	{r4, lr}
200237f8:	4604      	mov	r4, r0
200237fa:	b320      	cbz	r0, 20023846 <HAL_NAND_GET_ECC_STATUS+0x50>
200237fc:	68c2      	ldr	r2, [r0, #12]
200237fe:	b31a      	cbz	r2, 20023848 <HAL_NAND_GET_ECC_STATUS+0x52>
20023800:	7913      	ldrb	r3, [r2, #4]
20023802:	b31b      	cbz	r3, 2002384c <HAL_NAND_GET_ECC_STATUS+0x56>
20023804:	79d3      	ldrb	r3, [r2, #7]
20023806:	b30b      	cbz	r3, 2002384c <HAL_NAND_GET_ECC_STATUS+0x56>
20023808:	2101      	movs	r1, #1
2002380a:	f7ff fa18 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
2002380e:	68e3      	ldr	r3, [r4, #12]
20023810:	2102      	movs	r1, #2
20023812:	791a      	ldrb	r2, [r3, #4]
20023814:	4620      	mov	r0, r4
20023816:	f7ff fcb1 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002381a:	4620      	mov	r0, r4
2002381c:	f7ff fa65 	bl	20022cea <HAL_FLASH_READ32>
20023820:	f894 2024 	ldrb.w	r2, [r4, #36]	@ 0x24
20023824:	2a3f      	cmp	r2, #63	@ 0x3f
20023826:	ea4f 1312 	mov.w	r3, r2, lsr #4
2002382a:	d804      	bhi.n	20023836 <HAL_NAND_GET_ECC_STATUS+0x40>
2002382c:	2b01      	cmp	r3, #1
2002382e:	d808      	bhi.n	20023842 <HAL_NAND_GET_ECC_STATUS+0x4c>
20023830:	f000 0030 	and.w	r0, r0, #48	@ 0x30
20023834:	e007      	b.n	20023846 <HAL_NAND_GET_ECC_STATUS+0x50>
20023836:	3b04      	subs	r3, #4
20023838:	2b01      	cmp	r3, #1
2002383a:	d8f9      	bhi.n	20023830 <HAL_NAND_GET_ECC_STATUS+0x3a>
2002383c:	f000 00f0 	and.w	r0, r0, #240	@ 0xf0
20023840:	e001      	b.n	20023846 <HAL_NAND_GET_ECC_STATUS+0x50>
20023842:	f000 0070 	and.w	r0, r0, #112	@ 0x70
20023846:	bd10      	pop	{r4, pc}
20023848:	4610      	mov	r0, r2
2002384a:	e7fc      	b.n	20023846 <HAL_NAND_GET_ECC_STATUS+0x50>
2002384c:	4618      	mov	r0, r3
2002384e:	e7fa      	b.n	20023846 <HAL_NAND_GET_ECC_STATUS+0x50>

20023850 <HAL_NAND_CHECK_ECC>:
20023850:	4603      	mov	r3, r0
20023852:	1108      	asrs	r0, r1, #4
20023854:	b172      	cbz	r2, 20023874 <HAL_NAND_CHECK_ECC+0x24>
20023856:	2b07      	cmp	r3, #7
20023858:	d80c      	bhi.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
2002385a:	e8df f003 	tbb	[pc, r3]
2002385e:	0d04      	.short	0x0d04
20023860:	3f352e18 	.word	0x3f352e18
20023864:	4c47      	.short	0x4c47
20023866:	b128      	cbz	r0, 20023874 <HAL_NAND_CHECK_ECC+0x24>
20023868:	2801      	cmp	r0, #1
2002386a:	6813      	ldr	r3, [r2, #0]
2002386c:	d10a      	bne.n	20023884 <HAL_NAND_CHECK_ECC+0x34>
2002386e:	f043 0301 	orr.w	r3, r3, #1
20023872:	6013      	str	r3, [r2, #0]
20023874:	2000      	movs	r0, #0
20023876:	4770      	bx	lr
20023878:	f020 0302 	bic.w	r3, r0, #2
2002387c:	2b01      	cmp	r3, #1
2002387e:	d003      	beq.n	20023888 <HAL_NAND_CHECK_ECC+0x38>
20023880:	b1d0      	cbz	r0, 200238b8 <HAL_NAND_CHECK_ECC+0x68>
20023882:	6813      	ldr	r3, [r2, #0]
20023884:	4303      	orrs	r3, r0
20023886:	e016      	b.n	200238b6 <HAL_NAND_CHECK_ECC+0x66>
20023888:	6813      	ldr	r3, [r2, #0]
2002388a:	4303      	orrs	r3, r0
2002388c:	e7f1      	b.n	20023872 <HAL_NAND_CHECK_ECC+0x22>
2002388e:	2805      	cmp	r0, #5
20023890:	d8f7      	bhi.n	20023882 <HAL_NAND_CHECK_ECC+0x32>
20023892:	a301      	add	r3, pc, #4	@ (adr r3, 20023898 <HAL_NAND_CHECK_ECC+0x48>)
20023894:	f853 f020 	ldr.w	pc, [r3, r0, lsl #2]
20023898:	20023875 	.word	0x20023875
2002389c:	20023889 	.word	0x20023889
200238a0:	200238b1 	.word	0x200238b1
200238a4:	20023889 	.word	0x20023889
200238a8:	20023883 	.word	0x20023883
200238ac:	20023889 	.word	0x20023889
200238b0:	6813      	ldr	r3, [r2, #0]
200238b2:	f043 0302 	orr.w	r3, r3, #2
200238b6:	6013      	str	r3, [r2, #0]
200238b8:	4770      	bx	lr
200238ba:	2800      	cmp	r0, #0
200238bc:	d0da      	beq.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
200238be:	1e43      	subs	r3, r0, #1
200238c0:	2b05      	cmp	r3, #5
200238c2:	6813      	ldr	r3, [r2, #0]
200238c4:	d9e1      	bls.n	2002388a <HAL_NAND_CHECK_ECC+0x3a>
200238c6:	e7dd      	b.n	20023884 <HAL_NAND_CHECK_ECC+0x34>
200238c8:	07c3      	lsls	r3, r0, #31
200238ca:	f000 0103 	and.w	r1, r0, #3
200238ce:	d402      	bmi.n	200238d6 <HAL_NAND_CHECK_ECC+0x86>
200238d0:	2900      	cmp	r1, #0
200238d2:	d0cf      	beq.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
200238d4:	e7d5      	b.n	20023882 <HAL_NAND_CHECK_ECC+0x32>
200238d6:	6813      	ldr	r3, [r2, #0]
200238d8:	430b      	orrs	r3, r1
200238da:	e7ca      	b.n	20023872 <HAL_NAND_CHECK_ECC+0x22>
200238dc:	2800      	cmp	r0, #0
200238de:	d0c9      	beq.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
200238e0:	6813      	ldr	r3, [r2, #0]
200238e2:	2808      	cmp	r0, #8
200238e4:	ea43 0300 	orr.w	r3, r3, r0
200238e8:	dce5      	bgt.n	200238b6 <HAL_NAND_CHECK_ECC+0x66>
200238ea:	e7c2      	b.n	20023872 <HAL_NAND_CHECK_ECC+0x22>
200238ec:	2800      	cmp	r0, #0
200238ee:	d0c1      	beq.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
200238f0:	1e43      	subs	r3, r0, #1
200238f2:	2b01      	cmp	r3, #1
200238f4:	e7e5      	b.n	200238c2 <HAL_NAND_CHECK_ECC+0x72>
200238f6:	2800      	cmp	r0, #0
200238f8:	d0bc      	beq.n	20023874 <HAL_NAND_CHECK_ECC+0x24>
200238fa:	1e43      	subs	r3, r0, #1
200238fc:	2b02      	cmp	r3, #2
200238fe:	e7e0      	b.n	200238c2 <HAL_NAND_CHECK_ECC+0x72>

20023900 <HAL_NAND_GET_ECC_RESULT>:
20023900:	b510      	push	{r4, lr}
20023902:	f890 3025 	ldrb.w	r3, [r0, #37]	@ 0x25
20023906:	4604      	mov	r4, r0
20023908:	b183      	cbz	r3, 2002392c <HAL_NAND_GET_ECC_RESULT+0x2c>
2002390a:	f7ff ff74 	bl	200237f6 <HAL_NAND_GET_ECC_STATUS>
2002390e:	4601      	mov	r1, r0
20023910:	b160      	cbz	r0, 2002392c <HAL_NAND_GET_ECC_RESULT+0x2c>
20023912:	4622      	mov	r2, r4
20023914:	6863      	ldr	r3, [r4, #4]
20023916:	f443 4300 	orr.w	r3, r3, #32768	@ 0x8000
2002391a:	f842 3f04 	str.w	r3, [r2, #4]!
2002391e:	f894 0024 	ldrb.w	r0, [r4, #36]	@ 0x24
20023922:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20023926:	0900      	lsrs	r0, r0, #4
20023928:	f7ff bf92 	b.w	20023850 <HAL_NAND_CHECK_ECC>
2002392c:	2000      	movs	r0, #0
2002392e:	bd10      	pop	{r4, pc}

20023930 <HAL_NAND_EN_QUAL>:
20023930:	b538      	push	{r3, r4, r5, lr}
20023932:	460d      	mov	r5, r1
20023934:	4604      	mov	r4, r0
20023936:	b348      	cbz	r0, 2002398c <HAL_NAND_EN_QUAL+0x5c>
20023938:	68c3      	ldr	r3, [r0, #12]
2002393a:	b33b      	cbz	r3, 2002398c <HAL_NAND_EN_QUAL+0x5c>
2002393c:	799a      	ldrb	r2, [r3, #6]
2002393e:	b10a      	cbz	r2, 20023944 <HAL_NAND_EN_QUAL+0x14>
20023940:	7a1b      	ldrb	r3, [r3, #8]
20023942:	b90b      	cbnz	r3, 20023948 <HAL_NAND_EN_QUAL+0x18>
20023944:	2000      	movs	r0, #0
20023946:	bd38      	pop	{r3, r4, r5, pc}
20023948:	2101      	movs	r1, #1
2002394a:	f7ff f978 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
2002394e:	68e3      	ldr	r3, [r4, #12]
20023950:	2102      	movs	r1, #2
20023952:	799a      	ldrb	r2, [r3, #6]
20023954:	4620      	mov	r0, r4
20023956:	f7ff fc11 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
2002395a:	4620      	mov	r0, r4
2002395c:	f7ff f9c5 	bl	20022cea <HAL_FLASH_READ32>
20023960:	68e3      	ldr	r3, [r4, #12]
20023962:	7a1b      	ldrb	r3, [r3, #8]
20023964:	b17d      	cbz	r5, 20023986 <HAL_NAND_EN_QUAL+0x56>
20023966:	ea43 0100 	orr.w	r1, r3, r0
2002396a:	4620      	mov	r0, r4
2002396c:	f7ff f960 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
20023970:	2101      	movs	r1, #1
20023972:	4620      	mov	r0, r4
20023974:	f7ff f963 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023978:	68e3      	ldr	r3, [r4, #12]
2002397a:	2103      	movs	r1, #3
2002397c:	4620      	mov	r0, r4
2002397e:	799a      	ldrb	r2, [r3, #6]
20023980:	f7ff fbfc 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023984:	e7de      	b.n	20023944 <HAL_NAND_EN_QUAL+0x14>
20023986:	ea20 0103 	bic.w	r1, r0, r3
2002398a:	e7ee      	b.n	2002396a <HAL_NAND_EN_QUAL+0x3a>
2002398c:	f04f 30ff 	mov.w	r0, #4294967295
20023990:	e7d9      	b.n	20023946 <HAL_NAND_EN_QUAL+0x16>

20023992 <nand_clear_status>:
20023992:	b510      	push	{r4, lr}
20023994:	4604      	mov	r4, r0
20023996:	2101      	movs	r1, #1
20023998:	f7ff f951 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
2002399c:	2102      	movs	r1, #2
2002399e:	4620      	mov	r0, r4
200239a0:	f7ff f946 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200239a4:	68e3      	ldr	r3, [r4, #12]
200239a6:	2103      	movs	r1, #3
200239a8:	795a      	ldrb	r2, [r3, #5]
200239aa:	4620      	mov	r0, r4
200239ac:	f7ff fbe6 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200239b0:	2100      	movs	r1, #0
200239b2:	4620      	mov	r0, r4
200239b4:	f7ff f93c 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200239b8:	68e3      	ldr	r3, [r4, #12]
200239ba:	2103      	movs	r1, #3
200239bc:	4620      	mov	r0, r4
200239be:	795a      	ldrb	r2, [r3, #5]
200239c0:	f7ff fbdc 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200239c4:	2000      	movs	r0, #0
200239c6:	bd10      	pop	{r4, pc}

200239c8 <HAL_NAND_PAGE_SIZE>:
200239c8:	b140      	cbz	r0, 200239dc <HAL_NAND_PAGE_SIZE+0x14>
200239ca:	f890 3024 	ldrb.w	r3, [r0, #36]	@ 0x24
200239ce:	f013 0f01 	tst.w	r3, #1
200239d2:	bf14      	ite	ne
200239d4:	f44f 5080 	movne.w	r0, #4096	@ 0x1000
200239d8:	f44f 6000 	moveq.w	r0, #2048	@ 0x800
200239dc:	4770      	bx	lr
	...

200239e0 <HAL_NAND_READ_WITHOOB>:
200239e0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200239e4:	b091      	sub	sp, #68	@ 0x44
200239e6:	460e      	mov	r6, r1
200239e8:	4692      	mov	sl, r2
200239ea:	461d      	mov	r5, r3
200239ec:	4604      	mov	r4, r0
200239ee:	9f1b      	ldr	r7, [sp, #108]	@ 0x6c
200239f0:	b128      	cbz	r0, 200239fe <HAL_NAND_READ_WITHOOB+0x1e>
200239f2:	68c3      	ldr	r3, [r0, #12]
200239f4:	b11b      	cbz	r3, 200239fe <HAL_NAND_READ_WITHOOB+0x1e>
200239f6:	69c3      	ldr	r3, [r0, #28]
200239f8:	b10b      	cbz	r3, 200239fe <HAL_NAND_READ_WITHOOB+0x1e>
200239fa:	2f80      	cmp	r7, #128	@ 0x80
200239fc:	d905      	bls.n	20023a0a <HAL_NAND_READ_WITHOOB+0x2a>
200239fe:	2301      	movs	r3, #1
20023a00:	6063      	str	r3, [r4, #4]
20023a02:	2000      	movs	r0, #0
20023a04:	b011      	add	sp, #68	@ 0x44
20023a06:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20023a0a:	f7ff ffdd 	bl	200239c8 <HAL_NAND_PAGE_SIZE>
20023a0e:	f100 39ff 	add.w	r9, r0, #4294967295
20023a12:	ea09 0901 	and.w	r9, r9, r1
20023a16:	eb09 0305 	add.w	r3, r9, r5
20023a1a:	4283      	cmp	r3, r0
20023a1c:	4680      	mov	r8, r0
20023a1e:	d901      	bls.n	20023a24 <HAL_NAND_READ_WITHOOB+0x44>
20023a20:	2302      	movs	r3, #2
20023a22:	e7ed      	b.n	20023a00 <HAL_NAND_READ_WITHOOB+0x20>
20023a24:	2300      	movs	r3, #0
20023a26:	6063      	str	r3, [r4, #4]
20023a28:	6923      	ldr	r3, [r4, #16]
20023a2a:	f04f 0b00 	mov.w	fp, #0
20023a2e:	428b      	cmp	r3, r1
20023a30:	bf98      	it	ls
20023a32:	1ace      	subls	r6, r1, r3
20023a34:	fbb6 f2f0 	udiv	r2, r6, r0
20023a38:	2104      	movs	r1, #4
20023a3a:	4620      	mov	r0, r4
20023a3c:	f7ff fb9e 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023a40:	2014      	movs	r0, #20
20023a42:	f7fe f9fb 	bl	20021e3c <HAL_Delay_us_>
20023a46:	2101      	movs	r1, #1
20023a48:	4620      	mov	r0, r4
20023a4a:	f7ff f8f8 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023a4e:	2005      	movs	r0, #5
20023a50:	f7fe f9f4 	bl	20021e3c <HAL_Delay_us_>
20023a54:	68e3      	ldr	r3, [r4, #12]
20023a56:	2102      	movs	r1, #2
20023a58:	791a      	ldrb	r2, [r3, #4]
20023a5a:	4620      	mov	r0, r4
20023a5c:	f7ff fb8e 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023a60:	4620      	mov	r0, r4
20023a62:	f7ff f942 	bl	20022cea <HAL_FLASH_READ32>
20023a66:	07c3      	lsls	r3, r0, #31
20023a68:	d4f1      	bmi.n	20023a4e <HAL_NAND_READ_WITHOOB+0x6e>
20023a6a:	f1bb 0f00 	cmp.w	fp, #0
20023a6e:	d102      	bne.n	20023a76 <HAL_NAND_READ_WITHOOB+0x96>
20023a70:	f04f 0b01 	mov.w	fp, #1
20023a74:	e7eb      	b.n	20023a4e <HAL_NAND_READ_WITHOOB+0x6e>
20023a76:	4620      	mov	r0, r4
20023a78:	f7ff ff42 	bl	20023900 <HAL_NAND_GET_ECC_RESULT>
20023a7c:	b118      	cbz	r0, 20023a86 <HAL_NAND_READ_WITHOOB+0xa6>
20023a7e:	f440 4000 	orr.w	r0, r0, #32768	@ 0x8000
20023a82:	6060      	str	r0, [r4, #4]
20023a84:	e7bd      	b.n	20023a02 <HAL_NAND_READ_WITHOOB+0x22>
20023a86:	f894 2020 	ldrb.w	r2, [r4, #32]
20023a8a:	68e3      	ldr	r3, [r4, #12]
20023a8c:	2a00      	cmp	r2, #0
20023a8e:	d140      	bne.n	20023b12 <HAL_NAND_READ_WITHOOB+0x132>
20023a90:	f893 1046 	ldrb.w	r1, [r3, #70]	@ 0x46
20023a94:	4620      	mov	r0, r4
20023a96:	f7ff f87a 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
20023a9a:	68e0      	ldr	r0, [r4, #12]
20023a9c:	f990 c04e 	ldrsb.w	ip, [r0, #78]	@ 0x4e
20023aa0:	f990 304a 	ldrsb.w	r3, [r0, #74]	@ 0x4a
20023aa4:	f990 2049 	ldrsb.w	r2, [r0, #73]	@ 0x49
20023aa8:	f990 1048 	ldrsb.w	r1, [r0, #72]	@ 0x48
20023aac:	f8cd c00c 	str.w	ip, [sp, #12]
20023ab0:	f990 c04d 	ldrsb.w	ip, [r0, #77]	@ 0x4d
20023ab4:	f8cd c008 	str.w	ip, [sp, #8]
20023ab8:	f990 c04c 	ldrsb.w	ip, [r0, #76]	@ 0x4c
20023abc:	f8cd c004 	str.w	ip, [sp, #4]
20023ac0:	f990 004b 	ldrsb.w	r0, [r0, #75]	@ 0x4b
20023ac4:	9000      	str	r0, [sp, #0]
20023ac6:	4620      	mov	r0, r4
20023ac8:	f7ff f86c 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
20023acc:	03b0      	lsls	r0, r6, #14
20023ace:	f8d4 b010 	ldr.w	fp, [r4, #16]
20023ad2:	d504      	bpl.n	20023ade <HAL_NAND_READ_WITHOOB+0xfe>
20023ad4:	f894 3027 	ldrb.w	r3, [r4, #39]	@ 0x27
20023ad8:	b10b      	cbz	r3, 20023ade <HAL_NAND_READ_WITHOOB+0xfe>
20023ada:	f44b 5b80 	orr.w	fp, fp, #4096	@ 0x1000
20023ade:	ea4a 0305 	orr.w	r3, sl, r5
20023ae2:	ea43 0309 	orr.w	r3, r3, r9
20023ae6:	f013 0303 	ands.w	r3, r3, #3
20023aea:	d102      	bne.n	20023af2 <HAL_NAND_READ_WITHOOB+0x112>
20023aec:	1e6a      	subs	r2, r5, #1
20023aee:	2afe      	cmp	r2, #254	@ 0xfe
20023af0:	d82a      	bhi.n	20023b48 <HAL_NAND_READ_WITHOOB+0x168>
20023af2:	462a      	mov	r2, r5
20023af4:	4650      	mov	r0, sl
20023af6:	eb0b 0109 	add.w	r1, fp, r9
20023afa:	f006 fec5 	bl	2002a888 <memcpy>
20023afe:	9b1a      	ldr	r3, [sp, #104]	@ 0x68
20023b00:	b12b      	cbz	r3, 20023b0e <HAL_NAND_READ_WITHOOB+0x12e>
20023b02:	463a      	mov	r2, r7
20023b04:	4618      	mov	r0, r3
20023b06:	eb0b 0108 	add.w	r1, fp, r8
20023b0a:	f006 febd 	bl	2002a888 <memcpy>
20023b0e:	1978      	adds	r0, r7, r5
20023b10:	e778      	b.n	20023a04 <HAL_NAND_READ_WITHOOB+0x24>
20023b12:	f893 106a 	ldrb.w	r1, [r3, #106]	@ 0x6a
20023b16:	4620      	mov	r0, r4
20023b18:	f7ff f839 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
20023b1c:	68e0      	ldr	r0, [r4, #12]
20023b1e:	f990 c072 	ldrsb.w	ip, [r0, #114]	@ 0x72
20023b22:	f990 306e 	ldrsb.w	r3, [r0, #110]	@ 0x6e
20023b26:	f990 206d 	ldrsb.w	r2, [r0, #109]	@ 0x6d
20023b2a:	f990 106c 	ldrsb.w	r1, [r0, #108]	@ 0x6c
20023b2e:	f8cd c00c 	str.w	ip, [sp, #12]
20023b32:	f990 c071 	ldrsb.w	ip, [r0, #113]	@ 0x71
20023b36:	f8cd c008 	str.w	ip, [sp, #8]
20023b3a:	f990 c070 	ldrsb.w	ip, [r0, #112]	@ 0x70
20023b3e:	f8cd c004 	str.w	ip, [sp, #4]
20023b42:	f990 006f 	ldrsb.w	r0, [r0, #111]	@ 0x6f
20023b46:	e7bd      	b.n	20023ac4 <HAL_NAND_READ_WITHOOB+0xe4>
20023b48:	f1ba 0f00 	cmp.w	sl, #0
20023b4c:	d0d7      	beq.n	20023afe <HAL_NAND_READ_WITHOOB+0x11e>
20023b4e:	491c      	ldr	r1, [pc, #112]	@ (20023bc0 <HAL_NAND_READ_WITHOOB+0x1e0>)
20023b50:	4a1c      	ldr	r2, [pc, #112]	@ (20023bc4 <HAL_NAND_READ_WITHOOB+0x1e4>)
20023b52:	a804      	add	r0, sp, #16
20023b54:	e9cd 1205 	strd	r1, r2, [sp, #20]
20023b58:	f88d 301c 	strb.w	r3, [sp, #28]
20023b5c:	f7fe ff28 	bl	200229b0 <HAL_EXT_DMA_Init>
20023b60:	b150      	cbz	r0, 20023b78 <HAL_NAND_READ_WITHOOB+0x198>
20023b62:	990f      	ldr	r1, [sp, #60]	@ 0x3c
20023b64:	f89d 3029 	ldrb.w	r3, [sp, #41]	@ 0x29
20023b68:	ea40 4101 	orr.w	r1, r0, r1, lsl #16
20023b6c:	ea41 2103 	orr.w	r1, r1, r3, lsl #8
20023b70:	f041 4100 	orr.w	r1, r1, #2147483648	@ 0x80000000
20023b74:	6061      	str	r1, [r4, #4]
20023b76:	e744      	b.n	20023a02 <HAL_NAND_READ_WITHOOB+0x22>
20023b78:	eb0b 0109 	add.w	r1, fp, r9
20023b7c:	4652      	mov	r2, sl
20023b7e:	08ab      	lsrs	r3, r5, #2
20023b80:	a804      	add	r0, sp, #16
20023b82:	f7fe ff37 	bl	200229f4 <HAL_EXT_DMA_Start>
20023b86:	4601      	mov	r1, r0
20023b88:	b980      	cbnz	r0, 20023bac <HAL_NAND_READ_WITHOOB+0x1cc>
20023b8a:	f44f 727a 	mov.w	r2, #1000	@ 0x3e8
20023b8e:	a804      	add	r0, sp, #16
20023b90:	f7fe ff57 	bl	20022a42 <HAL_EXT_DMA_PollForTransfer>
20023b94:	2800      	cmp	r0, #0
20023b96:	d0b2      	beq.n	20023afe <HAL_NAND_READ_WITHOOB+0x11e>
20023b98:	990f      	ldr	r1, [sp, #60]	@ 0x3c
20023b9a:	f89d 3029 	ldrb.w	r3, [sp, #41]	@ 0x29
20023b9e:	ea40 4101 	orr.w	r1, r0, r1, lsl #16
20023ba2:	ea41 2103 	orr.w	r1, r1, r3, lsl #8
20023ba6:	f041 4160 	orr.w	r1, r1, #3758096384	@ 0xe0000000
20023baa:	e7e3      	b.n	20023b74 <HAL_NAND_READ_WITHOOB+0x194>
20023bac:	9a0f      	ldr	r2, [sp, #60]	@ 0x3c
20023bae:	f89d 3029 	ldrb.w	r3, [sp, #41]	@ 0x29
20023bb2:	ea40 4102 	orr.w	r1, r0, r2, lsl #16
20023bb6:	ea41 2103 	orr.w	r1, r1, r3, lsl #8
20023bba:	f041 4140 	orr.w	r1, r1, #3221225472	@ 0xc0000000
20023bbe:	e7d9      	b.n	20023b74 <HAL_NAND_READ_WITHOOB+0x194>
20023bc0:	000c0080 	.word	0x000c0080
20023bc4:	00030040 	.word	0x00030040

20023bc8 <HAL_NAND_BLOCK_SIZE>:
20023bc8:	b508      	push	{r3, lr}
20023bca:	4602      	mov	r2, r0
20023bcc:	f7ff fefc 	bl	200239c8 <HAL_NAND_PAGE_SIZE>
20023bd0:	b128      	cbz	r0, 20023bde <HAL_NAND_BLOCK_SIZE+0x16>
20023bd2:	f892 3024 	ldrb.w	r3, [r2, #36]	@ 0x24
20023bd6:	079b      	lsls	r3, r3, #30
20023bd8:	bf4c      	ite	mi
20023bda:	01c0      	lslmi	r0, r0, #7
20023bdc:	0180      	lslpl	r0, r0, #6
20023bde:	bd08      	pop	{r3, pc}

20023be0 <HAL_NAND_GET_BADBLK>:
20023be0:	b51f      	push	{r0, r1, r2, r3, r4, lr}
20023be2:	4604      	mov	r4, r0
20023be4:	b910      	cbnz	r0, 20023bec <HAL_NAND_GET_BADBLK+0xc>
20023be6:	2000      	movs	r0, #0
20023be8:	b004      	add	sp, #16
20023bea:	bd10      	pop	{r4, pc}
20023bec:	69c3      	ldr	r3, [r0, #28]
20023bee:	2b00      	cmp	r3, #0
20023bf0:	d0f9      	beq.n	20023be6 <HAL_NAND_GET_BADBLK+0x6>
20023bf2:	f7ff ffe9 	bl	20023bc8 <HAL_NAND_BLOCK_SIZE>
20023bf6:	2304      	movs	r3, #4
20023bf8:	9301      	str	r3, [sp, #4]
20023bfa:	ab03      	add	r3, sp, #12
20023bfc:	9300      	str	r3, [sp, #0]
20023bfe:	2300      	movs	r3, #0
20023c00:	4341      	muls	r1, r0
20023c02:	461a      	mov	r2, r3
20023c04:	4620      	mov	r0, r4
20023c06:	f7ff feeb 	bl	200239e0 <HAL_NAND_READ_WITHOOB>
20023c0a:	b140      	cbz	r0, 20023c1e <HAL_NAND_GET_BADBLK+0x3e>
20023c0c:	f89d 300c 	ldrb.w	r3, [sp, #12]
20023c10:	2bff      	cmp	r3, #255	@ 0xff
20023c12:	d0e8      	beq.n	20023be6 <HAL_NAND_GET_BADBLK+0x6>
20023c14:	9803      	ldr	r0, [sp, #12]
20023c16:	2800      	cmp	r0, #0
20023c18:	bf08      	it	eq
20023c1a:	2001      	moveq	r0, #1
20023c1c:	e7e4      	b.n	20023be8 <HAL_NAND_GET_BADBLK+0x8>
20023c1e:	2001      	movs	r0, #1
20023c20:	e7e2      	b.n	20023be8 <HAL_NAND_GET_BADBLK+0x8>

20023c22 <HAL_QSPIEX_WRITE_PAGE>:
20023c22:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20023c26:	b099      	sub	sp, #100	@ 0x64
20023c28:	4604      	mov	r4, r0
20023c2a:	460e      	mov	r6, r1
20023c2c:	4691      	mov	r9, r2
20023c2e:	f7ff fcd4 	bl	200235da <flash_handle_valid>
20023c32:	b318      	cbz	r0, 20023c7c <HAL_QSPIEX_WRITE_PAGE+0x5a>
20023c34:	2b00      	cmp	r3, #0
20023c36:	f000 80d7 	beq.w	20023de8 <HAL_QSPIEX_WRITE_PAGE+0x1c6>
20023c3a:	f5b3 7f80 	cmp.w	r3, #256	@ 0x100
20023c3e:	bf28      	it	cs
20023c40:	f44f 7380 	movcs.w	r3, #256	@ 0x100
20023c44:	68a1      	ldr	r1, [r4, #8]
20023c46:	461d      	mov	r5, r3
20023c48:	6962      	ldr	r2, [r4, #20]
20023c4a:	f894 3020 	ldrb.w	r3, [r4, #32]
20023c4e:	2900      	cmp	r1, #0
20023c50:	d03b      	beq.n	20023cca <HAL_QSPIEX_WRITE_PAGE+0xa8>
20023c52:	f1b2 7f80 	cmp.w	r2, #16777216	@ 0x1000000
20023c56:	d914      	bls.n	20023c82 <HAL_QSPIEX_WRITE_PAGE+0x60>
20023c58:	2b02      	cmp	r3, #2
20023c5a:	bf14      	ite	ne
20023c5c:	2727      	movne	r7, #39	@ 0x27
20023c5e:	2728      	moveq	r7, #40	@ 0x28
20023c60:	4639      	mov	r1, r7
20023c62:	4620      	mov	r0, r4
20023c64:	f7ff fa63 	bl	2002312e <HAL_FLASH_PRE_CMD>
20023c68:	4649      	mov	r1, r9
20023c6a:	462b      	mov	r3, r5
20023c6c:	2201      	movs	r2, #1
20023c6e:	4620      	mov	r0, r4
20023c70:	f7ff fcbb 	bl	200235ea <HAL_FLASH_DMA_START>
20023c74:	4601      	mov	r1, r0
20023c76:	b148      	cbz	r0, 20023c8c <HAL_QSPIEX_WRITE_PAGE+0x6a>
20023c78:	2500      	movs	r5, #0
20023c7a:	4628      	mov	r0, r5
20023c7c:	b019      	add	sp, #100	@ 0x64
20023c7e:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20023c82:	2b02      	cmp	r3, #2
20023c84:	bf14      	ite	ne
20023c86:	2716      	movne	r7, #22
20023c88:	2717      	moveq	r7, #23
20023c8a:	e7e9      	b.n	20023c60 <HAL_QSPIEX_WRITE_PAGE+0x3e>
20023c8c:	4632      	mov	r2, r6
20023c8e:	4620      	mov	r0, r4
20023c90:	f7ff fa74 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023c94:	2101      	movs	r1, #1
20023c96:	4620      	mov	r0, r4
20023c98:	f7fe ffdb 	bl	20022c52 <HAL_FLASH_WRITE_DLEN2>
20023c9c:	2301      	movs	r3, #1
20023c9e:	4632      	mov	r2, r6
20023ca0:	9300      	str	r3, [sp, #0]
20023ca2:	4639      	mov	r1, r7
20023ca4:	2302      	movs	r3, #2
20023ca6:	4620      	mov	r0, r4
20023ca8:	f7ff fa9b 	bl	200231e2 <HAL_FLASH_ISSUE_CMD_SEQ>
20023cac:	2800      	cmp	r0, #0
20023cae:	d1e3      	bne.n	20023c78 <HAL_QSPIEX_WRITE_PAGE+0x56>
20023cb0:	f44f 717a 	mov.w	r1, #1000	@ 0x3e8
20023cb4:	4620      	mov	r0, r4
20023cb6:	f7ff fce8 	bl	2002368a <HAL_FLASH_DMA_WAIT_DONE>
20023cba:	2800      	cmp	r0, #0
20023cbc:	d1dc      	bne.n	20023c78 <HAL_QSPIEX_WRITE_PAGE+0x56>
20023cbe:	6822      	ldr	r2, [r4, #0]
20023cc0:	6813      	ldr	r3, [r2, #0]
20023cc2:	f023 0320 	bic.w	r3, r3, #32
20023cc6:	6013      	str	r3, [r2, #0]
20023cc8:	e7d7      	b.n	20023c7a <HAL_QSPIEX_WRITE_PAGE+0x58>
20023cca:	f1b2 7f80 	cmp.w	r2, #16777216	@ 0x1000000
20023cce:	f240 8082 	bls.w	20023dd6 <HAL_QSPIEX_WRITE_PAGE+0x1b4>
20023cd2:	2b02      	cmp	r3, #2
20023cd4:	bf14      	ite	ne
20023cd6:	2327      	movne	r3, #39	@ 0x27
20023cd8:	2328      	moveq	r3, #40	@ 0x28
20023cda:	462f      	mov	r7, r5
20023cdc:	f04f 0800 	mov.w	r8, #0
20023ce0:	9303      	str	r3, [sp, #12]
20023ce2:	f64f 7afc 	movw	sl, #65532	@ 0xfffc
20023ce6:	2f40      	cmp	r7, #64	@ 0x40
20023ce8:	bfd4      	ite	le
20023cea:	ea0a 0a07 	andle.w	sl, sl, r7
20023cee:	f00a 0a40 	andgt.w	sl, sl, #64	@ 0x40
20023cf2:	f1ba 0f00 	cmp.w	sl, #0
20023cf6:	d03f      	beq.n	20023d78 <HAL_QSPIEX_WRITE_PAGE+0x156>
20023cf8:	2200      	movs	r2, #0
20023cfa:	4620      	mov	r0, r4
20023cfc:	4611      	mov	r1, r2
20023cfe:	f7ff fa3d 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023d02:	eb09 0308 	add.w	r3, r9, r8
20023d06:	f10d 0c20 	add.w	ip, sp, #32
20023d0a:	f103 0e40 	add.w	lr, r3, #64	@ 0x40
20023d0e:	4662      	mov	r2, ip
20023d10:	6818      	ldr	r0, [r3, #0]
20023d12:	6859      	ldr	r1, [r3, #4]
20023d14:	3308      	adds	r3, #8
20023d16:	c203      	stmia	r2!, {r0, r1}
20023d18:	4573      	cmp	r3, lr
20023d1a:	4694      	mov	ip, r2
20023d1c:	d1f7      	bne.n	20023d0e <HAL_QSPIEX_WRITE_PAGE+0xec>
20023d1e:	f04f 0b00 	mov.w	fp, #0
20023d22:	ea4f 02aa 	mov.w	r2, sl, asr #2
20023d26:	ab08      	add	r3, sp, #32
20023d28:	f853 1b04 	ldr.w	r1, [r3], #4
20023d2c:	4620      	mov	r0, r4
20023d2e:	9205      	str	r2, [sp, #20]
20023d30:	9304      	str	r3, [sp, #16]
20023d32:	f7fe ff7d 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
20023d36:	9a05      	ldr	r2, [sp, #20]
20023d38:	f10b 0b01 	add.w	fp, fp, #1
20023d3c:	4593      	cmp	fp, r2
20023d3e:	9b04      	ldr	r3, [sp, #16]
20023d40:	d1f2      	bne.n	20023d28 <HAL_QSPIEX_WRITE_PAGE+0x106>
20023d42:	4651      	mov	r1, sl
20023d44:	4620      	mov	r0, r4
20023d46:	f7fe ff7a 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023d4a:	4620      	mov	r0, r4
20023d4c:	9903      	ldr	r1, [sp, #12]
20023d4e:	eb06 0208 	add.w	r2, r6, r8
20023d52:	f7ff fa13 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023d56:	2101      	movs	r1, #1
20023d58:	4620      	mov	r0, r4
20023d5a:	f7fe ff70 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023d5e:	2200      	movs	r2, #0
20023d60:	2102      	movs	r1, #2
20023d62:	4620      	mov	r0, r4
20023d64:	f7ff fa0a 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023d68:	4620      	mov	r0, r4
20023d6a:	f7fe ffb5 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
20023d6e:	2800      	cmp	r0, #0
20023d70:	d0f1      	beq.n	20023d56 <HAL_QSPIEX_WRITE_PAGE+0x134>
20023d72:	eba7 070a 	sub.w	r7, r7, sl
20023d76:	44d0      	add	r8, sl
20023d78:	1e7b      	subs	r3, r7, #1
20023d7a:	2b02      	cmp	r3, #2
20023d7c:	d830      	bhi.n	20023de0 <HAL_QSPIEX_WRITE_PAGE+0x1be>
20023d7e:	6923      	ldr	r3, [r4, #16]
20023d80:	4446      	add	r6, r8
20023d82:	4333      	orrs	r3, r6
20023d84:	681b      	ldr	r3, [r3, #0]
20023d86:	463a      	mov	r2, r7
20023d88:	eb09 0108 	add.w	r1, r9, r8
20023d8c:	a807      	add	r0, sp, #28
20023d8e:	9307      	str	r3, [sp, #28]
20023d90:	f006 fd7a 	bl	2002a888 <memcpy>
20023d94:	2200      	movs	r2, #0
20023d96:	4620      	mov	r0, r4
20023d98:	4611      	mov	r1, r2
20023d9a:	f7ff f9ef 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023d9e:	9907      	ldr	r1, [sp, #28]
20023da0:	4620      	mov	r0, r4
20023da2:	f7fe ff45 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
20023da6:	2104      	movs	r1, #4
20023da8:	4620      	mov	r0, r4
20023daa:	f7fe ff48 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023dae:	4632      	mov	r2, r6
20023db0:	4620      	mov	r0, r4
20023db2:	9903      	ldr	r1, [sp, #12]
20023db4:	f7ff f9e2 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023db8:	2101      	movs	r1, #1
20023dba:	4620      	mov	r0, r4
20023dbc:	f7fe ff3f 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20023dc0:	2200      	movs	r2, #0
20023dc2:	2102      	movs	r1, #2
20023dc4:	4620      	mov	r0, r4
20023dc6:	f7ff f9d9 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023dca:	4620      	mov	r0, r4
20023dcc:	f7fe ff84 	bl	20022cd8 <HAL_FLASH_IS_PROG_DONE>
20023dd0:	2800      	cmp	r0, #0
20023dd2:	d0f1      	beq.n	20023db8 <HAL_QSPIEX_WRITE_PAGE+0x196>
20023dd4:	e751      	b.n	20023c7a <HAL_QSPIEX_WRITE_PAGE+0x58>
20023dd6:	2b02      	cmp	r3, #2
20023dd8:	bf14      	ite	ne
20023dda:	2316      	movne	r3, #22
20023ddc:	2317      	moveq	r3, #23
20023dde:	e77c      	b.n	20023cda <HAL_QSPIEX_WRITE_PAGE+0xb8>
20023de0:	2f00      	cmp	r7, #0
20023de2:	f73f af7e 	bgt.w	20023ce2 <HAL_QSPIEX_WRITE_PAGE+0xc0>
20023de6:	e748      	b.n	20023c7a <HAL_QSPIEX_WRITE_PAGE+0x58>
20023de8:	4618      	mov	r0, r3
20023dea:	e747      	b.n	20023c7c <HAL_QSPIEX_WRITE_PAGE+0x5a>

20023dec <HAL_QSPIEX_SECT_ERASE>:
20023dec:	b573      	push	{r0, r1, r4, r5, r6, lr}
20023dee:	4604      	mov	r4, r0
20023df0:	460d      	mov	r5, r1
20023df2:	f7ff fbf2 	bl	200235da <flash_handle_valid>
20023df6:	b1e8      	cbz	r0, 20023e34 <HAL_QSPIEX_SECT_ERASE+0x48>
20023df8:	6963      	ldr	r3, [r4, #20]
20023dfa:	460a      	mov	r2, r1
20023dfc:	f1b3 7f80 	cmp.w	r3, #16777216	@ 0x1000000
20023e00:	f04f 0100 	mov.w	r1, #0
20023e04:	4620      	mov	r0, r4
20023e06:	bf94      	ite	ls
20023e08:	261b      	movls	r6, #27
20023e0a:	2629      	movhi	r6, #41	@ 0x29
20023e0c:	f7ff f9b6 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
20023e10:	2101      	movs	r1, #1
20023e12:	4620      	mov	r0, r4
20023e14:	f7fe ff1d 	bl	20022c52 <HAL_FLASH_WRITE_DLEN2>
20023e18:	2301      	movs	r3, #1
20023e1a:	462a      	mov	r2, r5
20023e1c:	9300      	str	r3, [sp, #0]
20023e1e:	4631      	mov	r1, r6
20023e20:	2302      	movs	r3, #2
20023e22:	4620      	mov	r0, r4
20023e24:	f7ff f9dd 	bl	200231e2 <HAL_FLASH_ISSUE_CMD_SEQ>
20023e28:	3800      	subs	r0, #0
20023e2a:	bf18      	it	ne
20023e2c:	2001      	movne	r0, #1
20023e2e:	4240      	negs	r0, r0
20023e30:	b002      	add	sp, #8
20023e32:	bd70      	pop	{r4, r5, r6, pc}
20023e34:	f04f 30ff 	mov.w	r0, #4294967295
20023e38:	e7fa      	b.n	20023e30 <HAL_QSPIEX_SECT_ERASE+0x44>
	...

20023e3c <HAL_QSPI_GET_SRC_CLK>:
20023e3c:	b508      	push	{r3, lr}
20023e3e:	b1e8      	cbz	r0, 20023e7c <HAL_QSPI_GET_SRC_CLK+0x40>
20023e40:	6803      	ldr	r3, [r0, #0]
20023e42:	4a0f      	ldr	r2, [pc, #60]	@ (20023e80 <HAL_QSPI_GET_SRC_CLK+0x44>)
20023e44:	4293      	cmp	r3, r2
20023e46:	d00c      	beq.n	20023e62 <HAL_QSPI_GET_SRC_CLK+0x26>
20023e48:	f502 5280 	add.w	r2, r2, #4096	@ 0x1000
20023e4c:	4293      	cmp	r3, r2
20023e4e:	d115      	bne.n	20023e7c <HAL_QSPI_GET_SRC_CLK+0x40>
20023e50:	2006      	movs	r0, #6
20023e52:	f001 f829 	bl	20024ea8 <HAL_RCC_HCPU_GetClockSrc>
20023e56:	2802      	cmp	r0, #2
20023e58:	d105      	bne.n	20023e66 <HAL_QSPI_GET_SRC_CLK+0x2a>
20023e5a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
20023e5e:	f001 b858 	b.w	20024f12 <HAL_RCC_HCPU_GetDLL2Freq>
20023e62:	2004      	movs	r0, #4
20023e64:	e7f5      	b.n	20023e52 <HAL_QSPI_GET_SRC_CLK+0x16>
20023e66:	2803      	cmp	r0, #3
20023e68:	d103      	bne.n	20023e72 <HAL_QSPI_GET_SRC_CLK+0x36>
20023e6a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
20023e6e:	f001 b853 	b.w	20024f18 <HAL_RCC_HCPU_GetDLL3Freq>
20023e72:	2001      	movs	r0, #1
20023e74:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
20023e78:	f001 b8b2 	b.w	20024fe0 <HAL_RCC_GetSysCLKFreq>
20023e7c:	2000      	movs	r0, #0
20023e7e:	bd08      	pop	{r3, pc}
20023e80:	50041000 	.word	0x50041000

20023e84 <HAL_QSPI_GET_CLK>:
20023e84:	b538      	push	{r3, r4, r5, lr}
20023e86:	4605      	mov	r5, r0
20023e88:	b908      	cbnz	r0, 20023e8e <HAL_QSPI_GET_CLK+0xa>
20023e8a:	2000      	movs	r0, #0
20023e8c:	bd38      	pop	{r3, r4, r5, pc}
20023e8e:	f7fe ff3b 	bl	20022d08 <HAL_FLASH_GET_DIV>
20023e92:	4604      	mov	r4, r0
20023e94:	2800      	cmp	r0, #0
20023e96:	d0f8      	beq.n	20023e8a <HAL_QSPI_GET_CLK+0x6>
20023e98:	4628      	mov	r0, r5
20023e9a:	f7ff ffcf 	bl	20023e3c <HAL_QSPI_GET_SRC_CLK>
20023e9e:	fbb0 f0f4 	udiv	r0, r0, r4
20023ea2:	e7f3      	b.n	20023e8c <HAL_QSPI_GET_CLK+0x8>

20023ea4 <HAL_QSPI_READ_ID>:
20023ea4:	b138      	cbz	r0, 20023eb6 <HAL_QSPI_READ_ID+0x12>
20023ea6:	f890 3023 	ldrb.w	r3, [r0, #35]	@ 0x23
20023eaa:	b113      	cbz	r3, 20023eb2 <HAL_QSPI_READ_ID+0xe>
20023eac:	2100      	movs	r1, #0
20023eae:	f7ff bc38 	b.w	20023722 <nand_read_id>
20023eb2:	f7ff bab8 	b.w	20023426 <HAL_FLASH_GET_NOR_ID>
20023eb6:	20ff      	movs	r0, #255	@ 0xff
20023eb8:	4770      	bx	lr

20023eba <HAL_NOR_CFG_DTR>:
20023eba:	b57f      	push	{r0, r1, r2, r3, r4, r5, r6, lr}
20023ebc:	4604      	mov	r4, r0
20023ebe:	460a      	mov	r2, r1
20023ec0:	b351      	cbz	r1, 20023f18 <HAL_NOR_CFG_DTR+0x5e>
20023ec2:	68c5      	ldr	r5, [r0, #12]
20023ec4:	f895 31ff 	ldrb.w	r3, [r5, #511]	@ 0x1ff
20023ec8:	2b00      	cmp	r3, #0
20023eca:	d03b      	beq.n	20023f44 <HAL_NOR_CFG_DTR+0x8a>
20023ecc:	f890 3020 	ldrb.w	r3, [r0, #32]
20023ed0:	b3c3      	cbz	r3, 20023f44 <HAL_NOR_CFG_DTR+0x8a>
20023ed2:	f995 6207 	ldrsb.w	r6, [r5, #519]	@ 0x207
20023ed6:	f995 2202 	ldrsb.w	r2, [r5, #514]	@ 0x202
20023eda:	f995 3203 	ldrsb.w	r3, [r5, #515]	@ 0x203
20023ede:	f995 1201 	ldrsb.w	r1, [r5, #513]	@ 0x201
20023ee2:	9603      	str	r6, [sp, #12]
20023ee4:	f995 6206 	ldrsb.w	r6, [r5, #518]	@ 0x206
20023ee8:	9602      	str	r6, [sp, #8]
20023eea:	f995 6205 	ldrsb.w	r6, [r5, #517]	@ 0x205
20023eee:	9601      	str	r6, [sp, #4]
20023ef0:	f995 5204 	ldrsb.w	r5, [r5, #516]	@ 0x204
20023ef4:	9500      	str	r5, [sp, #0]
20023ef6:	f7fe fe55 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
20023efa:	68e3      	ldr	r3, [r4, #12]
20023efc:	4620      	mov	r0, r4
20023efe:	f893 11ff 	ldrb.w	r1, [r3, #511]	@ 0x1ff
20023f02:	f7fe fe44 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
20023f06:	2101      	movs	r1, #1
20023f08:	4620      	mov	r0, r4
20023f0a:	f894 2025 	ldrb.w	r2, [r4, #37]	@ 0x25
20023f0e:	f7ff f855 	bl	20022fbc <HAL_MPI_CFG_DTR>
20023f12:	2000      	movs	r0, #0
20023f14:	b004      	add	sp, #16
20023f16:	bd70      	pop	{r4, r5, r6, pc}
20023f18:	f7ff f850 	bl	20022fbc <HAL_MPI_CFG_DTR>
20023f1c:	6963      	ldr	r3, [r4, #20]
20023f1e:	f894 1020 	ldrb.w	r1, [r4, #32]
20023f22:	f1b3 7f80 	cmp.w	r3, #16777216	@ 0x1000000
20023f26:	d906      	bls.n	20023f36 <HAL_NOR_CFG_DTR+0x7c>
20023f28:	b919      	cbnz	r1, 20023f32 <HAL_NOR_CFG_DTR+0x78>
20023f2a:	4620      	mov	r0, r4
20023f2c:	f7ff f8c2 	bl	200230b4 <HAL_FLASH_CONFIG_FULL_AHB_READ>
20023f30:	e7ef      	b.n	20023f12 <HAL_NOR_CFG_DTR+0x58>
20023f32:	2101      	movs	r1, #1
20023f34:	e7f9      	b.n	20023f2a <HAL_NOR_CFG_DTR+0x70>
20023f36:	b919      	cbnz	r1, 20023f40 <HAL_NOR_CFG_DTR+0x86>
20023f38:	4620      	mov	r0, r4
20023f3a:	f7ff f877 	bl	2002302c <HAL_FLASH_CONFIG_AHB_READ>
20023f3e:	e7e8      	b.n	20023f12 <HAL_NOR_CFG_DTR+0x58>
20023f40:	2101      	movs	r1, #1
20023f42:	e7f9      	b.n	20023f38 <HAL_NOR_CFG_DTR+0x7e>
20023f44:	2001      	movs	r0, #1
20023f46:	e7e5      	b.n	20023f14 <HAL_NOR_CFG_DTR+0x5a>

20023f48 <HAL_NOR_DTR_CAL>:
20023f48:	b510      	push	{r4, lr}
20023f4a:	4604      	mov	r4, r0
20023f4c:	b1f0      	cbz	r0, 20023f8c <HAL_NOR_DTR_CAL+0x44>
20023f4e:	6802      	ldr	r2, [r0, #0]
20023f50:	2014      	movs	r0, #20
20023f52:	f8d2 3094 	ldr.w	r3, [r2, #148]	@ 0x94
20023f56:	f043 4300 	orr.w	r3, r3, #2147483648	@ 0x80000000
20023f5a:	f8c2 3094 	str.w	r3, [r2, #148]	@ 0x94
20023f5e:	f7fd ffcc 	bl	20021efa <HAL_Delay_us>
20023f62:	6823      	ldr	r3, [r4, #0]
20023f64:	f8d3 2094 	ldr.w	r2, [r3, #148]	@ 0x94
20023f68:	05d2      	lsls	r2, r2, #23
20023f6a:	d5fb      	bpl.n	20023f64 <HAL_NOR_DTR_CAL+0x1c>
20023f6c:	f8d3 0094 	ldr.w	r0, [r3, #148]	@ 0x94
20023f70:	f8d3 2094 	ldr.w	r2, [r3, #148]	@ 0x94
20023f74:	b2c0      	uxtb	r0, r0
20023f76:	f022 4200 	bic.w	r2, r2, #2147483648	@ 0x80000000
20023f7a:	f8c3 2094 	str.w	r2, [r3, #148]	@ 0x94
20023f7e:	f894 3025 	ldrb.w	r3, [r4, #37]	@ 0x25
20023f82:	f023 037f 	bic.w	r3, r3, #127	@ 0x7f
20023f86:	4303      	orrs	r3, r0
20023f88:	f884 3025 	strb.w	r3, [r4, #37]	@ 0x25
20023f8c:	bd10      	pop	{r4, pc}
	...

20023f90 <HAL_FLASH_Init>:
20023f90:	e92d 43f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
20023f94:	460e      	mov	r6, r1
20023f96:	4690      	mov	r8, r2
20023f98:	461f      	mov	r7, r3
20023f9a:	4604      	mov	r4, r0
20023f9c:	b087      	sub	sp, #28
20023f9e:	2800      	cmp	r0, #0
20023fa0:	f000 80e5 	beq.w	2002416e <HAL_FLASH_Init+0x1de>
20023fa4:	2900      	cmp	r1, #0
20023fa6:	f000 80e2 	beq.w	2002416e <HAL_FLASH_Init+0x1de>
20023faa:	f7fe fdcf 	bl	20022b4c <HAL_QSPI_Init>
20023fae:	6820      	ldr	r0, [r4, #0]
20023fb0:	f7ff fb19 	bl	200235e6 <HAL_GET_FLASH_MID>
20023fb4:	6933      	ldr	r3, [r6, #16]
20023fb6:	2100      	movs	r1, #0
20023fb8:	f884 3034 	strb.w	r3, [r4, #52]	@ 0x34
20023fbc:	68b3      	ldr	r3, [r6, #8]
20023fbe:	4605      	mov	r5, r0
20023fc0:	63a3      	str	r3, [r4, #56]	@ 0x38
20023fc2:	68f3      	ldr	r3, [r6, #12]
20023fc4:	f884 1024 	strb.w	r1, [r4, #36]	@ 0x24
20023fc8:	051b      	lsls	r3, r3, #20
20023fca:	63e3      	str	r3, [r4, #60]	@ 0x3c
20023fcc:	2302      	movs	r3, #2
20023fce:	f884 3036 	strb.w	r3, [r4, #54]	@ 0x36
20023fd2:	6933      	ldr	r3, [r6, #16]
20023fd4:	f8c4 8008 	str.w	r8, [r4, #8]
20023fd8:	1e5a      	subs	r2, r3, #1
20023fda:	4253      	negs	r3, r2
20023fdc:	4153      	adcs	r3, r2
20023fde:	f884 3023 	strb.w	r3, [r4, #35]	@ 0x23
20023fe2:	f1b8 0f00 	cmp.w	r8, #0
20023fe6:	d058      	beq.n	2002409a <HAL_FLASH_Init+0x10a>
20023fe8:	2f00      	cmp	r7, #0
20023fea:	d056      	beq.n	2002409a <HAL_FLASH_Init+0x10a>
20023fec:	683b      	ldr	r3, [r7, #0]
20023fee:	f8c8 3000 	str.w	r3, [r8]
20023ff2:	68a3      	ldr	r3, [r4, #8]
20023ff4:	68fa      	ldr	r2, [r7, #12]
20023ff6:	605a      	str	r2, [r3, #4]
20023ff8:	2210      	movs	r2, #16
20023ffa:	68a3      	ldr	r3, [r4, #8]
20023ffc:	609a      	str	r2, [r3, #8]
20023ffe:	2280      	movs	r2, #128	@ 0x80
20024000:	68a3      	ldr	r3, [r4, #8]
20024002:	60d9      	str	r1, [r3, #12]
20024004:	68a3      	ldr	r3, [r4, #8]
20024006:	611a      	str	r2, [r3, #16]
20024008:	f44f 5280 	mov.w	r2, #4096	@ 0x1000
2002400c:	68a3      	ldr	r3, [r4, #8]
2002400e:	6159      	str	r1, [r3, #20]
20024010:	68a3      	ldr	r3, [r4, #8]
20024012:	6199      	str	r1, [r3, #24]
20024014:	68a3      	ldr	r3, [r4, #8]
20024016:	61d9      	str	r1, [r3, #28]
20024018:	68a3      	ldr	r3, [r4, #8]
2002401a:	621a      	str	r2, [r3, #32]
2002401c:	68a3      	ldr	r3, [r4, #8]
2002401e:	6259      	str	r1, [r3, #36]	@ 0x24
20024020:	b1c0      	cbz	r0, 20024054 <HAL_FLASH_Init+0xc4>
20024022:	f06f 437f 	mvn.w	r3, #4278190080	@ 0xff000000
20024026:	4298      	cmp	r0, r3
20024028:	d014      	beq.n	20024054 <HAL_FLASH_Init+0xc4>
2002402a:	2601      	movs	r6, #1
2002402c:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
20024030:	2b00      	cmp	r3, #0
20024032:	d13d      	bne.n	200240b0 <HAL_FLASH_Init+0x120>
20024034:	2e00      	cmp	r6, #0
20024036:	d15a      	bne.n	200240ee <HAL_FLASH_Init+0x15e>
20024038:	4620      	mov	r0, r4
2002403a:	f7ff faae 	bl	2002359a <HAL_FLASH_RELEASE_DPD>
2002403e:	4630      	mov	r0, r6
20024040:	f7fd ff5b 	bl	20021efa <HAL_Delay_us>
20024044:	2032      	movs	r0, #50	@ 0x32
20024046:	f7fd ff58 	bl	20021efa <HAL_Delay_us>
2002404a:	4620      	mov	r0, r4
2002404c:	f7ff ff2a 	bl	20023ea4 <HAL_QSPI_READ_ID>
20024050:	4605      	mov	r5, r0
20024052:	e04c      	b.n	200240ee <HAL_FLASH_Init+0x15e>
20024054:	2101      	movs	r1, #1
20024056:	4620      	mov	r0, r4
20024058:	f7fe fe4b 	bl	20022cf2 <HAL_FLASH_SET_TXSLOT>
2002405c:	4ba7      	ldr	r3, [pc, #668]	@ (200242fc <HAL_FLASH_Init+0x36c>)
2002405e:	69a2      	ldr	r2, [r4, #24]
20024060:	4620      	mov	r0, r4
20024062:	429a      	cmp	r2, r3
20024064:	f04f 0200 	mov.w	r2, #0
20024068:	bf8c      	ite	hi
2002406a:	2101      	movhi	r1, #1
2002406c:	4611      	movls	r1, r2
2002406e:	f7ff fa85 	bl	2002357c <HAL_QSPI_SET_CLK_INV>
20024072:	4620      	mov	r0, r4
20024074:	f89d 1038 	ldrb.w	r1, [sp, #56]	@ 0x38
20024078:	f7fe fe42 	bl	20022d00 <HAL_FLASH_SET_CLK_rom>
2002407c:	f894 3035 	ldrb.w	r3, [r4, #53]	@ 0x35
20024080:	b12b      	cbz	r3, 2002408e <HAL_FLASH_Init+0xfe>
20024082:	2b01      	cmp	r3, #1
20024084:	d110      	bne.n	200240a8 <HAL_FLASH_Init+0x118>
20024086:	2100      	movs	r1, #0
20024088:	4620      	mov	r0, r4
2002408a:	f7fe ff51 	bl	20022f30 <HAL_FLASH_SET_DUAL_MODE>
2002408e:	2101      	movs	r1, #1
20024090:	4620      	mov	r0, r4
20024092:	f7fe feda 	bl	20022e4a <HAL_FLASH_ENABLE_QSPI>
20024096:	2600      	movs	r6, #0
20024098:	e7c8      	b.n	2002402c <HAL_FLASH_Init+0x9c>
2002409a:	2d00      	cmp	r5, #0
2002409c:	d0de      	beq.n	2002405c <HAL_FLASH_Init+0xcc>
2002409e:	f06f 437f 	mvn.w	r3, #4278190080	@ 0xff000000
200240a2:	429d      	cmp	r5, r3
200240a4:	d1c1      	bne.n	2002402a <HAL_FLASH_Init+0x9a>
200240a6:	e7d9      	b.n	2002405c <HAL_FLASH_Init+0xcc>
200240a8:	2b02      	cmp	r3, #2
200240aa:	d1f0      	bne.n	2002408e <HAL_FLASH_Init+0xfe>
200240ac:	2101      	movs	r1, #1
200240ae:	e7eb      	b.n	20024088 <HAL_FLASH_Init+0xf8>
200240b0:	6822      	ldr	r2, [r4, #0]
200240b2:	2700      	movs	r7, #0
200240b4:	6893      	ldr	r3, [r2, #8]
200240b6:	4639      	mov	r1, r7
200240b8:	f043 7370 	orr.w	r3, r3, #62914560	@ 0x3c00000
200240bc:	6093      	str	r3, [r2, #8]
200240be:	2301      	movs	r3, #1
200240c0:	463a      	mov	r2, r7
200240c2:	4620      	mov	r0, r4
200240c4:	e9cd 7303 	strd	r7, r3, [sp, #12]
200240c8:	e9cd 7701 	strd	r7, r7, [sp, #4]
200240cc:	463b      	mov	r3, r7
200240ce:	9700      	str	r7, [sp, #0]
200240d0:	f7fe fe1f 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
200240d4:	463a      	mov	r2, r7
200240d6:	21ff      	movs	r1, #255	@ 0xff
200240d8:	4620      	mov	r0, r4
200240da:	f7fe fdd5 	bl	20022c88 <HAL_FLASH_SET_CMD>
200240de:	4638      	mov	r0, r7
200240e0:	f7fd ff0b 	bl	20021efa <HAL_Delay_us>
200240e4:	20c8      	movs	r0, #200	@ 0xc8
200240e6:	f7fd ff08 	bl	20021efa <HAL_Delay_us>
200240ea:	2e00      	cmp	r6, #0
200240ec:	d0ad      	beq.n	2002404a <HAL_FLASH_Init+0xba>
200240ee:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
200240f2:	b2ef      	uxtb	r7, r5
200240f4:	f3c5 2807 	ubfx	r8, r5, #8, #8
200240f8:	6325      	str	r5, [r4, #48]	@ 0x30
200240fa:	f3c5 4507 	ubfx	r5, r5, #16, #8
200240fe:	4642      	mov	r2, r8
20024100:	4629      	mov	r1, r5
20024102:	4638      	mov	r0, r7
20024104:	b3ab      	cbz	r3, 20024172 <HAL_FLASH_Init+0x1e2>
20024106:	f001 f973 	bl	200253f0 <spi_nand_get_cmd_by_id>
2002410a:	60e0      	str	r0, [r4, #12]
2002410c:	bba0      	cbnz	r0, 20024178 <HAL_FLASH_Init+0x1e8>
2002410e:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
20024112:	b32b      	cbz	r3, 20024160 <HAL_FLASH_Init+0x1d0>
20024114:	2108      	movs	r1, #8
20024116:	4620      	mov	r0, r4
20024118:	f7ff fb03 	bl	20023722 <nand_read_id>
2002411c:	f3c0 2807 	ubfx	r8, r0, #8, #8
20024120:	f3c0 4507 	ubfx	r5, r0, #16, #8
20024124:	b2c7      	uxtb	r7, r0
20024126:	6320      	str	r0, [r4, #48]	@ 0x30
20024128:	4642      	mov	r2, r8
2002412a:	4629      	mov	r1, r5
2002412c:	4638      	mov	r0, r7
2002412e:	f001 f95f 	bl	200253f0 <spi_nand_get_cmd_by_id>
20024132:	60e0      	str	r0, [r4, #12]
20024134:	bb00      	cbnz	r0, 20024178 <HAL_FLASH_Init+0x1e8>
20024136:	210f      	movs	r1, #15
20024138:	4620      	mov	r0, r4
2002413a:	f7ff faf2 	bl	20023722 <nand_read_id>
2002413e:	f3c0 2807 	ubfx	r8, r0, #8, #8
20024142:	f3c0 4507 	ubfx	r5, r0, #16, #8
20024146:	b2c7      	uxtb	r7, r0
20024148:	6320      	str	r0, [r4, #48]	@ 0x30
2002414a:	4642      	mov	r2, r8
2002414c:	4629      	mov	r1, r5
2002414e:	4638      	mov	r0, r7
20024150:	f001 f94e 	bl	200253f0 <spi_nand_get_cmd_by_id>
20024154:	60e0      	str	r0, [r4, #12]
20024156:	b978      	cbnz	r0, 20024178 <HAL_FLASH_Init+0x1e8>
20024158:	f001 f960 	bl	2002541c <spi_nand_get_default_ctable>
2002415c:	60e0      	str	r0, [r4, #12]
2002415e:	b958      	cbnz	r0, 20024178 <HAL_FLASH_Init+0x1e8>
20024160:	2100      	movs	r1, #0
20024162:	4620      	mov	r0, r4
20024164:	f7fe fe71 	bl	20022e4a <HAL_FLASH_ENABLE_QSPI>
20024168:	2300      	movs	r3, #0
2002416a:	e9c4 330e 	strd	r3, r3, [r4, #56]	@ 0x38
2002416e:	2001      	movs	r0, #1
20024170:	e04c      	b.n	2002420c <HAL_FLASH_Init+0x27c>
20024172:	f001 f8f5 	bl	20025360 <spi_flash_get_cmd_by_id>
20024176:	e7c8      	b.n	2002410a <HAL_FLASH_Init+0x17a>
20024178:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
2002417c:	4642      	mov	r2, r8
2002417e:	4629      	mov	r1, r5
20024180:	4638      	mov	r0, r7
20024182:	2b00      	cmp	r3, #0
20024184:	d045      	beq.n	20024212 <HAL_FLASH_Init+0x282>
20024186:	f001 f957 	bl	20025438 <spi_nand_get_size_by_id>
2002418a:	4642      	mov	r2, r8
2002418c:	4629      	mov	r1, r5
2002418e:	4681      	mov	r9, r0
20024190:	4638      	mov	r0, r7
20024192:	f001 f95b 	bl	2002544c <spi_nand_get_plane_select_flag>
20024196:	4642      	mov	r2, r8
20024198:	4629      	mov	r1, r5
2002419a:	f884 0027 	strb.w	r0, [r4, #39]	@ 0x27
2002419e:	4638      	mov	r0, r7
200241a0:	f001 f95d 	bl	2002545e <spi_nand_get_big_page_flag>
200241a4:	4642      	mov	r2, r8
200241a6:	f884 0024 	strb.w	r0, [r4, #36]	@ 0x24
200241aa:	4629      	mov	r1, r5
200241ac:	4638      	mov	r0, r7
200241ae:	f001 f95f 	bl	20025470 <spi_nand_get_ecc_mode>
200241b2:	f894 3024 	ldrb.w	r3, [r4, #36]	@ 0x24
200241b6:	ea43 1300 	orr.w	r3, r3, r0, lsl #4
200241ba:	f884 3024 	strb.w	r3, [r4, #36]	@ 0x24
200241be:	f1b9 0f00 	cmp.w	r9, #0
200241c2:	d003      	beq.n	200241cc <HAL_FLASH_Init+0x23c>
200241c4:	f8c4 903c 	str.w	r9, [r4, #60]	@ 0x3c
200241c8:	f8c4 9014 	str.w	r9, [r4, #20]
200241cc:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
200241d0:	2b00      	cmp	r3, #0
200241d2:	d173      	bne.n	200242bc <HAL_FLASH_Init+0x32c>
200241d4:	2e00      	cmp	r6, #0
200241d6:	d16e      	bne.n	200242b6 <HAL_FLASH_Init+0x326>
200241d8:	4620      	mov	r0, r4
200241da:	f7ff f93f 	bl	2002345c <HAL_FLASH_CLR_PROTECT>
200241de:	6963      	ldr	r3, [r4, #20]
200241e0:	f1b3 7f80 	cmp.w	r3, #16777216	@ 0x1000000
200241e4:	d938      	bls.n	20024258 <HAL_FLASH_Init+0x2c8>
200241e6:	4632      	mov	r2, r6
200241e8:	2121      	movs	r1, #33	@ 0x21
200241ea:	4620      	mov	r0, r4
200241ec:	f7fe ffc6 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200241f0:	f894 3020 	ldrb.w	r3, [r4, #32]
200241f4:	b98b      	cbnz	r3, 2002421a <HAL_FLASH_Init+0x28a>
200241f6:	4631      	mov	r1, r6
200241f8:	4620      	mov	r0, r4
200241fa:	f884 6026 	strb.w	r6, [r4, #38]	@ 0x26
200241fe:	f7ff f907 	bl	20023410 <HAL_FLASH_FADDR_SET_QSPI>
20024202:	2107      	movs	r1, #7
20024204:	4620      	mov	r0, r4
20024206:	f7fe fe7b 	bl	20022f00 <HAL_FLASH_SET_ROW_BOUNDARY>
2002420a:	2000      	movs	r0, #0
2002420c:	b007      	add	sp, #28
2002420e:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
20024212:	f001 f8b9 	bl	20025388 <spi_flash_get_size_by_id>
20024216:	4681      	mov	r9, r0
20024218:	e7d1      	b.n	200241be <HAL_FLASH_Init+0x22e>
2002421a:	2101      	movs	r1, #1
2002421c:	4620      	mov	r0, r4
2002421e:	f7ff f8f7 	bl	20023410 <HAL_FLASH_FADDR_SET_QSPI>
20024222:	f894 9026 	ldrb.w	r9, [r4, #38]	@ 0x26
20024226:	f1b9 0f01 	cmp.w	r9, #1
2002422a:	d1ea      	bne.n	20024202 <HAL_FLASH_Init+0x272>
2002422c:	4642      	mov	r2, r8
2002422e:	4629      	mov	r1, r5
20024230:	4638      	mov	r0, r7
20024232:	f001 f8b3 	bl	2002539c <spi_flash_is_support_dtr>
20024236:	b138      	cbz	r0, 20024248 <HAL_FLASH_Init+0x2b8>
20024238:	4620      	mov	r0, r4
2002423a:	f7ff fe85 	bl	20023f48 <HAL_NOR_DTR_CAL>
2002423e:	4649      	mov	r1, r9
20024240:	4620      	mov	r0, r4
20024242:	f7ff fe3a 	bl	20023eba <HAL_NOR_CFG_DTR>
20024246:	e7dc      	b.n	20024202 <HAL_FLASH_Init+0x272>
20024248:	4632      	mov	r2, r6
2002424a:	4631      	mov	r1, r6
2002424c:	4620      	mov	r0, r4
2002424e:	f7fe feb5 	bl	20022fbc <HAL_MPI_CFG_DTR>
20024252:	f884 6026 	strb.w	r6, [r4, #38]	@ 0x26
20024256:	e7d4      	b.n	20024202 <HAL_FLASH_Init+0x272>
20024258:	f894 3020 	ldrb.w	r3, [r4, #32]
2002425c:	b933      	cbnz	r3, 2002426c <HAL_FLASH_Init+0x2dc>
2002425e:	4631      	mov	r1, r6
20024260:	4620      	mov	r0, r4
20024262:	f884 6026 	strb.w	r6, [r4, #38]	@ 0x26
20024266:	f7ff f8c8 	bl	200233fa <HAL_FLASH_SET_QUAL_SPI>
2002426a:	e7ce      	b.n	2002420a <HAL_FLASH_Init+0x27a>
2002426c:	2101      	movs	r1, #1
2002426e:	4620      	mov	r0, r4
20024270:	f7ff f8c3 	bl	200233fa <HAL_FLASH_SET_QUAL_SPI>
20024274:	f894 9026 	ldrb.w	r9, [r4, #38]	@ 0x26
20024278:	f1b9 0f01 	cmp.w	r9, #1
2002427c:	d115      	bne.n	200242aa <HAL_FLASH_Init+0x31a>
2002427e:	4642      	mov	r2, r8
20024280:	4629      	mov	r1, r5
20024282:	4638      	mov	r0, r7
20024284:	f001 f88a 	bl	2002539c <spi_flash_is_support_dtr>
20024288:	b138      	cbz	r0, 2002429a <HAL_FLASH_Init+0x30a>
2002428a:	4620      	mov	r0, r4
2002428c:	f7ff fe5c 	bl	20023f48 <HAL_NOR_DTR_CAL>
20024290:	4649      	mov	r1, r9
20024292:	4620      	mov	r0, r4
20024294:	f7ff fe11 	bl	20023eba <HAL_NOR_CFG_DTR>
20024298:	e7b7      	b.n	2002420a <HAL_FLASH_Init+0x27a>
2002429a:	4632      	mov	r2, r6
2002429c:	4631      	mov	r1, r6
2002429e:	4620      	mov	r0, r4
200242a0:	f7fe fe8c 	bl	20022fbc <HAL_MPI_CFG_DTR>
200242a4:	f884 6026 	strb.w	r6, [r4, #38]	@ 0x26
200242a8:	e7af      	b.n	2002420a <HAL_FLASH_Init+0x27a>
200242aa:	4632      	mov	r2, r6
200242ac:	4631      	mov	r1, r6
200242ae:	4620      	mov	r0, r4
200242b0:	f7fe fe84 	bl	20022fbc <HAL_MPI_CFG_DTR>
200242b4:	e7a9      	b.n	2002420a <HAL_FLASH_Init+0x27a>
200242b6:	f884 3026 	strb.w	r3, [r4, #38]	@ 0x26
200242ba:	e7a6      	b.n	2002420a <HAL_FLASH_Init+0x27a>
200242bc:	2101      	movs	r1, #1
200242be:	4620      	mov	r0, r4
200242c0:	f7fe fcbd 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200242c4:	68e3      	ldr	r3, [r4, #12]
200242c6:	2102      	movs	r1, #2
200242c8:	791a      	ldrb	r2, [r3, #4]
200242ca:	4620      	mov	r0, r4
200242cc:	f7fe ff56 	bl	2002317c <HAL_FLASH_ISSUE_CMD>
200242d0:	4620      	mov	r0, r4
200242d2:	f7fe fd0a 	bl	20022cea <HAL_FLASH_READ32>
200242d6:	4605      	mov	r5, r0
200242d8:	200a      	movs	r0, #10
200242da:	f7fd fe0e 	bl	20021efa <HAL_Delay_us>
200242de:	07eb      	lsls	r3, r5, #31
200242e0:	d4ec      	bmi.n	200242bc <HAL_FLASH_Init+0x32c>
200242e2:	4620      	mov	r0, r4
200242e4:	f7ff fb55 	bl	20023992 <nand_clear_status>
200242e8:	f894 3020 	ldrb.w	r3, [r4, #32]
200242ec:	2b02      	cmp	r3, #2
200242ee:	d18c      	bne.n	2002420a <HAL_FLASH_Init+0x27a>
200242f0:	2101      	movs	r1, #1
200242f2:	4620      	mov	r0, r4
200242f4:	f7ff fb1c 	bl	20023930 <HAL_NAND_EN_QUAL>
200242f8:	e787      	b.n	2002420a <HAL_FLASH_Init+0x27a>
200242fa:	bf00      	nop
200242fc:	05f5e100 	.word	0x05f5e100

20024300 <HAL_Delay_us_psram>:
20024300:	b51f      	push	{r0, r1, r2, r3, r4, lr}
20024302:	9001      	str	r0, [sp, #4]
20024304:	9b01      	ldr	r3, [sp, #4]
20024306:	4c11      	ldr	r4, [pc, #68]	@ (2002434c <HAL_Delay_us_psram+0x4c>)
20024308:	b10b      	cbz	r3, 2002430e <HAL_Delay_us_psram+0xe>
2002430a:	6820      	ldr	r0, [r4, #0]
2002430c:	b940      	cbnz	r0, 20024320 <HAL_Delay_us_psram+0x20>
2002430e:	2000      	movs	r0, #0
20024310:	f000 fe76 	bl	20025000 <HAL_RCC_GetHCLKFreq>
20024314:	4b0e      	ldr	r3, [pc, #56]	@ (20024350 <HAL_Delay_us_psram+0x50>)
20024316:	fbb0 f0f3 	udiv	r0, r0, r3
2002431a:	9b01      	ldr	r3, [sp, #4]
2002431c:	6020      	str	r0, [r4, #0]
2002431e:	b19b      	cbz	r3, 20024348 <HAL_Delay_us_psram+0x48>
20024320:	2830      	cmp	r0, #48	@ 0x30
20024322:	bf82      	ittt	hi
20024324:	9b01      	ldrhi	r3, [sp, #4]
20024326:	f103 33ff 	addhi.w	r3, r3, #4294967295
2002432a:	9301      	strhi	r3, [sp, #4]
2002432c:	9b01      	ldr	r3, [sp, #4]
2002432e:	b15b      	cbz	r3, 20024348 <HAL_Delay_us_psram+0x48>
20024330:	2205      	movs	r2, #5
20024332:	9b01      	ldr	r3, [sp, #4]
20024334:	3b01      	subs	r3, #1
20024336:	4343      	muls	r3, r0
20024338:	fbb3 f3f2 	udiv	r3, r3, r2
2002433c:	9303      	str	r3, [sp, #12]
2002433e:	9b03      	ldr	r3, [sp, #12]
20024340:	1e5a      	subs	r2, r3, #1
20024342:	9203      	str	r2, [sp, #12]
20024344:	2b00      	cmp	r3, #0
20024346:	d1fa      	bne.n	2002433e <HAL_Delay_us_psram+0x3e>
20024348:	b004      	add	sp, #16
2002434a:	bd10      	pop	{r4, pc}
2002434c:	20049f60 	.word	0x20049f60
20024350:	000f4240 	.word	0x000f4240

20024354 <HAL_MPI_OPSRAM_CAL_DELAY>:
20024354:	b570      	push	{r4, r5, r6, lr}
20024356:	460e      	mov	r6, r1
20024358:	4615      	mov	r5, r2
2002435a:	4604      	mov	r4, r0
2002435c:	b358      	cbz	r0, 200243b6 <HAL_MPI_OPSRAM_CAL_DELAY+0x62>
2002435e:	2202      	movs	r2, #2
20024360:	6803      	ldr	r3, [r0, #0]
20024362:	60da      	str	r2, [r3, #12]
20024364:	6802      	ldr	r2, [r0, #0]
20024366:	6d93      	ldr	r3, [r2, #88]	@ 0x58
20024368:	f023 7300 	bic.w	r3, r3, #33554432	@ 0x2000000
2002436c:	6593      	str	r3, [r2, #88]	@ 0x58
2002436e:	6802      	ldr	r2, [r0, #0]
20024370:	2000      	movs	r0, #0
20024372:	f8d2 3094 	ldr.w	r3, [r2, #148]	@ 0x94
20024376:	f043 4300 	orr.w	r3, r3, #2147483648	@ 0x80000000
2002437a:	f8c2 3094 	str.w	r3, [r2, #148]	@ 0x94
2002437e:	f7ff ffbf 	bl	20024300 <HAL_Delay_us_psram>
20024382:	2014      	movs	r0, #20
20024384:	f7ff ffbc 	bl	20024300 <HAL_Delay_us_psram>
20024388:	6820      	ldr	r0, [r4, #0]
2002438a:	f8d0 3094 	ldr.w	r3, [r0, #148]	@ 0x94
2002438e:	05db      	lsls	r3, r3, #23
20024390:	d5fb      	bpl.n	2002438a <HAL_MPI_OPSRAM_CAL_DELAY+0x36>
20024392:	f8d0 3094 	ldr.w	r3, [r0, #148]	@ 0x94
20024396:	f8d0 2094 	ldr.w	r2, [r0, #148]	@ 0x94
2002439a:	b2db      	uxtb	r3, r3
2002439c:	f022 4200 	bic.w	r2, r2, #2147483648	@ 0x80000000
200243a0:	f8c0 2094 	str.w	r2, [r0, #148]	@ 0x94
200243a4:	1e5a      	subs	r2, r3, #1
200243a6:	7032      	strb	r2, [r6, #0]
200243a8:	2201      	movs	r2, #1
200243aa:	2000      	movs	r0, #0
200243ac:	3b04      	subs	r3, #4
200243ae:	702b      	strb	r3, [r5, #0]
200243b0:	6823      	ldr	r3, [r4, #0]
200243b2:	60da      	str	r2, [r3, #12]
200243b4:	bd70      	pop	{r4, r5, r6, pc}
200243b6:	2001      	movs	r0, #1
200243b8:	e7fc      	b.n	200243b4 <HAL_MPI_OPSRAM_CAL_DELAY+0x60>
	...

200243bc <HAL_SPI_PSRAM_Init>:
200243bc:	b537      	push	{r0, r1, r2, r4, r5, lr}
200243be:	4614      	mov	r4, r2
200243c0:	4605      	mov	r5, r0
200243c2:	2800      	cmp	r0, #0
200243c4:	d043      	beq.n	2002444e <HAL_SPI_PSRAM_Init+0x92>
200243c6:	2900      	cmp	r1, #0
200243c8:	d041      	beq.n	2002444e <HAL_SPI_PSRAM_Init+0x92>
200243ca:	f7fe fbbf 	bl	20022b4c <HAL_QSPI_Init>
200243ce:	4628      	mov	r0, r5
200243d0:	b2e1      	uxtb	r1, r4
200243d2:	f7fe fc95 	bl	20022d00 <HAL_FLASH_SET_CLK_rom>
200243d6:	4628      	mov	r0, r5
200243d8:	f7ff fd54 	bl	20023e84 <HAL_QSPI_GET_CLK>
200243dc:	4b1d      	ldr	r3, [pc, #116]	@ (20024454 <HAL_SPI_PSRAM_Init+0x98>)
200243de:	4298      	cmp	r0, r3
200243e0:	d930      	bls.n	20024444 <HAL_SPI_PSRAM_Init+0x88>
200243e2:	4b1d      	ldr	r3, [pc, #116]	@ (20024458 <HAL_SPI_PSRAM_Init+0x9c>)
200243e4:	4298      	cmp	r0, r3
200243e6:	d92f      	bls.n	20024448 <HAL_SPI_PSRAM_Init+0x8c>
200243e8:	4b1c      	ldr	r3, [pc, #112]	@ (2002445c <HAL_SPI_PSRAM_Init+0xa0>)
200243ea:	4298      	cmp	r0, r3
200243ec:	d922      	bls.n	20024434 <HAL_SPI_PSRAM_Init+0x78>
200243ee:	f240 34b6 	movw	r4, #950	@ 0x3b6
200243f2:	f240 4374 	movw	r3, #1140	@ 0x474
200243f6:	4a1a      	ldr	r2, [pc, #104]	@ (20024460 <HAL_SPI_PSRAM_Init+0xa4>)
200243f8:	4290      	cmp	r0, r2
200243fa:	bf88      	it	hi
200243fc:	461c      	movhi	r4, r3
200243fe:	2200      	movs	r2, #0
20024400:	2101      	movs	r1, #1
20024402:	4628      	mov	r0, r5
20024404:	f7ff f8ba 	bl	2002357c <HAL_QSPI_SET_CLK_INV>
20024408:	2100      	movs	r1, #0
2002440a:	4622      	mov	r2, r4
2002440c:	2302      	movs	r3, #2
2002440e:	4628      	mov	r0, r5
20024410:	9100      	str	r1, [sp, #0]
20024412:	f7fe fd60 	bl	20022ed6 <HAL_FLASH_SET_CS_TIME>
20024416:	4604      	mov	r4, r0
20024418:	b948      	cbnz	r0, 2002442e <HAL_SPI_PSRAM_Init+0x72>
2002441a:	2106      	movs	r1, #6
2002441c:	4628      	mov	r0, r5
2002441e:	f7fe fd6f 	bl	20022f00 <HAL_FLASH_SET_ROW_BOUNDARY>
20024422:	4604      	mov	r4, r0
20024424:	b918      	cbnz	r0, 2002442e <HAL_SPI_PSRAM_Init+0x72>
20024426:	2101      	movs	r1, #1
20024428:	4628      	mov	r0, r5
2002442a:	f7fe fd0e 	bl	20022e4a <HAL_FLASH_ENABLE_QSPI>
2002442e:	4620      	mov	r0, r4
20024430:	b003      	add	sp, #12
20024432:	bd30      	pop	{r4, r5, pc}
20024434:	4b0b      	ldr	r3, [pc, #44]	@ (20024464 <HAL_SPI_PSRAM_Init+0xa8>)
20024436:	f44f 743e 	mov.w	r4, #760	@ 0x2f8
2002443a:	4298      	cmp	r0, r3
2002443c:	d8df      	bhi.n	200243fe <HAL_SPI_PSRAM_Init+0x42>
2002443e:	2200      	movs	r2, #0
20024440:	4611      	mov	r1, r2
20024442:	e7de      	b.n	20024402 <HAL_SPI_PSRAM_Init+0x46>
20024444:	24b4      	movs	r4, #180	@ 0xb4
20024446:	e7fa      	b.n	2002443e <HAL_SPI_PSRAM_Init+0x82>
20024448:	f44f 74be 	mov.w	r4, #380	@ 0x17c
2002444c:	e7f7      	b.n	2002443e <HAL_SPI_PSRAM_Init+0x82>
2002444e:	2401      	movs	r4, #1
20024450:	e7ed      	b.n	2002442e <HAL_SPI_PSRAM_Init+0x72>
20024452:	bf00      	nop
20024454:	016e3600 	.word	0x016e3600
20024458:	02dc6c00 	.word	0x02dc6c00
2002445c:	05b8d800 	.word	0x05b8d800
20024460:	07270e00 	.word	0x07270e00
20024464:	03938700 	.word	0x03938700

20024468 <HAL_MPI_MR_WRITE>:
20024468:	b5f0      	push	{r4, r5, r6, r7, lr}
2002446a:	460e      	mov	r6, r1
2002446c:	4617      	mov	r7, r2
2002446e:	4605      	mov	r5, r0
20024470:	b087      	sub	sp, #28
20024472:	b1d8      	cbz	r0, 200244ac <HAL_MPI_MR_WRITE+0x44>
20024474:	2207      	movs	r2, #7
20024476:	2400      	movs	r4, #0
20024478:	2303      	movs	r3, #3
2002447a:	e9cd 2203 	strd	r2, r2, [sp, #12]
2002447e:	2101      	movs	r1, #1
20024480:	e9cd 4301 	strd	r4, r3, [sp, #4]
20024484:	9400      	str	r4, [sp, #0]
20024486:	4623      	mov	r3, r4
20024488:	f7fe fc43 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
2002448c:	2102      	movs	r1, #2
2002448e:	4628      	mov	r0, r5
20024490:	f7fe fbd5 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20024494:	4639      	mov	r1, r7
20024496:	4628      	mov	r0, r5
20024498:	f7fe fbca 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
2002449c:	4632      	mov	r2, r6
2002449e:	21c0      	movs	r1, #192	@ 0xc0
200244a0:	4628      	mov	r0, r5
200244a2:	f7fe fbf1 	bl	20022c88 <HAL_FLASH_SET_CMD>
200244a6:	4620      	mov	r0, r4
200244a8:	b007      	add	sp, #28
200244aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
200244ac:	2001      	movs	r0, #1
200244ae:	e7fb      	b.n	200244a8 <HAL_MPI_MR_WRITE+0x40>

200244b0 <HAL_MPI_SET_FIXLAT>:
200244b0:	e92d 41ff 	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr}
200244b4:	460c      	mov	r4, r1
200244b6:	4616      	mov	r6, r2
200244b8:	461f      	mov	r7, r3
200244ba:	4605      	mov	r5, r0
200244bc:	2800      	cmp	r0, #0
200244be:	d040      	beq.n	20024542 <HAL_MPI_SET_FIXLAT+0x92>
200244c0:	466b      	mov	r3, sp
200244c2:	4a21      	ldr	r2, [pc, #132]	@ (20024548 <HAL_MPI_SET_FIXLAT+0x98>)
200244c4:	6810      	ldr	r0, [r2, #0]
200244c6:	6851      	ldr	r1, [r2, #4]
200244c8:	c303      	stmia	r3!, {r0, r1}
200244ca:	6890      	ldr	r0, [r2, #8]
200244cc:	68d1      	ldr	r1, [r2, #12]
200244ce:	c303      	stmia	r3!, {r0, r1}
200244d0:	4628      	mov	r0, r5
200244d2:	b2e1      	uxtb	r1, r4
200244d4:	f7fe fd3a 	bl	20022f4c <HAL_MPI_EN_FIXLAT>
200244d8:	f107 0310 	add.w	r3, r7, #16
200244dc:	446b      	add	r3, sp
200244de:	f813 8c08 	ldrb.w	r8, [r3, #-8]
200244e2:	ea4f 1848 	mov.w	r8, r8, lsl #5
200244e6:	fa5f f888 	uxtb.w	r8, r8
200244ea:	b30c      	cbz	r4, 20024530 <HAL_MPI_SET_FIXLAT+0x80>
200244ec:	ab04      	add	r3, sp, #16
200244ee:	eb03 0356 	add.w	r3, r3, r6, lsr #1
200244f2:	f813 4c10 	ldrb.w	r4, [r3, #-16]
200244f6:	00a4      	lsls	r4, r4, #2
200244f8:	f044 0421 	orr.w	r4, r4, #33	@ 0x21
200244fc:	b264      	sxtb	r4, r4
200244fe:	f004 02fd 	and.w	r2, r4, #253	@ 0xfd
20024502:	2100      	movs	r1, #0
20024504:	4628      	mov	r0, r5
20024506:	f7ff ffaf 	bl	20024468 <HAL_MPI_MR_WRITE>
2002450a:	1e71      	subs	r1, r6, #1
2002450c:	4628      	mov	r0, r5
2002450e:	b249      	sxtb	r1, r1
20024510:	f7fe fd7a 	bl	20023008 <HAL_MPI_MODIFY_RCMD_DELAY>
20024514:	4642      	mov	r2, r8
20024516:	2104      	movs	r1, #4
20024518:	4628      	mov	r0, r5
2002451a:	f7ff ffa5 	bl	20024468 <HAL_MPI_MR_WRITE>
2002451e:	1e79      	subs	r1, r7, #1
20024520:	4628      	mov	r0, r5
20024522:	b249      	sxtb	r1, r1
20024524:	f7fe fd79 	bl	2002301a <HAL_MPI_MODIFY_WCMD_DELAY>
20024528:	2000      	movs	r0, #0
2002452a:	b004      	add	sp, #16
2002452c:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20024530:	f106 0310 	add.w	r3, r6, #16
20024534:	446b      	add	r3, sp
20024536:	f813 4c10 	ldrb.w	r4, [r3, #-16]
2002453a:	00a4      	lsls	r4, r4, #2
2002453c:	f044 0401 	orr.w	r4, r4, #1
20024540:	e7dc      	b.n	200244fc <HAL_MPI_SET_FIXLAT+0x4c>
20024542:	2001      	movs	r0, #1
20024544:	e7f1      	b.n	2002452a <HAL_MPI_SET_FIXLAT+0x7a>
20024546:	bf00      	nop
20024548:	2002b880 	.word	0x2002b880

2002454c <HAL_LEGACY_MR_WRITE>:
2002454c:	b5f0      	push	{r4, r5, r6, r7, lr}
2002454e:	460e      	mov	r6, r1
20024550:	4617      	mov	r7, r2
20024552:	4605      	mov	r5, r0
20024554:	b087      	sub	sp, #28
20024556:	b1d8      	cbz	r0, 20024590 <HAL_LEGACY_MR_WRITE+0x44>
20024558:	2207      	movs	r2, #7
2002455a:	2400      	movs	r4, #0
2002455c:	2302      	movs	r3, #2
2002455e:	e9cd 2203 	strd	r2, r2, [sp, #12]
20024562:	2101      	movs	r1, #1
20024564:	e9cd 4301 	strd	r4, r3, [sp, #4]
20024568:	9400      	str	r4, [sp, #0]
2002456a:	4623      	mov	r3, r4
2002456c:	f7fe fbd1 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
20024570:	2104      	movs	r1, #4
20024572:	4628      	mov	r0, r5
20024574:	f7fe fb63 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
20024578:	4639      	mov	r1, r7
2002457a:	4628      	mov	r0, r5
2002457c:	f7fe fb58 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
20024580:	4632      	mov	r2, r6
20024582:	21c0      	movs	r1, #192	@ 0xc0
20024584:	4628      	mov	r0, r5
20024586:	f7fe fb7f 	bl	20022c88 <HAL_FLASH_SET_CMD>
2002458a:	4620      	mov	r0, r4
2002458c:	b007      	add	sp, #28
2002458e:	bdf0      	pop	{r4, r5, r6, r7, pc}
20024590:	2001      	movs	r0, #1
20024592:	e7fb      	b.n	2002458c <HAL_LEGACY_MR_WRITE+0x40>

20024594 <HAL_LEGACY_CFG_READ>:
20024594:	b530      	push	{r4, r5, lr}
20024596:	4605      	mov	r5, r0
20024598:	b085      	sub	sp, #20
2002459a:	b1a0      	cbz	r0, 200245c6 <HAL_LEGACY_CFG_READ+0x32>
2002459c:	2400      	movs	r4, #0
2002459e:	2107      	movs	r1, #7
200245a0:	2302      	movs	r3, #2
200245a2:	f890 2025 	ldrb.w	r2, [r0, #37]	@ 0x25
200245a6:	e9cd 1102 	strd	r1, r1, [sp, #8]
200245aa:	0052      	lsls	r2, r2, #1
200245ac:	e9cd 4300 	strd	r4, r3, [sp]
200245b0:	b252      	sxtb	r2, r2
200245b2:	4623      	mov	r3, r4
200245b4:	f7fe faf6 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200245b8:	4621      	mov	r1, r4
200245ba:	4628      	mov	r0, r5
200245bc:	f7fe fae7 	bl	20022b8e <HAL_FLASH_SET_AHB_RCMD>
200245c0:	4620      	mov	r0, r4
200245c2:	b005      	add	sp, #20
200245c4:	bd30      	pop	{r4, r5, pc}
200245c6:	2001      	movs	r0, #1
200245c8:	e7fb      	b.n	200245c2 <HAL_LEGACY_CFG_READ+0x2e>

200245ca <HAL_LEGACY_CFG_WRITE>:
200245ca:	b530      	push	{r4, r5, lr}
200245cc:	4605      	mov	r5, r0
200245ce:	b085      	sub	sp, #20
200245d0:	b190      	cbz	r0, 200245f8 <HAL_LEGACY_CFG_WRITE+0x2e>
200245d2:	2107      	movs	r1, #7
200245d4:	2400      	movs	r4, #0
200245d6:	2302      	movs	r3, #2
200245d8:	e9cd 1102 	strd	r1, r1, [sp, #8]
200245dc:	e9cd 4300 	strd	r4, r3, [sp]
200245e0:	4623      	mov	r3, r4
200245e2:	f990 2026 	ldrsb.w	r2, [r0, #38]	@ 0x26
200245e6:	f7fe fb06 	bl	20022bf6 <HAL_FLASH_CFG_AHB_WCMD>
200245ea:	2180      	movs	r1, #128	@ 0x80
200245ec:	4628      	mov	r0, r5
200245ee:	f7fe faf6 	bl	20022bde <HAL_FLASH_SET_AHB_WCMD>
200245f2:	4620      	mov	r0, r4
200245f4:	b005      	add	sp, #20
200245f6:	bd30      	pop	{r4, r5, pc}
200245f8:	2001      	movs	r0, #1
200245fa:	e7fb      	b.n	200245f4 <HAL_LEGACY_CFG_WRITE+0x2a>

200245fc <HAL_PSRAM_RESET>:
200245fc:	b5f0      	push	{r4, r5, r6, r7, lr}
200245fe:	4604      	mov	r4, r0
20024600:	b087      	sub	sp, #28
20024602:	2800      	cmp	r0, #0
20024604:	d03b      	beq.n	2002467e <HAL_PSRAM_RESET+0x82>
20024606:	f890 3023 	ldrb.w	r3, [r0, #35]	@ 0x23
2002460a:	2b05      	cmp	r3, #5
2002460c:	d034      	beq.n	20024678 <HAL_PSRAM_RESET+0x7c>
2002460e:	3b03      	subs	r3, #3
20024610:	2b01      	cmp	r3, #1
20024612:	d82e      	bhi.n	20024672 <HAL_PSRAM_RESET+0x76>
20024614:	2601      	movs	r6, #1
20024616:	2703      	movs	r7, #3
20024618:	2300      	movs	r3, #0
2002461a:	2507      	movs	r5, #7
2002461c:	b276      	sxtb	r6, r6
2002461e:	b27f      	sxtb	r7, r7
20024620:	461a      	mov	r2, r3
20024622:	2101      	movs	r1, #1
20024624:	4620      	mov	r0, r4
20024626:	e9cd 5503 	strd	r5, r5, [sp, #12]
2002462a:	e9cd 5701 	strd	r5, r7, [sp, #4]
2002462e:	9600      	str	r6, [sp, #0]
20024630:	f7fe fb6f 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
20024634:	2200      	movs	r2, #0
20024636:	21ff      	movs	r1, #255	@ 0xff
20024638:	4620      	mov	r0, r4
2002463a:	f7fe fb25 	bl	20022c88 <HAL_FLASH_SET_CMD>
2002463e:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
20024642:	2b05      	cmp	r3, #5
20024644:	d10f      	bne.n	20024666 <HAL_PSRAM_RESET+0x6a>
20024646:	2300      	movs	r3, #0
20024648:	2101      	movs	r1, #1
2002464a:	461a      	mov	r2, r3
2002464c:	4620      	mov	r0, r4
2002464e:	e9cd 5503 	strd	r5, r5, [sp, #12]
20024652:	e9cd 5701 	strd	r5, r7, [sp, #4]
20024656:	9600      	str	r6, [sp, #0]
20024658:	f7fe fb5b 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
2002465c:	2200      	movs	r2, #0
2002465e:	21ff      	movs	r1, #255	@ 0xff
20024660:	4620      	mov	r0, r4
20024662:	f7fe fb11 	bl	20022c88 <HAL_FLASH_SET_CMD>
20024666:	2000      	movs	r0, #0
20024668:	f7fd fc47 	bl	20021efa <HAL_Delay_us>
2002466c:	2003      	movs	r0, #3
2002466e:	f7fd fc44 	bl	20021efa <HAL_Delay_us>
20024672:	2000      	movs	r0, #0
20024674:	b007      	add	sp, #28
20024676:	bdf0      	pop	{r4, r5, r6, r7, pc}
20024678:	2603      	movs	r6, #3
2002467a:	2702      	movs	r7, #2
2002467c:	e7cc      	b.n	20024618 <HAL_PSRAM_RESET+0x1c>
2002467e:	2001      	movs	r0, #1
20024680:	e7f8      	b.n	20024674 <HAL_PSRAM_RESET+0x78>
	...

20024684 <HAL_OPI_PSRAM_Init>:
20024684:	b530      	push	{r4, r5, lr}
20024686:	4604      	mov	r4, r0
20024688:	b085      	sub	sp, #20
2002468a:	2800      	cmp	r0, #0
2002468c:	d06e      	beq.n	2002476c <HAL_OPI_PSRAM_Init+0xe8>
2002468e:	2900      	cmp	r1, #0
20024690:	d06c      	beq.n	2002476c <HAL_OPI_PSRAM_Init+0xe8>
20024692:	f7fe fa5b 	bl	20022b4c <HAL_QSPI_Init>
20024696:	6823      	ldr	r3, [r4, #0]
20024698:	f10d 020e 	add.w	r2, sp, #14
2002469c:	f10d 010f 	add.w	r1, sp, #15
200246a0:	4620      	mov	r0, r4
200246a2:	681d      	ldr	r5, [r3, #0]
200246a4:	f7ff fe56 	bl	20024354 <HAL_MPI_OPSRAM_CAL_DELAY>
200246a8:	2101      	movs	r1, #1
200246aa:	4620      	mov	r0, r4
200246ac:	f7fe fb28 	bl	20022d00 <HAL_FLASH_SET_CLK_rom>
200246b0:	4620      	mov	r0, r4
200246b2:	f7ff fbe7 	bl	20023e84 <HAL_QSPI_GET_CLK>
200246b6:	4b2e      	ldr	r3, [pc, #184]	@ (20024770 <HAL_OPI_PSRAM_Init+0xec>)
200246b8:	f005 0501 	and.w	r5, r5, #1
200246bc:	4298      	cmp	r0, r3
200246be:	d836      	bhi.n	2002472e <HAL_OPI_PSRAM_Init+0xaa>
200246c0:	2314      	movs	r3, #20
200246c2:	2103      	movs	r1, #3
200246c4:	f88d 300e 	strb.w	r3, [sp, #14]
200246c8:	f88d 300f 	strb.w	r3, [sp, #15]
200246cc:	4608      	mov	r0, r1
200246ce:	2300      	movs	r3, #0
200246d0:	22b4      	movs	r2, #180	@ 0xb4
200246d2:	f884 1025 	strb.w	r1, [r4, #37]	@ 0x25
200246d6:	f884 1026 	strb.w	r1, [r4, #38]	@ 0x26
200246da:	2106      	movs	r1, #6
200246dc:	9000      	str	r0, [sp, #0]
200246de:	4620      	mov	r0, r4
200246e0:	f7fe fbf9 	bl	20022ed6 <HAL_FLASH_SET_CS_TIME>
200246e4:	2107      	movs	r1, #7
200246e6:	4620      	mov	r0, r4
200246e8:	f7fe fc0a 	bl	20022f00 <HAL_FLASH_SET_ROW_BOUNDARY>
200246ec:	2101      	movs	r1, #1
200246ee:	4620      	mov	r0, r4
200246f0:	f7fe fc3a 	bl	20022f68 <HAL_MPI_ENABLE_DQS>
200246f4:	f89d 100e 	ldrb.w	r1, [sp, #14]
200246f8:	4620      	mov	r0, r4
200246fa:	f7fe fc43 	bl	20022f84 <HAL_MPI_SET_DQS_DELAY>
200246fe:	2200      	movs	r2, #0
20024700:	f89d 100f 	ldrb.w	r1, [sp, #15]
20024704:	4620      	mov	r0, r4
20024706:	f7fe fc49 	bl	20022f9c <HAL_MPI_SET_SCK>
2002470a:	2101      	movs	r1, #1
2002470c:	4620      	mov	r0, r4
2002470e:	f7fe fb9c 	bl	20022e4a <HAL_FLASH_ENABLE_QSPI>
20024712:	2101      	movs	r1, #1
20024714:	4620      	mov	r0, r4
20024716:	f7fe fba6 	bl	20022e66 <HAL_FLASH_ENABLE_OPI>
2002471a:	b92d      	cbnz	r5, 20024728 <HAL_OPI_PSRAM_Init+0xa4>
2002471c:	4b15      	ldr	r3, [pc, #84]	@ (20024774 <HAL_OPI_PSRAM_Init+0xf0>)
2002471e:	681b      	ldr	r3, [r3, #0]
20024720:	f003 0303 	and.w	r3, r3, #3
20024724:	2b03      	cmp	r3, #3
20024726:	d11d      	bne.n	20024764 <HAL_OPI_PSRAM_Init+0xe0>
20024728:	2000      	movs	r0, #0
2002472a:	b005      	add	sp, #20
2002472c:	bd30      	pop	{r4, r5, pc}
2002472e:	4b12      	ldr	r3, [pc, #72]	@ (20024778 <HAL_OPI_PSRAM_Init+0xf4>)
20024730:	4298      	cmp	r0, r3
20024732:	d90b      	bls.n	2002474c <HAL_OPI_PSRAM_Init+0xc8>
20024734:	f103 7337 	add.w	r3, r3, #47972352	@ 0x2dc0000
20024738:	f503 43d8 	add.w	r3, r3, #27648	@ 0x6c00
2002473c:	4298      	cmp	r0, r3
2002473e:	d90b      	bls.n	20024758 <HAL_OPI_PSRAM_Init+0xd4>
20024740:	2107      	movs	r1, #7
20024742:	2014      	movs	r0, #20
20024744:	2308      	movs	r3, #8
20024746:	f240 5232 	movw	r2, #1330	@ 0x532
2002474a:	e7c2      	b.n	200246d2 <HAL_OPI_PSRAM_Init+0x4e>
2002474c:	2105      	movs	r1, #5
2002474e:	200e      	movs	r0, #14
20024750:	2303      	movs	r3, #3
20024752:	f240 32b6 	movw	r2, #950	@ 0x3b6
20024756:	e7bc      	b.n	200246d2 <HAL_OPI_PSRAM_Init+0x4e>
20024758:	2106      	movs	r1, #6
2002475a:	2011      	movs	r0, #17
2002475c:	2305      	movs	r3, #5
2002475e:	f240 4274 	movw	r2, #1140	@ 0x474
20024762:	e7b6      	b.n	200246d2 <HAL_OPI_PSRAM_Init+0x4e>
20024764:	4620      	mov	r0, r4
20024766:	f7ff ff49 	bl	200245fc <HAL_PSRAM_RESET>
2002476a:	e7dd      	b.n	20024728 <HAL_OPI_PSRAM_Init+0xa4>
2002476c:	2001      	movs	r0, #1
2002476e:	e7dc      	b.n	2002472a <HAL_OPI_PSRAM_Init+0xa6>
20024770:	02dc6c01 	.word	0x02dc6c01
20024774:	500c0000 	.word	0x500c0000
20024778:	0e4e1c01 	.word	0x0e4e1c01

2002477c <HAL_LEGACY_PSRAM_Init>:
2002477c:	b5f0      	push	{r4, r5, r6, r7, lr}
2002477e:	4604      	mov	r4, r0
20024780:	b085      	sub	sp, #20
20024782:	2800      	cmp	r0, #0
20024784:	f000 8096 	beq.w	200248b4 <HAL_LEGACY_PSRAM_Init+0x138>
20024788:	2900      	cmp	r1, #0
2002478a:	f000 8093 	beq.w	200248b4 <HAL_LEGACY_PSRAM_Init+0x138>
2002478e:	f7fe f9dd 	bl	20022b4c <HAL_QSPI_Init>
20024792:	6823      	ldr	r3, [r4, #0]
20024794:	f10d 020e 	add.w	r2, sp, #14
20024798:	f10d 010f 	add.w	r1, sp, #15
2002479c:	4620      	mov	r0, r4
2002479e:	681e      	ldr	r6, [r3, #0]
200247a0:	f7ff fdd8 	bl	20024354 <HAL_MPI_OPSRAM_CAL_DELAY>
200247a4:	2101      	movs	r1, #1
200247a6:	4620      	mov	r0, r4
200247a8:	f7fe faaa 	bl	20022d00 <HAL_FLASH_SET_CLK_rom>
200247ac:	4620      	mov	r0, r4
200247ae:	f7ff fb69 	bl	20023e84 <HAL_QSPI_GET_CLK>
200247b2:	4b41      	ldr	r3, [pc, #260]	@ (200248b8 <HAL_LEGACY_PSRAM_Init+0x13c>)
200247b4:	4605      	mov	r5, r0
200247b6:	4298      	cmp	r0, r3
200247b8:	4f40      	ldr	r7, [pc, #256]	@ (200248bc <HAL_LEGACY_PSRAM_Init+0x140>)
200247ba:	f006 0601 	and.w	r6, r6, #1
200247be:	d850      	bhi.n	20024862 <HAL_LEGACY_PSRAM_Init+0xe6>
200247c0:	2314      	movs	r3, #20
200247c2:	2103      	movs	r1, #3
200247c4:	f88d 300e 	strb.w	r3, [sp, #14]
200247c8:	f88d 300f 	strb.w	r3, [sp, #15]
200247cc:	22b4      	movs	r2, #180	@ 0xb4
200247ce:	2300      	movs	r3, #0
200247d0:	9100      	str	r1, [sp, #0]
200247d2:	4620      	mov	r0, r4
200247d4:	2106      	movs	r1, #6
200247d6:	f7fe fb7e 	bl	20022ed6 <HAL_FLASH_SET_CS_TIME>
200247da:	2107      	movs	r1, #7
200247dc:	4620      	mov	r0, r4
200247de:	f7fe fb8f 	bl	20022f00 <HAL_FLASH_SET_ROW_BOUNDARY>
200247e2:	2101      	movs	r1, #1
200247e4:	4620      	mov	r0, r4
200247e6:	f7fe fbbf 	bl	20022f68 <HAL_MPI_ENABLE_DQS>
200247ea:	f89d 100e 	ldrb.w	r1, [sp, #14]
200247ee:	4620      	mov	r0, r4
200247f0:	f7fe fbc8 	bl	20022f84 <HAL_MPI_SET_DQS_DELAY>
200247f4:	2200      	movs	r2, #0
200247f6:	f89d 100f 	ldrb.w	r1, [sp, #15]
200247fa:	4620      	mov	r0, r4
200247fc:	f7fe fbce 	bl	20022f9c <HAL_MPI_SET_SCK>
20024800:	2101      	movs	r1, #1
20024802:	4620      	mov	r0, r4
20024804:	f7fe fb86 	bl	20022f14 <HAL_FLASH_SET_LEGACY>
20024808:	2101      	movs	r1, #1
2002480a:	4620      	mov	r0, r4
2002480c:	f7fe fb1d 	bl	20022e4a <HAL_FLASH_ENABLE_QSPI>
20024810:	2101      	movs	r1, #1
20024812:	4620      	mov	r0, r4
20024814:	f7fe fb27 	bl	20022e66 <HAL_FLASH_ENABLE_OPI>
20024818:	b92e      	cbnz	r6, 20024826 <HAL_LEGACY_PSRAM_Init+0xaa>
2002481a:	f894 3027 	ldrb.w	r3, [r4, #39]	@ 0x27
2002481e:	b913      	cbnz	r3, 20024826 <HAL_LEGACY_PSRAM_Init+0xaa>
20024820:	4620      	mov	r0, r4
20024822:	f7ff feeb 	bl	200245fc <HAL_PSRAM_RESET>
20024826:	42bd      	cmp	r5, r7
20024828:	d93a      	bls.n	200248a0 <HAL_LEGACY_PSRAM_Init+0x124>
2002482a:	4b25      	ldr	r3, [pc, #148]	@ (200248c0 <HAL_LEGACY_PSRAM_Init+0x144>)
2002482c:	429d      	cmp	r5, r3
2002482e:	d93c      	bls.n	200248aa <HAL_LEGACY_PSRAM_Init+0x12e>
20024830:	2206      	movs	r2, #6
20024832:	2302      	movs	r3, #2
20024834:	2588      	movs	r5, #136	@ 0x88
20024836:	263b      	movs	r6, #59	@ 0x3b
20024838:	f884 3026 	strb.w	r3, [r4, #38]	@ 0x26
2002483c:	2101      	movs	r1, #1
2002483e:	f884 2025 	strb.w	r2, [r4, #37]	@ 0x25
20024842:	4620      	mov	r0, r4
20024844:	f7fe fb82 	bl	20022f4c <HAL_MPI_EN_FIXLAT>
20024848:	4632      	mov	r2, r6
2002484a:	2100      	movs	r1, #0
2002484c:	4620      	mov	r0, r4
2002484e:	f7ff fe7d 	bl	2002454c <HAL_LEGACY_MR_WRITE>
20024852:	462a      	mov	r2, r5
20024854:	2104      	movs	r1, #4
20024856:	4620      	mov	r0, r4
20024858:	f7ff fe78 	bl	2002454c <HAL_LEGACY_MR_WRITE>
2002485c:	2000      	movs	r0, #0
2002485e:	b005      	add	sp, #20
20024860:	bdf0      	pop	{r4, r5, r6, r7, pc}
20024862:	42b8      	cmp	r0, r7
20024864:	d90d      	bls.n	20024882 <HAL_LEGACY_PSRAM_Init+0x106>
20024866:	4b16      	ldr	r3, [pc, #88]	@ (200248c0 <HAL_LEGACY_PSRAM_Init+0x144>)
20024868:	4298      	cmp	r0, r3
2002486a:	d90f      	bls.n	2002488c <HAL_LEGACY_PSRAM_Init+0x110>
2002486c:	f103 7337 	add.w	r3, r3, #47972352	@ 0x2dc0000
20024870:	f503 43d8 	add.w	r3, r3, #27648	@ 0x6c00
20024874:	4298      	cmp	r0, r3
20024876:	d80e      	bhi.n	20024896 <HAL_LEGACY_PSRAM_Init+0x11a>
20024878:	2114      	movs	r1, #20
2002487a:	2308      	movs	r3, #8
2002487c:	f240 5232 	movw	r2, #1330	@ 0x532
20024880:	e7a6      	b.n	200247d0 <HAL_LEGACY_PSRAM_Init+0x54>
20024882:	210e      	movs	r1, #14
20024884:	2303      	movs	r3, #3
20024886:	f240 32b6 	movw	r2, #950	@ 0x3b6
2002488a:	e7a1      	b.n	200247d0 <HAL_LEGACY_PSRAM_Init+0x54>
2002488c:	2111      	movs	r1, #17
2002488e:	2305      	movs	r3, #5
20024890:	f240 4274 	movw	r2, #1140	@ 0x474
20024894:	e79c      	b.n	200247d0 <HAL_LEGACY_PSRAM_Init+0x54>
20024896:	2117      	movs	r1, #23
20024898:	2309      	movs	r3, #9
2002489a:	f44f 62be 	mov.w	r2, #1520	@ 0x5f0
2002489e:	e797      	b.n	200247d0 <HAL_LEGACY_PSRAM_Init+0x54>
200248a0:	2204      	movs	r2, #4
200248a2:	2300      	movs	r3, #0
200248a4:	2508      	movs	r5, #8
200248a6:	2633      	movs	r6, #51	@ 0x33
200248a8:	e7c6      	b.n	20024838 <HAL_LEGACY_PSRAM_Init+0xbc>
200248aa:	2205      	movs	r2, #5
200248ac:	2300      	movs	r3, #0
200248ae:	2508      	movs	r5, #8
200248b0:	2637      	movs	r6, #55	@ 0x37
200248b2:	e7c1      	b.n	20024838 <HAL_LEGACY_PSRAM_Init+0xbc>
200248b4:	2001      	movs	r0, #1
200248b6:	e7d2      	b.n	2002485e <HAL_LEGACY_PSRAM_Init+0xe2>
200248b8:	02dc6c01 	.word	0x02dc6c01
200248bc:	0e4e1c01 	.word	0x0e4e1c01
200248c0:	112a8801 	.word	0x112a8801

200248c4 <HAL_HYPER_PSRAM_WriteCR>:
200248c4:	b570      	push	{r4, r5, r6, lr}
200248c6:	460e      	mov	r6, r1
200248c8:	4615      	mov	r5, r2
200248ca:	4604      	mov	r4, r0
200248cc:	b086      	sub	sp, #24
200248ce:	b1f8      	cbz	r0, 20024910 <HAL_HYPER_PSRAM_WriteCR+0x4c>
200248d0:	2207      	movs	r2, #7
200248d2:	2303      	movs	r3, #3
200248d4:	e9cd 2301 	strd	r2, r3, [sp, #4]
200248d8:	2300      	movs	r3, #0
200248da:	e9cd 2203 	strd	r2, r2, [sp, #12]
200248de:	9300      	str	r3, [sp, #0]
200248e0:	2101      	movs	r1, #1
200248e2:	f7fe fa16 	bl	20022d12 <HAL_FLASH_MANUAL_CMD>
200248e6:	4631      	mov	r1, r6
200248e8:	4620      	mov	r0, r4
200248ea:	f7fe f9bc 	bl	20022c66 <HAL_FLASH_WRITE_ABYTE>
200248ee:	2102      	movs	r1, #2
200248f0:	4620      	mov	r0, r4
200248f2:	f7fe f9a4 	bl	20022c3e <HAL_FLASH_WRITE_DLEN>
200248f6:	4629      	mov	r1, r5
200248f8:	4620      	mov	r0, r4
200248fa:	f7fe f999 	bl	20022c30 <HAL_FLASH_WRITE_WORD>
200248fe:	f44f 3280 	mov.w	r2, #65536	@ 0x10000
20024902:	2160      	movs	r1, #96	@ 0x60
20024904:	4620      	mov	r0, r4
20024906:	b006      	add	sp, #24
20024908:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
2002490c:	f7fe b9bc 	b.w	20022c88 <HAL_FLASH_SET_CMD>
20024910:	b006      	add	sp, #24
20024912:	bd70      	pop	{r4, r5, r6, pc}

20024914 <HAL_HYPER_PSRAM_Init>:
20024914:	b538      	push	{r3, r4, r5, lr}
20024916:	4604      	mov	r4, r0
20024918:	2201      	movs	r2, #1
2002491a:	f7ff feb3 	bl	20024684 <HAL_OPI_PSRAM_Init>
2002491e:	4620      	mov	r0, r4
20024920:	f7ff fab0 	bl	20023e84 <HAL_QSPI_GET_CLK>
20024924:	4b15      	ldr	r3, [pc, #84]	@ (2002497c <HAL_HYPER_PSRAM_Init+0x68>)
20024926:	4298      	cmp	r0, r3
20024928:	d91f      	bls.n	2002496a <HAL_HYPER_PSRAM_Init+0x56>
2002492a:	4b15      	ldr	r3, [pc, #84]	@ (20024980 <HAL_HYPER_PSRAM_Init+0x6c>)
2002492c:	4298      	cmp	r0, r3
2002492e:	d91f      	bls.n	20024970 <HAL_HYPER_PSRAM_Init+0x5c>
20024930:	f103 73f4 	add.w	r3, r3, #31981568	@ 0x1e80000
20024934:	f503 4390 	add.w	r3, r3, #18432	@ 0x4800
20024938:	4298      	cmp	r0, r3
2002493a:	d91c      	bls.n	20024976 <HAL_HYPER_PSRAM_Init+0x62>
2002493c:	f242 758f 	movw	r5, #10127	@ 0x278f
20024940:	f241 738f 	movw	r3, #6031	@ 0x178f
20024944:	4a0f      	ldr	r2, [pc, #60]	@ (20024984 <HAL_HYPER_PSRAM_Init+0x70>)
20024946:	4290      	cmp	r0, r2
20024948:	bf98      	it	ls
2002494a:	461d      	movls	r5, r3
2002494c:	2101      	movs	r1, #1
2002494e:	4620      	mov	r0, r4
20024950:	f7fe fa97 	bl	20022e82 <HAL_FLASH_ENABLE_HYPER>
20024954:	462a      	mov	r2, r5
20024956:	4620      	mov	r0, r4
20024958:	2100      	movs	r1, #0
2002495a:	f7ff ffb3 	bl	200248c4 <HAL_HYPER_PSRAM_WriteCR>
2002495e:	2101      	movs	r1, #1
20024960:	4620      	mov	r0, r4
20024962:	f7fe faf3 	bl	20022f4c <HAL_MPI_EN_FIXLAT>
20024966:	2000      	movs	r0, #0
20024968:	bd38      	pop	{r3, r4, r5, pc}
2002496a:	f24e 758f 	movw	r5, #59279	@ 0xe78f
2002496e:	e7ed      	b.n	2002494c <HAL_HYPER_PSRAM_Init+0x38>
20024970:	f24f 758f 	movw	r5, #63375	@ 0xf78f
20024974:	e7ea      	b.n	2002494c <HAL_HYPER_PSRAM_Init+0x38>
20024976:	f240 758f 	movw	r5, #1935	@ 0x78f
2002497a:	e7e7      	b.n	2002494c <HAL_HYPER_PSRAM_Init+0x38>
2002497c:	0a21fe81 	.word	0x0a21fe81
20024980:	0c65d401 	.word	0x0c65d401
20024984:	112a8801 	.word	0x112a8801

20024988 <HAL_HYPER_CFG_READ>:
20024988:	b51f      	push	{r0, r1, r2, r3, r4, lr}
2002498a:	b160      	cbz	r0, 200249a6 <HAL_HYPER_CFG_READ+0x1e>
2002498c:	2107      	movs	r1, #7
2002498e:	2303      	movs	r3, #3
20024990:	f890 2025 	ldrb.w	r2, [r0, #37]	@ 0x25
20024994:	e9cd 1300 	strd	r1, r3, [sp]
20024998:	3a01      	subs	r2, #1
2002499a:	2300      	movs	r3, #0
2002499c:	e9cd 1102 	strd	r1, r1, [sp, #8]
200249a0:	b252      	sxtb	r2, r2
200249a2:	f7fe f8ff 	bl	20022ba4 <HAL_FLASH_CFG_AHB_RCMD>
200249a6:	b005      	add	sp, #20
200249a8:	f85d fb04 	ldr.w	pc, [sp], #4

200249ac <HAL_HYPER_CFG_WRITE>:
200249ac:	b51f      	push	{r0, r1, r2, r3, r4, lr}
200249ae:	b160      	cbz	r0, 200249ca <HAL_HYPER_CFG_WRITE+0x1e>
200249b0:	2107      	movs	r1, #7
200249b2:	2303      	movs	r3, #3
200249b4:	f890 2026 	ldrb.w	r2, [r0, #38]	@ 0x26
200249b8:	e9cd 1300 	strd	r1, r3, [sp]
200249bc:	3a01      	subs	r2, #1
200249be:	2300      	movs	r3, #0
200249c0:	e9cd 1102 	strd	r1, r1, [sp, #8]
200249c4:	b252      	sxtb	r2, r2
200249c6:	f7fe f916 	bl	20022bf6 <HAL_FLASH_CFG_AHB_WCMD>
200249ca:	b005      	add	sp, #20
200249cc:	f85d fb04 	ldr.w	pc, [sp], #4

200249d0 <HAL_PIN_SetUartFunc.part.0>:
200249d0:	108b      	asrs	r3, r1, #2
200249d2:	f1a3 0248 	sub.w	r2, r3, #72	@ 0x48
200249d6:	b5f0      	push	{r4, r5, r6, r7, lr}
200249d8:	b2d6      	uxtb	r6, r2
200249da:	2e04      	cmp	r6, #4
200249dc:	d849      	bhi.n	20024a72 <HAL_PIN_SetUartFunc.part.0+0xa2>
200249de:	2e02      	cmp	r6, #2
200249e0:	d810      	bhi.n	20024a04 <HAL_PIN_SetUartFunc.part.0+0x34>
200249e2:	4d25      	ldr	r5, [pc, #148]	@ (20024a78 <HAL_PIN_SetUartFunc.part.0+0xa8>)
200249e4:	240e      	movs	r4, #14
200249e6:	eb05 0582 	add.w	r5, r5, r2, lsl #2
200249ea:	f240 22b2 	movw	r2, #690	@ 0x2b2
200249ee:	eba1 0386 	sub.w	r3, r1, r6, lsl #2
200249f2:	b29b      	uxth	r3, r3
200249f4:	f5a3 7390 	sub.w	r3, r3, #288	@ 0x120
200249f8:	2b03      	cmp	r3, #3
200249fa:	d83a      	bhi.n	20024a72 <HAL_PIN_SetUartFunc.part.0+0xa2>
200249fc:	e8df f003 	tbb	[pc, r3]
20024a00:	20271a09 	.word	0x20271a09
20024a04:	4d1d      	ldr	r5, [pc, #116]	@ (20024a7c <HAL_PIN_SetUartFunc.part.0+0xac>)
20024a06:	009b      	lsls	r3, r3, #2
20024a08:	243d      	movs	r4, #61	@ 0x3d
20024a0a:	f240 3221 	movw	r2, #801	@ 0x321
20024a0e:	441d      	add	r5, r3
20024a10:	e7ed      	b.n	200249ee <HAL_PIN_SetUartFunc.part.0+0x1e>
20024a12:	2c0e      	cmp	r4, #14
20024a14:	f04f 0608 	mov.w	r6, #8
20024a18:	d120      	bne.n	20024a5c <HAL_PIN_SetUartFunc.part.0+0x8c>
20024a1a:	f44f 517c 	mov.w	r1, #16128	@ 0x3f00
20024a1e:	682f      	ldr	r7, [r5, #0]
20024a20:	1b03      	subs	r3, r0, r4
20024a22:	40b3      	lsls	r3, r6
20024a24:	407b      	eors	r3, r7
20024a26:	400b      	ands	r3, r1
20024a28:	4410      	add	r0, r2
20024a2a:	407b      	eors	r3, r7
20024a2c:	1b00      	subs	r0, r0, r4
20024a2e:	602b      	str	r3, [r5, #0]
20024a30:	b280      	uxth	r0, r0
20024a32:	bdf0      	pop	{r4, r5, r6, r7, pc}
20024a34:	2c0e      	cmp	r4, #14
20024a36:	f04f 0600 	mov.w	r6, #0
20024a3a:	d112      	bne.n	20024a62 <HAL_PIN_SetUartFunc.part.0+0x92>
20024a3c:	213f      	movs	r1, #63	@ 0x3f
20024a3e:	e7ee      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a40:	2c0e      	cmp	r4, #14
20024a42:	f04f 0610 	mov.w	r6, #16
20024a46:	d10e      	bne.n	20024a66 <HAL_PIN_SetUartFunc.part.0+0x96>
20024a48:	f44f 117c 	mov.w	r1, #4128768	@ 0x3f0000
20024a4c:	e7e7      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a4e:	2c0e      	cmp	r4, #14
20024a50:	f04f 0618 	mov.w	r6, #24
20024a54:	d10a      	bne.n	20024a6c <HAL_PIN_SetUartFunc.part.0+0x9c>
20024a56:	f04f 517c 	mov.w	r1, #1056964608	@ 0x3f000000
20024a5a:	e7e0      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a5c:	f44f 61e0 	mov.w	r1, #1792	@ 0x700
20024a60:	e7dd      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a62:	2107      	movs	r1, #7
20024a64:	e7db      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a66:	f44f 21e0 	mov.w	r1, #458752	@ 0x70000
20024a6a:	e7d8      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a6c:	f04f 61e0 	mov.w	r1, #117440512	@ 0x7000000
20024a70:	e7d5      	b.n	20024a1e <HAL_PIN_SetUartFunc.part.0+0x4e>
20024a72:	2000      	movs	r0, #0
20024a74:	e7dd      	b.n	20024a32 <HAL_PIN_SetUartFunc.part.0+0x62>
20024a76:	bf00      	nop
20024a78:	5000b058 	.word	0x5000b058
20024a7c:	4000ef0c 	.word	0x4000ef0c

20024a80 <HAL_PIN_SetAonPE>:
20024a80:	2a00      	cmp	r2, #0
20024a82:	d031      	beq.n	20024ae8 <HAL_PIN_SetAonPE+0x68>
20024a84:	282f      	cmp	r0, #47	@ 0x2f
20024a86:	dd16      	ble.n	20024ab6 <HAL_PIN_SetAonPE+0x36>
20024a88:	283a      	cmp	r0, #58	@ 0x3a
20024a8a:	dc2d      	bgt.n	20024ae8 <HAL_PIN_SetAonPE+0x68>
20024a8c:	2301      	movs	r3, #1
20024a8e:	4a17      	ldr	r2, [pc, #92]	@ (20024aec <HAL_PIN_SetAonPE+0x6c>)
20024a90:	382a      	subs	r0, #42	@ 0x2a
20024a92:	4083      	lsls	r3, r0
20024a94:	6f10      	ldr	r0, [r2, #112]	@ 0x70
20024a96:	f011 0f20 	tst.w	r1, #32
20024a9a:	bf14      	ite	ne
20024a9c:	4318      	orrne	r0, r3
20024a9e:	4398      	biceq	r0, r3
20024aa0:	6710      	str	r0, [r2, #112]	@ 0x70
20024aa2:	4a12      	ldr	r2, [pc, #72]	@ (20024aec <HAL_PIN_SetAonPE+0x6c>)
20024aa4:	f011 0f10 	tst.w	r1, #16
20024aa8:	6ed1      	ldr	r1, [r2, #108]	@ 0x6c
20024aaa:	bf14      	ite	ne
20024aac:	430b      	orrne	r3, r1
20024aae:	ea21 0303 	biceq.w	r3, r1, r3
20024ab2:	66d3      	str	r3, [r2, #108]	@ 0x6c
20024ab4:	4770      	bx	lr
20024ab6:	3826      	subs	r0, #38	@ 0x26
20024ab8:	2803      	cmp	r0, #3
20024aba:	d815      	bhi.n	20024ae8 <HAL_PIN_SetAonPE+0x68>
20024abc:	4b0c      	ldr	r3, [pc, #48]	@ (20024af0 <HAL_PIN_SetAonPE+0x70>)
20024abe:	f011 0f20 	tst.w	r1, #32
20024ac2:	f853 2020 	ldr.w	r2, [r3, r0, lsl #2]
20024ac6:	bf14      	ite	ne
20024ac8:	f042 0210 	orrne.w	r2, r2, #16
20024acc:	f022 0210 	biceq.w	r2, r2, #16
20024ad0:	f843 2020 	str.w	r2, [r3, r0, lsl #2]
20024ad4:	f853 2020 	ldr.w	r2, [r3, r0, lsl #2]
20024ad8:	06c9      	lsls	r1, r1, #27
20024ada:	bf4c      	ite	mi
20024adc:	f042 0208 	orrmi.w	r2, r2, #8
20024ae0:	f022 0208 	bicpl.w	r2, r2, #8
20024ae4:	f843 2020 	str.w	r2, [r3, r0, lsl #2]
20024ae8:	4770      	bx	lr
20024aea:	bf00      	nop
20024aec:	500cb000 	.word	0x500cb000
20024af0:	500cb05c 	.word	0x500cb05c

20024af4 <HAL_PIN_Get_Base>:
20024af4:	b138      	cbz	r0, 20024b06 <HAL_PIN_Get_Base+0x12>
20024af6:	f04f 42a0 	mov.w	r2, #1342177280	@ 0x50000000
20024afa:	6893      	ldr	r3, [r2, #8]
20024afc:	4806      	ldr	r0, [pc, #24]	@ (20024b18 <HAL_PIN_Get_Base+0x24>)
20024afe:	f043 0304 	orr.w	r3, r3, #4
20024b02:	6093      	str	r3, [r2, #8]
20024b04:	4770      	bx	lr
20024b06:	f04f 4280 	mov.w	r2, #1073741824	@ 0x40000000
20024b0a:	6853      	ldr	r3, [r2, #4]
20024b0c:	4803      	ldr	r0, [pc, #12]	@ (20024b1c <HAL_PIN_Get_Base+0x28>)
20024b0e:	f043 0308 	orr.w	r3, r3, #8
20024b12:	6053      	str	r3, [r2, #4]
20024b14:	4770      	bx	lr
20024b16:	bf00      	nop
20024b18:	50003000 	.word	0x50003000
20024b1c:	40003000 	.word	0x40003000

20024b20 <HAL_PIN_Func2Idx>:
20024b20:	283b      	cmp	r0, #59	@ 0x3b
20024b22:	bfc8      	it	gt
20024b24:	383c      	subgt	r0, #60	@ 0x3c
20024b26:	0143      	lsls	r3, r0, #5
20024b28:	b152      	cbz	r2, 20024b40 <HAL_PIN_Func2Idx+0x20>
20024b2a:	4a06      	ldr	r2, [pc, #24]	@ (20024b44 <HAL_PIN_Func2Idx+0x24>)
20024b2c:	2000      	movs	r0, #0
20024b2e:	4413      	add	r3, r2
20024b30:	f833 2010 	ldrh.w	r2, [r3, r0, lsl #1]
20024b34:	428a      	cmp	r2, r1
20024b36:	d002      	beq.n	20024b3e <HAL_PIN_Func2Idx+0x1e>
20024b38:	3001      	adds	r0, #1
20024b3a:	2810      	cmp	r0, #16
20024b3c:	d1f8      	bne.n	20024b30 <HAL_PIN_Func2Idx+0x10>
20024b3e:	4770      	bx	lr
20024b40:	4a01      	ldr	r2, [pc, #4]	@ (20024b48 <HAL_PIN_Func2Idx+0x28>)
20024b42:	e7f3      	b.n	20024b2c <HAL_PIN_Func2Idx+0xc>
20024b44:	2002b11c 	.word	0x2002b11c
20024b48:	2002b07c 	.word	0x2002b07c

20024b4c <HAL_PIN_Set>:
20024b4c:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
20024b50:	4615      	mov	r5, r2
20024b52:	4604      	mov	r4, r0
20024b54:	b918      	cbnz	r0, 20024b5e <HAL_PIN_Set+0x12>
20024b56:	f04f 30ff 	mov.w	r0, #4294967295
20024b5a:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
20024b5e:	283a      	cmp	r0, #58	@ 0x3a
20024b60:	bfcd      	iteet	gt
20024b62:	2700      	movgt	r7, #0
20024b64:	2701      	movle	r7, #1
20024b66:	4606      	movle	r6, r0
20024b68:	f1a0 063c 	subgt.w	r6, r0, #60	@ 0x3c
20024b6c:	4638      	mov	r0, r7
20024b6e:	f7ff ffc1 	bl	20024af4 <HAL_PIN_Get_Base>
20024b72:	4680      	mov	r8, r0
20024b74:	2f00      	cmp	r7, #0
20024b76:	f000 80fe 	beq.w	20024d76 <HAL_PIN_Set+0x22a>
20024b7a:	f5a1 7390 	sub.w	r3, r1, #288	@ 0x120
20024b7e:	b29b      	uxth	r3, r3
20024b80:	2b0b      	cmp	r3, #11
20024b82:	d82e      	bhi.n	20024be2 <HAL_PIN_Set+0x96>
20024b84:	4620      	mov	r0, r4
20024b86:	f7ff ff23 	bl	200249d0 <HAL_PIN_SetUartFunc.part.0>
20024b8a:	4601      	mov	r1, r0
20024b8c:	463a      	mov	r2, r7
20024b8e:	4620      	mov	r0, r4
20024b90:	f7ff ffc6 	bl	20024b20 <HAL_PIN_Func2Idx>
20024b94:	280f      	cmp	r0, #15
20024b96:	4681      	mov	r9, r0
20024b98:	dcdd      	bgt.n	20024b56 <HAL_PIN_Set+0xa>
20024b9a:	463a      	mov	r2, r7
20024b9c:	4629      	mov	r1, r5
20024b9e:	4620      	mov	r0, r4
20024ba0:	f7ff ff6e 	bl	20024a80 <HAL_PIN_SetAonPE>
20024ba4:	2f00      	cmp	r7, #0
20024ba6:	f040 80ef 	bne.w	20024d88 <HAL_PIN_Set+0x23c>
20024baa:	2c40      	cmp	r4, #64	@ 0x40
20024bac:	f340 80ec 	ble.w	20024d88 <HAL_PIN_Set+0x23c>
20024bb0:	4a7f      	ldr	r2, [pc, #508]	@ (20024db0 <HAL_PIN_Set+0x264>)
20024bb2:	06e8      	lsls	r0, r5, #27
20024bb4:	f852 3024 	ldr.w	r3, [r2, r4, lsl #2]
20024bb8:	ea4f 3909 	mov.w	r9, r9, lsl #12
20024bbc:	f423 43e0 	bic.w	r3, r3, #28672	@ 0x7000
20024bc0:	f023 0318 	bic.w	r3, r3, #24
20024bc4:	bf48      	it	mi
20024bc6:	f043 0308 	orrmi.w	r3, r3, #8
20024bca:	06a9      	lsls	r1, r5, #26
20024bcc:	bf48      	it	mi
20024bce:	f043 0310 	orrmi.w	r3, r3, #16
20024bd2:	f409 49e0 	and.w	r9, r9, #28672	@ 0x7000
20024bd6:	ea49 0303 	orr.w	r3, r9, r3
20024bda:	f842 3024 	str.w	r3, [r2, r4, lsl #2]
20024bde:	2000      	movs	r0, #0
20024be0:	e7bb      	b.n	20024b5a <HAL_PIN_Set+0xe>
20024be2:	f5a1 739c 	sub.w	r3, r1, #312	@ 0x138
20024be6:	b29b      	uxth	r3, r3
20024be8:	2b07      	cmp	r3, #7
20024bea:	d826      	bhi.n	20024c3a <HAL_PIN_Set+0xee>
20024bec:	104a      	asrs	r2, r1, #1
20024bee:	3a9c      	subs	r2, #156	@ 0x9c
20024bf0:	eba1 0142 	sub.w	r1, r1, r2, lsl #1
20024bf4:	b289      	uxth	r1, r1
20024bf6:	f5b1 7f9c 	cmp.w	r1, #312	@ 0x138
20024bfa:	d019      	beq.n	20024c30 <HAL_PIN_Set+0xe4>
20024bfc:	f240 1339 	movw	r3, #313	@ 0x139
20024c00:	4299      	cmp	r1, r3
20024c02:	f040 80bf 	bne.w	20024d84 <HAL_PIN_Set+0x238>
20024c06:	f04f 0e08 	mov.w	lr, #8
20024c0a:	f44f 5c7c 	mov.w	ip, #16128	@ 0x3f00
20024c0e:	4969      	ldr	r1, [pc, #420]	@ (20024db4 <HAL_PIN_Set+0x268>)
20024c10:	f1a4 030e 	sub.w	r3, r4, #14
20024c14:	f851 0022 	ldr.w	r0, [r1, r2, lsl #2]
20024c18:	fa03 f30e 	lsl.w	r3, r3, lr
20024c1c:	4043      	eors	r3, r0
20024c1e:	ea03 030c 	and.w	r3, r3, ip
20024c22:	4043      	eors	r3, r0
20024c24:	f841 3022 	str.w	r3, [r1, r2, lsl #2]
20024c28:	f504 7129 	add.w	r1, r4, #676	@ 0x2a4
20024c2c:	b289      	uxth	r1, r1
20024c2e:	e7ad      	b.n	20024b8c <HAL_PIN_Set+0x40>
20024c30:	f04f 0e00 	mov.w	lr, #0
20024c34:	f04f 0c3f 	mov.w	ip, #63	@ 0x3f
20024c38:	e7e9      	b.n	20024c0e <HAL_PIN_Set+0xc2>
20024c3a:	f5a1 73ec 	sub.w	r3, r1, #472	@ 0x1d8
20024c3e:	b29a      	uxth	r2, r3
20024c40:	2a09      	cmp	r2, #9
20024c42:	d836      	bhi.n	20024cb2 <HAL_PIN_Set+0x166>
20024c44:	2205      	movs	r2, #5
20024c46:	fbb3 f3f2 	udiv	r3, r3, r2
20024c4a:	ebc3 3283 	rsb	r2, r3, r3, lsl #14
20024c4e:	ebc3 0282 	rsb	r2, r3, r2, lsl #2
20024c52:	440a      	add	r2, r1
20024c54:	b292      	uxth	r2, r2
20024c56:	f5a2 71ec 	sub.w	r1, r2, #472	@ 0x1d8
20024c5a:	b288      	uxth	r0, r1
20024c5c:	2803      	cmp	r0, #3
20024c5e:	d814      	bhi.n	20024c8a <HAL_PIN_Set+0x13e>
20024c60:	f04f 0e3f 	mov.w	lr, #63	@ 0x3f
20024c64:	4854      	ldr	r0, [pc, #336]	@ (20024db8 <HAL_PIN_Set+0x26c>)
20024c66:	00c9      	lsls	r1, r1, #3
20024c68:	f850 c023 	ldr.w	ip, [r0, r3, lsl #2]
20024c6c:	f1a4 020e 	sub.w	r2, r4, #14
20024c70:	408a      	lsls	r2, r1
20024c72:	ea82 020c 	eor.w	r2, r2, ip
20024c76:	fa0e f101 	lsl.w	r1, lr, r1
20024c7a:	400a      	ands	r2, r1
20024c7c:	ea82 020c 	eor.w	r2, r2, ip
20024c80:	f840 2023 	str.w	r2, [r0, r3, lsl #2]
20024c84:	f204 2155 	addw	r1, r4, #597	@ 0x255
20024c88:	e7d0      	b.n	20024c2c <HAL_PIN_Set+0xe0>
20024c8a:	f5b2 7fee 	cmp.w	r2, #476	@ 0x1dc
20024c8e:	d179      	bne.n	20024d84 <HAL_PIN_Set+0x238>
20024c90:	213f      	movs	r1, #63	@ 0x3f
20024c92:	484a      	ldr	r0, [pc, #296]	@ (20024dbc <HAL_PIN_Set+0x270>)
20024c94:	00da      	lsls	r2, r3, #3
20024c96:	f8d0 c06c 	ldr.w	ip, [r0, #108]	@ 0x6c
20024c9a:	f1a4 030e 	sub.w	r3, r4, #14
20024c9e:	4093      	lsls	r3, r2
20024ca0:	ea83 030c 	eor.w	r3, r3, ip
20024ca4:	fa01 f202 	lsl.w	r2, r1, r2
20024ca8:	4013      	ands	r3, r2
20024caa:	ea83 030c 	eor.w	r3, r3, ip
20024cae:	66c3      	str	r3, [r0, #108]	@ 0x6c
20024cb0:	e7e8      	b.n	20024c84 <HAL_PIN_Set+0x138>
20024cb2:	f46f 7901 	mvn.w	r9, #516	@ 0x204
20024cb6:	eb01 0209 	add.w	r2, r1, r9
20024cba:	b293      	uxth	r3, r2
20024cbc:	2b05      	cmp	r3, #5
20024cbe:	d827      	bhi.n	20024d10 <HAL_PIN_Set+0x1c4>
20024cc0:	2303      	movs	r3, #3
20024cc2:	fbb2 f2f3 	udiv	r2, r2, r3
20024cc6:	f46f 7e01 	mvn.w	lr, #516	@ 0x204
20024cca:	ebc2 3382 	rsb	r3, r2, r2, lsl #14
20024cce:	eb02 0383 	add.w	r3, r2, r3, lsl #2
20024cd2:	440b      	add	r3, r1
20024cd4:	b29b      	uxth	r3, r3
20024cd6:	eb03 0c0e 	add.w	ip, r3, lr
20024cda:	fa1f fc8c 	uxth.w	ip, ip
20024cde:	f1bc 0f02 	cmp.w	ip, #2
20024ce2:	d84f      	bhi.n	20024d84 <HAL_PIN_Set+0x238>
20024ce4:	00db      	lsls	r3, r3, #3
20024ce6:	f5a3 5381 	sub.w	r3, r3, #4128	@ 0x1020
20024cea:	4935      	ldr	r1, [pc, #212]	@ (20024dc0 <HAL_PIN_Set+0x274>)
20024cec:	f1a4 0e0e 	sub.w	lr, r4, #14
20024cf0:	3b08      	subs	r3, #8
20024cf2:	fa0e f303 	lsl.w	r3, lr, r3
20024cf6:	f8df e0d8 	ldr.w	lr, [pc, #216]	@ 20024dd0 <HAL_PIN_Set+0x284>
20024cfa:	f851 0022 	ldr.w	r0, [r1, r2, lsl #2]
20024cfe:	f85e c02c 	ldr.w	ip, [lr, ip, lsl #2]
20024d02:	4043      	eors	r3, r0
20024d04:	ea03 030c 	and.w	r3, r3, ip
20024d08:	4043      	eors	r3, r0
20024d0a:	f841 3022 	str.w	r3, [r1, r2, lsl #2]
20024d0e:	e7b9      	b.n	20024c84 <HAL_PIN_Set+0x138>
20024d10:	f46f 7cf8 	mvn.w	ip, #496	@ 0x1f0
20024d14:	eb01 030c 	add.w	r3, r1, ip
20024d18:	b29a      	uxth	r2, r3
20024d1a:	2a09      	cmp	r2, #9
20024d1c:	f63f af36 	bhi.w	20024b8c <HAL_PIN_Set+0x40>
20024d20:	f5b1 7ffc 	cmp.w	r1, #504	@ 0x1f8
20024d24:	d216      	bcs.n	20024d54 <HAL_PIN_Set+0x208>
20024d26:	0859      	lsrs	r1, r3, #1
20024d28:	f013 0f01 	tst.w	r3, #1
20024d2c:	4b25      	ldr	r3, [pc, #148]	@ (20024dc4 <HAL_PIN_Set+0x278>)
20024d2e:	f04f 003f 	mov.w	r0, #63	@ 0x3f
20024d32:	4a25      	ldr	r2, [pc, #148]	@ (20024dc8 <HAL_PIN_Set+0x27c>)
20024d34:	bf18      	it	ne
20024d36:	461a      	movne	r2, r3
20024d38:	00c9      	lsls	r1, r1, #3
20024d3a:	4088      	lsls	r0, r1
20024d3c:	f8d2 c000 	ldr.w	ip, [r2]
20024d40:	f1a4 030e 	sub.w	r3, r4, #14
20024d44:	408b      	lsls	r3, r1
20024d46:	ea83 030c 	eor.w	r3, r3, ip
20024d4a:	4003      	ands	r3, r0
20024d4c:	ea83 030c 	eor.w	r3, r3, ip
20024d50:	6013      	str	r3, [r2, #0]
20024d52:	e797      	b.n	20024c84 <HAL_PIN_Set+0x138>
20024d54:	d007      	beq.n	20024d66 <HAL_PIN_Set+0x21a>
20024d56:	f240 13f9 	movw	r3, #505	@ 0x1f9
20024d5a:	4299      	cmp	r1, r3
20024d5c:	d107      	bne.n	20024d6e <HAL_PIN_Set+0x222>
20024d5e:	2100      	movs	r1, #0
20024d60:	203f      	movs	r0, #63	@ 0x3f
20024d62:	4a1a      	ldr	r2, [pc, #104]	@ (20024dcc <HAL_PIN_Set+0x280>)
20024d64:	e7ea      	b.n	20024d3c <HAL_PIN_Set+0x1f0>
20024d66:	2110      	movs	r1, #16
20024d68:	f44f 107c 	mov.w	r0, #4128768	@ 0x3f0000
20024d6c:	e7f9      	b.n	20024d62 <HAL_PIN_Set+0x216>
20024d6e:	2108      	movs	r1, #8
20024d70:	f44f 507c 	mov.w	r0, #16128	@ 0x3f00
20024d74:	e7f5      	b.n	20024d62 <HAL_PIN_Set+0x216>
20024d76:	f5a1 7396 	sub.w	r3, r1, #300	@ 0x12c
20024d7a:	b29b      	uxth	r3, r3
20024d7c:	2b07      	cmp	r3, #7
20024d7e:	f63f af05 	bhi.w	20024b8c <HAL_PIN_Set+0x40>
20024d82:	e6ff      	b.n	20024b84 <HAL_PIN_Set+0x38>
20024d84:	2100      	movs	r1, #0
20024d86:	e701      	b.n	20024b8c <HAL_PIN_Set+0x40>
20024d88:	f106 4680 	add.w	r6, r6, #1073741824	@ 0x40000000
20024d8c:	3e01      	subs	r6, #1
20024d8e:	f858 3026 	ldr.w	r3, [r8, r6, lsl #2]
20024d92:	f005 0530 	and.w	r5, r5, #48	@ 0x30
20024d96:	f009 090f 	and.w	r9, r9, #15
20024d9a:	ea45 0509 	orr.w	r5, r5, r9
20024d9e:	f023 033f 	bic.w	r3, r3, #63	@ 0x3f
20024da2:	431d      	orrs	r5, r3
20024da4:	f045 0540 	orr.w	r5, r5, #64	@ 0x40
20024da8:	f848 5026 	str.w	r5, [r8, r6, lsl #2]
20024dac:	e717      	b.n	20024bde <HAL_PIN_Set+0x92>
20024dae:	bf00      	nop
20024db0:	500caf58 	.word	0x500caf58
20024db4:	5000b048 	.word	0x5000b048
20024db8:	5000b064 	.word	0x5000b064
20024dbc:	5000b000 	.word	0x5000b000
20024dc0:	5000b070 	.word	0x5000b070
20024dc4:	5000b07c 	.word	0x5000b07c
20024dc8:	5000b078 	.word	0x5000b078
20024dcc:	5000b080 	.word	0x5000b080
20024dd0:	2002b890 	.word	0x2002b890

20024dd4 <HAL_PIN_Set_Analog>:
20024dd4:	283a      	cmp	r0, #58	@ 0x3a
20024dd6:	b538      	push	{r3, r4, r5, lr}
20024dd8:	4604      	mov	r4, r0
20024dda:	dd25      	ble.n	20024e28 <HAL_PIN_Set_Analog+0x54>
20024ddc:	2840      	cmp	r0, #64	@ 0x40
20024dde:	dc16      	bgt.n	20024e0e <HAL_PIN_Set_Analog+0x3a>
20024de0:	2500      	movs	r5, #0
20024de2:	f1a0 013c 	sub.w	r1, r0, #60	@ 0x3c
20024de6:	4628      	mov	r0, r5
20024de8:	f7ff fe84 	bl	20024af4 <HAL_PIN_Get_Base>
20024dec:	f101 4380 	add.w	r3, r1, #1073741824	@ 0x40000000
20024df0:	3b01      	subs	r3, #1
20024df2:	f850 1023 	ldr.w	r1, [r0, r3, lsl #2]
20024df6:	462a      	mov	r2, r5
20024df8:	f021 015f 	bic.w	r1, r1, #95	@ 0x5f
20024dfc:	f041 010f 	orr.w	r1, r1, #15
20024e00:	f840 1023 	str.w	r1, [r0, r3, lsl #2]
20024e04:	2100      	movs	r1, #0
20024e06:	4620      	mov	r0, r4
20024e08:	f7ff fe3a 	bl	20024a80 <HAL_PIN_SetAonPE>
20024e0c:	e00a      	b.n	20024e24 <HAL_PIN_Set_Analog+0x50>
20024e0e:	4a08      	ldr	r2, [pc, #32]	@ (20024e30 <HAL_PIN_Set_Analog+0x5c>)
20024e10:	f852 3020 	ldr.w	r3, [r2, r0, lsl #2]
20024e14:	f423 43e0 	bic.w	r3, r3, #28672	@ 0x7000
20024e18:	f023 030e 	bic.w	r3, r3, #14
20024e1c:	f443 43e0 	orr.w	r3, r3, #28672	@ 0x7000
20024e20:	f842 3020 	str.w	r3, [r2, r0, lsl #2]
20024e24:	2000      	movs	r0, #0
20024e26:	bd38      	pop	{r3, r4, r5, pc}
20024e28:	4601      	mov	r1, r0
20024e2a:	2501      	movs	r5, #1
20024e2c:	e7db      	b.n	20024de6 <HAL_PIN_Set_Analog+0x12>
20024e2e:	bf00      	nop
20024e30:	500caf58 	.word	0x500caf58

20024e34 <HAL_PMU_EnableDLL>:
20024e34:	4b05      	ldr	r3, [pc, #20]	@ (20024e4c <HAL_PMU_EnableDLL+0x18>)
20024e36:	6e9a      	ldr	r2, [r3, #104]	@ 0x68
20024e38:	b120      	cbz	r0, 20024e44 <HAL_PMU_EnableDLL+0x10>
20024e3a:	f042 0220 	orr.w	r2, r2, #32
20024e3e:	2000      	movs	r0, #0
20024e40:	669a      	str	r2, [r3, #104]	@ 0x68
20024e42:	4770      	bx	lr
20024e44:	f022 0220 	bic.w	r2, r2, #32
20024e48:	e7f9      	b.n	20024e3e <HAL_PMU_EnableDLL+0xa>
20024e4a:	bf00      	nop
20024e4c:	500ca000 	.word	0x500ca000

20024e50 <HAL_RCC_HCPU_ConfigSxModeVolt>:
20024e50:	b507      	push	{r0, r1, r2, lr}
20024e52:	4a13      	ldr	r2, [pc, #76]	@ (20024ea0 <HAL_RCC_HCPU_ConfigSxModeVolt+0x50>)
20024e54:	4913      	ldr	r1, [pc, #76]	@ (20024ea4 <HAL_RCC_HCPU_ConfigSxModeVolt+0x54>)
20024e56:	eb02 02c0 	add.w	r2, r2, r0, lsl #3
20024e5a:	f8d1 309c 	ldr.w	r3, [r1, #156]	@ 0x9c
20024e5e:	7892      	ldrb	r2, [r2, #2]
20024e60:	2802      	cmp	r0, #2
20024e62:	f362 0303 	bfi	r3, r2, #0, #4
20024e66:	f8c1 309c 	str.w	r3, [r1, #156]	@ 0x9c
20024e6a:	f10d 0007 	add.w	r0, sp, #7
20024e6e:	d111      	bne.n	20024e94 <HAL_RCC_HCPU_ConfigSxModeVolt+0x44>
20024e70:	f007 fa9e 	bl	2002c3b0 <HAL_PMU_GetHpsysVoutRef>
20024e74:	b110      	cbz	r0, 20024e7c <HAL_RCC_HCPU_ConfigSxModeVolt+0x2c>
20024e76:	230b      	movs	r3, #11
20024e78:	f88d 3007 	strb.w	r3, [sp, #7]
20024e7c:	4a09      	ldr	r2, [pc, #36]	@ (20024ea4 <HAL_RCC_HCPU_ConfigSxModeVolt+0x54>)
20024e7e:	f89d 1007 	ldrb.w	r1, [sp, #7]
20024e82:	f8d2 3094 	ldr.w	r3, [r2, #148]	@ 0x94
20024e86:	f361 0303 	bfi	r3, r1, #0, #4
20024e8a:	f8c2 3094 	str.w	r3, [r2, #148]	@ 0x94
20024e8e:	b003      	add	sp, #12
20024e90:	f85d fb04 	ldr.w	pc, [sp], #4
20024e94:	f007 fa98 	bl	2002c3c8 <HAL_PMU_GetHpsysVoutRef2>
20024e98:	2800      	cmp	r0, #0
20024e9a:	d0ef      	beq.n	20024e7c <HAL_RCC_HCPU_ConfigSxModeVolt+0x2c>
20024e9c:	230d      	movs	r3, #13
20024e9e:	e7eb      	b.n	20024e78 <HAL_RCC_HCPU_ConfigSxModeVolt+0x28>
20024ea0:	2002b8ac 	.word	0x2002b8ac
20024ea4:	500ca000 	.word	0x500ca000

20024ea8 <HAL_RCC_HCPU_GetClockSrc>:
20024ea8:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
20024eac:	280d      	cmp	r0, #13
20024eae:	6a1a      	ldr	r2, [r3, #32]
20024eb0:	d80d      	bhi.n	20024ece <HAL_RCC_HCPU_GetClockSrc+0x26>
20024eb2:	f642 73f1 	movw	r3, #12273	@ 0x2ff1
20024eb6:	40c3      	lsrs	r3, r0
20024eb8:	f013 0f01 	tst.w	r3, #1
20024ebc:	bf0c      	ite	eq
20024ebe:	2301      	moveq	r3, #1
20024ec0:	2303      	movne	r3, #3
20024ec2:	4083      	lsls	r3, r0
20024ec4:	4013      	ands	r3, r2
20024ec6:	fa23 f000 	lsr.w	r0, r3, r0
20024eca:	b2c0      	uxtb	r0, r0
20024ecc:	4770      	bx	lr
20024ece:	2301      	movs	r3, #1
20024ed0:	e7f7      	b.n	20024ec2 <HAL_RCC_HCPU_GetClockSrc+0x1a>
	...

20024ed4 <HAL_RCC_HCPU_GetDLLFreq>:
20024ed4:	2801      	cmp	r0, #1
20024ed6:	d003      	beq.n	20024ee0 <HAL_RCC_HCPU_GetDLLFreq+0xc>
20024ed8:	2802      	cmp	r0, #2
20024eda:	d00e      	beq.n	20024efa <HAL_RCC_HCPU_GetDLLFreq+0x26>
20024edc:	2000      	movs	r0, #0
20024ede:	4770      	bx	lr
20024ee0:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
20024ee4:	6adb      	ldr	r3, [r3, #44]	@ 0x2c
20024ee6:	b163      	cbz	r3, 20024f02 <HAL_RCC_HCPU_GetDLLFreq+0x2e>
20024ee8:	f013 0001 	ands.w	r0, r3, #1
20024eec:	d00a      	beq.n	20024f04 <HAL_RCC_HCPU_GetDLLFreq+0x30>
20024eee:	4806      	ldr	r0, [pc, #24]	@ (20024f08 <HAL_RCC_HCPU_GetDLLFreq+0x34>)
20024ef0:	f3c3 0383 	ubfx	r3, r3, #2, #4
20024ef4:	fb03 0000 	mla	r0, r3, r0, r0
20024ef8:	4770      	bx	lr
20024efa:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
20024efe:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
20024f00:	e7f1      	b.n	20024ee6 <HAL_RCC_HCPU_GetDLLFreq+0x12>
20024f02:	4618      	mov	r0, r3
20024f04:	4770      	bx	lr
20024f06:	bf00      	nop
20024f08:	016e3600 	.word	0x016e3600

20024f0c <HAL_RCC_HCPU_GetDLL1Freq>:
20024f0c:	2001      	movs	r0, #1
20024f0e:	f7ff bfe1 	b.w	20024ed4 <HAL_RCC_HCPU_GetDLLFreq>

20024f12 <HAL_RCC_HCPU_GetDLL2Freq>:
20024f12:	2002      	movs	r0, #2
20024f14:	f7ff bfde 	b.w	20024ed4 <HAL_RCC_HCPU_GetDLLFreq>

20024f18 <HAL_RCC_HCPU_GetDLL3Freq>:
20024f18:	2000      	movs	r0, #0
20024f1a:	4770      	bx	lr

20024f1c <HAL_RCC_HCPU_EnableDLL>:
20024f1c:	4b23      	ldr	r3, [pc, #140]	@ (20024fac <HAL_RCC_HCPU_EnableDLL+0x90>)
20024f1e:	f1a1 71b7 	sub.w	r1, r1, #23986176	@ 0x16e0000
20024f22:	f5a1 5158 	sub.w	r1, r1, #13824	@ 0x3600
20024f26:	4299      	cmp	r1, r3
20024f28:	b510      	push	{r4, lr}
20024f2a:	d83c      	bhi.n	20024fa6 <HAL_RCC_HCPU_EnableDLL+0x8a>
20024f2c:	2801      	cmp	r0, #1
20024f2e:	d002      	beq.n	20024f36 <HAL_RCC_HCPU_EnableDLL+0x1a>
20024f30:	2802      	cmp	r0, #2
20024f32:	d036      	beq.n	20024fa2 <HAL_RCC_HCPU_EnableDLL+0x86>
20024f34:	e7fe      	b.n	20024f34 <HAL_RCC_HCPU_EnableDLL+0x18>
20024f36:	4c1e      	ldr	r4, [pc, #120]	@ (20024fb0 <HAL_RCC_HCPU_EnableDLL+0x94>)
20024f38:	4b1e      	ldr	r3, [pc, #120]	@ (20024fb4 <HAL_RCC_HCPU_EnableDLL+0x98>)
20024f3a:	f8d3 2094 	ldr.w	r2, [r3, #148]	@ 0x94
20024f3e:	0790      	lsls	r0, r2, #30
20024f40:	bf58      	it	pl
20024f42:	f8d3 2094 	ldrpl.w	r2, [r3, #148]	@ 0x94
20024f46:	f04f 0000 	mov.w	r0, #0
20024f4a:	bf5c      	itt	pl
20024f4c:	f042 0202 	orrpl.w	r2, r2, #2
20024f50:	f8c3 2094 	strpl.w	r2, [r3, #148]	@ 0x94
20024f54:	f8d3 2094 	ldr.w	r2, [r3, #148]	@ 0x94
20024f58:	07d2      	lsls	r2, r2, #31
20024f5a:	bf5e      	ittt	pl
20024f5c:	f8d3 2094 	ldrpl.w	r2, [r3, #148]	@ 0x94
20024f60:	f042 0201 	orrpl.w	r2, r2, #1
20024f64:	f8c3 2094 	strpl.w	r2, [r3, #148]	@ 0x94
20024f68:	4a13      	ldr	r2, [pc, #76]	@ (20024fb8 <HAL_RCC_HCPU_EnableDLL+0x9c>)
20024f6a:	6823      	ldr	r3, [r4, #0]
20024f6c:	fbb1 f1f2 	udiv	r1, r1, r2
20024f70:	f023 0301 	bic.w	r3, r3, #1
20024f74:	6023      	str	r3, [r4, #0]
20024f76:	6823      	ldr	r3, [r4, #0]
20024f78:	f423 5300 	bic.w	r3, r3, #8192	@ 0x2000
20024f7c:	f023 033c 	bic.w	r3, r3, #60	@ 0x3c
20024f80:	ea43 0381 	orr.w	r3, r3, r1, lsl #2
20024f84:	f443 5380 	orr.w	r3, r3, #4096	@ 0x1000
20024f88:	f043 0301 	orr.w	r3, r3, #1
20024f8c:	6023      	str	r3, [r4, #0]
20024f8e:	f7fc ffb4 	bl	20021efa <HAL_Delay_us>
20024f92:	200a      	movs	r0, #10
20024f94:	f7fc ffb1 	bl	20021efa <HAL_Delay_us>
20024f98:	6823      	ldr	r3, [r4, #0]
20024f9a:	2b00      	cmp	r3, #0
20024f9c:	dafc      	bge.n	20024f98 <HAL_RCC_HCPU_EnableDLL+0x7c>
20024f9e:	2000      	movs	r0, #0
20024fa0:	bd10      	pop	{r4, pc}
20024fa2:	4c06      	ldr	r4, [pc, #24]	@ (20024fbc <HAL_RCC_HCPU_EnableDLL+0xa0>)
20024fa4:	e7c8      	b.n	20024f38 <HAL_RCC_HCPU_EnableDLL+0x1c>
20024fa6:	2001      	movs	r0, #1
20024fa8:	e7fa      	b.n	20024fa0 <HAL_RCC_HCPU_EnableDLL+0x84>
20024faa:	bf00      	nop
20024fac:	15752a00 	.word	0x15752a00
20024fb0:	5000002c 	.word	0x5000002c
20024fb4:	5000b000 	.word	0x5000b000
20024fb8:	016e3600 	.word	0x016e3600
20024fbc:	50000030 	.word	0x50000030

20024fc0 <HAL_RCC_HCPU_EnableDLL1>:
20024fc0:	4601      	mov	r1, r0
20024fc2:	2001      	movs	r0, #1
20024fc4:	f7ff bfaa 	b.w	20024f1c <HAL_RCC_HCPU_EnableDLL>

20024fc8 <HAL_RCC_HCPU_EnableDLL2>:
20024fc8:	4601      	mov	r1, r0
20024fca:	2002      	movs	r0, #2
20024fcc:	f7ff bfa6 	b.w	20024f1c <HAL_RCC_HCPU_EnableDLL>

20024fd0 <HAL_RCC_HCPU_DisableDLL1>:
20024fd0:	f04f 42a0 	mov.w	r2, #1342177280	@ 0x50000000
20024fd4:	6ad3      	ldr	r3, [r2, #44]	@ 0x2c
20024fd6:	2000      	movs	r0, #0
20024fd8:	f023 0301 	bic.w	r3, r3, #1
20024fdc:	62d3      	str	r3, [r2, #44]	@ 0x2c
20024fde:	4770      	bx	lr

20024fe0 <HAL_RCC_GetSysCLKFreq>:
20024fe0:	2801      	cmp	r0, #1
20024fe2:	d108      	bne.n	20024ff6 <HAL_RCC_GetSysCLKFreq+0x16>
20024fe4:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
20024fe8:	6a1b      	ldr	r3, [r3, #32]
20024fea:	f003 0303 	and.w	r3, r3, #3
20024fee:	2b03      	cmp	r3, #3
20024ff0:	d101      	bne.n	20024ff6 <HAL_RCC_GetSysCLKFreq+0x16>
20024ff2:	f7ff bf8b 	b.w	20024f0c <HAL_RCC_HCPU_GetDLL1Freq>
20024ff6:	4801      	ldr	r0, [pc, #4]	@ (20024ffc <HAL_RCC_GetSysCLKFreq+0x1c>)
20024ff8:	4770      	bx	lr
20024ffa:	bf00      	nop
20024ffc:	02dc6c00 	.word	0x02dc6c00

20025000 <HAL_RCC_GetHCLKFreq>:
20025000:	1e02      	subs	r2, r0, #0
20025002:	bf08      	it	eq
20025004:	2201      	moveq	r2, #1
20025006:	b508      	push	{r3, lr}
20025008:	4610      	mov	r0, r2
2002500a:	f7ff ffe9 	bl	20024fe0 <HAL_RCC_GetSysCLKFreq>
2002500e:	2a01      	cmp	r2, #1
20025010:	d002      	beq.n	20025018 <HAL_RCC_GetHCLKFreq+0x18>
20025012:	2a02      	cmp	r2, #2
20025014:	d00a      	beq.n	2002502c <HAL_RCC_GetHCLKFreq+0x2c>
20025016:	e7fe      	b.n	20025016 <HAL_RCC_GetHCLKFreq+0x16>
20025018:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
2002501c:	6a5b      	ldr	r3, [r3, #36]	@ 0x24
2002501e:	b2db      	uxtb	r3, r3
20025020:	2b01      	cmp	r3, #1
20025022:	bfb8      	it	lt
20025024:	2301      	movlt	r3, #1
20025026:	fbb0 f0f3 	udiv	r0, r0, r3
2002502a:	bd08      	pop	{r3, pc}
2002502c:	f04f 4380 	mov.w	r3, #1073741824	@ 0x40000000
20025030:	695b      	ldr	r3, [r3, #20]
20025032:	f003 033f 	and.w	r3, r3, #63	@ 0x3f
20025036:	e7f3      	b.n	20025020 <HAL_RCC_GetHCLKFreq+0x20>

20025038 <HAL_RCC_HCPU_ClockSelect>:
20025038:	f04f 43a0 	mov.w	r3, #1342177280	@ 0x50000000
2002503c:	b510      	push	{r4, lr}
2002503e:	280d      	cmp	r0, #13
20025040:	6a1b      	ldr	r3, [r3, #32]
20025042:	d818      	bhi.n	20025076 <HAL_RCC_HCPU_ClockSelect+0x3e>
20025044:	f642 72f1 	movw	r2, #12273	@ 0x2ff1
20025048:	40c2      	lsrs	r2, r0
2002504a:	f012 0f01 	tst.w	r2, #1
2002504e:	bf0c      	ite	eq
20025050:	2201      	moveq	r2, #1
20025052:	2203      	movne	r2, #3
20025054:	fa02 f400 	lsl.w	r4, r2, r0
20025058:	4011      	ands	r1, r2
2002505a:	f04f 42a0 	mov.w	r2, #1342177280	@ 0x50000000
2002505e:	ea23 0304 	bic.w	r3, r3, r4
20025062:	4081      	lsls	r1, r0
20025064:	430b      	orrs	r3, r1
20025066:	6213      	str	r3, [r2, #32]
20025068:	b920      	cbnz	r0, 20025074 <HAL_RCC_HCPU_ClockSelect+0x3c>
2002506a:	2001      	movs	r0, #1
2002506c:	f7ff ffc8 	bl	20025000 <HAL_RCC_GetHCLKFreq>
20025070:	4b02      	ldr	r3, [pc, #8]	@ (2002507c <HAL_RCC_HCPU_ClockSelect+0x44>)
20025072:	6018      	str	r0, [r3, #0]
20025074:	bd10      	pop	{r4, pc}
20025076:	2201      	movs	r2, #1
20025078:	e7ec      	b.n	20025054 <HAL_RCC_HCPU_ClockSelect+0x1c>
2002507a:	bf00      	nop
2002507c:	20042c10 	.word	0x20042c10

20025080 <HAL_RCC_HCPU_SetDiv>:
20025080:	2800      	cmp	r0, #0
20025082:	bfd8      	it	le
20025084:	2000      	movle	r0, #0
20025086:	b508      	push	{r3, lr}
20025088:	bfcc      	ite	gt
2002508a:	23ff      	movgt	r3, #255	@ 0xff
2002508c:	4603      	movle	r3, r0
2002508e:	2900      	cmp	r1, #0
20025090:	db12      	blt.n	200250b8 <HAL_RCC_HCPU_SetDiv+0x38>
20025092:	2a00      	cmp	r2, #0
20025094:	f443 63e0 	orr.w	r3, r3, #1792	@ 0x700
20025098:	ea40 2001 	orr.w	r0, r0, r1, lsl #8
2002509c:	da0e      	bge.n	200250bc <HAL_RCC_HCPU_SetDiv+0x3c>
2002509e:	f04f 41a0 	mov.w	r1, #1342177280	@ 0x50000000
200250a2:	6a4a      	ldr	r2, [r1, #36]	@ 0x24
200250a4:	ea22 0303 	bic.w	r3, r2, r3
200250a8:	4303      	orrs	r3, r0
200250aa:	624b      	str	r3, [r1, #36]	@ 0x24
200250ac:	2001      	movs	r0, #1
200250ae:	f7ff ffa7 	bl	20025000 <HAL_RCC_GetHCLKFreq>
200250b2:	4b07      	ldr	r3, [pc, #28]	@ (200250d0 <HAL_RCC_HCPU_SetDiv+0x50>)
200250b4:	6018      	str	r0, [r3, #0]
200250b6:	bd08      	pop	{r3, pc}
200250b8:	2a00      	cmp	r2, #0
200250ba:	db04      	blt.n	200250c6 <HAL_RCC_HCPU_SetDiv+0x46>
200250bc:	f443 43e0 	orr.w	r3, r3, #28672	@ 0x7000
200250c0:	ea40 3002 	orr.w	r0, r0, r2, lsl #12
200250c4:	e7eb      	b.n	2002509e <HAL_RCC_HCPU_SetDiv+0x1e>
200250c6:	2b00      	cmp	r3, #0
200250c8:	d0f0      	beq.n	200250ac <HAL_RCC_HCPU_SetDiv+0x2c>
200250ca:	23ff      	movs	r3, #255	@ 0xff
200250cc:	e7e7      	b.n	2002509e <HAL_RCC_HCPU_SetDiv+0x1e>
200250ce:	bf00      	nop
200250d0:	20042c10 	.word	0x20042c10

200250d4 <HAL_RCC_HCPU_SwitchDvfsD2S>:
200250d4:	b570      	push	{r4, r5, r6, lr}
200250d6:	460c      	mov	r4, r1
200250d8:	4d19      	ldr	r5, [pc, #100]	@ (20025140 <HAL_RCC_HCPU_SwitchDvfsD2S+0x6c>)
200250da:	4606      	mov	r6, r0
200250dc:	f7ff feb8 	bl	20024e50 <HAL_RCC_HCPU_ConfigSxModeVolt>
200250e0:	692b      	ldr	r3, [r5, #16]
200250e2:	20fa      	movs	r0, #250	@ 0xfa
200250e4:	f023 0304 	bic.w	r3, r3, #4
200250e8:	612b      	str	r3, [r5, #16]
200250ea:	f7fc ff06 	bl	20021efa <HAL_Delay_us>
200250ee:	2c30      	cmp	r4, #48	@ 0x30
200250f0:	d80d      	bhi.n	2002510e <HAL_RCC_HCPU_SwitchDvfsD2S+0x3a>
200250f2:	2100      	movs	r1, #0
200250f4:	4608      	mov	r0, r1
200250f6:	f7ff ff9f 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
200250fa:	2030      	movs	r0, #48	@ 0x30
200250fc:	2204      	movs	r2, #4
200250fe:	2100      	movs	r1, #0
20025100:	fbb0 f0f4 	udiv	r0, r0, r4
20025104:	f7ff ffbc 	bl	20025080 <HAL_RCC_HCPU_SetDiv>
20025108:	2400      	movs	r4, #0
2002510a:	4620      	mov	r0, r4
2002510c:	bd70      	pop	{r4, r5, r6, pc}
2002510e:	f7fd fd09 	bl	20022b24 <HAL_HPAON_EnableXT48>
20025112:	480c      	ldr	r0, [pc, #48]	@ (20025144 <HAL_RCC_HCPU_SwitchDvfsD2S+0x70>)
20025114:	eb00 00c6 	add.w	r0, r0, r6, lsl #3
20025118:	6843      	ldr	r3, [r0, #4]
2002511a:	480b      	ldr	r0, [pc, #44]	@ (20025148 <HAL_RCC_HCPU_SwitchDvfsD2S+0x74>)
2002511c:	61eb      	str	r3, [r5, #28]
2002511e:	4360      	muls	r0, r4
20025120:	f7ff ff4e 	bl	20024fc0 <HAL_RCC_HCPU_EnableDLL1>
20025124:	4604      	mov	r4, r0
20025126:	2800      	cmp	r0, #0
20025128:	d1ef      	bne.n	2002510a <HAL_RCC_HCPU_SwitchDvfsD2S+0x36>
2002512a:	2101      	movs	r1, #1
2002512c:	2206      	movs	r2, #6
2002512e:	4608      	mov	r0, r1
20025130:	f7ff ffa6 	bl	20025080 <HAL_RCC_HCPU_SetDiv>
20025134:	2103      	movs	r1, #3
20025136:	4620      	mov	r0, r4
20025138:	f7ff ff7e 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
2002513c:	e7e4      	b.n	20025108 <HAL_RCC_HCPU_SwitchDvfsD2S+0x34>
2002513e:	bf00      	nop
20025140:	5000b000 	.word	0x5000b000
20025144:	2002b8ac 	.word	0x2002b8ac
20025148:	000f4240 	.word	0x000f4240

2002514c <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0>:
2002514c:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
20025150:	4c1d      	ldr	r4, [pc, #116]	@ (200251c8 <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x7c>)
20025152:	4f1e      	ldr	r7, [pc, #120]	@ (200251cc <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x80>)
20025154:	eb04 02c0 	add.w	r2, r4, r0, lsl #3
20025158:	6b3b      	ldr	r3, [r7, #48]	@ 0x30
2002515a:	7892      	ldrb	r2, [r2, #2]
2002515c:	4605      	mov	r5, r0
2002515e:	f362 5317 	bfi	r3, r2, #20, #4
20025162:	ea4f 08c0 	mov.w	r8, r0, lsl #3
20025166:	633b      	str	r3, [r7, #48]	@ 0x30
20025168:	f10d 0007 	add.w	r0, sp, #7
2002516c:	460e      	mov	r6, r1
2002516e:	f007 f91f 	bl	2002c3b0 <HAL_PMU_GetHpsysVoutRef>
20025172:	b110      	cbz	r0, 2002517a <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x2e>
20025174:	230b      	movs	r3, #11
20025176:	f88d 3007 	strb.w	r3, [sp, #7]
2002517a:	f89d 1007 	ldrb.w	r1, [sp, #7]
2002517e:	f914 2035 	ldrsb.w	r2, [r4, r5, lsl #3]
20025182:	6cfb      	ldr	r3, [r7, #76]	@ 0x4c
20025184:	440a      	add	r2, r1
20025186:	2100      	movs	r1, #0
20025188:	f362 0385 	bfi	r3, r2, #2, #4
2002518c:	4608      	mov	r0, r1
2002518e:	64fb      	str	r3, [r7, #76]	@ 0x4c
20025190:	f7ff ff52 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20025194:	2e30      	cmp	r6, #48	@ 0x30
20025196:	d900      	bls.n	2002519a <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x4e>
20025198:	e7fe      	b.n	20025198 <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x4c>
2002519a:	2030      	movs	r0, #48	@ 0x30
2002519c:	2204      	movs	r2, #4
2002519e:	2100      	movs	r1, #0
200251a0:	fbb0 f0f6 	udiv	r0, r0, r6
200251a4:	f7ff ff6c 	bl	20025080 <HAL_RCC_HCPU_SetDiv>
200251a8:	f7ff ff12 	bl	20024fd0 <HAL_RCC_HCPU_DisableDLL1>
200251ac:	f7fd fcc6 	bl	20022b3c <HAL_HPAON_DisableXT48>
200251b0:	4444      	add	r4, r8
200251b2:	4b07      	ldr	r3, [pc, #28]	@ (200251d0 <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0+0x84>)
200251b4:	6862      	ldr	r2, [r4, #4]
200251b6:	61da      	str	r2, [r3, #28]
200251b8:	691a      	ldr	r2, [r3, #16]
200251ba:	f042 0204 	orr.w	r2, r2, #4
200251be:	611a      	str	r2, [r3, #16]
200251c0:	b002      	add	sp, #8
200251c2:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
200251c6:	bf00      	nop
200251c8:	2002b8ac 	.word	0x2002b8ac
200251cc:	500ca000 	.word	0x500ca000
200251d0:	5000b000 	.word	0x5000b000

200251d4 <HAL_RCC_HCPU_ConfigDvfs>:
200251d4:	b570      	push	{r4, r5, r6, lr}
200251d6:	4e31      	ldr	r6, [pc, #196]	@ (2002529c <HAL_RCC_HCPU_ConfigDvfs+0xc8>)
200251d8:	4605      	mov	r5, r0
200251da:	7833      	ldrb	r3, [r6, #0]
200251dc:	460c      	mov	r4, r1
200251de:	2b01      	cmp	r3, #1
200251e0:	d943      	bls.n	2002526a <HAL_RCC_HCPU_ConfigDvfs+0x96>
200251e2:	3b02      	subs	r3, #2
200251e4:	2b01      	cmp	r3, #1
200251e6:	d902      	bls.n	200251ee <HAL_RCC_HCPU_ConfigDvfs+0x1a>
200251e8:	2501      	movs	r5, #1
200251ea:	4628      	mov	r0, r5
200251ec:	bd70      	pop	{r4, r5, r6, pc}
200251ee:	4b2c      	ldr	r3, [pc, #176]	@ (200252a0 <HAL_RCC_HCPU_ConfigDvfs+0xcc>)
200251f0:	f853 2021 	ldr.w	r2, [r3, r1, lsl #2]
200251f4:	f7ff fe8d 	bl	20024f12 <HAL_RCC_HCPU_GetDLL2Freq>
200251f8:	4290      	cmp	r0, r2
200251fa:	d8f5      	bhi.n	200251e8 <HAL_RCC_HCPU_ConfigDvfs+0x14>
200251fc:	2901      	cmp	r1, #1
200251fe:	d805      	bhi.n	2002520c <HAL_RCC_HCPU_ConfigDvfs+0x38>
20025200:	4629      	mov	r1, r5
20025202:	4620      	mov	r0, r4
20025204:	f7ff ffa2 	bl	2002514c <HAL_RCC_HCPU_SwitchDvfsS2D.isra.0>
20025208:	2500      	movs	r5, #0
2002520a:	e035      	b.n	20025278 <HAL_RCC_HCPU_ConfigDvfs+0xa4>
2002520c:	2100      	movs	r1, #0
2002520e:	4608      	mov	r0, r1
20025210:	f7ff ff12 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20025214:	4620      	mov	r0, r4
20025216:	f7ff fe1b 	bl	20024e50 <HAL_RCC_HCPU_ConfigSxModeVolt>
2002521a:	20fa      	movs	r0, #250	@ 0xfa
2002521c:	f7fc fe6d 	bl	20021efa <HAL_Delay_us>
20025220:	f7ff fed6 	bl	20024fd0 <HAL_RCC_HCPU_DisableDLL1>
20025224:	2d30      	cmp	r5, #48	@ 0x30
20025226:	d80d      	bhi.n	20025244 <HAL_RCC_HCPU_ConfigDvfs+0x70>
20025228:	f7fd fc88 	bl	20022b3c <HAL_HPAON_DisableXT48>
2002522c:	2100      	movs	r1, #0
2002522e:	4608      	mov	r0, r1
20025230:	f7ff ff02 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20025234:	2204      	movs	r2, #4
20025236:	2100      	movs	r1, #0
20025238:	2030      	movs	r0, #48	@ 0x30
2002523a:	fbb0 f0f5 	udiv	r0, r0, r5
2002523e:	f7ff ff1f 	bl	20025080 <HAL_RCC_HCPU_SetDiv>
20025242:	e7e1      	b.n	20025208 <HAL_RCC_HCPU_ConfigDvfs+0x34>
20025244:	f7fd fc6e 	bl	20022b24 <HAL_HPAON_EnableXT48>
20025248:	4816      	ldr	r0, [pc, #88]	@ (200252a4 <HAL_RCC_HCPU_ConfigDvfs+0xd0>)
2002524a:	4368      	muls	r0, r5
2002524c:	f7ff feb8 	bl	20024fc0 <HAL_RCC_HCPU_EnableDLL1>
20025250:	4605      	mov	r5, r0
20025252:	2800      	cmp	r0, #0
20025254:	d1c8      	bne.n	200251e8 <HAL_RCC_HCPU_ConfigDvfs+0x14>
20025256:	2101      	movs	r1, #1
20025258:	2206      	movs	r2, #6
2002525a:	4608      	mov	r0, r1
2002525c:	f7ff ff10 	bl	20025080 <HAL_RCC_HCPU_SetDiv>
20025260:	2103      	movs	r1, #3
20025262:	4628      	mov	r0, r5
20025264:	f7ff fee8 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
20025268:	e7ce      	b.n	20025208 <HAL_RCC_HCPU_ConfigDvfs+0x34>
2002526a:	2901      	cmp	r1, #1
2002526c:	d909      	bls.n	20025282 <HAL_RCC_HCPU_ConfigDvfs+0xae>
2002526e:	4601      	mov	r1, r0
20025270:	4620      	mov	r0, r4
20025272:	f7ff ff2f 	bl	200250d4 <HAL_RCC_HCPU_SwitchDvfsD2S>
20025276:	4605      	mov	r5, r0
20025278:	2000      	movs	r0, #0
2002527a:	7034      	strb	r4, [r6, #0]
2002527c:	f7fc fe3d 	bl	20021efa <HAL_Delay_us>
20025280:	e7b3      	b.n	200251ea <HAL_RCC_HCPU_ConfigDvfs+0x16>
20025282:	428b      	cmp	r3, r1
20025284:	d103      	bne.n	2002528e <HAL_RCC_HCPU_ConfigDvfs+0xba>
20025286:	f04f 32ff 	mov.w	r2, #4294967295
2002528a:	4611      	mov	r1, r2
2002528c:	e7d4      	b.n	20025238 <HAL_RCC_HCPU_ConfigDvfs+0x64>
2002528e:	2190      	movs	r1, #144	@ 0x90
20025290:	2002      	movs	r0, #2
20025292:	f7ff ff1f 	bl	200250d4 <HAL_RCC_HCPU_SwitchDvfsD2S>
20025296:	2800      	cmp	r0, #0
20025298:	d1a6      	bne.n	200251e8 <HAL_RCC_HCPU_ConfigDvfs+0x14>
2002529a:	e7b1      	b.n	20025200 <HAL_RCC_HCPU_ConfigDvfs+0x2c>
2002529c:	20042c14 	.word	0x20042c14
200252a0:	2002b89c 	.word	0x2002b89c
200252a4:	000f4240 	.word	0x000f4240

200252a8 <HAL_RCC_Reset_and_Halt_LCPU>:
200252a8:	4a13      	ldr	r2, [pc, #76]	@ (200252f8 <HAL_RCC_Reset_and_Halt_LCPU+0x50>)
200252aa:	6813      	ldr	r3, [r2, #0]
200252ac:	0759      	lsls	r1, r3, #29
200252ae:	d421      	bmi.n	200252f4 <HAL_RCC_Reset_and_Halt_LCPU+0x4c>
200252b0:	6811      	ldr	r1, [r2, #0]
200252b2:	2800      	cmp	r0, #0
200252b4:	bf0c      	ite	eq
200252b6:	2301      	moveq	r3, #1
200252b8:	f04f 33ff 	movne.w	r3, #4294967295
200252bc:	f041 0104 	orr.w	r1, r1, #4
200252c0:	6011      	str	r1, [r2, #0]
200252c2:	f04f 4280 	mov.w	r2, #1073741824	@ 0x40000000
200252c6:	f443 1380 	orr.w	r3, r3, #1048576	@ 0x100000
200252ca:	6013      	str	r3, [r2, #0]
200252cc:	6811      	ldr	r1, [r2, #0]
200252ce:	2900      	cmp	r1, #0
200252d0:	d0fc      	beq.n	200252cc <HAL_RCC_Reset_and_Halt_LCPU+0x24>
200252d2:	4a09      	ldr	r2, [pc, #36]	@ (200252f8 <HAL_RCC_Reset_and_Halt_LCPU+0x50>)
200252d4:	6c11      	ldr	r1, [r2, #64]	@ 0x40
200252d6:	06c8      	lsls	r0, r1, #27
200252d8:	d506      	bpl.n	200252e8 <HAL_RCC_Reset_and_Halt_LCPU+0x40>
200252da:	6c11      	ldr	r1, [r2, #64]	@ 0x40
200252dc:	f041 0102 	orr.w	r1, r1, #2
200252e0:	6411      	str	r1, [r2, #64]	@ 0x40
200252e2:	6c11      	ldr	r1, [r2, #64]	@ 0x40
200252e4:	06c9      	lsls	r1, r1, #27
200252e6:	d4fc      	bmi.n	200252e2 <HAL_RCC_Reset_and_Halt_LCPU+0x3a>
200252e8:	f04f 4180 	mov.w	r1, #1073741824	@ 0x40000000
200252ec:	680a      	ldr	r2, [r1, #0]
200252ee:	ea22 0303 	bic.w	r3, r2, r3
200252f2:	600b      	str	r3, [r1, #0]
200252f4:	4770      	bx	lr
200252f6:	bf00      	nop
200252f8:	40040000 	.word	0x40040000

200252fc <HAL_RCC_HCPU_ConfigHCLK>:
200252fc:	28f0      	cmp	r0, #240	@ 0xf0
200252fe:	d80d      	bhi.n	2002531c <HAL_RCC_HCPU_ConfigHCLK+0x20>
20025300:	2890      	cmp	r0, #144	@ 0x90
20025302:	d807      	bhi.n	20025314 <HAL_RCC_HCPU_ConfigHCLK+0x18>
20025304:	2830      	cmp	r0, #48	@ 0x30
20025306:	d807      	bhi.n	20025318 <HAL_RCC_HCPU_ConfigHCLK+0x1c>
20025308:	2818      	cmp	r0, #24
2002530a:	bf94      	ite	ls
2002530c:	2100      	movls	r1, #0
2002530e:	2101      	movhi	r1, #1
20025310:	f7ff bf60 	b.w	200251d4 <HAL_RCC_HCPU_ConfigDvfs>
20025314:	2103      	movs	r1, #3
20025316:	e7fb      	b.n	20025310 <HAL_RCC_HCPU_ConfigHCLK+0x14>
20025318:	2102      	movs	r1, #2
2002531a:	e7f9      	b.n	20025310 <HAL_RCC_HCPU_ConfigHCLK+0x14>
2002531c:	2001      	movs	r0, #1
2002531e:	4770      	bx	lr

20025320 <spi_flash_get_rdid>:
20025320:	b5f0      	push	{r4, r5, r6, r7, lr}
20025322:	4605      	mov	r5, r0
20025324:	3801      	subs	r0, #1
20025326:	b2c0      	uxtb	r0, r0
20025328:	28fd      	cmp	r0, #253	@ 0xfd
2002532a:	d808      	bhi.n	2002533e <spi_flash_get_rdid+0x1e>
2002532c:	2400      	movs	r4, #0
2002532e:	4f0b      	ldr	r7, [pc, #44]	@ (2002535c <spi_flash_get_rdid+0x3c>)
20025330:	f857 0b04 	ldr.w	r0, [r7], #4
20025334:	7806      	ldrb	r6, [r0, #0]
20025336:	b926      	cbnz	r6, 20025342 <spi_flash_get_rdid+0x22>
20025338:	3401      	adds	r4, #1
2002533a:	2c06      	cmp	r4, #6
2002533c:	d1f8      	bne.n	20025330 <spi_flash_get_rdid+0x10>
2002533e:	2000      	movs	r0, #0
20025340:	e00b      	b.n	2002535a <spi_flash_get_rdid+0x3a>
20025342:	42ae      	cmp	r6, r5
20025344:	d105      	bne.n	20025352 <spi_flash_get_rdid+0x32>
20025346:	7846      	ldrb	r6, [r0, #1]
20025348:	4296      	cmp	r6, r2
2002534a:	d102      	bne.n	20025352 <spi_flash_get_rdid+0x32>
2002534c:	7886      	ldrb	r6, [r0, #2]
2002534e:	428e      	cmp	r6, r1
20025350:	d001      	beq.n	20025356 <spi_flash_get_rdid+0x36>
20025352:	3008      	adds	r0, #8
20025354:	e7ee      	b.n	20025334 <spi_flash_get_rdid+0x14>
20025356:	b103      	cbz	r3, 2002535a <spi_flash_get_rdid+0x3a>
20025358:	701c      	strb	r4, [r3, #0]
2002535a:	bdf0      	pop	{r4, r5, r6, r7, pc}
2002535c:	20042c18 	.word	0x20042c18

20025360 <spi_flash_get_cmd_by_id>:
20025360:	b507      	push	{r0, r1, r2, lr}
20025362:	f10d 0307 	add.w	r3, sp, #7
20025366:	f7ff ffdb 	bl	20025320 <spi_flash_get_rdid>
2002536a:	4b06      	ldr	r3, [pc, #24]	@ (20025384 <spi_flash_get_cmd_by_id+0x24>)
2002536c:	b140      	cbz	r0, 20025380 <spi_flash_get_cmd_by_id+0x20>
2002536e:	f44f 7105 	mov.w	r1, #532	@ 0x214
20025372:	f89d 2007 	ldrb.w	r2, [sp, #7]
20025376:	fb01 3002 	mla	r0, r1, r2, r3
2002537a:	b003      	add	sp, #12
2002537c:	f85d fb04 	ldr.w	pc, [sp], #4
20025380:	4618      	mov	r0, r3
20025382:	e7fa      	b.n	2002537a <spi_flash_get_cmd_by_id+0x1a>
20025384:	20042e30 	.word	0x20042e30

20025388 <spi_flash_get_size_by_id>:
20025388:	b508      	push	{r3, lr}
2002538a:	2300      	movs	r3, #0
2002538c:	f7ff ffc8 	bl	20025320 <spi_flash_get_rdid>
20025390:	b108      	cbz	r0, 20025396 <spi_flash_get_size_by_id+0xe>
20025392:	6840      	ldr	r0, [r0, #4]
20025394:	bd08      	pop	{r3, pc}
20025396:	f44f 2000 	mov.w	r0, #524288	@ 0x80000
2002539a:	e7fb      	b.n	20025394 <spi_flash_get_size_by_id+0xc>

2002539c <spi_flash_is_support_dtr>:
2002539c:	b508      	push	{r3, lr}
2002539e:	2300      	movs	r3, #0
200253a0:	f7ff ffbe 	bl	20025320 <spi_flash_get_rdid>
200253a4:	b110      	cbz	r0, 200253ac <spi_flash_is_support_dtr+0x10>
200253a6:	78c0      	ldrb	r0, [r0, #3]
200253a8:	f000 0001 	and.w	r0, r0, #1
200253ac:	bd08      	pop	{r3, pc}
	...

200253b0 <spi_nand_get_rdid>:
200253b0:	b5f0      	push	{r4, r5, r6, r7, lr}
200253b2:	4605      	mov	r5, r0
200253b4:	3801      	subs	r0, #1
200253b6:	b2c0      	uxtb	r0, r0
200253b8:	28fd      	cmp	r0, #253	@ 0xfd
200253ba:	d808      	bhi.n	200253ce <spi_nand_get_rdid+0x1e>
200253bc:	2400      	movs	r4, #0
200253be:	4f0b      	ldr	r7, [pc, #44]	@ (200253ec <spi_nand_get_rdid+0x3c>)
200253c0:	f857 0b04 	ldr.w	r0, [r7], #4
200253c4:	7806      	ldrb	r6, [r0, #0]
200253c6:	b926      	cbnz	r6, 200253d2 <spi_nand_get_rdid+0x22>
200253c8:	3401      	adds	r4, #1
200253ca:	2c06      	cmp	r4, #6
200253cc:	d1f8      	bne.n	200253c0 <spi_nand_get_rdid+0x10>
200253ce:	2000      	movs	r0, #0
200253d0:	e00b      	b.n	200253ea <spi_nand_get_rdid+0x3a>
200253d2:	42ae      	cmp	r6, r5
200253d4:	d105      	bne.n	200253e2 <spi_nand_get_rdid+0x32>
200253d6:	7846      	ldrb	r6, [r0, #1]
200253d8:	4296      	cmp	r6, r2
200253da:	d102      	bne.n	200253e2 <spi_nand_get_rdid+0x32>
200253dc:	7886      	ldrb	r6, [r0, #2]
200253de:	428e      	cmp	r6, r1
200253e0:	d001      	beq.n	200253e6 <spi_nand_get_rdid+0x36>
200253e2:	3008      	adds	r0, #8
200253e4:	e7ee      	b.n	200253c4 <spi_nand_get_rdid+0x14>
200253e6:	b103      	cbz	r3, 200253ea <spi_nand_get_rdid+0x3a>
200253e8:	701c      	strb	r4, [r3, #0]
200253ea:	bdf0      	pop	{r4, r5, r6, r7, pc}
200253ec:	20043aa8 	.word	0x20043aa8

200253f0 <spi_nand_get_cmd_by_id>:
200253f0:	b507      	push	{r0, r1, r2, lr}
200253f2:	f10d 0307 	add.w	r3, sp, #7
200253f6:	f7ff ffdb 	bl	200253b0 <spi_nand_get_rdid>
200253fa:	b130      	cbz	r0, 2002540a <spi_nand_get_cmd_by_id+0x1a>
200253fc:	f44f 7205 	mov.w	r2, #532	@ 0x214
20025400:	f89d 3007 	ldrb.w	r3, [sp, #7]
20025404:	4802      	ldr	r0, [pc, #8]	@ (20025410 <spi_nand_get_cmd_by_id+0x20>)
20025406:	fb02 0003 	mla	r0, r2, r3, r0
2002540a:	b003      	add	sp, #12
2002540c:	f85d fb04 	ldr.w	pc, [sp], #4
20025410:	20043c88 	.word	0x20043c88

20025414 <HAL_GET_FLASH_DEFAUT_INX>:
20025414:	f04f 30ff 	mov.w	r0, #4294967295
20025418:	4770      	bx	lr
	...

2002541c <spi_nand_get_default_ctable>:
2002541c:	b508      	push	{r3, lr}
2002541e:	f7ff fff9 	bl	20025414 <HAL_GET_FLASH_DEFAUT_INX>
20025422:	1e03      	subs	r3, r0, #0
20025424:	bfa5      	ittet	ge
20025426:	f44f 7205 	movge.w	r2, #532	@ 0x214
2002542a:	4802      	ldrge	r0, [pc, #8]	@ (20025434 <spi_nand_get_default_ctable+0x18>)
2002542c:	2000      	movlt	r0, #0
2002542e:	fb02 0003 	mlage	r0, r2, r3, r0
20025432:	bd08      	pop	{r3, pc}
20025434:	20043c88 	.word	0x20043c88

20025438 <spi_nand_get_size_by_id>:
20025438:	b508      	push	{r3, lr}
2002543a:	2300      	movs	r3, #0
2002543c:	f7ff ffb8 	bl	200253b0 <spi_nand_get_rdid>
20025440:	b108      	cbz	r0, 20025446 <spi_nand_get_size_by_id+0xe>
20025442:	6840      	ldr	r0, [r0, #4]
20025444:	bd08      	pop	{r3, pc}
20025446:	f04f 6080 	mov.w	r0, #67108864	@ 0x4000000
2002544a:	e7fb      	b.n	20025444 <spi_nand_get_size_by_id+0xc>

2002544c <spi_nand_get_plane_select_flag>:
2002544c:	b508      	push	{r3, lr}
2002544e:	2300      	movs	r3, #0
20025450:	f7ff ffae 	bl	200253b0 <spi_nand_get_rdid>
20025454:	b110      	cbz	r0, 2002545c <spi_nand_get_plane_select_flag+0x10>
20025456:	78c0      	ldrb	r0, [r0, #3]
20025458:	f3c0 0040 	ubfx	r0, r0, #1, #1
2002545c:	bd08      	pop	{r3, pc}

2002545e <spi_nand_get_big_page_flag>:
2002545e:	b508      	push	{r3, lr}
20025460:	2300      	movs	r3, #0
20025462:	f7ff ffa5 	bl	200253b0 <spi_nand_get_rdid>
20025466:	b110      	cbz	r0, 2002546e <spi_nand_get_big_page_flag+0x10>
20025468:	78c0      	ldrb	r0, [r0, #3]
2002546a:	f3c0 0081 	ubfx	r0, r0, #2, #2
2002546e:	bd08      	pop	{r3, pc}

20025470 <spi_nand_get_ecc_mode>:
20025470:	b508      	push	{r3, lr}
20025472:	2300      	movs	r3, #0
20025474:	f7ff ff9c 	bl	200253b0 <spi_nand_get_rdid>
20025478:	b108      	cbz	r0, 2002547e <spi_nand_get_ecc_mode+0xe>
2002547a:	78c0      	ldrb	r0, [r0, #3]
2002547c:	0900      	lsrs	r0, r0, #4
2002547e:	bd08      	pop	{r3, pc}

20025480 <bbm_map_check.part.0>:
20025480:	b5f7      	push	{r0, r1, r2, r4, r5, r6, r7, lr}
20025482:	4b21      	ldr	r3, [pc, #132]	@ (20025508 <bbm_map_check.part.0+0x88>)
20025484:	4606      	mov	r6, r0
20025486:	681d      	ldr	r5, [r3, #0]
20025488:	4b20      	ldr	r3, [pc, #128]	@ (2002550c <bbm_map_check.part.0+0x8c>)
2002548a:	3d04      	subs	r5, #4
2002548c:	681f      	ldr	r7, [r3, #0]
2002548e:	2300      	movs	r3, #0
20025490:	f100 0e1a 	add.w	lr, r0, #26
20025494:	42ab      	cmp	r3, r5
20025496:	db02      	blt.n	2002549e <bbm_map_check.part.0+0x1e>
20025498:	2000      	movs	r0, #0
2002549a:	b003      	add	sp, #12
2002549c:	bdf0      	pop	{r4, r5, r6, r7, pc}
2002549e:	8b31      	ldrh	r1, [r6, #24]
200254a0:	b321      	cbz	r1, 200254ec <bbm_map_check.part.0+0x6c>
200254a2:	8b72      	ldrh	r2, [r6, #26]
200254a4:	b33a      	cbz	r2, 200254f6 <bbm_map_check.part.0+0x76>
200254a6:	42b9      	cmp	r1, r7
200254a8:	d201      	bcs.n	200254ae <bbm_map_check.part.0+0x2e>
200254aa:	4297      	cmp	r7, r2
200254ac:	d905      	bls.n	200254ba <bbm_map_check.part.0+0x3a>
200254ae:	4b18      	ldr	r3, [pc, #96]	@ (20025510 <bbm_map_check.part.0+0x90>)
200254b0:	681b      	ldr	r3, [r3, #0]
200254b2:	b10b      	cbz	r3, 200254b8 <bbm_map_check.part.0+0x38>
200254b4:	4817      	ldr	r0, [pc, #92]	@ (20025514 <bbm_map_check.part.0+0x94>)
200254b6:	4798      	blx	r3
200254b8:	e7fe      	b.n	200254b8 <bbm_map_check.part.0+0x38>
200254ba:	3301      	adds	r3, #1
200254bc:	461c      	mov	r4, r3
200254be:	42ac      	cmp	r4, r5
200254c0:	db01      	blt.n	200254c6 <bbm_map_check.part.0+0x46>
200254c2:	3604      	adds	r6, #4
200254c4:	e7e6      	b.n	20025494 <bbm_map_check.part.0+0x14>
200254c6:	f83e c024 	ldrh.w	ip, [lr, r4, lsl #2]
200254ca:	f1bc 0f00 	cmp.w	ip, #0
200254ce:	d0f8      	beq.n	200254c2 <bbm_map_check.part.0+0x42>
200254d0:	4562      	cmp	r2, ip
200254d2:	d109      	bne.n	200254e8 <bbm_map_check.part.0+0x68>
200254d4:	4b0e      	ldr	r3, [pc, #56]	@ (20025510 <bbm_map_check.part.0+0x90>)
200254d6:	681d      	ldr	r5, [r3, #0]
200254d8:	b12d      	cbz	r5, 200254e6 <bbm_map_check.part.0+0x66>
200254da:	3406      	adds	r4, #6
200254dc:	f830 3024 	ldrh.w	r3, [r0, r4, lsl #2]
200254e0:	480d      	ldr	r0, [pc, #52]	@ (20025518 <bbm_map_check.part.0+0x98>)
200254e2:	9200      	str	r2, [sp, #0]
200254e4:	47a8      	blx	r5
200254e6:	e7fe      	b.n	200254e6 <bbm_map_check.part.0+0x66>
200254e8:	3401      	adds	r4, #1
200254ea:	e7e8      	b.n	200254be <bbm_map_check.part.0+0x3e>
200254ec:	eb00 0283 	add.w	r2, r0, r3, lsl #2
200254f0:	8b52      	ldrh	r2, [r2, #26]
200254f2:	2a00      	cmp	r2, #0
200254f4:	d0d0      	beq.n	20025498 <bbm_map_check.part.0+0x18>
200254f6:	4a06      	ldr	r2, [pc, #24]	@ (20025510 <bbm_map_check.part.0+0x90>)
200254f8:	6814      	ldr	r4, [r2, #0]
200254fa:	b124      	cbz	r4, 20025506 <bbm_map_check.part.0+0x86>
200254fc:	eb00 0383 	add.w	r3, r0, r3, lsl #2
20025500:	8b5a      	ldrh	r2, [r3, #26]
20025502:	4806      	ldr	r0, [pc, #24]	@ (2002551c <bbm_map_check.part.0+0x9c>)
20025504:	47a0      	blx	r4
20025506:	e7fe      	b.n	20025506 <bbm_map_check.part.0+0x86>
20025508:	20049f84 	.word	0x20049f84
2002550c:	20049f88 	.word	0x20049f88
20025510:	20049f74 	.word	0x20049f74
20025514:	2002aa3c 	.word	0x2002aa3c
20025518:	2002aa59 	.word	0x2002aa59
2002551c:	2002aaa6 	.word	0x2002aaa6

20025520 <bbm_crc_check>:
20025520:	f04f 32ff 	mov.w	r2, #4294967295
20025524:	b510      	push	{r4, lr}
20025526:	4c07      	ldr	r4, [pc, #28]	@ (20025544 <bbm_crc_check+0x24>)
20025528:	4401      	add	r1, r0
2002552a:	4288      	cmp	r0, r1
2002552c:	d101      	bne.n	20025532 <bbm_crc_check+0x12>
2002552e:	43d0      	mvns	r0, r2
20025530:	bd10      	pop	{r4, pc}
20025532:	f810 3b01 	ldrb.w	r3, [r0], #1
20025536:	4053      	eors	r3, r2
20025538:	b2db      	uxtb	r3, r3
2002553a:	f854 3023 	ldr.w	r3, [r4, r3, lsl #2]
2002553e:	ea83 2212 	eor.w	r2, r3, r2, lsr #8
20025542:	e7f2      	b.n	2002552a <bbm_crc_check+0xa>
20025544:	2002b8cc 	.word	0x2002b8cc

20025548 <bbm_get_phy_blk>:
20025548:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
2002554a:	4b14      	ldr	r3, [pc, #80]	@ (2002559c <bbm_get_phy_blk+0x54>)
2002554c:	4601      	mov	r1, r0
2002554e:	681e      	ldr	r6, [r3, #0]
20025550:	42b0      	cmp	r0, r6
20025552:	d21e      	bcs.n	20025592 <bbm_get_phy_blk+0x4a>
20025554:	b138      	cbz	r0, 20025566 <bbm_get_phy_blk+0x1e>
20025556:	4b12      	ldr	r3, [pc, #72]	@ (200255a0 <bbm_get_phy_blk+0x58>)
20025558:	2200      	movs	r2, #0
2002555a:	681c      	ldr	r4, [r3, #0]
2002555c:	4b11      	ldr	r3, [pc, #68]	@ (200255a4 <bbm_get_phy_blk+0x5c>)
2002555e:	3c04      	subs	r4, #4
20025560:	461d      	mov	r5, r3
20025562:	4294      	cmp	r4, r2
20025564:	dc00      	bgt.n	20025568 <bbm_get_phy_blk+0x20>
20025566:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20025568:	8b1f      	ldrh	r7, [r3, #24]
2002556a:	428f      	cmp	r7, r1
2002556c:	d10a      	bne.n	20025584 <bbm_get_phy_blk+0x3c>
2002556e:	eb05 0582 	add.w	r5, r5, r2, lsl #2
20025572:	8b6a      	ldrh	r2, [r5, #26]
20025574:	4296      	cmp	r6, r2
20025576:	dd0f      	ble.n	20025598 <bbm_get_phy_blk+0x50>
20025578:	4b0b      	ldr	r3, [pc, #44]	@ (200255a8 <bbm_get_phy_blk+0x60>)
2002557a:	681b      	ldr	r3, [r3, #0]
2002557c:	b10b      	cbz	r3, 20025582 <bbm_get_phy_blk+0x3a>
2002557e:	480b      	ldr	r0, [pc, #44]	@ (200255ac <bbm_get_phy_blk+0x64>)
20025580:	4798      	blx	r3
20025582:	e7fe      	b.n	20025582 <bbm_get_phy_blk+0x3a>
20025584:	b917      	cbnz	r7, 2002558c <bbm_get_phy_blk+0x44>
20025586:	8b5f      	ldrh	r7, [r3, #26]
20025588:	2f00      	cmp	r7, #0
2002558a:	d0ec      	beq.n	20025566 <bbm_get_phy_blk+0x1e>
2002558c:	3201      	adds	r2, #1
2002558e:	3304      	adds	r3, #4
20025590:	e7e7      	b.n	20025562 <bbm_get_phy_blk+0x1a>
20025592:	f04f 30ff 	mov.w	r0, #4294967295
20025596:	e7e6      	b.n	20025566 <bbm_get_phy_blk+0x1e>
20025598:	4610      	mov	r0, r2
2002559a:	e7e4      	b.n	20025566 <bbm_get_phy_blk+0x1e>
2002559c:	20049f88 	.word	0x20049f88
200255a0:	20049f84 	.word	0x20049f84
200255a4:	20049f8c 	.word	0x20049f8c
200255a8:	20049f74 	.word	0x20049f74
200255ac:	2002aac4 	.word	0x2002aac4

200255b0 <bbm_get_version_inblk>:
200255b0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200255b4:	4607      	mov	r7, r0
200255b6:	4688      	mov	r8, r1
200255b8:	b087      	sub	sp, #28
200255ba:	2900      	cmp	r1, #0
200255bc:	d14b      	bne.n	20025656 <bbm_get_version_inblk+0xa6>
200255be:	2500      	movs	r5, #0
200255c0:	4628      	mov	r0, r5
200255c2:	b007      	add	sp, #28
200255c4:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
200255c8:	2200      	movs	r2, #0
200255ca:	e9cd 2201 	strd	r2, r2, [sp, #4]
200255ce:	4e26      	ldr	r6, [pc, #152]	@ (20025668 <bbm_get_version_inblk+0xb8>)
200255d0:	9100      	str	r1, [sp, #0]
200255d2:	4638      	mov	r0, r7
200255d4:	4621      	mov	r1, r4
200255d6:	6833      	ldr	r3, [r6, #0]
200255d8:	f7fb fad6 	bl	20020b88 <port_read_page>
200255dc:	2800      	cmp	r0, #0
200255de:	dd32      	ble.n	20025646 <bbm_get_version_inblk+0x96>
200255e0:	6832      	ldr	r2, [r6, #0]
200255e2:	6813      	ldr	r3, [r2, #0]
200255e4:	455b      	cmp	r3, fp
200255e6:	d123      	bne.n	20025630 <bbm_get_version_inblk+0x80>
200255e8:	6856      	ldr	r6, [r2, #4]
200255ea:	f3c6 061e 	ubfx	r6, r6, #0, #31
200255ee:	42ae      	cmp	r6, r5
200255f0:	dd15      	ble.n	2002561e <bbm_get_version_inblk+0x6e>
200255f2:	4610      	mov	r0, r2
200255f4:	2110      	movs	r1, #16
200255f6:	9205      	str	r2, [sp, #20]
200255f8:	f7ff ff92 	bl	20025520 <bbm_crc_check>
200255fc:	9a05      	ldr	r2, [sp, #20]
200255fe:	6913      	ldr	r3, [r2, #16]
20025600:	4283      	cmp	r3, r0
20025602:	d113      	bne.n	2002562c <bbm_get_version_inblk+0x7c>
20025604:	f8c8 4000 	str.w	r4, [r8]
20025608:	4635      	mov	r5, r6
2002560a:	3401      	adds	r4, #1
2002560c:	f8da 1000 	ldr.w	r1, [sl]
20025610:	f8d9 3000 	ldr.w	r3, [r9]
20025614:	fbb3 f3f1 	udiv	r3, r3, r1
20025618:	42a3      	cmp	r3, r4
2002561a:	d8d5      	bhi.n	200255c8 <bbm_get_version_inblk+0x18>
2002561c:	e7d0      	b.n	200255c0 <bbm_get_version_inblk+0x10>
2002561e:	4b13      	ldr	r3, [pc, #76]	@ (2002566c <bbm_get_version_inblk+0xbc>)
20025620:	681b      	ldr	r3, [r3, #0]
20025622:	b11b      	cbz	r3, 2002562c <bbm_get_version_inblk+0x7c>
20025624:	4632      	mov	r2, r6
20025626:	4629      	mov	r1, r5
20025628:	4811      	ldr	r0, [pc, #68]	@ (20025670 <bbm_get_version_inblk+0xc0>)
2002562a:	4798      	blx	r3
2002562c:	462e      	mov	r6, r5
2002562e:	e7eb      	b.n	20025608 <bbm_get_version_inblk+0x58>
20025630:	1c5a      	adds	r2, r3, #1
20025632:	d0c5      	beq.n	200255c0 <bbm_get_version_inblk+0x10>
20025634:	4a0d      	ldr	r2, [pc, #52]	@ (2002566c <bbm_get_version_inblk+0xbc>)
20025636:	6815      	ldr	r5, [r2, #0]
20025638:	2d00      	cmp	r5, #0
2002563a:	d0c0      	beq.n	200255be <bbm_get_version_inblk+0xe>
2002563c:	4622      	mov	r2, r4
2002563e:	4639      	mov	r1, r7
20025640:	480c      	ldr	r0, [pc, #48]	@ (20025674 <bbm_get_version_inblk+0xc4>)
20025642:	47a8      	blx	r5
20025644:	e7bb      	b.n	200255be <bbm_get_version_inblk+0xe>
20025646:	4b09      	ldr	r3, [pc, #36]	@ (2002566c <bbm_get_version_inblk+0xbc>)
20025648:	681b      	ldr	r3, [r3, #0]
2002564a:	2b00      	cmp	r3, #0
2002564c:	d0ee      	beq.n	2002562c <bbm_get_version_inblk+0x7c>
2002564e:	4622      	mov	r2, r4
20025650:	4639      	mov	r1, r7
20025652:	4809      	ldr	r0, [pc, #36]	@ (20025678 <bbm_get_version_inblk+0xc8>)
20025654:	e7e9      	b.n	2002562a <bbm_get_version_inblk+0x7a>
20025656:	2400      	movs	r4, #0
20025658:	f8df a020 	ldr.w	sl, [pc, #32]	@ 2002567c <bbm_get_version_inblk+0xcc>
2002565c:	4625      	mov	r5, r4
2002565e:	f8df 9020 	ldr.w	r9, [pc, #32]	@ 20025680 <bbm_get_version_inblk+0xd0>
20025662:	f8df b020 	ldr.w	fp, [pc, #32]	@ 20025684 <bbm_get_version_inblk+0xd4>
20025666:	e7d1      	b.n	2002560c <bbm_get_version_inblk+0x5c>
20025668:	20049f78 	.word	0x20049f78
2002566c:	20049f74 	.word	0x20049f74
20025670:	2002aae3 	.word	0x2002aae3
20025674:	2002ab10 	.word	0x2002ab10
20025678:	2002ab41 	.word	0x2002ab41
2002567c:	20044900 	.word	0x20044900
20025680:	20044904 	.word	0x20044904
20025684:	5366424d 	.word	0x5366424d

20025688 <bbm_get_map_table>:
20025688:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
2002568c:	2801      	cmp	r0, #1
2002568e:	4607      	mov	r7, r0
20025690:	f8df b15c 	ldr.w	fp, [pc, #348]	@ 200257f0 <bbm_get_map_table+0x168>
20025694:	b087      	sub	sp, #28
20025696:	dd0a      	ble.n	200256ae <bbm_get_map_table+0x26>
20025698:	f8db 3000 	ldr.w	r3, [fp]
2002569c:	b91b      	cbnz	r3, 200256a6 <bbm_get_map_table+0x1e>
2002569e:	2000      	movs	r0, #0
200256a0:	b007      	add	sp, #28
200256a2:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
200256a6:	4601      	mov	r1, r0
200256a8:	4847      	ldr	r0, [pc, #284]	@ (200257c8 <bbm_get_map_table+0x140>)
200256aa:	4798      	blx	r3
200256ac:	e7f7      	b.n	2002569e <bbm_get_map_table+0x16>
200256ae:	f8df 8144 	ldr.w	r8, [pc, #324]	@ 200257f4 <bbm_get_map_table+0x16c>
200256b2:	2800      	cmp	r0, #0
200256b4:	d163      	bne.n	2002577e <bbm_get_map_table+0xf6>
200256b6:	f8b8 6000 	ldrh.w	r6, [r8]
200256ba:	f8b8 5002 	ldrh.w	r5, [r8, #2]
200256be:	2e00      	cmp	r6, #0
200256c0:	d062      	beq.n	20025788 <bbm_get_map_table+0x100>
200256c2:	4630      	mov	r0, r6
200256c4:	a904      	add	r1, sp, #16
200256c6:	f7ff ff73 	bl	200255b0 <bbm_get_version_inblk>
200256ca:	4681      	mov	r9, r0
200256cc:	2d00      	cmp	r5, #0
200256ce:	d05d      	beq.n	2002578c <bbm_get_map_table+0x104>
200256d0:	4628      	mov	r0, r5
200256d2:	a905      	add	r1, sp, #20
200256d4:	f7ff ff6c 	bl	200255b0 <bbm_get_version_inblk>
200256d8:	4604      	mov	r4, r0
200256da:	f8db a000 	ldr.w	sl, [fp]
200256de:	f1ba 0f00 	cmp.w	sl, #0
200256e2:	d005      	beq.n	200256f0 <bbm_get_map_table+0x68>
200256e4:	4623      	mov	r3, r4
200256e6:	4632      	mov	r2, r6
200256e8:	4649      	mov	r1, r9
200256ea:	4838      	ldr	r0, [pc, #224]	@ (200257cc <bbm_get_map_table+0x144>)
200256ec:	9500      	str	r5, [sp, #0]
200256ee:	47d0      	blx	sl
200256f0:	45a1      	cmp	r9, r4
200256f2:	d0d4      	beq.n	2002569e <bbm_get_map_table+0x16>
200256f4:	f04f 0200 	mov.w	r2, #0
200256f8:	bf98      	it	ls
200256fa:	462e      	movls	r6, r5
200256fc:	f107 0308 	add.w	r3, r7, #8
20025700:	bf94      	ite	ls
20025702:	f828 5013 	strhls.w	r5, [r8, r3, lsl #1]
20025706:	f828 6013 	strhhi.w	r6, [r8, r3, lsl #1]
2002570a:	e9cd 2201 	strd	r2, r2, [sp, #4]
2002570e:	4b30      	ldr	r3, [pc, #192]	@ (200257d0 <bbm_get_map_table+0x148>)
20025710:	bf88      	it	hi
20025712:	f8dd a010 	ldrhi.w	sl, [sp, #16]
20025716:	681b      	ldr	r3, [r3, #0]
20025718:	bf98      	it	ls
2002571a:	f8dd a014 	ldrls.w	sl, [sp, #20]
2002571e:	f8df 80d8 	ldr.w	r8, [pc, #216]	@ 200257f8 <bbm_get_map_table+0x170>
20025722:	9300      	str	r3, [sp, #0]
20025724:	4651      	mov	r1, sl
20025726:	4630      	mov	r0, r6
20025728:	f8d8 3000 	ldr.w	r3, [r8]
2002572c:	bf88      	it	hi
2002572e:	464c      	movhi	r4, r9
20025730:	f7fb fa2a 	bl	20020b88 <port_read_page>
20025734:	2800      	cmp	r0, #0
20025736:	f8db 5000 	ldr.w	r5, [fp]
2002573a:	dd38      	ble.n	200257ae <bbm_get_map_table+0x126>
2002573c:	f8d8 8000 	ldr.w	r8, [r8]
20025740:	4b24      	ldr	r3, [pc, #144]	@ (200257d4 <bbm_get_map_table+0x14c>)
20025742:	f8d8 2000 	ldr.w	r2, [r8]
20025746:	429a      	cmp	r2, r3
20025748:	d12b      	bne.n	200257a2 <bbm_get_map_table+0x11a>
2002574a:	2110      	movs	r1, #16
2002574c:	4640      	mov	r0, r8
2002574e:	f7ff fee7 	bl	20025520 <bbm_crc_check>
20025752:	f8d8 2010 	ldr.w	r2, [r8, #16]
20025756:	4601      	mov	r1, r0
20025758:	4282      	cmp	r2, r0
2002575a:	d11e      	bne.n	2002579a <bbm_get_map_table+0x112>
2002575c:	f8d8 1004 	ldr.w	r1, [r8, #4]
20025760:	f3c1 011e 	ubfx	r1, r1, #0, #31
20025764:	42a1      	cmp	r1, r4
20025766:	d113      	bne.n	20025790 <bbm_get_map_table+0x108>
20025768:	f44f 7202 	mov.w	r2, #520	@ 0x208
2002576c:	481a      	ldr	r0, [pc, #104]	@ (200257d8 <bbm_get_map_table+0x150>)
2002576e:	4641      	mov	r1, r8
20025770:	fb02 0007 	mla	r0, r2, r7, r0
20025774:	f005 f888 	bl	2002a888 <memcpy>
20025778:	bb0d      	cbnz	r5, 200257be <bbm_get_map_table+0x136>
2002577a:	4620      	mov	r0, r4
2002577c:	e790      	b.n	200256a0 <bbm_get_map_table+0x18>
2002577e:	f8b8 6004 	ldrh.w	r6, [r8, #4]
20025782:	f8b8 5006 	ldrh.w	r5, [r8, #6]
20025786:	e79a      	b.n	200256be <bbm_get_map_table+0x36>
20025788:	46b1      	mov	r9, r6
2002578a:	e79f      	b.n	200256cc <bbm_get_map_table+0x44>
2002578c:	462c      	mov	r4, r5
2002578e:	e7a4      	b.n	200256da <bbm_get_map_table+0x52>
20025790:	b115      	cbz	r5, 20025798 <bbm_get_map_table+0x110>
20025792:	4622      	mov	r2, r4
20025794:	4811      	ldr	r0, [pc, #68]	@ (200257dc <bbm_get_map_table+0x154>)
20025796:	47a8      	blx	r5
20025798:	e7fe      	b.n	20025798 <bbm_get_map_table+0x110>
2002579a:	b10d      	cbz	r5, 200257a0 <bbm_get_map_table+0x118>
2002579c:	4810      	ldr	r0, [pc, #64]	@ (200257e0 <bbm_get_map_table+0x158>)
2002579e:	47a8      	blx	r5
200257a0:	e7fe      	b.n	200257a0 <bbm_get_map_table+0x118>
200257a2:	b11d      	cbz	r5, 200257ac <bbm_get_map_table+0x124>
200257a4:	4652      	mov	r2, sl
200257a6:	4631      	mov	r1, r6
200257a8:	480e      	ldr	r0, [pc, #56]	@ (200257e4 <bbm_get_map_table+0x15c>)
200257aa:	47a8      	blx	r5
200257ac:	e7fe      	b.n	200257ac <bbm_get_map_table+0x124>
200257ae:	2d00      	cmp	r5, #0
200257b0:	f43f af75 	beq.w	2002569e <bbm_get_map_table+0x16>
200257b4:	4652      	mov	r2, sl
200257b6:	4631      	mov	r1, r6
200257b8:	480b      	ldr	r0, [pc, #44]	@ (200257e8 <bbm_get_map_table+0x160>)
200257ba:	47a8      	blx	r5
200257bc:	e76f      	b.n	2002569e <bbm_get_map_table+0x16>
200257be:	4621      	mov	r1, r4
200257c0:	480a      	ldr	r0, [pc, #40]	@ (200257ec <bbm_get_map_table+0x164>)
200257c2:	47a8      	blx	r5
200257c4:	e7d9      	b.n	2002577a <bbm_get_map_table+0xf2>
200257c6:	bf00      	nop
200257c8:	2002ab5f 	.word	0x2002ab5f
200257cc:	2002ab73 	.word	0x2002ab73
200257d0:	20044900 	.word	0x20044900
200257d4:	5366424d 	.word	0x5366424d
200257d8:	20049f8c 	.word	0x20049f8c
200257dc:	2002ab99 	.word	0x2002ab99
200257e0:	2002abe3 	.word	0x2002abe3
200257e4:	2002abf5 	.word	0x2002abf5
200257e8:	2002ac2a 	.word	0x2002ac2a
200257ec:	2002ac56 	.word	0x2002ac56
200257f0:	20049f74 	.word	0x20049f74
200257f4:	2004a39c 	.word	0x2004a39c
200257f8:	20049f78 	.word	0x20049f78

200257fc <bbm_get_page_num>:
200257fc:	e92d 43f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
20025800:	4605      	mov	r5, r0
20025802:	2400      	movs	r4, #0
20025804:	4f13      	ldr	r7, [pc, #76]	@ (20025854 <bbm_get_page_num+0x58>)
20025806:	4e14      	ldr	r6, [pc, #80]	@ (20025858 <bbm_get_page_num+0x5c>)
20025808:	f8df 8050 	ldr.w	r8, [pc, #80]	@ 2002585c <bbm_get_page_num+0x60>
2002580c:	b085      	sub	sp, #20
2002580e:	6839      	ldr	r1, [r7, #0]
20025810:	6833      	ldr	r3, [r6, #0]
20025812:	fbb3 f3f1 	udiv	r3, r3, r1
20025816:	42a3      	cmp	r3, r4
20025818:	d802      	bhi.n	20025820 <bbm_get_page_num+0x24>
2002581a:	f04f 34ff 	mov.w	r4, #4294967295
2002581e:	e015      	b.n	2002584c <bbm_get_page_num+0x50>
20025820:	2200      	movs	r2, #0
20025822:	e9cd 2201 	strd	r2, r2, [sp, #4]
20025826:	f8df 9038 	ldr.w	r9, [pc, #56]	@ 20025860 <bbm_get_page_num+0x64>
2002582a:	9100      	str	r1, [sp, #0]
2002582c:	4628      	mov	r0, r5
2002582e:	4621      	mov	r1, r4
20025830:	f8d9 3000 	ldr.w	r3, [r9]
20025834:	f7fb f9a8 	bl	20020b88 <port_read_page>
20025838:	b120      	cbz	r0, 20025844 <bbm_get_page_num+0x48>
2002583a:	f8d9 3000 	ldr.w	r3, [r9]
2002583e:	681b      	ldr	r3, [r3, #0]
20025840:	4543      	cmp	r3, r8
20025842:	d101      	bne.n	20025848 <bbm_get_page_num+0x4c>
20025844:	3401      	adds	r4, #1
20025846:	e7e2      	b.n	2002580e <bbm_get_page_num+0x12>
20025848:	3301      	adds	r3, #1
2002584a:	d1fb      	bne.n	20025844 <bbm_get_page_num+0x48>
2002584c:	4620      	mov	r0, r4
2002584e:	b005      	add	sp, #20
20025850:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
20025854:	20044900 	.word	0x20044900
20025858:	20044904 	.word	0x20044904
2002585c:	5366424d 	.word	0x5366424d
20025860:	20049f78 	.word	0x20049f78

20025864 <bbm_read_page>:
20025864:	b5f0      	push	{r4, r5, r6, r7, lr}
20025866:	4604      	mov	r4, r0
20025868:	b085      	sub	sp, #20
2002586a:	b280      	uxth	r0, r0
2002586c:	461f      	mov	r7, r3
2002586e:	460d      	mov	r5, r1
20025870:	4616      	mov	r6, r2
20025872:	f7ff fe69 	bl	20025548 <bbm_get_phy_blk>
20025876:	1c43      	adds	r3, r0, #1
20025878:	d108      	bne.n	2002588c <bbm_read_page+0x28>
2002587a:	4b0a      	ldr	r3, [pc, #40]	@ (200258a4 <bbm_read_page+0x40>)
2002587c:	681b      	ldr	r3, [r3, #0]
2002587e:	b113      	cbz	r3, 20025886 <bbm_read_page+0x22>
20025880:	4621      	mov	r1, r4
20025882:	4809      	ldr	r0, [pc, #36]	@ (200258a8 <bbm_read_page+0x44>)
20025884:	4798      	blx	r3
20025886:	2000      	movs	r0, #0
20025888:	b005      	add	sp, #20
2002588a:	bdf0      	pop	{r4, r5, r6, r7, pc}
2002588c:	9b0c      	ldr	r3, [sp, #48]	@ 0x30
2002588e:	4632      	mov	r2, r6
20025890:	9302      	str	r3, [sp, #8]
20025892:	9b0b      	ldr	r3, [sp, #44]	@ 0x2c
20025894:	4629      	mov	r1, r5
20025896:	9301      	str	r3, [sp, #4]
20025898:	9b0a      	ldr	r3, [sp, #40]	@ 0x28
2002589a:	9300      	str	r3, [sp, #0]
2002589c:	463b      	mov	r3, r7
2002589e:	f7fb f973 	bl	20020b88 <port_read_page>
200258a2:	e7f1      	b.n	20025888 <bbm_read_page+0x24>
200258a4:	20049f74 	.word	0x20049f74
200258a8:	2002ac69 	.word	0x2002ac69

200258ac <port_write_page>:
200258ac:	4b01      	ldr	r3, [pc, #4]	@ (200258b4 <port_write_page+0x8>)
200258ae:	6818      	ldr	r0, [r3, #0]
200258b0:	4770      	bx	lr
200258b2:	bf00      	nop
200258b4:	20044900 	.word	0x20044900

200258b8 <bbm_write_talbe.isra.0>:
200258b8:	b5f7      	push	{r0, r1, r2, r4, r5, r6, r7, lr}
200258ba:	4604      	mov	r4, r0
200258bc:	4608      	mov	r0, r1
200258be:	460e      	mov	r6, r1
200258c0:	f7ff ff9c 	bl	200257fc <bbm_get_page_num>
200258c4:	1e05      	subs	r5, r0, #0
200258c6:	db25      	blt.n	20025914 <bbm_write_talbe.isra.0+0x5c>
200258c8:	4b13      	ldr	r3, [pc, #76]	@ (20025918 <bbm_write_talbe.isra.0+0x60>)
200258ca:	681a      	ldr	r2, [r3, #0]
200258cc:	4b13      	ldr	r3, [pc, #76]	@ (2002591c <bbm_write_talbe.isra.0+0x64>)
200258ce:	681b      	ldr	r3, [r3, #0]
200258d0:	fbb3 f3f2 	udiv	r3, r3, r2
200258d4:	429d      	cmp	r5, r3
200258d6:	da1d      	bge.n	20025914 <bbm_write_talbe.isra.0+0x5c>
200258d8:	4f11      	ldr	r7, [pc, #68]	@ (20025920 <bbm_write_talbe.isra.0+0x68>)
200258da:	21ff      	movs	r1, #255	@ 0xff
200258dc:	6838      	ldr	r0, [r7, #0]
200258de:	f004 ffb9 	bl	2002a854 <memset>
200258e2:	4264      	negs	r4, r4
200258e4:	490f      	ldr	r1, [pc, #60]	@ (20025924 <bbm_write_talbe.isra.0+0x6c>)
200258e6:	f404 7402 	and.w	r4, r4, #520	@ 0x208
200258ea:	f44f 7202 	mov.w	r2, #520	@ 0x208
200258ee:	6838      	ldr	r0, [r7, #0]
200258f0:	4421      	add	r1, r4
200258f2:	f004 ffc9 	bl	2002a888 <memcpy>
200258f6:	6838      	ldr	r0, [r7, #0]
200258f8:	b160      	cbz	r0, 20025914 <bbm_write_talbe.isra.0+0x5c>
200258fa:	6802      	ldr	r2, [r0, #0]
200258fc:	4b0a      	ldr	r3, [pc, #40]	@ (20025928 <bbm_write_talbe.isra.0+0x70>)
200258fe:	429a      	cmp	r2, r3
20025900:	d108      	bne.n	20025914 <bbm_write_talbe.isra.0+0x5c>
20025902:	f7ff fdbd 	bl	20025480 <bbm_map_check.part.0>
20025906:	2300      	movs	r3, #0
20025908:	9300      	str	r3, [sp, #0]
2002590a:	4629      	mov	r1, r5
2002590c:	4630      	mov	r0, r6
2002590e:	683a      	ldr	r2, [r7, #0]
20025910:	f7ff ffcc 	bl	200258ac <port_write_page>
20025914:	b003      	add	sp, #12
20025916:	bdf0      	pop	{r4, r5, r6, r7, pc}
20025918:	20044900 	.word	0x20044900
2002591c:	20044904 	.word	0x20044904
20025920:	20049f78 	.word	0x20049f78
20025924:	20049f8c 	.word	0x20049f8c
20025928:	5366424d 	.word	0x5366424d

2002592c <port_erase_block>:
2002592c:	2000      	movs	r0, #0
2002592e:	4770      	bx	lr

20025930 <bbm_init_table>:
20025930:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20025934:	4c7d      	ldr	r4, [pc, #500]	@ (20025b2c <bbm_init_table+0x1fc>)
20025936:	4b7e      	ldr	r3, [pc, #504]	@ (20025b30 <bbm_init_table+0x200>)
20025938:	6822      	ldr	r2, [r4, #0]
2002593a:	b085      	sub	sp, #20
2002593c:	429a      	cmp	r2, r3
2002593e:	f000 80ef 	beq.w	20025b20 <bbm_init_table+0x1f0>
20025942:	f8d4 2208 	ldr.w	r2, [r4, #520]	@ 0x208
20025946:	429a      	cmp	r2, r3
20025948:	f000 80ea 	beq.w	20025b20 <bbm_init_table+0x1f0>
2002594c:	6023      	str	r3, [r4, #0]
2002594e:	2301      	movs	r3, #1
20025950:	6063      	str	r3, [r4, #4]
20025952:	2300      	movs	r3, #0
20025954:	f8df 9210 	ldr.w	r9, [pc, #528]	@ 20025b68 <bbm_init_table+0x238>
20025958:	8123      	strh	r3, [r4, #8]
2002595a:	f8d9 3000 	ldr.w	r3, [r9]
2002595e:	4f75      	ldr	r7, [pc, #468]	@ (20025b34 <bbm_init_table+0x204>)
20025960:	3b04      	subs	r3, #4
20025962:	f8df a208 	ldr.w	sl, [pc, #520]	@ 20025b6c <bbm_init_table+0x23c>
20025966:	8163      	strh	r3, [r4, #10]
20025968:	683b      	ldr	r3, [r7, #0]
2002596a:	f8da 5000 	ldr.w	r5, [sl]
2002596e:	3b01      	subs	r3, #1
20025970:	4e71      	ldr	r6, [pc, #452]	@ (20025b38 <bbm_init_table+0x208>)
20025972:	81a3      	strh	r3, [r4, #12]
20025974:	81e5      	strh	r5, [r4, #14]
20025976:	683b      	ldr	r3, [r7, #0]
20025978:	429d      	cmp	r5, r3
2002597a:	db10      	blt.n	2002599e <bbm_init_table+0x6e>
2002597c:	2500      	movs	r5, #0
2002597e:	46a8      	mov	r8, r5
20025980:	f8df b1b4 	ldr.w	fp, [pc, #436]	@ 20025b38 <bbm_init_table+0x208>
20025984:	f8da 6000 	ldr.w	r6, [sl]
20025988:	42b5      	cmp	r5, r6
2002598a:	db20      	blt.n	200259ce <bbm_init_table+0x9e>
2002598c:	8963      	ldrh	r3, [r4, #10]
2002598e:	2b00      	cmp	r3, #0
20025990:	d14d      	bne.n	20025a2e <bbm_init_table+0xfe>
20025992:	4b69      	ldr	r3, [pc, #420]	@ (20025b38 <bbm_init_table+0x208>)
20025994:	681b      	ldr	r3, [r3, #0]
20025996:	b10b      	cbz	r3, 2002599c <bbm_init_table+0x6c>
20025998:	4868      	ldr	r0, [pc, #416]	@ (20025b3c <bbm_init_table+0x20c>)
2002599a:	4798      	blx	r3
2002599c:	e7fe      	b.n	2002599c <bbm_init_table+0x6c>
2002599e:	4628      	mov	r0, r5
200259a0:	f7fb f96e 	bl	20020c80 <bbm_get_bb>
200259a4:	b968      	cbnz	r0, 200259c2 <bbm_init_table+0x92>
200259a6:	4628      	mov	r0, r5
200259a8:	f7ff ffc0 	bl	2002592c <port_erase_block>
200259ac:	b138      	cbz	r0, 200259be <bbm_init_table+0x8e>
200259ae:	6833      	ldr	r3, [r6, #0]
200259b0:	b113      	cbz	r3, 200259b8 <bbm_init_table+0x88>
200259b2:	4629      	mov	r1, r5
200259b4:	4862      	ldr	r0, [pc, #392]	@ (20025b40 <bbm_init_table+0x210>)
200259b6:	4798      	blx	r3
200259b8:	8963      	ldrh	r3, [r4, #10]
200259ba:	3b01      	subs	r3, #1
200259bc:	8163      	strh	r3, [r4, #10]
200259be:	3501      	adds	r5, #1
200259c0:	e7d9      	b.n	20025976 <bbm_init_table+0x46>
200259c2:	6833      	ldr	r3, [r6, #0]
200259c4:	2b00      	cmp	r3, #0
200259c6:	d0f7      	beq.n	200259b8 <bbm_init_table+0x88>
200259c8:	4629      	mov	r1, r5
200259ca:	485e      	ldr	r0, [pc, #376]	@ (20025b44 <bbm_init_table+0x214>)
200259cc:	e7f3      	b.n	200259b6 <bbm_init_table+0x86>
200259ce:	4628      	mov	r0, r5
200259d0:	f7fb f956 	bl	20020c80 <bbm_get_bb>
200259d4:	b348      	cbz	r0, 20025a2a <bbm_init_table+0xfa>
200259d6:	f8db 3000 	ldr.w	r3, [fp]
200259da:	b113      	cbz	r3, 200259e2 <bbm_init_table+0xb2>
200259dc:	4629      	mov	r1, r5
200259de:	485a      	ldr	r0, [pc, #360]	@ (20025b48 <bbm_init_table+0x218>)
200259e0:	4798      	blx	r3
200259e2:	89a0      	ldrh	r0, [r4, #12]
200259e4:	f7fb f94c 	bl	20020c80 <bbm_get_bb>
200259e8:	89a3      	ldrh	r3, [r4, #12]
200259ea:	4606      	mov	r6, r0
200259ec:	3b01      	subs	r3, #1
200259ee:	81a3      	strh	r3, [r4, #12]
200259f0:	8963      	ldrh	r3, [r4, #10]
200259f2:	3b01      	subs	r3, #1
200259f4:	b29b      	uxth	r3, r3
200259f6:	8163      	strh	r3, [r4, #10]
200259f8:	b108      	cbz	r0, 200259fe <bbm_init_table+0xce>
200259fa:	2b00      	cmp	r3, #0
200259fc:	d1f1      	bne.n	200259e2 <bbm_init_table+0xb2>
200259fe:	f8db 3000 	ldr.w	r3, [fp]
20025a02:	b11b      	cbz	r3, 20025a0c <bbm_init_table+0xdc>
20025a04:	4642      	mov	r2, r8
20025a06:	4629      	mov	r1, r5
20025a08:	4850      	ldr	r0, [pc, #320]	@ (20025b4c <bbm_init_table+0x21c>)
20025a0a:	4798      	blx	r3
20025a0c:	b946      	cbnz	r6, 20025a20 <bbm_init_table+0xf0>
20025a0e:	89a2      	ldrh	r2, [r4, #12]
20025a10:	f108 0306 	add.w	r3, r8, #6
20025a14:	f824 5023 	strh.w	r5, [r4, r3, lsl #2]
20025a18:	3201      	adds	r2, #1
20025a1a:	eb04 0383 	add.w	r3, r4, r3, lsl #2
20025a1e:	805a      	strh	r2, [r3, #2]
20025a20:	8923      	ldrh	r3, [r4, #8]
20025a22:	f108 0801 	add.w	r8, r8, #1
20025a26:	3301      	adds	r3, #1
20025a28:	8123      	strh	r3, [r4, #8]
20025a2a:	3501      	adds	r5, #1
20025a2c:	e7aa      	b.n	20025984 <bbm_init_table+0x54>
20025a2e:	2110      	movs	r1, #16
20025a30:	483e      	ldr	r0, [pc, #248]	@ (20025b2c <bbm_init_table+0x1fc>)
20025a32:	f7ff fd75 	bl	20025520 <bbm_crc_check>
20025a36:	f8d9 1000 	ldr.w	r1, [r9]
20025a3a:	6120      	str	r0, [r4, #16]
20025a3c:	3904      	subs	r1, #4
20025a3e:	0089      	lsls	r1, r1, #2
20025a40:	4843      	ldr	r0, [pc, #268]	@ (20025b50 <bbm_init_table+0x220>)
20025a42:	f7ff fd6d 	bl	20025520 <bbm_crc_check>
20025a46:	f44f 7202 	mov.w	r2, #520	@ 0x208
20025a4a:	4938      	ldr	r1, [pc, #224]	@ (20025b2c <bbm_init_table+0x1fc>)
20025a4c:	6160      	str	r0, [r4, #20]
20025a4e:	1888      	adds	r0, r1, r2
20025a50:	f004 ff1a 	bl	2002a888 <memcpy>
20025a54:	f894 320f 	ldrb.w	r3, [r4, #527]	@ 0x20f
20025a58:	2110      	movs	r1, #16
20025a5a:	f043 0380 	orr.w	r3, r3, #128	@ 0x80
20025a5e:	f884 320f 	strb.w	r3, [r4, #527]	@ 0x20f
20025a62:	483c      	ldr	r0, [pc, #240]	@ (20025b54 <bbm_init_table+0x224>)
20025a64:	f7ff fd5c 	bl	20025520 <bbm_crc_check>
20025a68:	f8c4 0218 	str.w	r0, [r4, #536]	@ 0x218
20025a6c:	2400      	movs	r4, #0
20025a6e:	f8df 9100 	ldr.w	r9, [pc, #256]	@ 20025b70 <bbm_init_table+0x240>
20025a72:	f8df 8100 	ldr.w	r8, [pc, #256]	@ 20025b74 <bbm_init_table+0x244>
20025a76:	683b      	ldr	r3, [r7, #0]
20025a78:	429e      	cmp	r6, r3
20025a7a:	db08      	blt.n	20025a8e <bbm_init_table+0x15e>
20025a7c:	2c03      	cmp	r4, #3
20025a7e:	dc30      	bgt.n	20025ae2 <bbm_init_table+0x1b2>
20025a80:	4b2d      	ldr	r3, [pc, #180]	@ (20025b38 <bbm_init_table+0x208>)
20025a82:	681b      	ldr	r3, [r3, #0]
20025a84:	b113      	cbz	r3, 20025a8c <bbm_init_table+0x15c>
20025a86:	4621      	mov	r1, r4
20025a88:	4833      	ldr	r0, [pc, #204]	@ (20025b58 <bbm_init_table+0x228>)
20025a8a:	4798      	blx	r3
20025a8c:	e7fe      	b.n	20025a8c <bbm_init_table+0x15c>
20025a8e:	4630      	mov	r0, r6
20025a90:	f7fb f8f6 	bl	20020c80 <bbm_get_bb>
20025a94:	4605      	mov	r5, r0
20025a96:	bb10      	cbnz	r0, 20025ade <bbm_init_table+0x1ae>
20025a98:	f8d9 a000 	ldr.w	sl, [r9]
20025a9c:	21ff      	movs	r1, #255	@ 0xff
20025a9e:	4652      	mov	r2, sl
20025aa0:	f8d8 0000 	ldr.w	r0, [r8]
20025aa4:	f004 fed6 	bl	2002a854 <memset>
20025aa8:	e9cd 5501 	strd	r5, r5, [sp, #4]
20025aac:	f8cd a000 	str.w	sl, [sp]
20025ab0:	f8d8 3000 	ldr.w	r3, [r8]
20025ab4:	462a      	mov	r2, r5
20025ab6:	4629      	mov	r1, r5
20025ab8:	4630      	mov	r0, r6
20025aba:	f7fb f865 	bl	20020b88 <port_read_page>
20025abe:	f8d9 3000 	ldr.w	r3, [r9]
20025ac2:	4298      	cmp	r0, r3
20025ac4:	d109      	bne.n	20025ada <bbm_init_table+0x1aa>
20025ac6:	f8d8 3000 	ldr.w	r3, [r8]
20025aca:	681b      	ldr	r3, [r3, #0]
20025acc:	3301      	adds	r3, #1
20025ace:	bf01      	itttt	eq
20025ad0:	4b22      	ldreq	r3, [pc, #136]	@ (20025b5c <bbm_init_table+0x22c>)
20025ad2:	1d22      	addeq	r2, r4, #4
20025ad4:	f823 6012 	strheq.w	r6, [r3, r2, lsl #1]
20025ad8:	3401      	addeq	r4, #1
20025ada:	2c03      	cmp	r4, #3
20025adc:	dc01      	bgt.n	20025ae2 <bbm_init_table+0x1b2>
20025ade:	3601      	adds	r6, #1
20025ae0:	e7c9      	b.n	20025a76 <bbm_init_table+0x146>
20025ae2:	2500      	movs	r5, #0
20025ae4:	4c1d      	ldr	r4, [pc, #116]	@ (20025b5c <bbm_init_table+0x22c>)
20025ae6:	2000      	movs	r0, #0
20025ae8:	8921      	ldrh	r1, [r4, #8]
20025aea:	f7ff fee5 	bl	200258b8 <bbm_write_talbe.isra.0>
20025aee:	8923      	ldrh	r3, [r4, #8]
20025af0:	2001      	movs	r0, #1
20025af2:	8961      	ldrh	r1, [r4, #10]
20025af4:	8023      	strh	r3, [r4, #0]
20025af6:	8223      	strh	r3, [r4, #16]
20025af8:	8125      	strh	r5, [r4, #8]
20025afa:	f7ff fedd 	bl	200258b8 <bbm_write_talbe.isra.0>
20025afe:	8963      	ldrh	r3, [r4, #10]
20025b00:	8165      	strh	r5, [r4, #10]
20025b02:	80a3      	strh	r3, [r4, #4]
20025b04:	8263      	strh	r3, [r4, #18]
20025b06:	89a3      	ldrh	r3, [r4, #12]
20025b08:	8063      	strh	r3, [r4, #2]
20025b0a:	89e3      	ldrh	r3, [r4, #14]
20025b0c:	80e3      	strh	r3, [r4, #6]
20025b0e:	4b0a      	ldr	r3, [pc, #40]	@ (20025b38 <bbm_init_table+0x208>)
20025b10:	681b      	ldr	r3, [r3, #0]
20025b12:	b10b      	cbz	r3, 20025b18 <bbm_init_table+0x1e8>
20025b14:	4812      	ldr	r0, [pc, #72]	@ (20025b60 <bbm_init_table+0x230>)
20025b16:	4798      	blx	r3
20025b18:	2000      	movs	r0, #0
20025b1a:	b005      	add	sp, #20
20025b1c:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20025b20:	4b05      	ldr	r3, [pc, #20]	@ (20025b38 <bbm_init_table+0x208>)
20025b22:	681b      	ldr	r3, [r3, #0]
20025b24:	b10b      	cbz	r3, 20025b2a <bbm_init_table+0x1fa>
20025b26:	480f      	ldr	r0, [pc, #60]	@ (20025b64 <bbm_init_table+0x234>)
20025b28:	4798      	blx	r3
20025b2a:	e7fe      	b.n	20025b2a <bbm_init_table+0x1fa>
20025b2c:	20049f8c 	.word	0x20049f8c
20025b30:	5366424d 	.word	0x5366424d
20025b34:	20049f80 	.word	0x20049f80
20025b38:	20049f74 	.word	0x20049f74
20025b3c:	2002acfe 	.word	0x2002acfe
20025b40:	2002ac8c 	.word	0x2002ac8c
20025b44:	2002acae 	.word	0x2002acae
20025b48:	2002accb 	.word	0x2002accb
20025b4c:	2002acea 	.word	0x2002acea
20025b50:	20049fa4 	.word	0x20049fa4
20025b54:	2004a194 	.word	0x2004a194
20025b58:	2002ad18 	.word	0x2002ad18
20025b5c:	2004a39c 	.word	0x2004a39c
20025b60:	2002ad3f 	.word	0x2002ad3f
20025b64:	2002ad5b 	.word	0x2002ad5b
20025b68:	20049f84 	.word	0x20049f84
20025b6c:	20049f88 	.word	0x20049f88
20025b70:	20044900 	.word	0x20044900
20025b74:	20049f78 	.word	0x20049f78

20025b78 <sif_bbm_init>:
20025b78:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20025b7c:	b087      	sub	sp, #28
20025b7e:	2900      	cmp	r1, #0
20025b80:	f000 8129 	beq.w	20025dd6 <sif_bbm_init+0x25e>
20025b84:	4b95      	ldr	r3, [pc, #596]	@ (20025ddc <sif_bbm_init+0x264>)
20025b86:	681a      	ldr	r2, [r3, #0]
20025b88:	2a01      	cmp	r2, #1
20025b8a:	d108      	bne.n	20025b9e <sif_bbm_init+0x26>
20025b8c:	4b94      	ldr	r3, [pc, #592]	@ (20025de0 <sif_bbm_init+0x268>)
20025b8e:	681b      	ldr	r3, [r3, #0]
20025b90:	b10b      	cbz	r3, 20025b96 <sif_bbm_init+0x1e>
20025b92:	4894      	ldr	r0, [pc, #592]	@ (20025de4 <sif_bbm_init+0x26c>)
20025b94:	4798      	blx	r3
20025b96:	2000      	movs	r0, #0
20025b98:	b007      	add	sp, #28
20025b9a:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20025b9e:	2201      	movs	r2, #1
20025ba0:	601a      	str	r2, [r3, #0]
20025ba2:	4b91      	ldr	r3, [pc, #580]	@ (20025de8 <sif_bbm_init+0x270>)
20025ba4:	681c      	ldr	r4, [r3, #0]
20025ba6:	b904      	cbnz	r4, 20025baa <sif_bbm_init+0x32>
20025ba8:	e7fe      	b.n	20025ba8 <sif_bbm_init+0x30>
20025baa:	f8df a27c 	ldr.w	sl, [pc, #636]	@ 20025e28 <sif_bbm_init+0x2b0>
20025bae:	f8da 2000 	ldr.w	r2, [sl]
20025bb2:	b902      	cbnz	r2, 20025bb6 <sif_bbm_init+0x3e>
20025bb4:	e7fe      	b.n	20025bb4 <sif_bbm_init+0x3c>
20025bb6:	fbb0 f4f4 	udiv	r4, r0, r4
20025bba:	f04f 0800 	mov.w	r8, #0
20025bbe:	4a8b      	ldr	r2, [pc, #556]	@ (20025dec <sif_bbm_init+0x274>)
20025bc0:	f8df b268 	ldr.w	fp, [pc, #616]	@ 20025e2c <sif_bbm_init+0x2b4>
20025bc4:	0963      	lsrs	r3, r4, #5
20025bc6:	f8df 9268 	ldr.w	r9, [pc, #616]	@ 20025e30 <sif_bbm_init+0x2b8>
20025bca:	6013      	str	r3, [r2, #0]
20025bcc:	f8cb 4000 	str.w	r4, [fp]
20025bd0:	1ae4      	subs	r4, r4, r3
20025bd2:	4b87      	ldr	r3, [pc, #540]	@ (20025df0 <sif_bbm_init+0x278>)
20025bd4:	2218      	movs	r2, #24
20025bd6:	f8c9 1000 	str.w	r1, [r9]
20025bda:	4886      	ldr	r0, [pc, #536]	@ (20025df4 <sif_bbm_init+0x27c>)
20025bdc:	2100      	movs	r1, #0
20025bde:	601c      	str	r4, [r3, #0]
20025be0:	f004 fe38 	bl	2002a854 <memset>
20025be4:	f44f 6282 	mov.w	r2, #1040	@ 0x410
20025be8:	2100      	movs	r1, #0
20025bea:	4883      	ldr	r0, [pc, #524]	@ (20025df8 <sif_bbm_init+0x280>)
20025bec:	f004 fe32 	bl	2002a854 <memset>
20025bf0:	4647      	mov	r7, r8
20025bf2:	4646      	mov	r6, r8
20025bf4:	f8db 3000 	ldr.w	r3, [fp]
20025bf8:	429c      	cmp	r4, r3
20025bfa:	db02      	blt.n	20025c02 <sif_bbm_init+0x8a>
20025bfc:	f04f 35ff 	mov.w	r5, #4294967295
20025c00:	e064      	b.n	20025ccc <sif_bbm_init+0x154>
20025c02:	4620      	mov	r0, r4
20025c04:	f7fb f83c 	bl	20020c80 <bbm_get_bb>
20025c08:	4605      	mov	r5, r0
20025c0a:	b138      	cbz	r0, 20025c1c <sif_bbm_init+0xa4>
20025c0c:	4b74      	ldr	r3, [pc, #464]	@ (20025de0 <sif_bbm_init+0x268>)
20025c0e:	681b      	ldr	r3, [r3, #0]
20025c10:	b113      	cbz	r3, 20025c18 <sif_bbm_init+0xa0>
20025c12:	487a      	ldr	r0, [pc, #488]	@ (20025dfc <sif_bbm_init+0x284>)
20025c14:	1c61      	adds	r1, r4, #1
20025c16:	4798      	blx	r3
20025c18:	3401      	adds	r4, #1
20025c1a:	e7eb      	b.n	20025bf4 <sif_bbm_init+0x7c>
20025c1c:	f8da 2000 	ldr.w	r2, [sl]
20025c20:	21ff      	movs	r1, #255	@ 0xff
20025c22:	f8d9 0000 	ldr.w	r0, [r9]
20025c26:	9205      	str	r2, [sp, #20]
20025c28:	f004 fe14 	bl	2002a854 <memset>
20025c2c:	9a05      	ldr	r2, [sp, #20]
20025c2e:	e9cd 5501 	strd	r5, r5, [sp, #4]
20025c32:	9200      	str	r2, [sp, #0]
20025c34:	f8d9 3000 	ldr.w	r3, [r9]
20025c38:	462a      	mov	r2, r5
20025c3a:	4629      	mov	r1, r5
20025c3c:	4620      	mov	r0, r4
20025c3e:	f7fa ffa3 	bl	20020b88 <port_read_page>
20025c42:	f8da 3000 	ldr.w	r3, [sl]
20025c46:	4298      	cmp	r0, r3
20025c48:	d12e      	bne.n	20025ca8 <sif_bbm_init+0x130>
20025c4a:	f8d9 1000 	ldr.w	r1, [r9]
20025c4e:	486c      	ldr	r0, [pc, #432]	@ (20025e00 <sif_bbm_init+0x288>)
20025c50:	680b      	ldr	r3, [r1, #0]
20025c52:	b2a2      	uxth	r2, r4
20025c54:	4283      	cmp	r3, r0
20025c56:	4b67      	ldr	r3, [pc, #412]	@ (20025df4 <sif_bbm_init+0x27c>)
20025c58:	d11f      	bne.n	20025c9a <sif_bbm_init+0x122>
20025c5a:	f991 1007 	ldrsb.w	r1, [r1, #7]
20025c5e:	2900      	cmp	r1, #0
20025c60:	bfb5      	itete	lt
20025c62:	eb03 0147 	addlt.w	r1, r3, r7, lsl #1
20025c66:	f823 2016 	strhge.w	r2, [r3, r6, lsl #1]
20025c6a:	808a      	strhlt	r2, [r1, #4]
20025c6c:	3601      	addge	r6, #1
20025c6e:	bfb8      	it	lt
20025c70:	3701      	addlt	r7, #1
20025c72:	eb06 0208 	add.w	r2, r6, r8
20025c76:	443a      	add	r2, r7
20025c78:	2a03      	cmp	r2, #3
20025c7a:	ddcd      	ble.n	20025c18 <sif_bbm_init+0xa0>
20025c7c:	2e00      	cmp	r6, #0
20025c7e:	f000 8081 	beq.w	20025d84 <sif_bbm_init+0x20c>
20025c82:	2f00      	cmp	r7, #0
20025c84:	d07e      	beq.n	20025d84 <sif_bbm_init+0x20c>
20025c86:	2e01      	cmp	r6, #1
20025c88:	d001      	beq.n	20025c8e <sif_bbm_init+0x116>
20025c8a:	2f01      	cmp	r7, #1
20025c8c:	d11e      	bne.n	20025ccc <sif_bbm_init+0x154>
20025c8e:	8819      	ldrh	r1, [r3, #0]
20025c90:	891a      	ldrh	r2, [r3, #8]
20025c92:	b981      	cbnz	r1, 20025cb6 <sif_bbm_init+0x13e>
20025c94:	801a      	strh	r2, [r3, #0]
20025c96:	895a      	ldrh	r2, [r3, #10]
20025c98:	e013      	b.n	20025cc2 <sif_bbm_init+0x14a>
20025c9a:	f108 0104 	add.w	r1, r8, #4
20025c9e:	f823 2011 	strh.w	r2, [r3, r1, lsl #1]
20025ca2:	f108 0801 	add.w	r8, r8, #1
20025ca6:	e7e4      	b.n	20025c72 <sif_bbm_init+0xfa>
20025ca8:	4b4d      	ldr	r3, [pc, #308]	@ (20025de0 <sif_bbm_init+0x268>)
20025caa:	681b      	ldr	r3, [r3, #0]
20025cac:	2b00      	cmp	r3, #0
20025cae:	d0b3      	beq.n	20025c18 <sif_bbm_init+0xa0>
20025cb0:	4854      	ldr	r0, [pc, #336]	@ (20025e04 <sif_bbm_init+0x28c>)
20025cb2:	1c61      	adds	r1, r4, #1
20025cb4:	e7af      	b.n	20025c16 <sif_bbm_init+0x9e>
20025cb6:	8859      	ldrh	r1, [r3, #2]
20025cb8:	b909      	cbnz	r1, 20025cbe <sif_bbm_init+0x146>
20025cba:	805a      	strh	r2, [r3, #2]
20025cbc:	e7eb      	b.n	20025c96 <sif_bbm_init+0x11e>
20025cbe:	2a00      	cmp	r2, #0
20025cc0:	d0e9      	beq.n	20025c96 <sif_bbm_init+0x11e>
20025cc2:	8899      	ldrh	r1, [r3, #4]
20025cc4:	2900      	cmp	r1, #0
20025cc6:	d158      	bne.n	20025d7a <sif_bbm_init+0x202>
20025cc8:	809a      	strh	r2, [r3, #4]
20025cca:	2502      	movs	r5, #2
20025ccc:	f8df 9110 	ldr.w	r9, [pc, #272]	@ 20025de0 <sif_bbm_init+0x268>
20025cd0:	f8d9 4000 	ldr.w	r4, [r9]
20025cd4:	b124      	cbz	r4, 20025ce0 <sif_bbm_init+0x168>
20025cd6:	4643      	mov	r3, r8
20025cd8:	463a      	mov	r2, r7
20025cda:	4631      	mov	r1, r6
20025cdc:	484a      	ldr	r0, [pc, #296]	@ (20025e08 <sif_bbm_init+0x290>)
20025cde:	47a0      	blx	r4
20025ce0:	f8d9 3000 	ldr.w	r3, [r9]
20025ce4:	b113      	cbz	r3, 20025cec <sif_bbm_init+0x174>
20025ce6:	4629      	mov	r1, r5
20025ce8:	4848      	ldr	r0, [pc, #288]	@ (20025e0c <sif_bbm_init+0x294>)
20025cea:	4798      	blx	r3
20025cec:	f035 0002 	bics.w	r0, r5, #2
20025cf0:	d164      	bne.n	20025dbc <sif_bbm_init+0x244>
20025cf2:	f7ff fcc9 	bl	20025688 <bbm_get_map_table>
20025cf6:	4605      	mov	r5, r0
20025cf8:	2001      	movs	r0, #1
20025cfa:	f7ff fcc5 	bl	20025688 <bbm_get_map_table>
20025cfe:	f8d9 6000 	ldr.w	r6, [r9]
20025d02:	4604      	mov	r4, r0
20025d04:	b13e      	cbz	r6, 20025d16 <sif_bbm_init+0x19e>
20025d06:	4a3b      	ldr	r2, [pc, #236]	@ (20025df4 <sif_bbm_init+0x27c>)
20025d08:	4629      	mov	r1, r5
20025d0a:	8a53      	ldrh	r3, [r2, #18]
20025d0c:	9300      	str	r3, [sp, #0]
20025d0e:	8a12      	ldrh	r2, [r2, #16]
20025d10:	4603      	mov	r3, r0
20025d12:	483f      	ldr	r0, [pc, #252]	@ (20025e10 <sif_bbm_init+0x298>)
20025d14:	47b0      	blx	r6
20025d16:	42a5      	cmp	r5, r4
20025d18:	4c37      	ldr	r4, [pc, #220]	@ (20025df8 <sif_bbm_init+0x280>)
20025d1a:	dd35      	ble.n	20025d88 <sif_bbm_init+0x210>
20025d1c:	f44f 7202 	mov.w	r2, #520	@ 0x208
20025d20:	4621      	mov	r1, r4
20025d22:	18a0      	adds	r0, r4, r2
20025d24:	f004 fdb0 	bl	2002a888 <memcpy>
20025d28:	f894 320f 	ldrb.w	r3, [r4, #527]	@ 0x20f
20025d2c:	2110      	movs	r1, #16
20025d2e:	f043 0380 	orr.w	r3, r3, #128	@ 0x80
20025d32:	f884 320f 	strb.w	r3, [r4, #527]	@ 0x20f
20025d36:	f504 7002 	add.w	r0, r4, #520	@ 0x208
20025d3a:	f7ff fbf1 	bl	20025520 <bbm_crc_check>
20025d3e:	f8c4 0218 	str.w	r0, [r4, #536]	@ 0x218
20025d42:	2001      	movs	r0, #1
20025d44:	4b2b      	ldr	r3, [pc, #172]	@ (20025df4 <sif_bbm_init+0x27c>)
20025d46:	8a59      	ldrh	r1, [r3, #18]
20025d48:	f7ff fdb6 	bl	200258b8 <bbm_write_talbe.isra.0>
20025d4c:	6822      	ldr	r2, [r4, #0]
20025d4e:	4b2c      	ldr	r3, [pc, #176]	@ (20025e00 <sif_bbm_init+0x288>)
20025d50:	429a      	cmp	r2, r3
20025d52:	d12d      	bne.n	20025db0 <sif_bbm_init+0x238>
20025d54:	4828      	ldr	r0, [pc, #160]	@ (20025df8 <sif_bbm_init+0x280>)
20025d56:	f7ff fb93 	bl	20025480 <bbm_map_check.part.0>
20025d5a:	f8d9 4000 	ldr.w	r4, [r9]
20025d5e:	b12c      	cbz	r4, 20025d6c <sif_bbm_init+0x1f4>
20025d60:	4b2c      	ldr	r3, [pc, #176]	@ (20025e14 <sif_bbm_init+0x29c>)
20025d62:	4924      	ldr	r1, [pc, #144]	@ (20025df4 <sif_bbm_init+0x27c>)
20025d64:	482c      	ldr	r0, [pc, #176]	@ (20025e18 <sif_bbm_init+0x2a0>)
20025d66:	f5a3 7202 	sub.w	r2, r3, #520	@ 0x208
20025d6a:	47a0      	blx	r4
20025d6c:	f8d9 3000 	ldr.w	r3, [r9]
20025d70:	2b00      	cmp	r3, #0
20025d72:	f43f af10 	beq.w	20025b96 <sif_bbm_init+0x1e>
20025d76:	4829      	ldr	r0, [pc, #164]	@ (20025e1c <sif_bbm_init+0x2a4>)
20025d78:	e70c      	b.n	20025b94 <sif_bbm_init+0x1c>
20025d7a:	88d9      	ldrh	r1, [r3, #6]
20025d7c:	2900      	cmp	r1, #0
20025d7e:	d1a4      	bne.n	20025cca <sif_bbm_init+0x152>
20025d80:	80da      	strh	r2, [r3, #6]
20025d82:	e7a2      	b.n	20025cca <sif_bbm_init+0x152>
20025d84:	2501      	movs	r5, #1
20025d86:	e7a1      	b.n	20025ccc <sif_bbm_init+0x154>
20025d88:	dae0      	bge.n	20025d4c <sif_bbm_init+0x1d4>
20025d8a:	f44f 7202 	mov.w	r2, #520	@ 0x208
20025d8e:	4620      	mov	r0, r4
20025d90:	18a1      	adds	r1, r4, r2
20025d92:	f004 fd79 	bl	2002a888 <memcpy>
20025d96:	79e3      	ldrb	r3, [r4, #7]
20025d98:	2110      	movs	r1, #16
20025d9a:	f023 0380 	bic.w	r3, r3, #128	@ 0x80
20025d9e:	71e3      	strb	r3, [r4, #7]
20025da0:	4620      	mov	r0, r4
20025da2:	f7ff fbbd 	bl	20025520 <bbm_crc_check>
20025da6:	4b13      	ldr	r3, [pc, #76]	@ (20025df4 <sif_bbm_init+0x27c>)
20025da8:	6120      	str	r0, [r4, #16]
20025daa:	8a19      	ldrh	r1, [r3, #16]
20025dac:	2000      	movs	r0, #0
20025dae:	e7cb      	b.n	20025d48 <sif_bbm_init+0x1d0>
20025db0:	f8d9 3000 	ldr.w	r3, [r9]
20025db4:	b10b      	cbz	r3, 20025dba <sif_bbm_init+0x242>
20025db6:	481a      	ldr	r0, [pc, #104]	@ (20025e20 <sif_bbm_init+0x2a8>)
20025db8:	4798      	blx	r3
20025dba:	e7fe      	b.n	20025dba <sif_bbm_init+0x242>
20025dbc:	2d01      	cmp	r5, #1
20025dbe:	d102      	bne.n	20025dc6 <sif_bbm_init+0x24e>
20025dc0:	f7ff fdb6 	bl	20025930 <bbm_init_table>
20025dc4:	e7c9      	b.n	20025d5a <sif_bbm_init+0x1e2>
20025dc6:	f8d9 3000 	ldr.w	r3, [r9]
20025dca:	b11b      	cbz	r3, 20025dd4 <sif_bbm_init+0x25c>
20025dcc:	f04f 31ff 	mov.w	r1, #4294967295
20025dd0:	4814      	ldr	r0, [pc, #80]	@ (20025e24 <sif_bbm_init+0x2ac>)
20025dd2:	4798      	blx	r3
20025dd4:	e7fe      	b.n	20025dd4 <sif_bbm_init+0x25c>
20025dd6:	f04f 30ff 	mov.w	r0, #4294967295
20025dda:	e6dd      	b.n	20025b98 <sif_bbm_init+0x20>
20025ddc:	20049f7c 	.word	0x20049f7c
20025de0:	20049f74 	.word	0x20049f74
20025de4:	2002ad6f 	.word	0x2002ad6f
20025de8:	20044904 	.word	0x20044904
20025dec:	20049f84 	.word	0x20049f84
20025df0:	20049f88 	.word	0x20049f88
20025df4:	2004a39c 	.word	0x2004a39c
20025df8:	20049f8c 	.word	0x20049f8c
20025dfc:	2002ad9d 	.word	0x2002ad9d
20025e00:	5366424d 	.word	0x5366424d
20025e04:	2002ada9 	.word	0x2002ada9
20025e08:	2002adc8 	.word	0x2002adc8
20025e0c:	2002ade7 	.word	0x2002ade7
20025e10:	2002adf9 	.word	0x2002adf9
20025e14:	2004a194 	.word	0x2004a194
20025e18:	2002ae54 	.word	0x2002ae54
20025e1c:	2002ae78 	.word	0x2002ae78
20025e20:	2002ae1d 	.word	0x2002ae1d
20025e24:	2002ae33 	.word	0x2002ae33
20025e28:	20044900 	.word	0x20044900
20025e2c:	20049f80 	.word	0x20049f80
20025e30:	20049f78 	.word	0x20049f78

20025e34 <bbm_set_page_size>:
20025e34:	4b01      	ldr	r3, [pc, #4]	@ (20025e3c <bbm_set_page_size+0x8>)
20025e36:	6018      	str	r0, [r3, #0]
20025e38:	4770      	bx	lr
20025e3a:	bf00      	nop
20025e3c:	20044900 	.word	0x20044900

20025e40 <bbm_set_blk_size>:
20025e40:	4b01      	ldr	r3, [pc, #4]	@ (20025e48 <bbm_set_blk_size+0x8>)
20025e42:	6018      	str	r0, [r3, #0]
20025e44:	4770      	bx	lr
20025e46:	bf00      	nop
20025e48:	20044904 	.word	0x20044904

20025e4c <mbedtls_md_info_from_type>:
20025e4c:	3805      	subs	r0, #5
20025e4e:	b2c0      	uxtb	r0, r0
20025e50:	2803      	cmp	r0, #3
20025e52:	bf9a      	itte	ls
20025e54:	4b02      	ldrls	r3, [pc, #8]	@ (20025e60 <mbedtls_md_info_from_type+0x14>)
20025e56:	f853 0020 	ldrls.w	r0, [r3, r0, lsl #2]
20025e5a:	2000      	movhi	r0, #0
20025e5c:	4770      	bx	lr
20025e5e:	bf00      	nop
20025e60:	2002bccc 	.word	0x2002bccc

20025e64 <mbedtls_md_get_size>:
20025e64:	b100      	cbz	r0, 20025e68 <mbedtls_md_get_size+0x4>
20025e66:	7a00      	ldrb	r0, [r0, #8]
20025e68:	4770      	bx	lr

20025e6a <sha224_process_wrap>:
20025e6a:	f000 b8a9 	b.w	20025fc0 <mbedtls_sha256_process>

20025e6e <sha224_clone_wrap>:
20025e6e:	f000 b85a 	b.w	20025f26 <mbedtls_sha256_clone>

20025e72 <sha224_ctx_free>:
20025e72:	b510      	push	{r4, lr}
20025e74:	4604      	mov	r4, r0
20025e76:	f000 f84c 	bl	20025f12 <mbedtls_sha256_free>
20025e7a:	4620      	mov	r0, r4
20025e7c:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20025e80:	f004 bc22 	b.w	2002a6c8 <free>

20025e84 <sha224_ctx_alloc>:
20025e84:	b510      	push	{r4, lr}
20025e86:	216c      	movs	r1, #108	@ 0x6c
20025e88:	2001      	movs	r0, #1
20025e8a:	f004 fc01 	bl	2002a690 <calloc>
20025e8e:	4604      	mov	r4, r0
20025e90:	b108      	cbz	r0, 20025e96 <sha224_ctx_alloc+0x12>
20025e92:	f000 f83a 	bl	20025f0a <mbedtls_sha256_init>
20025e96:	4620      	mov	r0, r4
20025e98:	bd10      	pop	{r4, pc}

20025e9a <sha224_wrap>:
20025e9a:	2301      	movs	r3, #1
20025e9c:	f000 bc94 	b.w	200267c8 <mbedtls_sha256>

20025ea0 <sha256_wrap>:
20025ea0:	2300      	movs	r3, #0
20025ea2:	f000 bc91 	b.w	200267c8 <mbedtls_sha256>

20025ea6 <sha224_finish_wrap>:
20025ea6:	f000 bc21 	b.w	200266ec <mbedtls_sha256_finish>

20025eaa <sha224_update_wrap>:
20025eaa:	f000 bc1b 	b.w	200266e4 <mbedtls_sha256_update>

20025eae <sha224_starts_wrap>:
20025eae:	2101      	movs	r1, #1
20025eb0:	f000 b83e 	b.w	20025f30 <mbedtls_sha256_starts>

20025eb4 <sha256_starts_wrap>:
20025eb4:	2100      	movs	r1, #0
20025eb6:	f000 b83b 	b.w	20025f30 <mbedtls_sha256_starts>

20025eba <sha384_process_wrap>:
20025eba:	f000 bd8d 	b.w	200269d8 <mbedtls_sha512_process>

20025ebe <sha384_clone_wrap>:
20025ebe:	f000 bcf5 	b.w	200268ac <mbedtls_sha512_clone>

20025ec2 <sha384_ctx_free>:
20025ec2:	b510      	push	{r4, lr}
20025ec4:	4604      	mov	r4, r0
20025ec6:	f000 fce7 	bl	20026898 <mbedtls_sha512_free>
20025eca:	4620      	mov	r0, r4
20025ecc:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
20025ed0:	f004 bbfa 	b.w	2002a6c8 <free>

20025ed4 <sha384_ctx_alloc>:
20025ed4:	b510      	push	{r4, lr}
20025ed6:	21d8      	movs	r1, #216	@ 0xd8
20025ed8:	2001      	movs	r0, #1
20025eda:	f004 fbd9 	bl	2002a690 <calloc>
20025ede:	4604      	mov	r4, r0
20025ee0:	b108      	cbz	r0, 20025ee6 <sha384_ctx_alloc+0x12>
20025ee2:	f000 fcd5 	bl	20026890 <mbedtls_sha512_init>
20025ee6:	4620      	mov	r0, r4
20025ee8:	bd10      	pop	{r4, pc}

20025eea <sha384_wrap>:
20025eea:	2301      	movs	r3, #1
20025eec:	f001 bbf8 	b.w	200276e0 <mbedtls_sha512>

20025ef0 <sha512_wrap>:
20025ef0:	2300      	movs	r3, #0
20025ef2:	f001 bbf5 	b.w	200276e0 <mbedtls_sha512>

20025ef6 <sha384_finish_wrap>:
20025ef6:	f001 baed 	b.w	200274d4 <mbedtls_sha512_finish>

20025efa <sha384_update_wrap>:
20025efa:	f001 bae6 	b.w	200274ca <mbedtls_sha512_update>

20025efe <sha384_starts_wrap>:
20025efe:	2101      	movs	r1, #1
20025f00:	f000 bcda 	b.w	200268b8 <mbedtls_sha512_starts>

20025f04 <sha512_starts_wrap>:
20025f04:	2100      	movs	r1, #0
20025f06:	f000 bcd7 	b.w	200268b8 <mbedtls_sha512_starts>

20025f0a <mbedtls_sha256_init>:
20025f0a:	226c      	movs	r2, #108	@ 0x6c
20025f0c:	2100      	movs	r1, #0
20025f0e:	f004 bca1 	b.w	2002a854 <memset>

20025f12 <mbedtls_sha256_free>:
20025f12:	b138      	cbz	r0, 20025f24 <mbedtls_sha256_free+0x12>
20025f14:	2100      	movs	r1, #0
20025f16:	f100 036c 	add.w	r3, r0, #108	@ 0x6c
20025f1a:	4602      	mov	r2, r0
20025f1c:	3001      	adds	r0, #1
20025f1e:	4298      	cmp	r0, r3
20025f20:	7011      	strb	r1, [r2, #0]
20025f22:	d1fa      	bne.n	20025f1a <mbedtls_sha256_free+0x8>
20025f24:	4770      	bx	lr

20025f26 <mbedtls_sha256_clone>:
20025f26:	b508      	push	{r3, lr}
20025f28:	226c      	movs	r2, #108	@ 0x6c
20025f2a:	f004 fcad 	bl	2002a888 <memcpy>
20025f2e:	bd08      	pop	{r3, pc}

20025f30 <mbedtls_sha256_starts>:
20025f30:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20025f34:	b1c1      	cbz	r1, 20025f68 <mbedtls_sha256_starts+0x38>
20025f36:	f8df e078 	ldr.w	lr, [pc, #120]	@ 20025fb0 <mbedtls_sha256_starts+0x80>
20025f3a:	f8df c078 	ldr.w	ip, [pc, #120]	@ 20025fb4 <mbedtls_sha256_starts+0x84>
20025f3e:	4f10      	ldr	r7, [pc, #64]	@ (20025f80 <mbedtls_sha256_starts+0x50>)
20025f40:	4e10      	ldr	r6, [pc, #64]	@ (20025f84 <mbedtls_sha256_starts+0x54>)
20025f42:	4d11      	ldr	r5, [pc, #68]	@ (20025f88 <mbedtls_sha256_starts+0x58>)
20025f44:	4c11      	ldr	r4, [pc, #68]	@ (20025f8c <mbedtls_sha256_starts+0x5c>)
20025f46:	4a12      	ldr	r2, [pc, #72]	@ (20025f90 <mbedtls_sha256_starts+0x60>)
20025f48:	4b12      	ldr	r3, [pc, #72]	@ (20025f94 <mbedtls_sha256_starts+0x64>)
20025f4a:	f04f 0800 	mov.w	r8, #0
20025f4e:	e9c0 ec02 	strd	lr, ip, [r0, #8]
20025f52:	e9c0 8800 	strd	r8, r8, [r0]
20025f56:	e9c0 7604 	strd	r7, r6, [r0, #16]
20025f5a:	e9c0 5406 	strd	r5, r4, [r0, #24]
20025f5e:	e9c0 2308 	strd	r2, r3, [r0, #32]
20025f62:	6681      	str	r1, [r0, #104]	@ 0x68
20025f64:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20025f68:	f8df e04c 	ldr.w	lr, [pc, #76]	@ 20025fb8 <mbedtls_sha256_starts+0x88>
20025f6c:	f8df c04c 	ldr.w	ip, [pc, #76]	@ 20025fbc <mbedtls_sha256_starts+0x8c>
20025f70:	4f09      	ldr	r7, [pc, #36]	@ (20025f98 <mbedtls_sha256_starts+0x68>)
20025f72:	4e0a      	ldr	r6, [pc, #40]	@ (20025f9c <mbedtls_sha256_starts+0x6c>)
20025f74:	4d0a      	ldr	r5, [pc, #40]	@ (20025fa0 <mbedtls_sha256_starts+0x70>)
20025f76:	4c0b      	ldr	r4, [pc, #44]	@ (20025fa4 <mbedtls_sha256_starts+0x74>)
20025f78:	4a0b      	ldr	r2, [pc, #44]	@ (20025fa8 <mbedtls_sha256_starts+0x78>)
20025f7a:	4b0c      	ldr	r3, [pc, #48]	@ (20025fac <mbedtls_sha256_starts+0x7c>)
20025f7c:	e7e5      	b.n	20025f4a <mbedtls_sha256_starts+0x1a>
20025f7e:	bf00      	nop
20025f80:	3070dd17 	.word	0x3070dd17
20025f84:	f70e5939 	.word	0xf70e5939
20025f88:	ffc00b31 	.word	0xffc00b31
20025f8c:	68581511 	.word	0x68581511
20025f90:	64f98fa7 	.word	0x64f98fa7
20025f94:	befa4fa4 	.word	0xbefa4fa4
20025f98:	3c6ef372 	.word	0x3c6ef372
20025f9c:	a54ff53a 	.word	0xa54ff53a
20025fa0:	510e527f 	.word	0x510e527f
20025fa4:	9b05688c 	.word	0x9b05688c
20025fa8:	1f83d9ab 	.word	0x1f83d9ab
20025fac:	5be0cd19 	.word	0x5be0cd19
20025fb0:	c1059ed8 	.word	0xc1059ed8
20025fb4:	367cd507 	.word	0x367cd507
20025fb8:	6a09e667 	.word	0x6a09e667
20025fbc:	bb67ae85 	.word	0xbb67ae85

20025fc0 <mbedtls_sha256_process>:
20025fc0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20025fc4:	b0cf      	sub	sp, #316	@ 0x13c
20025fc6:	aa06      	add	r2, sp, #24
20025fc8:	460b      	mov	r3, r1
20025fca:	4616      	mov	r6, r2
20025fcc:	9004      	str	r0, [sp, #16]
20025fce:	f100 0408 	add.w	r4, r0, #8
20025fd2:	f100 0728 	add.w	r7, r0, #40	@ 0x28
20025fd6:	4635      	mov	r5, r6
20025fd8:	6820      	ldr	r0, [r4, #0]
20025fda:	6861      	ldr	r1, [r4, #4]
20025fdc:	3408      	adds	r4, #8
20025fde:	c503      	stmia	r5!, {r0, r1}
20025fe0:	42bc      	cmp	r4, r7
20025fe2:	462e      	mov	r6, r5
20025fe4:	d1f7      	bne.n	20025fd6 <mbedtls_sha256_process+0x16>
20025fe6:	f10d 0a38 	add.w	sl, sp, #56	@ 0x38
20025fea:	4619      	mov	r1, r3
20025fec:	4650      	mov	r0, sl
20025fee:	f103 0440 	add.w	r4, r3, #64	@ 0x40
20025ff2:	784b      	ldrb	r3, [r1, #1]
20025ff4:	780d      	ldrb	r5, [r1, #0]
20025ff6:	041b      	lsls	r3, r3, #16
20025ff8:	ea43 6305 	orr.w	r3, r3, r5, lsl #24
20025ffc:	78cd      	ldrb	r5, [r1, #3]
20025ffe:	3104      	adds	r1, #4
20026000:	432b      	orrs	r3, r5
20026002:	f811 5c02 	ldrb.w	r5, [r1, #-2]
20026006:	428c      	cmp	r4, r1
20026008:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
2002600c:	f840 3b04 	str.w	r3, [r0], #4
20026010:	d1ef      	bne.n	20025ff2 <mbedtls_sha256_process+0x32>
20026012:	4996      	ldr	r1, [pc, #600]	@ (2002626c <mbedtls_sha256_process+0x2ac>)
20026014:	46d4      	mov	ip, sl
20026016:	e9d2 e705 	ldrd	lr, r7, [r2, #20]
2002601a:	e9d2 9600 	ldrd	r9, r6, [r2]
2002601e:	460d      	mov	r5, r1
20026020:	9100      	str	r1, [sp, #0]
20026022:	f8d2 801c 	ldr.w	r8, [r2, #28]
20026026:	f8d2 b010 	ldr.w	fp, [r2, #16]
2002602a:	e9d2 3202 	ldrd	r3, r2, [r2, #8]
2002602e:	6829      	ldr	r1, [r5, #0]
20026030:	f8dc 0000 	ldr.w	r0, [ip]
20026034:	ea4f 24fb 	mov.w	r4, fp, ror #11
20026038:	ea84 14bb 	eor.w	r4, r4, fp, ror #6
2002603c:	4401      	add	r1, r0
2002603e:	ea87 000e 	eor.w	r0, r7, lr
20026042:	ea84 647b 	eor.w	r4, r4, fp, ror #25
20026046:	ea00 000b 	and.w	r0, r0, fp
2002604a:	4078      	eors	r0, r7
2002604c:	4421      	add	r1, r4
2002604e:	4401      	add	r1, r0
20026050:	4441      	add	r1, r8
20026052:	ea4f 3879 	mov.w	r8, r9, ror #13
20026056:	ea88 08b9 	eor.w	r8, r8, r9, ror #2
2002605a:	ea88 58b9 	eor.w	r8, r8, r9, ror #22
2002605e:	440a      	add	r2, r1
20026060:	4488      	add	r8, r1
20026062:	ea49 0106 	orr.w	r1, r9, r6
20026066:	ea09 0006 	and.w	r0, r9, r6
2002606a:	4019      	ands	r1, r3
2002606c:	4301      	orrs	r1, r0
2002606e:	4488      	add	r8, r1
20026070:	f8dc 0004 	ldr.w	r0, [ip, #4]
20026074:	6869      	ldr	r1, [r5, #4]
20026076:	ea4f 3478 	mov.w	r4, r8, ror #13
2002607a:	4401      	add	r1, r0
2002607c:	ea8b 000e 	eor.w	r0, fp, lr
20026080:	4010      	ands	r0, r2
20026082:	ea80 000e 	eor.w	r0, r0, lr
20026086:	4439      	add	r1, r7
20026088:	4401      	add	r1, r0
2002608a:	ea4f 20f2 	mov.w	r0, r2, ror #11
2002608e:	ea80 10b2 	eor.w	r0, r0, r2, ror #6
20026092:	ea80 6072 	eor.w	r0, r0, r2, ror #25
20026096:	ea84 04b8 	eor.w	r4, r4, r8, ror #2
2002609a:	4401      	add	r1, r0
2002609c:	ea84 54b8 	eor.w	r4, r4, r8, ror #22
200260a0:	440b      	add	r3, r1
200260a2:	440c      	add	r4, r1
200260a4:	ea48 0109 	orr.w	r1, r8, r9
200260a8:	ea08 0009 	and.w	r0, r8, r9
200260ac:	4031      	ands	r1, r6
200260ae:	4301      	orrs	r1, r0
200260b0:	440c      	add	r4, r1
200260b2:	f8dc 0008 	ldr.w	r0, [ip, #8]
200260b6:	68a9      	ldr	r1, [r5, #8]
200260b8:	ea82 0703 	eor.w	r7, r2, r3
200260bc:	4401      	add	r1, r0
200260be:	ea82 000b 	eor.w	r0, r2, fp
200260c2:	4018      	ands	r0, r3
200260c4:	ea80 000b 	eor.w	r0, r0, fp
200260c8:	4471      	add	r1, lr
200260ca:	4401      	add	r1, r0
200260cc:	ea4f 20f3 	mov.w	r0, r3, ror #11
200260d0:	ea80 10b3 	eor.w	r0, r0, r3, ror #6
200260d4:	ea80 6073 	eor.w	r0, r0, r3, ror #25
200260d8:	4401      	add	r1, r0
200260da:	ea4f 3074 	mov.w	r0, r4, ror #13
200260de:	ea80 00b4 	eor.w	r0, r0, r4, ror #2
200260e2:	ea80 50b4 	eor.w	r0, r0, r4, ror #22
200260e6:	eb06 0e01 	add.w	lr, r6, r1
200260ea:	4408      	add	r0, r1
200260ec:	ea48 0104 	orr.w	r1, r8, r4
200260f0:	ea08 0604 	and.w	r6, r8, r4
200260f4:	ea01 0109 	and.w	r1, r1, r9
200260f8:	4331      	orrs	r1, r6
200260fa:	4408      	add	r0, r1
200260fc:	f8dc 600c 	ldr.w	r6, [ip, #12]
20026100:	68e9      	ldr	r1, [r5, #12]
20026102:	ea07 070e 	and.w	r7, r7, lr
20026106:	440e      	add	r6, r1
20026108:	ea4f 21fe 	mov.w	r1, lr, ror #11
2002610c:	4057      	eors	r7, r2
2002610e:	445e      	add	r6, fp
20026110:	ea81 11be 	eor.w	r1, r1, lr, ror #6
20026114:	ea81 617e 	eor.w	r1, r1, lr, ror #25
20026118:	443e      	add	r6, r7
2002611a:	440e      	add	r6, r1
2002611c:	ea4f 3170 	mov.w	r1, r0, ror #13
20026120:	ea81 01b0 	eor.w	r1, r1, r0, ror #2
20026124:	ea81 51b0 	eor.w	r1, r1, r0, ror #22
20026128:	44b1      	add	r9, r6
2002612a:	4431      	add	r1, r6
2002612c:	ea44 0600 	orr.w	r6, r4, r0
20026130:	ea04 0700 	and.w	r7, r4, r0
20026134:	ea06 0608 	and.w	r6, r6, r8
20026138:	433e      	orrs	r6, r7
2002613a:	4431      	add	r1, r6
2002613c:	f8dc 7010 	ldr.w	r7, [ip, #16]
20026140:	692e      	ldr	r6, [r5, #16]
20026142:	3520      	adds	r5, #32
20026144:	443e      	add	r6, r7
20026146:	4416      	add	r6, r2
20026148:	ea83 020e 	eor.w	r2, r3, lr
2002614c:	ea02 0209 	and.w	r2, r2, r9
20026150:	405a      	eors	r2, r3
20026152:	4416      	add	r6, r2
20026154:	ea4f 22f9 	mov.w	r2, r9, ror #11
20026158:	ea82 12b9 	eor.w	r2, r2, r9, ror #6
2002615c:	ea82 6279 	eor.w	r2, r2, r9, ror #25
20026160:	4416      	add	r6, r2
20026162:	ea4f 3271 	mov.w	r2, r1, ror #13
20026166:	ea82 02b1 	eor.w	r2, r2, r1, ror #2
2002616a:	ea82 52b1 	eor.w	r2, r2, r1, ror #22
2002616e:	44b0      	add	r8, r6
20026170:	4432      	add	r2, r6
20026172:	ea40 0601 	orr.w	r6, r0, r1
20026176:	ea00 0701 	and.w	r7, r0, r1
2002617a:	4026      	ands	r6, r4
2002617c:	433e      	orrs	r6, r7
2002617e:	4432      	add	r2, r6
20026180:	f8dc 7014 	ldr.w	r7, [ip, #20]
20026184:	f855 6c0c 	ldr.w	r6, [r5, #-12]
20026188:	f10c 0c20 	add.w	ip, ip, #32
2002618c:	443e      	add	r6, r7
2002618e:	441e      	add	r6, r3
20026190:	ea8e 0309 	eor.w	r3, lr, r9
20026194:	ea03 0308 	and.w	r3, r3, r8
20026198:	ea83 030e 	eor.w	r3, r3, lr
2002619c:	441e      	add	r6, r3
2002619e:	ea4f 23f8 	mov.w	r3, r8, ror #11
200261a2:	ea83 13b8 	eor.w	r3, r3, r8, ror #6
200261a6:	ea83 6378 	eor.w	r3, r3, r8, ror #25
200261aa:	441e      	add	r6, r3
200261ac:	ea4f 3372 	mov.w	r3, r2, ror #13
200261b0:	ea83 03b2 	eor.w	r3, r3, r2, ror #2
200261b4:	19a7      	adds	r7, r4, r6
200261b6:	ea83 53b2 	eor.w	r3, r3, r2, ror #22
200261ba:	ea41 0402 	orr.w	r4, r1, r2
200261be:	4433      	add	r3, r6
200261c0:	4004      	ands	r4, r0
200261c2:	ea01 0602 	and.w	r6, r1, r2
200261c6:	4334      	orrs	r4, r6
200261c8:	4423      	add	r3, r4
200261ca:	f85c 6c08 	ldr.w	r6, [ip, #-8]
200261ce:	f855 4c08 	ldr.w	r4, [r5, #-8]
200261d2:	4434      	add	r4, r6
200261d4:	ea89 0608 	eor.w	r6, r9, r8
200261d8:	403e      	ands	r6, r7
200261da:	ea86 0609 	eor.w	r6, r6, r9
200261de:	4474      	add	r4, lr
200261e0:	4434      	add	r4, r6
200261e2:	ea4f 26f7 	mov.w	r6, r7, ror #11
200261e6:	ea86 16b7 	eor.w	r6, r6, r7, ror #6
200261ea:	ea86 6677 	eor.w	r6, r6, r7, ror #25
200261ee:	4434      	add	r4, r6
200261f0:	eb00 0e04 	add.w	lr, r0, r4
200261f4:	ea4f 3073 	mov.w	r0, r3, ror #13
200261f8:	ea80 00b3 	eor.w	r0, r0, r3, ror #2
200261fc:	ea80 50b3 	eor.w	r0, r0, r3, ror #22
20026200:	4420      	add	r0, r4
20026202:	ea42 0403 	orr.w	r4, r2, r3
20026206:	400c      	ands	r4, r1
20026208:	ea02 0603 	and.w	r6, r2, r3
2002620c:	4334      	orrs	r4, r6
2002620e:	1906      	adds	r6, r0, r4
20026210:	f855 0c04 	ldr.w	r0, [r5, #-4]
20026214:	f85c 4c04 	ldr.w	r4, [ip, #-4]
20026218:	4420      	add	r0, r4
2002621a:	ea88 0407 	eor.w	r4, r8, r7
2002621e:	ea04 040e 	and.w	r4, r4, lr
20026222:	4448      	add	r0, r9
20026224:	ea84 0408 	eor.w	r4, r4, r8
20026228:	4420      	add	r0, r4
2002622a:	ea4f 24fe 	mov.w	r4, lr, ror #11
2002622e:	ea84 14be 	eor.w	r4, r4, lr, ror #6
20026232:	ea84 647e 	eor.w	r4, r4, lr, ror #25
20026236:	4420      	add	r0, r4
20026238:	eb01 0b00 	add.w	fp, r1, r0
2002623c:	ea4f 3176 	mov.w	r1, r6, ror #13
20026240:	ea81 01b6 	eor.w	r1, r1, r6, ror #2
20026244:	ea81 51b6 	eor.w	r1, r1, r6, ror #22
20026248:	4401      	add	r1, r0
2002624a:	ea43 0006 	orr.w	r0, r3, r6
2002624e:	4010      	ands	r0, r2
20026250:	ea03 0406 	and.w	r4, r3, r6
20026254:	4320      	orrs	r0, r4
20026256:	eb01 0900 	add.w	r9, r1, r0
2002625a:	4905      	ldr	r1, [pc, #20]	@ (20026270 <mbedtls_sha256_process+0x2b0>)
2002625c:	42a9      	cmp	r1, r5
2002625e:	f47f aee6 	bne.w	2002602e <mbedtls_sha256_process+0x6e>
20026262:	f10a 01c0 	add.w	r1, sl, #192	@ 0xc0
20026266:	9105      	str	r1, [sp, #20]
20026268:	e004      	b.n	20026274 <mbedtls_sha256_process+0x2b4>
2002626a:	bf00      	nop
2002626c:	2002bddc 	.word	0x2002bddc
20026270:	2002be1c 	.word	0x2002be1c
20026274:	f8da 1038 	ldr.w	r1, [sl, #56]	@ 0x38
20026278:	f8da 5004 	ldr.w	r5, [sl, #4]
2002627c:	ea4f 44f1 	mov.w	r4, r1, ror #19
20026280:	ea84 4471 	eor.w	r4, r4, r1, ror #17
20026284:	f8da 0000 	ldr.w	r0, [sl]
20026288:	ea84 2491 	eor.w	r4, r4, r1, lsr #10
2002628c:	f8da 1024 	ldr.w	r1, [sl, #36]	@ 0x24
20026290:	f10a 0a20 	add.w	sl, sl, #32
20026294:	4401      	add	r1, r0
20026296:	ea4f 40b5 	mov.w	r0, r5, ror #18
2002629a:	ea80 10f5 	eor.w	r0, r0, r5, ror #7
2002629e:	ea80 00d5 	eor.w	r0, r0, r5, lsr #3
200262a2:	4421      	add	r1, r4
200262a4:	4401      	add	r1, r0
200262a6:	9103      	str	r1, [sp, #12]
200262a8:	ea87 000e 	eor.w	r0, r7, lr
200262ac:	9900      	ldr	r1, [sp, #0]
200262ae:	ea4f 24fb 	mov.w	r4, fp, ror #11
200262b2:	ea84 14bb 	eor.w	r4, r4, fp, ror #6
200262b6:	ea00 000b 	and.w	r0, r0, fp
200262ba:	ea84 647b 	eor.w	r4, r4, fp, ror #25
200262be:	6c09      	ldr	r1, [r1, #64]	@ 0x40
200262c0:	4078      	eors	r0, r7
200262c2:	4420      	add	r0, r4
200262c4:	4401      	add	r1, r0
200262c6:	9803      	ldr	r0, [sp, #12]
200262c8:	ea4f 3479 	mov.w	r4, r9, ror #13
200262cc:	4401      	add	r1, r0
200262ce:	4441      	add	r1, r8
200262d0:	eb02 0801 	add.w	r8, r2, r1
200262d4:	ea49 0206 	orr.w	r2, r9, r6
200262d8:	f8ca 0020 	str.w	r0, [sl, #32]
200262dc:	ea84 04b9 	eor.w	r4, r4, r9, ror #2
200262e0:	ea09 0006 	and.w	r0, r9, r6
200262e4:	401a      	ands	r2, r3
200262e6:	4302      	orrs	r2, r0
200262e8:	ea84 54b9 	eor.w	r4, r4, r9, ror #22
200262ec:	4414      	add	r4, r2
200262ee:	f8da 201c 	ldr.w	r2, [sl, #28]
200262f2:	440c      	add	r4, r1
200262f4:	ea4f 4cf2 	mov.w	ip, r2, ror #19
200262f8:	ea8c 4c72 	eor.w	ip, ip, r2, ror #17
200262fc:	f85a 1c18 	ldr.w	r1, [sl, #-24]
20026300:	ea8c 2c92 	eor.w	ip, ip, r2, lsr #10
20026304:	f8da 2008 	ldr.w	r2, [sl, #8]
20026308:	18a8      	adds	r0, r5, r2
2002630a:	ea4f 42b1 	mov.w	r2, r1, ror #18
2002630e:	ea82 12f1 	eor.w	r2, r2, r1, ror #7
20026312:	ea82 02d1 	eor.w	r2, r2, r1, lsr #3
20026316:	4460      	add	r0, ip
20026318:	4410      	add	r0, r2
2002631a:	9a00      	ldr	r2, [sp, #0]
2002631c:	ea8b 050e 	eor.w	r5, fp, lr
20026320:	6c52      	ldr	r2, [r2, #68]	@ 0x44
20026322:	ea05 0508 	and.w	r5, r5, r8
20026326:	443a      	add	r2, r7
20026328:	4402      	add	r2, r0
2002632a:	ea85 050e 	eor.w	r5, r5, lr
2002632e:	4415      	add	r5, r2
20026330:	ea4f 22f8 	mov.w	r2, r8, ror #11
20026334:	ea82 12b8 	eor.w	r2, r2, r8, ror #6
20026338:	ea82 6278 	eor.w	r2, r2, r8, ror #25
2002633c:	442a      	add	r2, r5
2002633e:	4413      	add	r3, r2
20026340:	9301      	str	r3, [sp, #4]
20026342:	ea49 0504 	orr.w	r5, r9, r4
20026346:	ea4f 3374 	mov.w	r3, r4, ror #13
2002634a:	ea09 0704 	and.w	r7, r9, r4
2002634e:	ea83 03b4 	eor.w	r3, r3, r4, ror #2
20026352:	4035      	ands	r5, r6
20026354:	433d      	orrs	r5, r7
20026356:	ea83 53b4 	eor.w	r3, r3, r4, ror #22
2002635a:	442b      	add	r3, r5
2002635c:	4413      	add	r3, r2
2002635e:	9a03      	ldr	r2, [sp, #12]
20026360:	f85a 5c14 	ldr.w	r5, [sl, #-20]
20026364:	ea4f 4cf2 	mov.w	ip, r2, ror #19
20026368:	ea8c 4c72 	eor.w	ip, ip, r2, ror #17
2002636c:	ea8c 2c92 	eor.w	ip, ip, r2, lsr #10
20026370:	f8da 200c 	ldr.w	r2, [sl, #12]
20026374:	f8ca 0024 	str.w	r0, [sl, #36]	@ 0x24
20026378:	188f      	adds	r7, r1, r2
2002637a:	ea4f 42b5 	mov.w	r2, r5, ror #18
2002637e:	ea82 12f5 	eor.w	r2, r2, r5, ror #7
20026382:	ea82 02d5 	eor.w	r2, r2, r5, lsr #3
20026386:	4467      	add	r7, ip
20026388:	4417      	add	r7, r2
2002638a:	9a01      	ldr	r2, [sp, #4]
2002638c:	ea8b 0108 	eor.w	r1, fp, r8
20026390:	4011      	ands	r1, r2
20026392:	9a00      	ldr	r2, [sp, #0]
20026394:	ea81 010b 	eor.w	r1, r1, fp
20026398:	6c92      	ldr	r2, [r2, #72]	@ 0x48
2002639a:	f8ca 7028 	str.w	r7, [sl, #40]	@ 0x28
2002639e:	4472      	add	r2, lr
200263a0:	443a      	add	r2, r7
200263a2:	eb01 0c02 	add.w	ip, r1, r2
200263a6:	9a01      	ldr	r2, [sp, #4]
200263a8:	9901      	ldr	r1, [sp, #4]
200263aa:	ea4f 22f2 	mov.w	r2, r2, ror #11
200263ae:	ea82 12b1 	eor.w	r2, r2, r1, ror #6
200263b2:	ea82 6271 	eor.w	r2, r2, r1, ror #25
200263b6:	4462      	add	r2, ip
200263b8:	18b1      	adds	r1, r6, r2
200263ba:	9102      	str	r1, [sp, #8]
200263bc:	ea44 0603 	orr.w	r6, r4, r3
200263c0:	ea4f 3173 	mov.w	r1, r3, ror #13
200263c4:	ea04 0c03 	and.w	ip, r4, r3
200263c8:	ea81 01b3 	eor.w	r1, r1, r3, ror #2
200263cc:	ea06 0609 	and.w	r6, r6, r9
200263d0:	ea46 060c 	orr.w	r6, r6, ip
200263d4:	ea81 51b3 	eor.w	r1, r1, r3, ror #22
200263d8:	4431      	add	r1, r6
200263da:	4411      	add	r1, r2
200263dc:	ea4f 42f0 	mov.w	r2, r0, ror #19
200263e0:	ea82 4270 	eor.w	r2, r2, r0, ror #17
200263e4:	f85a 6c10 	ldr.w	r6, [sl, #-16]
200263e8:	ea82 2090 	eor.w	r0, r2, r0, lsr #10
200263ec:	f8da 2010 	ldr.w	r2, [sl, #16]
200263f0:	ea03 0e01 	and.w	lr, r3, r1
200263f4:	4415      	add	r5, r2
200263f6:	ea4f 42b6 	mov.w	r2, r6, ror #18
200263fa:	ea82 12f6 	eor.w	r2, r2, r6, ror #7
200263fe:	ea82 02d6 	eor.w	r2, r2, r6, lsr #3
20026402:	4405      	add	r5, r0
20026404:	4415      	add	r5, r2
20026406:	9a01      	ldr	r2, [sp, #4]
20026408:	ea88 0002 	eor.w	r0, r8, r2
2002640c:	9a02      	ldr	r2, [sp, #8]
2002640e:	4010      	ands	r0, r2
20026410:	9a00      	ldr	r2, [sp, #0]
20026412:	ea80 0008 	eor.w	r0, r0, r8
20026416:	6cd2      	ldr	r2, [r2, #76]	@ 0x4c
20026418:	f8ca 502c 	str.w	r5, [sl, #44]	@ 0x2c
2002641c:	445a      	add	r2, fp
2002641e:	442a      	add	r2, r5
20026420:	eb00 0c02 	add.w	ip, r0, r2
20026424:	9a02      	ldr	r2, [sp, #8]
20026426:	9802      	ldr	r0, [sp, #8]
20026428:	ea4f 22f2 	mov.w	r2, r2, ror #11
2002642c:	ea82 12b0 	eor.w	r2, r2, r0, ror #6
20026430:	ea82 6270 	eor.w	r2, r2, r0, ror #25
20026434:	4462      	add	r2, ip
20026436:	ea4f 3071 	mov.w	r0, r1, ror #13
2002643a:	ea43 0c01 	orr.w	ip, r3, r1
2002643e:	ea80 00b1 	eor.w	r0, r0, r1, ror #2
20026442:	ea0c 0c04 	and.w	ip, ip, r4
20026446:	ea4c 0c0e 	orr.w	ip, ip, lr
2002644a:	ea80 50b1 	eor.w	r0, r0, r1, ror #22
2002644e:	4460      	add	r0, ip
20026450:	4410      	add	r0, r2
20026452:	4491      	add	r9, r2
20026454:	ea4f 42f7 	mov.w	r2, r7, ror #19
20026458:	ea82 4277 	eor.w	r2, r2, r7, ror #17
2002645c:	f85a cc0c 	ldr.w	ip, [sl, #-12]
20026460:	ea82 2797 	eor.w	r7, r2, r7, lsr #10
20026464:	f8da 2014 	ldr.w	r2, [sl, #20]
20026468:	ea01 0e00 	and.w	lr, r1, r0
2002646c:	4416      	add	r6, r2
2002646e:	ea4f 42bc 	mov.w	r2, ip, ror #18
20026472:	ea82 12fc 	eor.w	r2, r2, ip, ror #7
20026476:	ea82 02dc 	eor.w	r2, r2, ip, lsr #3
2002647a:	443e      	add	r6, r7
2002647c:	4416      	add	r6, r2
2002647e:	e9dd 2701 	ldrd	r2, r7, [sp, #4]
20026482:	4057      	eors	r7, r2
20026484:	ea07 0709 	and.w	r7, r7, r9
20026488:	4057      	eors	r7, r2
2002648a:	9a00      	ldr	r2, [sp, #0]
2002648c:	f8ca 6030 	str.w	r6, [sl, #48]	@ 0x30
20026490:	6d12      	ldr	r2, [r2, #80]	@ 0x50
20026492:	4432      	add	r2, r6
20026494:	4442      	add	r2, r8
20026496:	443a      	add	r2, r7
20026498:	ea4f 27f9 	mov.w	r7, r9, ror #11
2002649c:	ea87 17b9 	eor.w	r7, r7, r9, ror #6
200264a0:	ea87 6779 	eor.w	r7, r7, r9, ror #25
200264a4:	4417      	add	r7, r2
200264a6:	eb04 0807 	add.w	r8, r4, r7
200264aa:	ea4f 3270 	mov.w	r2, r0, ror #13
200264ae:	ea41 0400 	orr.w	r4, r1, r0
200264b2:	ea82 02b0 	eor.w	r2, r2, r0, ror #2
200264b6:	401c      	ands	r4, r3
200264b8:	ea44 040e 	orr.w	r4, r4, lr
200264bc:	ea82 52b0 	eor.w	r2, r2, r0, ror #22
200264c0:	4422      	add	r2, r4
200264c2:	ea4f 44f5 	mov.w	r4, r5, ror #19
200264c6:	ea84 4475 	eor.w	r4, r4, r5, ror #17
200264ca:	ea84 2495 	eor.w	r4, r4, r5, lsr #10
200264ce:	f8da 5018 	ldr.w	r5, [sl, #24]
200264d2:	f85a ec08 	ldr.w	lr, [sl, #-8]
200264d6:	4465      	add	r5, ip
200264d8:	4425      	add	r5, r4
200264da:	ea4f 44be 	mov.w	r4, lr, ror #18
200264de:	ea84 14fe 	eor.w	r4, r4, lr, ror #7
200264e2:	ea84 04de 	eor.w	r4, r4, lr, lsr #3
200264e6:	4425      	add	r5, r4
200264e8:	9c02      	ldr	r4, [sp, #8]
200264ea:	443a      	add	r2, r7
200264ec:	ea84 0709 	eor.w	r7, r4, r9
200264f0:	ea07 0708 	and.w	r7, r7, r8
200264f4:	ea87 0c04 	eor.w	ip, r7, r4
200264f8:	9c00      	ldr	r4, [sp, #0]
200264fa:	9f01      	ldr	r7, [sp, #4]
200264fc:	6d64      	ldr	r4, [r4, #84]	@ 0x54
200264fe:	ea00 0b02 	and.w	fp, r0, r2
20026502:	442c      	add	r4, r5
20026504:	443c      	add	r4, r7
20026506:	eb0c 0704 	add.w	r7, ip, r4
2002650a:	ea4f 24f8 	mov.w	r4, r8, ror #11
2002650e:	ea84 14b8 	eor.w	r4, r4, r8, ror #6
20026512:	ea84 6478 	eor.w	r4, r4, r8, ror #25
20026516:	443c      	add	r4, r7
20026518:	191f      	adds	r7, r3, r4
2002651a:	ea40 0c02 	orr.w	ip, r0, r2
2002651e:	ea4f 3372 	mov.w	r3, r2, ror #13
20026522:	ea0c 0c01 	and.w	ip, ip, r1
20026526:	ea83 03b2 	eor.w	r3, r3, r2, ror #2
2002652a:	ea4c 0c0b 	orr.w	ip, ip, fp
2002652e:	ea83 53b2 	eor.w	r3, r3, r2, ror #22
20026532:	4463      	add	r3, ip
20026534:	4423      	add	r3, r4
20026536:	ea4f 44f6 	mov.w	r4, r6, ror #19
2002653a:	ea84 4476 	eor.w	r4, r4, r6, ror #17
2002653e:	ea84 2496 	eor.w	r4, r4, r6, lsr #10
20026542:	f8da 601c 	ldr.w	r6, [sl, #28]
20026546:	f85a cc04 	ldr.w	ip, [sl, #-4]
2002654a:	4476      	add	r6, lr
2002654c:	4426      	add	r6, r4
2002654e:	ea4f 44bc 	mov.w	r4, ip, ror #18
20026552:	ea84 14fc 	eor.w	r4, r4, ip, ror #7
20026556:	ea84 04dc 	eor.w	r4, r4, ip, lsr #3
2002655a:	eb06 0b04 	add.w	fp, r6, r4
2002655e:	9c00      	ldr	r4, [sp, #0]
20026560:	9e02      	ldr	r6, [sp, #8]
20026562:	6da4      	ldr	r4, [r4, #88]	@ 0x58
20026564:	ea89 0e08 	eor.w	lr, r9, r8
20026568:	445c      	add	r4, fp
2002656a:	4434      	add	r4, r6
2002656c:	ea0e 0e07 	and.w	lr, lr, r7
20026570:	ea4f 26f7 	mov.w	r6, r7, ror #11
20026574:	ea8e 0e09 	eor.w	lr, lr, r9
20026578:	ea86 16b7 	eor.w	r6, r6, r7, ror #6
2002657c:	4474      	add	r4, lr
2002657e:	ea86 6677 	eor.w	r6, r6, r7, ror #25
20026582:	4434      	add	r4, r6
20026584:	eb01 0e04 	add.w	lr, r1, r4
20026588:	ea42 0603 	orr.w	r6, r2, r3
2002658c:	ea4f 3173 	mov.w	r1, r3, ror #13
20026590:	f8ca b038 	str.w	fp, [sl, #56]	@ 0x38
20026594:	4006      	ands	r6, r0
20026596:	ea02 0b03 	and.w	fp, r2, r3
2002659a:	ea81 01b3 	eor.w	r1, r1, r3, ror #2
2002659e:	ea46 060b 	orr.w	r6, r6, fp
200265a2:	ea81 51b3 	eor.w	r1, r1, r3, ror #22
200265a6:	4431      	add	r1, r6
200265a8:	190e      	adds	r6, r1, r4
200265aa:	ea4f 41f5 	mov.w	r1, r5, ror #19
200265ae:	ea81 4175 	eor.w	r1, r1, r5, ror #17
200265b2:	f8ca 5034 	str.w	r5, [sl, #52]	@ 0x34
200265b6:	ea81 2195 	eor.w	r1, r1, r5, lsr #10
200265ba:	9d03      	ldr	r5, [sp, #12]
200265bc:	f8da 4000 	ldr.w	r4, [sl]
200265c0:	4465      	add	r5, ip
200265c2:	4429      	add	r1, r5
200265c4:	ea4f 45b4 	mov.w	r5, r4, ror #18
200265c8:	ea85 15f4 	eor.w	r5, r5, r4, ror #7
200265cc:	ea85 05d4 	eor.w	r5, r5, r4, lsr #3
200265d0:	194c      	adds	r4, r1, r5
200265d2:	9900      	ldr	r1, [sp, #0]
200265d4:	ea88 0507 	eor.w	r5, r8, r7
200265d8:	6dc9      	ldr	r1, [r1, #92]	@ 0x5c
200265da:	ea05 050e 	and.w	r5, r5, lr
200265de:	4421      	add	r1, r4
200265e0:	4449      	add	r1, r9
200265e2:	ea85 0508 	eor.w	r5, r5, r8
200265e6:	440d      	add	r5, r1
200265e8:	ea4f 21fe 	mov.w	r1, lr, ror #11
200265ec:	ea81 11be 	eor.w	r1, r1, lr, ror #6
200265f0:	ea81 617e 	eor.w	r1, r1, lr, ror #25
200265f4:	4429      	add	r1, r5
200265f6:	f8ca 403c 	str.w	r4, [sl, #60]	@ 0x3c
200265fa:	eb00 0b01 	add.w	fp, r0, r1
200265fe:	ea43 0406 	orr.w	r4, r3, r6
20026602:	ea4f 3076 	mov.w	r0, r6, ror #13
20026606:	ea80 00b6 	eor.w	r0, r0, r6, ror #2
2002660a:	4014      	ands	r4, r2
2002660c:	ea03 0506 	and.w	r5, r3, r6
20026610:	ea80 50b6 	eor.w	r0, r0, r6, ror #22
20026614:	432c      	orrs	r4, r5
20026616:	4420      	add	r0, r4
20026618:	eb00 0901 	add.w	r9, r0, r1
2002661c:	9900      	ldr	r1, [sp, #0]
2002661e:	3120      	adds	r1, #32
20026620:	9100      	str	r1, [sp, #0]
20026622:	9905      	ldr	r1, [sp, #20]
20026624:	4551      	cmp	r1, sl
20026626:	f47f ae25 	bne.w	20026274 <mbedtls_sha256_process+0x2b4>
2002662a:	9308      	str	r3, [sp, #32]
2002662c:	9b04      	ldr	r3, [sp, #16]
2002662e:	a906      	add	r1, sp, #24
20026630:	60ca      	str	r2, [r1, #12]
20026632:	f8c1 801c 	str.w	r8, [r1, #28]
20026636:	1d1a      	adds	r2, r3, #4
20026638:	618f      	str	r7, [r1, #24]
2002663a:	3324      	adds	r3, #36	@ 0x24
2002663c:	f8c1 e014 	str.w	lr, [r1, #20]
20026640:	604e      	str	r6, [r1, #4]
20026642:	f8c1 b010 	str.w	fp, [r1, #16]
20026646:	f8c1 9000 	str.w	r9, [r1]
2002664a:	f852 0f04 	ldr.w	r0, [r2, #4]!
2002664e:	f851 4b04 	ldr.w	r4, [r1], #4
20026652:	4293      	cmp	r3, r2
20026654:	4420      	add	r0, r4
20026656:	6010      	str	r0, [r2, #0]
20026658:	d1f7      	bne.n	2002664a <mbedtls_sha256_process+0x68a>
2002665a:	b04f      	add	sp, #316	@ 0x13c
2002665c:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}

20026660 <mbedtls_sha256_update.part.0>:
20026660:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
20026664:	6803      	ldr	r3, [r0, #0]
20026666:	4605      	mov	r5, r0
20026668:	f003 073f 	and.w	r7, r3, #63	@ 0x3f
2002666c:	189b      	adds	r3, r3, r2
2002666e:	6003      	str	r3, [r0, #0]
20026670:	bf28      	it	cs
20026672:	6843      	ldrcs	r3, [r0, #4]
20026674:	460e      	mov	r6, r1
20026676:	bf28      	it	cs
20026678:	3301      	addcs	r3, #1
2002667a:	4614      	mov	r4, r2
2002667c:	bf28      	it	cs
2002667e:	6043      	strcs	r3, [r0, #4]
20026680:	b197      	cbz	r7, 200266a8 <mbedtls_sha256_update.part.0+0x48>
20026682:	f1c7 0940 	rsb	r9, r7, #64	@ 0x40
20026686:	4591      	cmp	r9, r2
20026688:	d80e      	bhi.n	200266a8 <mbedtls_sha256_update.part.0+0x48>
2002668a:	f100 0828 	add.w	r8, r0, #40	@ 0x28
2002668e:	464a      	mov	r2, r9
20026690:	eb08 0007 	add.w	r0, r8, r7
20026694:	f004 f8f8 	bl	2002a888 <memcpy>
20026698:	3c40      	subs	r4, #64	@ 0x40
2002669a:	4641      	mov	r1, r8
2002669c:	4628      	mov	r0, r5
2002669e:	443c      	add	r4, r7
200266a0:	f7ff fc8e 	bl	20025fc0 <mbedtls_sha256_process>
200266a4:	2700      	movs	r7, #0
200266a6:	444e      	add	r6, r9
200266a8:	46a0      	mov	r8, r4
200266aa:	eb04 0906 	add.w	r9, r4, r6
200266ae:	e004      	b.n	200266ba <mbedtls_sha256_update.part.0+0x5a>
200266b0:	4628      	mov	r0, r5
200266b2:	f7ff fc85 	bl	20025fc0 <mbedtls_sha256_process>
200266b6:	f1a8 0840 	sub.w	r8, r8, #64	@ 0x40
200266ba:	f1b8 0f3f 	cmp.w	r8, #63	@ 0x3f
200266be:	eba9 0108 	sub.w	r1, r9, r8
200266c2:	d8f5      	bhi.n	200266b0 <mbedtls_sha256_update.part.0+0x50>
200266c4:	f06f 033f 	mvn.w	r3, #63	@ 0x3f
200266c8:	09a1      	lsrs	r1, r4, #6
200266ca:	4359      	muls	r1, r3
200266cc:	1862      	adds	r2, r4, r1
200266ce:	d007      	beq.n	200266e0 <mbedtls_sha256_update.part.0+0x80>
200266d0:	f105 0028 	add.w	r0, r5, #40	@ 0x28
200266d4:	1a71      	subs	r1, r6, r1
200266d6:	4438      	add	r0, r7
200266d8:	e8bd 43f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
200266dc:	f004 b8d4 	b.w	2002a888 <memcpy>
200266e0:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

200266e4 <mbedtls_sha256_update>:
200266e4:	b10a      	cbz	r2, 200266ea <mbedtls_sha256_update+0x6>
200266e6:	f7ff bfbb 	b.w	20026660 <mbedtls_sha256_update.part.0>
200266ea:	4770      	bx	lr

200266ec <mbedtls_sha256_finish>:
200266ec:	b537      	push	{r0, r1, r2, r4, r5, lr}
200266ee:	4604      	mov	r4, r0
200266f0:	460d      	mov	r5, r1
200266f2:	e9d0 2100 	ldrd	r2, r1, [r0]
200266f6:	0f53      	lsrs	r3, r2, #29
200266f8:	ea43 03c1 	orr.w	r3, r3, r1, lsl #3
200266fc:	ba1b      	rev	r3, r3
200266fe:	9300      	str	r3, [sp, #0]
20026700:	00d3      	lsls	r3, r2, #3
20026702:	f002 023f 	and.w	r2, r2, #63	@ 0x3f
20026706:	2a37      	cmp	r2, #55	@ 0x37
20026708:	ba1b      	rev	r3, r3
2002670a:	bf94      	ite	ls
2002670c:	f1c2 0238 	rsbls	r2, r2, #56	@ 0x38
20026710:	f1c2 0278 	rsbhi	r2, r2, #120	@ 0x78
20026714:	492b      	ldr	r1, [pc, #172]	@ (200267c4 <mbedtls_sha256_finish+0xd8>)
20026716:	9301      	str	r3, [sp, #4]
20026718:	f7ff ffe4 	bl	200266e4 <mbedtls_sha256_update>
2002671c:	2208      	movs	r2, #8
2002671e:	4669      	mov	r1, sp
20026720:	4620      	mov	r0, r4
20026722:	f7ff ff9d 	bl	20026660 <mbedtls_sha256_update.part.0>
20026726:	7ae3      	ldrb	r3, [r4, #11]
20026728:	702b      	strb	r3, [r5, #0]
2002672a:	8963      	ldrh	r3, [r4, #10]
2002672c:	706b      	strb	r3, [r5, #1]
2002672e:	68a3      	ldr	r3, [r4, #8]
20026730:	0a1b      	lsrs	r3, r3, #8
20026732:	70ab      	strb	r3, [r5, #2]
20026734:	68a3      	ldr	r3, [r4, #8]
20026736:	70eb      	strb	r3, [r5, #3]
20026738:	7be3      	ldrb	r3, [r4, #15]
2002673a:	712b      	strb	r3, [r5, #4]
2002673c:	89e3      	ldrh	r3, [r4, #14]
2002673e:	716b      	strb	r3, [r5, #5]
20026740:	68e3      	ldr	r3, [r4, #12]
20026742:	0a1b      	lsrs	r3, r3, #8
20026744:	71ab      	strb	r3, [r5, #6]
20026746:	68e3      	ldr	r3, [r4, #12]
20026748:	71eb      	strb	r3, [r5, #7]
2002674a:	7ce3      	ldrb	r3, [r4, #19]
2002674c:	722b      	strb	r3, [r5, #8]
2002674e:	8a63      	ldrh	r3, [r4, #18]
20026750:	726b      	strb	r3, [r5, #9]
20026752:	6923      	ldr	r3, [r4, #16]
20026754:	0a1b      	lsrs	r3, r3, #8
20026756:	72ab      	strb	r3, [r5, #10]
20026758:	6923      	ldr	r3, [r4, #16]
2002675a:	72eb      	strb	r3, [r5, #11]
2002675c:	7de3      	ldrb	r3, [r4, #23]
2002675e:	732b      	strb	r3, [r5, #12]
20026760:	8ae3      	ldrh	r3, [r4, #22]
20026762:	736b      	strb	r3, [r5, #13]
20026764:	6963      	ldr	r3, [r4, #20]
20026766:	0a1b      	lsrs	r3, r3, #8
20026768:	73ab      	strb	r3, [r5, #14]
2002676a:	6963      	ldr	r3, [r4, #20]
2002676c:	73eb      	strb	r3, [r5, #15]
2002676e:	7ee3      	ldrb	r3, [r4, #27]
20026770:	742b      	strb	r3, [r5, #16]
20026772:	8b63      	ldrh	r3, [r4, #26]
20026774:	746b      	strb	r3, [r5, #17]
20026776:	69a3      	ldr	r3, [r4, #24]
20026778:	0a1b      	lsrs	r3, r3, #8
2002677a:	74ab      	strb	r3, [r5, #18]
2002677c:	69a3      	ldr	r3, [r4, #24]
2002677e:	74eb      	strb	r3, [r5, #19]
20026780:	7fe3      	ldrb	r3, [r4, #31]
20026782:	752b      	strb	r3, [r5, #20]
20026784:	8be3      	ldrh	r3, [r4, #30]
20026786:	756b      	strb	r3, [r5, #21]
20026788:	69e3      	ldr	r3, [r4, #28]
2002678a:	0a1b      	lsrs	r3, r3, #8
2002678c:	75ab      	strb	r3, [r5, #22]
2002678e:	69e3      	ldr	r3, [r4, #28]
20026790:	75eb      	strb	r3, [r5, #23]
20026792:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
20026796:	762b      	strb	r3, [r5, #24]
20026798:	8c63      	ldrh	r3, [r4, #34]	@ 0x22
2002679a:	766b      	strb	r3, [r5, #25]
2002679c:	6a23      	ldr	r3, [r4, #32]
2002679e:	0a1b      	lsrs	r3, r3, #8
200267a0:	76ab      	strb	r3, [r5, #26]
200267a2:	6a23      	ldr	r3, [r4, #32]
200267a4:	76eb      	strb	r3, [r5, #27]
200267a6:	6ea3      	ldr	r3, [r4, #104]	@ 0x68
200267a8:	b94b      	cbnz	r3, 200267be <mbedtls_sha256_finish+0xd2>
200267aa:	f894 3027 	ldrb.w	r3, [r4, #39]	@ 0x27
200267ae:	772b      	strb	r3, [r5, #28]
200267b0:	8ce3      	ldrh	r3, [r4, #38]	@ 0x26
200267b2:	776b      	strb	r3, [r5, #29]
200267b4:	6a63      	ldr	r3, [r4, #36]	@ 0x24
200267b6:	0a1b      	lsrs	r3, r3, #8
200267b8:	77ab      	strb	r3, [r5, #30]
200267ba:	6a63      	ldr	r3, [r4, #36]	@ 0x24
200267bc:	77eb      	strb	r3, [r5, #31]
200267be:	b003      	add	sp, #12
200267c0:	bd30      	pop	{r4, r5, pc}
200267c2:	bf00      	nop
200267c4:	2002bd9c 	.word	0x2002bd9c

200267c8 <mbedtls_sha256>:
200267c8:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
200267cc:	461d      	mov	r5, r3
200267ce:	b09c      	sub	sp, #112	@ 0x70
200267d0:	4607      	mov	r7, r0
200267d2:	a801      	add	r0, sp, #4
200267d4:	4688      	mov	r8, r1
200267d6:	4616      	mov	r6, r2
200267d8:	f7ff fb97 	bl	20025f0a <mbedtls_sha256_init>
200267dc:	b355      	cbz	r5, 20026834 <mbedtls_sha256+0x6c>
200267de:	f8df a090 	ldr.w	sl, [pc, #144]	@ 20026870 <mbedtls_sha256+0xa8>
200267e2:	f8df 9090 	ldr.w	r9, [pc, #144]	@ 20026874 <mbedtls_sha256+0xac>
200267e6:	f8df e090 	ldr.w	lr, [pc, #144]	@ 20026878 <mbedtls_sha256+0xb0>
200267ea:	f8df c090 	ldr.w	ip, [pc, #144]	@ 2002687c <mbedtls_sha256+0xb4>
200267ee:	4818      	ldr	r0, [pc, #96]	@ (20026850 <mbedtls_sha256+0x88>)
200267f0:	4918      	ldr	r1, [pc, #96]	@ (20026854 <mbedtls_sha256+0x8c>)
200267f2:	4a19      	ldr	r2, [pc, #100]	@ (20026858 <mbedtls_sha256+0x90>)
200267f4:	4b19      	ldr	r3, [pc, #100]	@ (2002685c <mbedtls_sha256+0x94>)
200267f6:	2400      	movs	r4, #0
200267f8:	e9cd 2309 	strd	r2, r3, [sp, #36]	@ 0x24
200267fc:	e9cd 0107 	strd	r0, r1, [sp, #28]
20026800:	4642      	mov	r2, r8
20026802:	4639      	mov	r1, r7
20026804:	a801      	add	r0, sp, #4
20026806:	e9cd ec05 	strd	lr, ip, [sp, #20]
2002680a:	e9cd 4401 	strd	r4, r4, [sp, #4]
2002680e:	e9cd a903 	strd	sl, r9, [sp, #12]
20026812:	951b      	str	r5, [sp, #108]	@ 0x6c
20026814:	f7ff ff66 	bl	200266e4 <mbedtls_sha256_update>
20026818:	4631      	mov	r1, r6
2002681a:	a801      	add	r0, sp, #4
2002681c:	f7ff ff66 	bl	200266ec <mbedtls_sha256_finish>
20026820:	4623      	mov	r3, r4
20026822:	4622      	mov	r2, r4
20026824:	a901      	add	r1, sp, #4
20026826:	54ca      	strb	r2, [r1, r3]
20026828:	3301      	adds	r3, #1
2002682a:	2b6c      	cmp	r3, #108	@ 0x6c
2002682c:	d1fa      	bne.n	20026824 <mbedtls_sha256+0x5c>
2002682e:	b01c      	add	sp, #112	@ 0x70
20026830:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
20026834:	f8df a048 	ldr.w	sl, [pc, #72]	@ 20026880 <mbedtls_sha256+0xb8>
20026838:	f8df 9048 	ldr.w	r9, [pc, #72]	@ 20026884 <mbedtls_sha256+0xbc>
2002683c:	f8df e048 	ldr.w	lr, [pc, #72]	@ 20026888 <mbedtls_sha256+0xc0>
20026840:	f8df c048 	ldr.w	ip, [pc, #72]	@ 2002688c <mbedtls_sha256+0xc4>
20026844:	4806      	ldr	r0, [pc, #24]	@ (20026860 <mbedtls_sha256+0x98>)
20026846:	4907      	ldr	r1, [pc, #28]	@ (20026864 <mbedtls_sha256+0x9c>)
20026848:	4a07      	ldr	r2, [pc, #28]	@ (20026868 <mbedtls_sha256+0xa0>)
2002684a:	4b08      	ldr	r3, [pc, #32]	@ (2002686c <mbedtls_sha256+0xa4>)
2002684c:	e7d3      	b.n	200267f6 <mbedtls_sha256+0x2e>
2002684e:	bf00      	nop
20026850:	ffc00b31 	.word	0xffc00b31
20026854:	68581511 	.word	0x68581511
20026858:	64f98fa7 	.word	0x64f98fa7
2002685c:	befa4fa4 	.word	0xbefa4fa4
20026860:	510e527f 	.word	0x510e527f
20026864:	9b05688c 	.word	0x9b05688c
20026868:	1f83d9ab 	.word	0x1f83d9ab
2002686c:	5be0cd19 	.word	0x5be0cd19
20026870:	c1059ed8 	.word	0xc1059ed8
20026874:	367cd507 	.word	0x367cd507
20026878:	3070dd17 	.word	0x3070dd17
2002687c:	f70e5939 	.word	0xf70e5939
20026880:	6a09e667 	.word	0x6a09e667
20026884:	bb67ae85 	.word	0xbb67ae85
20026888:	3c6ef372 	.word	0x3c6ef372
2002688c:	a54ff53a 	.word	0xa54ff53a

20026890 <mbedtls_sha512_init>:
20026890:	22d8      	movs	r2, #216	@ 0xd8
20026892:	2100      	movs	r1, #0
20026894:	f003 bfde 	b.w	2002a854 <memset>

20026898 <mbedtls_sha512_free>:
20026898:	b138      	cbz	r0, 200268aa <mbedtls_sha512_free+0x12>
2002689a:	2100      	movs	r1, #0
2002689c:	f100 03d8 	add.w	r3, r0, #216	@ 0xd8
200268a0:	4602      	mov	r2, r0
200268a2:	3001      	adds	r0, #1
200268a4:	4298      	cmp	r0, r3
200268a6:	7011      	strb	r1, [r2, #0]
200268a8:	d1fa      	bne.n	200268a0 <mbedtls_sha512_free+0x8>
200268aa:	4770      	bx	lr

200268ac <mbedtls_sha512_clone>:
200268ac:	b508      	push	{r3, lr}
200268ae:	22d8      	movs	r2, #216	@ 0xd8
200268b0:	f003 ffea 	bl	2002a888 <memcpy>
200268b4:	bd08      	pop	{r3, pc}
	...

200268b8 <mbedtls_sha512_starts>:
200268b8:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200268bc:	b381      	cbz	r1, 20026920 <mbedtls_sha512_starts+0x68>
200268be:	f20f 0bc8 	addw	fp, pc, #200	@ 0xc8
200268c2:	e9db ab00 	ldrd	sl, fp, [fp]
200268c6:	f20f 09c8 	addw	r9, pc, #200	@ 0xc8
200268ca:	e9d9 8900 	ldrd	r8, r9, [r9]
200268ce:	a732      	add	r7, pc, #200	@ (adr r7, 20026998 <mbedtls_sha512_starts+0xe0>)
200268d0:	e9d7 6700 	ldrd	r6, r7, [r7]
200268d4:	a532      	add	r5, pc, #200	@ (adr r5, 200269a0 <mbedtls_sha512_starts+0xe8>)
200268d6:	e9d5 4500 	ldrd	r4, r5, [r5]
200268da:	a333      	add	r3, pc, #204	@ (adr r3, 200269a8 <mbedtls_sha512_starts+0xf0>)
200268dc:	e9d3 2300 	ldrd	r2, r3, [r3]
200268e0:	ed9f 5b1b 	vldr	d5, [pc, #108]	@ 20026950 <mbedtls_sha512_starts+0x98>
200268e4:	ed9f 6b1c 	vldr	d6, [pc, #112]	@ 20026958 <mbedtls_sha512_starts+0xa0>
200268e8:	ed9f 7b1d 	vldr	d7, [pc, #116]	@ 20026960 <mbedtls_sha512_starts+0xa8>
200268ec:	ed9f 4b1e 	vldr	d4, [pc, #120]	@ 20026968 <mbedtls_sha512_starts+0xb0>
200268f0:	ed80 5b04 	vstr	d5, [r0, #16]
200268f4:	ed80 4b00 	vstr	d4, [r0]
200268f8:	ed80 4b02 	vstr	d4, [r0, #8]
200268fc:	ed80 6b06 	vstr	d6, [r0, #24]
20026900:	ed80 7b08 	vstr	d7, [r0, #32]
20026904:	e9c0 ab0a 	strd	sl, fp, [r0, #40]	@ 0x28
20026908:	e9c0 890c 	strd	r8, r9, [r0, #48]	@ 0x30
2002690c:	e9c0 670e 	strd	r6, r7, [r0, #56]	@ 0x38
20026910:	e9c0 4510 	strd	r4, r5, [r0, #64]	@ 0x40
20026914:	e9c0 2312 	strd	r2, r3, [r0, #72]	@ 0x48
20026918:	f8c0 10d0 	str.w	r1, [r0, #208]	@ 0xd0
2002691c:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20026920:	ed9f 5b13 	vldr	d5, [pc, #76]	@ 20026970 <mbedtls_sha512_starts+0xb8>
20026924:	f20f 0b88 	addw	fp, pc, #136	@ 0x88
20026928:	e9db ab00 	ldrd	sl, fp, [fp]
2002692c:	f20f 0988 	addw	r9, pc, #136	@ 0x88
20026930:	e9d9 8900 	ldrd	r8, r9, [r9]
20026934:	a722      	add	r7, pc, #136	@ (adr r7, 200269c0 <mbedtls_sha512_starts+0x108>)
20026936:	e9d7 6700 	ldrd	r6, r7, [r7]
2002693a:	a523      	add	r5, pc, #140	@ (adr r5, 200269c8 <mbedtls_sha512_starts+0x110>)
2002693c:	e9d5 4500 	ldrd	r4, r5, [r5]
20026940:	a323      	add	r3, pc, #140	@ (adr r3, 200269d0 <mbedtls_sha512_starts+0x118>)
20026942:	e9d3 2300 	ldrd	r2, r3, [r3]
20026946:	ed9f 6b0c 	vldr	d6, [pc, #48]	@ 20026978 <mbedtls_sha512_starts+0xc0>
2002694a:	ed9f 7b0d 	vldr	d7, [pc, #52]	@ 20026980 <mbedtls_sha512_starts+0xc8>
2002694e:	e7cd      	b.n	200268ec <mbedtls_sha512_starts+0x34>
20026950:	c1059ed8 	.word	0xc1059ed8
20026954:	cbbb9d5d 	.word	0xcbbb9d5d
20026958:	367cd507 	.word	0x367cd507
2002695c:	629a292a 	.word	0x629a292a
20026960:	3070dd17 	.word	0x3070dd17
20026964:	9159015a 	.word	0x9159015a
	...
20026970:	f3bcc908 	.word	0xf3bcc908
20026974:	6a09e667 	.word	0x6a09e667
20026978:	84caa73b 	.word	0x84caa73b
2002697c:	bb67ae85 	.word	0xbb67ae85
20026980:	fe94f82b 	.word	0xfe94f82b
20026984:	3c6ef372 	.word	0x3c6ef372
20026988:	f70e5939 	.word	0xf70e5939
2002698c:	152fecd8 	.word	0x152fecd8
20026990:	ffc00b31 	.word	0xffc00b31
20026994:	67332667 	.word	0x67332667
20026998:	68581511 	.word	0x68581511
2002699c:	8eb44a87 	.word	0x8eb44a87
200269a0:	64f98fa7 	.word	0x64f98fa7
200269a4:	db0c2e0d 	.word	0xdb0c2e0d
200269a8:	befa4fa4 	.word	0xbefa4fa4
200269ac:	47b5481d 	.word	0x47b5481d
200269b0:	5f1d36f1 	.word	0x5f1d36f1
200269b4:	a54ff53a 	.word	0xa54ff53a
200269b8:	ade682d1 	.word	0xade682d1
200269bc:	510e527f 	.word	0x510e527f
200269c0:	2b3e6c1f 	.word	0x2b3e6c1f
200269c4:	9b05688c 	.word	0x9b05688c
200269c8:	fb41bd6b 	.word	0xfb41bd6b
200269cc:	1f83d9ab 	.word	0x1f83d9ab
200269d0:	137e2179 	.word	0x137e2179
200269d4:	5be0cd19 	.word	0x5be0cd19

200269d8 <mbedtls_sha512_process>:
200269d8:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200269dc:	f5ad 7d3f 	sub.w	sp, sp, #764	@ 0x2fc
200269e0:	4682      	mov	sl, r0
200269e2:	a81e      	add	r0, sp, #120	@ 0x78
200269e4:	4604      	mov	r4, r0
200269e6:	f101 0580 	add.w	r5, r1, #128	@ 0x80
200269ea:	784b      	ldrb	r3, [r1, #1]
200269ec:	780a      	ldrb	r2, [r1, #0]
200269ee:	041b      	lsls	r3, r3, #16
200269f0:	790f      	ldrb	r7, [r1, #4]
200269f2:	ea43 6302 	orr.w	r3, r3, r2, lsl #24
200269f6:	79ca      	ldrb	r2, [r1, #7]
200269f8:	788e      	ldrb	r6, [r1, #2]
200269fa:	ea42 6207 	orr.w	r2, r2, r7, lsl #24
200269fe:	794f      	ldrb	r7, [r1, #5]
20026a00:	ea43 2306 	orr.w	r3, r3, r6, lsl #8
20026a04:	ea42 4207 	orr.w	r2, r2, r7, lsl #16
20026a08:	78ce      	ldrb	r6, [r1, #3]
20026a0a:	798f      	ldrb	r7, [r1, #6]
20026a0c:	3108      	adds	r1, #8
20026a0e:	ea42 2207 	orr.w	r2, r2, r7, lsl #8
20026a12:	4333      	orrs	r3, r6
20026a14:	428d      	cmp	r5, r1
20026a16:	e9c4 2300 	strd	r2, r3, [r4]
20026a1a:	f104 0408 	add.w	r4, r4, #8
20026a1e:	d1e4      	bne.n	200269ea <mbedtls_sha512_process+0x12>
20026a20:	4601      	mov	r1, r0
20026a22:	2610      	movs	r6, #16
20026a24:	e9d1 4c1c 	ldrd	r4, ip, [r1, #112]	@ 0x70
20026a28:	e9d1 2502 	ldrd	r2, r5, [r1, #8]
20026a2c:	468e      	mov	lr, r1
20026a2e:	0ce3      	lsrs	r3, r4, #19
20026a30:	ea4f 47dc 	mov.w	r7, ip, lsr #19
20026a34:	ea4f 09c4 	mov.w	r9, r4, lsl #3
20026a38:	ea4f 08cc 	mov.w	r8, ip, lsl #3
20026a3c:	ea48 7854 	orr.w	r8, r8, r4, lsr #29
20026a40:	ea43 334c 	orr.w	r3, r3, ip, lsl #13
20026a44:	ea47 3744 	orr.w	r7, r7, r4, lsl #13
20026a48:	ea49 795c 	orr.w	r9, r9, ip, lsr #29
20026a4c:	09a4      	lsrs	r4, r4, #6
20026a4e:	ea87 0708 	eor.w	r7, r7, r8
20026a52:	ea44 648c 	orr.w	r4, r4, ip, lsl #26
20026a56:	ea83 0309 	eor.w	r3, r3, r9
20026a5a:	4063      	eors	r3, r4
20026a5c:	ea87 179c 	eor.w	r7, r7, ip, lsr #6
20026a60:	e9de 4c12 	ldrd	r4, ip, [lr, #72]	@ 0x48
20026a64:	e9de 8e00 	ldrd	r8, lr, [lr]
20026a68:	eb14 0408 	adds.w	r4, r4, r8
20026a6c:	eb4c 0c0e 	adc.w	ip, ip, lr
20026a70:	191b      	adds	r3, r3, r4
20026a72:	eb47 070c 	adc.w	r7, r7, ip
20026a76:	0854      	lsrs	r4, r2, #1
20026a78:	ea4f 2812 	mov.w	r8, r2, lsr #8
20026a7c:	ea4f 0c55 	mov.w	ip, r5, lsr #1
20026a80:	ea4f 2e15 	mov.w	lr, r5, lsr #8
20026a84:	ea4c 7cc2 	orr.w	ip, ip, r2, lsl #31
20026a88:	ea4e 6e02 	orr.w	lr, lr, r2, lsl #24
20026a8c:	ea44 74c5 	orr.w	r4, r4, r5, lsl #31
20026a90:	ea48 6805 	orr.w	r8, r8, r5, lsl #24
20026a94:	09d2      	lsrs	r2, r2, #7
20026a96:	ea84 0408 	eor.w	r4, r4, r8
20026a9a:	ea42 6245 	orr.w	r2, r2, r5, lsl #25
20026a9e:	4062      	eors	r2, r4
20026aa0:	ea8c 0c0e 	eor.w	ip, ip, lr
20026aa4:	189b      	adds	r3, r3, r2
20026aa6:	ea8c 14d5 	eor.w	r4, ip, r5, lsr #7
20026aaa:	f106 0601 	add.w	r6, r6, #1
20026aae:	eb47 0704 	adc.w	r7, r7, r4
20026ab2:	3108      	adds	r1, #8
20026ab4:	2e50      	cmp	r6, #80	@ 0x50
20026ab6:	e9c1 371e 	strd	r3, r7, [r1, #120]	@ 0x78
20026aba:	d1b3      	bne.n	20026a24 <mbedtls_sha512_process+0x4c>
20026abc:	f8da 3010 	ldr.w	r3, [sl, #16]
20026ac0:	930e      	str	r3, [sp, #56]	@ 0x38
20026ac2:	f8da 3014 	ldr.w	r3, [sl, #20]
20026ac6:	930f      	str	r3, [sp, #60]	@ 0x3c
20026ac8:	f8da 3018 	ldr.w	r3, [sl, #24]
20026acc:	9310      	str	r3, [sp, #64]	@ 0x40
20026ace:	f8da 301c 	ldr.w	r3, [sl, #28]
20026ad2:	9311      	str	r3, [sp, #68]	@ 0x44
20026ad4:	f8da 3020 	ldr.w	r3, [sl, #32]
20026ad8:	9312      	str	r3, [sp, #72]	@ 0x48
20026ada:	f8da 3024 	ldr.w	r3, [sl, #36]	@ 0x24
20026ade:	9313      	str	r3, [sp, #76]	@ 0x4c
20026ae0:	f8da 3028 	ldr.w	r3, [sl, #40]	@ 0x28
20026ae4:	9314      	str	r3, [sp, #80]	@ 0x50
20026ae6:	f8da 302c 	ldr.w	r3, [sl, #44]	@ 0x2c
20026aea:	9315      	str	r3, [sp, #84]	@ 0x54
20026aec:	f8da 3030 	ldr.w	r3, [sl, #48]	@ 0x30
20026af0:	9316      	str	r3, [sp, #88]	@ 0x58
20026af2:	f8da 3034 	ldr.w	r3, [sl, #52]	@ 0x34
20026af6:	9317      	str	r3, [sp, #92]	@ 0x5c
20026af8:	f8da 3038 	ldr.w	r3, [sl, #56]	@ 0x38
20026afc:	9318      	str	r3, [sp, #96]	@ 0x60
20026afe:	f8da 303c 	ldr.w	r3, [sl, #60]	@ 0x3c
20026b02:	9319      	str	r3, [sp, #100]	@ 0x64
20026b04:	f8da 3040 	ldr.w	r3, [sl, #64]	@ 0x40
20026b08:	931a      	str	r3, [sp, #104]	@ 0x68
20026b0a:	f8da 3044 	ldr.w	r3, [sl, #68]	@ 0x44
20026b0e:	931b      	str	r3, [sp, #108]	@ 0x6c
20026b10:	f8da 3048 	ldr.w	r3, [sl, #72]	@ 0x48
20026b14:	931c      	str	r3, [sp, #112]	@ 0x70
20026b16:	f8da 304c 	ldr.w	r3, [sl, #76]	@ 0x4c
20026b1a:	931d      	str	r3, [sp, #116]	@ 0x74
20026b1c:	4b0f      	ldr	r3, [pc, #60]	@ (20026b5c <mbedtls_sha512_process+0x184>)
20026b1e:	9300      	str	r3, [sp, #0]
20026b20:	9b1c      	ldr	r3, [sp, #112]	@ 0x70
20026b22:	f8dd b054 	ldr.w	fp, [sp, #84]	@ 0x54
20026b26:	930a      	str	r3, [sp, #40]	@ 0x28
20026b28:	9b1d      	ldr	r3, [sp, #116]	@ 0x74
20026b2a:	e9dd ce10 	ldrd	ip, lr, [sp, #64]	@ 0x40
20026b2e:	930b      	str	r3, [sp, #44]	@ 0x2c
20026b30:	9b1a      	ldr	r3, [sp, #104]	@ 0x68
20026b32:	9308      	str	r3, [sp, #32]
20026b34:	9b1b      	ldr	r3, [sp, #108]	@ 0x6c
20026b36:	9309      	str	r3, [sp, #36]	@ 0x24
20026b38:	9b18      	ldr	r3, [sp, #96]	@ 0x60
20026b3a:	9306      	str	r3, [sp, #24]
20026b3c:	9b19      	ldr	r3, [sp, #100]	@ 0x64
20026b3e:	9307      	str	r3, [sp, #28]
20026b40:	9b16      	ldr	r3, [sp, #88]	@ 0x58
20026b42:	9304      	str	r3, [sp, #16]
20026b44:	9b17      	ldr	r3, [sp, #92]	@ 0x5c
20026b46:	9305      	str	r3, [sp, #20]
20026b48:	9b14      	ldr	r3, [sp, #80]	@ 0x50
20026b4a:	9303      	str	r3, [sp, #12]
20026b4c:	9b12      	ldr	r3, [sp, #72]	@ 0x48
20026b4e:	9301      	str	r3, [sp, #4]
20026b50:	9b13      	ldr	r3, [sp, #76]	@ 0x4c
20026b52:	9302      	str	r3, [sp, #8]
20026b54:	e9dd 320e 	ldrd	r3, r2, [sp, #56]	@ 0x38
20026b58:	e002      	b.n	20026b60 <mbedtls_sha512_process+0x188>
20026b5a:	bf00      	nop
20026b5c:	2002bf60 	.word	0x2002bf60
20026b60:	9c04      	ldr	r4, [sp, #16]
20026b62:	9e04      	ldr	r6, [sp, #16]
20026b64:	ea4f 3894 	mov.w	r8, r4, lsr #14
20026b68:	9c05      	ldr	r4, [sp, #20]
20026b6a:	9900      	ldr	r1, [sp, #0]
20026b6c:	ea48 4884 	orr.w	r8, r8, r4, lsl #18
20026b70:	ea4f 3994 	mov.w	r9, r4, lsr #14
20026b74:	9c04      	ldr	r4, [sp, #16]
20026b76:	ea49 4984 	orr.w	r9, r9, r4, lsl #18
20026b7a:	0ca5      	lsrs	r5, r4, #18
20026b7c:	9c05      	ldr	r4, [sp, #20]
20026b7e:	ea45 3584 	orr.w	r5, r5, r4, lsl #14
20026b82:	0ca4      	lsrs	r4, r4, #18
20026b84:	ea44 3486 	orr.w	r4, r4, r6, lsl #14
20026b88:	ea89 0904 	eor.w	r9, r9, r4
20026b8c:	9c05      	ldr	r4, [sp, #20]
20026b8e:	ea88 0805 	eor.w	r8, r8, r5
20026b92:	05f5      	lsls	r5, r6, #23
20026b94:	ea45 2554 	orr.w	r5, r5, r4, lsr #9
20026b98:	05e4      	lsls	r4, r4, #23
20026b9a:	ea44 2456 	orr.w	r4, r4, r6, lsr #9
20026b9e:	ea88 0805 	eor.w	r8, r8, r5
20026ba2:	ea89 0904 	eor.w	r9, r9, r4
20026ba6:	e9d1 5700 	ldrd	r5, r7, [r1]
20026baa:	e9d0 6400 	ldrd	r6, r4, [r0]
20026bae:	19ad      	adds	r5, r5, r6
20026bb0:	eb47 0404 	adc.w	r4, r7, r4
20026bb4:	9e06      	ldr	r6, [sp, #24]
20026bb6:	9f08      	ldr	r7, [sp, #32]
20026bb8:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026bba:	407e      	eors	r6, r7
20026bbc:	9f07      	ldr	r7, [sp, #28]
20026bbe:	eb18 0505 	adds.w	r5, r8, r5
20026bc2:	ea87 0701 	eor.w	r7, r7, r1
20026bc6:	9904      	ldr	r1, [sp, #16]
20026bc8:	eb49 0404 	adc.w	r4, r9, r4
20026bcc:	400e      	ands	r6, r1
20026bce:	9905      	ldr	r1, [sp, #20]
20026bd0:	ea4f 7813 	mov.w	r8, r3, lsr #28
20026bd4:	400f      	ands	r7, r1
20026bd6:	9908      	ldr	r1, [sp, #32]
20026bd8:	ea4f 7983 	mov.w	r9, r3, lsl #30
20026bdc:	404e      	eors	r6, r1
20026bde:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026be0:	19ad      	adds	r5, r5, r6
20026be2:	ea87 0701 	eor.w	r7, r7, r1
20026be6:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026be8:	eb44 0407 	adc.w	r4, r4, r7
20026bec:	186d      	adds	r5, r5, r1
20026bee:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026bf0:	ea4f 7712 	mov.w	r7, r2, lsr #28
20026bf4:	eb41 0404 	adc.w	r4, r1, r4
20026bf8:	9903      	ldr	r1, [sp, #12]
20026bfa:	0796      	lsls	r6, r2, #30
20026bfc:	1949      	adds	r1, r1, r5
20026bfe:	ea46 0693 	orr.w	r6, r6, r3, lsr #2
20026c02:	ea47 1703 	orr.w	r7, r7, r3, lsl #4
20026c06:	910a      	str	r1, [sp, #40]	@ 0x28
20026c08:	ea87 0706 	eor.w	r7, r7, r6
20026c0c:	eb4b 0104 	adc.w	r1, fp, r4
20026c10:	0656      	lsls	r6, r2, #25
20026c12:	ea49 0992 	orr.w	r9, r9, r2, lsr #2
20026c16:	ea46 16d3 	orr.w	r6, r6, r3, lsr #7
20026c1a:	910b      	str	r1, [sp, #44]	@ 0x2c
20026c1c:	ea48 1802 	orr.w	r8, r8, r2, lsl #4
20026c20:	9901      	ldr	r1, [sp, #4]
20026c22:	ea88 0809 	eor.w	r8, r8, r9
20026c26:	4077      	eors	r7, r6
20026c28:	ea4f 6943 	mov.w	r9, r3, lsl #25
20026c2c:	ea43 060c 	orr.w	r6, r3, ip
20026c30:	ea49 19d2 	orr.w	r9, r9, r2, lsr #7
20026c34:	400e      	ands	r6, r1
20026c36:	9902      	ldr	r1, [sp, #8]
20026c38:	ea03 0b0c 	and.w	fp, r3, ip
20026c3c:	ea88 0809 	eor.w	r8, r8, r9
20026c40:	ea42 090e 	orr.w	r9, r2, lr
20026c44:	ea09 0901 	and.w	r9, r9, r1
20026c48:	ea46 060b 	orr.w	r6, r6, fp
20026c4c:	ea02 010e 	and.w	r1, r2, lr
20026c50:	eb18 0606 	adds.w	r6, r8, r6
20026c54:	ea49 0901 	orr.w	r9, r9, r1
20026c58:	eb47 0709 	adc.w	r7, r7, r9
20026c5c:	1971      	adds	r1, r6, r5
20026c5e:	9103      	str	r1, [sp, #12]
20026c60:	9900      	ldr	r1, [sp, #0]
20026c62:	eb44 0b07 	adc.w	fp, r4, r7
20026c66:	e9d0 6702 	ldrd	r6, r7, [r0, #8]
20026c6a:	e9d1 4502 	ldrd	r4, r5, [r1, #8]
20026c6e:	9908      	ldr	r1, [sp, #32]
20026c70:	19a4      	adds	r4, r4, r6
20026c72:	eb45 0507 	adc.w	r5, r5, r7
20026c76:	1864      	adds	r4, r4, r1
20026c78:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026c7a:	9e06      	ldr	r6, [sp, #24]
20026c7c:	eb41 0505 	adc.w	r5, r1, r5
20026c80:	9904      	ldr	r1, [sp, #16]
20026c82:	ea81 0706 	eor.w	r7, r1, r6
20026c86:	9905      	ldr	r1, [sp, #20]
20026c88:	9e07      	ldr	r6, [sp, #28]
20026c8a:	404e      	eors	r6, r1
20026c8c:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026c8e:	400f      	ands	r7, r1
20026c90:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026c92:	400e      	ands	r6, r1
20026c94:	9906      	ldr	r1, [sp, #24]
20026c96:	404f      	eors	r7, r1
20026c98:	9907      	ldr	r1, [sp, #28]
20026c9a:	19e4      	adds	r4, r4, r7
20026c9c:	ea86 0601 	eor.w	r6, r6, r1
20026ca0:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026ca2:	eb45 0506 	adc.w	r5, r5, r6
20026ca6:	0b8f      	lsrs	r7, r1, #14
20026ca8:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026caa:	ea47 4781 	orr.w	r7, r7, r1, lsl #18
20026cae:	ea4f 3891 	mov.w	r8, r1, lsr #14
20026cb2:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026cb4:	ea48 4881 	orr.w	r8, r8, r1, lsl #18
20026cb8:	ea4f 4991 	mov.w	r9, r1, lsr #18
20026cbc:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026cbe:	ea49 3981 	orr.w	r9, r9, r1, lsl #14
20026cc2:	0c8e      	lsrs	r6, r1, #18
20026cc4:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026cc6:	ea87 0709 	eor.w	r7, r7, r9
20026cca:	ea46 3681 	orr.w	r6, r6, r1, lsl #14
20026cce:	ea88 0806 	eor.w	r8, r8, r6
20026cd2:	05ce      	lsls	r6, r1, #23
20026cd4:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026cd6:	ea46 2651 	orr.w	r6, r6, r1, lsr #9
20026cda:	ea4f 59c1 	mov.w	r9, r1, lsl #23
20026cde:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026ce0:	407e      	eors	r6, r7
20026ce2:	ea49 2951 	orr.w	r9, r9, r1, lsr #9
20026ce6:	9901      	ldr	r1, [sp, #4]
20026ce8:	19a4      	adds	r4, r4, r6
20026cea:	ea88 0809 	eor.w	r8, r8, r9
20026cee:	eb45 0808 	adc.w	r8, r5, r8
20026cf2:	1909      	adds	r1, r1, r4
20026cf4:	9108      	str	r1, [sp, #32]
20026cf6:	9902      	ldr	r1, [sp, #8]
20026cf8:	ea4f 761b 	mov.w	r6, fp, lsr #28
20026cfc:	eb41 0108 	adc.w	r1, r1, r8
20026d00:	9109      	str	r1, [sp, #36]	@ 0x24
20026d02:	9903      	ldr	r1, [sp, #12]
20026d04:	ea4f 758b 	mov.w	r5, fp, lsl #30
20026d08:	ea45 0591 	orr.w	r5, r5, r1, lsr #2
20026d0c:	0f0f      	lsrs	r7, r1, #28
20026d0e:	ea46 1601 	orr.w	r6, r6, r1, lsl #4
20026d12:	ea4f 7981 	mov.w	r9, r1, lsl #30
20026d16:	ea49 099b 	orr.w	r9, r9, fp, lsr #2
20026d1a:	ea47 170b 	orr.w	r7, r7, fp, lsl #4
20026d1e:	406e      	eors	r6, r5
20026d20:	ea4f 654b 	mov.w	r5, fp, lsl #25
20026d24:	ea45 15d1 	orr.w	r5, r5, r1, lsr #7
20026d28:	ea87 0709 	eor.w	r7, r7, r9
20026d2c:	ea4f 6941 	mov.w	r9, r1, lsl #25
20026d30:	ea49 19db 	orr.w	r9, r9, fp, lsr #7
20026d34:	406e      	eors	r6, r5
20026d36:	ea43 0501 	orr.w	r5, r3, r1
20026d3a:	ea87 0709 	eor.w	r7, r7, r9
20026d3e:	4019      	ands	r1, r3
20026d40:	ea42 090b 	orr.w	r9, r2, fp
20026d44:	ea05 050c 	and.w	r5, r5, ip
20026d48:	ea09 090e 	and.w	r9, r9, lr
20026d4c:	430d      	orrs	r5, r1
20026d4e:	ea02 010b 	and.w	r1, r2, fp
20026d52:	197d      	adds	r5, r7, r5
20026d54:	ea49 0901 	orr.w	r9, r9, r1
20026d58:	eb46 0609 	adc.w	r6, r6, r9
20026d5c:	1929      	adds	r1, r5, r4
20026d5e:	9101      	str	r1, [sp, #4]
20026d60:	eb48 0106 	adc.w	r1, r8, r6
20026d64:	9102      	str	r1, [sp, #8]
20026d66:	9900      	ldr	r1, [sp, #0]
20026d68:	e9d0 6704 	ldrd	r6, r7, [r0, #16]
20026d6c:	e9d1 4504 	ldrd	r4, r5, [r1, #16]
20026d70:	9906      	ldr	r1, [sp, #24]
20026d72:	19a4      	adds	r4, r4, r6
20026d74:	eb45 0507 	adc.w	r5, r5, r7
20026d78:	1864      	adds	r4, r4, r1
20026d7a:	9907      	ldr	r1, [sp, #28]
20026d7c:	eb41 0505 	adc.w	r5, r1, r5
20026d80:	9904      	ldr	r1, [sp, #16]
20026d82:	9e0a      	ldr	r6, [sp, #40]	@ 0x28
20026d84:	ea81 0706 	eor.w	r7, r1, r6
20026d88:	9905      	ldr	r1, [sp, #20]
20026d8a:	9e0b      	ldr	r6, [sp, #44]	@ 0x2c
20026d8c:	404e      	eors	r6, r1
20026d8e:	9908      	ldr	r1, [sp, #32]
20026d90:	400f      	ands	r7, r1
20026d92:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026d94:	400e      	ands	r6, r1
20026d96:	9904      	ldr	r1, [sp, #16]
20026d98:	404f      	eors	r7, r1
20026d9a:	9905      	ldr	r1, [sp, #20]
20026d9c:	19e4      	adds	r4, r4, r7
20026d9e:	ea86 0601 	eor.w	r6, r6, r1
20026da2:	9908      	ldr	r1, [sp, #32]
20026da4:	eb45 0506 	adc.w	r5, r5, r6
20026da8:	0b8f      	lsrs	r7, r1, #14
20026daa:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026dac:	ea47 4781 	orr.w	r7, r7, r1, lsl #18
20026db0:	ea4f 3891 	mov.w	r8, r1, lsr #14
20026db4:	9908      	ldr	r1, [sp, #32]
20026db6:	ea48 4881 	orr.w	r8, r8, r1, lsl #18
20026dba:	ea4f 4991 	mov.w	r9, r1, lsr #18
20026dbe:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026dc0:	ea49 3981 	orr.w	r9, r9, r1, lsl #14
20026dc4:	0c8e      	lsrs	r6, r1, #18
20026dc6:	9908      	ldr	r1, [sp, #32]
20026dc8:	ea87 0709 	eor.w	r7, r7, r9
20026dcc:	ea46 3681 	orr.w	r6, r6, r1, lsl #14
20026dd0:	ea88 0806 	eor.w	r8, r8, r6
20026dd4:	05ce      	lsls	r6, r1, #23
20026dd6:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026dd8:	ea46 2651 	orr.w	r6, r6, r1, lsr #9
20026ddc:	ea4f 59c1 	mov.w	r9, r1, lsl #23
20026de0:	9908      	ldr	r1, [sp, #32]
20026de2:	407e      	eors	r6, r7
20026de4:	ea49 2951 	orr.w	r9, r9, r1, lsr #9
20026de8:	19a4      	adds	r4, r4, r6
20026dea:	ea88 0809 	eor.w	r8, r8, r9
20026dee:	eb45 0808 	adc.w	r8, r5, r8
20026df2:	eb1c 0104 	adds.w	r1, ip, r4
20026df6:	9106      	str	r1, [sp, #24]
20026df8:	eb4e 0108 	adc.w	r1, lr, r8
20026dfc:	9107      	str	r1, [sp, #28]
20026dfe:	9901      	ldr	r1, [sp, #4]
20026e00:	0f0f      	lsrs	r7, r1, #28
20026e02:	9902      	ldr	r1, [sp, #8]
20026e04:	ea47 1701 	orr.w	r7, r7, r1, lsl #4
20026e08:	0f0e      	lsrs	r6, r1, #28
20026e0a:	9901      	ldr	r1, [sp, #4]
20026e0c:	ea46 1601 	orr.w	r6, r6, r1, lsl #4
20026e10:	ea4f 7c81 	mov.w	ip, r1, lsl #30
20026e14:	9902      	ldr	r1, [sp, #8]
20026e16:	ea4c 0c91 	orr.w	ip, ip, r1, lsr #2
20026e1a:	078d      	lsls	r5, r1, #30
20026e1c:	9901      	ldr	r1, [sp, #4]
20026e1e:	ea87 070c 	eor.w	r7, r7, ip
20026e22:	ea45 0591 	orr.w	r5, r5, r1, lsr #2
20026e26:	ea4f 6c41 	mov.w	ip, r1, lsl #25
20026e2a:	9902      	ldr	r1, [sp, #8]
20026e2c:	406e      	eors	r6, r5
20026e2e:	ea4c 1cd1 	orr.w	ip, ip, r1, lsr #7
20026e32:	064d      	lsls	r5, r1, #25
20026e34:	9901      	ldr	r1, [sp, #4]
20026e36:	ea87 070c 	eor.w	r7, r7, ip
20026e3a:	ea45 15d1 	orr.w	r5, r5, r1, lsr #7
20026e3e:	406e      	eors	r6, r5
20026e40:	9903      	ldr	r1, [sp, #12]
20026e42:	9d01      	ldr	r5, [sp, #4]
20026e44:	430d      	orrs	r5, r1
20026e46:	9902      	ldr	r1, [sp, #8]
20026e48:	ea4b 0c01 	orr.w	ip, fp, r1
20026e4c:	ea05 0103 	and.w	r1, r5, r3
20026e50:	910c      	str	r1, [sp, #48]	@ 0x30
20026e52:	9d01      	ldr	r5, [sp, #4]
20026e54:	9903      	ldr	r1, [sp, #12]
20026e56:	ea0c 0c02 	and.w	ip, ip, r2
20026e5a:	ea01 0905 	and.w	r9, r1, r5
20026e5e:	9902      	ldr	r1, [sp, #8]
20026e60:	ea0b 0e01 	and.w	lr, fp, r1
20026e64:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026e66:	ea4c 0c0e 	orr.w	ip, ip, lr
20026e6a:	ea41 0509 	orr.w	r5, r1, r9
20026e6e:	9900      	ldr	r1, [sp, #0]
20026e70:	197d      	adds	r5, r7, r5
20026e72:	eb46 060c 	adc.w	r6, r6, ip
20026e76:	eb15 0904 	adds.w	r9, r5, r4
20026e7a:	e9d1 4506 	ldrd	r4, r5, [r1, #24]
20026e7e:	9904      	ldr	r1, [sp, #16]
20026e80:	eb48 0806 	adc.w	r8, r8, r6
20026e84:	e9d0 6706 	ldrd	r6, r7, [r0, #24]
20026e88:	19a4      	adds	r4, r4, r6
20026e8a:	eb45 0507 	adc.w	r5, r5, r7
20026e8e:	1864      	adds	r4, r4, r1
20026e90:	9905      	ldr	r1, [sp, #20]
20026e92:	9e08      	ldr	r6, [sp, #32]
20026e94:	eb41 0505 	adc.w	r5, r1, r5
20026e98:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026e9a:	ea81 0706 	eor.w	r7, r1, r6
20026e9e:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026ea0:	9e09      	ldr	r6, [sp, #36]	@ 0x24
20026ea2:	404e      	eors	r6, r1
20026ea4:	9906      	ldr	r1, [sp, #24]
20026ea6:	400f      	ands	r7, r1
20026ea8:	9907      	ldr	r1, [sp, #28]
20026eaa:	400e      	ands	r6, r1
20026eac:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026eae:	404f      	eors	r7, r1
20026eb0:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026eb2:	19e4      	adds	r4, r4, r7
20026eb4:	ea86 0601 	eor.w	r6, r6, r1
20026eb8:	9906      	ldr	r1, [sp, #24]
20026eba:	eb45 0506 	adc.w	r5, r5, r6
20026ebe:	ea4f 3c91 	mov.w	ip, r1, lsr #14
20026ec2:	9907      	ldr	r1, [sp, #28]
20026ec4:	ea4c 4c81 	orr.w	ip, ip, r1, lsl #18
20026ec8:	0b8e      	lsrs	r6, r1, #14
20026eca:	9906      	ldr	r1, [sp, #24]
20026ecc:	ea46 4681 	orr.w	r6, r6, r1, lsl #18
20026ed0:	ea4f 4e91 	mov.w	lr, r1, lsr #18
20026ed4:	9907      	ldr	r1, [sp, #28]
20026ed6:	ea4e 3e81 	orr.w	lr, lr, r1, lsl #14
20026eda:	0c8f      	lsrs	r7, r1, #18
20026edc:	9906      	ldr	r1, [sp, #24]
20026ede:	ea8c 0c0e 	eor.w	ip, ip, lr
20026ee2:	ea47 3781 	orr.w	r7, r7, r1, lsl #14
20026ee6:	407e      	eors	r6, r7
20026ee8:	05cf      	lsls	r7, r1, #23
20026eea:	9907      	ldr	r1, [sp, #28]
20026eec:	ea47 2751 	orr.w	r7, r7, r1, lsr #9
20026ef0:	ea4f 5ec1 	mov.w	lr, r1, lsl #23
20026ef4:	9906      	ldr	r1, [sp, #24]
20026ef6:	ea8c 0707 	eor.w	r7, ip, r7
20026efa:	ea4e 2e51 	orr.w	lr, lr, r1, lsr #9
20026efe:	19e4      	adds	r4, r4, r7
20026f00:	ea86 060e 	eor.w	r6, r6, lr
20026f04:	eb45 0606 	adc.w	r6, r5, r6
20026f08:	191b      	adds	r3, r3, r4
20026f0a:	930c      	str	r3, [sp, #48]	@ 0x30
20026f0c:	eb42 0306 	adc.w	r3, r2, r6
20026f10:	930d      	str	r3, [sp, #52]	@ 0x34
20026f12:	ea4f 7218 	mov.w	r2, r8, lsr #28
20026f16:	ea4f 7388 	mov.w	r3, r8, lsl #30
20026f1a:	ea43 0399 	orr.w	r3, r3, r9, lsr #2
20026f1e:	ea4f 7519 	mov.w	r5, r9, lsr #28
20026f22:	ea42 1209 	orr.w	r2, r2, r9, lsl #4
20026f26:	ea4f 7789 	mov.w	r7, r9, lsl #30
20026f2a:	ea47 0798 	orr.w	r7, r7, r8, lsr #2
20026f2e:	ea45 1508 	orr.w	r5, r5, r8, lsl #4
20026f32:	405a      	eors	r2, r3
20026f34:	ea4f 6348 	mov.w	r3, r8, lsl #25
20026f38:	9902      	ldr	r1, [sp, #8]
20026f3a:	ea43 13d9 	orr.w	r3, r3, r9, lsr #7
20026f3e:	407d      	eors	r5, r7
20026f40:	ea4f 6749 	mov.w	r7, r9, lsl #25
20026f44:	ea47 17d8 	orr.w	r7, r7, r8, lsr #7
20026f48:	405a      	eors	r2, r3
20026f4a:	9b01      	ldr	r3, [sp, #4]
20026f4c:	407d      	eors	r5, r7
20026f4e:	ea41 0708 	orr.w	r7, r1, r8
20026f52:	9903      	ldr	r1, [sp, #12]
20026f54:	ea43 0309 	orr.w	r3, r3, r9
20026f58:	400b      	ands	r3, r1
20026f5a:	9901      	ldr	r1, [sp, #4]
20026f5c:	ea07 070b 	and.w	r7, r7, fp
20026f60:	ea01 0e09 	and.w	lr, r1, r9
20026f64:	9902      	ldr	r1, [sp, #8]
20026f66:	ea43 030e 	orr.w	r3, r3, lr
20026f6a:	ea01 0c08 	and.w	ip, r1, r8
20026f6e:	ea47 070c 	orr.w	r7, r7, ip
20026f72:	18eb      	adds	r3, r5, r3
20026f74:	eb42 0207 	adc.w	r2, r2, r7
20026f78:	191b      	adds	r3, r3, r4
20026f7a:	9304      	str	r3, [sp, #16]
20026f7c:	eb46 0302 	adc.w	r3, r6, r2
20026f80:	9305      	str	r3, [sp, #20]
20026f82:	9b00      	ldr	r3, [sp, #0]
20026f84:	6a1b      	ldr	r3, [r3, #32]
20026f86:	9a00      	ldr	r2, [sp, #0]
20026f88:	990a      	ldr	r1, [sp, #40]	@ 0x28
20026f8a:	6a52      	ldr	r2, [r2, #36]	@ 0x24
20026f8c:	e9d0 4508 	ldrd	r4, r5, [r0, #32]
20026f90:	191b      	adds	r3, r3, r4
20026f92:	eb42 0205 	adc.w	r2, r2, r5
20026f96:	185b      	adds	r3, r3, r1
20026f98:	990b      	ldr	r1, [sp, #44]	@ 0x2c
20026f9a:	9c06      	ldr	r4, [sp, #24]
20026f9c:	eb41 0202 	adc.w	r2, r1, r2
20026fa0:	9908      	ldr	r1, [sp, #32]
20026fa2:	ea81 0504 	eor.w	r5, r1, r4
20026fa6:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026fa8:	9c07      	ldr	r4, [sp, #28]
20026faa:	404c      	eors	r4, r1
20026fac:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026fae:	400d      	ands	r5, r1
20026fb0:	990d      	ldr	r1, [sp, #52]	@ 0x34
20026fb2:	400c      	ands	r4, r1
20026fb4:	9908      	ldr	r1, [sp, #32]
20026fb6:	404d      	eors	r5, r1
20026fb8:	9909      	ldr	r1, [sp, #36]	@ 0x24
20026fba:	195b      	adds	r3, r3, r5
20026fbc:	ea84 0401 	eor.w	r4, r4, r1
20026fc0:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026fc2:	eb42 0204 	adc.w	r2, r2, r4
20026fc6:	0b8e      	lsrs	r6, r1, #14
20026fc8:	990d      	ldr	r1, [sp, #52]	@ 0x34
20026fca:	ea46 4681 	orr.w	r6, r6, r1, lsl #18
20026fce:	0b8c      	lsrs	r4, r1, #14
20026fd0:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026fd2:	ea44 4481 	orr.w	r4, r4, r1, lsl #18
20026fd6:	0c8f      	lsrs	r7, r1, #18
20026fd8:	990d      	ldr	r1, [sp, #52]	@ 0x34
20026fda:	ea47 3781 	orr.w	r7, r7, r1, lsl #14
20026fde:	0c8d      	lsrs	r5, r1, #18
20026fe0:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026fe2:	407e      	eors	r6, r7
20026fe4:	ea45 3581 	orr.w	r5, r5, r1, lsl #14
20026fe8:	406c      	eors	r4, r5
20026fea:	05cd      	lsls	r5, r1, #23
20026fec:	990d      	ldr	r1, [sp, #52]	@ 0x34
20026fee:	ea45 2551 	orr.w	r5, r5, r1, lsr #9
20026ff2:	05cf      	lsls	r7, r1, #23
20026ff4:	990c      	ldr	r1, [sp, #48]	@ 0x30
20026ff6:	4075      	eors	r5, r6
20026ff8:	ea47 2751 	orr.w	r7, r7, r1, lsr #9
20026ffc:	9903      	ldr	r1, [sp, #12]
20026ffe:	195b      	adds	r3, r3, r5
20027000:	ea84 0407 	eor.w	r4, r4, r7
20027004:	eb42 0204 	adc.w	r2, r2, r4
20027008:	18c9      	adds	r1, r1, r3
2002700a:	910a      	str	r1, [sp, #40]	@ 0x28
2002700c:	eb4b 0102 	adc.w	r1, fp, r2
20027010:	910b      	str	r1, [sp, #44]	@ 0x2c
20027012:	9904      	ldr	r1, [sp, #16]
20027014:	0f0e      	lsrs	r6, r1, #28
20027016:	9905      	ldr	r1, [sp, #20]
20027018:	ea46 1601 	orr.w	r6, r6, r1, lsl #4
2002701c:	0f0d      	lsrs	r5, r1, #28
2002701e:	9904      	ldr	r1, [sp, #16]
20027020:	ea45 1501 	orr.w	r5, r5, r1, lsl #4
20027024:	078f      	lsls	r7, r1, #30
20027026:	9905      	ldr	r1, [sp, #20]
20027028:	ea47 0791 	orr.w	r7, r7, r1, lsr #2
2002702c:	078c      	lsls	r4, r1, #30
2002702e:	9904      	ldr	r1, [sp, #16]
20027030:	407e      	eors	r6, r7
20027032:	ea44 0491 	orr.w	r4, r4, r1, lsr #2
20027036:	064f      	lsls	r7, r1, #25
20027038:	9905      	ldr	r1, [sp, #20]
2002703a:	4065      	eors	r5, r4
2002703c:	ea47 17d1 	orr.w	r7, r7, r1, lsr #7
20027040:	064c      	lsls	r4, r1, #25
20027042:	9904      	ldr	r1, [sp, #16]
20027044:	407e      	eors	r6, r7
20027046:	ea44 14d1 	orr.w	r4, r4, r1, lsr #7
2002704a:	4065      	eors	r5, r4
2002704c:	ea49 0401 	orr.w	r4, r9, r1
20027050:	9905      	ldr	r1, [sp, #20]
20027052:	ea48 0701 	orr.w	r7, r8, r1
20027056:	9901      	ldr	r1, [sp, #4]
20027058:	400c      	ands	r4, r1
2002705a:	9902      	ldr	r1, [sp, #8]
2002705c:	400f      	ands	r7, r1
2002705e:	9904      	ldr	r1, [sp, #16]
20027060:	ea09 0e01 	and.w	lr, r9, r1
20027064:	9905      	ldr	r1, [sp, #20]
20027066:	ea44 040e 	orr.w	r4, r4, lr
2002706a:	ea08 0c01 	and.w	ip, r8, r1
2002706e:	1934      	adds	r4, r6, r4
20027070:	ea47 070c 	orr.w	r7, r7, ip
20027074:	eb45 0507 	adc.w	r5, r5, r7
20027078:	18e3      	adds	r3, r4, r3
2002707a:	9303      	str	r3, [sp, #12]
2002707c:	9b00      	ldr	r3, [sp, #0]
2002707e:	eb42 0b05 	adc.w	fp, r2, r5
20027082:	9a00      	ldr	r2, [sp, #0]
20027084:	6a9b      	ldr	r3, [r3, #40]	@ 0x28
20027086:	9908      	ldr	r1, [sp, #32]
20027088:	6ad2      	ldr	r2, [r2, #44]	@ 0x2c
2002708a:	e9d0 450a 	ldrd	r4, r5, [r0, #40]	@ 0x28
2002708e:	191b      	adds	r3, r3, r4
20027090:	eb42 0205 	adc.w	r2, r2, r5
20027094:	185b      	adds	r3, r3, r1
20027096:	9909      	ldr	r1, [sp, #36]	@ 0x24
20027098:	9c0c      	ldr	r4, [sp, #48]	@ 0x30
2002709a:	eb41 0202 	adc.w	r2, r1, r2
2002709e:	9906      	ldr	r1, [sp, #24]
200270a0:	ea81 0504 	eor.w	r5, r1, r4
200270a4:	9907      	ldr	r1, [sp, #28]
200270a6:	9c0d      	ldr	r4, [sp, #52]	@ 0x34
200270a8:	404c      	eors	r4, r1
200270aa:	990a      	ldr	r1, [sp, #40]	@ 0x28
200270ac:	400d      	ands	r5, r1
200270ae:	990b      	ldr	r1, [sp, #44]	@ 0x2c
200270b0:	400c      	ands	r4, r1
200270b2:	9906      	ldr	r1, [sp, #24]
200270b4:	404d      	eors	r5, r1
200270b6:	9907      	ldr	r1, [sp, #28]
200270b8:	195b      	adds	r3, r3, r5
200270ba:	ea84 0401 	eor.w	r4, r4, r1
200270be:	990a      	ldr	r1, [sp, #40]	@ 0x28
200270c0:	eb42 0204 	adc.w	r2, r2, r4
200270c4:	0b8e      	lsrs	r6, r1, #14
200270c6:	990b      	ldr	r1, [sp, #44]	@ 0x2c
200270c8:	ea46 4681 	orr.w	r6, r6, r1, lsl #18
200270cc:	0b8c      	lsrs	r4, r1, #14
200270ce:	990a      	ldr	r1, [sp, #40]	@ 0x28
200270d0:	ea44 4481 	orr.w	r4, r4, r1, lsl #18
200270d4:	0c8f      	lsrs	r7, r1, #18
200270d6:	990b      	ldr	r1, [sp, #44]	@ 0x2c
200270d8:	ea47 3781 	orr.w	r7, r7, r1, lsl #14
200270dc:	0c8d      	lsrs	r5, r1, #18
200270de:	990a      	ldr	r1, [sp, #40]	@ 0x28
200270e0:	407e      	eors	r6, r7
200270e2:	ea45 3581 	orr.w	r5, r5, r1, lsl #14
200270e6:	406c      	eors	r4, r5
200270e8:	05cd      	lsls	r5, r1, #23
200270ea:	990b      	ldr	r1, [sp, #44]	@ 0x2c
200270ec:	ea45 2551 	orr.w	r5, r5, r1, lsr #9
200270f0:	05cf      	lsls	r7, r1, #23
200270f2:	990a      	ldr	r1, [sp, #40]	@ 0x28
200270f4:	4075      	eors	r5, r6
200270f6:	ea47 2751 	orr.w	r7, r7, r1, lsr #9
200270fa:	9901      	ldr	r1, [sp, #4]
200270fc:	195b      	adds	r3, r3, r5
200270fe:	ea84 0407 	eor.w	r4, r4, r7
20027102:	eb42 0204 	adc.w	r2, r2, r4
20027106:	18c9      	adds	r1, r1, r3
20027108:	9108      	str	r1, [sp, #32]
2002710a:	9902      	ldr	r1, [sp, #8]
2002710c:	ea4f 751b 	mov.w	r5, fp, lsr #28
20027110:	eb41 0102 	adc.w	r1, r1, r2
20027114:	9109      	str	r1, [sp, #36]	@ 0x24
20027116:	9903      	ldr	r1, [sp, #12]
20027118:	ea4f 748b 	mov.w	r4, fp, lsl #30
2002711c:	ea44 0491 	orr.w	r4, r4, r1, lsr #2
20027120:	ea45 1501 	orr.w	r5, r5, r1, lsl #4
20027124:	0f0e      	lsrs	r6, r1, #28
20027126:	078f      	lsls	r7, r1, #30
20027128:	4065      	eors	r5, r4
2002712a:	ea4f 644b 	mov.w	r4, fp, lsl #25
2002712e:	ea47 079b 	orr.w	r7, r7, fp, lsr #2
20027132:	ea44 14d1 	orr.w	r4, r4, r1, lsr #7
20027136:	ea46 160b 	orr.w	r6, r6, fp, lsl #4
2002713a:	407e      	eors	r6, r7
2002713c:	4065      	eors	r5, r4
2002713e:	064f      	lsls	r7, r1, #25
20027140:	e9dd 4103 	ldrd	r4, r1, [sp, #12]
20027144:	430c      	orrs	r4, r1
20027146:	9905      	ldr	r1, [sp, #20]
20027148:	ea47 17db 	orr.w	r7, r7, fp, lsr #7
2002714c:	407e      	eors	r6, r7
2002714e:	ea41 070b 	orr.w	r7, r1, fp
20027152:	ea04 0109 	and.w	r1, r4, r9
20027156:	9101      	str	r1, [sp, #4]
20027158:	e9dd 4103 	ldrd	r4, r1, [sp, #12]
2002715c:	ea01 0e04 	and.w	lr, r1, r4
20027160:	9905      	ldr	r1, [sp, #20]
20027162:	ea07 0708 	and.w	r7, r7, r8
20027166:	ea01 0c0b 	and.w	ip, r1, fp
2002716a:	9901      	ldr	r1, [sp, #4]
2002716c:	ea47 070c 	orr.w	r7, r7, ip
20027170:	ea41 040e 	orr.w	r4, r1, lr
20027174:	1934      	adds	r4, r6, r4
20027176:	eb45 0507 	adc.w	r5, r5, r7
2002717a:	18e3      	adds	r3, r4, r3
2002717c:	9301      	str	r3, [sp, #4]
2002717e:	eb42 0305 	adc.w	r3, r2, r5
20027182:	9302      	str	r3, [sp, #8]
20027184:	9b00      	ldr	r3, [sp, #0]
20027186:	9a00      	ldr	r2, [sp, #0]
20027188:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
2002718a:	9906      	ldr	r1, [sp, #24]
2002718c:	6b52      	ldr	r2, [r2, #52]	@ 0x34
2002718e:	e9d0 450c 	ldrd	r4, r5, [r0, #48]	@ 0x30
20027192:	191b      	adds	r3, r3, r4
20027194:	eb42 0205 	adc.w	r2, r2, r5
20027198:	185b      	adds	r3, r3, r1
2002719a:	9907      	ldr	r1, [sp, #28]
2002719c:	9c0a      	ldr	r4, [sp, #40]	@ 0x28
2002719e:	eb41 0202 	adc.w	r2, r1, r2
200271a2:	990c      	ldr	r1, [sp, #48]	@ 0x30
200271a4:	ea81 0504 	eor.w	r5, r1, r4
200271a8:	990d      	ldr	r1, [sp, #52]	@ 0x34
200271aa:	9c0b      	ldr	r4, [sp, #44]	@ 0x2c
200271ac:	404c      	eors	r4, r1
200271ae:	9908      	ldr	r1, [sp, #32]
200271b0:	400d      	ands	r5, r1
200271b2:	9909      	ldr	r1, [sp, #36]	@ 0x24
200271b4:	400c      	ands	r4, r1
200271b6:	990c      	ldr	r1, [sp, #48]	@ 0x30
200271b8:	404d      	eors	r5, r1
200271ba:	990d      	ldr	r1, [sp, #52]	@ 0x34
200271bc:	195b      	adds	r3, r3, r5
200271be:	ea84 0401 	eor.w	r4, r4, r1
200271c2:	9908      	ldr	r1, [sp, #32]
200271c4:	eb42 0204 	adc.w	r2, r2, r4
200271c8:	0b8e      	lsrs	r6, r1, #14
200271ca:	9909      	ldr	r1, [sp, #36]	@ 0x24
200271cc:	ea46 4681 	orr.w	r6, r6, r1, lsl #18
200271d0:	0b8c      	lsrs	r4, r1, #14
200271d2:	9908      	ldr	r1, [sp, #32]
200271d4:	ea44 4481 	orr.w	r4, r4, r1, lsl #18
200271d8:	0c8f      	lsrs	r7, r1, #18
200271da:	9909      	ldr	r1, [sp, #36]	@ 0x24
200271dc:	ea47 3781 	orr.w	r7, r7, r1, lsl #14
200271e0:	0c8d      	lsrs	r5, r1, #18
200271e2:	9908      	ldr	r1, [sp, #32]
200271e4:	407e      	eors	r6, r7
200271e6:	ea45 3581 	orr.w	r5, r5, r1, lsl #14
200271ea:	406c      	eors	r4, r5
200271ec:	05cd      	lsls	r5, r1, #23
200271ee:	9909      	ldr	r1, [sp, #36]	@ 0x24
200271f0:	ea45 2551 	orr.w	r5, r5, r1, lsr #9
200271f4:	05cf      	lsls	r7, r1, #23
200271f6:	9908      	ldr	r1, [sp, #32]
200271f8:	4075      	eors	r5, r6
200271fa:	ea47 2751 	orr.w	r7, r7, r1, lsr #9
200271fe:	195b      	adds	r3, r3, r5
20027200:	ea84 0407 	eor.w	r4, r4, r7
20027204:	eb42 0204 	adc.w	r2, r2, r4
20027208:	eb19 0103 	adds.w	r1, r9, r3
2002720c:	9106      	str	r1, [sp, #24]
2002720e:	eb48 0102 	adc.w	r1, r8, r2
20027212:	9107      	str	r1, [sp, #28]
20027214:	9901      	ldr	r1, [sp, #4]
20027216:	0f0e      	lsrs	r6, r1, #28
20027218:	9902      	ldr	r1, [sp, #8]
2002721a:	ea46 1601 	orr.w	r6, r6, r1, lsl #4
2002721e:	0f0d      	lsrs	r5, r1, #28
20027220:	9901      	ldr	r1, [sp, #4]
20027222:	ea45 1501 	orr.w	r5, r5, r1, lsl #4
20027226:	078f      	lsls	r7, r1, #30
20027228:	9902      	ldr	r1, [sp, #8]
2002722a:	ea47 0791 	orr.w	r7, r7, r1, lsr #2
2002722e:	078c      	lsls	r4, r1, #30
20027230:	9901      	ldr	r1, [sp, #4]
20027232:	407e      	eors	r6, r7
20027234:	ea44 0491 	orr.w	r4, r4, r1, lsr #2
20027238:	064f      	lsls	r7, r1, #25
2002723a:	9902      	ldr	r1, [sp, #8]
2002723c:	4065      	eors	r5, r4
2002723e:	ea47 17d1 	orr.w	r7, r7, r1, lsr #7
20027242:	064c      	lsls	r4, r1, #25
20027244:	9901      	ldr	r1, [sp, #4]
20027246:	407e      	eors	r6, r7
20027248:	ea44 14d1 	orr.w	r4, r4, r1, lsr #7
2002724c:	4065      	eors	r5, r4
2002724e:	9903      	ldr	r1, [sp, #12]
20027250:	9c01      	ldr	r4, [sp, #4]
20027252:	430c      	orrs	r4, r1
20027254:	9902      	ldr	r1, [sp, #8]
20027256:	ea4b 0701 	orr.w	r7, fp, r1
2002725a:	9904      	ldr	r1, [sp, #16]
2002725c:	ea04 0801 	and.w	r8, r4, r1
20027260:	9905      	ldr	r1, [sp, #20]
20027262:	9c01      	ldr	r4, [sp, #4]
20027264:	400f      	ands	r7, r1
20027266:	9903      	ldr	r1, [sp, #12]
20027268:	ea01 0e04 	and.w	lr, r1, r4
2002726c:	9902      	ldr	r1, [sp, #8]
2002726e:	ea48 040e 	orr.w	r4, r8, lr
20027272:	ea0b 0c01 	and.w	ip, fp, r1
20027276:	1934      	adds	r4, r6, r4
20027278:	ea47 070c 	orr.w	r7, r7, ip
2002727c:	eb45 0507 	adc.w	r5, r5, r7
20027280:	eb14 0c03 	adds.w	ip, r4, r3
20027284:	9b00      	ldr	r3, [sp, #0]
20027286:	eb42 0e05 	adc.w	lr, r2, r5
2002728a:	6b9b      	ldr	r3, [r3, #56]	@ 0x38
2002728c:	9a00      	ldr	r2, [sp, #0]
2002728e:	e9d0 450e 	ldrd	r4, r5, [r0, #56]	@ 0x38
20027292:	6bd2      	ldr	r2, [r2, #60]	@ 0x3c
20027294:	191c      	adds	r4, r3, r4
20027296:	9b0c      	ldr	r3, [sp, #48]	@ 0x30
20027298:	eb42 0205 	adc.w	r2, r2, r5
2002729c:	18e4      	adds	r4, r4, r3
2002729e:	9b0d      	ldr	r3, [sp, #52]	@ 0x34
200272a0:	9908      	ldr	r1, [sp, #32]
200272a2:	eb43 0202 	adc.w	r2, r3, r2
200272a6:	9b0a      	ldr	r3, [sp, #40]	@ 0x28
200272a8:	3040      	adds	r0, #64	@ 0x40
200272aa:	ea83 0501 	eor.w	r5, r3, r1
200272ae:	9909      	ldr	r1, [sp, #36]	@ 0x24
200272b0:	9b0b      	ldr	r3, [sp, #44]	@ 0x2c
200272b2:	404b      	eors	r3, r1
200272b4:	9906      	ldr	r1, [sp, #24]
200272b6:	400d      	ands	r5, r1
200272b8:	9907      	ldr	r1, [sp, #28]
200272ba:	400b      	ands	r3, r1
200272bc:	990a      	ldr	r1, [sp, #40]	@ 0x28
200272be:	404d      	eors	r5, r1
200272c0:	990b      	ldr	r1, [sp, #44]	@ 0x2c
200272c2:	1964      	adds	r4, r4, r5
200272c4:	ea83 0301 	eor.w	r3, r3, r1
200272c8:	eb42 0203 	adc.w	r2, r2, r3
200272cc:	9b06      	ldr	r3, [sp, #24]
200272ce:	9906      	ldr	r1, [sp, #24]
200272d0:	0b9e      	lsrs	r6, r3, #14
200272d2:	9b07      	ldr	r3, [sp, #28]
200272d4:	0c8f      	lsrs	r7, r1, #18
200272d6:	ea46 4683 	orr.w	r6, r6, r3, lsl #18
200272da:	0b9b      	lsrs	r3, r3, #14
200272dc:	ea43 4381 	orr.w	r3, r3, r1, lsl #18
200272e0:	9907      	ldr	r1, [sp, #28]
200272e2:	ea47 3781 	orr.w	r7, r7, r1, lsl #14
200272e6:	0c8d      	lsrs	r5, r1, #18
200272e8:	9906      	ldr	r1, [sp, #24]
200272ea:	407e      	eors	r6, r7
200272ec:	ea45 3581 	orr.w	r5, r5, r1, lsl #14
200272f0:	406b      	eors	r3, r5
200272f2:	05cd      	lsls	r5, r1, #23
200272f4:	9907      	ldr	r1, [sp, #28]
200272f6:	ea45 2551 	orr.w	r5, r5, r1, lsr #9
200272fa:	05cf      	lsls	r7, r1, #23
200272fc:	9906      	ldr	r1, [sp, #24]
200272fe:	4075      	eors	r5, r6
20027300:	ea47 2751 	orr.w	r7, r7, r1, lsr #9
20027304:	1964      	adds	r4, r4, r5
20027306:	ea83 0307 	eor.w	r3, r3, r7
2002730a:	eb42 0203 	adc.w	r2, r2, r3
2002730e:	9b04      	ldr	r3, [sp, #16]
20027310:	ea4f 751e 	mov.w	r5, lr, lsr #28
20027314:	191b      	adds	r3, r3, r4
20027316:	9304      	str	r3, [sp, #16]
20027318:	9b05      	ldr	r3, [sp, #20]
2002731a:	ea4f 761c 	mov.w	r6, ip, lsr #28
2002731e:	eb43 0302 	adc.w	r3, r3, r2
20027322:	9305      	str	r3, [sp, #20]
20027324:	ea4f 738e 	mov.w	r3, lr, lsl #30
20027328:	ea43 039c 	orr.w	r3, r3, ip, lsr #2
2002732c:	ea45 150c 	orr.w	r5, r5, ip, lsl #4
20027330:	ea4f 778c 	mov.w	r7, ip, lsl #30
20027334:	ea47 079e 	orr.w	r7, r7, lr, lsr #2
20027338:	405d      	eors	r5, r3
2002733a:	ea46 160e 	orr.w	r6, r6, lr, lsl #4
2002733e:	ea4f 634e 	mov.w	r3, lr, lsl #25
20027342:	9902      	ldr	r1, [sp, #8]
20027344:	407e      	eors	r6, r7
20027346:	ea43 13dc 	orr.w	r3, r3, ip, lsr #7
2002734a:	ea4f 674c 	mov.w	r7, ip, lsl #25
2002734e:	ea47 17de 	orr.w	r7, r7, lr, lsr #7
20027352:	405d      	eors	r5, r3
20027354:	9b01      	ldr	r3, [sp, #4]
20027356:	407e      	eors	r6, r7
20027358:	ea41 070e 	orr.w	r7, r1, lr
2002735c:	9903      	ldr	r1, [sp, #12]
2002735e:	ea43 030c 	orr.w	r3, r3, ip
20027362:	400b      	ands	r3, r1
20027364:	9901      	ldr	r1, [sp, #4]
20027366:	ea07 070b 	and.w	r7, r7, fp
2002736a:	ea01 090c 	and.w	r9, r1, ip
2002736e:	9902      	ldr	r1, [sp, #8]
20027370:	ea43 0309 	orr.w	r3, r3, r9
20027374:	ea01 080e 	and.w	r8, r1, lr
20027378:	9900      	ldr	r1, [sp, #0]
2002737a:	18f3      	adds	r3, r6, r3
2002737c:	f101 0140 	add.w	r1, r1, #64	@ 0x40
20027380:	9100      	str	r1, [sp, #0]
20027382:	ea47 0708 	orr.w	r7, r7, r8
20027386:	eb45 0507 	adc.w	r5, r5, r7
2002738a:	4928      	ldr	r1, [pc, #160]	@ (2002742c <mbedtls_sha512_process+0xa54>)
2002738c:	191b      	adds	r3, r3, r4
2002738e:	9c00      	ldr	r4, [sp, #0]
20027390:	eb42 0205 	adc.w	r2, r2, r5
20027394:	42a1      	cmp	r1, r4
20027396:	f47f abe3 	bne.w	20026b60 <mbedtls_sha512_process+0x188>
2002739a:	990e      	ldr	r1, [sp, #56]	@ 0x38
2002739c:	18cb      	adds	r3, r1, r3
2002739e:	990f      	ldr	r1, [sp, #60]	@ 0x3c
200273a0:	eb42 0201 	adc.w	r2, r2, r1
200273a4:	e9ca 3204 	strd	r3, r2, [sl, #16]
200273a8:	9b10      	ldr	r3, [sp, #64]	@ 0x40
200273aa:	9a11      	ldr	r2, [sp, #68]	@ 0x44
200273ac:	eb13 030c 	adds.w	r3, r3, ip
200273b0:	eb4e 0202 	adc.w	r2, lr, r2
200273b4:	e9ca 3206 	strd	r3, r2, [sl, #24]
200273b8:	9a01      	ldr	r2, [sp, #4]
200273ba:	9b12      	ldr	r3, [sp, #72]	@ 0x48
200273bc:	9913      	ldr	r1, [sp, #76]	@ 0x4c
200273be:	189b      	adds	r3, r3, r2
200273c0:	9a02      	ldr	r2, [sp, #8]
200273c2:	eb42 0201 	adc.w	r2, r2, r1
200273c6:	e9ca 3208 	strd	r3, r2, [sl, #32]
200273ca:	9a03      	ldr	r2, [sp, #12]
200273cc:	9b14      	ldr	r3, [sp, #80]	@ 0x50
200273ce:	9917      	ldr	r1, [sp, #92]	@ 0x5c
200273d0:	189b      	adds	r3, r3, r2
200273d2:	9a15      	ldr	r2, [sp, #84]	@ 0x54
200273d4:	eb4b 0202 	adc.w	r2, fp, r2
200273d8:	e9ca 320a 	strd	r3, r2, [sl, #40]	@ 0x28
200273dc:	9a04      	ldr	r2, [sp, #16]
200273de:	9b16      	ldr	r3, [sp, #88]	@ 0x58
200273e0:	189b      	adds	r3, r3, r2
200273e2:	9a05      	ldr	r2, [sp, #20]
200273e4:	eb42 0201 	adc.w	r2, r2, r1
200273e8:	e9ca 320c 	strd	r3, r2, [sl, #48]	@ 0x30
200273ec:	9b18      	ldr	r3, [sp, #96]	@ 0x60
200273ee:	9a06      	ldr	r2, [sp, #24]
200273f0:	9919      	ldr	r1, [sp, #100]	@ 0x64
200273f2:	189a      	adds	r2, r3, r2
200273f4:	9b07      	ldr	r3, [sp, #28]
200273f6:	eb43 0301 	adc.w	r3, r3, r1
200273fa:	e9ca 230e 	strd	r2, r3, [sl, #56]	@ 0x38
200273fe:	9b1a      	ldr	r3, [sp, #104]	@ 0x68
20027400:	9a08      	ldr	r2, [sp, #32]
20027402:	991b      	ldr	r1, [sp, #108]	@ 0x6c
20027404:	189a      	adds	r2, r3, r2
20027406:	9b09      	ldr	r3, [sp, #36]	@ 0x24
20027408:	eb43 0301 	adc.w	r3, r3, r1
2002740c:	e9ca 2310 	strd	r2, r3, [sl, #64]	@ 0x40
20027410:	9b1c      	ldr	r3, [sp, #112]	@ 0x70
20027412:	9a0a      	ldr	r2, [sp, #40]	@ 0x28
20027414:	991d      	ldr	r1, [sp, #116]	@ 0x74
20027416:	189a      	adds	r2, r3, r2
20027418:	9b0b      	ldr	r3, [sp, #44]	@ 0x2c
2002741a:	eb43 0301 	adc.w	r3, r3, r1
2002741e:	e9ca 2312 	strd	r2, r3, [sl, #72]	@ 0x48
20027422:	f50d 7d3f 	add.w	sp, sp, #764	@ 0x2fc
20027426:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
2002742a:	bf00      	nop
2002742c:	2002c1e0 	.word	0x2002c1e0

20027430 <mbedtls_sha512_update.part.0>:
20027430:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
20027434:	4615      	mov	r5, r2
20027436:	e9d0 3200 	ldrd	r3, r2, [r0]
2002743a:	f003 077f 	and.w	r7, r3, #127	@ 0x7f
2002743e:	195b      	adds	r3, r3, r5
20027440:	f152 0200 	adcs.w	r2, r2, #0
20027444:	460e      	mov	r6, r1
20027446:	f04f 0100 	mov.w	r1, #0
2002744a:	bf28      	it	cs
2002744c:	2101      	movcs	r1, #1
2002744e:	4604      	mov	r4, r0
20027450:	e9c0 3200 	strd	r3, r2, [r0]
20027454:	b131      	cbz	r1, 20027464 <mbedtls_sha512_update.part.0+0x34>
20027456:	e9d0 3202 	ldrd	r3, r2, [r0, #8]
2002745a:	3301      	adds	r3, #1
2002745c:	f142 0200 	adc.w	r2, r2, #0
20027460:	e9c0 3202 	strd	r3, r2, [r0, #8]
20027464:	b19f      	cbz	r7, 2002748e <mbedtls_sha512_update.part.0+0x5e>
20027466:	f1c7 0980 	rsb	r9, r7, #128	@ 0x80
2002746a:	45a9      	cmp	r9, r5
2002746c:	d80f      	bhi.n	2002748e <mbedtls_sha512_update.part.0+0x5e>
2002746e:	f104 0850 	add.w	r8, r4, #80	@ 0x50
20027472:	4631      	mov	r1, r6
20027474:	464a      	mov	r2, r9
20027476:	eb08 0007 	add.w	r0, r8, r7
2002747a:	f003 fa05 	bl	2002a888 <memcpy>
2002747e:	3d80      	subs	r5, #128	@ 0x80
20027480:	4641      	mov	r1, r8
20027482:	4620      	mov	r0, r4
20027484:	443d      	add	r5, r7
20027486:	f7ff faa7 	bl	200269d8 <mbedtls_sha512_process>
2002748a:	2700      	movs	r7, #0
2002748c:	444e      	add	r6, r9
2002748e:	46a8      	mov	r8, r5
20027490:	eb05 0906 	add.w	r9, r5, r6
20027494:	e004      	b.n	200274a0 <mbedtls_sha512_update.part.0+0x70>
20027496:	4620      	mov	r0, r4
20027498:	f7ff fa9e 	bl	200269d8 <mbedtls_sha512_process>
2002749c:	f1a8 0880 	sub.w	r8, r8, #128	@ 0x80
200274a0:	f1b8 0f7f 	cmp.w	r8, #127	@ 0x7f
200274a4:	eba9 0108 	sub.w	r1, r9, r8
200274a8:	d8f5      	bhi.n	20027496 <mbedtls_sha512_update.part.0+0x66>
200274aa:	f06f 037f 	mvn.w	r3, #127	@ 0x7f
200274ae:	09e9      	lsrs	r1, r5, #7
200274b0:	4359      	muls	r1, r3
200274b2:	186a      	adds	r2, r5, r1
200274b4:	d007      	beq.n	200274c6 <mbedtls_sha512_update.part.0+0x96>
200274b6:	f104 0050 	add.w	r0, r4, #80	@ 0x50
200274ba:	1a71      	subs	r1, r6, r1
200274bc:	4438      	add	r0, r7
200274be:	e8bd 43f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
200274c2:	f003 b9e1 	b.w	2002a888 <memcpy>
200274c6:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

200274ca <mbedtls_sha512_update>:
200274ca:	b10a      	cbz	r2, 200274d0 <mbedtls_sha512_update+0x6>
200274cc:	f7ff bfb0 	b.w	20027430 <mbedtls_sha512_update.part.0>
200274d0:	4770      	bx	lr
	...

200274d4 <mbedtls_sha512_finish>:
200274d4:	b5f0      	push	{r4, r5, r6, r7, lr}
200274d6:	4604      	mov	r4, r0
200274d8:	e9d0 2300 	ldrd	r2, r3, [r0]
200274dc:	460d      	mov	r5, r1
200274de:	e9d0 6102 	ldrd	r6, r1, [r0, #8]
200274e2:	00c9      	lsls	r1, r1, #3
200274e4:	ea41 7156 	orr.w	r1, r1, r6, lsr #29
200274e8:	b085      	sub	sp, #20
200274ea:	0e0f      	lsrs	r7, r1, #24
200274ec:	0f58      	lsrs	r0, r3, #29
200274ee:	00db      	lsls	r3, r3, #3
200274f0:	ea43 7352 	orr.w	r3, r3, r2, lsr #29
200274f4:	f88d 7000 	strb.w	r7, [sp]
200274f8:	0c0f      	lsrs	r7, r1, #16
200274fa:	f88d 7001 	strb.w	r7, [sp, #1]
200274fe:	f88d 1003 	strb.w	r1, [sp, #3]
20027502:	0a0f      	lsrs	r7, r1, #8
20027504:	0e19      	lsrs	r1, r3, #24
20027506:	ea40 00c6 	orr.w	r0, r0, r6, lsl #3
2002750a:	f88d 1008 	strb.w	r1, [sp, #8]
2002750e:	00d6      	lsls	r6, r2, #3
20027510:	0c19      	lsrs	r1, r3, #16
20027512:	f002 027f 	and.w	r2, r2, #127	@ 0x7f
20027516:	2a6f      	cmp	r2, #111	@ 0x6f
20027518:	ba00      	rev	r0, r0
2002751a:	f88d 1009 	strb.w	r1, [sp, #9]
2002751e:	ea4f 2113 	mov.w	r1, r3, lsr #8
20027522:	bf94      	ite	ls
20027524:	f1c2 0270 	rsbls	r2, r2, #112	@ 0x70
20027528:	f1c2 02f0 	rsbhi	r2, r2, #240	@ 0xf0
2002752c:	9001      	str	r0, [sp, #4]
2002752e:	f88d 100a 	strb.w	r1, [sp, #10]
20027532:	4620      	mov	r0, r4
20027534:	4969      	ldr	r1, [pc, #420]	@ (200276dc <mbedtls_sha512_finish+0x208>)
20027536:	ba36      	rev	r6, r6
20027538:	f88d 300b 	strb.w	r3, [sp, #11]
2002753c:	f88d 7002 	strb.w	r7, [sp, #2]
20027540:	9603      	str	r6, [sp, #12]
20027542:	f7ff ffc2 	bl	200274ca <mbedtls_sha512_update>
20027546:	2210      	movs	r2, #16
20027548:	4669      	mov	r1, sp
2002754a:	4620      	mov	r0, r4
2002754c:	f7ff ff70 	bl	20027430 <mbedtls_sha512_update.part.0>
20027550:	7de3      	ldrb	r3, [r4, #23]
20027552:	702b      	strb	r3, [r5, #0]
20027554:	8ae3      	ldrh	r3, [r4, #22]
20027556:	706b      	strb	r3, [r5, #1]
20027558:	6963      	ldr	r3, [r4, #20]
2002755a:	0a1b      	lsrs	r3, r3, #8
2002755c:	70ab      	strb	r3, [r5, #2]
2002755e:	6963      	ldr	r3, [r4, #20]
20027560:	70eb      	strb	r3, [r5, #3]
20027562:	7ce3      	ldrb	r3, [r4, #19]
20027564:	712b      	strb	r3, [r5, #4]
20027566:	8a63      	ldrh	r3, [r4, #18]
20027568:	716b      	strb	r3, [r5, #5]
2002756a:	6923      	ldr	r3, [r4, #16]
2002756c:	0a1b      	lsrs	r3, r3, #8
2002756e:	71ab      	strb	r3, [r5, #6]
20027570:	6923      	ldr	r3, [r4, #16]
20027572:	71eb      	strb	r3, [r5, #7]
20027574:	7fe3      	ldrb	r3, [r4, #31]
20027576:	722b      	strb	r3, [r5, #8]
20027578:	8be3      	ldrh	r3, [r4, #30]
2002757a:	726b      	strb	r3, [r5, #9]
2002757c:	69e3      	ldr	r3, [r4, #28]
2002757e:	0a1b      	lsrs	r3, r3, #8
20027580:	72ab      	strb	r3, [r5, #10]
20027582:	69e3      	ldr	r3, [r4, #28]
20027584:	72eb      	strb	r3, [r5, #11]
20027586:	7ee3      	ldrb	r3, [r4, #27]
20027588:	732b      	strb	r3, [r5, #12]
2002758a:	8b63      	ldrh	r3, [r4, #26]
2002758c:	736b      	strb	r3, [r5, #13]
2002758e:	69a3      	ldr	r3, [r4, #24]
20027590:	0a1b      	lsrs	r3, r3, #8
20027592:	73ab      	strb	r3, [r5, #14]
20027594:	69a3      	ldr	r3, [r4, #24]
20027596:	73eb      	strb	r3, [r5, #15]
20027598:	f894 3027 	ldrb.w	r3, [r4, #39]	@ 0x27
2002759c:	742b      	strb	r3, [r5, #16]
2002759e:	8ce3      	ldrh	r3, [r4, #38]	@ 0x26
200275a0:	746b      	strb	r3, [r5, #17]
200275a2:	6a63      	ldr	r3, [r4, #36]	@ 0x24
200275a4:	0a1b      	lsrs	r3, r3, #8
200275a6:	74ab      	strb	r3, [r5, #18]
200275a8:	6a63      	ldr	r3, [r4, #36]	@ 0x24
200275aa:	74eb      	strb	r3, [r5, #19]
200275ac:	f894 3023 	ldrb.w	r3, [r4, #35]	@ 0x23
200275b0:	752b      	strb	r3, [r5, #20]
200275b2:	8c63      	ldrh	r3, [r4, #34]	@ 0x22
200275b4:	756b      	strb	r3, [r5, #21]
200275b6:	6a23      	ldr	r3, [r4, #32]
200275b8:	0a1b      	lsrs	r3, r3, #8
200275ba:	75ab      	strb	r3, [r5, #22]
200275bc:	6a23      	ldr	r3, [r4, #32]
200275be:	75eb      	strb	r3, [r5, #23]
200275c0:	f894 302f 	ldrb.w	r3, [r4, #47]	@ 0x2f
200275c4:	762b      	strb	r3, [r5, #24]
200275c6:	8de3      	ldrh	r3, [r4, #46]	@ 0x2e
200275c8:	766b      	strb	r3, [r5, #25]
200275ca:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
200275cc:	0a1b      	lsrs	r3, r3, #8
200275ce:	76ab      	strb	r3, [r5, #26]
200275d0:	6ae3      	ldr	r3, [r4, #44]	@ 0x2c
200275d2:	76eb      	strb	r3, [r5, #27]
200275d4:	f894 302b 	ldrb.w	r3, [r4, #43]	@ 0x2b
200275d8:	772b      	strb	r3, [r5, #28]
200275da:	8d63      	ldrh	r3, [r4, #42]	@ 0x2a
200275dc:	776b      	strb	r3, [r5, #29]
200275de:	6aa3      	ldr	r3, [r4, #40]	@ 0x28
200275e0:	0a1b      	lsrs	r3, r3, #8
200275e2:	77ab      	strb	r3, [r5, #30]
200275e4:	6aa3      	ldr	r3, [r4, #40]	@ 0x28
200275e6:	77eb      	strb	r3, [r5, #31]
200275e8:	f894 3037 	ldrb.w	r3, [r4, #55]	@ 0x37
200275ec:	f885 3020 	strb.w	r3, [r5, #32]
200275f0:	8ee3      	ldrh	r3, [r4, #54]	@ 0x36
200275f2:	f885 3021 	strb.w	r3, [r5, #33]	@ 0x21
200275f6:	6b63      	ldr	r3, [r4, #52]	@ 0x34
200275f8:	0a1b      	lsrs	r3, r3, #8
200275fa:	f885 3022 	strb.w	r3, [r5, #34]	@ 0x22
200275fe:	6b63      	ldr	r3, [r4, #52]	@ 0x34
20027600:	f885 3023 	strb.w	r3, [r5, #35]	@ 0x23
20027604:	f894 3033 	ldrb.w	r3, [r4, #51]	@ 0x33
20027608:	f885 3024 	strb.w	r3, [r5, #36]	@ 0x24
2002760c:	8e63      	ldrh	r3, [r4, #50]	@ 0x32
2002760e:	f885 3025 	strb.w	r3, [r5, #37]	@ 0x25
20027612:	6b23      	ldr	r3, [r4, #48]	@ 0x30
20027614:	0a1b      	lsrs	r3, r3, #8
20027616:	f885 3026 	strb.w	r3, [r5, #38]	@ 0x26
2002761a:	6b23      	ldr	r3, [r4, #48]	@ 0x30
2002761c:	f885 3027 	strb.w	r3, [r5, #39]	@ 0x27
20027620:	f894 303f 	ldrb.w	r3, [r4, #63]	@ 0x3f
20027624:	f885 3028 	strb.w	r3, [r5, #40]	@ 0x28
20027628:	8fe3      	ldrh	r3, [r4, #62]	@ 0x3e
2002762a:	f885 3029 	strb.w	r3, [r5, #41]	@ 0x29
2002762e:	6be3      	ldr	r3, [r4, #60]	@ 0x3c
20027630:	0a1b      	lsrs	r3, r3, #8
20027632:	f885 302a 	strb.w	r3, [r5, #42]	@ 0x2a
20027636:	6be3      	ldr	r3, [r4, #60]	@ 0x3c
20027638:	f885 302b 	strb.w	r3, [r5, #43]	@ 0x2b
2002763c:	f894 303b 	ldrb.w	r3, [r4, #59]	@ 0x3b
20027640:	f885 302c 	strb.w	r3, [r5, #44]	@ 0x2c
20027644:	8f63      	ldrh	r3, [r4, #58]	@ 0x3a
20027646:	f885 302d 	strb.w	r3, [r5, #45]	@ 0x2d
2002764a:	6ba3      	ldr	r3, [r4, #56]	@ 0x38
2002764c:	0a1b      	lsrs	r3, r3, #8
2002764e:	f885 302e 	strb.w	r3, [r5, #46]	@ 0x2e
20027652:	6ba3      	ldr	r3, [r4, #56]	@ 0x38
20027654:	f885 302f 	strb.w	r3, [r5, #47]	@ 0x2f
20027658:	f8d4 30d0 	ldr.w	r3, [r4, #208]	@ 0xd0
2002765c:	2b00      	cmp	r3, #0
2002765e:	d13b      	bne.n	200276d8 <mbedtls_sha512_finish+0x204>
20027660:	f894 3047 	ldrb.w	r3, [r4, #71]	@ 0x47
20027664:	f885 3030 	strb.w	r3, [r5, #48]	@ 0x30
20027668:	f8b4 3046 	ldrh.w	r3, [r4, #70]	@ 0x46
2002766c:	f885 3031 	strb.w	r3, [r5, #49]	@ 0x31
20027670:	6c63      	ldr	r3, [r4, #68]	@ 0x44
20027672:	0a1b      	lsrs	r3, r3, #8
20027674:	f885 3032 	strb.w	r3, [r5, #50]	@ 0x32
20027678:	6c63      	ldr	r3, [r4, #68]	@ 0x44
2002767a:	f885 3033 	strb.w	r3, [r5, #51]	@ 0x33
2002767e:	f894 3043 	ldrb.w	r3, [r4, #67]	@ 0x43
20027682:	f885 3034 	strb.w	r3, [r5, #52]	@ 0x34
20027686:	f8b4 3042 	ldrh.w	r3, [r4, #66]	@ 0x42
2002768a:	f885 3035 	strb.w	r3, [r5, #53]	@ 0x35
2002768e:	6c23      	ldr	r3, [r4, #64]	@ 0x40
20027690:	0a1b      	lsrs	r3, r3, #8
20027692:	f885 3036 	strb.w	r3, [r5, #54]	@ 0x36
20027696:	6c23      	ldr	r3, [r4, #64]	@ 0x40
20027698:	f885 3037 	strb.w	r3, [r5, #55]	@ 0x37
2002769c:	f894 304f 	ldrb.w	r3, [r4, #79]	@ 0x4f
200276a0:	f885 3038 	strb.w	r3, [r5, #56]	@ 0x38
200276a4:	f8b4 304e 	ldrh.w	r3, [r4, #78]	@ 0x4e
200276a8:	f885 3039 	strb.w	r3, [r5, #57]	@ 0x39
200276ac:	6ce3      	ldr	r3, [r4, #76]	@ 0x4c
200276ae:	0a1b      	lsrs	r3, r3, #8
200276b0:	f885 303a 	strb.w	r3, [r5, #58]	@ 0x3a
200276b4:	6ce3      	ldr	r3, [r4, #76]	@ 0x4c
200276b6:	f885 303b 	strb.w	r3, [r5, #59]	@ 0x3b
200276ba:	f894 304b 	ldrb.w	r3, [r4, #75]	@ 0x4b
200276be:	f885 303c 	strb.w	r3, [r5, #60]	@ 0x3c
200276c2:	f8b4 304a 	ldrh.w	r3, [r4, #74]	@ 0x4a
200276c6:	f885 303d 	strb.w	r3, [r5, #61]	@ 0x3d
200276ca:	6ca3      	ldr	r3, [r4, #72]	@ 0x48
200276cc:	0a1b      	lsrs	r3, r3, #8
200276ce:	f885 303e 	strb.w	r3, [r5, #62]	@ 0x3e
200276d2:	6ca3      	ldr	r3, [r4, #72]	@ 0x48
200276d4:	f885 303f 	strb.w	r3, [r5, #63]	@ 0x3f
200276d8:	b005      	add	sp, #20
200276da:	bdf0      	pop	{r4, r5, r6, r7, pc}
200276dc:	2002bedc 	.word	0x2002bedc

200276e0 <mbedtls_sha512>:
200276e0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200276e4:	461c      	mov	r4, r3
200276e6:	b0b7      	sub	sp, #220	@ 0xdc
200276e8:	4606      	mov	r6, r0
200276ea:	4668      	mov	r0, sp
200276ec:	460f      	mov	r7, r1
200276ee:	4615      	mov	r5, r2
200276f0:	f7ff f8ce 	bl	20026890 <mbedtls_sha512_init>
200276f4:	2c00      	cmp	r4, #0
200276f6:	d03f      	beq.n	20027778 <mbedtls_sha512+0x98>
200276f8:	f20f 0bf4 	addw	fp, pc, #244	@ 0xf4
200276fc:	e9db ab00 	ldrd	sl, fp, [fp]
20027700:	f20f 09f4 	addw	r9, pc, #244	@ 0xf4
20027704:	e9d9 8900 	ldrd	r8, r9, [r9]
20027708:	a13d      	add	r1, pc, #244	@ (adr r1, 20027800 <mbedtls_sha512+0x120>)
2002770a:	e9d1 0100 	ldrd	r0, r1, [r1]
2002770e:	a33e      	add	r3, pc, #248	@ (adr r3, 20027808 <mbedtls_sha512+0x128>)
20027710:	e9d3 2300 	ldrd	r2, r3, [r3]
20027714:	ed9f 4b24 	vldr	d4, [pc, #144]	@ 200277a8 <mbedtls_sha512+0xc8>
20027718:	ed9f 5b25 	vldr	d5, [pc, #148]	@ 200277b0 <mbedtls_sha512+0xd0>
2002771c:	ed9f 6b26 	vldr	d6, [pc, #152]	@ 200277b8 <mbedtls_sha512+0xd8>
20027720:	ed9f 7b27 	vldr	d7, [pc, #156]	@ 200277c0 <mbedtls_sha512+0xe0>
20027724:	ed9f 3b28 	vldr	d3, [pc, #160]	@ 200277c8 <mbedtls_sha512+0xe8>
20027728:	e9cd 2312 	strd	r2, r3, [sp, #72]	@ 0x48
2002772c:	e9cd 0110 	strd	r0, r1, [sp, #64]	@ 0x40
20027730:	463a      	mov	r2, r7
20027732:	4631      	mov	r1, r6
20027734:	4668      	mov	r0, sp
20027736:	ed8d 3b00 	vstr	d3, [sp]
2002773a:	ed8d 3b02 	vstr	d3, [sp, #8]
2002773e:	ed8d 4b04 	vstr	d4, [sp, #16]
20027742:	ed8d 5b06 	vstr	d5, [sp, #24]
20027746:	ed8d 6b08 	vstr	d6, [sp, #32]
2002774a:	ed8d 7b0a 	vstr	d7, [sp, #40]	@ 0x28
2002774e:	e9cd ab0c 	strd	sl, fp, [sp, #48]	@ 0x30
20027752:	e9cd 890e 	strd	r8, r9, [sp, #56]	@ 0x38
20027756:	9434      	str	r4, [sp, #208]	@ 0xd0
20027758:	f7ff feb7 	bl	200274ca <mbedtls_sha512_update>
2002775c:	4629      	mov	r1, r5
2002775e:	4668      	mov	r0, sp
20027760:	f7ff feb8 	bl	200274d4 <mbedtls_sha512_finish>
20027764:	2300      	movs	r3, #0
20027766:	461a      	mov	r2, r3
20027768:	f80d 2003 	strb.w	r2, [sp, r3]
2002776c:	3301      	adds	r3, #1
2002776e:	2bd8      	cmp	r3, #216	@ 0xd8
20027770:	d1fa      	bne.n	20027768 <mbedtls_sha512+0x88>
20027772:	b037      	add	sp, #220	@ 0xdc
20027774:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20027778:	ed9f 4b15 	vldr	d4, [pc, #84]	@ 200277d0 <mbedtls_sha512+0xf0>
2002777c:	f20f 0b90 	addw	fp, pc, #144	@ 0x90
20027780:	e9db ab00 	ldrd	sl, fp, [fp]
20027784:	f20f 0990 	addw	r9, pc, #144	@ 0x90
20027788:	e9d9 8900 	ldrd	r8, r9, [r9]
2002778c:	a124      	add	r1, pc, #144	@ (adr r1, 20027820 <mbedtls_sha512+0x140>)
2002778e:	e9d1 0100 	ldrd	r0, r1, [r1]
20027792:	a325      	add	r3, pc, #148	@ (adr r3, 20027828 <mbedtls_sha512+0x148>)
20027794:	e9d3 2300 	ldrd	r2, r3, [r3]
20027798:	ed9f 5b0f 	vldr	d5, [pc, #60]	@ 200277d8 <mbedtls_sha512+0xf8>
2002779c:	ed9f 6b10 	vldr	d6, [pc, #64]	@ 200277e0 <mbedtls_sha512+0x100>
200277a0:	ed9f 7b11 	vldr	d7, [pc, #68]	@ 200277e8 <mbedtls_sha512+0x108>
200277a4:	e7be      	b.n	20027724 <mbedtls_sha512+0x44>
200277a6:	bf00      	nop
200277a8:	c1059ed8 	.word	0xc1059ed8
200277ac:	cbbb9d5d 	.word	0xcbbb9d5d
200277b0:	367cd507 	.word	0x367cd507
200277b4:	629a292a 	.word	0x629a292a
200277b8:	3070dd17 	.word	0x3070dd17
200277bc:	9159015a 	.word	0x9159015a
200277c0:	f70e5939 	.word	0xf70e5939
200277c4:	152fecd8 	.word	0x152fecd8
	...
200277d0:	f3bcc908 	.word	0xf3bcc908
200277d4:	6a09e667 	.word	0x6a09e667
200277d8:	84caa73b 	.word	0x84caa73b
200277dc:	bb67ae85 	.word	0xbb67ae85
200277e0:	fe94f82b 	.word	0xfe94f82b
200277e4:	3c6ef372 	.word	0x3c6ef372
200277e8:	5f1d36f1 	.word	0x5f1d36f1
200277ec:	a54ff53a 	.word	0xa54ff53a
200277f0:	ffc00b31 	.word	0xffc00b31
200277f4:	67332667 	.word	0x67332667
200277f8:	68581511 	.word	0x68581511
200277fc:	8eb44a87 	.word	0x8eb44a87
20027800:	64f98fa7 	.word	0x64f98fa7
20027804:	db0c2e0d 	.word	0xdb0c2e0d
20027808:	befa4fa4 	.word	0xbefa4fa4
2002780c:	47b5481d 	.word	0x47b5481d
20027810:	ade682d1 	.word	0xade682d1
20027814:	510e527f 	.word	0x510e527f
20027818:	2b3e6c1f 	.word	0x2b3e6c1f
2002781c:	9b05688c 	.word	0x9b05688c
20027820:	fb41bd6b 	.word	0xfb41bd6b
20027824:	1f83d9ab 	.word	0x1f83d9ab
20027828:	137e2179 	.word	0x137e2179
2002782c:	5be0cd19 	.word	0x5be0cd19

20027830 <mbedtls_asn1_get_len>:
20027830:	b570      	push	{r4, r5, r6, lr}
20027832:	6803      	ldr	r3, [r0, #0]
20027834:	1acd      	subs	r5, r1, r3
20027836:	2d00      	cmp	r5, #0
20027838:	dc02      	bgt.n	20027840 <mbedtls_asn1_get_len+0x10>
2002783a:	f06f 005f 	mvn.w	r0, #95	@ 0x5f
2002783e:	bd70      	pop	{r4, r5, r6, pc}
20027840:	f993 6000 	ldrsb.w	r6, [r3]
20027844:	781c      	ldrb	r4, [r3, #0]
20027846:	2e00      	cmp	r6, #0
20027848:	db0a      	blt.n	20027860 <mbedtls_asn1_get_len+0x30>
2002784a:	1c5c      	adds	r4, r3, #1
2002784c:	6004      	str	r4, [r0, #0]
2002784e:	781b      	ldrb	r3, [r3, #0]
20027850:	6013      	str	r3, [r2, #0]
20027852:	6803      	ldr	r3, [r0, #0]
20027854:	1ac9      	subs	r1, r1, r3
20027856:	6813      	ldr	r3, [r2, #0]
20027858:	428b      	cmp	r3, r1
2002785a:	d8ee      	bhi.n	2002783a <mbedtls_asn1_get_len+0xa>
2002785c:	2000      	movs	r0, #0
2002785e:	e7ee      	b.n	2002783e <mbedtls_asn1_get_len+0xe>
20027860:	f004 047f 	and.w	r4, r4, #127	@ 0x7f
20027864:	3c01      	subs	r4, #1
20027866:	2c03      	cmp	r4, #3
20027868:	d82b      	bhi.n	200278c2 <mbedtls_asn1_get_len+0x92>
2002786a:	e8df f004 	tbb	[pc, r4]
2002786e:	0a02      	.short	0x0a02
20027870:	2114      	.short	0x2114
20027872:	2d01      	cmp	r5, #1
20027874:	d0e1      	beq.n	2002783a <mbedtls_asn1_get_len+0xa>
20027876:	785b      	ldrb	r3, [r3, #1]
20027878:	6013      	str	r3, [r2, #0]
2002787a:	6803      	ldr	r3, [r0, #0]
2002787c:	3302      	adds	r3, #2
2002787e:	6003      	str	r3, [r0, #0]
20027880:	e7e7      	b.n	20027852 <mbedtls_asn1_get_len+0x22>
20027882:	2d02      	cmp	r5, #2
20027884:	ddd9      	ble.n	2002783a <mbedtls_asn1_get_len+0xa>
20027886:	f8b3 3001 	ldrh.w	r3, [r3, #1]
2002788a:	ba5b      	rev16	r3, r3
2002788c:	b29b      	uxth	r3, r3
2002788e:	6013      	str	r3, [r2, #0]
20027890:	6803      	ldr	r3, [r0, #0]
20027892:	3303      	adds	r3, #3
20027894:	e7f3      	b.n	2002787e <mbedtls_asn1_get_len+0x4e>
20027896:	2d03      	cmp	r5, #3
20027898:	ddcf      	ble.n	2002783a <mbedtls_asn1_get_len+0xa>
2002789a:	789c      	ldrb	r4, [r3, #2]
2002789c:	785d      	ldrb	r5, [r3, #1]
2002789e:	0224      	lsls	r4, r4, #8
200278a0:	78db      	ldrb	r3, [r3, #3]
200278a2:	ea44 4405 	orr.w	r4, r4, r5, lsl #16
200278a6:	4323      	orrs	r3, r4
200278a8:	6013      	str	r3, [r2, #0]
200278aa:	6803      	ldr	r3, [r0, #0]
200278ac:	3304      	adds	r3, #4
200278ae:	e7e6      	b.n	2002787e <mbedtls_asn1_get_len+0x4e>
200278b0:	2d04      	cmp	r5, #4
200278b2:	ddc2      	ble.n	2002783a <mbedtls_asn1_get_len+0xa>
200278b4:	f8d3 3001 	ldr.w	r3, [r3, #1]
200278b8:	ba1b      	rev	r3, r3
200278ba:	6013      	str	r3, [r2, #0]
200278bc:	6803      	ldr	r3, [r0, #0]
200278be:	3305      	adds	r3, #5
200278c0:	e7dd      	b.n	2002787e <mbedtls_asn1_get_len+0x4e>
200278c2:	f06f 0063 	mvn.w	r0, #99	@ 0x63
200278c6:	e7ba      	b.n	2002783e <mbedtls_asn1_get_len+0xe>

200278c8 <mbedtls_asn1_get_tag>:
200278c8:	b470      	push	{r4, r5, r6}
200278ca:	6804      	ldr	r4, [r0, #0]
200278cc:	1b0e      	subs	r6, r1, r4
200278ce:	2e00      	cmp	r6, #0
200278d0:	dd07      	ble.n	200278e2 <mbedtls_asn1_get_tag+0x1a>
200278d2:	7826      	ldrb	r6, [r4, #0]
200278d4:	429e      	cmp	r6, r3
200278d6:	d108      	bne.n	200278ea <mbedtls_asn1_get_tag+0x22>
200278d8:	3401      	adds	r4, #1
200278da:	6004      	str	r4, [r0, #0]
200278dc:	bc70      	pop	{r4, r5, r6}
200278de:	f7ff bfa7 	b.w	20027830 <mbedtls_asn1_get_len>
200278e2:	f06f 005f 	mvn.w	r0, #95	@ 0x5f
200278e6:	bc70      	pop	{r4, r5, r6}
200278e8:	4770      	bx	lr
200278ea:	f06f 0061 	mvn.w	r0, #97	@ 0x61
200278ee:	e7fa      	b.n	200278e6 <mbedtls_asn1_get_tag+0x1e>

200278f0 <mbedtls_asn1_get_mpi>:
200278f0:	b573      	push	{r0, r1, r4, r5, r6, lr}
200278f2:	2302      	movs	r3, #2
200278f4:	4615      	mov	r5, r2
200278f6:	aa01      	add	r2, sp, #4
200278f8:	4604      	mov	r4, r0
200278fa:	f7ff ffe5 	bl	200278c8 <mbedtls_asn1_get_tag>
200278fe:	b940      	cbnz	r0, 20027912 <mbedtls_asn1_get_mpi+0x22>
20027900:	9e01      	ldr	r6, [sp, #4]
20027902:	4628      	mov	r0, r5
20027904:	4632      	mov	r2, r6
20027906:	6821      	ldr	r1, [r4, #0]
20027908:	f000 fad4 	bl	20027eb4 <mbedtls_mpi_read_binary>
2002790c:	6823      	ldr	r3, [r4, #0]
2002790e:	4433      	add	r3, r6
20027910:	6023      	str	r3, [r4, #0]
20027912:	b002      	add	sp, #8
20027914:	bd70      	pop	{r4, r5, r6, pc}

20027916 <mbedtls_asn1_get_bitstring_null>:
20027916:	b538      	push	{r3, r4, r5, lr}
20027918:	2303      	movs	r3, #3
2002791a:	4604      	mov	r4, r0
2002791c:	4615      	mov	r5, r2
2002791e:	f7ff ffd3 	bl	200278c8 <mbedtls_asn1_get_tag>
20027922:	b958      	cbnz	r0, 2002793c <mbedtls_asn1_get_bitstring_null+0x26>
20027924:	6813      	ldr	r3, [r2, #0]
20027926:	1e5a      	subs	r2, r3, #1
20027928:	2b01      	cmp	r3, #1
2002792a:	602a      	str	r2, [r5, #0]
2002792c:	d904      	bls.n	20027938 <mbedtls_asn1_get_bitstring_null+0x22>
2002792e:	6823      	ldr	r3, [r4, #0]
20027930:	1c5a      	adds	r2, r3, #1
20027932:	6022      	str	r2, [r4, #0]
20027934:	781b      	ldrb	r3, [r3, #0]
20027936:	b10b      	cbz	r3, 2002793c <mbedtls_asn1_get_bitstring_null+0x26>
20027938:	f06f 0067 	mvn.w	r0, #103	@ 0x67
2002793c:	bd38      	pop	{r3, r4, r5, pc}

2002793e <mbedtls_asn1_get_alg>:
2002793e:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
20027942:	4690      	mov	r8, r2
20027944:	461e      	mov	r6, r3
20027946:	aa01      	add	r2, sp, #4
20027948:	2330      	movs	r3, #48	@ 0x30
2002794a:	4605      	mov	r5, r0
2002794c:	460f      	mov	r7, r1
2002794e:	f7ff ffbb 	bl	200278c8 <mbedtls_asn1_get_tag>
20027952:	4604      	mov	r4, r0
20027954:	bb10      	cbnz	r0, 2002799c <mbedtls_asn1_get_alg+0x5e>
20027956:	682b      	ldr	r3, [r5, #0]
20027958:	1aff      	subs	r7, r7, r3
2002795a:	2f00      	cmp	r7, #0
2002795c:	dd38      	ble.n	200279d0 <mbedtls_asn1_get_alg+0x92>
2002795e:	4642      	mov	r2, r8
20027960:	781b      	ldrb	r3, [r3, #0]
20027962:	4628      	mov	r0, r5
20027964:	f842 3b04 	str.w	r3, [r2], #4
20027968:	682f      	ldr	r7, [r5, #0]
2002796a:	9b01      	ldr	r3, [sp, #4]
2002796c:	441f      	add	r7, r3
2002796e:	4639      	mov	r1, r7
20027970:	2306      	movs	r3, #6
20027972:	f7ff ffa9 	bl	200278c8 <mbedtls_asn1_get_tag>
20027976:	4604      	mov	r4, r0
20027978:	b980      	cbnz	r0, 2002799c <mbedtls_asn1_get_alg+0x5e>
2002797a:	682b      	ldr	r3, [r5, #0]
2002797c:	f8d8 2004 	ldr.w	r2, [r8, #4]
20027980:	f8c8 3008 	str.w	r3, [r8, #8]
20027984:	1899      	adds	r1, r3, r2
20027986:	42b9      	cmp	r1, r7
20027988:	6029      	str	r1, [r5, #0]
2002798a:	d10b      	bne.n	200279a4 <mbedtls_asn1_get_alg+0x66>
2002798c:	4601      	mov	r1, r0
2002798e:	f106 030c 	add.w	r3, r6, #12
20027992:	4632      	mov	r2, r6
20027994:	3601      	adds	r6, #1
20027996:	42b3      	cmp	r3, r6
20027998:	7011      	strb	r1, [r2, #0]
2002799a:	d1fa      	bne.n	20027992 <mbedtls_asn1_get_alg+0x54>
2002799c:	4620      	mov	r0, r4
2002799e:	b002      	add	sp, #8
200279a0:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
200279a4:	5c9b      	ldrb	r3, [r3, r2]
200279a6:	4632      	mov	r2, r6
200279a8:	f842 3b04 	str.w	r3, [r2], #4
200279ac:	682b      	ldr	r3, [r5, #0]
200279ae:	4639      	mov	r1, r7
200279b0:	3301      	adds	r3, #1
200279b2:	4628      	mov	r0, r5
200279b4:	602b      	str	r3, [r5, #0]
200279b6:	f7ff ff3b 	bl	20027830 <mbedtls_asn1_get_len>
200279ba:	b960      	cbnz	r0, 200279d6 <mbedtls_asn1_get_alg+0x98>
200279bc:	682b      	ldr	r3, [r5, #0]
200279be:	6872      	ldr	r2, [r6, #4]
200279c0:	60b3      	str	r3, [r6, #8]
200279c2:	4413      	add	r3, r2
200279c4:	42bb      	cmp	r3, r7
200279c6:	bf18      	it	ne
200279c8:	f06f 0465 	mvnne.w	r4, #101	@ 0x65
200279cc:	602b      	str	r3, [r5, #0]
200279ce:	e7e5      	b.n	2002799c <mbedtls_asn1_get_alg+0x5e>
200279d0:	f06f 045f 	mvn.w	r4, #95	@ 0x5f
200279d4:	e7e2      	b.n	2002799c <mbedtls_asn1_get_alg+0x5e>
200279d6:	4604      	mov	r4, r0
200279d8:	e7e0      	b.n	2002799c <mbedtls_asn1_get_alg+0x5e>

200279da <mpi_sub_hlp>:
200279da:	2300      	movs	r3, #0
200279dc:	b5f0      	push	{r4, r5, r6, r7, lr}
200279de:	461c      	mov	r4, r3
200279e0:	1f16      	subs	r6, r2, #4
200279e2:	4284      	cmp	r4, r0
200279e4:	d103      	bne.n	200279ee <mpi_sub_hlp+0x14>
200279e6:	eb02 0284 	add.w	r2, r2, r4, lsl #2
200279ea:	b9b3      	cbnz	r3, 20027a1a <mpi_sub_hlp+0x40>
200279ec:	bdf0      	pop	{r4, r5, r6, r7, pc}
200279ee:	f856 cf04 	ldr.w	ip, [r6, #4]!
200279f2:	ebac 0503 	sub.w	r5, ip, r3
200279f6:	6035      	str	r5, [r6, #0]
200279f8:	f851 7024 	ldr.w	r7, [r1, r4, lsl #2]
200279fc:	3401      	adds	r4, #1
200279fe:	42bd      	cmp	r5, r7
20027a00:	bf2c      	ite	cs
20027a02:	f04f 0e00 	movcs.w	lr, #0
20027a06:	f04f 0e01 	movcc.w	lr, #1
20027a0a:	1bed      	subs	r5, r5, r7
20027a0c:	459c      	cmp	ip, r3
20027a0e:	bf2c      	ite	cs
20027a10:	4673      	movcs	r3, lr
20027a12:	f10e 0301 	addcc.w	r3, lr, #1
20027a16:	6035      	str	r5, [r6, #0]
20027a18:	e7e3      	b.n	200279e2 <mpi_sub_hlp+0x8>
20027a1a:	6811      	ldr	r1, [r2, #0]
20027a1c:	1ac8      	subs	r0, r1, r3
20027a1e:	4299      	cmp	r1, r3
20027a20:	bf2c      	ite	cs
20027a22:	2300      	movcs	r3, #0
20027a24:	2301      	movcc	r3, #1
20027a26:	f842 0b04 	str.w	r0, [r2], #4
20027a2a:	e7de      	b.n	200279ea <mpi_sub_hlp+0x10>

20027a2c <mpi_mul_hlp>:
20027a2c:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20027a30:	4694      	mov	ip, r2
20027a32:	460e      	mov	r6, r1
20027a34:	4686      	mov	lr, r0
20027a36:	2500      	movs	r5, #0
20027a38:	f102 0440 	add.w	r4, r2, #64	@ 0x40
20027a3c:	f1be 0f0f 	cmp.w	lr, #15
20027a40:	f854 7c40 	ldr.w	r7, [r4, #-64]
20027a44:	f106 0640 	add.w	r6, r6, #64	@ 0x40
20027a48:	f104 0440 	add.w	r4, r4, #64	@ 0x40
20027a4c:	d87c      	bhi.n	20027b48 <mpi_mul_hlp+0x11c>
20027a4e:	f06f 080f 	mvn.w	r8, #15
20027a52:	0902      	lsrs	r2, r0, #4
20027a54:	fb08 0002 	mla	r0, r8, r2, r0
20027a58:	2807      	cmp	r0, #7
20027a5a:	ea4f 1e82 	mov.w	lr, r2, lsl #6
20027a5e:	eb0c 1482 	add.w	r4, ip, r2, lsl #6
20027a62:	eb01 1682 	add.w	r6, r1, r2, lsl #6
20027a66:	d95b      	bls.n	20027b20 <mpi_mul_hlp+0xf4>
20027a68:	f851 100e 	ldr.w	r1, [r1, lr]
20027a6c:	3808      	subs	r0, #8
20027a6e:	fba1 1203 	umull	r1, r2, r1, r3
20027a72:	1869      	adds	r1, r5, r1
20027a74:	f142 0200 	adc.w	r2, r2, #0
20027a78:	187f      	adds	r7, r7, r1
20027a7a:	f84c 700e 	str.w	r7, [ip, lr]
20027a7e:	6871      	ldr	r1, [r6, #4]
20027a80:	f142 0200 	adc.w	r2, r2, #0
20027a84:	fba1 5103 	umull	r5, r1, r1, r3
20027a88:	1952      	adds	r2, r2, r5
20027a8a:	6865      	ldr	r5, [r4, #4]
20027a8c:	f141 0100 	adc.w	r1, r1, #0
20027a90:	1952      	adds	r2, r2, r5
20027a92:	6062      	str	r2, [r4, #4]
20027a94:	68b2      	ldr	r2, [r6, #8]
20027a96:	f141 0100 	adc.w	r1, r1, #0
20027a9a:	fba2 5203 	umull	r5, r2, r2, r3
20027a9e:	1949      	adds	r1, r1, r5
20027aa0:	68a5      	ldr	r5, [r4, #8]
20027aa2:	f142 0200 	adc.w	r2, r2, #0
20027aa6:	1949      	adds	r1, r1, r5
20027aa8:	60a1      	str	r1, [r4, #8]
20027aaa:	68f1      	ldr	r1, [r6, #12]
20027aac:	f142 0200 	adc.w	r2, r2, #0
20027ab0:	fba1 5103 	umull	r5, r1, r1, r3
20027ab4:	1952      	adds	r2, r2, r5
20027ab6:	68e5      	ldr	r5, [r4, #12]
20027ab8:	f141 0100 	adc.w	r1, r1, #0
20027abc:	1952      	adds	r2, r2, r5
20027abe:	60e2      	str	r2, [r4, #12]
20027ac0:	6932      	ldr	r2, [r6, #16]
20027ac2:	f141 0100 	adc.w	r1, r1, #0
20027ac6:	fba2 5203 	umull	r5, r2, r2, r3
20027aca:	1949      	adds	r1, r1, r5
20027acc:	6925      	ldr	r5, [r4, #16]
20027ace:	f142 0200 	adc.w	r2, r2, #0
20027ad2:	1949      	adds	r1, r1, r5
20027ad4:	6121      	str	r1, [r4, #16]
20027ad6:	6971      	ldr	r1, [r6, #20]
20027ad8:	f142 0200 	adc.w	r2, r2, #0
20027adc:	fba1 5103 	umull	r5, r1, r1, r3
20027ae0:	1952      	adds	r2, r2, r5
20027ae2:	6965      	ldr	r5, [r4, #20]
20027ae4:	f141 0100 	adc.w	r1, r1, #0
20027ae8:	1952      	adds	r2, r2, r5
20027aea:	6162      	str	r2, [r4, #20]
20027aec:	69b2      	ldr	r2, [r6, #24]
20027aee:	f141 0100 	adc.w	r1, r1, #0
20027af2:	fba2 5203 	umull	r5, r2, r2, r3
20027af6:	1949      	adds	r1, r1, r5
20027af8:	69a5      	ldr	r5, [r4, #24]
20027afa:	f142 0200 	adc.w	r2, r2, #0
20027afe:	1949      	adds	r1, r1, r5
20027b00:	61a1      	str	r1, [r4, #24]
20027b02:	69f1      	ldr	r1, [r6, #28]
20027b04:	f142 0200 	adc.w	r2, r2, #0
20027b08:	fba1 1503 	umull	r1, r5, r1, r3
20027b0c:	1852      	adds	r2, r2, r1
20027b0e:	69e1      	ldr	r1, [r4, #28]
20027b10:	f145 0500 	adc.w	r5, r5, #0
20027b14:	1852      	adds	r2, r2, r1
20027b16:	61e2      	str	r2, [r4, #28]
20027b18:	f145 0500 	adc.w	r5, r5, #0
20027b1c:	3420      	adds	r4, #32
20027b1e:	3620      	adds	r6, #32
20027b20:	4627      	mov	r7, r4
20027b22:	ea4f 0c80 	mov.w	ip, r0, lsl #2
20027b26:	eb06 0080 	add.w	r0, r6, r0, lsl #2
20027b2a:	42b0      	cmp	r0, r6
20027b2c:	f857 1b04 	ldr.w	r1, [r7], #4
20027b30:	f040 80eb 	bne.w	20027d0a <mpi_mul_hlp+0x2de>
20027b34:	4464      	add	r4, ip
20027b36:	6823      	ldr	r3, [r4, #0]
20027b38:	195b      	adds	r3, r3, r5
20027b3a:	f844 3b04 	str.w	r3, [r4], #4
20027b3e:	f04f 0501 	mov.w	r5, #1
20027b42:	d2f8      	bcs.n	20027b36 <mpi_mul_hlp+0x10a>
20027b44:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20027b48:	f856 2c40 	ldr.w	r2, [r6, #-64]
20027b4c:	f1ae 0e10 	sub.w	lr, lr, #16
20027b50:	fba2 2803 	umull	r2, r8, r2, r3
20027b54:	18aa      	adds	r2, r5, r2
20027b56:	f148 0500 	adc.w	r5, r8, #0
20027b5a:	18ba      	adds	r2, r7, r2
20027b5c:	f844 2c80 	str.w	r2, [r4, #-128]
20027b60:	f856 2c3c 	ldr.w	r2, [r6, #-60]
20027b64:	f145 0500 	adc.w	r5, r5, #0
20027b68:	fba2 7203 	umull	r7, r2, r2, r3
20027b6c:	19ef      	adds	r7, r5, r7
20027b6e:	f854 5c7c 	ldr.w	r5, [r4, #-124]
20027b72:	f142 0200 	adc.w	r2, r2, #0
20027b76:	19ed      	adds	r5, r5, r7
20027b78:	f844 5c7c 	str.w	r5, [r4, #-124]
20027b7c:	f856 5c38 	ldr.w	r5, [r6, #-56]
20027b80:	f142 0200 	adc.w	r2, r2, #0
20027b84:	fba5 7503 	umull	r7, r5, r5, r3
20027b88:	19d7      	adds	r7, r2, r7
20027b8a:	f854 2c78 	ldr.w	r2, [r4, #-120]
20027b8e:	f145 0500 	adc.w	r5, r5, #0
20027b92:	19d2      	adds	r2, r2, r7
20027b94:	f844 2c78 	str.w	r2, [r4, #-120]
20027b98:	f856 2c34 	ldr.w	r2, [r6, #-52]
20027b9c:	f145 0500 	adc.w	r5, r5, #0
20027ba0:	fba2 7203 	umull	r7, r2, r2, r3
20027ba4:	19ef      	adds	r7, r5, r7
20027ba6:	f854 5c74 	ldr.w	r5, [r4, #-116]
20027baa:	f142 0200 	adc.w	r2, r2, #0
20027bae:	19ed      	adds	r5, r5, r7
20027bb0:	f844 5c74 	str.w	r5, [r4, #-116]
20027bb4:	f856 5c30 	ldr.w	r5, [r6, #-48]
20027bb8:	f142 0200 	adc.w	r2, r2, #0
20027bbc:	fba5 7503 	umull	r7, r5, r5, r3
20027bc0:	19d7      	adds	r7, r2, r7
20027bc2:	f854 2c70 	ldr.w	r2, [r4, #-112]
20027bc6:	f145 0500 	adc.w	r5, r5, #0
20027bca:	19d2      	adds	r2, r2, r7
20027bcc:	f844 2c70 	str.w	r2, [r4, #-112]
20027bd0:	f856 2c2c 	ldr.w	r2, [r6, #-44]
20027bd4:	f145 0500 	adc.w	r5, r5, #0
20027bd8:	fba2 7203 	umull	r7, r2, r2, r3
20027bdc:	19ef      	adds	r7, r5, r7
20027bde:	f854 5c6c 	ldr.w	r5, [r4, #-108]
20027be2:	f142 0200 	adc.w	r2, r2, #0
20027be6:	19ed      	adds	r5, r5, r7
20027be8:	f844 5c6c 	str.w	r5, [r4, #-108]
20027bec:	f856 5c28 	ldr.w	r5, [r6, #-40]
20027bf0:	f142 0200 	adc.w	r2, r2, #0
20027bf4:	fba5 7503 	umull	r7, r5, r5, r3
20027bf8:	19d7      	adds	r7, r2, r7
20027bfa:	f854 2c68 	ldr.w	r2, [r4, #-104]
20027bfe:	f145 0500 	adc.w	r5, r5, #0
20027c02:	19d2      	adds	r2, r2, r7
20027c04:	f844 2c68 	str.w	r2, [r4, #-104]
20027c08:	f856 2c24 	ldr.w	r2, [r6, #-36]
20027c0c:	f145 0500 	adc.w	r5, r5, #0
20027c10:	fba2 7203 	umull	r7, r2, r2, r3
20027c14:	19ef      	adds	r7, r5, r7
20027c16:	f854 5c64 	ldr.w	r5, [r4, #-100]
20027c1a:	f142 0200 	adc.w	r2, r2, #0
20027c1e:	19ed      	adds	r5, r5, r7
20027c20:	f844 5c64 	str.w	r5, [r4, #-100]
20027c24:	f856 5c20 	ldr.w	r5, [r6, #-32]
20027c28:	f142 0200 	adc.w	r2, r2, #0
20027c2c:	fba5 7503 	umull	r7, r5, r5, r3
20027c30:	19d7      	adds	r7, r2, r7
20027c32:	f854 2c60 	ldr.w	r2, [r4, #-96]
20027c36:	f145 0500 	adc.w	r5, r5, #0
20027c3a:	19d2      	adds	r2, r2, r7
20027c3c:	f844 2c60 	str.w	r2, [r4, #-96]
20027c40:	f856 2c1c 	ldr.w	r2, [r6, #-28]
20027c44:	f145 0500 	adc.w	r5, r5, #0
20027c48:	fba2 7203 	umull	r7, r2, r2, r3
20027c4c:	19ef      	adds	r7, r5, r7
20027c4e:	f854 5c5c 	ldr.w	r5, [r4, #-92]
20027c52:	f142 0200 	adc.w	r2, r2, #0
20027c56:	19ed      	adds	r5, r5, r7
20027c58:	f844 5c5c 	str.w	r5, [r4, #-92]
20027c5c:	f856 5c18 	ldr.w	r5, [r6, #-24]
20027c60:	f142 0200 	adc.w	r2, r2, #0
20027c64:	fba5 7503 	umull	r7, r5, r5, r3
20027c68:	19d7      	adds	r7, r2, r7
20027c6a:	f854 2c58 	ldr.w	r2, [r4, #-88]
20027c6e:	f145 0500 	adc.w	r5, r5, #0
20027c72:	19d2      	adds	r2, r2, r7
20027c74:	f844 2c58 	str.w	r2, [r4, #-88]
20027c78:	f856 2c14 	ldr.w	r2, [r6, #-20]
20027c7c:	f145 0500 	adc.w	r5, r5, #0
20027c80:	fba2 7203 	umull	r7, r2, r2, r3
20027c84:	19ef      	adds	r7, r5, r7
20027c86:	f854 5c54 	ldr.w	r5, [r4, #-84]
20027c8a:	f142 0200 	adc.w	r2, r2, #0
20027c8e:	19ed      	adds	r5, r5, r7
20027c90:	f844 5c54 	str.w	r5, [r4, #-84]
20027c94:	f856 5c10 	ldr.w	r5, [r6, #-16]
20027c98:	f142 0200 	adc.w	r2, r2, #0
20027c9c:	fba5 7503 	umull	r7, r5, r5, r3
20027ca0:	19d7      	adds	r7, r2, r7
20027ca2:	f854 2c50 	ldr.w	r2, [r4, #-80]
20027ca6:	f145 0500 	adc.w	r5, r5, #0
20027caa:	19d2      	adds	r2, r2, r7
20027cac:	f844 2c50 	str.w	r2, [r4, #-80]
20027cb0:	f856 2c0c 	ldr.w	r2, [r6, #-12]
20027cb4:	f145 0500 	adc.w	r5, r5, #0
20027cb8:	fba2 7203 	umull	r7, r2, r2, r3
20027cbc:	19ef      	adds	r7, r5, r7
20027cbe:	f854 5c4c 	ldr.w	r5, [r4, #-76]
20027cc2:	f142 0200 	adc.w	r2, r2, #0
20027cc6:	19ed      	adds	r5, r5, r7
20027cc8:	f844 5c4c 	str.w	r5, [r4, #-76]
20027ccc:	f856 5c08 	ldr.w	r5, [r6, #-8]
20027cd0:	f142 0200 	adc.w	r2, r2, #0
20027cd4:	fba5 5703 	umull	r5, r7, r5, r3
20027cd8:	1955      	adds	r5, r2, r5
20027cda:	f854 2c48 	ldr.w	r2, [r4, #-72]
20027cde:	f147 0700 	adc.w	r7, r7, #0
20027ce2:	1952      	adds	r2, r2, r5
20027ce4:	f844 2c48 	str.w	r2, [r4, #-72]
20027ce8:	f856 2c04 	ldr.w	r2, [r6, #-4]
20027cec:	f147 0700 	adc.w	r7, r7, #0
20027cf0:	fba2 2503 	umull	r2, r5, r2, r3
20027cf4:	18bf      	adds	r7, r7, r2
20027cf6:	f854 2c44 	ldr.w	r2, [r4, #-68]
20027cfa:	f145 0500 	adc.w	r5, r5, #0
20027cfe:	19d2      	adds	r2, r2, r7
20027d00:	f145 0500 	adc.w	r5, r5, #0
20027d04:	f844 2c44 	str.w	r2, [r4, #-68]
20027d08:	e698      	b.n	20027a3c <mpi_mul_hlp+0x10>
20027d0a:	f856 2b04 	ldr.w	r2, [r6], #4
20027d0e:	fba2 2e03 	umull	r2, lr, r2, r3
20027d12:	18aa      	adds	r2, r5, r2
20027d14:	f14e 0500 	adc.w	r5, lr, #0
20027d18:	1889      	adds	r1, r1, r2
20027d1a:	f145 0500 	adc.w	r5, r5, #0
20027d1e:	f847 1c04 	str.w	r1, [r7, #-4]
20027d22:	e702      	b.n	20027b2a <mpi_mul_hlp+0xfe>

20027d24 <mbedtls_mpi_init>:
20027d24:	b120      	cbz	r0, 20027d30 <mbedtls_mpi_init+0xc>
20027d26:	2300      	movs	r3, #0
20027d28:	2201      	movs	r2, #1
20027d2a:	e9c0 2300 	strd	r2, r3, [r0]
20027d2e:	6083      	str	r3, [r0, #8]
20027d30:	4770      	bx	lr

20027d32 <mbedtls_mpi_free>:
20027d32:	b510      	push	{r4, lr}
20027d34:	4604      	mov	r4, r0
20027d36:	b168      	cbz	r0, 20027d54 <mbedtls_mpi_free+0x22>
20027d38:	6883      	ldr	r3, [r0, #8]
20027d3a:	b133      	cbz	r3, 20027d4a <mbedtls_mpi_free+0x18>
20027d3c:	2100      	movs	r1, #0
20027d3e:	6842      	ldr	r2, [r0, #4]
20027d40:	3a01      	subs	r2, #1
20027d42:	d208      	bcs.n	20027d56 <mbedtls_mpi_free+0x24>
20027d44:	68a0      	ldr	r0, [r4, #8]
20027d46:	f002 fcbf 	bl	2002a6c8 <free>
20027d4a:	2300      	movs	r3, #0
20027d4c:	2201      	movs	r2, #1
20027d4e:	e9c4 2300 	strd	r2, r3, [r4]
20027d52:	60a3      	str	r3, [r4, #8]
20027d54:	bd10      	pop	{r4, pc}
20027d56:	f843 1b04 	str.w	r1, [r3], #4
20027d5a:	e7f1      	b.n	20027d40 <mbedtls_mpi_free+0xe>

20027d5c <mbedtls_mpi_grow>:
20027d5c:	f242 7310 	movw	r3, #10000	@ 0x2710
20027d60:	4299      	cmp	r1, r3
20027d62:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20027d66:	4605      	mov	r5, r0
20027d68:	460f      	mov	r7, r1
20027d6a:	d903      	bls.n	20027d74 <mbedtls_mpi_grow+0x18>
20027d6c:	f06f 000f 	mvn.w	r0, #15
20027d70:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20027d74:	6846      	ldr	r6, [r0, #4]
20027d76:	428e      	cmp	r6, r1
20027d78:	d301      	bcc.n	20027d7e <mbedtls_mpi_grow+0x22>
20027d7a:	2000      	movs	r0, #0
20027d7c:	e7f8      	b.n	20027d70 <mbedtls_mpi_grow+0x14>
20027d7e:	2104      	movs	r1, #4
20027d80:	4638      	mov	r0, r7
20027d82:	f002 fc85 	bl	2002a690 <calloc>
20027d86:	4680      	mov	r8, r0
20027d88:	2800      	cmp	r0, #0
20027d8a:	d0ef      	beq.n	20027d6c <mbedtls_mpi_grow+0x10>
20027d8c:	68ac      	ldr	r4, [r5, #8]
20027d8e:	b15c      	cbz	r4, 20027da8 <mbedtls_mpi_grow+0x4c>
20027d90:	00b6      	lsls	r6, r6, #2
20027d92:	4632      	mov	r2, r6
20027d94:	4621      	mov	r1, r4
20027d96:	f002 fd77 	bl	2002a888 <memcpy>
20027d9a:	2300      	movs	r3, #0
20027d9c:	4426      	add	r6, r4
20027d9e:	42b4      	cmp	r4, r6
20027da0:	d105      	bne.n	20027dae <mbedtls_mpi_grow+0x52>
20027da2:	68a8      	ldr	r0, [r5, #8]
20027da4:	f002 fc90 	bl	2002a6c8 <free>
20027da8:	e9c5 7801 	strd	r7, r8, [r5, #4]
20027dac:	e7e5      	b.n	20027d7a <mbedtls_mpi_grow+0x1e>
20027dae:	f844 3b04 	str.w	r3, [r4], #4
20027db2:	e7f4      	b.n	20027d9e <mbedtls_mpi_grow+0x42>

20027db4 <mbedtls_mpi_copy>:
20027db4:	4288      	cmp	r0, r1
20027db6:	b570      	push	{r4, r5, r6, lr}
20027db8:	4605      	mov	r5, r0
20027dba:	460e      	mov	r6, r1
20027dbc:	d003      	beq.n	20027dc6 <mbedtls_mpi_copy+0x12>
20027dbe:	688b      	ldr	r3, [r1, #8]
20027dc0:	b91b      	cbnz	r3, 20027dca <mbedtls_mpi_copy+0x16>
20027dc2:	f7ff ffb6 	bl	20027d32 <mbedtls_mpi_free>
20027dc6:	2000      	movs	r0, #0
20027dc8:	bd70      	pop	{r4, r5, r6, pc}
20027dca:	684a      	ldr	r2, [r1, #4]
20027dcc:	3a01      	subs	r2, #1
20027dce:	b11a      	cbz	r2, 20027dd8 <mbedtls_mpi_copy+0x24>
20027dd0:	f853 1022 	ldr.w	r1, [r3, r2, lsl #2]
20027dd4:	2900      	cmp	r1, #0
20027dd6:	d0f9      	beq.n	20027dcc <mbedtls_mpi_copy+0x18>
20027dd8:	6833      	ldr	r3, [r6, #0]
20027dda:	1c54      	adds	r4, r2, #1
20027ddc:	4621      	mov	r1, r4
20027dde:	4628      	mov	r0, r5
20027de0:	602b      	str	r3, [r5, #0]
20027de2:	f7ff ffbb 	bl	20027d5c <mbedtls_mpi_grow>
20027de6:	4601      	mov	r1, r0
20027de8:	b950      	cbnz	r0, 20027e00 <mbedtls_mpi_copy+0x4c>
20027dea:	686a      	ldr	r2, [r5, #4]
20027dec:	68a8      	ldr	r0, [r5, #8]
20027dee:	0092      	lsls	r2, r2, #2
20027df0:	f002 fd30 	bl	2002a854 <memset>
20027df4:	68b1      	ldr	r1, [r6, #8]
20027df6:	68a8      	ldr	r0, [r5, #8]
20027df8:	00a2      	lsls	r2, r4, #2
20027dfa:	f002 fd45 	bl	2002a888 <memcpy>
20027dfe:	e7e2      	b.n	20027dc6 <mbedtls_mpi_copy+0x12>
20027e00:	f06f 000f 	mvn.w	r0, #15
20027e04:	e7e0      	b.n	20027dc8 <mbedtls_mpi_copy+0x14>

20027e06 <mbedtls_mpi_lset>:
20027e06:	b570      	push	{r4, r5, r6, lr}
20027e08:	460e      	mov	r6, r1
20027e0a:	2101      	movs	r1, #1
20027e0c:	4604      	mov	r4, r0
20027e0e:	f7ff ffa5 	bl	20027d5c <mbedtls_mpi_grow>
20027e12:	4605      	mov	r5, r0
20027e14:	b988      	cbnz	r0, 20027e3a <mbedtls_mpi_lset+0x34>
20027e16:	6862      	ldr	r2, [r4, #4]
20027e18:	4601      	mov	r1, r0
20027e1a:	0092      	lsls	r2, r2, #2
20027e1c:	68a0      	ldr	r0, [r4, #8]
20027e1e:	f002 fd19 	bl	2002a854 <memset>
20027e22:	68a3      	ldr	r3, [r4, #8]
20027e24:	ea86 72e6 	eor.w	r2, r6, r6, asr #31
20027e28:	2e00      	cmp	r6, #0
20027e2a:	eba2 72e6 	sub.w	r2, r2, r6, asr #31
20027e2e:	601a      	str	r2, [r3, #0]
20027e30:	bfac      	ite	ge
20027e32:	2301      	movge	r3, #1
20027e34:	f04f 33ff 	movlt.w	r3, #4294967295
20027e38:	6023      	str	r3, [r4, #0]
20027e3a:	4628      	mov	r0, r5
20027e3c:	bd70      	pop	{r4, r5, r6, pc}

20027e3e <mbedtls_mpi_lsb>:
20027e3e:	2300      	movs	r3, #0
20027e40:	4619      	mov	r1, r3
20027e42:	b570      	push	{r4, r5, r6, lr}
20027e44:	6844      	ldr	r4, [r0, #4]
20027e46:	428c      	cmp	r4, r1
20027e48:	d101      	bne.n	20027e4e <mbedtls_mpi_lsb+0x10>
20027e4a:	2000      	movs	r0, #0
20027e4c:	e008      	b.n	20027e60 <mbedtls_mpi_lsb+0x22>
20027e4e:	6882      	ldr	r2, [r0, #8]
20027e50:	f852 5021 	ldr.w	r5, [r2, r1, lsl #2]
20027e54:	2200      	movs	r2, #0
20027e56:	fa25 f602 	lsr.w	r6, r5, r2
20027e5a:	07f6      	lsls	r6, r6, #31
20027e5c:	d501      	bpl.n	20027e62 <mbedtls_mpi_lsb+0x24>
20027e5e:	1898      	adds	r0, r3, r2
20027e60:	bd70      	pop	{r4, r5, r6, pc}
20027e62:	3201      	adds	r2, #1
20027e64:	2a20      	cmp	r2, #32
20027e66:	d1f6      	bne.n	20027e56 <mbedtls_mpi_lsb+0x18>
20027e68:	3320      	adds	r3, #32
20027e6a:	3101      	adds	r1, #1
20027e6c:	e7eb      	b.n	20027e46 <mbedtls_mpi_lsb+0x8>

20027e6e <mbedtls_mpi_bitlen>:
20027e6e:	4602      	mov	r2, r0
20027e70:	6840      	ldr	r0, [r0, #4]
20027e72:	b188      	cbz	r0, 20027e98 <mbedtls_mpi_bitlen+0x2a>
20027e74:	6891      	ldr	r1, [r2, #8]
20027e76:	1e43      	subs	r3, r0, #1
20027e78:	b97b      	cbnz	r3, 20027e9a <mbedtls_mpi_bitlen+0x2c>
20027e7a:	461a      	mov	r2, r3
20027e7c:	5889      	ldr	r1, [r1, r2]
20027e7e:	2000      	movs	r0, #0
20027e80:	f04f 4200 	mov.w	r2, #2147483648	@ 0x80000000
20027e84:	4211      	tst	r1, r2
20027e86:	d104      	bne.n	20027e92 <mbedtls_mpi_bitlen+0x24>
20027e88:	3001      	adds	r0, #1
20027e8a:	2820      	cmp	r0, #32
20027e8c:	ea4f 0252 	mov.w	r2, r2, lsr #1
20027e90:	d1f8      	bne.n	20027e84 <mbedtls_mpi_bitlen+0x16>
20027e92:	3301      	adds	r3, #1
20027e94:	ebc0 1043 	rsb	r0, r0, r3, lsl #5
20027e98:	4770      	bx	lr
20027e9a:	f851 0023 	ldr.w	r0, [r1, r3, lsl #2]
20027e9e:	009a      	lsls	r2, r3, #2
20027ea0:	2800      	cmp	r0, #0
20027ea2:	d1eb      	bne.n	20027e7c <mbedtls_mpi_bitlen+0xe>
20027ea4:	3b01      	subs	r3, #1
20027ea6:	e7e7      	b.n	20027e78 <mbedtls_mpi_bitlen+0xa>

20027ea8 <mbedtls_mpi_size>:
20027ea8:	b508      	push	{r3, lr}
20027eaa:	f7ff ffe0 	bl	20027e6e <mbedtls_mpi_bitlen>
20027eae:	3007      	adds	r0, #7
20027eb0:	08c0      	lsrs	r0, r0, #3
20027eb2:	bd08      	pop	{r3, pc}

20027eb4 <mbedtls_mpi_read_binary>:
20027eb4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20027eb6:	4607      	mov	r7, r0
20027eb8:	460c      	mov	r4, r1
20027eba:	4616      	mov	r6, r2
20027ebc:	2500      	movs	r5, #0
20027ebe:	42b5      	cmp	r5, r6
20027ec0:	d001      	beq.n	20027ec6 <mbedtls_mpi_read_binary+0x12>
20027ec2:	5d63      	ldrb	r3, [r4, r5]
20027ec4:	b173      	cbz	r3, 20027ee4 <mbedtls_mpi_read_binary+0x30>
20027ec6:	1b71      	subs	r1, r6, r5
20027ec8:	f011 0303 	ands.w	r3, r1, #3
20027ecc:	bf18      	it	ne
20027ece:	2301      	movne	r3, #1
20027ed0:	4638      	mov	r0, r7
20027ed2:	eb03 0191 	add.w	r1, r3, r1, lsr #2
20027ed6:	f7ff ff41 	bl	20027d5c <mbedtls_mpi_grow>
20027eda:	4601      	mov	r1, r0
20027edc:	b120      	cbz	r0, 20027ee8 <mbedtls_mpi_read_binary+0x34>
20027ede:	f06f 000f 	mvn.w	r0, #15
20027ee2:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20027ee4:	3501      	adds	r5, #1
20027ee6:	e7ea      	b.n	20027ebe <mbedtls_mpi_read_binary+0xa>
20027ee8:	4638      	mov	r0, r7
20027eea:	f7ff ff8c 	bl	20027e06 <mbedtls_mpi_lset>
20027eee:	2800      	cmp	r0, #0
20027ef0:	d1f5      	bne.n	20027ede <mbedtls_mpi_read_binary+0x2a>
20027ef2:	4603      	mov	r3, r0
20027ef4:	4434      	add	r4, r6
20027ef6:	1af2      	subs	r2, r6, r3
20027ef8:	4295      	cmp	r5, r2
20027efa:	d2f2      	bcs.n	20027ee2 <mbedtls_mpi_read_binary+0x2e>
20027efc:	f8d7 e008 	ldr.w	lr, [r7, #8]
20027f00:	f814 1d01 	ldrb.w	r1, [r4, #-1]!
20027f04:	00da      	lsls	r2, r3, #3
20027f06:	f023 0c03 	bic.w	ip, r3, #3
20027f0a:	f002 0218 	and.w	r2, r2, #24
20027f0e:	4091      	lsls	r1, r2
20027f10:	f85e 200c 	ldr.w	r2, [lr, ip]
20027f14:	3301      	adds	r3, #1
20027f16:	430a      	orrs	r2, r1
20027f18:	f84e 200c 	str.w	r2, [lr, ip]
20027f1c:	e7eb      	b.n	20027ef6 <mbedtls_mpi_read_binary+0x42>

20027f1e <mbedtls_mpi_write_binary>:
20027f1e:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20027f20:	4615      	mov	r5, r2
20027f22:	4607      	mov	r7, r0
20027f24:	460c      	mov	r4, r1
20027f26:	f7ff ffbf 	bl	20027ea8 <mbedtls_mpi_size>
20027f2a:	42a8      	cmp	r0, r5
20027f2c:	4606      	mov	r6, r0
20027f2e:	d816      	bhi.n	20027f5e <mbedtls_mpi_write_binary+0x40>
20027f30:	4620      	mov	r0, r4
20027f32:	462a      	mov	r2, r5
20027f34:	2100      	movs	r1, #0
20027f36:	f002 fc8d 	bl	2002a854 <memset>
20027f3a:	2300      	movs	r3, #0
20027f3c:	442c      	add	r4, r5
20027f3e:	42b3      	cmp	r3, r6
20027f40:	d101      	bne.n	20027f46 <mbedtls_mpi_write_binary+0x28>
20027f42:	2000      	movs	r0, #0
20027f44:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20027f46:	68b8      	ldr	r0, [r7, #8]
20027f48:	f023 0203 	bic.w	r2, r3, #3
20027f4c:	5882      	ldr	r2, [r0, r2]
20027f4e:	00d9      	lsls	r1, r3, #3
20027f50:	f001 0118 	and.w	r1, r1, #24
20027f54:	40ca      	lsrs	r2, r1
20027f56:	f804 2d01 	strb.w	r2, [r4, #-1]!
20027f5a:	3301      	adds	r3, #1
20027f5c:	e7ef      	b.n	20027f3e <mbedtls_mpi_write_binary+0x20>
20027f5e:	f06f 0007 	mvn.w	r0, #7
20027f62:	e7ef      	b.n	20027f44 <mbedtls_mpi_write_binary+0x26>

20027f64 <mbedtls_mpi_shift_l>:
20027f64:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
20027f66:	4605      	mov	r5, r0
20027f68:	460e      	mov	r6, r1
20027f6a:	094c      	lsrs	r4, r1, #5
20027f6c:	f001 071f 	and.w	r7, r1, #31
20027f70:	f7ff ff7d 	bl	20027e6e <mbedtls_mpi_bitlen>
20027f74:	686b      	ldr	r3, [r5, #4]
20027f76:	4430      	add	r0, r6
20027f78:	ebb0 1f43 	cmp.w	r0, r3, lsl #5
20027f7c:	d805      	bhi.n	20027f8a <mbedtls_mpi_shift_l+0x26>
20027f7e:	2e1f      	cmp	r6, #31
20027f80:	d811      	bhi.n	20027fa6 <mbedtls_mpi_shift_l+0x42>
20027f82:	2f00      	cmp	r7, #0
20027f84:	d143      	bne.n	2002800e <mbedtls_mpi_shift_l+0xaa>
20027f86:	2000      	movs	r0, #0
20027f88:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20027f8a:	f010 011f 	ands.w	r1, r0, #31
20027f8e:	bf18      	it	ne
20027f90:	2101      	movne	r1, #1
20027f92:	eb01 1150 	add.w	r1, r1, r0, lsr #5
20027f96:	4628      	mov	r0, r5
20027f98:	f7ff fee0 	bl	20027d5c <mbedtls_mpi_grow>
20027f9c:	2800      	cmp	r0, #0
20027f9e:	d0ee      	beq.n	20027f7e <mbedtls_mpi_shift_l+0x1a>
20027fa0:	f06f 000f 	mvn.w	r0, #15
20027fa4:	e7f0      	b.n	20027f88 <mbedtls_mpi_shift_l+0x24>
20027fa6:	f06f 0003 	mvn.w	r0, #3
20027faa:	686a      	ldr	r2, [r5, #4]
20027fac:	4360      	muls	r0, r4
20027fae:	4611      	mov	r1, r2
20027fb0:	0093      	lsls	r3, r2, #2
20027fb2:	42a1      	cmp	r1, r4
20027fb4:	f1a3 0304 	sub.w	r3, r3, #4
20027fb8:	d80c      	bhi.n	20027fd4 <mbedtls_mpi_shift_l+0x70>
20027fba:	1aa3      	subs	r3, r4, r2
20027fbc:	4294      	cmp	r4, r2
20027fbe:	bf88      	it	hi
20027fc0:	2300      	movhi	r3, #0
20027fc2:	4413      	add	r3, r2
20027fc4:	2200      	movs	r2, #0
20027fc6:	009b      	lsls	r3, r3, #2
20027fc8:	3b04      	subs	r3, #4
20027fca:	1d19      	adds	r1, r3, #4
20027fcc:	d0d9      	beq.n	20027f82 <mbedtls_mpi_shift_l+0x1e>
20027fce:	68a9      	ldr	r1, [r5, #8]
20027fd0:	50ca      	str	r2, [r1, r3]
20027fd2:	e7f9      	b.n	20027fc8 <mbedtls_mpi_shift_l+0x64>
20027fd4:	68ae      	ldr	r6, [r5, #8]
20027fd6:	3901      	subs	r1, #1
20027fd8:	eb06 0c03 	add.w	ip, r6, r3
20027fdc:	f85c c000 	ldr.w	ip, [ip, r0]
20027fe0:	f846 c003 	str.w	ip, [r6, r3]
20027fe4:	e7e5      	b.n	20027fb2 <mbedtls_mpi_shift_l+0x4e>
20027fe6:	68ab      	ldr	r3, [r5, #8]
20027fe8:	f853 1024 	ldr.w	r1, [r3, r4, lsl #2]
20027fec:	fa01 f007 	lsl.w	r0, r1, r7
20027ff0:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
20027ff4:	68a8      	ldr	r0, [r5, #8]
20027ff6:	f850 3024 	ldr.w	r3, [r0, r4, lsl #2]
20027ffa:	4313      	orrs	r3, r2
20027ffc:	f840 3024 	str.w	r3, [r0, r4, lsl #2]
20028000:	fa21 f206 	lsr.w	r2, r1, r6
20028004:	3401      	adds	r4, #1
20028006:	686b      	ldr	r3, [r5, #4]
20028008:	42a3      	cmp	r3, r4
2002800a:	d8ec      	bhi.n	20027fe6 <mbedtls_mpi_shift_l+0x82>
2002800c:	e7bb      	b.n	20027f86 <mbedtls_mpi_shift_l+0x22>
2002800e:	2200      	movs	r2, #0
20028010:	f1c7 0620 	rsb	r6, r7, #32
20028014:	e7f7      	b.n	20028006 <mbedtls_mpi_shift_l+0xa2>

20028016 <mbedtls_mpi_shift_r>:
20028016:	b4f0      	push	{r4, r5, r6, r7}
20028018:	6843      	ldr	r3, [r0, #4]
2002801a:	094c      	lsrs	r4, r1, #5
2002801c:	42a3      	cmp	r3, r4
2002801e:	f001 021f 	and.w	r2, r1, #31
20028022:	d301      	bcc.n	20028028 <mbedtls_mpi_shift_r+0x12>
20028024:	d104      	bne.n	20028030 <mbedtls_mpi_shift_r+0x1a>
20028026:	b392      	cbz	r2, 2002808e <mbedtls_mpi_shift_r+0x78>
20028028:	bcf0      	pop	{r4, r5, r6, r7}
2002802a:	2100      	movs	r1, #0
2002802c:	f7ff beeb 	b.w	20027e06 <mbedtls_mpi_lset>
20028030:	291f      	cmp	r1, #31
20028032:	d82e      	bhi.n	20028092 <mbedtls_mpi_shift_r+0x7c>
20028034:	b9aa      	cbnz	r2, 20028062 <mbedtls_mpi_shift_r+0x4c>
20028036:	bcf0      	pop	{r4, r5, r6, r7}
20028038:	2000      	movs	r0, #0
2002803a:	4770      	bx	lr
2002803c:	6885      	ldr	r5, [r0, #8]
2002803e:	586e      	ldr	r6, [r5, r1]
20028040:	3104      	adds	r1, #4
20028042:	f845 6023 	str.w	r6, [r5, r3, lsl #2]
20028046:	3301      	adds	r3, #1
20028048:	6845      	ldr	r5, [r0, #4]
2002804a:	1b2d      	subs	r5, r5, r4
2002804c:	429d      	cmp	r5, r3
2002804e:	d8f5      	bhi.n	2002803c <mbedtls_mpi_shift_r+0x26>
20028050:	2400      	movs	r4, #0
20028052:	6841      	ldr	r1, [r0, #4]
20028054:	4299      	cmp	r1, r3
20028056:	d9ed      	bls.n	20028034 <mbedtls_mpi_shift_r+0x1e>
20028058:	6881      	ldr	r1, [r0, #8]
2002805a:	f841 4023 	str.w	r4, [r1, r3, lsl #2]
2002805e:	3301      	adds	r3, #1
20028060:	e7f7      	b.n	20028052 <mbedtls_mpi_shift_r+0x3c>
20028062:	2400      	movs	r4, #0
20028064:	6843      	ldr	r3, [r0, #4]
20028066:	f1c2 0720 	rsb	r7, r2, #32
2002806a:	3b01      	subs	r3, #1
2002806c:	d3e3      	bcc.n	20028036 <mbedtls_mpi_shift_r+0x20>
2002806e:	6881      	ldr	r1, [r0, #8]
20028070:	f851 5023 	ldr.w	r5, [r1, r3, lsl #2]
20028074:	fa25 f602 	lsr.w	r6, r5, r2
20028078:	f841 6023 	str.w	r6, [r1, r3, lsl #2]
2002807c:	6886      	ldr	r6, [r0, #8]
2002807e:	f856 1023 	ldr.w	r1, [r6, r3, lsl #2]
20028082:	4321      	orrs	r1, r4
20028084:	f846 1023 	str.w	r1, [r6, r3, lsl #2]
20028088:	fa05 f407 	lsl.w	r4, r5, r7
2002808c:	e7ed      	b.n	2002806a <mbedtls_mpi_shift_r+0x54>
2002808e:	291f      	cmp	r1, #31
20028090:	d9d1      	bls.n	20028036 <mbedtls_mpi_shift_r+0x20>
20028092:	2300      	movs	r3, #0
20028094:	00a1      	lsls	r1, r4, #2
20028096:	e7d7      	b.n	20028048 <mbedtls_mpi_shift_r+0x32>

20028098 <mbedtls_mpi_cmp_abs>:
20028098:	b530      	push	{r4, r5, lr}
2002809a:	6842      	ldr	r2, [r0, #4]
2002809c:	b922      	cbnz	r2, 200280a8 <mbedtls_mpi_cmp_abs+0x10>
2002809e:	684b      	ldr	r3, [r1, #4]
200280a0:	b95b      	cbnz	r3, 200280ba <mbedtls_mpi_cmp_abs+0x22>
200280a2:	b19a      	cbz	r2, 200280cc <mbedtls_mpi_cmp_abs+0x34>
200280a4:	2001      	movs	r0, #1
200280a6:	e015      	b.n	200280d4 <mbedtls_mpi_cmp_abs+0x3c>
200280a8:	6883      	ldr	r3, [r0, #8]
200280aa:	eb03 0382 	add.w	r3, r3, r2, lsl #2
200280ae:	f853 3c04 	ldr.w	r3, [r3, #-4]
200280b2:	2b00      	cmp	r3, #0
200280b4:	d1f3      	bne.n	2002809e <mbedtls_mpi_cmp_abs+0x6>
200280b6:	3a01      	subs	r2, #1
200280b8:	e7f0      	b.n	2002809c <mbedtls_mpi_cmp_abs+0x4>
200280ba:	688c      	ldr	r4, [r1, #8]
200280bc:	eb04 0583 	add.w	r5, r4, r3, lsl #2
200280c0:	f855 5c04 	ldr.w	r5, [r5, #-4]
200280c4:	b90d      	cbnz	r5, 200280ca <mbedtls_mpi_cmp_abs+0x32>
200280c6:	3b01      	subs	r3, #1
200280c8:	e7ea      	b.n	200280a0 <mbedtls_mpi_cmp_abs+0x8>
200280ca:	b922      	cbnz	r2, 200280d6 <mbedtls_mpi_cmp_abs+0x3e>
200280cc:	1e18      	subs	r0, r3, #0
200280ce:	bf18      	it	ne
200280d0:	2001      	movne	r0, #1
200280d2:	4240      	negs	r0, r0
200280d4:	bd30      	pop	{r4, r5, pc}
200280d6:	4293      	cmp	r3, r2
200280d8:	d3e4      	bcc.n	200280a4 <mbedtls_mpi_cmp_abs+0xc>
200280da:	d80e      	bhi.n	200280fa <mbedtls_mpi_cmp_abs+0x62>
200280dc:	3a01      	subs	r2, #1
200280de:	6883      	ldr	r3, [r0, #8]
200280e0:	f853 1022 	ldr.w	r1, [r3, r2, lsl #2]
200280e4:	f854 3022 	ldr.w	r3, [r4, r2, lsl #2]
200280e8:	4299      	cmp	r1, r3
200280ea:	d8db      	bhi.n	200280a4 <mbedtls_mpi_cmp_abs+0xc>
200280ec:	f102 32ff 	add.w	r2, r2, #4294967295
200280f0:	d303      	bcc.n	200280fa <mbedtls_mpi_cmp_abs+0x62>
200280f2:	1c53      	adds	r3, r2, #1
200280f4:	d1f3      	bne.n	200280de <mbedtls_mpi_cmp_abs+0x46>
200280f6:	2000      	movs	r0, #0
200280f8:	e7ec      	b.n	200280d4 <mbedtls_mpi_cmp_abs+0x3c>
200280fa:	f04f 30ff 	mov.w	r0, #4294967295
200280fe:	e7e9      	b.n	200280d4 <mbedtls_mpi_cmp_abs+0x3c>

20028100 <mpi_montmul>:
20028100:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20028104:	4615      	mov	r5, r2
20028106:	b087      	sub	sp, #28
20028108:	9305      	str	r3, [sp, #20]
2002810a:	9b10      	ldr	r3, [sp, #64]	@ 0x40
2002810c:	4606      	mov	r6, r0
2002810e:	685a      	ldr	r2, [r3, #4]
20028110:	686b      	ldr	r3, [r5, #4]
20028112:	4689      	mov	r9, r1
20028114:	3301      	adds	r3, #1
20028116:	429a      	cmp	r2, r3
20028118:	d359      	bcc.n	200281ce <mpi_montmul+0xce>
2002811a:	9b10      	ldr	r3, [sp, #64]	@ 0x40
2002811c:	6898      	ldr	r0, [r3, #8]
2002811e:	2800      	cmp	r0, #0
20028120:	d055      	beq.n	200281ce <mpi_montmul+0xce>
20028122:	0092      	lsls	r2, r2, #2
20028124:	2100      	movs	r1, #0
20028126:	f002 fb95 	bl	2002a854 <memset>
2002812a:	9b10      	ldr	r3, [sp, #64]	@ 0x40
2002812c:	f8d5 8004 	ldr.w	r8, [r5, #4]
20028130:	f8d3 a008 	ldr.w	sl, [r3, #8]
20028134:	f8d9 3004 	ldr.w	r3, [r9, #4]
20028138:	46d3      	mov	fp, sl
2002813a:	4543      	cmp	r3, r8
2002813c:	bf28      	it	cs
2002813e:	4643      	movcs	r3, r8
20028140:	2400      	movs	r4, #0
20028142:	9304      	str	r3, [sp, #16]
20028144:	f108 0301 	add.w	r3, r8, #1
20028148:	009a      	lsls	r2, r3, #2
2002814a:	eb0a 0383 	add.w	r3, sl, r3, lsl #2
2002814e:	9202      	str	r2, [sp, #8]
20028150:	9303      	str	r3, [sp, #12]
20028152:	4544      	cmp	r4, r8
20028154:	68b0      	ldr	r0, [r6, #8]
20028156:	d118      	bne.n	2002818a <mpi_montmul+0x8a>
20028158:	9b02      	ldr	r3, [sp, #8]
2002815a:	1f19      	subs	r1, r3, #4
2002815c:	461a      	mov	r2, r3
2002815e:	4451      	add	r1, sl
20028160:	f002 fb92 	bl	2002a888 <memcpy>
20028164:	4629      	mov	r1, r5
20028166:	4630      	mov	r0, r6
20028168:	f7ff ff96 	bl	20028098 <mbedtls_mpi_cmp_abs>
2002816c:	3001      	adds	r0, #1
2002816e:	68b1      	ldr	r1, [r6, #8]
20028170:	bf0c      	ite	eq
20028172:	9b10      	ldreq	r3, [sp, #64]	@ 0x40
20028174:	460a      	movne	r2, r1
20028176:	4620      	mov	r0, r4
20028178:	bf14      	ite	ne
2002817a:	68a9      	ldrne	r1, [r5, #8]
2002817c:	689a      	ldreq	r2, [r3, #8]
2002817e:	f7ff fc2c 	bl	200279da <mpi_sub_hlp>
20028182:	2000      	movs	r0, #0
20028184:	b007      	add	sp, #28
20028186:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
2002818a:	f850 3024 	ldr.w	r3, [r0, r4, lsl #2]
2002818e:	f8d9 1008 	ldr.w	r1, [r9, #8]
20028192:	9301      	str	r3, [sp, #4]
20028194:	9a01      	ldr	r2, [sp, #4]
20028196:	680b      	ldr	r3, [r1, #0]
20028198:	f8db 7000 	ldr.w	r7, [fp]
2002819c:	9804      	ldr	r0, [sp, #16]
2002819e:	fb03 7702 	mla	r7, r3, r2, r7
200281a2:	9b05      	ldr	r3, [sp, #20]
200281a4:	3401      	adds	r4, #1
200281a6:	435f      	muls	r7, r3
200281a8:	4613      	mov	r3, r2
200281aa:	465a      	mov	r2, fp
200281ac:	f7ff fc3e 	bl	20027a2c <mpi_mul_hlp>
200281b0:	465a      	mov	r2, fp
200281b2:	463b      	mov	r3, r7
200281b4:	4640      	mov	r0, r8
200281b6:	68a9      	ldr	r1, [r5, #8]
200281b8:	f7ff fc38 	bl	20027a2c <mpi_mul_hlp>
200281bc:	2200      	movs	r2, #0
200281be:	9b01      	ldr	r3, [sp, #4]
200281c0:	f84b 3b04 	str.w	r3, [fp], #4
200281c4:	9b03      	ldr	r3, [sp, #12]
200281c6:	f843 2f04 	str.w	r2, [r3, #4]!
200281ca:	9303      	str	r3, [sp, #12]
200281cc:	e7c1      	b.n	20028152 <mpi_montmul+0x52>
200281ce:	f06f 0003 	mvn.w	r0, #3
200281d2:	e7d7      	b.n	20028184 <mpi_montmul+0x84>

200281d4 <mbedtls_mpi_cmp_mpi>:
200281d4:	4602      	mov	r2, r0
200281d6:	b530      	push	{r4, r5, lr}
200281d8:	6843      	ldr	r3, [r0, #4]
200281da:	b923      	cbnz	r3, 200281e6 <mbedtls_mpi_cmp_mpi+0x12>
200281dc:	6848      	ldr	r0, [r1, #4]
200281de:	b958      	cbnz	r0, 200281f8 <mbedtls_mpi_cmp_mpi+0x24>
200281e0:	2b00      	cmp	r3, #0
200281e2:	d136      	bne.n	20028252 <mbedtls_mpi_cmp_mpi+0x7e>
200281e4:	e02f      	b.n	20028246 <mbedtls_mpi_cmp_mpi+0x72>
200281e6:	6890      	ldr	r0, [r2, #8]
200281e8:	eb00 0083 	add.w	r0, r0, r3, lsl #2
200281ec:	f850 0c04 	ldr.w	r0, [r0, #-4]
200281f0:	2800      	cmp	r0, #0
200281f2:	d1f3      	bne.n	200281dc <mbedtls_mpi_cmp_mpi+0x8>
200281f4:	3b01      	subs	r3, #1
200281f6:	e7f0      	b.n	200281da <mbedtls_mpi_cmp_mpi+0x6>
200281f8:	688c      	ldr	r4, [r1, #8]
200281fa:	eb04 0580 	add.w	r5, r4, r0, lsl #2
200281fe:	f855 5c04 	ldr.w	r5, [r5, #-4]
20028202:	bb15      	cbnz	r5, 2002824a <mbedtls_mpi_cmp_mpi+0x76>
20028204:	3801      	subs	r0, #1
20028206:	e7ea      	b.n	200281de <mbedtls_mpi_cmp_mpi+0xa>
20028208:	680d      	ldr	r5, [r1, #0]
2002820a:	d202      	bcs.n	20028212 <mbedtls_mpi_cmp_mpi+0x3e>
2002820c:	6808      	ldr	r0, [r1, #0]
2002820e:	4240      	negs	r0, r0
20028210:	e020      	b.n	20028254 <mbedtls_mpi_cmp_mpi+0x80>
20028212:	6810      	ldr	r0, [r2, #0]
20028214:	2800      	cmp	r0, #0
20028216:	dd03      	ble.n	20028220 <mbedtls_mpi_cmp_mpi+0x4c>
20028218:	2d00      	cmp	r5, #0
2002821a:	da07      	bge.n	2002822c <mbedtls_mpi_cmp_mpi+0x58>
2002821c:	2001      	movs	r0, #1
2002821e:	e019      	b.n	20028254 <mbedtls_mpi_cmp_mpi+0x80>
20028220:	2d00      	cmp	r5, #0
20028222:	dd03      	ble.n	2002822c <mbedtls_mpi_cmp_mpi+0x58>
20028224:	b110      	cbz	r0, 2002822c <mbedtls_mpi_cmp_mpi+0x58>
20028226:	f04f 30ff 	mov.w	r0, #4294967295
2002822a:	e013      	b.n	20028254 <mbedtls_mpi_cmp_mpi+0x80>
2002822c:	3b01      	subs	r3, #1
2002822e:	6891      	ldr	r1, [r2, #8]
20028230:	f851 5023 	ldr.w	r5, [r1, r3, lsl #2]
20028234:	f854 1023 	ldr.w	r1, [r4, r3, lsl #2]
20028238:	428d      	cmp	r5, r1
2002823a:	d80b      	bhi.n	20028254 <mbedtls_mpi_cmp_mpi+0x80>
2002823c:	f103 33ff 	add.w	r3, r3, #4294967295
20028240:	d3e5      	bcc.n	2002820e <mbedtls_mpi_cmp_mpi+0x3a>
20028242:	1c59      	adds	r1, r3, #1
20028244:	d1f3      	bne.n	2002822e <mbedtls_mpi_cmp_mpi+0x5a>
20028246:	2000      	movs	r0, #0
20028248:	e004      	b.n	20028254 <mbedtls_mpi_cmp_mpi+0x80>
2002824a:	2b00      	cmp	r3, #0
2002824c:	d0de      	beq.n	2002820c <mbedtls_mpi_cmp_mpi+0x38>
2002824e:	4283      	cmp	r3, r0
20028250:	d9da      	bls.n	20028208 <mbedtls_mpi_cmp_mpi+0x34>
20028252:	6810      	ldr	r0, [r2, #0]
20028254:	bd30      	pop	{r4, r5, pc}

20028256 <mbedtls_mpi_cmp_int>:
20028256:	b51f      	push	{r0, r1, r2, r3, r4, lr}
20028258:	ea81 73e1 	eor.w	r3, r1, r1, asr #31
2002825c:	eba3 73e1 	sub.w	r3, r3, r1, asr #31
20028260:	2900      	cmp	r1, #0
20028262:	9300      	str	r3, [sp, #0]
20028264:	bfac      	ite	ge
20028266:	2301      	movge	r3, #1
20028268:	f04f 33ff 	movlt.w	r3, #4294967295
2002826c:	9301      	str	r3, [sp, #4]
2002826e:	2301      	movs	r3, #1
20028270:	a901      	add	r1, sp, #4
20028272:	9302      	str	r3, [sp, #8]
20028274:	f8cd d00c 	str.w	sp, [sp, #12]
20028278:	f7ff ffac 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
2002827c:	b005      	add	sp, #20
2002827e:	f85d fb04 	ldr.w	pc, [sp], #4

20028282 <mbedtls_mpi_add_abs>:
20028282:	4290      	cmp	r0, r2
20028284:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20028288:	4606      	mov	r6, r0
2002828a:	460c      	mov	r4, r1
2002828c:	4615      	mov	r5, r2
2002828e:	d002      	beq.n	20028296 <mbedtls_mpi_add_abs+0x14>
20028290:	4288      	cmp	r0, r1
20028292:	d12c      	bne.n	200282ee <mbedtls_mpi_add_abs+0x6c>
20028294:	462c      	mov	r4, r5
20028296:	2301      	movs	r3, #1
20028298:	6033      	str	r3, [r6, #0]
2002829a:	6865      	ldr	r5, [r4, #4]
2002829c:	bb85      	cbnz	r5, 20028300 <mbedtls_mpi_add_abs+0x7e>
2002829e:	4629      	mov	r1, r5
200282a0:	4630      	mov	r0, r6
200282a2:	f7ff fd5b 	bl	20027d5c <mbedtls_mpi_grow>
200282a6:	4607      	mov	r7, r0
200282a8:	bb28      	cbnz	r0, 200282f6 <mbedtls_mpi_add_abs+0x74>
200282aa:	68b3      	ldr	r3, [r6, #8]
200282ac:	68a1      	ldr	r1, [r4, #8]
200282ae:	469c      	mov	ip, r3
200282b0:	4604      	mov	r4, r0
200282b2:	42a8      	cmp	r0, r5
200282b4:	d12d      	bne.n	20028312 <mbedtls_mpi_add_abs+0x90>
200282b6:	eb03 0385 	add.w	r3, r3, r5, lsl #2
200282ba:	b1f4      	cbz	r4, 200282fa <mbedtls_mpi_add_abs+0x78>
200282bc:	6872      	ldr	r2, [r6, #4]
200282be:	f105 0801 	add.w	r8, r5, #1
200282c2:	42aa      	cmp	r2, r5
200282c4:	d807      	bhi.n	200282d6 <mbedtls_mpi_add_abs+0x54>
200282c6:	4641      	mov	r1, r8
200282c8:	4630      	mov	r0, r6
200282ca:	f7ff fd47 	bl	20027d5c <mbedtls_mpi_grow>
200282ce:	b990      	cbnz	r0, 200282f6 <mbedtls_mpi_add_abs+0x74>
200282d0:	68b3      	ldr	r3, [r6, #8]
200282d2:	eb03 0385 	add.w	r3, r3, r5, lsl #2
200282d6:	681a      	ldr	r2, [r3, #0]
200282d8:	4645      	mov	r5, r8
200282da:	1912      	adds	r2, r2, r4
200282dc:	bf2c      	ite	cs
200282de:	2401      	movcs	r4, #1
200282e0:	2400      	movcc	r4, #0
200282e2:	3c00      	subs	r4, #0
200282e4:	bf18      	it	ne
200282e6:	2401      	movne	r4, #1
200282e8:	f843 2b04 	str.w	r2, [r3], #4
200282ec:	e7e5      	b.n	200282ba <mbedtls_mpi_add_abs+0x38>
200282ee:	f7ff fd61 	bl	20027db4 <mbedtls_mpi_copy>
200282f2:	2800      	cmp	r0, #0
200282f4:	d0ce      	beq.n	20028294 <mbedtls_mpi_add_abs+0x12>
200282f6:	f06f 070f 	mvn.w	r7, #15
200282fa:	4638      	mov	r0, r7
200282fc:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20028300:	68a3      	ldr	r3, [r4, #8]
20028302:	eb03 0385 	add.w	r3, r3, r5, lsl #2
20028306:	f853 3c04 	ldr.w	r3, [r3, #-4]
2002830a:	2b00      	cmp	r3, #0
2002830c:	d1c7      	bne.n	2002829e <mbedtls_mpi_add_abs+0x1c>
2002830e:	3d01      	subs	r5, #1
20028310:	e7c4      	b.n	2002829c <mbedtls_mpi_add_abs+0x1a>
20028312:	f8dc 2000 	ldr.w	r2, [ip]
20028316:	1912      	adds	r2, r2, r4
20028318:	bf2c      	ite	cs
2002831a:	f04f 0e01 	movcs.w	lr, #1
2002831e:	f04f 0e00 	movcc.w	lr, #0
20028322:	f851 4020 	ldr.w	r4, [r1, r0, lsl #2]
20028326:	3001      	adds	r0, #1
20028328:	1912      	adds	r2, r2, r4
2002832a:	f84c 2b04 	str.w	r2, [ip], #4
2002832e:	f14e 0400 	adc.w	r4, lr, #0
20028332:	e7be      	b.n	200282b2 <mbedtls_mpi_add_abs+0x30>

20028334 <mbedtls_mpi_sub_abs>:
20028334:	b57f      	push	{r0, r1, r2, r3, r4, r5, r6, lr}
20028336:	460e      	mov	r6, r1
20028338:	4605      	mov	r5, r0
2002833a:	4611      	mov	r1, r2
2002833c:	4630      	mov	r0, r6
2002833e:	4614      	mov	r4, r2
20028340:	f7ff feaa 	bl	20028098 <mbedtls_mpi_cmp_abs>
20028344:	3001      	adds	r0, #1
20028346:	d02f      	beq.n	200283a8 <mbedtls_mpi_sub_abs+0x74>
20028348:	2300      	movs	r3, #0
2002834a:	2201      	movs	r2, #1
2002834c:	42ac      	cmp	r4, r5
2002834e:	e9cd 2301 	strd	r2, r3, [sp, #4]
20028352:	9303      	str	r3, [sp, #12]
20028354:	d10d      	bne.n	20028372 <mbedtls_mpi_sub_abs+0x3e>
20028356:	4621      	mov	r1, r4
20028358:	a801      	add	r0, sp, #4
2002835a:	f7ff fd2b 	bl	20027db4 <mbedtls_mpi_copy>
2002835e:	b138      	cbz	r0, 20028370 <mbedtls_mpi_sub_abs+0x3c>
20028360:	f06f 040f 	mvn.w	r4, #15
20028364:	a801      	add	r0, sp, #4
20028366:	f7ff fce4 	bl	20027d32 <mbedtls_mpi_free>
2002836a:	4620      	mov	r0, r4
2002836c:	b004      	add	sp, #16
2002836e:	bd70      	pop	{r4, r5, r6, pc}
20028370:	ac01      	add	r4, sp, #4
20028372:	42ae      	cmp	r6, r5
20028374:	d109      	bne.n	2002838a <mbedtls_mpi_sub_abs+0x56>
20028376:	2301      	movs	r3, #1
20028378:	602b      	str	r3, [r5, #0]
2002837a:	e9d4 0101 	ldrd	r0, r1, [r4, #4]
2002837e:	b958      	cbnz	r0, 20028398 <mbedtls_mpi_sub_abs+0x64>
20028380:	68aa      	ldr	r2, [r5, #8]
20028382:	f7ff fb2a 	bl	200279da <mpi_sub_hlp>
20028386:	2400      	movs	r4, #0
20028388:	e7ec      	b.n	20028364 <mbedtls_mpi_sub_abs+0x30>
2002838a:	4631      	mov	r1, r6
2002838c:	4628      	mov	r0, r5
2002838e:	f7ff fd11 	bl	20027db4 <mbedtls_mpi_copy>
20028392:	2800      	cmp	r0, #0
20028394:	d0ef      	beq.n	20028376 <mbedtls_mpi_sub_abs+0x42>
20028396:	e7e3      	b.n	20028360 <mbedtls_mpi_sub_abs+0x2c>
20028398:	eb01 0380 	add.w	r3, r1, r0, lsl #2
2002839c:	f853 3c04 	ldr.w	r3, [r3, #-4]
200283a0:	2b00      	cmp	r3, #0
200283a2:	d1ed      	bne.n	20028380 <mbedtls_mpi_sub_abs+0x4c>
200283a4:	3801      	subs	r0, #1
200283a6:	e7ea      	b.n	2002837e <mbedtls_mpi_sub_abs+0x4a>
200283a8:	f06f 0409 	mvn.w	r4, #9
200283ac:	e7dd      	b.n	2002836a <mbedtls_mpi_sub_abs+0x36>

200283ae <mbedtls_mpi_add_mpi>:
200283ae:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
200283b0:	680d      	ldr	r5, [r1, #0]
200283b2:	6813      	ldr	r3, [r2, #0]
200283b4:	4604      	mov	r4, r0
200283b6:	436b      	muls	r3, r5
200283b8:	460f      	mov	r7, r1
200283ba:	4616      	mov	r6, r2
200283bc:	d516      	bpl.n	200283ec <mbedtls_mpi_add_mpi+0x3e>
200283be:	4611      	mov	r1, r2
200283c0:	4638      	mov	r0, r7
200283c2:	f7ff fe69 	bl	20028098 <mbedtls_mpi_cmp_abs>
200283c6:	3001      	adds	r0, #1
200283c8:	d007      	beq.n	200283da <mbedtls_mpi_add_mpi+0x2c>
200283ca:	4632      	mov	r2, r6
200283cc:	4639      	mov	r1, r7
200283ce:	4620      	mov	r0, r4
200283d0:	f7ff ffb0 	bl	20028334 <mbedtls_mpi_sub_abs>
200283d4:	b900      	cbnz	r0, 200283d8 <mbedtls_mpi_add_mpi+0x2a>
200283d6:	6025      	str	r5, [r4, #0]
200283d8:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
200283da:	463a      	mov	r2, r7
200283dc:	4631      	mov	r1, r6
200283de:	4620      	mov	r0, r4
200283e0:	f7ff ffa8 	bl	20028334 <mbedtls_mpi_sub_abs>
200283e4:	2800      	cmp	r0, #0
200283e6:	d1f7      	bne.n	200283d8 <mbedtls_mpi_add_mpi+0x2a>
200283e8:	426d      	negs	r5, r5
200283ea:	e7f4      	b.n	200283d6 <mbedtls_mpi_add_mpi+0x28>
200283ec:	f7ff ff49 	bl	20028282 <mbedtls_mpi_add_abs>
200283f0:	2800      	cmp	r0, #0
200283f2:	d0f0      	beq.n	200283d6 <mbedtls_mpi_add_mpi+0x28>
200283f4:	f06f 000f 	mvn.w	r0, #15
200283f8:	e7ee      	b.n	200283d8 <mbedtls_mpi_add_mpi+0x2a>

200283fa <mbedtls_mpi_sub_mpi>:
200283fa:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
200283fc:	680d      	ldr	r5, [r1, #0]
200283fe:	6813      	ldr	r3, [r2, #0]
20028400:	4604      	mov	r4, r0
20028402:	436b      	muls	r3, r5
20028404:	2b00      	cmp	r3, #0
20028406:	460f      	mov	r7, r1
20028408:	4616      	mov	r6, r2
2002840a:	dd16      	ble.n	2002843a <mbedtls_mpi_sub_mpi+0x40>
2002840c:	4611      	mov	r1, r2
2002840e:	4638      	mov	r0, r7
20028410:	f7ff fe42 	bl	20028098 <mbedtls_mpi_cmp_abs>
20028414:	3001      	adds	r0, #1
20028416:	d007      	beq.n	20028428 <mbedtls_mpi_sub_mpi+0x2e>
20028418:	4632      	mov	r2, r6
2002841a:	4639      	mov	r1, r7
2002841c:	4620      	mov	r0, r4
2002841e:	f7ff ff89 	bl	20028334 <mbedtls_mpi_sub_abs>
20028422:	b900      	cbnz	r0, 20028426 <mbedtls_mpi_sub_mpi+0x2c>
20028424:	6025      	str	r5, [r4, #0]
20028426:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
20028428:	463a      	mov	r2, r7
2002842a:	4631      	mov	r1, r6
2002842c:	4620      	mov	r0, r4
2002842e:	f7ff ff81 	bl	20028334 <mbedtls_mpi_sub_abs>
20028432:	2800      	cmp	r0, #0
20028434:	d1f7      	bne.n	20028426 <mbedtls_mpi_sub_mpi+0x2c>
20028436:	426d      	negs	r5, r5
20028438:	e7f4      	b.n	20028424 <mbedtls_mpi_sub_mpi+0x2a>
2002843a:	f7ff ff22 	bl	20028282 <mbedtls_mpi_add_abs>
2002843e:	2800      	cmp	r0, #0
20028440:	d0f0      	beq.n	20028424 <mbedtls_mpi_sub_mpi+0x2a>
20028442:	f06f 000f 	mvn.w	r0, #15
20028446:	e7ee      	b.n	20028426 <mbedtls_mpi_sub_mpi+0x2c>

20028448 <mbedtls_mpi_sub_int>:
20028448:	b51f      	push	{r0, r1, r2, r3, r4, lr}
2002844a:	ea82 73e2 	eor.w	r3, r2, r2, asr #31
2002844e:	eba3 73e2 	sub.w	r3, r3, r2, asr #31
20028452:	2a00      	cmp	r2, #0
20028454:	9300      	str	r3, [sp, #0]
20028456:	bfac      	ite	ge
20028458:	2301      	movge	r3, #1
2002845a:	f04f 33ff 	movlt.w	r3, #4294967295
2002845e:	9301      	str	r3, [sp, #4]
20028460:	2301      	movs	r3, #1
20028462:	aa01      	add	r2, sp, #4
20028464:	9302      	str	r3, [sp, #8]
20028466:	f8cd d00c 	str.w	sp, [sp, #12]
2002846a:	f7ff ffc6 	bl	200283fa <mbedtls_mpi_sub_mpi>
2002846e:	b005      	add	sp, #20
20028470:	f85d fb04 	ldr.w	pc, [sp], #4

20028474 <mbedtls_mpi_mul_mpi>:
20028474:	e92d 43f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
20028478:	2300      	movs	r3, #0
2002847a:	4615      	mov	r5, r2
2002847c:	2201      	movs	r2, #1
2002847e:	b087      	sub	sp, #28
20028480:	4288      	cmp	r0, r1
20028482:	4607      	mov	r7, r0
20028484:	460e      	mov	r6, r1
20028486:	e9cd 2300 	strd	r2, r3, [sp]
2002848a:	e9cd 3202 	strd	r3, r2, [sp, #8]
2002848e:	e9cd 3304 	strd	r3, r3, [sp, #16]
20028492:	d110      	bne.n	200284b6 <mbedtls_mpi_mul_mpi+0x42>
20028494:	4668      	mov	r0, sp
20028496:	f7ff fc8d 	bl	20027db4 <mbedtls_mpi_copy>
2002849a:	b158      	cbz	r0, 200284b4 <mbedtls_mpi_mul_mpi+0x40>
2002849c:	f06f 090f 	mvn.w	r9, #15
200284a0:	a803      	add	r0, sp, #12
200284a2:	f7ff fc46 	bl	20027d32 <mbedtls_mpi_free>
200284a6:	4668      	mov	r0, sp
200284a8:	f7ff fc43 	bl	20027d32 <mbedtls_mpi_free>
200284ac:	4648      	mov	r0, r9
200284ae:	b007      	add	sp, #28
200284b0:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
200284b4:	466e      	mov	r6, sp
200284b6:	42af      	cmp	r7, r5
200284b8:	d106      	bne.n	200284c8 <mbedtls_mpi_mul_mpi+0x54>
200284ba:	4639      	mov	r1, r7
200284bc:	a803      	add	r0, sp, #12
200284be:	f7ff fc79 	bl	20027db4 <mbedtls_mpi_copy>
200284c2:	2800      	cmp	r0, #0
200284c4:	d1ea      	bne.n	2002849c <mbedtls_mpi_mul_mpi+0x28>
200284c6:	ad03      	add	r5, sp, #12
200284c8:	f8d6 8004 	ldr.w	r8, [r6, #4]
200284cc:	f1b8 0f00 	cmp.w	r8, #0
200284d0:	d116      	bne.n	20028500 <mbedtls_mpi_mul_mpi+0x8c>
200284d2:	686c      	ldr	r4, [r5, #4]
200284d4:	b9f4      	cbnz	r4, 20028514 <mbedtls_mpi_mul_mpi+0xa0>
200284d6:	eb08 0104 	add.w	r1, r8, r4
200284da:	4638      	mov	r0, r7
200284dc:	f7ff fc3e 	bl	20027d5c <mbedtls_mpi_grow>
200284e0:	4601      	mov	r1, r0
200284e2:	2800      	cmp	r0, #0
200284e4:	d1da      	bne.n	2002849c <mbedtls_mpi_mul_mpi+0x28>
200284e6:	4638      	mov	r0, r7
200284e8:	f7ff fc8d 	bl	20027e06 <mbedtls_mpi_lset>
200284ec:	4681      	mov	r9, r0
200284ee:	2800      	cmp	r0, #0
200284f0:	d1d4      	bne.n	2002849c <mbedtls_mpi_mul_mpi+0x28>
200284f2:	3c01      	subs	r4, #1
200284f4:	d217      	bcs.n	20028526 <mbedtls_mpi_mul_mpi+0xb2>
200284f6:	6833      	ldr	r3, [r6, #0]
200284f8:	682a      	ldr	r2, [r5, #0]
200284fa:	4353      	muls	r3, r2
200284fc:	603b      	str	r3, [r7, #0]
200284fe:	e7cf      	b.n	200284a0 <mbedtls_mpi_mul_mpi+0x2c>
20028500:	68b3      	ldr	r3, [r6, #8]
20028502:	eb03 0388 	add.w	r3, r3, r8, lsl #2
20028506:	f853 3c04 	ldr.w	r3, [r3, #-4]
2002850a:	2b00      	cmp	r3, #0
2002850c:	d1e1      	bne.n	200284d2 <mbedtls_mpi_mul_mpi+0x5e>
2002850e:	f108 38ff 	add.w	r8, r8, #4294967295
20028512:	e7db      	b.n	200284cc <mbedtls_mpi_mul_mpi+0x58>
20028514:	68ab      	ldr	r3, [r5, #8]
20028516:	eb03 0384 	add.w	r3, r3, r4, lsl #2
2002851a:	f853 3c04 	ldr.w	r3, [r3, #-4]
2002851e:	2b00      	cmp	r3, #0
20028520:	d1d9      	bne.n	200284d6 <mbedtls_mpi_mul_mpi+0x62>
20028522:	3c01      	subs	r4, #1
20028524:	e7d6      	b.n	200284d4 <mbedtls_mpi_mul_mpi+0x60>
20028526:	68ab      	ldr	r3, [r5, #8]
20028528:	68ba      	ldr	r2, [r7, #8]
2002852a:	4640      	mov	r0, r8
2002852c:	f853 3024 	ldr.w	r3, [r3, r4, lsl #2]
20028530:	68b1      	ldr	r1, [r6, #8]
20028532:	eb02 0284 	add.w	r2, r2, r4, lsl #2
20028536:	f7ff fa79 	bl	20027a2c <mpi_mul_hlp>
2002853a:	e7da      	b.n	200284f2 <mbedtls_mpi_mul_mpi+0x7e>

2002853c <mbedtls_mpi_mul_int>:
2002853c:	b51f      	push	{r0, r1, r2, r3, r4, lr}
2002853e:	2301      	movs	r3, #1
20028540:	9200      	str	r2, [sp, #0]
20028542:	aa01      	add	r2, sp, #4
20028544:	e9cd 3301 	strd	r3, r3, [sp, #4]
20028548:	f8cd d00c 	str.w	sp, [sp, #12]
2002854c:	f7ff ff92 	bl	20028474 <mbedtls_mpi_mul_mpi>
20028550:	b005      	add	sp, #20
20028552:	f85d fb04 	ldr.w	pc, [sp], #4

20028556 <mbedtls_mpi_div_mpi>:
20028556:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
2002855a:	b09f      	sub	sp, #124	@ 0x7c
2002855c:	e9cd 1203 	strd	r1, r2, [sp, #12]
20028560:	9005      	str	r0, [sp, #20]
20028562:	2100      	movs	r1, #0
20028564:	4618      	mov	r0, r3
20028566:	9309      	str	r3, [sp, #36]	@ 0x24
20028568:	f7ff fe75 	bl	20028256 <mbedtls_mpi_cmp_int>
2002856c:	2800      	cmp	r0, #0
2002856e:	f000 81f3 	beq.w	20028958 <mbedtls_mpi_div_mpi+0x402>
20028572:	2501      	movs	r5, #1
20028574:	2400      	movs	r4, #0
20028576:	9909      	ldr	r1, [sp, #36]	@ 0x24
20028578:	9804      	ldr	r0, [sp, #16]
2002857a:	e9cd 5418 	strd	r5, r4, [sp, #96]	@ 0x60
2002857e:	e9cd 541b 	strd	r5, r4, [sp, #108]	@ 0x6c
20028582:	950f      	str	r5, [sp, #60]	@ 0x3c
20028584:	9512      	str	r5, [sp, #72]	@ 0x48
20028586:	9515      	str	r5, [sp, #84]	@ 0x54
20028588:	9416      	str	r4, [sp, #88]	@ 0x58
2002858a:	f7ff fd85 	bl	20028098 <mbedtls_mpi_cmp_abs>
2002858e:	3001      	adds	r0, #1
20028590:	d11f      	bne.n	200285d2 <mbedtls_mpi_div_mpi+0x7c>
20028592:	9b05      	ldr	r3, [sp, #20]
20028594:	b933      	cbnz	r3, 200285a4 <mbedtls_mpi_div_mpi+0x4e>
20028596:	9b03      	ldr	r3, [sp, #12]
20028598:	b9a3      	cbnz	r3, 200285c4 <mbedtls_mpi_div_mpi+0x6e>
2002859a:	2100      	movs	r1, #0
2002859c:	4608      	mov	r0, r1
2002859e:	b01f      	add	sp, #124	@ 0x7c
200285a0:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
200285a4:	4621      	mov	r1, r4
200285a6:	9805      	ldr	r0, [sp, #20]
200285a8:	f7ff fc2d 	bl	20027e06 <mbedtls_mpi_lset>
200285ac:	2800      	cmp	r0, #0
200285ae:	d0f2      	beq.n	20028596 <mbedtls_mpi_div_mpi+0x40>
200285b0:	2400      	movs	r4, #0
200285b2:	4625      	mov	r5, r4
200285b4:	46a1      	mov	r9, r4
200285b6:	46a0      	mov	r8, r4
200285b8:	4626      	mov	r6, r4
200285ba:	4627      	mov	r7, r4
200285bc:	9402      	str	r4, [sp, #8]
200285be:	f06f 010f 	mvn.w	r1, #15
200285c2:	e0ef      	b.n	200287a4 <mbedtls_mpi_div_mpi+0x24e>
200285c4:	e9dd 0103 	ldrd	r0, r1, [sp, #12]
200285c8:	f7ff fbf4 	bl	20027db4 <mbedtls_mpi_copy>
200285cc:	2800      	cmp	r0, #0
200285ce:	d1ef      	bne.n	200285b0 <mbedtls_mpi_div_mpi+0x5a>
200285d0:	e7e3      	b.n	2002859a <mbedtls_mpi_div_mpi+0x44>
200285d2:	9904      	ldr	r1, [sp, #16]
200285d4:	a80f      	add	r0, sp, #60	@ 0x3c
200285d6:	e9cd 4410 	strd	r4, r4, [sp, #64]	@ 0x40
200285da:	f7ff fbeb 	bl	20027db4 <mbedtls_mpi_copy>
200285de:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
200285e2:	4682      	mov	sl, r0
200285e4:	2800      	cmp	r0, #0
200285e6:	f040 81a9 	bne.w	2002893c <mbedtls_mpi_div_mpi+0x3e6>
200285ea:	e9cd 0013 	strd	r0, r0, [sp, #76]	@ 0x4c
200285ee:	9909      	ldr	r1, [sp, #36]	@ 0x24
200285f0:	a812      	add	r0, sp, #72	@ 0x48
200285f2:	f7ff fbdf 	bl	20027db4 <mbedtls_mpi_copy>
200285f6:	e9dd 8913 	ldrd	r8, r9, [sp, #76]	@ 0x4c
200285fa:	4604      	mov	r4, r0
200285fc:	2800      	cmp	r0, #0
200285fe:	f040 81a2 	bne.w	20028946 <mbedtls_mpi_div_mpi+0x3f0>
20028602:	9b04      	ldr	r3, [sp, #16]
20028604:	9017      	str	r0, [sp, #92]	@ 0x5c
20028606:	6859      	ldr	r1, [r3, #4]
20028608:	a815      	add	r0, sp, #84	@ 0x54
2002860a:	3102      	adds	r1, #2
2002860c:	9512      	str	r5, [sp, #72]	@ 0x48
2002860e:	950f      	str	r5, [sp, #60]	@ 0x3c
20028610:	f7ff fba4 	bl	20027d5c <mbedtls_mpi_grow>
20028614:	4605      	mov	r5, r0
20028616:	b118      	cbz	r0, 20028620 <mbedtls_mpi_div_mpi+0xca>
20028618:	9b17      	ldr	r3, [sp, #92]	@ 0x5c
2002861a:	9302      	str	r3, [sp, #8]
2002861c:	4625      	mov	r5, r4
2002861e:	e7ce      	b.n	200285be <mbedtls_mpi_div_mpi+0x68>
20028620:	4601      	mov	r1, r0
20028622:	a815      	add	r0, sp, #84	@ 0x54
20028624:	f7ff fbef 	bl	20027e06 <mbedtls_mpi_lset>
20028628:	9b17      	ldr	r3, [sp, #92]	@ 0x5c
2002862a:	4604      	mov	r4, r0
2002862c:	9302      	str	r3, [sp, #8]
2002862e:	2800      	cmp	r0, #0
20028630:	f040 818e 	bne.w	20028950 <mbedtls_mpi_div_mpi+0x3fa>
20028634:	901a      	str	r0, [sp, #104]	@ 0x68
20028636:	2102      	movs	r1, #2
20028638:	a818      	add	r0, sp, #96	@ 0x60
2002863a:	f7ff fb8f 	bl	20027d5c <mbedtls_mpi_grow>
2002863e:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
20028640:	2800      	cmp	r0, #0
20028642:	d1bc      	bne.n	200285be <mbedtls_mpi_div_mpi+0x68>
20028644:	901d      	str	r0, [sp, #116]	@ 0x74
20028646:	2103      	movs	r1, #3
20028648:	a81b      	add	r0, sp, #108	@ 0x6c
2002864a:	f7ff fb87 	bl	20027d5c <mbedtls_mpi_grow>
2002864e:	9c1d      	ldr	r4, [sp, #116]	@ 0x74
20028650:	4683      	mov	fp, r0
20028652:	2800      	cmp	r0, #0
20028654:	d1b3      	bne.n	200285be <mbedtls_mpi_div_mpi+0x68>
20028656:	a812      	add	r0, sp, #72	@ 0x48
20028658:	f7ff fc09 	bl	20027e6e <mbedtls_mpi_bitlen>
2002865c:	f000 001f 	and.w	r0, r0, #31
20028660:	281f      	cmp	r0, #31
20028662:	f000 808a 	beq.w	2002877a <mbedtls_mpi_div_mpi+0x224>
20028666:	f1c0 031f 	rsb	r3, r0, #31
2002866a:	4619      	mov	r1, r3
2002866c:	a80f      	add	r0, sp, #60	@ 0x3c
2002866e:	9306      	str	r3, [sp, #24]
20028670:	f7ff fc78 	bl	20027f64 <mbedtls_mpi_shift_l>
20028674:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
20028678:	2800      	cmp	r0, #0
2002867a:	d1a0      	bne.n	200285be <mbedtls_mpi_div_mpi+0x68>
2002867c:	9906      	ldr	r1, [sp, #24]
2002867e:	a812      	add	r0, sp, #72	@ 0x48
20028680:	f7ff fc70 	bl	20027f64 <mbedtls_mpi_shift_l>
20028684:	e9dd 8913 	ldrd	r8, r9, [sp, #76]	@ 0x4c
20028688:	2800      	cmp	r0, #0
2002868a:	d198      	bne.n	200285be <mbedtls_mpi_div_mpi+0x68>
2002868c:	46ba      	mov	sl, r7
2002868e:	f8cd 8020 	str.w	r8, [sp, #32]
20028692:	eba7 0b08 	sub.w	fp, r7, r8
20028696:	ea4f 134b 	mov.w	r3, fp, lsl #5
2002869a:	4619      	mov	r1, r3
2002869c:	a812      	add	r0, sp, #72	@ 0x48
2002869e:	e9cd 8913 	strd	r8, r9, [sp, #76]	@ 0x4c
200286a2:	9301      	str	r3, [sp, #4]
200286a4:	f7ff fc5e 	bl	20027f64 <mbedtls_mpi_shift_l>
200286a8:	e9dd 8913 	ldrd	r8, r9, [sp, #76]	@ 0x4c
200286ac:	2800      	cmp	r0, #0
200286ae:	d186      	bne.n	200285be <mbedtls_mpi_div_mpi+0x68>
200286b0:	ea4f 038b 	mov.w	r3, fp, lsl #2
200286b4:	930b      	str	r3, [sp, #44]	@ 0x2c
200286b6:	9b02      	ldr	r3, [sp, #8]
200286b8:	eb03 0b8b 	add.w	fp, r3, fp, lsl #2
200286bc:	a912      	add	r1, sp, #72	@ 0x48
200286be:	a80f      	add	r0, sp, #60	@ 0x3c
200286c0:	e9cd 7610 	strd	r7, r6, [sp, #64]	@ 0x40
200286c4:	e9cd 8913 	strd	r8, r9, [sp, #76]	@ 0x4c
200286c8:	f7ff fd84 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200286cc:	2800      	cmp	r0, #0
200286ce:	da5a      	bge.n	20028786 <mbedtls_mpi_div_mpi+0x230>
200286d0:	9901      	ldr	r1, [sp, #4]
200286d2:	a812      	add	r0, sp, #72	@ 0x48
200286d4:	f7ff fc9f 	bl	20028016 <mbedtls_mpi_shift_r>
200286d8:	e9dd 8913 	ldrd	r8, r9, [sp, #76]	@ 0x4c
200286dc:	2800      	cmp	r0, #0
200286de:	f47f af6e 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
200286e2:	f10a 33ff 	add.w	r3, sl, #4294967295
200286e6:	9301      	str	r3, [sp, #4]
200286e8:	9b08      	ldr	r3, [sp, #32]
200286ea:	9a02      	ldr	r2, [sp, #8]
200286ec:	3b01      	subs	r3, #1
200286ee:	9307      	str	r3, [sp, #28]
200286f0:	eb09 0383 	add.w	r3, r9, r3, lsl #2
200286f4:	930a      	str	r3, [sp, #40]	@ 0x28
200286f6:	9b08      	ldr	r3, [sp, #32]
200286f8:	f103 4380 	add.w	r3, r3, #1073741824	@ 0x40000000
200286fc:	3b02      	subs	r3, #2
200286fe:	eb09 0383 	add.w	r3, r9, r3, lsl #2
20028702:	930c      	str	r3, [sp, #48]	@ 0x30
20028704:	9b0b      	ldr	r3, [sp, #44]	@ 0x2c
20028706:	4413      	add	r3, r2
20028708:	469a      	mov	sl, r3
2002870a:	9b01      	ldr	r3, [sp, #4]
2002870c:	9a07      	ldr	r2, [sp, #28]
2002870e:	4293      	cmp	r3, r2
20028710:	d862      	bhi.n	200287d8 <mbedtls_mpi_div_mpi+0x282>
20028712:	9b05      	ldr	r3, [sp, #20]
20028714:	b16b      	cbz	r3, 20028732 <mbedtls_mpi_div_mpi+0x1dc>
20028716:	4618      	mov	r0, r3
20028718:	a915      	add	r1, sp, #84	@ 0x54
2002871a:	f7ff fb4b 	bl	20027db4 <mbedtls_mpi_copy>
2002871e:	2800      	cmp	r0, #0
20028720:	f47f af4d 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
20028724:	9b04      	ldr	r3, [sp, #16]
20028726:	9a09      	ldr	r2, [sp, #36]	@ 0x24
20028728:	681b      	ldr	r3, [r3, #0]
2002872a:	6812      	ldr	r2, [r2, #0]
2002872c:	4353      	muls	r3, r2
2002872e:	9a05      	ldr	r2, [sp, #20]
20028730:	6013      	str	r3, [r2, #0]
20028732:	9b03      	ldr	r3, [sp, #12]
20028734:	2b00      	cmp	r3, #0
20028736:	f000 810d 	beq.w	20028954 <mbedtls_mpi_div_mpi+0x3fe>
2002873a:	9906      	ldr	r1, [sp, #24]
2002873c:	a80f      	add	r0, sp, #60	@ 0x3c
2002873e:	e9cd 7610 	strd	r7, r6, [sp, #64]	@ 0x40
20028742:	f7ff fc68 	bl	20028016 <mbedtls_mpi_shift_r>
20028746:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
2002874a:	2800      	cmp	r0, #0
2002874c:	f47f af37 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
20028750:	9b04      	ldr	r3, [sp, #16]
20028752:	a90f      	add	r1, sp, #60	@ 0x3c
20028754:	681b      	ldr	r3, [r3, #0]
20028756:	9803      	ldr	r0, [sp, #12]
20028758:	930f      	str	r3, [sp, #60]	@ 0x3c
2002875a:	f7ff fb2b 	bl	20027db4 <mbedtls_mpi_copy>
2002875e:	4601      	mov	r1, r0
20028760:	2800      	cmp	r0, #0
20028762:	f47f af2c 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
20028766:	9001      	str	r0, [sp, #4]
20028768:	9803      	ldr	r0, [sp, #12]
2002876a:	f7ff fd74 	bl	20028256 <mbedtls_mpi_cmp_int>
2002876e:	9901      	ldr	r1, [sp, #4]
20028770:	b9c0      	cbnz	r0, 200287a4 <mbedtls_mpi_div_mpi+0x24e>
20028772:	2301      	movs	r3, #1
20028774:	9a03      	ldr	r2, [sp, #12]
20028776:	6013      	str	r3, [r2, #0]
20028778:	e014      	b.n	200287a4 <mbedtls_mpi_div_mpi+0x24e>
2002877a:	46ba      	mov	sl, r7
2002877c:	f8cd 8020 	str.w	r8, [sp, #32]
20028780:	f8cd b018 	str.w	fp, [sp, #24]
20028784:	e785      	b.n	20028692 <mbedtls_mpi_div_mpi+0x13c>
20028786:	f8db 2000 	ldr.w	r2, [fp]
2002878a:	a90f      	add	r1, sp, #60	@ 0x3c
2002878c:	3201      	adds	r2, #1
2002878e:	4608      	mov	r0, r1
20028790:	f8cb 2000 	str.w	r2, [fp]
20028794:	aa12      	add	r2, sp, #72	@ 0x48
20028796:	f7ff fe30 	bl	200283fa <mbedtls_mpi_sub_mpi>
2002879a:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
2002879e:	4601      	mov	r1, r0
200287a0:	2800      	cmp	r0, #0
200287a2:	d08b      	beq.n	200286bc <mbedtls_mpi_div_mpi+0x166>
200287a4:	a80f      	add	r0, sp, #60	@ 0x3c
200287a6:	9101      	str	r1, [sp, #4]
200287a8:	e9cd 7610 	strd	r7, r6, [sp, #64]	@ 0x40
200287ac:	f7ff fac1 	bl	20027d32 <mbedtls_mpi_free>
200287b0:	a812      	add	r0, sp, #72	@ 0x48
200287b2:	e9cd 8913 	strd	r8, r9, [sp, #76]	@ 0x4c
200287b6:	f7ff fabc 	bl	20027d32 <mbedtls_mpi_free>
200287ba:	9b02      	ldr	r3, [sp, #8]
200287bc:	a815      	add	r0, sp, #84	@ 0x54
200287be:	9317      	str	r3, [sp, #92]	@ 0x5c
200287c0:	f7ff fab7 	bl	20027d32 <mbedtls_mpi_free>
200287c4:	a818      	add	r0, sp, #96	@ 0x60
200287c6:	951a      	str	r5, [sp, #104]	@ 0x68
200287c8:	f7ff fab3 	bl	20027d32 <mbedtls_mpi_free>
200287cc:	a81b      	add	r0, sp, #108	@ 0x6c
200287ce:	941d      	str	r4, [sp, #116]	@ 0x74
200287d0:	f7ff faaf 	bl	20027d32 <mbedtls_mpi_free>
200287d4:	9901      	ldr	r1, [sp, #4]
200287d6:	e6e1      	b.n	2002859c <mbedtls_mpi_div_mpi+0x46>
200287d8:	9b01      	ldr	r3, [sp, #4]
200287da:	ea4f 0b83 	mov.w	fp, r3, lsl #2
200287de:	eb06 0383 	add.w	r3, r6, r3, lsl #2
200287e2:	930b      	str	r3, [sp, #44]	@ 0x2c
200287e4:	9b01      	ldr	r3, [sp, #4]
200287e6:	f1ab 0004 	sub.w	r0, fp, #4
200287ea:	f856 1023 	ldr.w	r1, [r6, r3, lsl #2]
200287ee:	9b0a      	ldr	r3, [sp, #40]	@ 0x28
200287f0:	681a      	ldr	r2, [r3, #0]
200287f2:	1833      	adds	r3, r6, r0
200287f4:	4291      	cmp	r1, r2
200287f6:	930d      	str	r3, [sp, #52]	@ 0x34
200287f8:	d255      	bcs.n	200288a6 <mbedtls_mpi_div_mpi+0x350>
200287fa:	2300      	movs	r3, #0
200287fc:	5830      	ldr	r0, [r6, r0]
200287fe:	f001 fd87 	bl	2002a310 <__aeabi_uldivmod>
20028802:	2900      	cmp	r1, #0
20028804:	bf14      	ite	ne
20028806:	f04f 33ff 	movne.w	r3, #4294967295
2002880a:	4603      	moveq	r3, r0
2002880c:	3301      	adds	r3, #1
2002880e:	f1ab 0b08 	sub.w	fp, fp, #8
20028812:	f84a 3c04 	str.w	r3, [sl, #-4]
20028816:	44b3      	add	fp, r6
20028818:	f85a 3c04 	ldr.w	r3, [sl, #-4]
2002881c:	2100      	movs	r1, #0
2002881e:	3b01      	subs	r3, #1
20028820:	f84a 3c04 	str.w	r3, [sl, #-4]
20028824:	a818      	add	r0, sp, #96	@ 0x60
20028826:	951a      	str	r5, [sp, #104]	@ 0x68
20028828:	f7ff faed 	bl	20027e06 <mbedtls_mpi_lset>
2002882c:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
2002882e:	2800      	cmp	r0, #0
20028830:	f47f aec5 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
20028834:	9b07      	ldr	r3, [sp, #28]
20028836:	2b00      	cmp	r3, #0
20028838:	d038      	beq.n	200288ac <mbedtls_mpi_div_mpi+0x356>
2002883a:	9b0c      	ldr	r3, [sp, #48]	@ 0x30
2002883c:	681b      	ldr	r3, [r3, #0]
2002883e:	602b      	str	r3, [r5, #0]
20028840:	9b0a      	ldr	r3, [sp, #40]	@ 0x28
20028842:	a918      	add	r1, sp, #96	@ 0x60
20028844:	681b      	ldr	r3, [r3, #0]
20028846:	4608      	mov	r0, r1
20028848:	606b      	str	r3, [r5, #4]
2002884a:	f85a 2c04 	ldr.w	r2, [sl, #-4]
2002884e:	f7ff fe75 	bl	2002853c <mbedtls_mpi_mul_int>
20028852:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
20028854:	4601      	mov	r1, r0
20028856:	2800      	cmp	r0, #0
20028858:	f47f aeb1 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
2002885c:	a81b      	add	r0, sp, #108	@ 0x6c
2002885e:	941d      	str	r4, [sp, #116]	@ 0x74
20028860:	f7ff fad1 	bl	20027e06 <mbedtls_mpi_lset>
20028864:	9c1d      	ldr	r4, [sp, #116]	@ 0x74
20028866:	2800      	cmp	r0, #0
20028868:	f47f aea9 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
2002886c:	9b01      	ldr	r3, [sp, #4]
2002886e:	a91b      	add	r1, sp, #108	@ 0x6c
20028870:	2b01      	cmp	r3, #1
20028872:	bf18      	it	ne
20028874:	f8db 0000 	ldrne.w	r0, [fp]
20028878:	9b0d      	ldr	r3, [sp, #52]	@ 0x34
2002887a:	6020      	str	r0, [r4, #0]
2002887c:	681b      	ldr	r3, [r3, #0]
2002887e:	a818      	add	r0, sp, #96	@ 0x60
20028880:	6063      	str	r3, [r4, #4]
20028882:	9b0b      	ldr	r3, [sp, #44]	@ 0x2c
20028884:	681b      	ldr	r3, [r3, #0]
20028886:	60a3      	str	r3, [r4, #8]
20028888:	f7ff fca4 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
2002888c:	2800      	cmp	r0, #0
2002888e:	dcc3      	bgt.n	20028818 <mbedtls_mpi_div_mpi+0x2c2>
20028890:	f85a 2c04 	ldr.w	r2, [sl, #-4]
20028894:	a912      	add	r1, sp, #72	@ 0x48
20028896:	a818      	add	r0, sp, #96	@ 0x60
20028898:	e9cd 8913 	strd	r8, r9, [sp, #76]	@ 0x4c
2002889c:	f7ff fe4e 	bl	2002853c <mbedtls_mpi_mul_int>
200288a0:	b130      	cbz	r0, 200288b0 <mbedtls_mpi_div_mpi+0x35a>
200288a2:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
200288a4:	e68b      	b.n	200285be <mbedtls_mpi_div_mpi+0x68>
200288a6:	f04f 33ff 	mov.w	r3, #4294967295
200288aa:	e7af      	b.n	2002880c <mbedtls_mpi_div_mpi+0x2b6>
200288ac:	9b07      	ldr	r3, [sp, #28]
200288ae:	e7c6      	b.n	2002883e <mbedtls_mpi_div_mpi+0x2e8>
200288b0:	f06f 0b1f 	mvn.w	fp, #31
200288b4:	9b08      	ldr	r3, [sp, #32]
200288b6:	a818      	add	r0, sp, #96	@ 0x60
200288b8:	fb0b fb03 	mul.w	fp, fp, r3
200288bc:	9b01      	ldr	r3, [sp, #4]
200288be:	eb0b 1b43 	add.w	fp, fp, r3, lsl #5
200288c2:	4659      	mov	r1, fp
200288c4:	f7ff fb4e 	bl	20027f64 <mbedtls_mpi_shift_l>
200288c8:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
200288ca:	2800      	cmp	r0, #0
200288cc:	f47f ae77 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
200288d0:	a90f      	add	r1, sp, #60	@ 0x3c
200288d2:	4608      	mov	r0, r1
200288d4:	aa18      	add	r2, sp, #96	@ 0x60
200288d6:	e9cd 7610 	strd	r7, r6, [sp, #64]	@ 0x40
200288da:	f7ff fd8e 	bl	200283fa <mbedtls_mpi_sub_mpi>
200288de:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
200288e2:	4601      	mov	r1, r0
200288e4:	2800      	cmp	r0, #0
200288e6:	f47f af5d 	bne.w	200287a4 <mbedtls_mpi_div_mpi+0x24e>
200288ea:	a80f      	add	r0, sp, #60	@ 0x3c
200288ec:	f7ff fcb3 	bl	20028256 <mbedtls_mpi_cmp_int>
200288f0:	2800      	cmp	r0, #0
200288f2:	da1d      	bge.n	20028930 <mbedtls_mpi_div_mpi+0x3da>
200288f4:	a912      	add	r1, sp, #72	@ 0x48
200288f6:	a818      	add	r0, sp, #96	@ 0x60
200288f8:	f7ff fa5c 	bl	20027db4 <mbedtls_mpi_copy>
200288fc:	2800      	cmp	r0, #0
200288fe:	d1d0      	bne.n	200288a2 <mbedtls_mpi_div_mpi+0x34c>
20028900:	4659      	mov	r1, fp
20028902:	a818      	add	r0, sp, #96	@ 0x60
20028904:	f7ff fb2e 	bl	20027f64 <mbedtls_mpi_shift_l>
20028908:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
2002890a:	2800      	cmp	r0, #0
2002890c:	f47f ae57 	bne.w	200285be <mbedtls_mpi_div_mpi+0x68>
20028910:	a90f      	add	r1, sp, #60	@ 0x3c
20028912:	4608      	mov	r0, r1
20028914:	aa18      	add	r2, sp, #96	@ 0x60
20028916:	f7ff fd4a 	bl	200283ae <mbedtls_mpi_add_mpi>
2002891a:	e9dd 7610 	ldrd	r7, r6, [sp, #64]	@ 0x40
2002891e:	4601      	mov	r1, r0
20028920:	2800      	cmp	r0, #0
20028922:	f47f af3f 	bne.w	200287a4 <mbedtls_mpi_div_mpi+0x24e>
20028926:	f85a 3c04 	ldr.w	r3, [sl, #-4]
2002892a:	3b01      	subs	r3, #1
2002892c:	f84a 3c04 	str.w	r3, [sl, #-4]
20028930:	9b01      	ldr	r3, [sp, #4]
20028932:	f1aa 0a04 	sub.w	sl, sl, #4
20028936:	3b01      	subs	r3, #1
20028938:	9301      	str	r3, [sp, #4]
2002893a:	e6e6      	b.n	2002870a <mbedtls_mpi_div_mpi+0x1b4>
2002893c:	4625      	mov	r5, r4
2002893e:	46a1      	mov	r9, r4
20028940:	46a0      	mov	r8, r4
20028942:	9402      	str	r4, [sp, #8]
20028944:	e63b      	b.n	200285be <mbedtls_mpi_div_mpi+0x68>
20028946:	4654      	mov	r4, sl
20028948:	4655      	mov	r5, sl
2002894a:	f8cd a008 	str.w	sl, [sp, #8]
2002894e:	e636      	b.n	200285be <mbedtls_mpi_div_mpi+0x68>
20028950:	462c      	mov	r4, r5
20028952:	e663      	b.n	2002861c <mbedtls_mpi_div_mpi+0xc6>
20028954:	9903      	ldr	r1, [sp, #12]
20028956:	e725      	b.n	200287a4 <mbedtls_mpi_div_mpi+0x24e>
20028958:	f06f 010b 	mvn.w	r1, #11
2002895c:	e61e      	b.n	2002859c <mbedtls_mpi_div_mpi+0x46>

2002895e <mbedtls_mpi_mod_mpi>:
2002895e:	b570      	push	{r4, r5, r6, lr}
20028960:	4604      	mov	r4, r0
20028962:	460d      	mov	r5, r1
20028964:	4610      	mov	r0, r2
20028966:	2100      	movs	r1, #0
20028968:	4616      	mov	r6, r2
2002896a:	f7ff fc74 	bl	20028256 <mbedtls_mpi_cmp_int>
2002896e:	2800      	cmp	r0, #0
20028970:	db24      	blt.n	200289bc <mbedtls_mpi_mod_mpi+0x5e>
20028972:	462a      	mov	r2, r5
20028974:	4633      	mov	r3, r6
20028976:	4621      	mov	r1, r4
20028978:	2000      	movs	r0, #0
2002897a:	f7ff fdec 	bl	20028556 <mbedtls_mpi_div_mpi>
2002897e:	4605      	mov	r5, r0
20028980:	b138      	cbz	r0, 20028992 <mbedtls_mpi_mod_mpi+0x34>
20028982:	4628      	mov	r0, r5
20028984:	bd70      	pop	{r4, r5, r6, pc}
20028986:	4632      	mov	r2, r6
20028988:	4621      	mov	r1, r4
2002898a:	4620      	mov	r0, r4
2002898c:	f7ff fd0f 	bl	200283ae <mbedtls_mpi_add_mpi>
20028990:	b990      	cbnz	r0, 200289b8 <mbedtls_mpi_mod_mpi+0x5a>
20028992:	2100      	movs	r1, #0
20028994:	4620      	mov	r0, r4
20028996:	f7ff fc5e 	bl	20028256 <mbedtls_mpi_cmp_int>
2002899a:	2800      	cmp	r0, #0
2002899c:	dbf3      	blt.n	20028986 <mbedtls_mpi_mod_mpi+0x28>
2002899e:	4631      	mov	r1, r6
200289a0:	4620      	mov	r0, r4
200289a2:	f7ff fc17 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200289a6:	2800      	cmp	r0, #0
200289a8:	dbeb      	blt.n	20028982 <mbedtls_mpi_mod_mpi+0x24>
200289aa:	4632      	mov	r2, r6
200289ac:	4621      	mov	r1, r4
200289ae:	4620      	mov	r0, r4
200289b0:	f7ff fd23 	bl	200283fa <mbedtls_mpi_sub_mpi>
200289b4:	2800      	cmp	r0, #0
200289b6:	d0f2      	beq.n	2002899e <mbedtls_mpi_mod_mpi+0x40>
200289b8:	4605      	mov	r5, r0
200289ba:	e7e2      	b.n	20028982 <mbedtls_mpi_mod_mpi+0x24>
200289bc:	f06f 0509 	mvn.w	r5, #9
200289c0:	e7df      	b.n	20028982 <mbedtls_mpi_mod_mpi+0x24>

200289c2 <mbedtls_mpi_exp_mod>:
200289c2:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200289c6:	4605      	mov	r5, r0
200289c8:	f2ad 6d54 	subw	sp, sp, #1620	@ 0x654
200289cc:	4688      	mov	r8, r1
200289ce:	4618      	mov	r0, r3
200289d0:	2100      	movs	r1, #0
200289d2:	461c      	mov	r4, r3
200289d4:	9203      	str	r2, [sp, #12]
200289d6:	f7ff fc3e 	bl	20028256 <mbedtls_mpi_cmp_int>
200289da:	2800      	cmp	r0, #0
200289dc:	f2c0 8202 	blt.w	20028de4 <mbedtls_mpi_exp_mod+0x422>
200289e0:	68a3      	ldr	r3, [r4, #8]
200289e2:	681f      	ldr	r7, [r3, #0]
200289e4:	f017 0301 	ands.w	r3, r7, #1
200289e8:	9305      	str	r3, [sp, #20]
200289ea:	f000 81fb 	beq.w	20028de4 <mbedtls_mpi_exp_mod+0x422>
200289ee:	2100      	movs	r1, #0
200289f0:	9803      	ldr	r0, [sp, #12]
200289f2:	f7ff fc30 	bl	20028256 <mbedtls_mpi_cmp_int>
200289f6:	2800      	cmp	r0, #0
200289f8:	f2c0 81f4 	blt.w	20028de4 <mbedtls_mpi_exp_mod+0x422>
200289fc:	2100      	movs	r1, #0
200289fe:	2301      	movs	r3, #1
20028a00:	f44f 62c0 	mov.w	r2, #1536	@ 0x600
20028a04:	a814      	add	r0, sp, #80	@ 0x50
20028a06:	e9cd 3108 	strd	r3, r1, [sp, #32]
20028a0a:	e9cd 130a 	strd	r1, r3, [sp, #40]	@ 0x28
20028a0e:	e9cd 110c 	strd	r1, r1, [sp, #48]	@ 0x30
20028a12:	e9cd 310e 	strd	r3, r1, [sp, #56]	@ 0x38
20028a16:	9110      	str	r1, [sp, #64]	@ 0x40
20028a18:	f001 ff1c 	bl	2002a854 <memset>
20028a1c:	9803      	ldr	r0, [sp, #12]
20028a1e:	f7ff fa26 	bl	20027e6e <mbedtls_mpi_bitlen>
20028a22:	f5b0 7f28 	cmp.w	r0, #672	@ 0x2a0
20028a26:	d233      	bcs.n	20028a90 <mbedtls_mpi_exp_mod+0xce>
20028a28:	28ef      	cmp	r0, #239	@ 0xef
20028a2a:	d833      	bhi.n	20028a94 <mbedtls_mpi_exp_mod+0xd2>
20028a2c:	284f      	cmp	r0, #79	@ 0x4f
20028a2e:	d833      	bhi.n	20028a98 <mbedtls_mpi_exp_mod+0xd6>
20028a30:	9b05      	ldr	r3, [sp, #20]
20028a32:	2818      	cmp	r0, #24
20028a34:	bf34      	ite	cc
20028a36:	461e      	movcc	r6, r3
20028a38:	2603      	movcs	r6, #3
20028a3a:	6863      	ldr	r3, [r4, #4]
20028a3c:	4628      	mov	r0, r5
20028a3e:	f103 0901 	add.w	r9, r3, #1
20028a42:	4649      	mov	r1, r9
20028a44:	f7ff f98a 	bl	20027d5c <mbedtls_mpi_grow>
20028a48:	b340      	cbz	r0, 20028a9c <mbedtls_mpi_exp_mod+0xda>
20028a4a:	f06f 090f 	mvn.w	r9, #15
20028a4e:	2301      	movs	r3, #1
20028a50:	1e74      	subs	r4, r6, #1
20028a52:	fa03 f506 	lsl.w	r5, r3, r6
20028a56:	260c      	movs	r6, #12
20028a58:	fa03 f404 	lsl.w	r4, r3, r4
20028a5c:	af14      	add	r7, sp, #80	@ 0x50
20028a5e:	42a5      	cmp	r5, r4
20028a60:	f200 81ba 	bhi.w	20028dd8 <mbedtls_mpi_exp_mod+0x416>
20028a64:	a817      	add	r0, sp, #92	@ 0x5c
20028a66:	f7ff f964 	bl	20027d32 <mbedtls_mpi_free>
20028a6a:	a80b      	add	r0, sp, #44	@ 0x2c
20028a6c:	f7ff f961 	bl	20027d32 <mbedtls_mpi_free>
20028a70:	a80e      	add	r0, sp, #56	@ 0x38
20028a72:	f7ff f95e 	bl	20027d32 <mbedtls_mpi_free>
20028a76:	f8dd 3678 	ldr.w	r3, [sp, #1656]	@ 0x678
20028a7a:	b10b      	cbz	r3, 20028a80 <mbedtls_mpi_exp_mod+0xbe>
20028a7c:	689b      	ldr	r3, [r3, #8]
20028a7e:	b913      	cbnz	r3, 20028a86 <mbedtls_mpi_exp_mod+0xc4>
20028a80:	a808      	add	r0, sp, #32
20028a82:	f7ff f956 	bl	20027d32 <mbedtls_mpi_free>
20028a86:	4648      	mov	r0, r9
20028a88:	f20d 6d54 	addw	sp, sp, #1620	@ 0x654
20028a8c:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20028a90:	2606      	movs	r6, #6
20028a92:	e7d2      	b.n	20028a3a <mbedtls_mpi_exp_mod+0x78>
20028a94:	2605      	movs	r6, #5
20028a96:	e7d0      	b.n	20028a3a <mbedtls_mpi_exp_mod+0x78>
20028a98:	2604      	movs	r6, #4
20028a9a:	e7ce      	b.n	20028a3a <mbedtls_mpi_exp_mod+0x78>
20028a9c:	4649      	mov	r1, r9
20028a9e:	a817      	add	r0, sp, #92	@ 0x5c
20028aa0:	f7ff f95c 	bl	20027d5c <mbedtls_mpi_grow>
20028aa4:	2800      	cmp	r0, #0
20028aa6:	d1d0      	bne.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028aa8:	ea4f 0149 	mov.w	r1, r9, lsl #1
20028aac:	a80b      	add	r0, sp, #44	@ 0x2c
20028aae:	f7ff f955 	bl	20027d5c <mbedtls_mpi_grow>
20028ab2:	2800      	cmp	r0, #0
20028ab4:	d1c9      	bne.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028ab6:	f8d8 3000 	ldr.w	r3, [r8]
20028aba:	9304      	str	r3, [sp, #16]
20028abc:	3301      	adds	r3, #1
20028abe:	d109      	bne.n	20028ad4 <mbedtls_mpi_exp_mod+0x112>
20028ac0:	4641      	mov	r1, r8
20028ac2:	a80e      	add	r0, sp, #56	@ 0x38
20028ac4:	f7ff f976 	bl	20027db4 <mbedtls_mpi_copy>
20028ac8:	2800      	cmp	r0, #0
20028aca:	d1be      	bne.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028acc:	2301      	movs	r3, #1
20028ace:	f10d 0838 	add.w	r8, sp, #56	@ 0x38
20028ad2:	930e      	str	r3, [sp, #56]	@ 0x38
20028ad4:	f8dd 3678 	ldr.w	r3, [sp, #1656]	@ 0x678
20028ad8:	b11b      	cbz	r3, 20028ae2 <mbedtls_mpi_exp_mod+0x120>
20028ada:	689b      	ldr	r3, [r3, #8]
20028adc:	2b00      	cmp	r3, #0
20028ade:	f040 80ab 	bne.w	20028c38 <mbedtls_mpi_exp_mod+0x276>
20028ae2:	2101      	movs	r1, #1
20028ae4:	a808      	add	r0, sp, #32
20028ae6:	f7ff f98e 	bl	20027e06 <mbedtls_mpi_lset>
20028aea:	2800      	cmp	r0, #0
20028aec:	d1ad      	bne.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028aee:	6861      	ldr	r1, [r4, #4]
20028af0:	a808      	add	r0, sp, #32
20028af2:	0189      	lsls	r1, r1, #6
20028af4:	f7ff fa36 	bl	20027f64 <mbedtls_mpi_shift_l>
20028af8:	2800      	cmp	r0, #0
20028afa:	d1a6      	bne.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028afc:	a908      	add	r1, sp, #32
20028afe:	4622      	mov	r2, r4
20028b00:	4608      	mov	r0, r1
20028b02:	f7ff ff2c 	bl	2002895e <mbedtls_mpi_mod_mpi>
20028b06:	4681      	mov	r9, r0
20028b08:	2800      	cmp	r0, #0
20028b0a:	d1a0      	bne.n	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028b0c:	f8dd 3678 	ldr.w	r3, [sp, #1656]	@ 0x678
20028b10:	b13b      	cbz	r3, 20028b22 <mbedtls_mpi_exp_mod+0x160>
20028b12:	f8dd 2678 	ldr.w	r2, [sp, #1656]	@ 0x678
20028b16:	ab08      	add	r3, sp, #32
20028b18:	cb03      	ldmia	r3!, {r0, r1}
20028b1a:	6010      	str	r0, [r2, #0]
20028b1c:	6818      	ldr	r0, [r3, #0]
20028b1e:	6051      	str	r1, [r2, #4]
20028b20:	6090      	str	r0, [r2, #8]
20028b22:	4621      	mov	r1, r4
20028b24:	4640      	mov	r0, r8
20028b26:	f7ff fb55 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20028b2a:	2800      	cmp	r0, #0
20028b2c:	f2c0 808d 	blt.w	20028c4a <mbedtls_mpi_exp_mod+0x288>
20028b30:	4622      	mov	r2, r4
20028b32:	4641      	mov	r1, r8
20028b34:	a817      	add	r0, sp, #92	@ 0x5c
20028b36:	f7ff ff12 	bl	2002895e <mbedtls_mpi_mod_mpi>
20028b3a:	4681      	mov	r9, r0
20028b3c:	2800      	cmp	r0, #0
20028b3e:	d186      	bne.n	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028b40:	1cba      	adds	r2, r7, #2
20028b42:	0052      	lsls	r2, r2, #1
20028b44:	f002 0208 	and.w	r2, r2, #8
20028b48:	443a      	add	r2, r7
20028b4a:	fb02 f307 	mul.w	r3, r2, r7
20028b4e:	f1c3 0302 	rsb	r3, r3, #2
20028b52:	4353      	muls	r3, r2
20028b54:	fb03 f207 	mul.w	r2, r3, r7
20028b58:	f1c2 0202 	rsb	r2, r2, #2
20028b5c:	4353      	muls	r3, r2
20028b5e:	435f      	muls	r7, r3
20028b60:	3f02      	subs	r7, #2
20028b62:	437b      	muls	r3, r7
20028b64:	f10d 0b2c 	add.w	fp, sp, #44	@ 0x2c
20028b68:	4622      	mov	r2, r4
20028b6a:	f8cd b000 	str.w	fp, [sp]
20028b6e:	a908      	add	r1, sp, #32
20028b70:	a817      	add	r0, sp, #92	@ 0x5c
20028b72:	9302      	str	r3, [sp, #8]
20028b74:	f7ff fac4 	bl	20028100 <mpi_montmul>
20028b78:	2800      	cmp	r0, #0
20028b7a:	f040 80e4 	bne.w	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028b7e:	4628      	mov	r0, r5
20028b80:	a908      	add	r1, sp, #32
20028b82:	f7ff f917 	bl	20027db4 <mbedtls_mpi_copy>
20028b86:	2800      	cmp	r0, #0
20028b88:	f47f af5f 	bne.w	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028b8c:	2301      	movs	r3, #1
20028b8e:	aa07      	add	r2, sp, #28
20028b90:	e9cd 3311 	strd	r3, r3, [sp, #68]	@ 0x44
20028b94:	9307      	str	r3, [sp, #28]
20028b96:	9213      	str	r2, [sp, #76]	@ 0x4c
20028b98:	4628      	mov	r0, r5
20028b9a:	4622      	mov	r2, r4
20028b9c:	9b02      	ldr	r3, [sp, #8]
20028b9e:	f8cd b000 	str.w	fp, [sp]
20028ba2:	a911      	add	r1, sp, #68	@ 0x44
20028ba4:	f7ff faac 	bl	20028100 <mpi_montmul>
20028ba8:	2800      	cmp	r0, #0
20028baa:	f040 80cc 	bne.w	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028bae:	2e01      	cmp	r6, #1
20028bb0:	d153      	bne.n	20028c5a <mbedtls_mpi_exp_mod+0x298>
20028bb2:	f04f 0900 	mov.w	r9, #0
20028bb6:	464f      	mov	r7, r9
20028bb8:	46ca      	mov	sl, r9
20028bba:	46c8      	mov	r8, r9
20028bbc:	9b03      	ldr	r3, [sp, #12]
20028bbe:	f8d3 b004 	ldr.w	fp, [r3, #4]
20028bc2:	f1ba 0f00 	cmp.w	sl, #0
20028bc6:	f040 80a1 	bne.w	20028d0c <mbedtls_mpi_exp_mod+0x34a>
20028bca:	f1bb 0f00 	cmp.w	fp, #0
20028bce:	f040 8099 	bne.w	20028d04 <mbedtls_mpi_exp_mod+0x342>
20028bd2:	f04f 0a01 	mov.w	sl, #1
20028bd6:	f10d 092c 	add.w	r9, sp, #44	@ 0x2c
20028bda:	fa0a fa06 	lsl.w	sl, sl, r6
20028bde:	45bb      	cmp	fp, r7
20028be0:	f040 80dd 	bne.w	20028d9e <mbedtls_mpi_exp_mod+0x3dc>
20028be4:	2301      	movs	r3, #1
20028be6:	aa07      	add	r2, sp, #28
20028be8:	e9cd 3311 	strd	r3, r3, [sp, #68]	@ 0x44
20028bec:	9307      	str	r3, [sp, #28]
20028bee:	9213      	str	r2, [sp, #76]	@ 0x4c
20028bf0:	f8cd 9000 	str.w	r9, [sp]
20028bf4:	4622      	mov	r2, r4
20028bf6:	4628      	mov	r0, r5
20028bf8:	9b02      	ldr	r3, [sp, #8]
20028bfa:	a911      	add	r1, sp, #68	@ 0x44
20028bfc:	f7ff fa80 	bl	20028100 <mpi_montmul>
20028c00:	4681      	mov	r9, r0
20028c02:	2800      	cmp	r0, #0
20028c04:	f040 809f 	bne.w	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028c08:	9b04      	ldr	r3, [sp, #16]
20028c0a:	3301      	adds	r3, #1
20028c0c:	f47f af1f 	bne.w	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028c10:	9b03      	ldr	r3, [sp, #12]
20028c12:	685b      	ldr	r3, [r3, #4]
20028c14:	2b00      	cmp	r3, #0
20028c16:	f43f af1a 	beq.w	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028c1a:	9b03      	ldr	r3, [sp, #12]
20028c1c:	689b      	ldr	r3, [r3, #8]
20028c1e:	681b      	ldr	r3, [r3, #0]
20028c20:	07db      	lsls	r3, r3, #31
20028c22:	f57f af14 	bpl.w	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028c26:	9b04      	ldr	r3, [sp, #16]
20028c28:	462a      	mov	r2, r5
20028c2a:	4621      	mov	r1, r4
20028c2c:	4628      	mov	r0, r5
20028c2e:	602b      	str	r3, [r5, #0]
20028c30:	f7ff fbbd 	bl	200283ae <mbedtls_mpi_add_mpi>
20028c34:	4681      	mov	r9, r0
20028c36:	e70a      	b.n	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028c38:	f8dd 2678 	ldr.w	r2, [sp, #1656]	@ 0x678
20028c3c:	ab08      	add	r3, sp, #32
20028c3e:	6810      	ldr	r0, [r2, #0]
20028c40:	6851      	ldr	r1, [r2, #4]
20028c42:	c303      	stmia	r3!, {r0, r1}
20028c44:	6890      	ldr	r0, [r2, #8]
20028c46:	6018      	str	r0, [r3, #0]
20028c48:	e76b      	b.n	20028b22 <mbedtls_mpi_exp_mod+0x160>
20028c4a:	4641      	mov	r1, r8
20028c4c:	a817      	add	r0, sp, #92	@ 0x5c
20028c4e:	f7ff f8b1 	bl	20027db4 <mbedtls_mpi_copy>
20028c52:	2800      	cmp	r0, #0
20028c54:	f43f af74 	beq.w	20028b40 <mbedtls_mpi_exp_mod+0x17e>
20028c58:	e6f7      	b.n	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028c5a:	f04f 0a0c 	mov.w	sl, #12
20028c5e:	1e77      	subs	r7, r6, #1
20028c60:	6861      	ldr	r1, [r4, #4]
20028c62:	fa0a fa07 	lsl.w	sl, sl, r7
20028c66:	f10d 0950 	add.w	r9, sp, #80	@ 0x50
20028c6a:	44d1      	add	r9, sl
20028c6c:	4648      	mov	r0, r9
20028c6e:	3101      	adds	r1, #1
20028c70:	f7ff f874 	bl	20027d5c <mbedtls_mpi_grow>
20028c74:	2800      	cmp	r0, #0
20028c76:	f47f aee8 	bne.w	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028c7a:	4648      	mov	r0, r9
20028c7c:	a917      	add	r1, sp, #92	@ 0x5c
20028c7e:	f7ff f899 	bl	20027db4 <mbedtls_mpi_copy>
20028c82:	2800      	cmp	r0, #0
20028c84:	f47f aee1 	bne.w	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028c88:	4680      	mov	r8, r0
20028c8a:	4622      	mov	r2, r4
20028c8c:	4649      	mov	r1, r9
20028c8e:	4648      	mov	r0, r9
20028c90:	9b02      	ldr	r3, [sp, #8]
20028c92:	f8cd b000 	str.w	fp, [sp]
20028c96:	f7ff fa33 	bl	20028100 <mpi_montmul>
20028c9a:	2800      	cmp	r0, #0
20028c9c:	d153      	bne.n	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028c9e:	f108 0801 	add.w	r8, r8, #1
20028ca2:	45b8      	cmp	r8, r7
20028ca4:	d3f1      	bcc.n	20028c8a <mbedtls_mpi_exp_mod+0x2c8>
20028ca6:	f04f 0801 	mov.w	r8, #1
20028caa:	f10d 0b50 	add.w	fp, sp, #80	@ 0x50
20028cae:	fa08 f707 	lsl.w	r7, r8, r7
20028cb2:	4447      	add	r7, r8
20028cb4:	44d3      	add	fp, sl
20028cb6:	fa08 f806 	lsl.w	r8, r8, r6
20028cba:	f10d 0a2c 	add.w	sl, sp, #44	@ 0x2c
20028cbe:	45b8      	cmp	r8, r7
20028cc0:	f67f af77 	bls.w	20028bb2 <mbedtls_mpi_exp_mod+0x1f0>
20028cc4:	6861      	ldr	r1, [r4, #4]
20028cc6:	f10b 090c 	add.w	r9, fp, #12
20028cca:	4648      	mov	r0, r9
20028ccc:	3101      	adds	r1, #1
20028cce:	f7ff f845 	bl	20027d5c <mbedtls_mpi_grow>
20028cd2:	2800      	cmp	r0, #0
20028cd4:	f47f aeb9 	bne.w	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028cd8:	4659      	mov	r1, fp
20028cda:	4648      	mov	r0, r9
20028cdc:	f7ff f86a 	bl	20027db4 <mbedtls_mpi_copy>
20028ce0:	2800      	cmp	r0, #0
20028ce2:	f47f aeb2 	bne.w	20028a4a <mbedtls_mpi_exp_mod+0x88>
20028ce6:	4622      	mov	r2, r4
20028ce8:	4648      	mov	r0, r9
20028cea:	9b02      	ldr	r3, [sp, #8]
20028cec:	f8cd a000 	str.w	sl, [sp]
20028cf0:	a917      	add	r1, sp, #92	@ 0x5c
20028cf2:	f7ff fa05 	bl	20028100 <mpi_montmul>
20028cf6:	bb30      	cbnz	r0, 20028d46 <mbedtls_mpi_exp_mod+0x384>
20028cf8:	46cb      	mov	fp, r9
20028cfa:	3701      	adds	r7, #1
20028cfc:	e7df      	b.n	20028cbe <mbedtls_mpi_exp_mod+0x2fc>
20028cfe:	f04f 0902 	mov.w	r9, #2
20028d02:	e75e      	b.n	20028bc2 <mbedtls_mpi_exp_mod+0x200>
20028d04:	f04f 0a20 	mov.w	sl, #32
20028d08:	f10b 3bff 	add.w	fp, fp, #4294967295
20028d0c:	9b03      	ldr	r3, [sp, #12]
20028d0e:	f10a 3aff 	add.w	sl, sl, #4294967295
20028d12:	689b      	ldr	r3, [r3, #8]
20028d14:	f853 302b 	ldr.w	r3, [r3, fp, lsl #2]
20028d18:	fa23 f30a 	lsr.w	r3, r3, sl
20028d1c:	f013 0301 	ands.w	r3, r3, #1
20028d20:	d114      	bne.n	20028d4c <mbedtls_mpi_exp_mod+0x38a>
20028d22:	f1b9 0f00 	cmp.w	r9, #0
20028d26:	f43f af4c 	beq.w	20028bc2 <mbedtls_mpi_exp_mod+0x200>
20028d2a:	f1b9 0f01 	cmp.w	r9, #1
20028d2e:	d10d      	bne.n	20028d4c <mbedtls_mpi_exp_mod+0x38a>
20028d30:	ab0b      	add	r3, sp, #44	@ 0x2c
20028d32:	9300      	str	r3, [sp, #0]
20028d34:	4622      	mov	r2, r4
20028d36:	4629      	mov	r1, r5
20028d38:	4628      	mov	r0, r5
20028d3a:	9b02      	ldr	r3, [sp, #8]
20028d3c:	f7ff f9e0 	bl	20028100 <mpi_montmul>
20028d40:	2800      	cmp	r0, #0
20028d42:	f43f af3e 	beq.w	20028bc2 <mbedtls_mpi_exp_mod+0x200>
20028d46:	f06f 0903 	mvn.w	r9, #3
20028d4a:	e680      	b.n	20028a4e <mbedtls_mpi_exp_mod+0x8c>
20028d4c:	3701      	adds	r7, #1
20028d4e:	1bf2      	subs	r2, r6, r7
20028d50:	4093      	lsls	r3, r2
20028d52:	42be      	cmp	r6, r7
20028d54:	ea48 0803 	orr.w	r8, r8, r3
20028d58:	d1d1      	bne.n	20028cfe <mbedtls_mpi_exp_mod+0x33c>
20028d5a:	f04f 0900 	mov.w	r9, #0
20028d5e:	ab0b      	add	r3, sp, #44	@ 0x2c
20028d60:	9300      	str	r3, [sp, #0]
20028d62:	4622      	mov	r2, r4
20028d64:	4629      	mov	r1, r5
20028d66:	4628      	mov	r0, r5
20028d68:	9b02      	ldr	r3, [sp, #8]
20028d6a:	f7ff f9c9 	bl	20028100 <mpi_montmul>
20028d6e:	2800      	cmp	r0, #0
20028d70:	d1e9      	bne.n	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028d72:	f109 0901 	add.w	r9, r9, #1
20028d76:	454f      	cmp	r7, r9
20028d78:	d8f1      	bhi.n	20028d5e <mbedtls_mpi_exp_mod+0x39c>
20028d7a:	200c      	movs	r0, #12
20028d7c:	ab0b      	add	r3, sp, #44	@ 0x2c
20028d7e:	a914      	add	r1, sp, #80	@ 0x50
20028d80:	fb00 1108 	mla	r1, r0, r8, r1
20028d84:	9300      	str	r3, [sp, #0]
20028d86:	4622      	mov	r2, r4
20028d88:	4628      	mov	r0, r5
20028d8a:	9b02      	ldr	r3, [sp, #8]
20028d8c:	f7ff f9b8 	bl	20028100 <mpi_montmul>
20028d90:	4607      	mov	r7, r0
20028d92:	2800      	cmp	r0, #0
20028d94:	d1d7      	bne.n	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028d96:	4680      	mov	r8, r0
20028d98:	f8dd 9014 	ldr.w	r9, [sp, #20]
20028d9c:	e711      	b.n	20028bc2 <mbedtls_mpi_exp_mod+0x200>
20028d9e:	4622      	mov	r2, r4
20028da0:	4629      	mov	r1, r5
20028da2:	4628      	mov	r0, r5
20028da4:	9b02      	ldr	r3, [sp, #8]
20028da6:	f8cd 9000 	str.w	r9, [sp]
20028daa:	f7ff f9a9 	bl	20028100 <mpi_montmul>
20028dae:	2800      	cmp	r0, #0
20028db0:	d1c9      	bne.n	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028db2:	ea4f 0848 	mov.w	r8, r8, lsl #1
20028db6:	ea18 0f0a 	tst.w	r8, sl
20028dba:	d102      	bne.n	20028dc2 <mbedtls_mpi_exp_mod+0x400>
20028dbc:	f10b 0b01 	add.w	fp, fp, #1
20028dc0:	e70d      	b.n	20028bde <mbedtls_mpi_exp_mod+0x21c>
20028dc2:	4622      	mov	r2, r4
20028dc4:	4628      	mov	r0, r5
20028dc6:	9b02      	ldr	r3, [sp, #8]
20028dc8:	f8cd 9000 	str.w	r9, [sp]
20028dcc:	a917      	add	r1, sp, #92	@ 0x5c
20028dce:	f7ff f997 	bl	20028100 <mpi_montmul>
20028dd2:	2800      	cmp	r0, #0
20028dd4:	d0f2      	beq.n	20028dbc <mbedtls_mpi_exp_mod+0x3fa>
20028dd6:	e7b6      	b.n	20028d46 <mbedtls_mpi_exp_mod+0x384>
20028dd8:	fb06 7004 	mla	r0, r6, r4, r7
20028ddc:	f7fe ffa9 	bl	20027d32 <mbedtls_mpi_free>
20028de0:	3401      	adds	r4, #1
20028de2:	e63c      	b.n	20028a5e <mbedtls_mpi_exp_mod+0x9c>
20028de4:	f06f 0903 	mvn.w	r9, #3
20028de8:	e64d      	b.n	20028a86 <mbedtls_mpi_exp_mod+0xc4>

20028dea <mbedtls_mpi_gcd>:
20028dea:	b570      	push	{r4, r5, r6, lr}
20028dec:	2300      	movs	r3, #0
20028dee:	2401      	movs	r4, #1
20028df0:	b086      	sub	sp, #24
20028df2:	4606      	mov	r6, r0
20028df4:	4668      	mov	r0, sp
20028df6:	4615      	mov	r5, r2
20028df8:	e9cd 4300 	strd	r4, r3, [sp]
20028dfc:	e9cd 3402 	strd	r3, r4, [sp, #8]
20028e00:	e9cd 3304 	strd	r3, r3, [sp, #16]
20028e04:	f7fe ffd6 	bl	20027db4 <mbedtls_mpi_copy>
20028e08:	b150      	cbz	r0, 20028e20 <mbedtls_mpi_gcd+0x36>
20028e0a:	f06f 040f 	mvn.w	r4, #15
20028e0e:	4668      	mov	r0, sp
20028e10:	f7fe ff8f 	bl	20027d32 <mbedtls_mpi_free>
20028e14:	a803      	add	r0, sp, #12
20028e16:	f7fe ff8c 	bl	20027d32 <mbedtls_mpi_free>
20028e1a:	4620      	mov	r0, r4
20028e1c:	b006      	add	sp, #24
20028e1e:	bd70      	pop	{r4, r5, r6, pc}
20028e20:	4629      	mov	r1, r5
20028e22:	a803      	add	r0, sp, #12
20028e24:	f7fe ffc6 	bl	20027db4 <mbedtls_mpi_copy>
20028e28:	2800      	cmp	r0, #0
20028e2a:	d1ee      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e2c:	4668      	mov	r0, sp
20028e2e:	f7ff f806 	bl	20027e3e <mbedtls_mpi_lsb>
20028e32:	4605      	mov	r5, r0
20028e34:	a803      	add	r0, sp, #12
20028e36:	f7ff f802 	bl	20027e3e <mbedtls_mpi_lsb>
20028e3a:	4285      	cmp	r5, r0
20028e3c:	bf28      	it	cs
20028e3e:	4605      	movcs	r5, r0
20028e40:	4668      	mov	r0, sp
20028e42:	4629      	mov	r1, r5
20028e44:	f7ff f8e7 	bl	20028016 <mbedtls_mpi_shift_r>
20028e48:	2800      	cmp	r0, #0
20028e4a:	d1de      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e4c:	4629      	mov	r1, r5
20028e4e:	a803      	add	r0, sp, #12
20028e50:	f7ff f8e1 	bl	20028016 <mbedtls_mpi_shift_r>
20028e54:	2800      	cmp	r0, #0
20028e56:	d1d8      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e58:	9403      	str	r4, [sp, #12]
20028e5a:	9400      	str	r4, [sp, #0]
20028e5c:	2100      	movs	r1, #0
20028e5e:	4668      	mov	r0, sp
20028e60:	f7ff f9f9 	bl	20028256 <mbedtls_mpi_cmp_int>
20028e64:	b968      	cbnz	r0, 20028e82 <mbedtls_mpi_gcd+0x98>
20028e66:	4629      	mov	r1, r5
20028e68:	a803      	add	r0, sp, #12
20028e6a:	f7ff f87b 	bl	20027f64 <mbedtls_mpi_shift_l>
20028e6e:	2800      	cmp	r0, #0
20028e70:	d1cb      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e72:	4630      	mov	r0, r6
20028e74:	a903      	add	r1, sp, #12
20028e76:	f7fe ff9d 	bl	20027db4 <mbedtls_mpi_copy>
20028e7a:	4604      	mov	r4, r0
20028e7c:	2800      	cmp	r0, #0
20028e7e:	d0c6      	beq.n	20028e0e <mbedtls_mpi_gcd+0x24>
20028e80:	e7c3      	b.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e82:	4668      	mov	r0, sp
20028e84:	f7fe ffdb 	bl	20027e3e <mbedtls_mpi_lsb>
20028e88:	4601      	mov	r1, r0
20028e8a:	4668      	mov	r0, sp
20028e8c:	f7ff f8c3 	bl	20028016 <mbedtls_mpi_shift_r>
20028e90:	2800      	cmp	r0, #0
20028e92:	d1ba      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028e94:	a803      	add	r0, sp, #12
20028e96:	f7fe ffd2 	bl	20027e3e <mbedtls_mpi_lsb>
20028e9a:	4601      	mov	r1, r0
20028e9c:	a803      	add	r0, sp, #12
20028e9e:	f7ff f8ba 	bl	20028016 <mbedtls_mpi_shift_r>
20028ea2:	2800      	cmp	r0, #0
20028ea4:	d1b1      	bne.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028ea6:	4668      	mov	r0, sp
20028ea8:	a903      	add	r1, sp, #12
20028eaa:	f7ff f993 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20028eae:	2800      	cmp	r0, #0
20028eb0:	db0e      	blt.n	20028ed0 <mbedtls_mpi_gcd+0xe6>
20028eb2:	4669      	mov	r1, sp
20028eb4:	4668      	mov	r0, sp
20028eb6:	aa03      	add	r2, sp, #12
20028eb8:	f7ff fa3c 	bl	20028334 <mbedtls_mpi_sub_abs>
20028ebc:	4604      	mov	r4, r0
20028ebe:	2800      	cmp	r0, #0
20028ec0:	d1a5      	bne.n	20028e0e <mbedtls_mpi_gcd+0x24>
20028ec2:	2101      	movs	r1, #1
20028ec4:	4668      	mov	r0, sp
20028ec6:	f7ff f8a6 	bl	20028016 <mbedtls_mpi_shift_r>
20028eca:	2800      	cmp	r0, #0
20028ecc:	d0c6      	beq.n	20028e5c <mbedtls_mpi_gcd+0x72>
20028ece:	e79c      	b.n	20028e0a <mbedtls_mpi_gcd+0x20>
20028ed0:	a903      	add	r1, sp, #12
20028ed2:	466a      	mov	r2, sp
20028ed4:	4608      	mov	r0, r1
20028ed6:	f7ff fa2d 	bl	20028334 <mbedtls_mpi_sub_abs>
20028eda:	4604      	mov	r4, r0
20028edc:	2800      	cmp	r0, #0
20028ede:	d196      	bne.n	20028e0e <mbedtls_mpi_gcd+0x24>
20028ee0:	2101      	movs	r1, #1
20028ee2:	a803      	add	r0, sp, #12
20028ee4:	e7ef      	b.n	20028ec6 <mbedtls_mpi_gcd+0xdc>

20028ee6 <mbedtls_mpi_fill_random>:
20028ee6:	b570      	push	{r4, r5, r6, lr}
20028ee8:	f5b1 6f80 	cmp.w	r1, #1024	@ 0x400
20028eec:	4605      	mov	r5, r0
20028eee:	460c      	mov	r4, r1
20028ef0:	4616      	mov	r6, r2
20028ef2:	4618      	mov	r0, r3
20028ef4:	f5ad 6d80 	sub.w	sp, sp, #1024	@ 0x400
20028ef8:	d80f      	bhi.n	20028f1a <mbedtls_mpi_fill_random+0x34>
20028efa:	460a      	mov	r2, r1
20028efc:	4669      	mov	r1, sp
20028efe:	47b0      	blx	r6
20028f00:	b940      	cbnz	r0, 20028f14 <mbedtls_mpi_fill_random+0x2e>
20028f02:	4622      	mov	r2, r4
20028f04:	4669      	mov	r1, sp
20028f06:	4628      	mov	r0, r5
20028f08:	f7fe ffd4 	bl	20027eb4 <mbedtls_mpi_read_binary>
20028f0c:	2800      	cmp	r0, #0
20028f0e:	bf18      	it	ne
20028f10:	f06f 000f 	mvnne.w	r0, #15
20028f14:	f50d 6d80 	add.w	sp, sp, #1024	@ 0x400
20028f18:	bd70      	pop	{r4, r5, r6, pc}
20028f1a:	f06f 0003 	mvn.w	r0, #3
20028f1e:	e7f9      	b.n	20028f14 <mbedtls_mpi_fill_random+0x2e>

20028f20 <mbedtls_mpi_inv_mod>:
20028f20:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20028f24:	b09f      	sub	sp, #124	@ 0x7c
20028f26:	9001      	str	r0, [sp, #4]
20028f28:	460f      	mov	r7, r1
20028f2a:	4610      	mov	r0, r2
20028f2c:	2101      	movs	r1, #1
20028f2e:	4692      	mov	sl, r2
20028f30:	f7ff f991 	bl	20028256 <mbedtls_mpi_cmp_int>
20028f34:	2800      	cmp	r0, #0
20028f36:	f340 81b5 	ble.w	200292a4 <mbedtls_mpi_inv_mod+0x384>
20028f3a:	2500      	movs	r5, #0
20028f3c:	2601      	movs	r6, #1
20028f3e:	4652      	mov	r2, sl
20028f40:	4639      	mov	r1, r7
20028f42:	a803      	add	r0, sp, #12
20028f44:	e9cd 6506 	strd	r6, r5, [sp, #24]
20028f48:	e9cd 5608 	strd	r5, r6, [sp, #32]
20028f4c:	e9cd 650c 	strd	r6, r5, [sp, #48]	@ 0x30
20028f50:	e9cd 650f 	strd	r6, r5, [sp, #60]	@ 0x3c
20028f54:	e9cd 6503 	strd	r6, r5, [sp, #12]
20028f58:	e9cd 6512 	strd	r6, r5, [sp, #72]	@ 0x48
20028f5c:	e9cd 5614 	strd	r5, r6, [sp, #80]	@ 0x50
20028f60:	e9cd 6518 	strd	r6, r5, [sp, #96]	@ 0x60
20028f64:	e9cd 651b 	strd	r6, r5, [sp, #108]	@ 0x6c
20028f68:	950a      	str	r5, [sp, #40]	@ 0x28
20028f6a:	9505      	str	r5, [sp, #20]
20028f6c:	9516      	str	r5, [sp, #88]	@ 0x58
20028f6e:	f7ff ff3c 	bl	20028dea <mbedtls_mpi_gcd>
20028f72:	4604      	mov	r4, r0
20028f74:	2800      	cmp	r0, #0
20028f76:	f040 8182 	bne.w	2002927e <mbedtls_mpi_inv_mod+0x35e>
20028f7a:	4631      	mov	r1, r6
20028f7c:	a803      	add	r0, sp, #12
20028f7e:	f7ff f96a 	bl	20028256 <mbedtls_mpi_cmp_int>
20028f82:	4605      	mov	r5, r0
20028f84:	2800      	cmp	r0, #0
20028f86:	f040 8171 	bne.w	2002926c <mbedtls_mpi_inv_mod+0x34c>
20028f8a:	4652      	mov	r2, sl
20028f8c:	4639      	mov	r1, r7
20028f8e:	a806      	add	r0, sp, #24
20028f90:	f7ff fce5 	bl	2002895e <mbedtls_mpi_mod_mpi>
20028f94:	4604      	mov	r4, r0
20028f96:	2800      	cmp	r0, #0
20028f98:	f040 8171 	bne.w	2002927e <mbedtls_mpi_inv_mod+0x35e>
20028f9c:	900b      	str	r0, [sp, #44]	@ 0x2c
20028f9e:	a906      	add	r1, sp, #24
20028fa0:	a809      	add	r0, sp, #36	@ 0x24
20028fa2:	f7fe ff07 	bl	20027db4 <mbedtls_mpi_copy>
20028fa6:	f8dd 902c 	ldr.w	r9, [sp, #44]	@ 0x2c
20028faa:	b920      	cbnz	r0, 20028fb6 <mbedtls_mpi_inv_mod+0x96>
20028fac:	4651      	mov	r1, sl
20028fae:	a812      	add	r0, sp, #72	@ 0x48
20028fb0:	f7fe ff00 	bl	20027db4 <mbedtls_mpi_copy>
20028fb4:	b130      	cbz	r0, 20028fc4 <mbedtls_mpi_inv_mod+0xa4>
20028fb6:	f04f 0b00 	mov.w	fp, #0
20028fba:	465d      	mov	r5, fp
20028fbc:	46d8      	mov	r8, fp
20028fbe:	465e      	mov	r6, fp
20028fc0:	465f      	mov	r7, fp
20028fc2:	e0f5      	b.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
20028fc4:	9017      	str	r0, [sp, #92]	@ 0x5c
20028fc6:	4651      	mov	r1, sl
20028fc8:	a815      	add	r0, sp, #84	@ 0x54
20028fca:	f7fe fef3 	bl	20027db4 <mbedtls_mpi_copy>
20028fce:	f8dd 805c 	ldr.w	r8, [sp, #92]	@ 0x5c
20028fd2:	2800      	cmp	r0, #0
20028fd4:	f040 8159 	bne.w	2002928a <mbedtls_mpi_inv_mod+0x36a>
20028fd8:	4631      	mov	r1, r6
20028fda:	900e      	str	r0, [sp, #56]	@ 0x38
20028fdc:	a80c      	add	r0, sp, #48	@ 0x30
20028fde:	f7fe ff12 	bl	20027e06 <mbedtls_mpi_lset>
20028fe2:	9f0e      	ldr	r7, [sp, #56]	@ 0x38
20028fe4:	4601      	mov	r1, r0
20028fe6:	2800      	cmp	r0, #0
20028fe8:	f040 8152 	bne.w	20029290 <mbedtls_mpi_inv_mod+0x370>
20028fec:	9011      	str	r0, [sp, #68]	@ 0x44
20028fee:	a80f      	add	r0, sp, #60	@ 0x3c
20028ff0:	f7fe ff09 	bl	20027e06 <mbedtls_mpi_lset>
20028ff4:	9e11      	ldr	r6, [sp, #68]	@ 0x44
20028ff6:	4683      	mov	fp, r0
20028ff8:	2800      	cmp	r0, #0
20028ffa:	f040 814d 	bne.w	20029298 <mbedtls_mpi_inv_mod+0x378>
20028ffe:	4601      	mov	r1, r0
20029000:	901a      	str	r0, [sp, #104]	@ 0x68
20029002:	a818      	add	r0, sp, #96	@ 0x60
20029004:	f7fe feff 	bl	20027e06 <mbedtls_mpi_lset>
20029008:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
2002900a:	2800      	cmp	r0, #0
2002900c:	f040 8147 	bne.w	2002929e <mbedtls_mpi_inv_mod+0x37e>
20029010:	2101      	movs	r1, #1
20029012:	a81b      	add	r0, sp, #108	@ 0x6c
20029014:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
20029018:	f7fe fef5 	bl	20027e06 <mbedtls_mpi_lset>
2002901c:	f8dd b074 	ldr.w	fp, [sp, #116]	@ 0x74
20029020:	2800      	cmp	r0, #0
20029022:	f040 80c5 	bne.w	200291b0 <mbedtls_mpi_inv_mod+0x290>
20029026:	f8d9 2000 	ldr.w	r2, [r9]
2002902a:	07d0      	lsls	r0, r2, #31
2002902c:	d554      	bpl.n	200290d8 <mbedtls_mpi_inv_mod+0x1b8>
2002902e:	f8d8 2000 	ldr.w	r2, [r8]
20029032:	07d3      	lsls	r3, r2, #31
20029034:	f140 8083 	bpl.w	2002913e <mbedtls_mpi_inv_mod+0x21e>
20029038:	a915      	add	r1, sp, #84	@ 0x54
2002903a:	a809      	add	r0, sp, #36	@ 0x24
2002903c:	f8cd 902c 	str.w	r9, [sp, #44]	@ 0x2c
20029040:	f8cd 805c 	str.w	r8, [sp, #92]	@ 0x5c
20029044:	f7ff f8c6 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20029048:	2800      	cmp	r0, #0
2002904a:	f2c0 80b4 	blt.w	200291b6 <mbedtls_mpi_inv_mod+0x296>
2002904e:	a909      	add	r1, sp, #36	@ 0x24
20029050:	4608      	mov	r0, r1
20029052:	aa15      	add	r2, sp, #84	@ 0x54
20029054:	f7ff f9d1 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029058:	f8dd 902c 	ldr.w	r9, [sp, #44]	@ 0x2c
2002905c:	4604      	mov	r4, r0
2002905e:	2800      	cmp	r0, #0
20029060:	f040 80d1 	bne.w	20029206 <mbedtls_mpi_inv_mod+0x2e6>
20029064:	a90c      	add	r1, sp, #48	@ 0x30
20029066:	4608      	mov	r0, r1
20029068:	aa18      	add	r2, sp, #96	@ 0x60
2002906a:	970e      	str	r7, [sp, #56]	@ 0x38
2002906c:	951a      	str	r5, [sp, #104]	@ 0x68
2002906e:	f7ff f9c4 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029072:	9f0e      	ldr	r7, [sp, #56]	@ 0x38
20029074:	4604      	mov	r4, r0
20029076:	2800      	cmp	r0, #0
20029078:	f040 80c5 	bne.w	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002907c:	a90f      	add	r1, sp, #60	@ 0x3c
2002907e:	4608      	mov	r0, r1
20029080:	aa1b      	add	r2, sp, #108	@ 0x6c
20029082:	9611      	str	r6, [sp, #68]	@ 0x44
20029084:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
20029088:	f7ff f9b7 	bl	200283fa <mbedtls_mpi_sub_mpi>
2002908c:	9e11      	ldr	r6, [sp, #68]	@ 0x44
2002908e:	4604      	mov	r4, r0
20029090:	2800      	cmp	r0, #0
20029092:	f040 80b8 	bne.w	20029206 <mbedtls_mpi_inv_mod+0x2e6>
20029096:	2100      	movs	r1, #0
20029098:	a809      	add	r0, sp, #36	@ 0x24
2002909a:	f8cd 902c 	str.w	r9, [sp, #44]	@ 0x2c
2002909e:	f7ff f8da 	bl	20028256 <mbedtls_mpi_cmp_int>
200290a2:	2800      	cmp	r0, #0
200290a4:	d1bf      	bne.n	20029026 <mbedtls_mpi_inv_mod+0x106>
200290a6:	2100      	movs	r1, #0
200290a8:	a818      	add	r0, sp, #96	@ 0x60
200290aa:	951a      	str	r5, [sp, #104]	@ 0x68
200290ac:	f7ff f8d3 	bl	20028256 <mbedtls_mpi_cmp_int>
200290b0:	2800      	cmp	r0, #0
200290b2:	f2c0 809e 	blt.w	200291f2 <mbedtls_mpi_inv_mod+0x2d2>
200290b6:	4651      	mov	r1, sl
200290b8:	a818      	add	r0, sp, #96	@ 0x60
200290ba:	951a      	str	r5, [sp, #104]	@ 0x68
200290bc:	f7ff f88a 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200290c0:	2800      	cmp	r0, #0
200290c2:	f280 80c8 	bge.w	20029256 <mbedtls_mpi_inv_mod+0x336>
200290c6:	9801      	ldr	r0, [sp, #4]
200290c8:	a918      	add	r1, sp, #96	@ 0x60
200290ca:	f7fe fe73 	bl	20027db4 <mbedtls_mpi_copy>
200290ce:	1e04      	subs	r4, r0, #0
200290d0:	bf18      	it	ne
200290d2:	f06f 040f 	mvnne.w	r4, #15
200290d6:	e096      	b.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
200290d8:	2101      	movs	r1, #1
200290da:	a809      	add	r0, sp, #36	@ 0x24
200290dc:	f8cd 902c 	str.w	r9, [sp, #44]	@ 0x2c
200290e0:	f7fe ff99 	bl	20028016 <mbedtls_mpi_shift_r>
200290e4:	f8dd 902c 	ldr.w	r9, [sp, #44]	@ 0x2c
200290e8:	2800      	cmp	r0, #0
200290ea:	d161      	bne.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
200290ec:	683a      	ldr	r2, [r7, #0]
200290ee:	07d3      	lsls	r3, r2, #31
200290f0:	d402      	bmi.n	200290f8 <mbedtls_mpi_inv_mod+0x1d8>
200290f2:	6832      	ldr	r2, [r6, #0]
200290f4:	07d4      	lsls	r4, r2, #31
200290f6:	d513      	bpl.n	20029120 <mbedtls_mpi_inv_mod+0x200>
200290f8:	a90c      	add	r1, sp, #48	@ 0x30
200290fa:	4608      	mov	r0, r1
200290fc:	aa12      	add	r2, sp, #72	@ 0x48
200290fe:	970e      	str	r7, [sp, #56]	@ 0x38
20029100:	f7ff f955 	bl	200283ae <mbedtls_mpi_add_mpi>
20029104:	9f0e      	ldr	r7, [sp, #56]	@ 0x38
20029106:	4604      	mov	r4, r0
20029108:	2800      	cmp	r0, #0
2002910a:	d17c      	bne.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002910c:	a90f      	add	r1, sp, #60	@ 0x3c
2002910e:	4608      	mov	r0, r1
20029110:	aa06      	add	r2, sp, #24
20029112:	9611      	str	r6, [sp, #68]	@ 0x44
20029114:	f7ff f971 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029118:	9e11      	ldr	r6, [sp, #68]	@ 0x44
2002911a:	4604      	mov	r4, r0
2002911c:	2800      	cmp	r0, #0
2002911e:	d172      	bne.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
20029120:	2101      	movs	r1, #1
20029122:	a80c      	add	r0, sp, #48	@ 0x30
20029124:	970e      	str	r7, [sp, #56]	@ 0x38
20029126:	f7fe ff76 	bl	20028016 <mbedtls_mpi_shift_r>
2002912a:	9f0e      	ldr	r7, [sp, #56]	@ 0x38
2002912c:	2800      	cmp	r0, #0
2002912e:	d13f      	bne.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
20029130:	2101      	movs	r1, #1
20029132:	a80f      	add	r0, sp, #60	@ 0x3c
20029134:	9611      	str	r6, [sp, #68]	@ 0x44
20029136:	f7fe ff6e 	bl	20028016 <mbedtls_mpi_shift_r>
2002913a:	9e11      	ldr	r6, [sp, #68]	@ 0x44
2002913c:	e770      	b.n	20029020 <mbedtls_mpi_inv_mod+0x100>
2002913e:	2101      	movs	r1, #1
20029140:	a815      	add	r0, sp, #84	@ 0x54
20029142:	f8cd 805c 	str.w	r8, [sp, #92]	@ 0x5c
20029146:	f7fe ff66 	bl	20028016 <mbedtls_mpi_shift_r>
2002914a:	f8dd 805c 	ldr.w	r8, [sp, #92]	@ 0x5c
2002914e:	2800      	cmp	r0, #0
20029150:	d12e      	bne.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
20029152:	682a      	ldr	r2, [r5, #0]
20029154:	07d1      	lsls	r1, r2, #31
20029156:	d403      	bmi.n	20029160 <mbedtls_mpi_inv_mod+0x240>
20029158:	f8db 2000 	ldr.w	r2, [fp]
2002915c:	07d2      	lsls	r2, r2, #31
2002915e:	d515      	bpl.n	2002918c <mbedtls_mpi_inv_mod+0x26c>
20029160:	a918      	add	r1, sp, #96	@ 0x60
20029162:	4608      	mov	r0, r1
20029164:	aa12      	add	r2, sp, #72	@ 0x48
20029166:	951a      	str	r5, [sp, #104]	@ 0x68
20029168:	f7ff f921 	bl	200283ae <mbedtls_mpi_add_mpi>
2002916c:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
2002916e:	4604      	mov	r4, r0
20029170:	2800      	cmp	r0, #0
20029172:	d148      	bne.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
20029174:	a91b      	add	r1, sp, #108	@ 0x6c
20029176:	4608      	mov	r0, r1
20029178:	aa06      	add	r2, sp, #24
2002917a:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
2002917e:	f7ff f93c 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029182:	f8dd b074 	ldr.w	fp, [sp, #116]	@ 0x74
20029186:	4604      	mov	r4, r0
20029188:	2800      	cmp	r0, #0
2002918a:	d13c      	bne.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002918c:	2101      	movs	r1, #1
2002918e:	a818      	add	r0, sp, #96	@ 0x60
20029190:	951a      	str	r5, [sp, #104]	@ 0x68
20029192:	f7fe ff40 	bl	20028016 <mbedtls_mpi_shift_r>
20029196:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
20029198:	b950      	cbnz	r0, 200291b0 <mbedtls_mpi_inv_mod+0x290>
2002919a:	2101      	movs	r1, #1
2002919c:	a81b      	add	r0, sp, #108	@ 0x6c
2002919e:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
200291a2:	f7fe ff38 	bl	20028016 <mbedtls_mpi_shift_r>
200291a6:	f8dd b074 	ldr.w	fp, [sp, #116]	@ 0x74
200291aa:	2800      	cmp	r0, #0
200291ac:	f43f af3f 	beq.w	2002902e <mbedtls_mpi_inv_mod+0x10e>
200291b0:	f06f 040f 	mvn.w	r4, #15
200291b4:	e027      	b.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
200291b6:	a915      	add	r1, sp, #84	@ 0x54
200291b8:	4608      	mov	r0, r1
200291ba:	aa09      	add	r2, sp, #36	@ 0x24
200291bc:	f7ff f91d 	bl	200283fa <mbedtls_mpi_sub_mpi>
200291c0:	f8dd 805c 	ldr.w	r8, [sp, #92]	@ 0x5c
200291c4:	4604      	mov	r4, r0
200291c6:	b9f0      	cbnz	r0, 20029206 <mbedtls_mpi_inv_mod+0x2e6>
200291c8:	a918      	add	r1, sp, #96	@ 0x60
200291ca:	4608      	mov	r0, r1
200291cc:	aa0c      	add	r2, sp, #48	@ 0x30
200291ce:	951a      	str	r5, [sp, #104]	@ 0x68
200291d0:	970e      	str	r7, [sp, #56]	@ 0x38
200291d2:	f7ff f912 	bl	200283fa <mbedtls_mpi_sub_mpi>
200291d6:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
200291d8:	4604      	mov	r4, r0
200291da:	b9a0      	cbnz	r0, 20029206 <mbedtls_mpi_inv_mod+0x2e6>
200291dc:	a91b      	add	r1, sp, #108	@ 0x6c
200291de:	4608      	mov	r0, r1
200291e0:	aa0f      	add	r2, sp, #60	@ 0x3c
200291e2:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
200291e6:	9611      	str	r6, [sp, #68]	@ 0x44
200291e8:	f7ff f907 	bl	200283fa <mbedtls_mpi_sub_mpi>
200291ec:	f8dd b074 	ldr.w	fp, [sp, #116]	@ 0x74
200291f0:	e74d      	b.n	2002908e <mbedtls_mpi_inv_mod+0x16e>
200291f2:	a918      	add	r1, sp, #96	@ 0x60
200291f4:	4652      	mov	r2, sl
200291f6:	4608      	mov	r0, r1
200291f8:	f7ff f8d9 	bl	200283ae <mbedtls_mpi_add_mpi>
200291fc:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
200291fe:	4604      	mov	r4, r0
20029200:	2800      	cmp	r0, #0
20029202:	f43f af50 	beq.w	200290a6 <mbedtls_mpi_inv_mod+0x186>
20029206:	a806      	add	r0, sp, #24
20029208:	f7fe fd93 	bl	20027d32 <mbedtls_mpi_free>
2002920c:	a809      	add	r0, sp, #36	@ 0x24
2002920e:	f8cd 902c 	str.w	r9, [sp, #44]	@ 0x2c
20029212:	f7fe fd8e 	bl	20027d32 <mbedtls_mpi_free>
20029216:	a80c      	add	r0, sp, #48	@ 0x30
20029218:	970e      	str	r7, [sp, #56]	@ 0x38
2002921a:	f7fe fd8a 	bl	20027d32 <mbedtls_mpi_free>
2002921e:	a80f      	add	r0, sp, #60	@ 0x3c
20029220:	9611      	str	r6, [sp, #68]	@ 0x44
20029222:	f7fe fd86 	bl	20027d32 <mbedtls_mpi_free>
20029226:	a803      	add	r0, sp, #12
20029228:	f7fe fd83 	bl	20027d32 <mbedtls_mpi_free>
2002922c:	a812      	add	r0, sp, #72	@ 0x48
2002922e:	f7fe fd80 	bl	20027d32 <mbedtls_mpi_free>
20029232:	a815      	add	r0, sp, #84	@ 0x54
20029234:	f8cd 805c 	str.w	r8, [sp, #92]	@ 0x5c
20029238:	f7fe fd7b 	bl	20027d32 <mbedtls_mpi_free>
2002923c:	a818      	add	r0, sp, #96	@ 0x60
2002923e:	951a      	str	r5, [sp, #104]	@ 0x68
20029240:	f7fe fd77 	bl	20027d32 <mbedtls_mpi_free>
20029244:	a81b      	add	r0, sp, #108	@ 0x6c
20029246:	f8cd b074 	str.w	fp, [sp, #116]	@ 0x74
2002924a:	f7fe fd72 	bl	20027d32 <mbedtls_mpi_free>
2002924e:	4620      	mov	r0, r4
20029250:	b01f      	add	sp, #124	@ 0x7c
20029252:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20029256:	a918      	add	r1, sp, #96	@ 0x60
20029258:	4652      	mov	r2, sl
2002925a:	4608      	mov	r0, r1
2002925c:	f7ff f8cd 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029260:	9d1a      	ldr	r5, [sp, #104]	@ 0x68
20029262:	4604      	mov	r4, r0
20029264:	2800      	cmp	r0, #0
20029266:	f43f af26 	beq.w	200290b6 <mbedtls_mpi_inv_mod+0x196>
2002926a:	e7cc      	b.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002926c:	46a3      	mov	fp, r4
2002926e:	4625      	mov	r5, r4
20029270:	46a0      	mov	r8, r4
20029272:	4626      	mov	r6, r4
20029274:	4627      	mov	r7, r4
20029276:	46a1      	mov	r9, r4
20029278:	f06f 040d 	mvn.w	r4, #13
2002927c:	e7c3      	b.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002927e:	46ab      	mov	fp, r5
20029280:	46a8      	mov	r8, r5
20029282:	462e      	mov	r6, r5
20029284:	462f      	mov	r7, r5
20029286:	46a9      	mov	r9, r5
20029288:	e7bd      	b.n	20029206 <mbedtls_mpi_inv_mod+0x2e6>
2002928a:	46a3      	mov	fp, r4
2002928c:	4625      	mov	r5, r4
2002928e:	e696      	b.n	20028fbe <mbedtls_mpi_inv_mod+0x9e>
20029290:	46a3      	mov	fp, r4
20029292:	4625      	mov	r5, r4
20029294:	4626      	mov	r6, r4
20029296:	e78b      	b.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
20029298:	46a3      	mov	fp, r4
2002929a:	4625      	mov	r5, r4
2002929c:	e788      	b.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
2002929e:	f04f 0b00 	mov.w	fp, #0
200292a2:	e785      	b.n	200291b0 <mbedtls_mpi_inv_mod+0x290>
200292a4:	f06f 0403 	mvn.w	r4, #3
200292a8:	e7d1      	b.n	2002924e <mbedtls_mpi_inv_mod+0x32e>
	...

200292ac <mbedtls_oid_get_pk_alg>:
200292ac:	b570      	push	{r4, r5, r6, lr}
200292ae:	460e      	mov	r6, r1
200292b0:	4605      	mov	r5, r0
200292b2:	b110      	cbz	r0, 200292ba <mbedtls_oid_get_pk_alg+0xe>
200292b4:	4c09      	ldr	r4, [pc, #36]	@ (200292dc <mbedtls_oid_get_pk_alg+0x30>)
200292b6:	6820      	ldr	r0, [r4, #0]
200292b8:	b910      	cbnz	r0, 200292c0 <mbedtls_oid_get_pk_alg+0x14>
200292ba:	f06f 002d 	mvn.w	r0, #45	@ 0x2d
200292be:	bd70      	pop	{r4, r5, r6, pc}
200292c0:	686b      	ldr	r3, [r5, #4]
200292c2:	6862      	ldr	r2, [r4, #4]
200292c4:	429a      	cmp	r2, r3
200292c6:	d103      	bne.n	200292d0 <mbedtls_oid_get_pk_alg+0x24>
200292c8:	68a9      	ldr	r1, [r5, #8]
200292ca:	f001 fab3 	bl	2002a834 <memcmp>
200292ce:	b108      	cbz	r0, 200292d4 <mbedtls_oid_get_pk_alg+0x28>
200292d0:	3414      	adds	r4, #20
200292d2:	e7f0      	b.n	200292b6 <mbedtls_oid_get_pk_alg+0xa>
200292d4:	7c23      	ldrb	r3, [r4, #16]
200292d6:	7033      	strb	r3, [r6, #0]
200292d8:	e7f1      	b.n	200292be <mbedtls_oid_get_pk_alg+0x12>
200292da:	bf00      	nop
200292dc:	2002c244 	.word	0x2002c244

200292e0 <mbedtls_oid_get_md_alg>:
200292e0:	b570      	push	{r4, r5, r6, lr}
200292e2:	460e      	mov	r6, r1
200292e4:	4605      	mov	r5, r0
200292e6:	b110      	cbz	r0, 200292ee <mbedtls_oid_get_md_alg+0xe>
200292e8:	4c09      	ldr	r4, [pc, #36]	@ (20029310 <mbedtls_oid_get_md_alg+0x30>)
200292ea:	6820      	ldr	r0, [r4, #0]
200292ec:	b910      	cbnz	r0, 200292f4 <mbedtls_oid_get_md_alg+0x14>
200292ee:	f06f 002d 	mvn.w	r0, #45	@ 0x2d
200292f2:	bd70      	pop	{r4, r5, r6, pc}
200292f4:	686b      	ldr	r3, [r5, #4]
200292f6:	6862      	ldr	r2, [r4, #4]
200292f8:	429a      	cmp	r2, r3
200292fa:	d103      	bne.n	20029304 <mbedtls_oid_get_md_alg+0x24>
200292fc:	68a9      	ldr	r1, [r5, #8]
200292fe:	f001 fa99 	bl	2002a834 <memcmp>
20029302:	b108      	cbz	r0, 20029308 <mbedtls_oid_get_md_alg+0x28>
20029304:	3414      	adds	r4, #20
20029306:	e7f0      	b.n	200292ea <mbedtls_oid_get_md_alg+0xa>
20029308:	7c23      	ldrb	r3, [r4, #16]
2002930a:	7033      	strb	r3, [r6, #0]
2002930c:	e7f1      	b.n	200292f2 <mbedtls_oid_get_md_alg+0x12>
2002930e:	bf00      	nop
20029310:	2002c1e0 	.word	0x2002c1e0

20029314 <mbedtls_oid_get_oid_by_md>:
20029314:	b530      	push	{r4, r5, lr}
20029316:	4b08      	ldr	r3, [pc, #32]	@ (20029338 <mbedtls_oid_get_oid_by_md+0x24>)
20029318:	681c      	ldr	r4, [r3, #0]
2002931a:	b914      	cbnz	r4, 20029322 <mbedtls_oid_get_oid_by_md+0xe>
2002931c:	f06f 002d 	mvn.w	r0, #45	@ 0x2d
20029320:	e006      	b.n	20029330 <mbedtls_oid_get_oid_by_md+0x1c>
20029322:	7c1d      	ldrb	r5, [r3, #16]
20029324:	4285      	cmp	r5, r0
20029326:	d104      	bne.n	20029332 <mbedtls_oid_get_oid_by_md+0x1e>
20029328:	2000      	movs	r0, #0
2002932a:	600c      	str	r4, [r1, #0]
2002932c:	685b      	ldr	r3, [r3, #4]
2002932e:	6013      	str	r3, [r2, #0]
20029330:	bd30      	pop	{r4, r5, pc}
20029332:	3314      	adds	r3, #20
20029334:	e7f0      	b.n	20029318 <mbedtls_oid_get_oid_by_md+0x4>
20029336:	bf00      	nop
20029338:	2002c1e0 	.word	0x2002c1e0

2002933c <mbedtls_pk_init>:
2002933c:	b110      	cbz	r0, 20029344 <mbedtls_pk_init+0x8>
2002933e:	2300      	movs	r3, #0
20029340:	e9c0 3300 	strd	r3, r3, [r0]
20029344:	4770      	bx	lr

20029346 <mbedtls_pk_free>:
20029346:	b510      	push	{r4, lr}
20029348:	4604      	mov	r4, r0
2002934a:	b160      	cbz	r0, 20029366 <mbedtls_pk_free+0x20>
2002934c:	6803      	ldr	r3, [r0, #0]
2002934e:	b153      	cbz	r3, 20029366 <mbedtls_pk_free+0x20>
20029350:	6a9b      	ldr	r3, [r3, #40]	@ 0x28
20029352:	6840      	ldr	r0, [r0, #4]
20029354:	4798      	blx	r3
20029356:	2100      	movs	r1, #0
20029358:	f104 0308 	add.w	r3, r4, #8
2002935c:	4622      	mov	r2, r4
2002935e:	3401      	adds	r4, #1
20029360:	429c      	cmp	r4, r3
20029362:	7011      	strb	r1, [r2, #0]
20029364:	d1fa      	bne.n	2002935c <mbedtls_pk_free+0x16>
20029366:	bd10      	pop	{r4, pc}

20029368 <mbedtls_pk_info_from_type>:
20029368:	2801      	cmp	r0, #1
2002936a:	4802      	ldr	r0, [pc, #8]	@ (20029374 <mbedtls_pk_info_from_type+0xc>)
2002936c:	bf18      	it	ne
2002936e:	2000      	movne	r0, #0
20029370:	4770      	bx	lr
20029372:	bf00      	nop
20029374:	2002c294 	.word	0x2002c294

20029378 <mbedtls_pk_setup>:
20029378:	b570      	push	{r4, r5, r6, lr}
2002937a:	460e      	mov	r6, r1
2002937c:	4605      	mov	r5, r0
2002937e:	b148      	cbz	r0, 20029394 <mbedtls_pk_setup+0x1c>
20029380:	b141      	cbz	r1, 20029394 <mbedtls_pk_setup+0x1c>
20029382:	6804      	ldr	r4, [r0, #0]
20029384:	b934      	cbnz	r4, 20029394 <mbedtls_pk_setup+0x1c>
20029386:	6a4b      	ldr	r3, [r1, #36]	@ 0x24
20029388:	4798      	blx	r3
2002938a:	6068      	str	r0, [r5, #4]
2002938c:	b120      	cbz	r0, 20029398 <mbedtls_pk_setup+0x20>
2002938e:	4620      	mov	r0, r4
20029390:	602e      	str	r6, [r5, #0]
20029392:	bd70      	pop	{r4, r5, r6, pc}
20029394:	4801      	ldr	r0, [pc, #4]	@ (2002939c <mbedtls_pk_setup+0x24>)
20029396:	e7fc      	b.n	20029392 <mbedtls_pk_setup+0x1a>
20029398:	4801      	ldr	r0, [pc, #4]	@ (200293a0 <mbedtls_pk_setup+0x28>)
2002939a:	e7fa      	b.n	20029392 <mbedtls_pk_setup+0x1a>
2002939c:	ffffc180 	.word	0xffffc180
200293a0:	ffffc080 	.word	0xffffc080

200293a4 <mbedtls_pk_verify>:
200293a4:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
200293a8:	460d      	mov	r5, r1
200293aa:	e9dd 8908 	ldrd	r8, r9, [sp, #32]
200293ae:	4616      	mov	r6, r2
200293b0:	4604      	mov	r4, r0
200293b2:	b910      	cbnz	r0, 200293ba <mbedtls_pk_verify+0x16>
200293b4:	480e      	ldr	r0, [pc, #56]	@ (200293f0 <mbedtls_pk_verify+0x4c>)
200293b6:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
200293ba:	6802      	ldr	r2, [r0, #0]
200293bc:	2a00      	cmp	r2, #0
200293be:	d0f9      	beq.n	200293b4 <mbedtls_pk_verify+0x10>
200293c0:	b93b      	cbnz	r3, 200293d2 <mbedtls_pk_verify+0x2e>
200293c2:	4608      	mov	r0, r1
200293c4:	f7fc fd42 	bl	20025e4c <mbedtls_md_info_from_type>
200293c8:	2800      	cmp	r0, #0
200293ca:	d0f3      	beq.n	200293b4 <mbedtls_pk_verify+0x10>
200293cc:	f7fc fd4a 	bl	20025e64 <mbedtls_md_get_size>
200293d0:	4603      	mov	r3, r0
200293d2:	6822      	ldr	r2, [r4, #0]
200293d4:	6917      	ldr	r7, [r2, #16]
200293d6:	b147      	cbz	r7, 200293ea <mbedtls_pk_verify+0x46>
200293d8:	e9cd 8908 	strd	r8, r9, [sp, #32]
200293dc:	4632      	mov	r2, r6
200293de:	4629      	mov	r1, r5
200293e0:	46bc      	mov	ip, r7
200293e2:	6860      	ldr	r0, [r4, #4]
200293e4:	e8bd 47f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
200293e8:	4760      	bx	ip
200293ea:	4802      	ldr	r0, [pc, #8]	@ (200293f4 <mbedtls_pk_verify+0x50>)
200293ec:	e7e3      	b.n	200293b6 <mbedtls_pk_verify+0x12>
200293ee:	bf00      	nop
200293f0:	ffffc180 	.word	0xffffc180
200293f4:	ffffc100 	.word	0xffffc100

200293f8 <pk_get_pk_alg>:
200293f8:	b530      	push	{r4, r5, lr}
200293fa:	4615      	mov	r5, r2
200293fc:	2200      	movs	r2, #0
200293fe:	b085      	sub	sp, #20
20029400:	e9c3 2200 	strd	r2, r2, [r3]
20029404:	609a      	str	r2, [r3, #8]
20029406:	aa01      	add	r2, sp, #4
20029408:	461c      	mov	r4, r3
2002940a:	f7fe fa98 	bl	2002793e <mbedtls_asn1_get_alg>
2002940e:	b118      	cbz	r0, 20029418 <pk_get_pk_alg+0x20>
20029410:	f5a0 506a 	sub.w	r0, r0, #14976	@ 0x3a80
20029414:	b005      	add	sp, #20
20029416:	bd30      	pop	{r4, r5, pc}
20029418:	4629      	mov	r1, r5
2002941a:	a801      	add	r0, sp, #4
2002941c:	f7ff ff46 	bl	200292ac <mbedtls_oid_get_pk_alg>
20029420:	b960      	cbnz	r0, 2002943c <pk_get_pk_alg+0x44>
20029422:	782b      	ldrb	r3, [r5, #0]
20029424:	2b01      	cmp	r3, #1
20029426:	d1f5      	bne.n	20029414 <pk_get_pk_alg+0x1c>
20029428:	6823      	ldr	r3, [r4, #0]
2002942a:	2b05      	cmp	r3, #5
2002942c:	d000      	beq.n	20029430 <pk_get_pk_alg+0x38>
2002942e:	b93b      	cbnz	r3, 20029440 <pk_get_pk_alg+0x48>
20029430:	6862      	ldr	r2, [r4, #4]
20029432:	4b04      	ldr	r3, [pc, #16]	@ (20029444 <pk_get_pk_alg+0x4c>)
20029434:	2a00      	cmp	r2, #0
20029436:	bf18      	it	ne
20029438:	4618      	movne	r0, r3
2002943a:	e7eb      	b.n	20029414 <pk_get_pk_alg+0x1c>
2002943c:	4802      	ldr	r0, [pc, #8]	@ (20029448 <pk_get_pk_alg+0x50>)
2002943e:	e7e9      	b.n	20029414 <pk_get_pk_alg+0x1c>
20029440:	4800      	ldr	r0, [pc, #0]	@ (20029444 <pk_get_pk_alg+0x4c>)
20029442:	e7e7      	b.n	20029414 <pk_get_pk_alg+0x1c>
20029444:	ffffc580 	.word	0xffffc580
20029448:	ffffc380 	.word	0xffffc380

2002944c <mbedtls_pk_parse_subpubkey>:
2002944c:	2300      	movs	r3, #0
2002944e:	e92d 45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
20029452:	b087      	sub	sp, #28
20029454:	4690      	mov	r8, r2
20029456:	f88d 3003 	strb.w	r3, [sp, #3]
2002945a:	aa01      	add	r2, sp, #4
2002945c:	2330      	movs	r3, #48	@ 0x30
2002945e:	4606      	mov	r6, r0
20029460:	f7fe fa32 	bl	200278c8 <mbedtls_asn1_get_tag>
20029464:	b128      	cbz	r0, 20029472 <mbedtls_pk_parse_subpubkey+0x26>
20029466:	f5a0 5474 	sub.w	r4, r0, #15616	@ 0x3d00
2002946a:	4620      	mov	r0, r4
2002946c:	b007      	add	sp, #28
2002946e:	e8bd 85f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, pc}
20029472:	9b01      	ldr	r3, [sp, #4]
20029474:	6837      	ldr	r7, [r6, #0]
20029476:	4630      	mov	r0, r6
20029478:	441f      	add	r7, r3
2002947a:	4639      	mov	r1, r7
2002947c:	ab03      	add	r3, sp, #12
2002947e:	f10d 0203 	add.w	r2, sp, #3
20029482:	f7ff ffb9 	bl	200293f8 <pk_get_pk_alg>
20029486:	4604      	mov	r4, r0
20029488:	2800      	cmp	r0, #0
2002948a:	d1ee      	bne.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
2002948c:	4639      	mov	r1, r7
2002948e:	4630      	mov	r0, r6
20029490:	aa01      	add	r2, sp, #4
20029492:	f7fe fa40 	bl	20027916 <mbedtls_asn1_get_bitstring_null>
20029496:	b110      	cbz	r0, 2002949e <mbedtls_pk_parse_subpubkey+0x52>
20029498:	f5a0 546c 	sub.w	r4, r0, #15104	@ 0x3b00
2002949c:	e7e5      	b.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
2002949e:	6833      	ldr	r3, [r6, #0]
200294a0:	9a01      	ldr	r2, [sp, #4]
200294a2:	4413      	add	r3, r2
200294a4:	429f      	cmp	r7, r3
200294a6:	d14b      	bne.n	20029540 <mbedtls_pk_parse_subpubkey+0xf4>
200294a8:	f89d 0003 	ldrb.w	r0, [sp, #3]
200294ac:	f7ff ff5c 	bl	20029368 <mbedtls_pk_info_from_type>
200294b0:	4601      	mov	r1, r0
200294b2:	2800      	cmp	r0, #0
200294b4:	d046      	beq.n	20029544 <mbedtls_pk_parse_subpubkey+0xf8>
200294b6:	4640      	mov	r0, r8
200294b8:	f7ff ff5e 	bl	20029378 <mbedtls_pk_setup>
200294bc:	4604      	mov	r4, r0
200294be:	2800      	cmp	r0, #0
200294c0:	d1d3      	bne.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
200294c2:	f89d 3003 	ldrb.w	r3, [sp, #3]
200294c6:	2b01      	cmp	r3, #1
200294c8:	d138      	bne.n	2002953c <mbedtls_pk_parse_subpubkey+0xf0>
200294ca:	2330      	movs	r3, #48	@ 0x30
200294cc:	4639      	mov	r1, r7
200294ce:	4630      	mov	r0, r6
200294d0:	aa02      	add	r2, sp, #8
200294d2:	f8d8 5004 	ldr.w	r5, [r8, #4]
200294d6:	f7fe f9f7 	bl	200278c8 <mbedtls_asn1_get_tag>
200294da:	b138      	cbz	r0, 200294ec <mbedtls_pk_parse_subpubkey+0xa0>
200294dc:	f5a0 556c 	sub.w	r5, r0, #15104	@ 0x3b00
200294e0:	bb3d      	cbnz	r5, 20029532 <mbedtls_pk_parse_subpubkey+0xe6>
200294e2:	6833      	ldr	r3, [r6, #0]
200294e4:	42bb      	cmp	r3, r7
200294e6:	d0c0      	beq.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
200294e8:	4d17      	ldr	r5, [pc, #92]	@ (20029548 <mbedtls_pk_parse_subpubkey+0xfc>)
200294ea:	e022      	b.n	20029532 <mbedtls_pk_parse_subpubkey+0xe6>
200294ec:	6833      	ldr	r3, [r6, #0]
200294ee:	9a02      	ldr	r2, [sp, #8]
200294f0:	4413      	add	r3, r2
200294f2:	429f      	cmp	r7, r3
200294f4:	d1f8      	bne.n	200294e8 <mbedtls_pk_parse_subpubkey+0x9c>
200294f6:	f105 0a08 	add.w	sl, r5, #8
200294fa:	4652      	mov	r2, sl
200294fc:	4639      	mov	r1, r7
200294fe:	4630      	mov	r0, r6
20029500:	f7fe f9f6 	bl	200278f0 <mbedtls_asn1_get_mpi>
20029504:	2800      	cmp	r0, #0
20029506:	d1e9      	bne.n	200294dc <mbedtls_pk_parse_subpubkey+0x90>
20029508:	4639      	mov	r1, r7
2002950a:	4630      	mov	r0, r6
2002950c:	f105 0214 	add.w	r2, r5, #20
20029510:	f7fe f9ee 	bl	200278f0 <mbedtls_asn1_get_mpi>
20029514:	2800      	cmp	r0, #0
20029516:	d1e1      	bne.n	200294dc <mbedtls_pk_parse_subpubkey+0x90>
20029518:	6833      	ldr	r3, [r6, #0]
2002951a:	429f      	cmp	r7, r3
2002951c:	d1e4      	bne.n	200294e8 <mbedtls_pk_parse_subpubkey+0x9c>
2002951e:	4628      	mov	r0, r5
20029520:	f000 f8c2 	bl	200296a8 <mbedtls_rsa_check_pubkey>
20029524:	b920      	cbnz	r0, 20029530 <mbedtls_pk_parse_subpubkey+0xe4>
20029526:	4650      	mov	r0, sl
20029528:	f7fe fcbe 	bl	20027ea8 <mbedtls_mpi_size>
2002952c:	6068      	str	r0, [r5, #4]
2002952e:	e7d8      	b.n	200294e2 <mbedtls_pk_parse_subpubkey+0x96>
20029530:	4d06      	ldr	r5, [pc, #24]	@ (2002954c <mbedtls_pk_parse_subpubkey+0x100>)
20029532:	4640      	mov	r0, r8
20029534:	f7ff ff07 	bl	20029346 <mbedtls_pk_free>
20029538:	462c      	mov	r4, r5
2002953a:	e796      	b.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
2002953c:	4d04      	ldr	r5, [pc, #16]	@ (20029550 <mbedtls_pk_parse_subpubkey+0x104>)
2002953e:	e7f8      	b.n	20029532 <mbedtls_pk_parse_subpubkey+0xe6>
20029540:	4c01      	ldr	r4, [pc, #4]	@ (20029548 <mbedtls_pk_parse_subpubkey+0xfc>)
20029542:	e792      	b.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
20029544:	4c02      	ldr	r4, [pc, #8]	@ (20029550 <mbedtls_pk_parse_subpubkey+0x104>)
20029546:	e790      	b.n	2002946a <mbedtls_pk_parse_subpubkey+0x1e>
20029548:	ffffc49a 	.word	0xffffc49a
2002954c:	ffffc500 	.word	0xffffc500
20029550:	ffffc380 	.word	0xffffc380

20029554 <mbedtls_pk_parse_public_key>:
20029554:	4613      	mov	r3, r2
20029556:	b507      	push	{r0, r1, r2, lr}
20029558:	4602      	mov	r2, r0
2002955a:	9101      	str	r1, [sp, #4]
2002955c:	a801      	add	r0, sp, #4
2002955e:	4419      	add	r1, r3
20029560:	f7ff ff74 	bl	2002944c <mbedtls_pk_parse_subpubkey>
20029564:	b003      	add	sp, #12
20029566:	f85d fb04 	ldr.w	pc, [sp], #4

2002956a <rsa_can_do>:
2002956a:	2801      	cmp	r0, #1
2002956c:	d002      	beq.n	20029574 <rsa_can_do+0xa>
2002956e:	1f83      	subs	r3, r0, #6
20029570:	4258      	negs	r0, r3
20029572:	4158      	adcs	r0, r3
20029574:	4770      	bx	lr

20029576 <rsa_get_bitlen>:
20029576:	6840      	ldr	r0, [r0, #4]
20029578:	00c0      	lsls	r0, r0, #3
2002957a:	4770      	bx	lr

2002957c <rsa_debug>:
2002957c:	2301      	movs	r3, #1
2002957e:	4a06      	ldr	r2, [pc, #24]	@ (20029598 <rsa_debug+0x1c>)
20029580:	700b      	strb	r3, [r1, #0]
20029582:	730b      	strb	r3, [r1, #12]
20029584:	4b05      	ldr	r3, [pc, #20]	@ (2002959c <rsa_debug+0x20>)
20029586:	604a      	str	r2, [r1, #4]
20029588:	f100 0208 	add.w	r2, r0, #8
2002958c:	3014      	adds	r0, #20
2002958e:	608a      	str	r2, [r1, #8]
20029590:	610b      	str	r3, [r1, #16]
20029592:	6148      	str	r0, [r1, #20]
20029594:	4770      	bx	lr
20029596:	bf00      	nop
20029598:	2002b070 	.word	0x2002b070
2002959c:	2002b076 	.word	0x2002b076

200295a0 <rsa_free_wrap>:
200295a0:	b510      	push	{r4, lr}
200295a2:	4604      	mov	r4, r0
200295a4:	f000 fe7c 	bl	2002a2a0 <mbedtls_rsa_free>
200295a8:	4620      	mov	r0, r4
200295aa:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
200295ae:	f001 b88b 	b.w	2002a6c8 <free>

200295b2 <rsa_alloc_wrap>:
200295b2:	b510      	push	{r4, lr}
200295b4:	21ac      	movs	r1, #172	@ 0xac
200295b6:	2001      	movs	r0, #1
200295b8:	f001 f86a 	bl	2002a690 <calloc>
200295bc:	4604      	mov	r4, r0
200295be:	b118      	cbz	r0, 200295c8 <rsa_alloc_wrap+0x16>
200295c0:	2200      	movs	r2, #0
200295c2:	4611      	mov	r1, r2
200295c4:	f000 f862 	bl	2002968c <mbedtls_rsa_init>
200295c8:	4620      	mov	r0, r4
200295ca:	bd10      	pop	{r4, pc}

200295cc <rsa_check_pair_wrap>:
200295cc:	f000 b99c 	b.w	20029908 <mbedtls_rsa_check_pub_priv>

200295d0 <rsa_encrypt_wrap>:
200295d0:	b4f0      	push	{r4, r5, r6, r7}
200295d2:	9f04      	ldr	r7, [sp, #16]
200295d4:	6846      	ldr	r6, [r0, #4]
200295d6:	460d      	mov	r5, r1
200295d8:	603e      	str	r6, [r7, #0]
200295da:	9f05      	ldr	r7, [sp, #20]
200295dc:	4614      	mov	r4, r2
200295de:	e9dd 1206 	ldrd	r1, r2, [sp, #24]
200295e2:	42be      	cmp	r6, r7
200295e4:	d806      	bhi.n	200295f4 <rsa_encrypt_wrap+0x24>
200295e6:	e9cd 5305 	strd	r5, r3, [sp, #20]
200295ea:	9404      	str	r4, [sp, #16]
200295ec:	2300      	movs	r3, #0
200295ee:	bcf0      	pop	{r4, r5, r6, r7}
200295f0:	f000 bbe2 	b.w	20029db8 <mbedtls_rsa_pkcs1_encrypt>
200295f4:	4801      	ldr	r0, [pc, #4]	@ (200295fc <rsa_encrypt_wrap+0x2c>)
200295f6:	bcf0      	pop	{r4, r5, r6, r7}
200295f8:	4770      	bx	lr
200295fa:	bf00      	nop
200295fc:	ffffbc00 	.word	0xffffbc00

20029600 <rsa_decrypt_wrap>:
20029600:	b4f0      	push	{r4, r5, r6, r7}
20029602:	4616      	mov	r6, r2
20029604:	6847      	ldr	r7, [r0, #4]
20029606:	460c      	mov	r4, r1
20029608:	e9dd 5105 	ldrd	r5, r1, [sp, #20]
2002960c:	42b7      	cmp	r7, r6
2002960e:	9a07      	ldr	r2, [sp, #28]
20029610:	d106      	bne.n	20029620 <rsa_decrypt_wrap+0x20>
20029612:	e9cd 3506 	strd	r3, r5, [sp, #24]
20029616:	9405      	str	r4, [sp, #20]
20029618:	2301      	movs	r3, #1
2002961a:	bcf0      	pop	{r4, r5, r6, r7}
2002961c:	f000 bc6e 	b.w	20029efc <mbedtls_rsa_pkcs1_decrypt>
20029620:	4801      	ldr	r0, [pc, #4]	@ (20029628 <rsa_decrypt_wrap+0x28>)
20029622:	bcf0      	pop	{r4, r5, r6, r7}
20029624:	4770      	bx	lr
20029626:	bf00      	nop
20029628:	ffffbf80 	.word	0xffffbf80

2002962c <rsa_sign_wrap>:
2002962c:	b4f0      	push	{r4, r5, r6, r7}
2002962e:	460c      	mov	r4, r1
20029630:	4615      	mov	r5, r2
20029632:	e9dd 1206 	ldrd	r1, r2, [sp, #24]
20029636:	6847      	ldr	r7, [r0, #4]
20029638:	9e05      	ldr	r6, [sp, #20]
2002963a:	6037      	str	r7, [r6, #0]
2002963c:	9e04      	ldr	r6, [sp, #16]
2002963e:	e9cd 4304 	strd	r4, r3, [sp, #16]
20029642:	e9cd 5606 	strd	r5, r6, [sp, #24]
20029646:	bcf0      	pop	{r4, r5, r6, r7}
20029648:	2301      	movs	r3, #1
2002964a:	f000 bd31 	b.w	2002a0b0 <mbedtls_rsa_pkcs1_sign>
	...

20029650 <rsa_verify_wrap>:
20029650:	b57f      	push	{r0, r1, r2, r3, r4, r5, r6, lr}
20029652:	9d09      	ldr	r5, [sp, #36]	@ 0x24
20029654:	6846      	ldr	r6, [r0, #4]
20029656:	4604      	mov	r4, r0
20029658:	42ae      	cmp	r6, r5
2002965a:	d811      	bhi.n	20029680 <rsa_verify_wrap+0x30>
2002965c:	e9cd 1300 	strd	r1, r3, [sp]
20029660:	2300      	movs	r3, #0
20029662:	9e08      	ldr	r6, [sp, #32]
20029664:	4619      	mov	r1, r3
20029666:	e9cd 2602 	strd	r2, r6, [sp, #8]
2002966a:	461a      	mov	r2, r3
2002966c:	f000 fe08 	bl	2002a280 <mbedtls_rsa_pkcs1_verify>
20029670:	b920      	cbnz	r0, 2002967c <rsa_verify_wrap+0x2c>
20029672:	6862      	ldr	r2, [r4, #4]
20029674:	4b03      	ldr	r3, [pc, #12]	@ (20029684 <rsa_verify_wrap+0x34>)
20029676:	42aa      	cmp	r2, r5
20029678:	bf38      	it	cc
2002967a:	4618      	movcc	r0, r3
2002967c:	b004      	add	sp, #16
2002967e:	bd70      	pop	{r4, r5, r6, pc}
20029680:	4801      	ldr	r0, [pc, #4]	@ (20029688 <rsa_verify_wrap+0x38>)
20029682:	e7fb      	b.n	2002967c <rsa_verify_wrap+0x2c>
20029684:	ffffc700 	.word	0xffffc700
20029688:	ffffbc80 	.word	0xffffbc80

2002968c <mbedtls_rsa_init>:
2002968c:	b570      	push	{r4, r5, r6, lr}
2002968e:	4604      	mov	r4, r0
20029690:	460e      	mov	r6, r1
20029692:	4615      	mov	r5, r2
20029694:	2100      	movs	r1, #0
20029696:	22ac      	movs	r2, #172	@ 0xac
20029698:	f001 f8dc 	bl	2002a854 <memset>
2002969c:	e9c4 6529 	strd	r6, r5, [r4, #164]	@ 0xa4
200296a0:	bd70      	pop	{r4, r5, r6, pc}

200296a2 <mbedtls_rsa_set_padding>:
200296a2:	e9c0 1229 	strd	r1, r2, [r0, #164]	@ 0xa4
200296a6:	4770      	bx	lr

200296a8 <mbedtls_rsa_check_pubkey>:
200296a8:	b538      	push	{r3, r4, r5, lr}
200296aa:	6902      	ldr	r2, [r0, #16]
200296ac:	4604      	mov	r4, r0
200296ae:	b10a      	cbz	r2, 200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296b0:	69c3      	ldr	r3, [r0, #28]
200296b2:	b90b      	cbnz	r3, 200296b8 <mbedtls_rsa_check_pubkey+0x10>
200296b4:	4811      	ldr	r0, [pc, #68]	@ (200296fc <mbedtls_rsa_check_pubkey+0x54>)
200296b6:	bd38      	pop	{r3, r4, r5, pc}
200296b8:	6812      	ldr	r2, [r2, #0]
200296ba:	07d2      	lsls	r2, r2, #31
200296bc:	d5fa      	bpl.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296be:	681b      	ldr	r3, [r3, #0]
200296c0:	07db      	lsls	r3, r3, #31
200296c2:	d5f7      	bpl.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296c4:	f100 0508 	add.w	r5, r0, #8
200296c8:	4628      	mov	r0, r5
200296ca:	f7fe fbd0 	bl	20027e6e <mbedtls_mpi_bitlen>
200296ce:	287f      	cmp	r0, #127	@ 0x7f
200296d0:	d9f0      	bls.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296d2:	4628      	mov	r0, r5
200296d4:	f7fe fbcb 	bl	20027e6e <mbedtls_mpi_bitlen>
200296d8:	f5b0 5f00 	cmp.w	r0, #8192	@ 0x2000
200296dc:	d8ea      	bhi.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296de:	3414      	adds	r4, #20
200296e0:	4620      	mov	r0, r4
200296e2:	f7fe fbc4 	bl	20027e6e <mbedtls_mpi_bitlen>
200296e6:	2801      	cmp	r0, #1
200296e8:	d9e4      	bls.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296ea:	4629      	mov	r1, r5
200296ec:	4620      	mov	r0, r4
200296ee:	f7fe fd71 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200296f2:	2800      	cmp	r0, #0
200296f4:	dade      	bge.n	200296b4 <mbedtls_rsa_check_pubkey+0xc>
200296f6:	2000      	movs	r0, #0
200296f8:	e7dd      	b.n	200296b6 <mbedtls_rsa_check_pubkey+0xe>
200296fa:	bf00      	nop
200296fc:	ffffbe00 	.word	0xffffbe00

20029700 <mbedtls_rsa_check_privkey>:
20029700:	e92d 43f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
20029704:	b0a9      	sub	sp, #164	@ 0xa4
20029706:	4605      	mov	r5, r0
20029708:	f7ff ffce 	bl	200296a8 <mbedtls_rsa_check_pubkey>
2002970c:	b120      	cbz	r0, 20029718 <mbedtls_rsa_check_privkey+0x18>
2002970e:	4c7d      	ldr	r4, [pc, #500]	@ (20029904 <mbedtls_rsa_check_privkey+0x204>)
20029710:	4620      	mov	r0, r4
20029712:	b029      	add	sp, #164	@ 0xa4
20029714:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
20029718:	6b6b      	ldr	r3, [r5, #52]	@ 0x34
2002971a:	2b00      	cmp	r3, #0
2002971c:	d0f7      	beq.n	2002970e <mbedtls_rsa_check_privkey+0xe>
2002971e:	6c2b      	ldr	r3, [r5, #64]	@ 0x40
20029720:	2b00      	cmp	r3, #0
20029722:	d0f4      	beq.n	2002970e <mbedtls_rsa_check_privkey+0xe>
20029724:	6aab      	ldr	r3, [r5, #40]	@ 0x28
20029726:	2b00      	cmp	r3, #0
20029728:	d0f1      	beq.n	2002970e <mbedtls_rsa_check_privkey+0xe>
2002972a:	a801      	add	r0, sp, #4
2002972c:	f7fe fafa 	bl	20027d24 <mbedtls_mpi_init>
20029730:	a804      	add	r0, sp, #16
20029732:	f7fe faf7 	bl	20027d24 <mbedtls_mpi_init>
20029736:	a807      	add	r0, sp, #28
20029738:	f7fe faf4 	bl	20027d24 <mbedtls_mpi_init>
2002973c:	a80a      	add	r0, sp, #40	@ 0x28
2002973e:	f7fe faf1 	bl	20027d24 <mbedtls_mpi_init>
20029742:	a80d      	add	r0, sp, #52	@ 0x34
20029744:	f7fe faee 	bl	20027d24 <mbedtls_mpi_init>
20029748:	a810      	add	r0, sp, #64	@ 0x40
2002974a:	f7fe faeb 	bl	20027d24 <mbedtls_mpi_init>
2002974e:	a813      	add	r0, sp, #76	@ 0x4c
20029750:	f7fe fae8 	bl	20027d24 <mbedtls_mpi_init>
20029754:	a816      	add	r0, sp, #88	@ 0x58
20029756:	f7fe fae5 	bl	20027d24 <mbedtls_mpi_init>
2002975a:	a819      	add	r0, sp, #100	@ 0x64
2002975c:	f7fe fae2 	bl	20027d24 <mbedtls_mpi_init>
20029760:	a81c      	add	r0, sp, #112	@ 0x70
20029762:	f7fe fadf 	bl	20027d24 <mbedtls_mpi_init>
20029766:	a81f      	add	r0, sp, #124	@ 0x7c
20029768:	f7fe fadc 	bl	20027d24 <mbedtls_mpi_init>
2002976c:	a822      	add	r0, sp, #136	@ 0x88
2002976e:	f7fe fad9 	bl	20027d24 <mbedtls_mpi_init>
20029772:	f105 072c 	add.w	r7, r5, #44	@ 0x2c
20029776:	a825      	add	r0, sp, #148	@ 0x94
20029778:	f105 0638 	add.w	r6, r5, #56	@ 0x38
2002977c:	f7fe fad2 	bl	20027d24 <mbedtls_mpi_init>
20029780:	4632      	mov	r2, r6
20029782:	4639      	mov	r1, r7
20029784:	a801      	add	r0, sp, #4
20029786:	f7fe fe75 	bl	20028474 <mbedtls_mpi_mul_mpi>
2002978a:	4604      	mov	r4, r0
2002978c:	2800      	cmp	r0, #0
2002978e:	d15e      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
20029790:	f105 0820 	add.w	r8, r5, #32
20029794:	f105 0914 	add.w	r9, r5, #20
20029798:	464a      	mov	r2, r9
2002979a:	4641      	mov	r1, r8
2002979c:	a804      	add	r0, sp, #16
2002979e:	f7fe fe69 	bl	20028474 <mbedtls_mpi_mul_mpi>
200297a2:	4604      	mov	r4, r0
200297a4:	2800      	cmp	r0, #0
200297a6:	d152      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
200297a8:	2201      	movs	r2, #1
200297aa:	4639      	mov	r1, r7
200297ac:	a807      	add	r0, sp, #28
200297ae:	f7fe fe4b 	bl	20028448 <mbedtls_mpi_sub_int>
200297b2:	4604      	mov	r4, r0
200297b4:	2800      	cmp	r0, #0
200297b6:	d14a      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
200297b8:	2201      	movs	r2, #1
200297ba:	4631      	mov	r1, r6
200297bc:	a80a      	add	r0, sp, #40	@ 0x28
200297be:	f7fe fe43 	bl	20028448 <mbedtls_mpi_sub_int>
200297c2:	4604      	mov	r4, r0
200297c4:	2800      	cmp	r0, #0
200297c6:	d142      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
200297c8:	aa0a      	add	r2, sp, #40	@ 0x28
200297ca:	a907      	add	r1, sp, #28
200297cc:	a80d      	add	r0, sp, #52	@ 0x34
200297ce:	f7fe fe51 	bl	20028474 <mbedtls_mpi_mul_mpi>
200297d2:	4604      	mov	r4, r0
200297d4:	2800      	cmp	r0, #0
200297d6:	d13a      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
200297d8:	4649      	mov	r1, r9
200297da:	aa0d      	add	r2, sp, #52	@ 0x34
200297dc:	a813      	add	r0, sp, #76	@ 0x4c
200297de:	f7ff fb04 	bl	20028dea <mbedtls_mpi_gcd>
200297e2:	4604      	mov	r4, r0
200297e4:	2800      	cmp	r0, #0
200297e6:	d132      	bne.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
200297e8:	aa0a      	add	r2, sp, #40	@ 0x28
200297ea:	a907      	add	r1, sp, #28
200297ec:	a816      	add	r0, sp, #88	@ 0x58
200297ee:	f7ff fafc 	bl	20028dea <mbedtls_mpi_gcd>
200297f2:	4604      	mov	r4, r0
200297f4:	bb58      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
200297f6:	ab16      	add	r3, sp, #88	@ 0x58
200297f8:	aa0d      	add	r2, sp, #52	@ 0x34
200297fa:	a91c      	add	r1, sp, #112	@ 0x70
200297fc:	a819      	add	r0, sp, #100	@ 0x64
200297fe:	f7fe feaa 	bl	20028556 <mbedtls_mpi_div_mpi>
20029802:	4604      	mov	r4, r0
20029804:	bb18      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
20029806:	aa19      	add	r2, sp, #100	@ 0x64
20029808:	a904      	add	r1, sp, #16
2002980a:	a810      	add	r0, sp, #64	@ 0x40
2002980c:	f7ff f8a7 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029810:	4604      	mov	r4, r0
20029812:	b9e0      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
20029814:	4641      	mov	r1, r8
20029816:	aa07      	add	r2, sp, #28
20029818:	a81f      	add	r0, sp, #124	@ 0x7c
2002981a:	f7ff f8a0 	bl	2002895e <mbedtls_mpi_mod_mpi>
2002981e:	4604      	mov	r4, r0
20029820:	b9a8      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
20029822:	4641      	mov	r1, r8
20029824:	aa0a      	add	r2, sp, #40	@ 0x28
20029826:	a822      	add	r0, sp, #136	@ 0x88
20029828:	f7ff f899 	bl	2002895e <mbedtls_mpi_mod_mpi>
2002982c:	4604      	mov	r4, r0
2002982e:	b970      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
20029830:	463a      	mov	r2, r7
20029832:	4631      	mov	r1, r6
20029834:	a825      	add	r0, sp, #148	@ 0x94
20029836:	f7ff fb73 	bl	20028f20 <mbedtls_mpi_inv_mod>
2002983a:	4604      	mov	r4, r0
2002983c:	b938      	cbnz	r0, 2002984e <mbedtls_rsa_check_privkey+0x14e>
2002983e:	f105 0108 	add.w	r1, r5, #8
20029842:	a801      	add	r0, sp, #4
20029844:	f7fe fcc6 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20029848:	2800      	cmp	r0, #0
2002984a:	d031      	beq.n	200298b0 <mbedtls_rsa_check_privkey+0x1b0>
2002984c:	4c2d      	ldr	r4, [pc, #180]	@ (20029904 <mbedtls_rsa_check_privkey+0x204>)
2002984e:	a801      	add	r0, sp, #4
20029850:	f7fe fa6f 	bl	20027d32 <mbedtls_mpi_free>
20029854:	a804      	add	r0, sp, #16
20029856:	f7fe fa6c 	bl	20027d32 <mbedtls_mpi_free>
2002985a:	a807      	add	r0, sp, #28
2002985c:	f7fe fa69 	bl	20027d32 <mbedtls_mpi_free>
20029860:	a80a      	add	r0, sp, #40	@ 0x28
20029862:	f7fe fa66 	bl	20027d32 <mbedtls_mpi_free>
20029866:	a80d      	add	r0, sp, #52	@ 0x34
20029868:	f7fe fa63 	bl	20027d32 <mbedtls_mpi_free>
2002986c:	a810      	add	r0, sp, #64	@ 0x40
2002986e:	f7fe fa60 	bl	20027d32 <mbedtls_mpi_free>
20029872:	a813      	add	r0, sp, #76	@ 0x4c
20029874:	f7fe fa5d 	bl	20027d32 <mbedtls_mpi_free>
20029878:	a816      	add	r0, sp, #88	@ 0x58
2002987a:	f7fe fa5a 	bl	20027d32 <mbedtls_mpi_free>
2002987e:	a819      	add	r0, sp, #100	@ 0x64
20029880:	f7fe fa57 	bl	20027d32 <mbedtls_mpi_free>
20029884:	a81c      	add	r0, sp, #112	@ 0x70
20029886:	f7fe fa54 	bl	20027d32 <mbedtls_mpi_free>
2002988a:	a81f      	add	r0, sp, #124	@ 0x7c
2002988c:	f7fe fa51 	bl	20027d32 <mbedtls_mpi_free>
20029890:	a822      	add	r0, sp, #136	@ 0x88
20029892:	f7fe fa4e 	bl	20027d32 <mbedtls_mpi_free>
20029896:	a825      	add	r0, sp, #148	@ 0x94
20029898:	f7fe fa4b 	bl	20027d32 <mbedtls_mpi_free>
2002989c:	f514 4f84 	cmn.w	r4, #16896	@ 0x4200
200298a0:	f43f af35 	beq.w	2002970e <mbedtls_rsa_check_privkey+0xe>
200298a4:	2c00      	cmp	r4, #0
200298a6:	f43f af33 	beq.w	20029710 <mbedtls_rsa_check_privkey+0x10>
200298aa:	f5a4 4484 	sub.w	r4, r4, #16896	@ 0x4200
200298ae:	e72f      	b.n	20029710 <mbedtls_rsa_check_privkey+0x10>
200298b0:	f105 0144 	add.w	r1, r5, #68	@ 0x44
200298b4:	a81f      	add	r0, sp, #124	@ 0x7c
200298b6:	f7fe fc8d 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200298ba:	2800      	cmp	r0, #0
200298bc:	d1c6      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
200298be:	f105 0150 	add.w	r1, r5, #80	@ 0x50
200298c2:	a822      	add	r0, sp, #136	@ 0x88
200298c4:	f7fe fc86 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200298c8:	2800      	cmp	r0, #0
200298ca:	d1bf      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
200298cc:	f105 015c 	add.w	r1, r5, #92	@ 0x5c
200298d0:	a825      	add	r0, sp, #148	@ 0x94
200298d2:	f7fe fc7f 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
200298d6:	2800      	cmp	r0, #0
200298d8:	d1b8      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
200298da:	2100      	movs	r1, #0
200298dc:	a81c      	add	r0, sp, #112	@ 0x70
200298de:	f7fe fcba 	bl	20028256 <mbedtls_mpi_cmp_int>
200298e2:	2800      	cmp	r0, #0
200298e4:	d1b2      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
200298e6:	2101      	movs	r1, #1
200298e8:	a810      	add	r0, sp, #64	@ 0x40
200298ea:	f7fe fcb4 	bl	20028256 <mbedtls_mpi_cmp_int>
200298ee:	2800      	cmp	r0, #0
200298f0:	d1ac      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
200298f2:	2101      	movs	r1, #1
200298f4:	a813      	add	r0, sp, #76	@ 0x4c
200298f6:	f7fe fcae 	bl	20028256 <mbedtls_mpi_cmp_int>
200298fa:	4604      	mov	r4, r0
200298fc:	2800      	cmp	r0, #0
200298fe:	d1a5      	bne.n	2002984c <mbedtls_rsa_check_privkey+0x14c>
20029900:	e7a5      	b.n	2002984e <mbedtls_rsa_check_privkey+0x14e>
20029902:	bf00      	nop
20029904:	ffffbe00 	.word	0xffffbe00

20029908 <mbedtls_rsa_check_pub_priv>:
20029908:	b538      	push	{r3, r4, r5, lr}
2002990a:	4605      	mov	r5, r0
2002990c:	460c      	mov	r4, r1
2002990e:	f7ff fecb 	bl	200296a8 <mbedtls_rsa_check_pubkey>
20029912:	b918      	cbnz	r0, 2002991c <mbedtls_rsa_check_pub_priv+0x14>
20029914:	4620      	mov	r0, r4
20029916:	f7ff fef3 	bl	20029700 <mbedtls_rsa_check_privkey>
2002991a:	b108      	cbz	r0, 20029920 <mbedtls_rsa_check_pub_priv+0x18>
2002991c:	4809      	ldr	r0, [pc, #36]	@ (20029944 <mbedtls_rsa_check_pub_priv+0x3c>)
2002991e:	bd38      	pop	{r3, r4, r5, pc}
20029920:	f104 0108 	add.w	r1, r4, #8
20029924:	f105 0008 	add.w	r0, r5, #8
20029928:	f7fe fc54 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
2002992c:	2800      	cmp	r0, #0
2002992e:	d1f5      	bne.n	2002991c <mbedtls_rsa_check_pub_priv+0x14>
20029930:	f104 0114 	add.w	r1, r4, #20
20029934:	f105 0014 	add.w	r0, r5, #20
20029938:	f7fe fc4c 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
2002993c:	2800      	cmp	r0, #0
2002993e:	d0ee      	beq.n	2002991e <mbedtls_rsa_check_pub_priv+0x16>
20029940:	e7ec      	b.n	2002991c <mbedtls_rsa_check_pub_priv+0x14>
20029942:	bf00      	nop
20029944:	ffffbe00 	.word	0xffffbe00

20029948 <mbedtls_rsa_public>:
20029948:	b5f0      	push	{r4, r5, r6, r7, lr}
2002994a:	460c      	mov	r4, r1
2002994c:	4605      	mov	r5, r0
2002994e:	b087      	sub	sp, #28
20029950:	a803      	add	r0, sp, #12
20029952:	4616      	mov	r6, r2
20029954:	f7fe f9e6 	bl	20027d24 <mbedtls_mpi_init>
20029958:	4621      	mov	r1, r4
2002995a:	686a      	ldr	r2, [r5, #4]
2002995c:	a803      	add	r0, sp, #12
2002995e:	f7fe faa9 	bl	20027eb4 <mbedtls_mpi_read_binary>
20029962:	4604      	mov	r4, r0
20029964:	b9d0      	cbnz	r0, 2002999c <mbedtls_rsa_public+0x54>
20029966:	f105 0408 	add.w	r4, r5, #8
2002996a:	4621      	mov	r1, r4
2002996c:	a803      	add	r0, sp, #12
2002996e:	f7fe fc31 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20029972:	2800      	cmp	r0, #0
20029974:	da1b      	bge.n	200299ae <mbedtls_rsa_public+0x66>
20029976:	f105 0368 	add.w	r3, r5, #104	@ 0x68
2002997a:	a903      	add	r1, sp, #12
2002997c:	686f      	ldr	r7, [r5, #4]
2002997e:	4608      	mov	r0, r1
20029980:	9300      	str	r3, [sp, #0]
20029982:	f105 0214 	add.w	r2, r5, #20
20029986:	4623      	mov	r3, r4
20029988:	f7ff f81b 	bl	200289c2 <mbedtls_mpi_exp_mod>
2002998c:	4604      	mov	r4, r0
2002998e:	b928      	cbnz	r0, 2002999c <mbedtls_rsa_public+0x54>
20029990:	463a      	mov	r2, r7
20029992:	4631      	mov	r1, r6
20029994:	a803      	add	r0, sp, #12
20029996:	f7fe fac2 	bl	20027f1e <mbedtls_mpi_write_binary>
2002999a:	4604      	mov	r4, r0
2002999c:	a803      	add	r0, sp, #12
2002999e:	f7fe f9c8 	bl	20027d32 <mbedtls_mpi_free>
200299a2:	b10c      	cbz	r4, 200299a8 <mbedtls_rsa_public+0x60>
200299a4:	f5a4 4485 	sub.w	r4, r4, #17024	@ 0x4280
200299a8:	4620      	mov	r0, r4
200299aa:	b007      	add	sp, #28
200299ac:	bdf0      	pop	{r4, r5, r6, r7, pc}
200299ae:	f06f 0403 	mvn.w	r4, #3
200299b2:	e7f3      	b.n	2002999c <mbedtls_rsa_public+0x54>

200299b4 <mbedtls_rsa_private>:
200299b4:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
200299b8:	461e      	mov	r6, r3
200299ba:	6b43      	ldr	r3, [r0, #52]	@ 0x34
200299bc:	4604      	mov	r4, r0
200299be:	460d      	mov	r5, r1
200299c0:	4617      	mov	r7, r2
200299c2:	b09d      	sub	sp, #116	@ 0x74
200299c4:	2b00      	cmp	r3, #0
200299c6:	f000 8179 	beq.w	20029cbc <mbedtls_rsa_private+0x308>
200299ca:	6c03      	ldr	r3, [r0, #64]	@ 0x40
200299cc:	2b00      	cmp	r3, #0
200299ce:	f000 8175 	beq.w	20029cbc <mbedtls_rsa_private+0x308>
200299d2:	6a83      	ldr	r3, [r0, #40]	@ 0x28
200299d4:	2b00      	cmp	r3, #0
200299d6:	f000 8171 	beq.w	20029cbc <mbedtls_rsa_private+0x308>
200299da:	a804      	add	r0, sp, #16
200299dc:	f7fe f9a2 	bl	20027d24 <mbedtls_mpi_init>
200299e0:	a807      	add	r0, sp, #28
200299e2:	f7fe f99f 	bl	20027d24 <mbedtls_mpi_init>
200299e6:	a80a      	add	r0, sp, #40	@ 0x28
200299e8:	f7fe f99c 	bl	20027d24 <mbedtls_mpi_init>
200299ec:	a80d      	add	r0, sp, #52	@ 0x34
200299ee:	f7fe f999 	bl	20027d24 <mbedtls_mpi_init>
200299f2:	a810      	add	r0, sp, #64	@ 0x40
200299f4:	f7fe f996 	bl	20027d24 <mbedtls_mpi_init>
200299f8:	a813      	add	r0, sp, #76	@ 0x4c
200299fa:	f7fe f993 	bl	20027d24 <mbedtls_mpi_init>
200299fe:	b12d      	cbz	r5, 20029a0c <mbedtls_rsa_private+0x58>
20029a00:	a816      	add	r0, sp, #88	@ 0x58
20029a02:	f7fe f98f 	bl	20027d24 <mbedtls_mpi_init>
20029a06:	a819      	add	r0, sp, #100	@ 0x64
20029a08:	f7fe f98c 	bl	20027d24 <mbedtls_mpi_init>
20029a0c:	4631      	mov	r1, r6
20029a0e:	6862      	ldr	r2, [r4, #4]
20029a10:	a804      	add	r0, sp, #16
20029a12:	f7fe fa4f 	bl	20027eb4 <mbedtls_mpi_read_binary>
20029a16:	4603      	mov	r3, r0
20029a18:	2800      	cmp	r0, #0
20029a1a:	f040 80e0 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029a1e:	f104 0608 	add.w	r6, r4, #8
20029a22:	4631      	mov	r1, r6
20029a24:	a804      	add	r0, sp, #16
20029a26:	f7fe fbd5 	bl	200281d4 <mbedtls_mpi_cmp_mpi>
20029a2a:	2800      	cmp	r0, #0
20029a2c:	f280 8143 	bge.w	20029cb6 <mbedtls_rsa_private+0x302>
20029a30:	f104 0a44 	add.w	sl, r4, #68	@ 0x44
20029a34:	f104 0950 	add.w	r9, r4, #80	@ 0x50
20029a38:	2d00      	cmp	r5, #0
20029a3a:	f000 8089 	beq.w	20029b50 <mbedtls_rsa_private+0x19c>
20029a3e:	f8d4 30a0 	ldr.w	r3, [r4, #160]	@ 0xa0
20029a42:	2b00      	cmp	r3, #0
20029a44:	f000 80f4 	beq.w	20029c30 <mbedtls_rsa_private+0x27c>
20029a48:	f104 088c 	add.w	r8, r4, #140	@ 0x8c
20029a4c:	4642      	mov	r2, r8
20029a4e:	4641      	mov	r1, r8
20029a50:	4640      	mov	r0, r8
20029a52:	f7fe fd0f 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029a56:	4603      	mov	r3, r0
20029a58:	2800      	cmp	r0, #0
20029a5a:	f040 80c0 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029a5e:	4632      	mov	r2, r6
20029a60:	4641      	mov	r1, r8
20029a62:	4640      	mov	r0, r8
20029a64:	f7fe ff7b 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029a68:	4603      	mov	r3, r0
20029a6a:	2800      	cmp	r0, #0
20029a6c:	f040 80b7 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029a70:	f104 0898 	add.w	r8, r4, #152	@ 0x98
20029a74:	4642      	mov	r2, r8
20029a76:	4641      	mov	r1, r8
20029a78:	4640      	mov	r0, r8
20029a7a:	f7fe fcfb 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029a7e:	4603      	mov	r3, r0
20029a80:	2800      	cmp	r0, #0
20029a82:	f040 80ac 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029a86:	4632      	mov	r2, r6
20029a88:	4641      	mov	r1, r8
20029a8a:	4640      	mov	r0, r8
20029a8c:	f7fe ff67 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029a90:	4603      	mov	r3, r0
20029a92:	2800      	cmp	r0, #0
20029a94:	f040 80a3 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029a98:	a904      	add	r1, sp, #16
20029a9a:	4608      	mov	r0, r1
20029a9c:	f104 028c 	add.w	r2, r4, #140	@ 0x8c
20029aa0:	f7fe fce8 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029aa4:	4603      	mov	r3, r0
20029aa6:	2800      	cmp	r0, #0
20029aa8:	f040 8099 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029aac:	a904      	add	r1, sp, #16
20029aae:	4632      	mov	r2, r6
20029ab0:	4608      	mov	r0, r1
20029ab2:	f7fe ff54 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029ab6:	4603      	mov	r3, r0
20029ab8:	2800      	cmp	r0, #0
20029aba:	f040 8090 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029abe:	2201      	movs	r2, #1
20029ac0:	f104 012c 	add.w	r1, r4, #44	@ 0x2c
20029ac4:	a80d      	add	r0, sp, #52	@ 0x34
20029ac6:	f7fe fcbf 	bl	20028448 <mbedtls_mpi_sub_int>
20029aca:	4603      	mov	r3, r0
20029acc:	2800      	cmp	r0, #0
20029ace:	f040 8086 	bne.w	20029bde <mbedtls_rsa_private+0x22a>
20029ad2:	2201      	movs	r2, #1
20029ad4:	f104 0138 	add.w	r1, r4, #56	@ 0x38
20029ad8:	a810      	add	r0, sp, #64	@ 0x40
20029ada:	f7fe fcb5 	bl	20028448 <mbedtls_mpi_sub_int>
20029ade:	4603      	mov	r3, r0
20029ae0:	2800      	cmp	r0, #0
20029ae2:	d17c      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029ae4:	463b      	mov	r3, r7
20029ae6:	462a      	mov	r2, r5
20029ae8:	211c      	movs	r1, #28
20029aea:	a813      	add	r0, sp, #76	@ 0x4c
20029aec:	f7ff f9fb 	bl	20028ee6 <mbedtls_mpi_fill_random>
20029af0:	4603      	mov	r3, r0
20029af2:	2800      	cmp	r0, #0
20029af4:	d173      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029af6:	aa13      	add	r2, sp, #76	@ 0x4c
20029af8:	a90d      	add	r1, sp, #52	@ 0x34
20029afa:	a816      	add	r0, sp, #88	@ 0x58
20029afc:	f7fe fcba 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029b00:	4603      	mov	r3, r0
20029b02:	2800      	cmp	r0, #0
20029b04:	d16b      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b06:	a916      	add	r1, sp, #88	@ 0x58
20029b08:	4652      	mov	r2, sl
20029b0a:	4608      	mov	r0, r1
20029b0c:	f7fe fc4f 	bl	200283ae <mbedtls_mpi_add_mpi>
20029b10:	4603      	mov	r3, r0
20029b12:	2800      	cmp	r0, #0
20029b14:	d163      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b16:	463b      	mov	r3, r7
20029b18:	462a      	mov	r2, r5
20029b1a:	211c      	movs	r1, #28
20029b1c:	a813      	add	r0, sp, #76	@ 0x4c
20029b1e:	f7ff f9e2 	bl	20028ee6 <mbedtls_mpi_fill_random>
20029b22:	4603      	mov	r3, r0
20029b24:	2800      	cmp	r0, #0
20029b26:	d15a      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b28:	aa13      	add	r2, sp, #76	@ 0x4c
20029b2a:	a910      	add	r1, sp, #64	@ 0x40
20029b2c:	a819      	add	r0, sp, #100	@ 0x64
20029b2e:	f7fe fca1 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029b32:	4603      	mov	r3, r0
20029b34:	2800      	cmp	r0, #0
20029b36:	d152      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b38:	a919      	add	r1, sp, #100	@ 0x64
20029b3a:	464a      	mov	r2, r9
20029b3c:	4608      	mov	r0, r1
20029b3e:	f7fe fc36 	bl	200283ae <mbedtls_mpi_add_mpi>
20029b42:	4603      	mov	r3, r0
20029b44:	2800      	cmp	r0, #0
20029b46:	d14a      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b48:	f10d 0964 	add.w	r9, sp, #100	@ 0x64
20029b4c:	f10d 0a58 	add.w	sl, sp, #88	@ 0x58
20029b50:	f104 0374 	add.w	r3, r4, #116	@ 0x74
20029b54:	f104 082c 	add.w	r8, r4, #44	@ 0x2c
20029b58:	9300      	str	r3, [sp, #0]
20029b5a:	4652      	mov	r2, sl
20029b5c:	4643      	mov	r3, r8
20029b5e:	a904      	add	r1, sp, #16
20029b60:	a807      	add	r0, sp, #28
20029b62:	f7fe ff2e 	bl	200289c2 <mbedtls_mpi_exp_mod>
20029b66:	4603      	mov	r3, r0
20029b68:	2800      	cmp	r0, #0
20029b6a:	d138      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029b6c:	f104 0380 	add.w	r3, r4, #128	@ 0x80
20029b70:	f104 0738 	add.w	r7, r4, #56	@ 0x38
20029b74:	9300      	str	r3, [sp, #0]
20029b76:	464a      	mov	r2, r9
20029b78:	463b      	mov	r3, r7
20029b7a:	a904      	add	r1, sp, #16
20029b7c:	a80a      	add	r0, sp, #40	@ 0x28
20029b7e:	f7fe ff20 	bl	200289c2 <mbedtls_mpi_exp_mod>
20029b82:	4603      	mov	r3, r0
20029b84:	bb58      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029b86:	aa0a      	add	r2, sp, #40	@ 0x28
20029b88:	a907      	add	r1, sp, #28
20029b8a:	a804      	add	r0, sp, #16
20029b8c:	f7fe fc35 	bl	200283fa <mbedtls_mpi_sub_mpi>
20029b90:	4603      	mov	r3, r0
20029b92:	bb20      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029b94:	f104 025c 	add.w	r2, r4, #92	@ 0x5c
20029b98:	a904      	add	r1, sp, #16
20029b9a:	a807      	add	r0, sp, #28
20029b9c:	f7fe fc6a 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029ba0:	4603      	mov	r3, r0
20029ba2:	b9e0      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029ba4:	4642      	mov	r2, r8
20029ba6:	a907      	add	r1, sp, #28
20029ba8:	a804      	add	r0, sp, #16
20029baa:	f7fe fed8 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029bae:	4603      	mov	r3, r0
20029bb0:	b9a8      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029bb2:	463a      	mov	r2, r7
20029bb4:	a904      	add	r1, sp, #16
20029bb6:	a807      	add	r0, sp, #28
20029bb8:	f7fe fc5c 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029bbc:	4603      	mov	r3, r0
20029bbe:	b970      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029bc0:	aa07      	add	r2, sp, #28
20029bc2:	a90a      	add	r1, sp, #40	@ 0x28
20029bc4:	a804      	add	r0, sp, #16
20029bc6:	f7fe fbf2 	bl	200283ae <mbedtls_mpi_add_mpi>
20029bca:	4603      	mov	r3, r0
20029bcc:	b938      	cbnz	r0, 20029bde <mbedtls_rsa_private+0x22a>
20029bce:	2d00      	cmp	r5, #0
20029bd0:	d15f      	bne.n	20029c92 <mbedtls_rsa_private+0x2de>
20029bd2:	6862      	ldr	r2, [r4, #4]
20029bd4:	9926      	ldr	r1, [sp, #152]	@ 0x98
20029bd6:	a804      	add	r0, sp, #16
20029bd8:	f7fe f9a1 	bl	20027f1e <mbedtls_mpi_write_binary>
20029bdc:	4603      	mov	r3, r0
20029bde:	a804      	add	r0, sp, #16
20029be0:	9303      	str	r3, [sp, #12]
20029be2:	f7fe f8a6 	bl	20027d32 <mbedtls_mpi_free>
20029be6:	a807      	add	r0, sp, #28
20029be8:	f7fe f8a3 	bl	20027d32 <mbedtls_mpi_free>
20029bec:	a80a      	add	r0, sp, #40	@ 0x28
20029bee:	f7fe f8a0 	bl	20027d32 <mbedtls_mpi_free>
20029bf2:	a80d      	add	r0, sp, #52	@ 0x34
20029bf4:	f7fe f89d 	bl	20027d32 <mbedtls_mpi_free>
20029bf8:	a810      	add	r0, sp, #64	@ 0x40
20029bfa:	f7fe f89a 	bl	20027d32 <mbedtls_mpi_free>
20029bfe:	a813      	add	r0, sp, #76	@ 0x4c
20029c00:	f7fe f897 	bl	20027d32 <mbedtls_mpi_free>
20029c04:	9b03      	ldr	r3, [sp, #12]
20029c06:	b135      	cbz	r5, 20029c16 <mbedtls_rsa_private+0x262>
20029c08:	a816      	add	r0, sp, #88	@ 0x58
20029c0a:	f7fe f892 	bl	20027d32 <mbedtls_mpi_free>
20029c0e:	a819      	add	r0, sp, #100	@ 0x64
20029c10:	f7fe f88f 	bl	20027d32 <mbedtls_mpi_free>
20029c14:	9b03      	ldr	r3, [sp, #12]
20029c16:	b10b      	cbz	r3, 20029c1c <mbedtls_rsa_private+0x268>
20029c18:	f5a3 4386 	sub.w	r3, r3, #17152	@ 0x4300
20029c1c:	4618      	mov	r0, r3
20029c1e:	b01d      	add	sp, #116	@ 0x74
20029c20:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20029c24:	9b03      	ldr	r3, [sp, #12]
20029c26:	3b01      	subs	r3, #1
20029c28:	9303      	str	r3, [sp, #12]
20029c2a:	d107      	bne.n	20029c3c <mbedtls_rsa_private+0x288>
20029c2c:	4b24      	ldr	r3, [pc, #144]	@ (20029cc0 <mbedtls_rsa_private+0x30c>)
20029c2e:	e7d6      	b.n	20029bde <mbedtls_rsa_private+0x22a>
20029c30:	230b      	movs	r3, #11
20029c32:	f104 0b98 	add.w	fp, r4, #152	@ 0x98
20029c36:	9303      	str	r3, [sp, #12]
20029c38:	f104 088c 	add.w	r8, r4, #140	@ 0x8c
20029c3c:	6861      	ldr	r1, [r4, #4]
20029c3e:	463b      	mov	r3, r7
20029c40:	462a      	mov	r2, r5
20029c42:	4658      	mov	r0, fp
20029c44:	3901      	subs	r1, #1
20029c46:	f7ff f94e 	bl	20028ee6 <mbedtls_mpi_fill_random>
20029c4a:	4603      	mov	r3, r0
20029c4c:	2800      	cmp	r0, #0
20029c4e:	d1c6      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029c50:	4632      	mov	r2, r6
20029c52:	4659      	mov	r1, fp
20029c54:	4640      	mov	r0, r8
20029c56:	f7ff f8c8 	bl	20028dea <mbedtls_mpi_gcd>
20029c5a:	4603      	mov	r3, r0
20029c5c:	2800      	cmp	r0, #0
20029c5e:	d1be      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029c60:	2101      	movs	r1, #1
20029c62:	4640      	mov	r0, r8
20029c64:	f7fe faf7 	bl	20028256 <mbedtls_mpi_cmp_int>
20029c68:	2800      	cmp	r0, #0
20029c6a:	d1db      	bne.n	20029c24 <mbedtls_rsa_private+0x270>
20029c6c:	4632      	mov	r2, r6
20029c6e:	4659      	mov	r1, fp
20029c70:	4640      	mov	r0, r8
20029c72:	f7ff f955 	bl	20028f20 <mbedtls_mpi_inv_mod>
20029c76:	4603      	mov	r3, r0
20029c78:	2800      	cmp	r0, #0
20029c7a:	d1b0      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029c7c:	f104 0368 	add.w	r3, r4, #104	@ 0x68
20029c80:	9300      	str	r3, [sp, #0]
20029c82:	4641      	mov	r1, r8
20029c84:	4633      	mov	r3, r6
20029c86:	4640      	mov	r0, r8
20029c88:	f104 0214 	add.w	r2, r4, #20
20029c8c:	f7fe fe99 	bl	200289c2 <mbedtls_mpi_exp_mod>
20029c90:	e6fe      	b.n	20029a90 <mbedtls_rsa_private+0xdc>
20029c92:	a904      	add	r1, sp, #16
20029c94:	4608      	mov	r0, r1
20029c96:	f104 0298 	add.w	r2, r4, #152	@ 0x98
20029c9a:	f7fe fbeb 	bl	20028474 <mbedtls_mpi_mul_mpi>
20029c9e:	4603      	mov	r3, r0
20029ca0:	2800      	cmp	r0, #0
20029ca2:	d19c      	bne.n	20029bde <mbedtls_rsa_private+0x22a>
20029ca4:	a904      	add	r1, sp, #16
20029ca6:	4632      	mov	r2, r6
20029ca8:	4608      	mov	r0, r1
20029caa:	f7fe fe58 	bl	2002895e <mbedtls_mpi_mod_mpi>
20029cae:	4603      	mov	r3, r0
20029cb0:	2800      	cmp	r0, #0
20029cb2:	d08e      	beq.n	20029bd2 <mbedtls_rsa_private+0x21e>
20029cb4:	e793      	b.n	20029bde <mbedtls_rsa_private+0x22a>
20029cb6:	f06f 0303 	mvn.w	r3, #3
20029cba:	e790      	b.n	20029bde <mbedtls_rsa_private+0x22a>
20029cbc:	4b01      	ldr	r3, [pc, #4]	@ (20029cc4 <mbedtls_rsa_private+0x310>)
20029cbe:	e7ad      	b.n	20029c1c <mbedtls_rsa_private+0x268>
20029cc0:	ffffbb80 	.word	0xffffbb80
20029cc4:	ffffbf80 	.word	0xffffbf80

20029cc8 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt>:
20029cc8:	e92d 4ff7 	stmdb	sp!, {r0, r1, r2, r4, r5, r6, r7, r8, r9, sl, fp, lr}
20029ccc:	4698      	mov	r8, r3
20029cce:	e9dd a30c 	ldrd	sl, r3, [sp, #48]	@ 0x30
20029cd2:	f1b8 0f01 	cmp.w	r8, #1
20029cd6:	4606      	mov	r6, r0
20029cd8:	460f      	mov	r7, r1
20029cda:	4691      	mov	r9, r2
20029cdc:	9d0e      	ldr	r5, [sp, #56]	@ 0x38
20029cde:	d103      	bne.n	20029ce8 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0x20>
20029ce0:	f8d0 20a4 	ldr.w	r2, [r0, #164]	@ 0xa4
20029ce4:	2a00      	cmp	r2, #0
20029ce6:	d162      	bne.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029ce8:	2f00      	cmp	r7, #0
20029cea:	d060      	beq.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029cec:	2b00      	cmp	r3, #0
20029cee:	d05e      	beq.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029cf0:	2d00      	cmp	r5, #0
20029cf2:	d05c      	beq.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029cf4:	f11a 0f0c 	cmn.w	sl, #12
20029cf8:	6874      	ldr	r4, [r6, #4]
20029cfa:	d858      	bhi.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029cfc:	f10a 020b 	add.w	r2, sl, #11
20029d00:	42a2      	cmp	r2, r4
20029d02:	d854      	bhi.n	20029dae <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xe6>
20029d04:	4629      	mov	r1, r5
20029d06:	2200      	movs	r2, #0
20029d08:	eba4 040a 	sub.w	r4, r4, sl
20029d0c:	3c03      	subs	r4, #3
20029d0e:	f801 2b02 	strb.w	r2, [r1], #2
20029d12:	f1b8 0f00 	cmp.w	r8, #0
20029d16:	d131      	bne.n	20029d7c <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xb4>
20029d18:	2202      	movs	r2, #2
20029d1a:	4414      	add	r4, r2
20029d1c:	706a      	strb	r2, [r5, #1]
20029d1e:	442c      	add	r4, r5
20029d20:	42a1      	cmp	r1, r4
20029d22:	d112      	bne.n	20029d4a <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0x82>
20029d24:	2200      	movs	r2, #0
20029d26:	4620      	mov	r0, r4
20029d28:	4619      	mov	r1, r3
20029d2a:	f800 2b01 	strb.w	r2, [r0], #1
20029d2e:	4652      	mov	r2, sl
20029d30:	f000 fdaa 	bl	2002a888 <memcpy>
20029d34:	f1b8 0f00 	cmp.w	r8, #0
20029d38:	d12f      	bne.n	20029d9a <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xd2>
20029d3a:	462a      	mov	r2, r5
20029d3c:	4629      	mov	r1, r5
20029d3e:	4630      	mov	r0, r6
20029d40:	b003      	add	sp, #12
20029d42:	e8bd 4ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20029d46:	f7ff bdff 	b.w	20029948 <mbedtls_rsa_public>
20029d4a:	f04f 0b64 	mov.w	fp, #100	@ 0x64
20029d4e:	2201      	movs	r2, #1
20029d50:	4648      	mov	r0, r9
20029d52:	9301      	str	r3, [sp, #4]
20029d54:	9100      	str	r1, [sp, #0]
20029d56:	47b8      	blx	r7
20029d58:	9900      	ldr	r1, [sp, #0]
20029d5a:	9b01      	ldr	r3, [sp, #4]
20029d5c:	780a      	ldrb	r2, [r1, #0]
20029d5e:	b94a      	cbnz	r2, 20029d74 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xac>
20029d60:	f1bb 0b01 	subs.w	fp, fp, #1
20029d64:	d001      	beq.n	20029d6a <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xa2>
20029d66:	2800      	cmp	r0, #0
20029d68:	d0f1      	beq.n	20029d4e <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0x86>
20029d6a:	f5a0 4089 	sub.w	r0, r0, #17536	@ 0x4480
20029d6e:	b003      	add	sp, #12
20029d70:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20029d74:	2800      	cmp	r0, #0
20029d76:	d1f8      	bne.n	20029d6a <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xa2>
20029d78:	3101      	adds	r1, #1
20029d7a:	e7d1      	b.n	20029d20 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0x58>
20029d7c:	2001      	movs	r0, #1
20029d7e:	462a      	mov	r2, r5
20029d80:	f04f 0cff 	mov.w	ip, #255	@ 0xff
20029d84:	f802 0f01 	strb.w	r0, [r2, #1]!
20029d88:	1820      	adds	r0, r4, r0
20029d8a:	4428      	add	r0, r5
20029d8c:	4282      	cmp	r2, r0
20029d8e:	d101      	bne.n	20029d94 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xcc>
20029d90:	440c      	add	r4, r1
20029d92:	e7c7      	b.n	20029d24 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0x5c>
20029d94:	f802 cf01 	strb.w	ip, [r2, #1]!
20029d98:	e7f8      	b.n	20029d8c <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xc4>
20029d9a:	462b      	mov	r3, r5
20029d9c:	464a      	mov	r2, r9
20029d9e:	4639      	mov	r1, r7
20029da0:	4630      	mov	r0, r6
20029da2:	950c      	str	r5, [sp, #48]	@ 0x30
20029da4:	b003      	add	sp, #12
20029da6:	e8bd 4ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20029daa:	f7ff be03 	b.w	200299b4 <mbedtls_rsa_private>
20029dae:	4801      	ldr	r0, [pc, #4]	@ (20029db4 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xec>)
20029db0:	e7dd      	b.n	20029d6e <mbedtls_rsa_rsaes_pkcs1_v15_encrypt+0xa6>
20029db2:	bf00      	nop
20029db4:	ffffbf80 	.word	0xffffbf80

20029db8 <mbedtls_rsa_pkcs1_encrypt>:
20029db8:	b410      	push	{r4}
20029dba:	f8d0 40a4 	ldr.w	r4, [r0, #164]	@ 0xa4
20029dbe:	b91c      	cbnz	r4, 20029dc8 <mbedtls_rsa_pkcs1_encrypt+0x10>
20029dc0:	f85d 4b04 	ldr.w	r4, [sp], #4
20029dc4:	f7ff bf80 	b.w	20029cc8 <mbedtls_rsa_rsaes_pkcs1_v15_encrypt>
20029dc8:	4801      	ldr	r0, [pc, #4]	@ (20029dd0 <mbedtls_rsa_pkcs1_encrypt+0x18>)
20029dca:	f85d 4b04 	ldr.w	r4, [sp], #4
20029dce:	4770      	bx	lr
20029dd0:	ffffbf00 	.word	0xffffbf00

20029dd4 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt>:
20029dd4:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
20029dd8:	4698      	mov	r8, r3
20029dda:	f5ad 6d81 	sub.w	sp, sp, #1032	@ 0x408
20029dde:	f1b8 0f01 	cmp.w	r8, #1
20029de2:	f8dd 3424 	ldr.w	r3, [sp, #1060]	@ 0x424
20029de6:	d103      	bne.n	20029df0 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x1c>
20029de8:	f8d0 40a4 	ldr.w	r4, [r0, #164]	@ 0xa4
20029dec:	2c00      	cmp	r4, #0
20029dee:	d17c      	bne.n	20029eea <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x116>
20029df0:	6845      	ldr	r5, [r0, #4]
20029df2:	f1a5 0410 	sub.w	r4, r5, #16
20029df6:	f5b4 7f7c 	cmp.w	r4, #1008	@ 0x3f0
20029dfa:	d876      	bhi.n	20029eea <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x116>
20029dfc:	ae02      	add	r6, sp, #8
20029dfe:	f1b8 0f00 	cmp.w	r8, #0
20029e02:	d153      	bne.n	20029eac <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xd8>
20029e04:	4632      	mov	r2, r6
20029e06:	4619      	mov	r1, r3
20029e08:	f7ff fd9e 	bl	20029948 <mbedtls_rsa_public>
20029e0c:	4604      	mov	r4, r0
20029e0e:	2800      	cmp	r0, #0
20029e10:	d140      	bne.n	20029e94 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xc0>
20029e12:	f1b8 0f01 	cmp.w	r8, #1
20029e16:	7831      	ldrb	r1, [r6, #0]
20029e18:	7872      	ldrb	r2, [r6, #1]
20029e1a:	f1a5 0703 	sub.w	r7, r5, #3
20029e1e:	d149      	bne.n	20029eb4 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xe0>
20029e20:	f082 0202 	eor.w	r2, r2, #2
20029e24:	ea41 0302 	orr.w	r3, r1, r2
20029e28:	4684      	mov	ip, r0
20029e2a:	4686      	mov	lr, r0
20029e2c:	4602      	mov	r2, r0
20029e2e:	f10d 0109 	add.w	r1, sp, #9
20029e32:	f811 0f01 	ldrb.w	r0, [r1, #1]!
20029e36:	f10e 0e01 	add.w	lr, lr, #1
20029e3a:	f1c0 0800 	rsb	r8, r0, #0
20029e3e:	ea40 0008 	orr.w	r0, r0, r8
20029e42:	f3c0 10c0 	ubfx	r0, r0, #7, #1
20029e46:	f080 0001 	eor.w	r0, r0, #1
20029e4a:	ea4c 0c00 	orr.w	ip, ip, r0
20029e4e:	f1cc 0000 	rsb	r0, ip, #0
20029e52:	ea4c 0000 	orr.w	r0, ip, r0
20029e56:	f3c0 10c0 	ubfx	r0, r0, #7, #1
20029e5a:	f080 0001 	eor.w	r0, r0, #1
20029e5e:	45be      	cmp	lr, r7
20029e60:	4402      	add	r2, r0
20029e62:	d3e6      	bcc.n	20029e32 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x5e>
20029e64:	f10d 000a 	add.w	r0, sp, #10
20029e68:	1881      	adds	r1, r0, r2
20029e6a:	5c80      	ldrb	r0, [r0, r2]
20029e6c:	3101      	adds	r1, #1
20029e6e:	4303      	orrs	r3, r0
20029e70:	2a07      	cmp	r2, #7
20029e72:	bf98      	it	ls
20029e74:	f043 0301 	orrls.w	r3, r3, #1
20029e78:	bb9b      	cbnz	r3, 20029ee2 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x10e>
20029e7a:	1b8b      	subs	r3, r1, r6
20029e7c:	1aea      	subs	r2, r5, r3
20029e7e:	f8dd 342c 	ldr.w	r3, [sp, #1068]	@ 0x42c
20029e82:	429a      	cmp	r2, r3
20029e84:	d82f      	bhi.n	20029ee6 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x112>
20029e86:	f8dd 3420 	ldr.w	r3, [sp, #1056]	@ 0x420
20029e8a:	f8dd 0428 	ldr.w	r0, [sp, #1064]	@ 0x428
20029e8e:	601a      	str	r2, [r3, #0]
20029e90:	f000 fcfa 	bl	2002a888 <memcpy>
20029e94:	2300      	movs	r3, #0
20029e96:	461a      	mov	r2, r3
20029e98:	54f2      	strb	r2, [r6, r3]
20029e9a:	3301      	adds	r3, #1
20029e9c:	f5b3 6f80 	cmp.w	r3, #1024	@ 0x400
20029ea0:	d1fa      	bne.n	20029e98 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xc4>
20029ea2:	4620      	mov	r0, r4
20029ea4:	f50d 6d81 	add.w	sp, sp, #1032	@ 0x408
20029ea8:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
20029eac:	9600      	str	r6, [sp, #0]
20029eae:	f7ff fd81 	bl	200299b4 <mbedtls_rsa_private>
20029eb2:	e7ab      	b.n	20029e0c <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x38>
20029eb4:	f082 0201 	eor.w	r2, r2, #1
20029eb8:	ea41 0302 	orr.w	r3, r1, r2
20029ebc:	4684      	mov	ip, r0
20029ebe:	4602      	mov	r2, r0
20029ec0:	f10d 0109 	add.w	r1, sp, #9
20029ec4:	f811 ef01 	ldrb.w	lr, [r1, #1]!
20029ec8:	3001      	adds	r0, #1
20029eca:	f1be 0fff 	cmp.w	lr, #255	@ 0xff
20029ece:	bf18      	it	ne
20029ed0:	f04c 0c01 	orrne.w	ip, ip, #1
20029ed4:	42b8      	cmp	r0, r7
20029ed6:	f08c 0e01 	eor.w	lr, ip, #1
20029eda:	fa52 f28e 	uxtab	r2, r2, lr
20029ede:	d3f1      	bcc.n	20029ec4 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xf0>
20029ee0:	e7c0      	b.n	20029e64 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x90>
20029ee2:	4c03      	ldr	r4, [pc, #12]	@ (20029ef0 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x11c>)
20029ee4:	e7d6      	b.n	20029e94 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xc0>
20029ee6:	4c03      	ldr	r4, [pc, #12]	@ (20029ef4 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x120>)
20029ee8:	e7d4      	b.n	20029e94 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xc0>
20029eea:	4c03      	ldr	r4, [pc, #12]	@ (20029ef8 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0x124>)
20029eec:	e7d9      	b.n	20029ea2 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt+0xce>
20029eee:	bf00      	nop
20029ef0:	ffffbf00 	.word	0xffffbf00
20029ef4:	ffffbc00 	.word	0xffffbc00
20029ef8:	ffffbf80 	.word	0xffffbf80

20029efc <mbedtls_rsa_pkcs1_decrypt>:
20029efc:	b410      	push	{r4}
20029efe:	f8d0 40a4 	ldr.w	r4, [r0, #164]	@ 0xa4
20029f02:	b91c      	cbnz	r4, 20029f0c <mbedtls_rsa_pkcs1_decrypt+0x10>
20029f04:	f85d 4b04 	ldr.w	r4, [sp], #4
20029f08:	f7ff bf64 	b.w	20029dd4 <mbedtls_rsa_rsaes_pkcs1_v15_decrypt>
20029f0c:	4801      	ldr	r0, [pc, #4]	@ (20029f14 <mbedtls_rsa_pkcs1_decrypt+0x18>)
20029f0e:	f85d 4b04 	ldr.w	r4, [sp], #4
20029f12:	4770      	bx	lr
20029f14:	ffffbf00 	.word	0xffffbf00

20029f18 <mbedtls_rsa_rsassa_pkcs1_v15_sign>:
20029f18:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
20029f1c:	4692      	mov	sl, r2
20029f1e:	2200      	movs	r2, #0
20029f20:	b089      	sub	sp, #36	@ 0x24
20029f22:	2b01      	cmp	r3, #1
20029f24:	4604      	mov	r4, r0
20029f26:	461f      	mov	r7, r3
20029f28:	e9cd 2206 	strd	r2, r2, [sp, #24]
20029f2c:	f89d 8048 	ldrb.w	r8, [sp, #72]	@ 0x48
20029f30:	f8dd 904c 	ldr.w	r9, [sp, #76]	@ 0x4c
20029f34:	9e15      	ldr	r6, [sp, #84]	@ 0x54
20029f36:	9102      	str	r1, [sp, #8]
20029f38:	d107      	bne.n	20029f4a <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x32>
20029f3a:	f8d0 20a4 	ldr.w	r2, [r0, #164]	@ 0xa4
20029f3e:	b122      	cbz	r2, 20029f4a <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x32>
20029f40:	4d59      	ldr	r5, [pc, #356]	@ (2002a0a8 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x190>)
20029f42:	4628      	mov	r0, r5
20029f44:	b009      	add	sp, #36	@ 0x24
20029f46:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
20029f4a:	f8d4 b004 	ldr.w	fp, [r4, #4]
20029f4e:	f1ab 0503 	sub.w	r5, fp, #3
20029f52:	f1b8 0f00 	cmp.w	r8, #0
20029f56:	d014      	beq.n	20029f82 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x6a>
20029f58:	4640      	mov	r0, r8
20029f5a:	f7fb ff77 	bl	20025e4c <mbedtls_md_info_from_type>
20029f5e:	4681      	mov	r9, r0
20029f60:	2800      	cmp	r0, #0
20029f62:	d0ed      	beq.n	20029f40 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x28>
20029f64:	4640      	mov	r0, r8
20029f66:	aa06      	add	r2, sp, #24
20029f68:	a907      	add	r1, sp, #28
20029f6a:	f7ff f9d3 	bl	20029314 <mbedtls_oid_get_oid_by_md>
20029f6e:	2800      	cmp	r0, #0
20029f70:	d1e6      	bne.n	20029f40 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x28>
20029f72:	9a06      	ldr	r2, [sp, #24]
20029f74:	4648      	mov	r0, r9
20029f76:	1aaa      	subs	r2, r5, r2
20029f78:	f1a2 050a 	sub.w	r5, r2, #10
20029f7c:	f7fb ff72 	bl	20025e64 <mbedtls_md_get_size>
20029f80:	4681      	mov	r9, r0
20029f82:	eba5 0209 	sub.w	r2, r5, r9
20029f86:	2a07      	cmp	r2, #7
20029f88:	d9da      	bls.n	20029f40 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x28>
20029f8a:	4593      	cmp	fp, r2
20029f8c:	d3d8      	bcc.n	20029f40 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x28>
20029f8e:	46b3      	mov	fp, r6
20029f90:	2500      	movs	r5, #0
20029f92:	2101      	movs	r1, #1
20029f94:	f80b 5b02 	strb.w	r5, [fp], #2
20029f98:	4658      	mov	r0, fp
20029f9a:	7071      	strb	r1, [r6, #1]
20029f9c:	21ff      	movs	r1, #255	@ 0xff
20029f9e:	9203      	str	r2, [sp, #12]
20029fa0:	f000 fc58 	bl	2002a854 <memset>
20029fa4:	9a03      	ldr	r2, [sp, #12]
20029fa6:	eb0b 0002 	add.w	r0, fp, r2
20029faa:	f80b 5002 	strb.w	r5, [fp, r2]
20029fae:	f1b8 0f00 	cmp.w	r8, #0
20029fb2:	d10c      	bne.n	20029fce <mbedtls_rsa_rsassa_pkcs1_v15_sign+0xb6>
20029fb4:	464a      	mov	r2, r9
20029fb6:	9914      	ldr	r1, [sp, #80]	@ 0x50
20029fb8:	3001      	adds	r0, #1
20029fba:	f000 fc65 	bl	2002a888 <memcpy>
20029fbe:	bb8f      	cbnz	r7, 2002a024 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x10c>
20029fc0:	4632      	mov	r2, r6
20029fc2:	4631      	mov	r1, r6
20029fc4:	4620      	mov	r0, r4
20029fc6:	f7ff fcbf 	bl	20029948 <mbedtls_rsa_public>
20029fca:	4605      	mov	r5, r0
20029fcc:	e7b9      	b.n	20029f42 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x2a>
20029fce:	2130      	movs	r1, #48	@ 0x30
20029fd0:	7041      	strb	r1, [r0, #1]
20029fd2:	9a06      	ldr	r2, [sp, #24]
20029fd4:	70c1      	strb	r1, [r0, #3]
20029fd6:	3208      	adds	r2, #8
20029fd8:	fa52 f289 	uxtab	r2, r2, r9
20029fdc:	7082      	strb	r2, [r0, #2]
20029fde:	9a06      	ldr	r2, [sp, #24]
20029fe0:	f100 0807 	add.w	r8, r0, #7
20029fe4:	b2d1      	uxtb	r1, r2
20029fe6:	f101 0c04 	add.w	ip, r1, #4
20029fea:	f880 c004 	strb.w	ip, [r0, #4]
20029fee:	f04f 0c06 	mov.w	ip, #6
20029ff2:	7181      	strb	r1, [r0, #6]
20029ff4:	f880 c005 	strb.w	ip, [r0, #5]
20029ff8:	9907      	ldr	r1, [sp, #28]
20029ffa:	4640      	mov	r0, r8
20029ffc:	9203      	str	r2, [sp, #12]
20029ffe:	f000 fc43 	bl	2002a888 <memcpy>
2002a002:	2105      	movs	r1, #5
2002a004:	9a03      	ldr	r2, [sp, #12]
2002a006:	fa5f fb89 	uxtb.w	fp, r9
2002a00a:	eb08 0002 	add.w	r0, r8, r2
2002a00e:	f808 1002 	strb.w	r1, [r8, r2]
2002a012:	2204      	movs	r2, #4
2002a014:	7045      	strb	r5, [r0, #1]
2002a016:	7082      	strb	r2, [r0, #2]
2002a018:	f880 b003 	strb.w	fp, [r0, #3]
2002a01c:	464a      	mov	r2, r9
2002a01e:	9914      	ldr	r1, [sp, #80]	@ 0x50
2002a020:	3004      	adds	r0, #4
2002a022:	e7ca      	b.n	20029fba <mbedtls_rsa_rsassa_pkcs1_v15_sign+0xa2>
2002a024:	6865      	ldr	r5, [r4, #4]
2002a026:	2001      	movs	r0, #1
2002a028:	4629      	mov	r1, r5
2002a02a:	f000 fb31 	bl	2002a690 <calloc>
2002a02e:	4607      	mov	r7, r0
2002a030:	b140      	cbz	r0, 2002a044 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x12c>
2002a032:	4629      	mov	r1, r5
2002a034:	2001      	movs	r0, #1
2002a036:	f000 fb2b 	bl	2002a690 <calloc>
2002a03a:	4680      	mov	r8, r0
2002a03c:	b928      	cbnz	r0, 2002a04a <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x132>
2002a03e:	4638      	mov	r0, r7
2002a040:	f000 fb42 	bl	2002a6c8 <free>
2002a044:	f06f 050f 	mvn.w	r5, #15
2002a048:	e77b      	b.n	20029f42 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x2a>
2002a04a:	4633      	mov	r3, r6
2002a04c:	4652      	mov	r2, sl
2002a04e:	4620      	mov	r0, r4
2002a050:	9902      	ldr	r1, [sp, #8]
2002a052:	9700      	str	r7, [sp, #0]
2002a054:	f7ff fcae 	bl	200299b4 <mbedtls_rsa_private>
2002a058:	4605      	mov	r5, r0
2002a05a:	b9a0      	cbnz	r0, 2002a086 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x16e>
2002a05c:	4642      	mov	r2, r8
2002a05e:	4639      	mov	r1, r7
2002a060:	4620      	mov	r0, r4
2002a062:	f7ff fc71 	bl	20029948 <mbedtls_rsa_public>
2002a066:	4605      	mov	r5, r0
2002a068:	b968      	cbnz	r0, 2002a086 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x16e>
2002a06a:	4601      	mov	r1, r0
2002a06c:	4603      	mov	r3, r0
2002a06e:	6862      	ldr	r2, [r4, #4]
2002a070:	429a      	cmp	r2, r3
2002a072:	d10f      	bne.n	2002a094 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x17c>
2002a074:	f88d 1017 	strb.w	r1, [sp, #23]
2002a078:	f89d 3017 	ldrb.w	r3, [sp, #23]
2002a07c:	b98b      	cbnz	r3, 2002a0a2 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x18a>
2002a07e:	4639      	mov	r1, r7
2002a080:	4630      	mov	r0, r6
2002a082:	f000 fc01 	bl	2002a888 <memcpy>
2002a086:	4638      	mov	r0, r7
2002a088:	f000 fb1e 	bl	2002a6c8 <free>
2002a08c:	4640      	mov	r0, r8
2002a08e:	f000 fb1b 	bl	2002a6c8 <free>
2002a092:	e756      	b.n	20029f42 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x2a>
2002a094:	f818 0003 	ldrb.w	r0, [r8, r3]
2002a098:	5cf4      	ldrb	r4, [r6, r3]
2002a09a:	3301      	adds	r3, #1
2002a09c:	4060      	eors	r0, r4
2002a09e:	4301      	orrs	r1, r0
2002a0a0:	e7e6      	b.n	2002a070 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x158>
2002a0a2:	4d02      	ldr	r5, [pc, #8]	@ (2002a0ac <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x194>)
2002a0a4:	e7ef      	b.n	2002a086 <mbedtls_rsa_rsassa_pkcs1_v15_sign+0x16e>
2002a0a6:	bf00      	nop
2002a0a8:	ffffbf80 	.word	0xffffbf80
2002a0ac:	ffffbd00 	.word	0xffffbd00

2002a0b0 <mbedtls_rsa_pkcs1_sign>:
2002a0b0:	b430      	push	{r4, r5}
2002a0b2:	f8d0 50a4 	ldr.w	r5, [r0, #164]	@ 0xa4
2002a0b6:	f89d 4008 	ldrb.w	r4, [sp, #8]
2002a0ba:	b91d      	cbnz	r5, 2002a0c4 <mbedtls_rsa_pkcs1_sign+0x14>
2002a0bc:	9402      	str	r4, [sp, #8]
2002a0be:	bc30      	pop	{r4, r5}
2002a0c0:	f7ff bf2a 	b.w	20029f18 <mbedtls_rsa_rsassa_pkcs1_v15_sign>
2002a0c4:	4801      	ldr	r0, [pc, #4]	@ (2002a0cc <mbedtls_rsa_pkcs1_sign+0x1c>)
2002a0c6:	bc30      	pop	{r4, r5}
2002a0c8:	4770      	bx	lr
2002a0ca:	bf00      	nop
2002a0cc:	ffffbf00 	.word	0xffffbf00

2002a0d0 <mbedtls_rsa_rsassa_pkcs1_v15_verify>:
2002a0d0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
2002a0d4:	461c      	mov	r4, r3
2002a0d6:	f2ad 4d2c 	subw	sp, sp, #1068	@ 0x42c
2002a0da:	f89d 3450 	ldrb.w	r3, [sp, #1104]	@ 0x450
2002a0de:	2c01      	cmp	r4, #1
2002a0e0:	9303      	str	r3, [sp, #12]
2002a0e2:	f8dd 8454 	ldr.w	r8, [sp, #1108]	@ 0x454
2002a0e6:	f8dd 345c 	ldr.w	r3, [sp, #1116]	@ 0x45c
2002a0ea:	d108      	bne.n	2002a0fe <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x2e>
2002a0ec:	f8d0 50a4 	ldr.w	r5, [r0, #164]	@ 0xa4
2002a0f0:	b12d      	cbz	r5, 2002a0fe <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x2e>
2002a0f2:	4d60      	ldr	r5, [pc, #384]	@ (2002a274 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x1a4>)
2002a0f4:	4628      	mov	r0, r5
2002a0f6:	f20d 4d2c 	addw	sp, sp, #1068	@ 0x42c
2002a0fa:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
2002a0fe:	6846      	ldr	r6, [r0, #4]
2002a100:	f1a6 0510 	sub.w	r5, r6, #16
2002a104:	f5b5 7f7c 	cmp.w	r5, #1008	@ 0x3f0
2002a108:	d8f3      	bhi.n	2002a0f2 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x22>
2002a10a:	af0a      	add	r7, sp, #40	@ 0x28
2002a10c:	b954      	cbnz	r4, 2002a124 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x54>
2002a10e:	463a      	mov	r2, r7
2002a110:	4619      	mov	r1, r3
2002a112:	f7ff fc19 	bl	20029948 <mbedtls_rsa_public>
2002a116:	4605      	mov	r5, r0
2002a118:	2800      	cmp	r0, #0
2002a11a:	d1eb      	bne.n	2002a0f4 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x24>
2002a11c:	783b      	ldrb	r3, [r7, #0]
2002a11e:	b12b      	cbz	r3, 2002a12c <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x5c>
2002a120:	4d55      	ldr	r5, [pc, #340]	@ (2002a278 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x1a8>)
2002a122:	e7e7      	b.n	2002a0f4 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x24>
2002a124:	9700      	str	r7, [sp, #0]
2002a126:	f7ff fc45 	bl	200299b4 <mbedtls_rsa_private>
2002a12a:	e7f4      	b.n	2002a116 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x46>
2002a12c:	787b      	ldrb	r3, [r7, #1]
2002a12e:	ac06      	add	r4, sp, #24
2002a130:	f10d 002a 	add.w	r0, sp, #42	@ 0x2a
2002a134:	2b01      	cmp	r3, #1
2002a136:	6020      	str	r0, [r4, #0]
2002a138:	d1f2      	bne.n	2002a120 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x50>
2002a13a:	1e73      	subs	r3, r6, #1
2002a13c:	443b      	add	r3, r7
2002a13e:	7802      	ldrb	r2, [r0, #0]
2002a140:	b992      	cbnz	r2, 2002a168 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x98>
2002a142:	3001      	adds	r0, #1
2002a144:	1bc7      	subs	r7, r0, r7
2002a146:	2f0a      	cmp	r7, #10
2002a148:	6020      	str	r0, [r4, #0]
2002a14a:	dde9      	ble.n	2002a120 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x50>
2002a14c:	1bf6      	subs	r6, r6, r7
2002a14e:	4546      	cmp	r6, r8
2002a150:	d112      	bne.n	2002a178 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0xa8>
2002a152:	9b03      	ldr	r3, [sp, #12]
2002a154:	b983      	cbnz	r3, 2002a178 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0xa8>
2002a156:	4642      	mov	r2, r8
2002a158:	f8dd 1458 	ldr.w	r1, [sp, #1112]	@ 0x458
2002a15c:	f000 fb6a 	bl	2002a834 <memcmp>
2002a160:	2800      	cmp	r0, #0
2002a162:	d0c7      	beq.n	2002a0f4 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x24>
2002a164:	4d45      	ldr	r5, [pc, #276]	@ (2002a27c <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x1ac>)
2002a166:	e7c5      	b.n	2002a0f4 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x24>
2002a168:	4298      	cmp	r0, r3
2002a16a:	d2d9      	bcs.n	2002a120 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x50>
2002a16c:	2aff      	cmp	r2, #255	@ 0xff
2002a16e:	f100 0001 	add.w	r0, r0, #1
2002a172:	d1d5      	bne.n	2002a120 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x50>
2002a174:	6020      	str	r0, [r4, #0]
2002a176:	e7e2      	b.n	2002a13e <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x6e>
2002a178:	9803      	ldr	r0, [sp, #12]
2002a17a:	f7fb fe67 	bl	20025e4c <mbedtls_md_info_from_type>
2002a17e:	2800      	cmp	r0, #0
2002a180:	d0b7      	beq.n	2002a0f2 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x22>
2002a182:	f7fb fe6f 	bl	20025e64 <mbedtls_md_get_size>
2002a186:	f8d4 a000 	ldr.w	sl, [r4]
2002a18a:	af05      	add	r7, sp, #20
2002a18c:	eb0a 0806 	add.w	r8, sl, r6
2002a190:	4681      	mov	r9, r0
2002a192:	2330      	movs	r3, #48	@ 0x30
2002a194:	463a      	mov	r2, r7
2002a196:	4641      	mov	r1, r8
2002a198:	4620      	mov	r0, r4
2002a19a:	f7fd fb95 	bl	200278c8 <mbedtls_asn1_get_tag>
2002a19e:	2800      	cmp	r0, #0
2002a1a0:	d1e0      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1a2:	f8d4 b000 	ldr.w	fp, [r4]
2002a1a6:	f10a 0a02 	add.w	sl, sl, #2
2002a1aa:	45d3      	cmp	fp, sl
2002a1ac:	d1da      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1ae:	683b      	ldr	r3, [r7, #0]
2002a1b0:	3302      	adds	r3, #2
2002a1b2:	42b3      	cmp	r3, r6
2002a1b4:	d1d6      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1b6:	2330      	movs	r3, #48	@ 0x30
2002a1b8:	463a      	mov	r2, r7
2002a1ba:	4641      	mov	r1, r8
2002a1bc:	4620      	mov	r0, r4
2002a1be:	f7fd fb83 	bl	200278c8 <mbedtls_asn1_get_tag>
2002a1c2:	2800      	cmp	r0, #0
2002a1c4:	d1ce      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1c6:	f8d4 a000 	ldr.w	sl, [r4]
2002a1ca:	f10b 0b02 	add.w	fp, fp, #2
2002a1ce:	45da      	cmp	sl, fp
2002a1d0:	d1c8      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1d2:	683b      	ldr	r3, [r7, #0]
2002a1d4:	3306      	adds	r3, #6
2002a1d6:	444b      	add	r3, r9
2002a1d8:	42b3      	cmp	r3, r6
2002a1da:	d1c3      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1dc:	2306      	movs	r3, #6
2002a1de:	4641      	mov	r1, r8
2002a1e0:	4620      	mov	r0, r4
2002a1e2:	aa08      	add	r2, sp, #32
2002a1e4:	ae07      	add	r6, sp, #28
2002a1e6:	f7fd fb6f 	bl	200278c8 <mbedtls_asn1_get_tag>
2002a1ea:	2800      	cmp	r0, #0
2002a1ec:	d1ba      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1ee:	6823      	ldr	r3, [r4, #0]
2002a1f0:	f10a 0a02 	add.w	sl, sl, #2
2002a1f4:	4553      	cmp	r3, sl
2002a1f6:	d1b5      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a1f8:	9a08      	ldr	r2, [sp, #32]
2002a1fa:	f10d 0a13 	add.w	sl, sp, #19
2002a1fe:	9309      	str	r3, [sp, #36]	@ 0x24
2002a200:	4651      	mov	r1, sl
2002a202:	4413      	add	r3, r2
2002a204:	4630      	mov	r0, r6
2002a206:	6023      	str	r3, [r4, #0]
2002a208:	f7ff f86a 	bl	200292e0 <mbedtls_oid_get_md_alg>
2002a20c:	2800      	cmp	r0, #0
2002a20e:	d1a9      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a210:	f89d 3013 	ldrb.w	r3, [sp, #19]
2002a214:	9a03      	ldr	r2, [sp, #12]
2002a216:	4293      	cmp	r3, r2
2002a218:	d1a4      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a21a:	2305      	movs	r3, #5
2002a21c:	463a      	mov	r2, r7
2002a21e:	4641      	mov	r1, r8
2002a220:	4620      	mov	r0, r4
2002a222:	f8d4 a000 	ldr.w	sl, [r4]
2002a226:	f7fd fb4f 	bl	200278c8 <mbedtls_asn1_get_tag>
2002a22a:	2800      	cmp	r0, #0
2002a22c:	d19a      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a22e:	6826      	ldr	r6, [r4, #0]
2002a230:	f10a 0a02 	add.w	sl, sl, #2
2002a234:	4556      	cmp	r6, sl
2002a236:	d195      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a238:	2304      	movs	r3, #4
2002a23a:	463a      	mov	r2, r7
2002a23c:	4641      	mov	r1, r8
2002a23e:	4620      	mov	r0, r4
2002a240:	f7fd fb42 	bl	200278c8 <mbedtls_asn1_get_tag>
2002a244:	2800      	cmp	r0, #0
2002a246:	d18d      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a248:	6824      	ldr	r4, [r4, #0]
2002a24a:	3602      	adds	r6, #2
2002a24c:	42b4      	cmp	r4, r6
2002a24e:	d189      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a250:	683b      	ldr	r3, [r7, #0]
2002a252:	454b      	cmp	r3, r9
2002a254:	d186      	bne.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a256:	464a      	mov	r2, r9
2002a258:	4620      	mov	r0, r4
2002a25a:	f8dd 1458 	ldr.w	r1, [sp, #1112]	@ 0x458
2002a25e:	f000 fae9 	bl	2002a834 <memcmp>
2002a262:	2800      	cmp	r0, #0
2002a264:	f47f af7e 	bne.w	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a268:	444c      	add	r4, r9
2002a26a:	45a0      	cmp	r8, r4
2002a26c:	f43f af42 	beq.w	2002a0f4 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x24>
2002a270:	e778      	b.n	2002a164 <mbedtls_rsa_rsassa_pkcs1_v15_verify+0x94>
2002a272:	bf00      	nop
2002a274:	ffffbf80 	.word	0xffffbf80
2002a278:	ffffbf00 	.word	0xffffbf00
2002a27c:	ffffbc80 	.word	0xffffbc80

2002a280 <mbedtls_rsa_pkcs1_verify>:
2002a280:	b430      	push	{r4, r5}
2002a282:	f8d0 50a4 	ldr.w	r5, [r0, #164]	@ 0xa4
2002a286:	f89d 4008 	ldrb.w	r4, [sp, #8]
2002a28a:	b91d      	cbnz	r5, 2002a294 <mbedtls_rsa_pkcs1_verify+0x14>
2002a28c:	9402      	str	r4, [sp, #8]
2002a28e:	bc30      	pop	{r4, r5}
2002a290:	f7ff bf1e 	b.w	2002a0d0 <mbedtls_rsa_rsassa_pkcs1_v15_verify>
2002a294:	4801      	ldr	r0, [pc, #4]	@ (2002a29c <mbedtls_rsa_pkcs1_verify+0x1c>)
2002a296:	bc30      	pop	{r4, r5}
2002a298:	4770      	bx	lr
2002a29a:	bf00      	nop
2002a29c:	ffffbf00 	.word	0xffffbf00

2002a2a0 <mbedtls_rsa_free>:
2002a2a0:	b510      	push	{r4, lr}
2002a2a2:	4604      	mov	r4, r0
2002a2a4:	308c      	adds	r0, #140	@ 0x8c
2002a2a6:	f7fd fd44 	bl	20027d32 <mbedtls_mpi_free>
2002a2aa:	f104 0098 	add.w	r0, r4, #152	@ 0x98
2002a2ae:	f7fd fd40 	bl	20027d32 <mbedtls_mpi_free>
2002a2b2:	f104 0080 	add.w	r0, r4, #128	@ 0x80
2002a2b6:	f7fd fd3c 	bl	20027d32 <mbedtls_mpi_free>
2002a2ba:	f104 0074 	add.w	r0, r4, #116	@ 0x74
2002a2be:	f7fd fd38 	bl	20027d32 <mbedtls_mpi_free>
2002a2c2:	f104 0068 	add.w	r0, r4, #104	@ 0x68
2002a2c6:	f7fd fd34 	bl	20027d32 <mbedtls_mpi_free>
2002a2ca:	f104 005c 	add.w	r0, r4, #92	@ 0x5c
2002a2ce:	f7fd fd30 	bl	20027d32 <mbedtls_mpi_free>
2002a2d2:	f104 0050 	add.w	r0, r4, #80	@ 0x50
2002a2d6:	f7fd fd2c 	bl	20027d32 <mbedtls_mpi_free>
2002a2da:	f104 0044 	add.w	r0, r4, #68	@ 0x44
2002a2de:	f7fd fd28 	bl	20027d32 <mbedtls_mpi_free>
2002a2e2:	f104 0038 	add.w	r0, r4, #56	@ 0x38
2002a2e6:	f7fd fd24 	bl	20027d32 <mbedtls_mpi_free>
2002a2ea:	f104 002c 	add.w	r0, r4, #44	@ 0x2c
2002a2ee:	f7fd fd20 	bl	20027d32 <mbedtls_mpi_free>
2002a2f2:	f104 0020 	add.w	r0, r4, #32
2002a2f6:	f7fd fd1c 	bl	20027d32 <mbedtls_mpi_free>
2002a2fa:	f104 0014 	add.w	r0, r4, #20
2002a2fe:	f7fd fd18 	bl	20027d32 <mbedtls_mpi_free>
2002a302:	f104 0008 	add.w	r0, r4, #8
2002a306:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
2002a30a:	f7fd bd12 	b.w	20027d32 <mbedtls_mpi_free>
	...

2002a310 <__aeabi_uldivmod>:
2002a310:	b953      	cbnz	r3, 2002a328 <__aeabi_uldivmod+0x18>
2002a312:	b94a      	cbnz	r2, 2002a328 <__aeabi_uldivmod+0x18>
2002a314:	2900      	cmp	r1, #0
2002a316:	bf08      	it	eq
2002a318:	2800      	cmpeq	r0, #0
2002a31a:	bf1c      	itt	ne
2002a31c:	f04f 31ff 	movne.w	r1, #4294967295
2002a320:	f04f 30ff 	movne.w	r0, #4294967295
2002a324:	f000 b9b2 	b.w	2002a68c <__aeabi_idiv0>
2002a328:	f1ad 0c08 	sub.w	ip, sp, #8
2002a32c:	e96d ce04 	strd	ip, lr, [sp, #-16]!
2002a330:	f000 f806 	bl	2002a340 <__udivmoddi4>
2002a334:	f8dd e004 	ldr.w	lr, [sp, #4]
2002a338:	e9dd 2302 	ldrd	r2, r3, [sp, #8]
2002a33c:	b004      	add	sp, #16
2002a33e:	4770      	bx	lr

2002a340 <__udivmoddi4>:
2002a340:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
2002a344:	468c      	mov	ip, r1
2002a346:	9e09      	ldr	r6, [sp, #36]	@ 0x24
2002a348:	4604      	mov	r4, r0
2002a34a:	460f      	mov	r7, r1
2002a34c:	2b00      	cmp	r3, #0
2002a34e:	d148      	bne.n	2002a3e2 <__udivmoddi4+0xa2>
2002a350:	428a      	cmp	r2, r1
2002a352:	4615      	mov	r5, r2
2002a354:	d95e      	bls.n	2002a414 <__udivmoddi4+0xd4>
2002a356:	fab2 f382 	clz	r3, r2
2002a35a:	b13b      	cbz	r3, 2002a36c <__udivmoddi4+0x2c>
2002a35c:	f1c3 0220 	rsb	r2, r3, #32
2002a360:	409f      	lsls	r7, r3
2002a362:	409d      	lsls	r5, r3
2002a364:	409c      	lsls	r4, r3
2002a366:	fa20 f202 	lsr.w	r2, r0, r2
2002a36a:	4317      	orrs	r7, r2
2002a36c:	ea4f 4e15 	mov.w	lr, r5, lsr #16
2002a370:	fa1f fc85 	uxth.w	ip, r5
2002a374:	0c22      	lsrs	r2, r4, #16
2002a376:	fbb7 f1fe 	udiv	r1, r7, lr
2002a37a:	fb0e 7711 	mls	r7, lr, r1, r7
2002a37e:	fb01 f00c 	mul.w	r0, r1, ip
2002a382:	ea42 4207 	orr.w	r2, r2, r7, lsl #16
2002a386:	4290      	cmp	r0, r2
2002a388:	d907      	bls.n	2002a39a <__udivmoddi4+0x5a>
2002a38a:	18aa      	adds	r2, r5, r2
2002a38c:	f101 37ff 	add.w	r7, r1, #4294967295
2002a390:	d202      	bcs.n	2002a398 <__udivmoddi4+0x58>
2002a392:	4290      	cmp	r0, r2
2002a394:	f200 8158 	bhi.w	2002a648 <__udivmoddi4+0x308>
2002a398:	4639      	mov	r1, r7
2002a39a:	1a12      	subs	r2, r2, r0
2002a39c:	b2a4      	uxth	r4, r4
2002a39e:	fbb2 f0fe 	udiv	r0, r2, lr
2002a3a2:	fb0e 2210 	mls	r2, lr, r0, r2
2002a3a6:	fb00 fc0c 	mul.w	ip, r0, ip
2002a3aa:	ea44 4402 	orr.w	r4, r4, r2, lsl #16
2002a3ae:	45a4      	cmp	ip, r4
2002a3b0:	d90b      	bls.n	2002a3ca <__udivmoddi4+0x8a>
2002a3b2:	192c      	adds	r4, r5, r4
2002a3b4:	f100 32ff 	add.w	r2, r0, #4294967295
2002a3b8:	bf2c      	ite	cs
2002a3ba:	2701      	movcs	r7, #1
2002a3bc:	2700      	movcc	r7, #0
2002a3be:	45a4      	cmp	ip, r4
2002a3c0:	d902      	bls.n	2002a3c8 <__udivmoddi4+0x88>
2002a3c2:	2f00      	cmp	r7, #0
2002a3c4:	f000 8143 	beq.w	2002a64e <__udivmoddi4+0x30e>
2002a3c8:	4610      	mov	r0, r2
2002a3ca:	ea40 4001 	orr.w	r0, r0, r1, lsl #16
2002a3ce:	eba4 040c 	sub.w	r4, r4, ip
2002a3d2:	2100      	movs	r1, #0
2002a3d4:	b11e      	cbz	r6, 2002a3de <__udivmoddi4+0x9e>
2002a3d6:	40dc      	lsrs	r4, r3
2002a3d8:	2300      	movs	r3, #0
2002a3da:	e9c6 4300 	strd	r4, r3, [r6]
2002a3de:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
2002a3e2:	428b      	cmp	r3, r1
2002a3e4:	d906      	bls.n	2002a3f4 <__udivmoddi4+0xb4>
2002a3e6:	b10e      	cbz	r6, 2002a3ec <__udivmoddi4+0xac>
2002a3e8:	e9c6 0100 	strd	r0, r1, [r6]
2002a3ec:	2100      	movs	r1, #0
2002a3ee:	4608      	mov	r0, r1
2002a3f0:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
2002a3f4:	fab3 f183 	clz	r1, r3
2002a3f8:	2900      	cmp	r1, #0
2002a3fa:	d151      	bne.n	2002a4a0 <__udivmoddi4+0x160>
2002a3fc:	4563      	cmp	r3, ip
2002a3fe:	f0c0 8116 	bcc.w	2002a62e <__udivmoddi4+0x2ee>
2002a402:	4282      	cmp	r2, r0
2002a404:	f240 8113 	bls.w	2002a62e <__udivmoddi4+0x2ee>
2002a408:	4608      	mov	r0, r1
2002a40a:	2e00      	cmp	r6, #0
2002a40c:	d0e7      	beq.n	2002a3de <__udivmoddi4+0x9e>
2002a40e:	e9c6 4700 	strd	r4, r7, [r6]
2002a412:	e7e4      	b.n	2002a3de <__udivmoddi4+0x9e>
2002a414:	2a00      	cmp	r2, #0
2002a416:	f000 80af 	beq.w	2002a578 <__udivmoddi4+0x238>
2002a41a:	fab2 f382 	clz	r3, r2
2002a41e:	2b00      	cmp	r3, #0
2002a420:	f040 80c2 	bne.w	2002a5a8 <__udivmoddi4+0x268>
2002a424:	1a8a      	subs	r2, r1, r2
2002a426:	ea4f 4e15 	mov.w	lr, r5, lsr #16
2002a42a:	b2af      	uxth	r7, r5
2002a42c:	2101      	movs	r1, #1
2002a42e:	0c20      	lsrs	r0, r4, #16
2002a430:	fbb2 fcfe 	udiv	ip, r2, lr
2002a434:	fb0e 221c 	mls	r2, lr, ip, r2
2002a438:	ea40 4202 	orr.w	r2, r0, r2, lsl #16
2002a43c:	fb07 f00c 	mul.w	r0, r7, ip
2002a440:	4290      	cmp	r0, r2
2002a442:	d90e      	bls.n	2002a462 <__udivmoddi4+0x122>
2002a444:	18aa      	adds	r2, r5, r2
2002a446:	f10c 38ff 	add.w	r8, ip, #4294967295
2002a44a:	bf2c      	ite	cs
2002a44c:	f04f 0901 	movcs.w	r9, #1
2002a450:	f04f 0900 	movcc.w	r9, #0
2002a454:	4290      	cmp	r0, r2
2002a456:	d903      	bls.n	2002a460 <__udivmoddi4+0x120>
2002a458:	f1b9 0f00 	cmp.w	r9, #0
2002a45c:	f000 80f0 	beq.w	2002a640 <__udivmoddi4+0x300>
2002a460:	46c4      	mov	ip, r8
2002a462:	1a12      	subs	r2, r2, r0
2002a464:	b2a4      	uxth	r4, r4
2002a466:	fbb2 f0fe 	udiv	r0, r2, lr
2002a46a:	fb0e 2210 	mls	r2, lr, r0, r2
2002a46e:	fb00 f707 	mul.w	r7, r0, r7
2002a472:	ea44 4402 	orr.w	r4, r4, r2, lsl #16
2002a476:	42a7      	cmp	r7, r4
2002a478:	d90e      	bls.n	2002a498 <__udivmoddi4+0x158>
2002a47a:	192c      	adds	r4, r5, r4
2002a47c:	f100 32ff 	add.w	r2, r0, #4294967295
2002a480:	bf2c      	ite	cs
2002a482:	f04f 0e01 	movcs.w	lr, #1
2002a486:	f04f 0e00 	movcc.w	lr, #0
2002a48a:	42a7      	cmp	r7, r4
2002a48c:	d903      	bls.n	2002a496 <__udivmoddi4+0x156>
2002a48e:	f1be 0f00 	cmp.w	lr, #0
2002a492:	f000 80d2 	beq.w	2002a63a <__udivmoddi4+0x2fa>
2002a496:	4610      	mov	r0, r2
2002a498:	1be4      	subs	r4, r4, r7
2002a49a:	ea40 400c 	orr.w	r0, r0, ip, lsl #16
2002a49e:	e799      	b.n	2002a3d4 <__udivmoddi4+0x94>
2002a4a0:	f1c1 0520 	rsb	r5, r1, #32
2002a4a4:	408b      	lsls	r3, r1
2002a4a6:	fa0c f401 	lsl.w	r4, ip, r1
2002a4aa:	fa00 f901 	lsl.w	r9, r0, r1
2002a4ae:	fa22 f705 	lsr.w	r7, r2, r5
2002a4b2:	fa2c fc05 	lsr.w	ip, ip, r5
2002a4b6:	408a      	lsls	r2, r1
2002a4b8:	431f      	orrs	r7, r3
2002a4ba:	fa20 f305 	lsr.w	r3, r0, r5
2002a4be:	0c38      	lsrs	r0, r7, #16
2002a4c0:	4323      	orrs	r3, r4
2002a4c2:	fa1f fe87 	uxth.w	lr, r7
2002a4c6:	0c1c      	lsrs	r4, r3, #16
2002a4c8:	fbbc f8f0 	udiv	r8, ip, r0
2002a4cc:	fb00 cc18 	mls	ip, r0, r8, ip
2002a4d0:	ea44 440c 	orr.w	r4, r4, ip, lsl #16
2002a4d4:	fb08 fc0e 	mul.w	ip, r8, lr
2002a4d8:	45a4      	cmp	ip, r4
2002a4da:	d90e      	bls.n	2002a4fa <__udivmoddi4+0x1ba>
2002a4dc:	193c      	adds	r4, r7, r4
2002a4de:	f108 3aff 	add.w	sl, r8, #4294967295
2002a4e2:	bf2c      	ite	cs
2002a4e4:	f04f 0b01 	movcs.w	fp, #1
2002a4e8:	f04f 0b00 	movcc.w	fp, #0
2002a4ec:	45a4      	cmp	ip, r4
2002a4ee:	d903      	bls.n	2002a4f8 <__udivmoddi4+0x1b8>
2002a4f0:	f1bb 0f00 	cmp.w	fp, #0
2002a4f4:	f000 80b8 	beq.w	2002a668 <__udivmoddi4+0x328>
2002a4f8:	46d0      	mov	r8, sl
2002a4fa:	eba4 040c 	sub.w	r4, r4, ip
2002a4fe:	fa1f fc83 	uxth.w	ip, r3
2002a502:	fbb4 f3f0 	udiv	r3, r4, r0
2002a506:	fb00 4413 	mls	r4, r0, r3, r4
2002a50a:	fb03 fe0e 	mul.w	lr, r3, lr
2002a50e:	ea4c 4404 	orr.w	r4, ip, r4, lsl #16
2002a512:	45a6      	cmp	lr, r4
2002a514:	d90e      	bls.n	2002a534 <__udivmoddi4+0x1f4>
2002a516:	193c      	adds	r4, r7, r4
2002a518:	f103 30ff 	add.w	r0, r3, #4294967295
2002a51c:	bf2c      	ite	cs
2002a51e:	f04f 0c01 	movcs.w	ip, #1
2002a522:	f04f 0c00 	movcc.w	ip, #0
2002a526:	45a6      	cmp	lr, r4
2002a528:	d903      	bls.n	2002a532 <__udivmoddi4+0x1f2>
2002a52a:	f1bc 0f00 	cmp.w	ip, #0
2002a52e:	f000 809f 	beq.w	2002a670 <__udivmoddi4+0x330>
2002a532:	4603      	mov	r3, r0
2002a534:	ea43 4008 	orr.w	r0, r3, r8, lsl #16
2002a538:	eba4 040e 	sub.w	r4, r4, lr
2002a53c:	fba0 ec02 	umull	lr, ip, r0, r2
2002a540:	4564      	cmp	r4, ip
2002a542:	4673      	mov	r3, lr
2002a544:	46e0      	mov	r8, ip
2002a546:	d302      	bcc.n	2002a54e <__udivmoddi4+0x20e>
2002a548:	d107      	bne.n	2002a55a <__udivmoddi4+0x21a>
2002a54a:	45f1      	cmp	r9, lr
2002a54c:	d205      	bcs.n	2002a55a <__udivmoddi4+0x21a>
2002a54e:	ebbe 0302 	subs.w	r3, lr, r2
2002a552:	eb6c 0c07 	sbc.w	ip, ip, r7
2002a556:	3801      	subs	r0, #1
2002a558:	46e0      	mov	r8, ip
2002a55a:	b15e      	cbz	r6, 2002a574 <__udivmoddi4+0x234>
2002a55c:	ebb9 0203 	subs.w	r2, r9, r3
2002a560:	eb64 0408 	sbc.w	r4, r4, r8
2002a564:	fa04 f505 	lsl.w	r5, r4, r5
2002a568:	fa22 f301 	lsr.w	r3, r2, r1
2002a56c:	40cc      	lsrs	r4, r1
2002a56e:	431d      	orrs	r5, r3
2002a570:	e9c6 5400 	strd	r5, r4, [r6]
2002a574:	2100      	movs	r1, #0
2002a576:	e732      	b.n	2002a3de <__udivmoddi4+0x9e>
2002a578:	0842      	lsrs	r2, r0, #1
2002a57a:	462f      	mov	r7, r5
2002a57c:	084b      	lsrs	r3, r1, #1
2002a57e:	46ac      	mov	ip, r5
2002a580:	ea42 72c1 	orr.w	r2, r2, r1, lsl #31
2002a584:	46ae      	mov	lr, r5
2002a586:	07c4      	lsls	r4, r0, #31
2002a588:	0c11      	lsrs	r1, r2, #16
2002a58a:	b292      	uxth	r2, r2
2002a58c:	ea41 4103 	orr.w	r1, r1, r3, lsl #16
2002a590:	ea42 4201 	orr.w	r2, r2, r1, lsl #16
2002a594:	fbb1 f1f5 	udiv	r1, r1, r5
2002a598:	fbb3 f0f5 	udiv	r0, r3, r5
2002a59c:	231f      	movs	r3, #31
2002a59e:	eba2 020c 	sub.w	r2, r2, ip
2002a5a2:	ea41 4100 	orr.w	r1, r1, r0, lsl #16
2002a5a6:	e742      	b.n	2002a42e <__udivmoddi4+0xee>
2002a5a8:	409d      	lsls	r5, r3
2002a5aa:	f1c3 0220 	rsb	r2, r3, #32
2002a5ae:	4099      	lsls	r1, r3
2002a5b0:	409c      	lsls	r4, r3
2002a5b2:	fa2c fc02 	lsr.w	ip, ip, r2
2002a5b6:	ea4f 4e15 	mov.w	lr, r5, lsr #16
2002a5ba:	fa20 f202 	lsr.w	r2, r0, r2
2002a5be:	b2af      	uxth	r7, r5
2002a5c0:	fbbc f8fe 	udiv	r8, ip, lr
2002a5c4:	430a      	orrs	r2, r1
2002a5c6:	fb0e cc18 	mls	ip, lr, r8, ip
2002a5ca:	0c11      	lsrs	r1, r2, #16
2002a5cc:	ea41 410c 	orr.w	r1, r1, ip, lsl #16
2002a5d0:	fb08 fc07 	mul.w	ip, r8, r7
2002a5d4:	458c      	cmp	ip, r1
2002a5d6:	d950      	bls.n	2002a67a <__udivmoddi4+0x33a>
2002a5d8:	1869      	adds	r1, r5, r1
2002a5da:	f108 30ff 	add.w	r0, r8, #4294967295
2002a5de:	bf2c      	ite	cs
2002a5e0:	f04f 0901 	movcs.w	r9, #1
2002a5e4:	f04f 0900 	movcc.w	r9, #0
2002a5e8:	458c      	cmp	ip, r1
2002a5ea:	d902      	bls.n	2002a5f2 <__udivmoddi4+0x2b2>
2002a5ec:	f1b9 0f00 	cmp.w	r9, #0
2002a5f0:	d030      	beq.n	2002a654 <__udivmoddi4+0x314>
2002a5f2:	eba1 010c 	sub.w	r1, r1, ip
2002a5f6:	fbb1 f8fe 	udiv	r8, r1, lr
2002a5fa:	fb08 fc07 	mul.w	ip, r8, r7
2002a5fe:	fb0e 1118 	mls	r1, lr, r8, r1
2002a602:	b292      	uxth	r2, r2
2002a604:	ea42 4201 	orr.w	r2, r2, r1, lsl #16
2002a608:	4562      	cmp	r2, ip
2002a60a:	d234      	bcs.n	2002a676 <__udivmoddi4+0x336>
2002a60c:	18aa      	adds	r2, r5, r2
2002a60e:	f108 31ff 	add.w	r1, r8, #4294967295
2002a612:	bf2c      	ite	cs
2002a614:	f04f 0901 	movcs.w	r9, #1
2002a618:	f04f 0900 	movcc.w	r9, #0
2002a61c:	4562      	cmp	r2, ip
2002a61e:	d2be      	bcs.n	2002a59e <__udivmoddi4+0x25e>
2002a620:	f1b9 0f00 	cmp.w	r9, #0
2002a624:	d1bb      	bne.n	2002a59e <__udivmoddi4+0x25e>
2002a626:	f1a8 0102 	sub.w	r1, r8, #2
2002a62a:	442a      	add	r2, r5
2002a62c:	e7b7      	b.n	2002a59e <__udivmoddi4+0x25e>
2002a62e:	1a84      	subs	r4, r0, r2
2002a630:	eb6c 0203 	sbc.w	r2, ip, r3
2002a634:	2001      	movs	r0, #1
2002a636:	4617      	mov	r7, r2
2002a638:	e6e7      	b.n	2002a40a <__udivmoddi4+0xca>
2002a63a:	442c      	add	r4, r5
2002a63c:	3802      	subs	r0, #2
2002a63e:	e72b      	b.n	2002a498 <__udivmoddi4+0x158>
2002a640:	f1ac 0c02 	sub.w	ip, ip, #2
2002a644:	442a      	add	r2, r5
2002a646:	e70c      	b.n	2002a462 <__udivmoddi4+0x122>
2002a648:	3902      	subs	r1, #2
2002a64a:	442a      	add	r2, r5
2002a64c:	e6a5      	b.n	2002a39a <__udivmoddi4+0x5a>
2002a64e:	442c      	add	r4, r5
2002a650:	3802      	subs	r0, #2
2002a652:	e6ba      	b.n	2002a3ca <__udivmoddi4+0x8a>
2002a654:	eba5 0c0c 	sub.w	ip, r5, ip
2002a658:	f1a8 0002 	sub.w	r0, r8, #2
2002a65c:	4461      	add	r1, ip
2002a65e:	fbb1 f8fe 	udiv	r8, r1, lr
2002a662:	fb08 fc07 	mul.w	ip, r8, r7
2002a666:	e7ca      	b.n	2002a5fe <__udivmoddi4+0x2be>
2002a668:	f1a8 0802 	sub.w	r8, r8, #2
2002a66c:	443c      	add	r4, r7
2002a66e:	e744      	b.n	2002a4fa <__udivmoddi4+0x1ba>
2002a670:	3b02      	subs	r3, #2
2002a672:	443c      	add	r4, r7
2002a674:	e75e      	b.n	2002a534 <__udivmoddi4+0x1f4>
2002a676:	4641      	mov	r1, r8
2002a678:	e791      	b.n	2002a59e <__udivmoddi4+0x25e>
2002a67a:	eba1 010c 	sub.w	r1, r1, ip
2002a67e:	4640      	mov	r0, r8
2002a680:	fbb1 f8fe 	udiv	r8, r1, lr
2002a684:	fb08 fc07 	mul.w	ip, r8, r7
2002a688:	e7b9      	b.n	2002a5fe <__udivmoddi4+0x2be>
2002a68a:	bf00      	nop

2002a68c <__aeabi_idiv0>:
2002a68c:	4770      	bx	lr
2002a68e:	bf00      	nop

2002a690 <calloc>:
2002a690:	4b02      	ldr	r3, [pc, #8]	@ (2002a69c <calloc+0xc>)
2002a692:	460a      	mov	r2, r1
2002a694:	4601      	mov	r1, r0
2002a696:	6818      	ldr	r0, [r3, #0]
2002a698:	f000 b802 	b.w	2002a6a0 <_calloc_r>
2002a69c:	20044908 	.word	0x20044908

2002a6a0 <_calloc_r>:
2002a6a0:	b570      	push	{r4, r5, r6, lr}
2002a6a2:	fba1 5402 	umull	r5, r4, r1, r2
2002a6a6:	b934      	cbnz	r4, 2002a6b6 <_calloc_r+0x16>
2002a6a8:	4629      	mov	r1, r5
2002a6aa:	f000 f837 	bl	2002a71c <_malloc_r>
2002a6ae:	4606      	mov	r6, r0
2002a6b0:	b928      	cbnz	r0, 2002a6be <_calloc_r+0x1e>
2002a6b2:	4630      	mov	r0, r6
2002a6b4:	bd70      	pop	{r4, r5, r6, pc}
2002a6b6:	220c      	movs	r2, #12
2002a6b8:	2600      	movs	r6, #0
2002a6ba:	6002      	str	r2, [r0, #0]
2002a6bc:	e7f9      	b.n	2002a6b2 <_calloc_r+0x12>
2002a6be:	462a      	mov	r2, r5
2002a6c0:	4621      	mov	r1, r4
2002a6c2:	f000 f8c7 	bl	2002a854 <memset>
2002a6c6:	e7f4      	b.n	2002a6b2 <_calloc_r+0x12>

2002a6c8 <free>:
2002a6c8:	4b02      	ldr	r3, [pc, #8]	@ (2002a6d4 <free+0xc>)
2002a6ca:	4601      	mov	r1, r0
2002a6cc:	6818      	ldr	r0, [r3, #0]
2002a6ce:	f000 b8e9 	b.w	2002a8a4 <_free_r>
2002a6d2:	bf00      	nop
2002a6d4:	20044908 	.word	0x20044908

2002a6d8 <sbrk_aligned>:
2002a6d8:	b570      	push	{r4, r5, r6, lr}
2002a6da:	4e0f      	ldr	r6, [pc, #60]	@ (2002a718 <sbrk_aligned+0x40>)
2002a6dc:	460c      	mov	r4, r1
2002a6de:	4605      	mov	r5, r0
2002a6e0:	6831      	ldr	r1, [r6, #0]
2002a6e2:	b911      	cbnz	r1, 2002a6ea <sbrk_aligned+0x12>
2002a6e4:	f000 f8be 	bl	2002a864 <_sbrk_r>
2002a6e8:	6030      	str	r0, [r6, #0]
2002a6ea:	4621      	mov	r1, r4
2002a6ec:	4628      	mov	r0, r5
2002a6ee:	f000 f8b9 	bl	2002a864 <_sbrk_r>
2002a6f2:	1c43      	adds	r3, r0, #1
2002a6f4:	d103      	bne.n	2002a6fe <sbrk_aligned+0x26>
2002a6f6:	f04f 34ff 	mov.w	r4, #4294967295
2002a6fa:	4620      	mov	r0, r4
2002a6fc:	bd70      	pop	{r4, r5, r6, pc}
2002a6fe:	1cc4      	adds	r4, r0, #3
2002a700:	f024 0403 	bic.w	r4, r4, #3
2002a704:	42a0      	cmp	r0, r4
2002a706:	d0f8      	beq.n	2002a6fa <sbrk_aligned+0x22>
2002a708:	1a21      	subs	r1, r4, r0
2002a70a:	4628      	mov	r0, r5
2002a70c:	f000 f8aa 	bl	2002a864 <_sbrk_r>
2002a710:	3001      	adds	r0, #1
2002a712:	d1f2      	bne.n	2002a6fa <sbrk_aligned+0x22>
2002a714:	e7ef      	b.n	2002a6f6 <sbrk_aligned+0x1e>
2002a716:	bf00      	nop
2002a718:	2004a3b4 	.word	0x2004a3b4

2002a71c <_malloc_r>:
2002a71c:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
2002a720:	1ccd      	adds	r5, r1, #3
2002a722:	4606      	mov	r6, r0
2002a724:	f025 0503 	bic.w	r5, r5, #3
2002a728:	3508      	adds	r5, #8
2002a72a:	2d0c      	cmp	r5, #12
2002a72c:	bf38      	it	cc
2002a72e:	250c      	movcc	r5, #12
2002a730:	2d00      	cmp	r5, #0
2002a732:	db01      	blt.n	2002a738 <_malloc_r+0x1c>
2002a734:	42a9      	cmp	r1, r5
2002a736:	d904      	bls.n	2002a742 <_malloc_r+0x26>
2002a738:	230c      	movs	r3, #12
2002a73a:	6033      	str	r3, [r6, #0]
2002a73c:	2000      	movs	r0, #0
2002a73e:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
2002a742:	f8df 80d4 	ldr.w	r8, [pc, #212]	@ 2002a818 <_malloc_r+0xfc>
2002a746:	f000 f869 	bl	2002a81c <__malloc_lock>
2002a74a:	f8d8 3000 	ldr.w	r3, [r8]
2002a74e:	461c      	mov	r4, r3
2002a750:	bb44      	cbnz	r4, 2002a7a4 <_malloc_r+0x88>
2002a752:	4629      	mov	r1, r5
2002a754:	4630      	mov	r0, r6
2002a756:	f7ff ffbf 	bl	2002a6d8 <sbrk_aligned>
2002a75a:	1c43      	adds	r3, r0, #1
2002a75c:	4604      	mov	r4, r0
2002a75e:	d158      	bne.n	2002a812 <_malloc_r+0xf6>
2002a760:	f8d8 4000 	ldr.w	r4, [r8]
2002a764:	4627      	mov	r7, r4
2002a766:	2f00      	cmp	r7, #0
2002a768:	d143      	bne.n	2002a7f2 <_malloc_r+0xd6>
2002a76a:	2c00      	cmp	r4, #0
2002a76c:	d04b      	beq.n	2002a806 <_malloc_r+0xea>
2002a76e:	6823      	ldr	r3, [r4, #0]
2002a770:	4639      	mov	r1, r7
2002a772:	4630      	mov	r0, r6
2002a774:	eb04 0903 	add.w	r9, r4, r3
2002a778:	f000 f874 	bl	2002a864 <_sbrk_r>
2002a77c:	4581      	cmp	r9, r0
2002a77e:	d142      	bne.n	2002a806 <_malloc_r+0xea>
2002a780:	6821      	ldr	r1, [r4, #0]
2002a782:	4630      	mov	r0, r6
2002a784:	1a6d      	subs	r5, r5, r1
2002a786:	4629      	mov	r1, r5
2002a788:	f7ff ffa6 	bl	2002a6d8 <sbrk_aligned>
2002a78c:	3001      	adds	r0, #1
2002a78e:	d03a      	beq.n	2002a806 <_malloc_r+0xea>
2002a790:	6823      	ldr	r3, [r4, #0]
2002a792:	442b      	add	r3, r5
2002a794:	6023      	str	r3, [r4, #0]
2002a796:	f8d8 3000 	ldr.w	r3, [r8]
2002a79a:	685a      	ldr	r2, [r3, #4]
2002a79c:	bb62      	cbnz	r2, 2002a7f8 <_malloc_r+0xdc>
2002a79e:	f8c8 7000 	str.w	r7, [r8]
2002a7a2:	e00f      	b.n	2002a7c4 <_malloc_r+0xa8>
2002a7a4:	6822      	ldr	r2, [r4, #0]
2002a7a6:	1b52      	subs	r2, r2, r5
2002a7a8:	d420      	bmi.n	2002a7ec <_malloc_r+0xd0>
2002a7aa:	2a0b      	cmp	r2, #11
2002a7ac:	d917      	bls.n	2002a7de <_malloc_r+0xc2>
2002a7ae:	1961      	adds	r1, r4, r5
2002a7b0:	42a3      	cmp	r3, r4
2002a7b2:	6025      	str	r5, [r4, #0]
2002a7b4:	bf18      	it	ne
2002a7b6:	6059      	strne	r1, [r3, #4]
2002a7b8:	6863      	ldr	r3, [r4, #4]
2002a7ba:	bf08      	it	eq
2002a7bc:	f8c8 1000 	streq.w	r1, [r8]
2002a7c0:	5162      	str	r2, [r4, r5]
2002a7c2:	604b      	str	r3, [r1, #4]
2002a7c4:	4630      	mov	r0, r6
2002a7c6:	f000 f82f 	bl	2002a828 <__malloc_unlock>
2002a7ca:	f104 000b 	add.w	r0, r4, #11
2002a7ce:	1d23      	adds	r3, r4, #4
2002a7d0:	f020 0007 	bic.w	r0, r0, #7
2002a7d4:	1ac2      	subs	r2, r0, r3
2002a7d6:	bf1c      	itt	ne
2002a7d8:	1a1b      	subne	r3, r3, r0
2002a7da:	50a3      	strne	r3, [r4, r2]
2002a7dc:	e7af      	b.n	2002a73e <_malloc_r+0x22>
2002a7de:	6862      	ldr	r2, [r4, #4]
2002a7e0:	42a3      	cmp	r3, r4
2002a7e2:	bf0c      	ite	eq
2002a7e4:	f8c8 2000 	streq.w	r2, [r8]
2002a7e8:	605a      	strne	r2, [r3, #4]
2002a7ea:	e7eb      	b.n	2002a7c4 <_malloc_r+0xa8>
2002a7ec:	4623      	mov	r3, r4
2002a7ee:	6864      	ldr	r4, [r4, #4]
2002a7f0:	e7ae      	b.n	2002a750 <_malloc_r+0x34>
2002a7f2:	463c      	mov	r4, r7
2002a7f4:	687f      	ldr	r7, [r7, #4]
2002a7f6:	e7b6      	b.n	2002a766 <_malloc_r+0x4a>
2002a7f8:	461a      	mov	r2, r3
2002a7fa:	685b      	ldr	r3, [r3, #4]
2002a7fc:	42a3      	cmp	r3, r4
2002a7fe:	d1fb      	bne.n	2002a7f8 <_malloc_r+0xdc>
2002a800:	2300      	movs	r3, #0
2002a802:	6053      	str	r3, [r2, #4]
2002a804:	e7de      	b.n	2002a7c4 <_malloc_r+0xa8>
2002a806:	230c      	movs	r3, #12
2002a808:	4630      	mov	r0, r6
2002a80a:	6033      	str	r3, [r6, #0]
2002a80c:	f000 f80c 	bl	2002a828 <__malloc_unlock>
2002a810:	e794      	b.n	2002a73c <_malloc_r+0x20>
2002a812:	6005      	str	r5, [r0, #0]
2002a814:	e7d6      	b.n	2002a7c4 <_malloc_r+0xa8>
2002a816:	bf00      	nop
2002a818:	2004a3b8 	.word	0x2004a3b8

2002a81c <__malloc_lock>:
2002a81c:	4801      	ldr	r0, [pc, #4]	@ (2002a824 <__malloc_lock+0x8>)
2002a81e:	f000 b831 	b.w	2002a884 <__retarget_lock_acquire_recursive>
2002a822:	bf00      	nop
2002a824:	2004a4f8 	.word	0x2004a4f8

2002a828 <__malloc_unlock>:
2002a828:	4801      	ldr	r0, [pc, #4]	@ (2002a830 <__malloc_unlock+0x8>)
2002a82a:	f000 b82c 	b.w	2002a886 <__retarget_lock_release_recursive>
2002a82e:	bf00      	nop
2002a830:	2004a4f8 	.word	0x2004a4f8

2002a834 <memcmp>:
2002a834:	3901      	subs	r1, #1
2002a836:	4402      	add	r2, r0
2002a838:	b510      	push	{r4, lr}
2002a83a:	4290      	cmp	r0, r2
2002a83c:	d101      	bne.n	2002a842 <memcmp+0xe>
2002a83e:	2000      	movs	r0, #0
2002a840:	e005      	b.n	2002a84e <memcmp+0x1a>
2002a842:	7803      	ldrb	r3, [r0, #0]
2002a844:	f811 4f01 	ldrb.w	r4, [r1, #1]!
2002a848:	42a3      	cmp	r3, r4
2002a84a:	d001      	beq.n	2002a850 <memcmp+0x1c>
2002a84c:	1b18      	subs	r0, r3, r4
2002a84e:	bd10      	pop	{r4, pc}
2002a850:	3001      	adds	r0, #1
2002a852:	e7f2      	b.n	2002a83a <memcmp+0x6>

2002a854 <memset>:
2002a854:	4402      	add	r2, r0
2002a856:	4603      	mov	r3, r0
2002a858:	4293      	cmp	r3, r2
2002a85a:	d100      	bne.n	2002a85e <memset+0xa>
2002a85c:	4770      	bx	lr
2002a85e:	f803 1b01 	strb.w	r1, [r3], #1
2002a862:	e7f9      	b.n	2002a858 <memset+0x4>

2002a864 <_sbrk_r>:
2002a864:	b538      	push	{r3, r4, r5, lr}
2002a866:	2300      	movs	r3, #0
2002a868:	4d05      	ldr	r5, [pc, #20]	@ (2002a880 <_sbrk_r+0x1c>)
2002a86a:	4604      	mov	r4, r0
2002a86c:	4608      	mov	r0, r1
2002a86e:	602b      	str	r3, [r5, #0]
2002a870:	f000 f862 	bl	2002a938 <_sbrk>
2002a874:	1c43      	adds	r3, r0, #1
2002a876:	d102      	bne.n	2002a87e <_sbrk_r+0x1a>
2002a878:	682b      	ldr	r3, [r5, #0]
2002a87a:	b103      	cbz	r3, 2002a87e <_sbrk_r+0x1a>
2002a87c:	6023      	str	r3, [r4, #0]
2002a87e:	bd38      	pop	{r3, r4, r5, pc}
2002a880:	2004a4f4 	.word	0x2004a4f4

2002a884 <__retarget_lock_acquire_recursive>:
2002a884:	4770      	bx	lr

2002a886 <__retarget_lock_release_recursive>:
2002a886:	4770      	bx	lr

2002a888 <memcpy>:
2002a888:	440a      	add	r2, r1
2002a88a:	1e43      	subs	r3, r0, #1
2002a88c:	4291      	cmp	r1, r2
2002a88e:	d100      	bne.n	2002a892 <memcpy+0xa>
2002a890:	4770      	bx	lr
2002a892:	b510      	push	{r4, lr}
2002a894:	f811 4b01 	ldrb.w	r4, [r1], #1
2002a898:	4291      	cmp	r1, r2
2002a89a:	f803 4f01 	strb.w	r4, [r3, #1]!
2002a89e:	d1f9      	bne.n	2002a894 <memcpy+0xc>
2002a8a0:	bd10      	pop	{r4, pc}
	...

2002a8a4 <_free_r>:
2002a8a4:	b538      	push	{r3, r4, r5, lr}
2002a8a6:	4605      	mov	r5, r0
2002a8a8:	2900      	cmp	r1, #0
2002a8aa:	d041      	beq.n	2002a930 <_free_r+0x8c>
2002a8ac:	f851 3c04 	ldr.w	r3, [r1, #-4]
2002a8b0:	1f0c      	subs	r4, r1, #4
2002a8b2:	2b00      	cmp	r3, #0
2002a8b4:	bfb8      	it	lt
2002a8b6:	18e4      	addlt	r4, r4, r3
2002a8b8:	f7ff ffb0 	bl	2002a81c <__malloc_lock>
2002a8bc:	4a1d      	ldr	r2, [pc, #116]	@ (2002a934 <_free_r+0x90>)
2002a8be:	6813      	ldr	r3, [r2, #0]
2002a8c0:	b933      	cbnz	r3, 2002a8d0 <_free_r+0x2c>
2002a8c2:	6063      	str	r3, [r4, #4]
2002a8c4:	6014      	str	r4, [r2, #0]
2002a8c6:	4628      	mov	r0, r5
2002a8c8:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
2002a8cc:	f7ff bfac 	b.w	2002a828 <__malloc_unlock>
2002a8d0:	42a3      	cmp	r3, r4
2002a8d2:	d908      	bls.n	2002a8e6 <_free_r+0x42>
2002a8d4:	6820      	ldr	r0, [r4, #0]
2002a8d6:	1821      	adds	r1, r4, r0
2002a8d8:	428b      	cmp	r3, r1
2002a8da:	bf01      	itttt	eq
2002a8dc:	6819      	ldreq	r1, [r3, #0]
2002a8de:	685b      	ldreq	r3, [r3, #4]
2002a8e0:	1809      	addeq	r1, r1, r0
2002a8e2:	6021      	streq	r1, [r4, #0]
2002a8e4:	e7ed      	b.n	2002a8c2 <_free_r+0x1e>
2002a8e6:	461a      	mov	r2, r3
2002a8e8:	685b      	ldr	r3, [r3, #4]
2002a8ea:	b10b      	cbz	r3, 2002a8f0 <_free_r+0x4c>
2002a8ec:	42a3      	cmp	r3, r4
2002a8ee:	d9fa      	bls.n	2002a8e6 <_free_r+0x42>
2002a8f0:	6811      	ldr	r1, [r2, #0]
2002a8f2:	1850      	adds	r0, r2, r1
2002a8f4:	42a0      	cmp	r0, r4
2002a8f6:	d10b      	bne.n	2002a910 <_free_r+0x6c>
2002a8f8:	6820      	ldr	r0, [r4, #0]
2002a8fa:	4401      	add	r1, r0
2002a8fc:	1850      	adds	r0, r2, r1
2002a8fe:	6011      	str	r1, [r2, #0]
2002a900:	4283      	cmp	r3, r0
2002a902:	d1e0      	bne.n	2002a8c6 <_free_r+0x22>
2002a904:	6818      	ldr	r0, [r3, #0]
2002a906:	685b      	ldr	r3, [r3, #4]
2002a908:	4408      	add	r0, r1
2002a90a:	6053      	str	r3, [r2, #4]
2002a90c:	6010      	str	r0, [r2, #0]
2002a90e:	e7da      	b.n	2002a8c6 <_free_r+0x22>
2002a910:	d902      	bls.n	2002a918 <_free_r+0x74>
2002a912:	230c      	movs	r3, #12
2002a914:	602b      	str	r3, [r5, #0]
2002a916:	e7d6      	b.n	2002a8c6 <_free_r+0x22>
2002a918:	6820      	ldr	r0, [r4, #0]
2002a91a:	1821      	adds	r1, r4, r0
2002a91c:	428b      	cmp	r3, r1
2002a91e:	bf02      	ittt	eq
2002a920:	6819      	ldreq	r1, [r3, #0]
2002a922:	685b      	ldreq	r3, [r3, #4]
2002a924:	1809      	addeq	r1, r1, r0
2002a926:	6063      	str	r3, [r4, #4]
2002a928:	bf08      	it	eq
2002a92a:	6021      	streq	r1, [r4, #0]
2002a92c:	6054      	str	r4, [r2, #4]
2002a92e:	e7ca      	b.n	2002a8c6 <_free_r+0x22>
2002a930:	bd38      	pop	{r3, r4, r5, pc}
2002a932:	bf00      	nop
2002a934:	2004a3b8 	.word	0x2004a3b8

2002a938 <_sbrk>:
2002a938:	4a05      	ldr	r2, [pc, #20]	@ (2002a950 <_sbrk+0x18>)
2002a93a:	4603      	mov	r3, r0
2002a93c:	6810      	ldr	r0, [r2, #0]
2002a93e:	b110      	cbz	r0, 2002a946 <_sbrk+0xe>
2002a940:	4403      	add	r3, r0
2002a942:	6013      	str	r3, [r2, #0]
2002a944:	4770      	bx	lr
2002a946:	4803      	ldr	r0, [pc, #12]	@ (2002a954 <_sbrk+0x1c>)
2002a948:	4403      	add	r3, r0
2002a94a:	6013      	str	r3, [r2, #0]
2002a94c:	4770      	bx	lr
2002a94e:	bf00      	nop
2002a950:	2004a4fc 	.word	0x2004a4fc
2002a954:	20042000 	.word	0x20042000
2002a958:	50041000 	.word	0x50041000
2002a95c:	00000002 	.word	0x00000002
2002a960:	10000000 	.word	0x10000000
2002a964:	00000004 	.word	0x00000004
2002a968:	00000000 	.word	0x00000000
2002a96c:	50081008 	.word	0x50081008
2002a970:	00000000 	.word	0x00000000
2002a974:	00000032 	.word	0x00000032
2002a978:	00000000 	.word	0x00000000
2002a97c:	50042000 	.word	0x50042000
2002a980:	00000002 	.word	0x00000002
2002a984:	12000000 	.word	0x12000000
2002a988:	00000004 	.word	0x00000004
2002a98c:	00000000 	.word	0x00000000
2002a990:	5008101c 	.word	0x5008101c
2002a994:	00000000 	.word	0x00000000
2002a998:	00000033 	.word	0x00000033
2002a99c:	00000001 	.word	0x00000001
2002a9a0:	62636573 	.word	0x62636573
2002a9a4:	20746f6f 	.word	0x20746f6f
2002a9a8:	6b676973 	.word	0x6b676973
2002a9ac:	70207965 	.word	0x70207965
2002a9b0:	65206275 	.word	0x65206275
2002a9b4:	00217272 	.word	0x00217272
2002a9b8:	62636573 	.word	0x62636573
2002a9bc:	20746f6f 	.word	0x20746f6f
2002a9c0:	20676d69 	.word	0x20676d69
2002a9c4:	68736168 	.word	0x68736168
2002a9c8:	67697320 	.word	0x67697320
2002a9cc:	72726520 	.word	0x72726520
2002a9d0:	65730021 	.word	0x65730021
2002a9d4:	6f6f6263 	.word	0x6f6f6263
2002a9d8:	78652074 	.word	0x78652074
2002a9dc:	20747063 	.word	0x20747063
2002a9e0:	6c6c756e 	.word	0x6c6c756e
2002a9e4:	41480021 	.word	0x41480021
2002a9e8:	535f4853 	.word	0x535f4853
2002a9ec:	49545445 	.word	0x49545445
2002a9f0:	253d474e 	.word	0x253d474e
2002a9f4:	0a583830 	.word	0x0a583830
2002a9f8:	616f4c00 	.word	0x616f4c00
2002a9fc:	56492064 	.word	0x56492064
2002aa00:	646e6120 	.word	0x646e6120
2002aa04:	6e656c20 	.word	0x6e656c20
2002aa08:	20687467 	.word	0x20687467
2002aa0c:	48534148 	.word	0x48534148
2002aa10:	5445535f 	.word	0x5445535f
2002aa14:	474e4954 	.word	0x474e4954
2002aa18:	3830253d 	.word	0x3830253d
2002aa1c:	69202c58 	.word	0x69202c58
2002aa20:	656c2076 	.word	0x656c2076
2002aa24:	6874676e 	.word	0x6874676e
2002aa28:	0a64253d 	.word	0x0a64253d
2002aa2c:	73655200 	.word	0x73655200
2002aa30:	20746c75 	.word	0x20746c75
2002aa34:	3d6e656c 	.word	0x3d6e656c
2002aa38:	000a6425 	.word	0x000a6425
2002aa3c:	2070614d 	.word	0x2070614d
2002aa40:	6f727265 	.word	0x6f727265
2002aa44:	6c203a72 	.word	0x6c203a72
2002aa48:	6369676f 	.word	0x6369676f
2002aa4c:	2c642520 	.word	0x2c642520
2002aa50:	79687020 	.word	0x79687020
2002aa54:	0a642520 	.word	0x0a642520
2002aa58:	52524500 	.word	0x52524500
2002aa5c:	2032203a 	.word	0x2032203a
2002aa60:	69676f6c 	.word	0x69676f6c
2002aa64:	6c622063 	.word	0x6c622063
2002aa68:	736b636f 	.word	0x736b636f
2002aa6c:	70616d20 	.word	0x70616d20
2002aa70:	206f7420 	.word	0x206f7420
2002aa74:	656d6173 	.word	0x656d6173
2002aa78:	6b6c6220 	.word	0x6b6c6220
2002aa7c:	6f6c203a 	.word	0x6f6c203a
2002aa80:	30636967 	.word	0x30636967
2002aa84:	2c642520 	.word	0x2c642520
2002aa88:	79687020 	.word	0x79687020
2002aa8c:	64252030 	.word	0x64252030
2002aa90:	6f6c202c 	.word	0x6f6c202c
2002aa94:	31636967 	.word	0x31636967
2002aa98:	2c642520 	.word	0x2c642520
2002aa9c:	79687020 	.word	0x79687020
2002aaa0:	64252031 	.word	0x64252031
2002aaa4:	614d000a 	.word	0x614d000a
2002aaa8:	72652070 	.word	0x72652070
2002aaac:	30726f72 	.word	0x30726f72
2002aab0:	6f6c203a 	.word	0x6f6c203a
2002aab4:	20636967 	.word	0x20636967
2002aab8:	202c6425 	.word	0x202c6425
2002aabc:	20796870 	.word	0x20796870
2002aac0:	000a6425 	.word	0x000a6425
2002aac4:	20746547 	.word	0x20746547
2002aac8:	2070616d 	.word	0x2070616d
2002aacc:	636f6c62 	.word	0x636f6c62
2002aad0:	7265206b 	.word	0x7265206b
2002aad4:	20726f72 	.word	0x20726f72
2002aad8:	2d206425 	.word	0x2d206425
2002aadc:	25203e2d 	.word	0x25203e2d
2002aae0:	42000a64 	.word	0x42000a64
2002aae4:	76204d42 	.word	0x76204d42
2002aae8:	69737265 	.word	0x69737265
2002aaec:	6e206e6f 	.word	0x6e206e6f
2002aaf0:	6920746f 	.word	0x6920746f
2002aaf4:	6572636e 	.word	0x6572636e
2002aaf8:	64657361 	.word	0x64657361
2002aafc:	7270203a 	.word	0x7270203a
2002ab00:	25207665 	.word	0x25207665
2002ab04:	63202c64 	.word	0x63202c64
2002ab08:	20727275 	.word	0x20727275
2002ab0c:	000a6425 	.word	0x000a6425
2002ab10:	41544144 	.word	0x41544144
2002ab14:	746f6e20 	.word	0x746f6e20
2002ab18:	61657220 	.word	0x61657220
2002ab1c:	616e6f73 	.word	0x616e6f73
2002ab20:	20656c62 	.word	0x20656c62
2002ab24:	42206e69 	.word	0x42206e69
2002ab28:	62204d42 	.word	0x62204d42
2002ab2c:	25206b6c 	.word	0x25206b6c
2002ab30:	61702064 	.word	0x61702064
2002ab34:	25206567 	.word	0x25206567
2002ab38:	30203a64 	.word	0x30203a64
2002ab3c:	0a782578 	.word	0x0a782578
2002ab40:	61655200 	.word	0x61655200
2002ab44:	62622064 	.word	0x62622064
2002ab48:	6c62206d 	.word	0x6c62206d
2002ab4c:	6425206b 	.word	0x6425206b
2002ab50:	67617020 	.word	0x67617020
2002ab54:	64252065 	.word	0x64252065
2002ab58:	69616620 	.word	0x69616620
2002ab5c:	49000a6c 	.word	0x49000a6c
2002ab60:	6c61766e 	.word	0x6c61766e
2002ab64:	42206469 	.word	0x42206469
2002ab68:	49204d42 	.word	0x49204d42
2002ab6c:	25205844 	.word	0x25205844
2002ab70:	56000a64 	.word	0x56000a64
2002ab74:	64252031 	.word	0x64252031
2002ab78:	206e6920 	.word	0x206e6920
2002ab7c:	636f6c62 	.word	0x636f6c62
2002ab80:	6425206b 	.word	0x6425206b
2002ab84:	3256202c 	.word	0x3256202c
2002ab88:	20642520 	.word	0x20642520
2002ab8c:	62206e69 	.word	0x62206e69
2002ab90:	6b636f6c 	.word	0x6b636f6c
2002ab94:	0a642520 	.word	0x0a642520
2002ab98:	6d615300 	.word	0x6d615300
2002ab9c:	69687465 	.word	0x69687465
2002aba0:	6d20676e 	.word	0x6d20676e
2002aba4:	20747375 	.word	0x20747375
2002aba8:	77206562 	.word	0x77206562
2002abac:	676e6f72 	.word	0x676e6f72
2002abb0:	6567202c 	.word	0x6567202c
2002abb4:	656e2074 	.word	0x656e2074
2002abb8:	65762077 	.word	0x65762077
2002abbc:	6f697372 	.word	0x6f697372
2002abc0:	6425206e 	.word	0x6425206e
2002abc4:	206f6420 	.word	0x206f6420
2002abc8:	20746f6e 	.word	0x20746f6e
2002abcc:	656d6173 	.word	0x656d6173
2002abd0:	206f7420 	.word	0x206f7420
2002abd4:	76657270 	.word	0x76657270
2002abd8:	65686320 	.word	0x65686320
2002abdc:	25206b63 	.word	0x25206b63
2002abe0:	43000a64 	.word	0x43000a64
2002abe4:	63204352 	.word	0x63204352
2002abe8:	6b636568 	.word	0x6b636568
2002abec:	72726520 	.word	0x72726520
2002abf0:	0a20726f 	.word	0x0a20726f
2002abf4:	61655200 	.word	0x61655200
2002abf8:	62622064 	.word	0x62622064
2002abfc:	6c62206d 	.word	0x6c62206d
2002ac00:	6425206b 	.word	0x6425206b
2002ac04:	67617020 	.word	0x67617020
2002ac08:	64252065 	.word	0x64252065
2002ac0c:	74616420 	.word	0x74616420
2002ac10:	6f6e2061 	.word	0x6f6e2061
2002ac14:	72772074 	.word	0x72772074
2002ac18:	20657469 	.word	0x20657469
2002ac1c:	20726f66 	.word	0x20726f66
2002ac20:	20646e32 	.word	0x20646e32
2002ac24:	656d6974 	.word	0x656d6974
2002ac28:	6552000a 	.word	0x6552000a
2002ac2c:	62206461 	.word	0x62206461
2002ac30:	62206d62 	.word	0x62206d62
2002ac34:	25206b6c 	.word	0x25206b6c
2002ac38:	61702064 	.word	0x61702064
2002ac3c:	25206567 	.word	0x25206567
2002ac40:	61662064 	.word	0x61662064
2002ac44:	66206c69 	.word	0x66206c69
2002ac48:	3220726f 	.word	0x3220726f
2002ac4c:	7420646e 	.word	0x7420646e
2002ac50:	3f656d69 	.word	0x3f656d69
2002ac54:	614c000a 	.word	0x614c000a
2002ac58:	74736574 	.word	0x74736574
2002ac5c:	72657620 	.word	0x72657620
2002ac60:	6e6f6973 	.word	0x6e6f6973
2002ac64:	0a642520 	.word	0x0a642520
2002ac68:	74654700 	.word	0x74654700
2002ac6c:	79687020 	.word	0x79687020
2002ac70:	6b6c6220 	.word	0x6b6c6220
2002ac74:	726f6620 	.word	0x726f6620
2002ac78:	20642520 	.word	0x20642520
2002ac7c:	6c696166 	.word	0x6c696166
2002ac80:	65687720 	.word	0x65687720
2002ac84:	6572206e 	.word	0x6572206e
2002ac88:	000a6461 	.word	0x000a6461
2002ac8c:	636f6c42 	.word	0x636f6c42
2002ac90:	6425206b 	.word	0x6425206b
2002ac94:	61726520 	.word	0x61726520
2002ac98:	66206573 	.word	0x66206573
2002ac9c:	2c6c6961 	.word	0x2c6c6961
2002aca0:	72616d20 	.word	0x72616d20
2002aca4:	7361206b 	.word	0x7361206b
2002aca8:	64616220 	.word	0x64616220
2002acac:	6c42000a 	.word	0x6c42000a
2002acb0:	206b636f 	.word	0x206b636f
2002acb4:	63206425 	.word	0x63206425
2002acb8:	6b636568 	.word	0x6b636568
2002acbc:	20736120 	.word	0x20736120
2002acc0:	20646162 	.word	0x20646162
2002acc4:	636f6c62 	.word	0x636f6c62
2002acc8:	42000a6b 	.word	0x42000a6b
2002accc:	6b636f6c 	.word	0x6b636f6c
2002acd0:	20642520 	.word	0x20642520
2002acd4:	62207369 	.word	0x62207369
2002acd8:	69206461 	.word	0x69206461
2002acdc:	7375206e 	.word	0x7375206e
2002ace0:	62207265 	.word	0x62207265
2002ace4:	6b636f6c 	.word	0x6b636f6c
2002ace8:	6162000a 	.word	0x6162000a
2002acec:	64252064 	.word	0x64252064
2002acf0:	6572202c 	.word	0x6572202c
2002acf4:	63616c70 	.word	0x63616c70
2002acf8:	64252065 	.word	0x64252065
2002acfc:	6f4e000a 	.word	0x6f4e000a
2002ad00:	63616220 	.word	0x63616220
2002ad04:	2070756b 	.word	0x2070756b
2002ad08:	636f6c62 	.word	0x636f6c62
2002ad0c:	6e61206b 	.word	0x6e61206b
2002ad10:	6f6d2079 	.word	0x6f6d2079
2002ad14:	000a6572 	.word	0x000a6572
2002ad18:	74706d65 	.word	0x74706d65
2002ad1c:	61742079 	.word	0x61742079
2002ad20:	20656c62 	.word	0x20656c62
2002ad24:	6e206425 	.word	0x6e206425
2002ad28:	6520746f 	.word	0x6520746f
2002ad2c:	67756f6e 	.word	0x67756f6e
2002ad30:	6f662068 	.word	0x6f662068
2002ad34:	6e692072 	.word	0x6e692072
2002ad38:	61697469 	.word	0x61697469
2002ad3c:	55000a6c 	.word	0x55000a6c
2002ad40:	74616470 	.word	0x74616470
2002ad44:	61742065 	.word	0x61742065
2002ad48:	20656c62 	.word	0x20656c62
2002ad4c:	66206f74 	.word	0x66206f74
2002ad50:	6873616c 	.word	0x6873616c
2002ad54:	6e6f6420 	.word	0x6e6f6420
2002ad58:	49000a65 	.word	0x49000a65
2002ad5c:	6974696e 	.word	0x6974696e
2002ad60:	74206c61 	.word	0x74206c61
2002ad64:	656c6261 	.word	0x656c6261
2002ad68:	69616620 	.word	0x69616620
2002ad6c:	42000a6c 	.word	0x42000a6c
2002ad70:	69204d42 	.word	0x69204d42
2002ad74:	6974696e 	.word	0x6974696e
2002ad78:	7a696c61 	.word	0x7a696c61
2002ad7c:	62206465 	.word	0x62206465
2002ad80:	726f6665 	.word	0x726f6665
2002ad84:	64202c65 	.word	0x64202c65
2002ad88:	6f6e206f 	.word	0x6f6e206f
2002ad8c:	6e692074 	.word	0x6e692074
2002ad90:	61207469 	.word	0x61207469
2002ad94:	6d20796e 	.word	0x6d20796e
2002ad98:	0a65726f 	.word	0x0a65726f
2002ad9c:	54454400 	.word	0x54454400
2002ada0:	20642520 	.word	0x20642520
2002ada4:	0a646162 	.word	0x0a646162
2002ada8:	4b4c4200 	.word	0x4b4c4200
2002adac:	20642520 	.word	0x20642520
2002adb0:	64616572 	.word	0x64616572
2002adb4:	69616620 	.word	0x69616620
2002adb8:	6d202c6c 	.word	0x6d202c6c
2002adbc:	206b7261 	.word	0x206b7261
2002adc0:	62207361 	.word	0x62207361
2002adc4:	000a6461 	.word	0x000a6461
2002adc8:	20746564 	.word	0x20746564
2002adcc:	206d6262 	.word	0x206d6262
2002add0:	6c626174 	.word	0x6c626174
2002add4:	69772065 	.word	0x69772065
2002add8:	25206874 	.word	0x25206874
2002addc:	25202c64 	.word	0x25202c64
2002ade0:	25202c64 	.word	0x25202c64
2002ade4:	64000a64 	.word	0x64000a64
2002ade8:	63657465 	.word	0x63657465
2002adec:	65722074 	.word	0x65722074
2002adf0:	746c7573 	.word	0x746c7573
2002adf4:	0a642520 	.word	0x0a642520
2002adf8:	20317600 	.word	0x20317600
2002adfc:	69206425 	.word	0x69206425
2002ae00:	6c62206e 	.word	0x6c62206e
2002ae04:	6425206b 	.word	0x6425206b
2002ae08:	3276202c 	.word	0x3276202c
2002ae0c:	20642520 	.word	0x20642520
2002ae10:	62206e69 	.word	0x62206e69
2002ae14:	6b636f6c 	.word	0x6b636f6c
2002ae18:	0a642520 	.word	0x0a642520
2002ae1c:	65684300 	.word	0x65684300
2002ae20:	62206b63 	.word	0x62206b63
2002ae24:	74206d62 	.word	0x74206d62
2002ae28:	656c6261 	.word	0x656c6261
2002ae2c:	69616620 	.word	0x69616620
2002ae30:	64000a6c 	.word	0x64000a6c
2002ae34:	63657465 	.word	0x63657465
2002ae38:	65722074 	.word	0x65722074
2002ae3c:	746c7573 	.word	0x746c7573
2002ae40:	20642520 	.word	0x20642520
2002ae44:	20746f6e 	.word	0x20746f6e
2002ae48:	73616572 	.word	0x73616572
2002ae4c:	62616e6f 	.word	0x62616e6f
2002ae50:	000a656c 	.word	0x000a656c
2002ae54:	204d4242 	.word	0x204d4242
2002ae58:	3a4d454d 	.word	0x3a4d454d
2002ae5c:	78746320 	.word	0x78746320
2002ae60:	2c702520 	.word	0x2c702520
2002ae64:	70616d20 	.word	0x70616d20
2002ae68:	70252031 	.word	0x70252031
2002ae6c:	616d202c 	.word	0x616d202c
2002ae70:	25203270 	.word	0x25203270
2002ae74:	000a2070 	.word	0x000a2070
2002ae78:	5f666973 	.word	0x5f666973
2002ae7c:	5f6d6262 	.word	0x5f6d6262
2002ae80:	74696e69 	.word	0x74696e69
2002ae84:	6e6f6420 	.word	0x6e6f6420
2002ae88:	53000a65 	.word	0x53000a65
2002ae8c:	31354148 	.word	0x31354148
2002ae90:	48530032 	.word	0x48530032
2002ae94:	34383341 	.word	0x34383341
2002ae98:	41485300 	.word	0x41485300
2002ae9c:	00363532 	.word	0x00363532
2002aea0:	32414853 	.word	0x32414853
2002aea4:	60003432 	.word	0x60003432
2002aea8:	65014886 	.word	0x65014886
2002aeac:	04020403 	.word	0x04020403
2002aeb0:	2d646900 	.word	0x2d646900
2002aeb4:	32616873 	.word	0x32616873
2002aeb8:	60003432 	.word	0x60003432
2002aebc:	65014886 	.word	0x65014886
2002aec0:	01020403 	.word	0x01020403
2002aec4:	2d646900 	.word	0x2d646900
2002aec8:	32616873 	.word	0x32616873
2002aecc:	60003635 	.word	0x60003635
2002aed0:	65014886 	.word	0x65014886
2002aed4:	02020403 	.word	0x02020403
2002aed8:	2d646900 	.word	0x2d646900
2002aedc:	33616873 	.word	0x33616873
2002aee0:	60003438 	.word	0x60003438
2002aee4:	65014886 	.word	0x65014886
2002aee8:	03020403 	.word	0x03020403
2002aeec:	2d646900 	.word	0x2d646900
2002aef0:	35616873 	.word	0x35616873
2002aef4:	2b003231 	.word	0x2b003231
2002aef8:	0702030e 	.word	0x0702030e
2002aefc:	73656400 	.word	0x73656400
2002af00:	00434243 	.word	0x00434243
2002af04:	2d534544 	.word	0x2d534544
2002af08:	00434243 	.word	0x00434243
2002af0c:	8648862a 	.word	0x8648862a
2002af10:	07030df7 	.word	0x07030df7
2002af14:	73656400 	.word	0x73656400
2002af18:	6564652d 	.word	0x6564652d
2002af1c:	62632d33 	.word	0x62632d33
2002af20:	45440063 	.word	0x45440063
2002af24:	44452d53 	.word	0x44452d53
2002af28:	432d3345 	.word	0x432d3345
2002af2c:	2a004342 	.word	0x2a004342
2002af30:	f7864886 	.word	0xf7864886
2002af34:	0101010d 	.word	0x0101010d
2002af38:	61737200 	.word	0x61737200
2002af3c:	72636e45 	.word	0x72636e45
2002af40:	69747079 	.word	0x69747079
2002af44:	52006e6f 	.word	0x52006e6f
2002af48:	2a004153 	.word	0x2a004153
2002af4c:	3dce4886 	.word	0x3dce4886
2002af50:	69000102 	.word	0x69000102
2002af54:	63652d64 	.word	0x63652d64
2002af58:	6c627550 	.word	0x6c627550
2002af5c:	654b6369 	.word	0x654b6369
2002af60:	65470079 	.word	0x65470079
2002af64:	6972656e 	.word	0x6972656e
2002af68:	43452063 	.word	0x43452063
2002af6c:	79656b20 	.word	0x79656b20
2002af70:	04812b00 	.word	0x04812b00
2002af74:	69000c01 	.word	0x69000c01
2002af78:	63652d64 	.word	0x63652d64
2002af7c:	45004844 	.word	0x45004844
2002af80:	656b2043 	.word	0x656b2043
2002af84:	6f662079 	.word	0x6f662079
2002af88:	43452072 	.word	0x43452072
2002af8c:	2a004844 	.word	0x2a004844
2002af90:	f7864886 	.word	0xf7864886
2002af94:	0e01010d 	.word	0x0e01010d
2002af98:	61687300 	.word	0x61687300
2002af9c:	57343232 	.word	0x57343232
2002afa0:	52687469 	.word	0x52687469
2002afa4:	6e454153 	.word	0x6e454153
2002afa8:	70797263 	.word	0x70797263
2002afac:	6e6f6974 	.word	0x6e6f6974
2002afb0:	41535200 	.word	0x41535200
2002afb4:	74697720 	.word	0x74697720
2002afb8:	48532068 	.word	0x48532068
2002afbc:	32322d41 	.word	0x32322d41
2002afc0:	862a0034 	.word	0x862a0034
2002afc4:	0df78648 	.word	0x0df78648
2002afc8:	000b0101 	.word	0x000b0101
2002afcc:	32616873 	.word	0x32616873
2002afd0:	69573635 	.word	0x69573635
2002afd4:	53526874 	.word	0x53526874
2002afd8:	636e4541 	.word	0x636e4541
2002afdc:	74707972 	.word	0x74707972
2002afe0:	006e6f69 	.word	0x006e6f69
2002afe4:	20415352 	.word	0x20415352
2002afe8:	68746977 	.word	0x68746977
2002afec:	41485320 	.word	0x41485320
2002aff0:	3635322d 	.word	0x3635322d
2002aff4:	48862a00 	.word	0x48862a00
2002aff8:	010df786 	.word	0x010df786
2002affc:	73000c01 	.word	0x73000c01
2002b000:	38336168 	.word	0x38336168
2002b004:	74695734 	.word	0x74695734
2002b008:	41535268 	.word	0x41535268
2002b00c:	72636e45 	.word	0x72636e45
2002b010:	69747079 	.word	0x69747079
2002b014:	52006e6f 	.word	0x52006e6f
2002b018:	77204153 	.word	0x77204153
2002b01c:	20687469 	.word	0x20687469
2002b020:	2d414853 	.word	0x2d414853
2002b024:	00343833 	.word	0x00343833
2002b028:	8648862a 	.word	0x8648862a
2002b02c:	01010df7 	.word	0x01010df7
2002b030:	6873000d 	.word	0x6873000d
2002b034:	32313561 	.word	0x32313561
2002b038:	68746957 	.word	0x68746957
2002b03c:	45415352 	.word	0x45415352
2002b040:	7972636e 	.word	0x7972636e
2002b044:	6f697470 	.word	0x6f697470
2002b048:	5352006e 	.word	0x5352006e
2002b04c:	69772041 	.word	0x69772041
2002b050:	53206874 	.word	0x53206874
2002b054:	352d4148 	.word	0x352d4148
2002b058:	2a003231 	.word	0x2a003231
2002b05c:	f7864886 	.word	0xf7864886
2002b060:	0a01010d 	.word	0x0a01010d
2002b064:	41535200 	.word	0x41535200
2002b068:	2d415353 	.word	0x2d415353
2002b06c:	00535350 	.word	0x00535350
2002b070:	2e617372 	.word	0x2e617372
2002b074:	7372004e 	.word	0x7372004e
2002b078:	00452e61 	.word	0x00452e61

2002b07c <pin_pad_func_lcpu>:
	...
2002b09c:	032100b2 00000301 00000000 024b023b     ..!.........;.K.
2002b0ac:	00000237 00000000 00000000 00000000     7...............
2002b0bc:	032200b3 00000302 00000000 024b023c     ..".........<.K.
2002b0cc:	00000238 00000000 00000000 00000000     8...............
2002b0dc:	032300b4 00000303 00000000 024b023d     ..#.........=.K.
2002b0ec:	0000023a 00000000 00000000 00000000     :...............
2002b0fc:	032400b5 00000304 00000000 024b023e     ..$.........>.K.
2002b10c:	00000239 00000000 00000000 00000000     9...............

2002b11c <pin_pad_func_hcpu>:
	...
2002b13c:	000400f2 00000000 000b0000 00000000     ................
	...
2002b15c:	000900f3 00000000 00030000 00000000     ................
	...
2002b17c:	000a00f4 00000000 000a0000 00000000     ................
	...
2002b19c:	000b00f5 00000000 000b0000 00000000     ................
	...
2002b1bc:	000c00f6 00000000 00030000 00000000     ................
	...
2002b1dc:	000300f7 000d0000 00000009 00000000     ................
	...
2002b1fc:	000200f8 000e0000 0000000b 00000000     ................
	...
2002b21c:	000100f9 000f0000 0009000a 00000000     ................
	...
2002b23c:	000d00fa 00100000 000c0003 00000000     ................
	...
2002b25c:	000e00fb 00060000 00010001 00000000     ................
	...
2002b27c:	000f00fc 00010000 000c000c 00000000     ................
	...
2002b29c:	001000fd 00030000 00090000 00000000     ................
	...
2002b2bc:	000500fe 00000006 00000000 00000000     ................
	...
2002b2dc:	01540052 00000000 026302b2 016a0000     R.T.......c...j.
	...
2002b2fc:	00000053 00000000 026402b3 00000000     S.........d.....
	...
2002b31c:	01550054 01c60000 026502b4 016b019a     T.U.......e...k.
2002b32c:	023b0000 02270000 00000000 00000000     ..;...'.........
2002b33c:	014e0055 01c80000 026602b5 015f0199     U.N.......f..._.
2002b34c:	023c0000 02280000 00000000 00000000     ..<...(.........
2002b35c:	014f0056 01c70000 026702b6 015e0197     V.O.......g...^.
2002b36c:	023d0000 02290000 00000000 00000000     ..=...).........
2002b37c:	01500057 01c40000 026802b7 01680195     W.P.......h...h.
2002b38c:	023e0000 022a0000 00000000 00000000     ..>...*.........
2002b39c:	01510058 01c50000 026902b8 01690194     X.Q.......i...i.
2002b3ac:	023f0000 022b0000 00000000 00000000     ..?...+.........
2002b3bc:	01520059 01d40000 026a02b9 01600192     Y.R.......j...`.
2002b3cc:	02400000 022c0000 00000000 00000000     ..@...,.........
2002b3dc:	0153005a 01d50000 026b02ba 01610191     Z.S.......k...a.
2002b3ec:	02410000 0000023a 00000000 00000000     ..A.:...........
2002b3fc:	0000005b 00000000 026c02bb 00000000     [.........l.....
2002b40c:	02420000 00000239 00000000 00000000     ..B.9...........
2002b41c:	0000005c 00000000 026d02bc 00000000     \.........m.....
	...
2002b43c:	0000005d 00000000 026e02bd 00000000     ].........n.....
2002b44c:	01d30000 02210237 00000000 00000000     ....7.!.........
2002b45c:	001b005e 000001b7 026f02be 00000000     ^.........o.....
2002b46c:	00000000 02220238 00000000 00000000     ....8.".........
2002b47c:	0022005f 000001b8 027002bf 00000000     _.".......p.....
2002b48c:	00000000 02230000 00000000 00000000     ......#.........
2002b49c:	00230060 000001b2 027102c0 00000000     `.#.......q.....
2002b4ac:	00000000 02240000 00000000 00000000     ......$.........
2002b4bc:	00210061 000001b4 027202c1 00000000     a.!.......r.....
2002b4cc:	00000000 02250000 00000000 00000000     ......%.........
2002b4dc:	00190062 000001b5 027302c2 00000000     b.........s.....
2002b4ec:	00000000 02260000 00000000 00000000     ......&.........
2002b4fc:	00240063 000001b6 027402c3 00000000     c.$.......t.....
	...
2002b51c:	00000064 0000021a 027502c4 00000000     d.........u.....
	...
2002b53c:	00000065 00000219 027602c5 00000000     e.........v.....
	...
2002b55c:	00000066 00000000 027702c6 00000000     f.........w.....
2002b56c:	024b0000 00000000 00000000 00000000     ..K.............
2002b57c:	00000067 00000000 027802c7 00000000     g.........x.....
	...
2002b59c:	00000068 01d40000 027902c8 00000000     h.........y.....
	...
2002b5bc:	00000069 01d50000 027a02c9 00000000     i.........z.....
	...
2002b5dc:	0000006a 01c60149 027b02ca 00000000     j...I.....{.....
	...
2002b5fc:	0000006b 01c80148 027c02cb 00000000     k...H.....|.....
	...
2002b61c:	0000006c 00000000 027d02cc 00000000     l.........}.....
	...
2002b63c:	0000006d 00000000 027e02cd 00000000     m.........~.....
	...
2002b65c:	0000006e 01c70146 027f02ce 00000000     n...F...........
	...
2002b67c:	0000006f 01c40147 028002cf 00000000     o...G...........
	...
2002b69c:	00000070 01c50000 028102d0 00000000     p...............
	...
2002b6bc:	00000071 00000000 028202d1 00000000     q...............
2002b6cc:	02430000 00000000 00000000 00000000     ..C.............
2002b6dc:	00000072 00000000 028302d2 00000000     r...............
	...
2002b6fc:	00000073 00000000 028402d3 00000000     s...............
	...
2002b71c:	00000074 00000000 028502d4 00000000     t...............
	...
2002b73c:	00000075 00000000 028602d5 00000000     u...............
	...
2002b75c:	00000076 00000000 028702d6 00000000     v...............
	...
2002b77c:	00000077 0000014d 028802d7 01620000     w...M.........b.
2002b78c:	02440000 00000000 00000000 00000000     ..D.............
2002b79c:	00000078 0000014c 028902d8 00000000     x...L...........
	...
2002b7bc:	00000079 0000014a 028a02d9 01630190     y...J.........c.
2002b7cc:	02450000 022f0000 00000000 00000000     ..E.../.........
2002b7dc:	0000007a 0000014b 028b02da 0164018f     z...K.........d.
2002b7ec:	02460000 02300000 00000000 00000000     ..F...0.........
2002b7fc:	0000007b 00000000 028c02db 01650193     {.............e.
2002b80c:	02470000 02310000 00000000 00000000     ..G...1.........
2002b81c:	0000007c 00000000 028d02dc 01660196     |.............f.
2002b82c:	02480000 02320000 00000000 00000000     ..H...2.........
2002b83c:	0000007d 00000000 028e02dd 01670198     }.............g.
2002b84c:	02490000 02330000 00000000 00000000     ..I...3.........
2002b85c:	0000007e 00000000 028f02de 00000000     ~...............
2002b86c:	024a0000 02340000 00000000 00000000     ..J...4.........

2002b87c <HASH_SIZE>:
2002b87c:	20202014 00000000 04030201 00000000     .   ............
2002b88c:	01060204                                ....

2002b890 <CSWTCH.47>:
2002b890:	0000003f 00003f00 003f0000              ?....?....?.

2002b89c <hpsys_dll2_limit>:
	...
2002b8a4:	112a8800 112a8800                       ..*...*.

2002b8ac <hpsys_dvfs_config>:
2002b8ac:	000906fb 00100330 000a08fd 00110331     ....0.......1...
2002b8bc:	000d0b00 00130213 000f0d02 00130213     ................

2002b8cc <crc32tab>:
2002b8cc:	00000000 77073096 ee0e612c 990951ba     .....0.w,a...Q..
2002b8dc:	076dc419 706af48f e963a535 9e6495a3     ..m...jp5.c...d.
2002b8ec:	0edb8832 79dcb8a4 e0d5e91e 97d2d988     2......y........
2002b8fc:	09b64c2b 7eb17cbd e7b82d07 90bf1d91     +L...|.~.-......
2002b90c:	1db71064 6ab020f2 f3b97148 84be41de     d.... .jHq...A..
2002b91c:	1adad47d 6ddde4eb f4d4b551 83d385c7     }......mQ.......
2002b92c:	136c9856 646ba8c0 fd62f97a 8a65c9ec     V.l...kdz.b...e.
2002b93c:	14015c4f 63066cd9 fa0f3d63 8d080df5     O\...l.cc=......
2002b94c:	3b6e20c8 4c69105e d56041e4 a2677172     . n;^.iL.A`.rqg.
2002b95c:	3c03e4d1 4b04d447 d20d85fd a50ab56b     ...<G..K....k...
2002b96c:	35b5a8fa 42b2986c dbbbc9d6 acbcf940     ...5l..B....@...
2002b97c:	32d86ce3 45df5c75 dcd60dcf abd13d59     .l.2u\.E....Y=..
2002b98c:	26d930ac 51de003a c8d75180 bfd06116     .0.&:..Q.Q...a..
2002b99c:	21b4f4b5 56b3c423 cfba9599 b8bda50f     ...!#..V........
2002b9ac:	2802b89e 5f058808 c60cd9b2 b10be924     ...(..._....$...
2002b9bc:	2f6f7c87 58684c11 c1611dab b6662d3d     .|o/.LhX..a.=-f.
2002b9cc:	76dc4190 01db7106 98d220bc efd5102a     .A.v.q... ..*...
2002b9dc:	71b18589 06b6b51f 9fbfe4a5 e8b8d433     ...q........3...
2002b9ec:	7807c9a2 0f00f934 9609a88e e10e9818     ...x4...........
2002b9fc:	7f6a0dbb 086d3d2d 91646c97 e6635c01     ..j.-=m..ld..\c.
2002ba0c:	6b6b51f4 1c6c6162 856530d8 f262004e     .Qkkbal..0e.N.b.
2002ba1c:	6c0695ed 1b01a57b 8208f4c1 f50fc457     ...l{.......W...
2002ba2c:	65b0d9c6 12b7e950 8bbeb8ea fcb9887c     ...eP.......|...
2002ba3c:	62dd1ddf 15da2d49 8cd37cf3 fbd44c65     ...bI-...|..eL..
2002ba4c:	4db26158 3ab551ce a3bc0074 d4bb30e2     Xa.M.Q.:t....0..
2002ba5c:	4adfa541 3dd895d7 a4d1c46d d3d6f4fb     A..J...=m.......
2002ba6c:	4369e96a 346ed9fc ad678846 da60b8d0     j.iC..n4F.g...`.
2002ba7c:	44042d73 33031de5 aa0a4c5f dd0d7cc9     s-.D...3_L...|..
2002ba8c:	5005713c 270241aa be0b1010 c90c2086     <q.P.A.'..... ..
2002ba9c:	5768b525 206f85b3 b966d409 ce61e49f     %.hW..o ..f...a.
2002baac:	5edef90e 29d9c998 b0d09822 c7d7a8b4     ...^...)".......
2002babc:	59b33d17 2eb40d81 b7bd5c3b c0ba6cad     .=.Y....;\...l..
2002bacc:	edb88320 9abfb3b6 03b6e20c 74b1d29a      ..............t
2002badc:	ead54739 9dd277af 04db2615 73dc1683     9G...w...&.....s
2002baec:	e3630b12 94643b84 0d6d6a3e 7a6a5aa8     ..c..;d.>jm..Zjz
2002bafc:	e40ecf0b 9309ff9d 0a00ae27 7d079eb1     ........'......}
2002bb0c:	f00f9344 8708a3d2 1e01f268 6906c2fe     D.......h......i
2002bb1c:	f762575d 806567cb 196c3671 6e6b06e7     ]Wb..ge.q6l...kn
2002bb2c:	fed41b76 89d32be0 10da7a5a 67dd4acc     v....+..Zz...J.g
2002bb3c:	f9b9df6f 8ebeeff9 17b7be43 60b08ed5     o.......C......`
2002bb4c:	d6d6a3e8 a1d1937e 38d8c2c4 4fdff252     ....~......8R..O
2002bb5c:	d1bb67f1 a6bc5767 3fb506dd 48b2364b     .g..gW.....?K6.H
2002bb6c:	d80d2bda af0a1b4c 36034af6 41047a60     .+..L....J.6`z.A
2002bb7c:	df60efc3 a867df55 316e8eef 4669be79     ..`.U.g...n1y.iF
2002bb8c:	cb61b38c bc66831a 256fd2a0 5268e236     ..a...f...o%6.hR
2002bb9c:	cc0c7795 bb0b4703 220216b9 5505262f     .w...G....."/&.U
2002bbac:	c5ba3bbe b2bd0b28 2bb45a92 5cb36a04     .;..(....Z.+.j.\
2002bbbc:	c2d7ffa7 b5d0cf31 2cd99e8b 5bdeae1d     ....1......,...[
2002bbcc:	9b64c2b0 ec63f226 756aa39c 026d930a     ..d.&.c...ju..m.
2002bbdc:	9c0906a9 eb0e363f 72076785 05005713     ....?6...g.r.W..
2002bbec:	95bf4a82 e2b87a14 7bb12bae 0cb61b38     .J...z...+.{8...
2002bbfc:	92d28e9b e5d5be0d 7cdcefb7 0bdbdf21     ...........|!...
2002bc0c:	86d3d2d4 f1d4e242 68ddb3f8 1fda836e     ....B......hn...
2002bc1c:	81be16cd f6b9265b 6fb077e1 18b74777     ....[&...w.owG..
2002bc2c:	88085ae6 ff0f6a70 66063bca 11010b5c     .Z..pj...;.f\...
2002bc3c:	8f659eff f862ae69 616bffd3 166ccf45     ..e.i.b...kaE.l.
2002bc4c:	a00ae278 d70dd2ee 4e048354 3903b3c2     x.......T..N...9
2002bc5c:	a7672661 d06016f7 4969474d 3e6e77db     a&g...`.MGiI.wn>
2002bc6c:	aed16a4a d9d65adc 40df0b66 37d83bf0     Jj...Z..f..@.;.7
2002bc7c:	a9bcae53 debb9ec5 47b2cf7f 30b5ffe9     S..........G...0
2002bc8c:	bdbdf21c cabac28a 53b39330 24b4a3a6     ........0..S...$
2002bc9c:	bad03605 cdd70693 54de5729 23d967bf     .6......)W.T.g.#
2002bcac:	b3667a2e c4614ab8 5d681b02 2a6f2b94     .zf..Ja...h].+o*
2002bcbc:	b40bbe37 c30c8ea1 5a05df1b 2d02ef8d     7..........Z...-

2002bccc <CSWTCH.5>:
2002bccc:	2002bd6c 2002bd3c 2002bd0c 2002bcdc     l.. <.. ... ... 

2002bcdc <mbedtls_sha512_info>:
2002bcdc:	00000008 2002ae8b 00000040 00000080     ....... @.......
2002bcec:	20025f05 20025efb 20025ef7 20025ef1     ._. .^. .^. .^. 
2002bcfc:	20025ed5 20025ec3 20025ebf 20025ebb     .^. .^. .^. .^. 

2002bd0c <mbedtls_sha384_info>:
2002bd0c:	00000007 2002ae92 00000030 00000080     ....... 0.......
2002bd1c:	20025eff 20025efb 20025ef7 20025eeb     .^. .^. .^. .^. 
2002bd2c:	20025ed5 20025ec3 20025ebf 20025ebb     .^. .^. .^. .^. 

2002bd3c <mbedtls_sha256_info>:
2002bd3c:	00000006 2002ae99 00000020 00000040     .......  ...@...
2002bd4c:	20025eb5 20025eab 20025ea7 20025ea1     .^. .^. .^. .^. 
2002bd5c:	20025e85 20025e73 20025e6f 20025e6b     .^. s^. o^. k^. 

2002bd6c <mbedtls_sha224_info>:
2002bd6c:	00000005 2002aea0 0000001c 00000040     ....... ....@...
2002bd7c:	20025eaf 20025eab 20025ea7 20025e9b     .^. .^. .^. .^. 
2002bd8c:	20025e85 20025e73 20025e6f 20025e6b     .^. s^. o^. k^. 

2002bd9c <sha256_padding>:
2002bd9c:	00000080 00000000 00000000 00000000     ................
	...

2002bddc <K>:
2002bddc:	428a2f98 71374491 b5c0fbcf e9b5dba5     ./.B.D7q........
2002bdec:	3956c25b 59f111f1 923f82a4 ab1c5ed5     [.V9...Y..?..^..
2002bdfc:	d807aa98 12835b01 243185be 550c7dc3     .....[....1$.}.U
2002be0c:	72be5d74 80deb1fe 9bdc06a7 c19bf174     t].r........t...
2002be1c:	e49b69c1 efbe4786 0fc19dc6 240ca1cc     .i...G.........$
2002be2c:	2de92c6f 4a7484aa 5cb0a9dc 76f988da     o,.-..tJ...\...v
2002be3c:	983e5152 a831c66d b00327c8 bf597fc7     RQ>.m.1..'....Y.
2002be4c:	c6e00bf3 d5a79147 06ca6351 14292967     ....G...Qc..g)).
2002be5c:	27b70a85 2e1b2138 4d2c6dfc 53380d13     ...'8!...m,M..8S
2002be6c:	650a7354 766a0abb 81c2c92e 92722c85     Ts.e..jv.....,r.
2002be7c:	a2bfe8a1 a81a664b c24b8b70 c76c51a3     ....Kf..p.K..Ql.
2002be8c:	d192e819 d6990624 f40e3585 106aa070     ....$....5..p.j.
2002be9c:	19a4c116 1e376c08 2748774c 34b0bcb5     .....l7.LwH'...4
2002beac:	391c0cb3 4ed8aa4a 5b9cca4f 682e6ff3     ...9J..NO..[.o.h
2002bebc:	748f82ee 78a5636f 84c87814 8cc70208     ...toc.x.x......
2002becc:	90befffa a4506ceb bef9a3f7 c67178f2     .....lP......xq.

2002bedc <sha512_padding>:
2002bedc:	00000080 00000000 00000000 00000000     ................
	...

2002bf60 <K>:
2002bf60:	d728ae22 428a2f98 23ef65cd 71374491     ".(../.B.e.#.D7q
2002bf70:	ec4d3b2f b5c0fbcf 8189dbbc e9b5dba5     /;M.............
2002bf80:	f348b538 3956c25b b605d019 59f111f1     8.H.[.V9.......Y
2002bf90:	af194f9b 923f82a4 da6d8118 ab1c5ed5     .O....?...m..^..
2002bfa0:	a3030242 d807aa98 45706fbe 12835b01     B........opE.[..
2002bfb0:	4ee4b28c 243185be d5ffb4e2 550c7dc3     ...N..1$.....}.U
2002bfc0:	f27b896f 72be5d74 3b1696b1 80deb1fe     o.{.t].r...;....
2002bfd0:	25c71235 9bdc06a7 cf692694 c19bf174     5..%.....&i.t...
2002bfe0:	9ef14ad2 e49b69c1 384f25e3 efbe4786     .J...i...%O8.G..
2002bff0:	8b8cd5b5 0fc19dc6 77ac9c65 240ca1cc     ........e..w...$
2002c000:	592b0275 2de92c6f 6ea6e483 4a7484aa     u.+Yo,.-...n..tJ
2002c010:	bd41fbd4 5cb0a9dc 831153b5 76f988da     ..A....\.S.....v
2002c020:	ee66dfab 983e5152 2db43210 a831c66d     ..f.RQ>..2.-m.1.
2002c030:	98fb213f b00327c8 beef0ee4 bf597fc7     ?!...'........Y.
2002c040:	3da88fc2 c6e00bf3 930aa725 d5a79147     ...=....%...G...
2002c050:	e003826f 06ca6351 0a0e6e70 14292967     o...Qc..pn..g)).
2002c060:	46d22ffc 27b70a85 5c26c926 2e1b2138     ./.F...'&.&\8!..
2002c070:	5ac42aed 4d2c6dfc 9d95b3df 53380d13     .*.Z.m,M......8S
2002c080:	8baf63de 650a7354 3c77b2a8 766a0abb     .c..Ts.e..w<..jv
2002c090:	47edaee6 81c2c92e 1482353b 92722c85     ...G....;5...,r.
2002c0a0:	4cf10364 a2bfe8a1 bc423001 a81a664b     d..L.....0B.Kf..
2002c0b0:	d0f89791 c24b8b70 0654be30 c76c51a3     ....p.K.0.T..Ql.
2002c0c0:	d6ef5218 d192e819 5565a910 d6990624     .R........eU$...
2002c0d0:	5771202a f40e3585 32bbd1b8 106aa070     * qW.5.....2p.j.
2002c0e0:	b8d2d0c8 19a4c116 5141ab53 1e376c08     ........S.AQ.l7.
2002c0f0:	df8eeb99 2748774c e19b48a8 34b0bcb5     ....LwH'.H.....4
2002c100:	c5c95a63 391c0cb3 e3418acb 4ed8aa4a     cZ.....9..A.J..N
2002c110:	7763e373 5b9cca4f d6b2b8a3 682e6ff3     s.cwO..[.....o.h
2002c120:	5defb2fc 748f82ee 43172f60 78a5636f     ...]...t`/.Coc.x
2002c130:	a1f0ab72 84c87814 1a6439ec 8cc70208     r....x...9d.....
2002c140:	23631e28 90befffa de82bde9 a4506ceb     (.c#.........lP.
2002c150:	b2c67915 bef9a3f7 e372532b c67178f2     .y......+Sr..xq.
2002c160:	ea26619c ca273ece 21c0c207 d186b8c7     .a&..>'....!....
2002c170:	cde0eb1e eada7dd6 ee6ed178 f57d4f7f     .....}..x.n..O}.
2002c180:	72176fba 06f067aa a2c898a6 0a637dc5     .o.r.g.......}c.
2002c190:	bef90dae 113f9804 131c471b 1b710b35     ......?..G..5.q.
2002c1a0:	23047d84 28db77f5 40c72493 32caab7b     .}.#.w.(.$.@{..2
2002c1b0:	15c9bebc 3c9ebe0a 9c100d4c 431d67c4     .......<L....g.C
2002c1c0:	cb3e42b6 4cc5d4be fc657e2a 597f299c     .B>....L*~e..).Y
2002c1d0:	3ad6faec 5fcb6fab 4a475817 6c44198c     ...:.o._.XGJ..Dl

2002c1e0 <oid_md_alg>:
2002c1e0:	2002aea7 00000009 2002aeb1 2002afba     ... ....... ... 
2002c1f0:	00000005 2002aebb 00000009 2002aec5     ....... ....... 
2002c200:	2002afed 00000006 2002aecf 00000009     ... ....... ....
2002c210:	2002aed9 2002b020 00000007 2002aee3     ...  .. ....... 
2002c220:	00000009 2002aeed 2002b053 00000008     ....... S.. ....
	...

2002c244 <oid_pk_alg>:
2002c244:	2002af2f 00000009 2002af39 2002af47     /.. ....9.. G.. 
2002c254:	00000001 2002af4b 00000007 2002af53     ....K.. ....S.. 
2002c264:	2002af62 00000002 2002af71 00000005     b.. ....q.. ....
2002c274:	2002af77 2002af7f 00000003 00000000     w.. ... ........
	...

2002c294 <mbedtls_rsa_info>:
2002c294:	00000001 2002af47 20029577 2002956b     ....G.. w.. k.. 
2002c2a4:	20029651 2002962d 20029601 200295d1     Q.. -.. ... ... 
2002c2b4:	200295cd 200295b3 200295a1 2002957d     ... ... ... }.. 

2002c2c4 <_init>:
2002c2c4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
2002c2c6:	bf00      	nop
2002c2c8:	bcf8      	pop	{r3, r4, r5, r6, r7}
2002c2ca:	bc08      	pop	{r3}
2002c2cc:	469e      	mov	lr, r3
2002c2ce:	4770      	bx	lr

2002c2d0 <_fini>:
2002c2d0:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
2002c2d2:	bf00      	nop
2002c2d4:	bcf8      	pop	{r3, r4, r5, r6, r7}
2002c2d6:	bc08      	pop	{r3}
2002c2d8:	469e      	mov	lr, r3
2002c2da:	4770      	bx	lr

2002c2dc <__EH_FRAME_BEGIN__>:
2002c2dc:	0000 0000                                   ....

Disassembly of section .l1_ret_text_HAL_PMU_ConfigPeriLdo:

2002c2e0 <HAL_PMU_ConfigPeriLdo>:
2002c2e0:	b538      	push	{r3, r4, r5, lr}
2002c2e2:	b160      	cbz	r0, 2002c2fe <HAL_PMU_ConfigPeriLdo+0x1e>
2002c2e4:	4c11      	ldr	r4, [pc, #68]	@ (2002c32c <HAL_PMU_ConfigPeriLdo+0x4c>)
2002c2e6:	6863      	ldr	r3, [r4, #4]
2002c2e8:	b2db      	uxtb	r3, r3
2002c2ea:	2b07      	cmp	r3, #7
2002c2ec:	d01a      	beq.n	2002c324 <HAL_PMU_ConfigPeriLdo+0x44>
2002c2ee:	6863      	ldr	r3, [r4, #4]
2002c2f0:	b2db      	uxtb	r3, r3
2002c2f2:	2b0f      	cmp	r3, #15
2002c2f4:	d016      	beq.n	2002c324 <HAL_PMU_ConfigPeriLdo+0x44>
2002c2f6:	2808      	cmp	r0, #8
2002c2f8:	d001      	beq.n	2002c2fe <HAL_PMU_ConfigPeriLdo+0x1e>
2002c2fa:	2810      	cmp	r0, #16
2002c2fc:	d114      	bne.n	2002c328 <HAL_PMU_ConfigPeriLdo+0x48>
2002c2fe:	2900      	cmp	r1, #0
2002c300:	f04f 0421 	mov.w	r4, #33	@ 0x21
2002c304:	bf0c      	ite	eq
2002c306:	2120      	moveq	r1, #32
2002c308:	2101      	movne	r1, #1
2002c30a:	4d09      	ldr	r5, [pc, #36]	@ (2002c330 <HAL_PMU_ConfigPeriLdo+0x50>)
2002c30c:	4084      	lsls	r4, r0
2002c30e:	6deb      	ldr	r3, [r5, #92]	@ 0x5c
2002c310:	4081      	lsls	r1, r0
2002c312:	ea23 0304 	bic.w	r3, r3, r4
2002c316:	430b      	orrs	r3, r1
2002c318:	65eb      	str	r3, [r5, #92]	@ 0x5c
2002c31a:	b11a      	cbz	r2, 2002c324 <HAL_PMU_ConfigPeriLdo+0x44>
2002c31c:	f241 3088 	movw	r0, #5000	@ 0x1388
2002c320:	f7f5 fdeb 	bl	20021efa <HAL_Delay_us>
2002c324:	2000      	movs	r0, #0
2002c326:	bd38      	pop	{r3, r4, r5, pc}
2002c328:	2001      	movs	r0, #1
2002c32a:	e7fc      	b.n	2002c326 <HAL_PMU_ConfigPeriLdo+0x46>
2002c32c:	5000b000 	.word	0x5000b000
2002c330:	500ca000 	.word	0x500ca000

Disassembly of section .l1_ret_text_HAL_PMU_Reboot:

2002c334 <HAL_PMU_Reboot>:
2002c334:	b508      	push	{r3, lr}
2002c336:	f3ef 8310 	mrs	r3, PRIMASK
2002c33a:	2501      	movs	r5, #1
2002c33c:	f385 8810 	msr	PRIMASK, r5
2002c340:	2002      	movs	r0, #2
2002c342:	f7f6 fbc5 	bl	20022ad0 <HAL_HPAON_WakeCore>
2002c346:	4628      	mov	r0, r5
2002c348:	f7f8 ffae 	bl	200252a8 <HAL_RCC_Reset_and_Halt_LCPU>
2002c34c:	462a      	mov	r2, r5
2002c34e:	2100      	movs	r1, #0
2002c350:	2008      	movs	r0, #8
2002c352:	f7ff ffc5 	bl	2002c2e0 <HAL_PMU_ConfigPeriLdo>
2002c356:	f44f 50fa 	mov.w	r0, #8000	@ 0x1f40
2002c35a:	f7f5 fd6f 	bl	20021e3c <HAL_Delay_us_>
2002c35e:	2000      	movs	r0, #0
2002c360:	f7f8 fda2 	bl	20024ea8 <HAL_RCC_HCPU_GetClockSrc>
2002c364:	4604      	mov	r4, r0
2002c366:	b928      	cbnz	r0, 2002c374 <HAL_PMU_Reboot+0x40>
2002c368:	f7f6 fbdc 	bl	20022b24 <HAL_HPAON_EnableXT48>
2002c36c:	4629      	mov	r1, r5
2002c36e:	4620      	mov	r0, r4
2002c370:	f7f8 fe62 	bl	20025038 <HAL_RCC_HCPU_ClockSelect>
2002c374:	f245 0250 	movw	r2, #20560	@ 0x5050
2002c378:	4c09      	ldr	r4, [pc, #36]	@ (2002c3a0 <HAL_PMU_Reboot+0x6c>)
2002c37a:	4b0a      	ldr	r3, [pc, #40]	@ (2002c3a4 <HAL_PMU_Reboot+0x70>)
2002c37c:	6763      	str	r3, [r4, #116]	@ 0x74
2002c37e:	4b0a      	ldr	r3, [pc, #40]	@ (2002c3a8 <HAL_PMU_Reboot+0x74>)
2002c380:	631a      	str	r2, [r3, #48]	@ 0x30
2002c382:	6823      	ldr	r3, [r4, #0]
2002c384:	075b      	lsls	r3, r3, #29
2002c386:	d506      	bpl.n	2002c396 <HAL_PMU_Reboot+0x62>
2002c388:	6823      	ldr	r3, [r4, #0]
2002c38a:	4808      	ldr	r0, [pc, #32]	@ (2002c3ac <HAL_PMU_Reboot+0x78>)
2002c38c:	f023 0304 	bic.w	r3, r3, #4
2002c390:	6023      	str	r3, [r4, #0]
2002c392:	f7f5 fdb2 	bl	20021efa <HAL_Delay_us>
2002c396:	6823      	ldr	r3, [r4, #0]
2002c398:	f043 0304 	orr.w	r3, r3, #4
2002c39c:	6023      	str	r3, [r4, #0]
2002c39e:	e7fe      	b.n	2002c39e <HAL_PMU_Reboot+0x6a>
2002c3a0:	500ca000 	.word	0x500ca000
2002c3a4:	0a50c015 	.word	0x0a50c015
2002c3a8:	500cb000 	.word	0x500cb000
2002c3ac:	000186a0 	.word	0x000186a0

Disassembly of section .l1_ret_text_HAL_PMU_GetHpsysVoutRef:

2002c3b0 <HAL_PMU_GetHpsysVoutRef>:
2002c3b0:	4b04      	ldr	r3, [pc, #16]	@ (2002c3c4 <HAL_PMU_GetHpsysVoutRef+0x14>)
2002c3b2:	781a      	ldrb	r2, [r3, #0]
2002c3b4:	b122      	cbz	r2, 2002c3c0 <HAL_PMU_GetHpsysVoutRef+0x10>
2002c3b6:	b118      	cbz	r0, 2002c3c0 <HAL_PMU_GetHpsysVoutRef+0x10>
2002c3b8:	78db      	ldrb	r3, [r3, #3]
2002c3ba:	7003      	strb	r3, [r0, #0]
2002c3bc:	2000      	movs	r0, #0
2002c3be:	4770      	bx	lr
2002c3c0:	2001      	movs	r0, #1
2002c3c2:	4770      	bx	lr
2002c3c4:	20049f64 	.word	0x20049f64

Disassembly of section .l1_ret_text_HAL_PMU_GetHpsysVoutRef2:

2002c3c8 <HAL_PMU_GetHpsysVoutRef2>:
2002c3c8:	4b04      	ldr	r3, [pc, #16]	@ (2002c3dc <HAL_PMU_GetHpsysVoutRef2+0x14>)
2002c3ca:	781a      	ldrb	r2, [r3, #0]
2002c3cc:	b122      	cbz	r2, 2002c3d8 <HAL_PMU_GetHpsysVoutRef2+0x10>
2002c3ce:	b118      	cbz	r0, 2002c3d8 <HAL_PMU_GetHpsysVoutRef2+0x10>
2002c3d0:	7b5b      	ldrb	r3, [r3, #13]
2002c3d2:	7003      	strb	r3, [r0, #0]
2002c3d4:	2000      	movs	r0, #0
2002c3d6:	4770      	bx	lr
2002c3d8:	2001      	movs	r0, #1
2002c3da:	4770      	bx	lr
2002c3dc:	20049f64 	.word	0x20049f64
