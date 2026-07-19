__ROM_BASE = ((0x12020000));
__ROM_SIZE = ((0x00700000));
__RAM_BASE = (0x20000000);
__RAM_SIZE = (0x0007FC00);
__STACK_SIZE = 0x00002000;
__HEAP_SIZE = 0x00000C00;
__ROM_EX_BASE = (0x2007FC00);
__ROM_EX_SIZE = (0x00000000);
__PSRAM_BASE = (0x60000000);
__PSRAM_SIZE = (0x00800000);
__ROM2_BASE = (((0x12000000)));
__ROM2_SIZE = (4096*1024);
__ROM3_BASE = (((((((0x12000000)))) + ((4096*1024)) - 1)) + 1);
__ROM3_SIZE = (4096*3*1024);
MEMORY
{
    ROM (rx) : ORIGIN = __ROM_BASE, LENGTH = __ROM_SIZE
    RAM (rw) : ORIGIN = __RAM_BASE, LENGTH = __RAM_SIZE
    ROM_EX(rw):ORIGIN = __ROM_EX_BASE, LENGTH = __ROM_EX_SIZE
    PSRAM(rw): ORIGIN = __PSRAM_BASE, LENGTH = __PSRAM_SIZE
    ROM2 (rx): ORIGIN = __ROM2_BASE, LENGTH = __ROM2_SIZE
    ROM3 (rx): ORIGIN = __ROM3_BASE, LENGTH = __ROM3_SIZE
}
ENTRY(Reset_Handler)
SECTIONS
{
  .vectors :
  {
    _stext = ABSOLUTE(.);
    KEEP(*(.vectors));
    . = . + 4;
  } > ROM
  .stack :
  {
    . = ALIGN(8);
    __StackLimit = .;
    . = . + __STACK_SIZE;
    . = ALIGN(8);
    __StackTop = .;
  } > RAM
  PROVIDE(__stack = __StackTop);
  .heap :
  {
    . = ALIGN(8);
    __end__ = .;
    PROVIDE(end = .);
    . = . + __HEAP_SIZE;
    . = ALIGN(8);
    __HeapLimit = .;
  } > RAM
  .retm_data :
  {
    . = ALIGN(4);
    __rw_retm_data_start__ = .;
    * (.*l1_ret_text_*)
    * (.*l1_ret_rodata_*)
    *drv_spi_flash.o (.text* .rodata*)
    *flash_table.o (.text* .rodata*)
    *bf0_hal_mpi.o (.text* .rodata*)
    *bf0_hal_mpi_ex.o (.text* .rodata*)
    *bf0_hal_mpi_psram.o (.text* .rodata*)
    *flash.o (.text* .rodata*)
    *drv_psram.o (.text* .rodata*)
    *context_gcc.o (.text* .rodata*)
    *drv_common.o (.text.HAL_GetTick)
    *bf0_hal_rcc.o (.text* .rodata*)
    *bf0_pm.o (.text.sifli_light_handler)
    *bf0_pm.o (.text.sifli_deep_handler)
    *bf0_pm.o (.text.sifli_standby_handler)
    *bf0_pm.o (.text.SystemInitFromStandby)
    *.o (.text.SystemPowerOnModeGet)
    *bsp_init.o (.text* .rodata*)
    *bsp_lcd_tp.o (.text* .rodata*)
    *bsp_pinmux.o (.text* .rodata*)
    *bsp_power.o (.text* .rodata*)
    *bf0_hal_gpio.o (.text* .rodata*)
    *bf0_hal_hpaon.o (.text* .rodata*)
    *bf0_hal.o (.text.HAL_Init)
    *.o (.text.HAL_Delay_us)
    *.o (.text.HAL_Delay_us_)
    *.o (.text.HAL_Delay_us2_)
    *.o (.text.HAL_MspInit)
    *.o (.text.HAL_Delay)
    *bf0_hal_pinmux.o (.text* .rodata*)
    *bf0_pin_const.o (.text* .rodata*)
    *drv_common.o (.text.rt_hw_us_delay)
    *.o (.text.rt_memset)
    *rt_memclr*.o (.text*)
    *memset*.o (.text*)
    *.o (.retm_data_*)
    . = ALIGN(4);
    __rw_retm_data_end__ = .;
  } > RAM AT > ROM
  .text :
  {
    *(.text*)
    *(.rodata*)
    KEEP(*(.init))
    KEEP(*(.fini))
    . = ALIGN(4);
    __fsymtab_start = .;
    KEEP(*(FSymTab))
    __fsymtab_end = .;
    . = ALIGN(4);
    __vsymtab_start = .;
    KEEP(*(VSymTab))
    __vsymtab_end = .;
    . = ALIGN(4);
    LcdDriverDescTab_start = .;
    KEEP(*(LcdDriverDescTab))
    LcdDriverDescTab_end = .;
    . = ALIGN(4);
    __rt_utest_tc_tab_start = .;
    KEEP(*(UtestTcTab))
    __rt_utest_tc_tab_end = .;
    . = ALIGN(4);
    __rt_init_start = .;
    KEEP(*(SORT(.rti_fn*)))
    __rt_init_end = .;
    . = ALIGN(4);
    BuiltinAppTab_start = .;
    KEEP(*(BuiltinAppTab))
    BuiltinAppTab_end = .;
    . = ALIGN(4);
    __app_font_start__ = .;
    KEEP(*(.app_font))
    __app_font_end__ = .;
    . = ALIGN(4);
    __SerialTranExport_start__ = .;
    KEEP(*(SerialTranExport))
    __SerialTranExport_end__ = .;
    . = ALIGN(4);
    __sifli_reg_start__ = .;
    KEEP(*(SORT(.sifli_reg*)))
    __sifli_reg_end__ = .;
    . = ALIGN(4);
    __bt_sifli_reg_start__ = .;
    KEEP(*(SORT(.bt_sifli_reg*)))
    __bt_sifli_reg_end__ = .;
    KEEP(*(.eh_frame*))
    _etext = ABSOLUTE(.);
  } > ROM
  .rom_ex :
  {
    . = ALIGN(4);
    __rw_rom_ex_start__ = .;
    __ER_IROM1_EX$$RO_start__ = .;
    __ER_IROM1_EX$$RO_load_start__ = LOADADDR(.rom_ex);
    *(.l1_non_ret_text_*)
    *(.l1_non_ret_rodata_*)
    . = ALIGN(4);
    __rw_rom_ex_end__ = .;
    __ER_IROM1_EX$$RO_end__ = .;
    __ER_IROM1_EX$$RO_load_end__ = LOADADDR(.rom_ex) + SIZEOF(.rom_ex);
  } > ROM_EX AT > ROM
  .ARM.extab :
  {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > ROM
  __exidx_start = .;
  .ARM.exidx :
  {
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } > ROM
  __exidx_end = .;
  .copy.table :
  {
    . = ALIGN(4);
    __copy_table_start__ = .;
    LONG (LOADADDR(.data))
    LONG (ADDR(.data))
    LONG (SIZEOF(.data))
    LONG (LOADADDR(.retm_data))
    LONG (ADDR(.retm_data))
    LONG (SIZEOF(.retm_data))
    LONG (LOADADDR(.rom_ex))
    LONG (ADDR(.rom_ex))
    LONG (SIZEOF(.rom_ex))
    __copy_table_end__ = .;
  } > ROM
  .zero.table :
  {
    . = ALIGN(4);
    __zero_table_start__ = .;
    LONG (__bss_start__)
    LONG (__bss_end__ - __bss_start__)
    LONG (ADDR(.retm_bss))
    LONG (SIZEOF(.retm_bss))
    __zero_table_end__ = .;
  } > ROM
  .retm_bss :
  {
    . = ALIGN(4);
    __rw_retm_bss_start__ = .;
    __RW_IRAM_RET$$ZI_start__ = .;
    * (.bss.retm_bss_*)
    . = ALIGN(4);
    __RW_IRAM_RET$$ZI_end__ = .;
  } > RAM
  .RW_IRAM0 :
  {
    *(non_ret)
    *(.*l1_non_ret_data_*)
    *(.*l1_non_ret_bss_*)
  } > RAM
  __etext = ALIGN (4);
  .data :
  {
    _sdata = ABSOLUTE(.);
    __data_start__ = .;
    __RW_IRAM1_start__ = .;
    *(vtable)
    *(.data)
    *(.data.*)
    *(.l1_ret_data_*)
    *(Jlink_RTT)
    . = ALIGN(4);
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP(*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
    . = ALIGN(4);
    _sinit = ABSOLUTE(.);
    PROVIDE(__ctors_start__ = .);
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP(*(SORT(.ctors.*)))
    KEEP(*(.ctors))
    KEEP(*(SORT(.init_array.*)))
    KEEP(*(.init_array))
    _einit = ABSOLUTE(.);
    PROVIDE_HIDDEN (__init_array_end = .);
    PROVIDE(__ctors_end__ = .);
    . = ALIGN(4);
    PROVIDE(__dtors_start__ = .);
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP(*(SORT(.dtors.*)))
    KEEP(*(.dtors))
    KEEP(*(SORT(.fini_array.*)))
    KEEP(*(.fini_array))
    PROVIDE_HIDDEN (__fini_array_end = .);
    PROVIDE(__dtors_end__ = .);
    KEEP(*(.jcr*))
    . = ALIGN(4);
    __data_end__ = .;
    __RW_IRAM1_end__ = .;
    _edata = ABSOLUTE(.);
  } > RAM AT > ROM
  __etext2 = ALIGN (4);
  .RW_PSRAM1 :
  {
    . = ALIGN(4);
    __rw_psram1_start__ = .;
    *(.*l2_ret_data_*)
    *(.*l2_ret_bss_*)
    *(.*l2_cache_ret_data_*)
    *(.*l2_cache_ret_bss_*)
    . = ALIGN(4);
    __rw_psram1_end__ = .;
  } > PSRAM
  .RW_PSRAM_NON_RET :
  {
    . = ALIGN(32);
    __RW_PSRAM_NON_RET_start__ = .;
    *(.nand_cache)
    *(.*l2_non_ret_data_*)
    *(.*l2_non_ret_bss_*)
    *(.*l2_cache_non_ret_data_*)
    *(.*l2_cache_non_ret_bss_*)
    . = ALIGN(4);
    __RW_PSRAM_NON_RET_end__ = .;
  } > PSRAM
  .bss :
  {
    _sbss = ABSOLUTE(.);
    . = ALIGN(4);
    __bss_start__ = .;
    *(.bss)
    *(.bss.*)
    *(COMMON)
    *(.l1_ret_bss_*)
    . = ALIGN(4);
    __bss_end__ = .;
    __bss_end = .;
    _ebss = ABSOLUTE(.);
    __end__ = .;
    PROVIDE(end = .);
  } > RAM AT > RAM
  .rom2 :
  {
    *(.ROM1_IMG)
    *(.ROM3_IMG)
  } > ROM2
  .rom3 :
  {
    *lvsf_font_*(.rodata*)
  } > ROM3
}
