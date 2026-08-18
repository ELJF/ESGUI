#include <rtconfig.h>
#include <board.h>
#include <string.h>
#include <dfu.h>


#undef FLASH_TABLE_START_ADDR
#define FLASH_TABLE_START_ADDR (0x12000000)

RT_USED const struct sec_configuration sec_config =
{
    .magic = SEC_CONFIG_MAGIC,
    .ftab[0] = {.base = FLASH_TABLE_START_ADDR,      .size = FLASH_TABLE_SIZE,      .xip_base = 0, .flags = 0},
    .ftab[1] = {.base = FLASH_CAL_TABLE_START_ADDR,  .size = FLASH_CAL_TABLE_SIZE,  .xip_base = 0, .flags = 0},
    .ftab[3] = {.base = 0x12010000, .size = 0x00010000,  .xip_base = 0x20020000, .flags = 0},
    .ftab[4] = {.base = 0x12020000, .size = 0x00700000,  .xip_base = 0x12020000, .flags = 0},
    .ftab[5] = {.base = FLASH_BOOT_PATCH_START_ADDR, .size = FLASH_BOOT_PATCH_SIZE, .xip_base = BOOTLOADER_PATCH_CODE_ADDR, .flags = 0},
    .ftab[7] = {.base = 0x12010000, .size = 0x00010000,  .xip_base = 0x20020000, .flags = 0},
    .ftab[8] = {.base = 0x12020000, .size = 0x00700000,  .xip_base = 0x12020000, .flags = 0},
    .ftab[9] = {.base = BOOTLOADER_PATCH_CODE_ADDR,  .size = FLASH_BOOT_PATCH_SIZE, .xip_base = BOOTLOADER_PATCH_CODE_ADDR, .flags = 0},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_HCPU)] = {.length = 0x00048F08, .blksize = 512, .flags = DFU_FLAG_AUTO},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_LCPU)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_BL)] = {.length = 0x0000E164, .blksize = 512, .flags = DFU_FLAG_AUTO},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_BOOT)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_LCPU2)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_BCPU2)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_HCPU2)] = {.length = 0x00048F08, .blksize = 512, .flags = DFU_FLAG_AUTO},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_BOOT2)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_HCPU_EXT2)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_LCPU_EXT1)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_LCPU_EXT2)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_RESERVED)] = {.length = 0xFFFFFFFF},
    .imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_SINGLE)] = {.length = 0xFFFFFFFF},
    .running_imgs[CORE_HCPU] = (struct image_header_enc *)&(((struct sec_configuration *)FLASH_TABLE_START_ADDR)->imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_HCPU)]),
    .running_imgs[CORE_LCPU] = (struct image_header_enc *)0xFFFFFFFF,
    .running_imgs[CORE_BL] = (struct image_header_enc *)&(((struct sec_configuration *)FLASH_TABLE_START_ADDR)->imgs[DFU_FLASH_IMG_IDX(DFU_FLASH_IMG_BL)]),
    .running_imgs[CORE_BOOT] = (struct image_header_enc *)0xFFFFFFFF,
};

