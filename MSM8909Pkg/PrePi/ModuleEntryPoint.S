//
//  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
//  Copyright (c) 2019, RUIKAI LIU and MR TUNNEL. All rights reserved.
//
//  This program and the accompanying materials
//  are licensed and made available under the terms and conditions of the BSD License
//  which accompanies this distribution.  The full text of the license may be found at
//  http://opensource.org/licenses/bsd-license.php
//
//  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
//  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
//
//

#include <AsmMacroIoLib.h>
#include <Library/PcdLib.h>
#include <Chipset/ArmV7.h>
.text
.align 3

#define LoadConstantToReg(Data, Reg) \
    ldr Reg, =Data


GCC_ASM_IMPORT (ArmDeInitialize)
GCC_ASM_IMPORT (CEntryPoint)
GCC_ASM_EXPORT (_ModuleEntryPoint)
GCC_ASM_IMPORT (ArmEnableInstructionCache)
GCC_ASM_IMPORT (ArmEnableDataCache)
GCC_ASM_IMPORT (ArmInvalidateTlb)

.global _StackBase 
.global _StackSize

_StackBase:
  .quad FixedPcdGet32(PcdPrePiStackBase)

_StackSize:
  .quad FixedPcdGet32(PcdPrePiStackSize)

_ModuleEntryPoint:
  /* World reset */
  bl ASM_PFX(ArmDeInitialize)
  
  /* Clear r0 for function calls below */
  mov r0, #0  

  /* First ensure all interrupts are disabled */
  bl ASM_PFX(ArmDisableInterrupts)

  /* Ensure that the MMU and caches are off */
  bl ASM_PFX(ArmDisableCachesAndMmu)
 
  /* Invalide I-Cache */
  bl ASM_PFX(ArmInvalidateInstructionCache)
  
  /* Invalidate TLB */
  bl ASM_PFX(ArmInvalidateTlb)
    
_SetupPrimaryCoreStack:
      
  //Disable Strict alignment checking & Enable Instruction cache
  mrc     p15, 0, r0, c1, c0, 0
  bic     r0, r0, #0x00002300     /* clear bits 13, 9:8 (--V- --RS) */
  bic     r0, r0, #0x00000005     /* clear bits 0, 2 (---- -C-M) */
  bic     r0, r0, #0x00000002     /* Clear bit 1 (Alignment faults) */
  orr     r0, r0, #0x00001000     /* set bit 12 (I) enable I-Cache */
  mcr     p15, 0, r0, c1, c0, 0
  // Enable NEON register in case folks want to use them for optimizations (CopyMem)
  mrc     p15, 0, r0, c1, c0, 2
  orr     r0, r0, #0x00f00000   // Enable VPF access (V* instructions)
  mcr     p15, 0, r0, c1, c0, 2
  mov     r0, #0x40000000       // Set EN bit in FPEXC
  mcr     p10,#0x7,r0,c8,c0,#0  // msr     FPEXC,r0 in ARM assembly

  ldr r0, _StackBase     /* Stack base arg0 */
  ldr r1, _StackSize     /* Stack size arg1 */
  
  add r4, r0, r1
  add sp, r4, #0

_EnableCache: 
  bl ArmInvalidateDataCache
  bl ASM_PFX(ArmEnableInstructionCache)
  bl ASM_PFX(ArmEnableDataCache) 

_PrepareArguments:
  /* r0 = _StackBase and r1 = _StackSize */
  ldr   r0, _StackBase /* Stack base arg0 */
  ldr   r1, _StackSize /* Stack size arg1 */

  // Move sec startup address into a data register
  // Ensure we're jumping to FV version of the code (not boot remapped alias)
  ldr   r4, =ASM_PFX(CEntryPoint)

  // Jump to PrePiCore C code
  //    r0 = UefiMemoryBase
  //    r1 = StacksBase
  blx	r4

_NeverReturn:
  b _NeverReturn

.align 3
dead:  
  b dead 
