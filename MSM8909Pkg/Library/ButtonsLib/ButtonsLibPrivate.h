#ifndef __BUTTONSLIBPRIVATE_H__
#define __BUTTONSLIBPRIVATE_H__

/** @file
ButtonsLibPrivate.h

  Buttons library internal defines

  Copyright (c) 2013-2014 Qualcomm Technologies, Inc. All rights reserved.
  Qualcomm Technologies Proprietary and Confidential.

**/

/*===========================================================================

                        EDIT HISTORY FOR MODULE

  This section contains comments describing changes made to the module.
  Notice that changes are listed in reverse chronological order.


when       who     what, where, why
--------   ---     ----------------------------------------------------------
02/14/14   dm      Changing SNAPSHOT GPIO
01/28/14   dm      Port to 8x16
08/14/13   ma      Configure S3 reset timer, enable DVDD button reset
03/22/13   ma      Added reset support
03/21/13   ma      Added PON debounce register
03/18/13   ma      Added macros to denote registers
10/27/12   ma      Port to 8x26
09/27/12   ma      Initial version for 8974.
===========================================================================*/

#include <Protocol/EFIPlatformInfo.h>
#include <Protocol/SimpleTextInEx.h>
#include <Protocol/EFISPMI.h>
#include <Protocol/EFITlmm.h>

VOID SPMIError (
     SpmiBus_ResultType error,
     EFI_STATUS Status
     );

#define VOLUME_UP_GPIO    90
#define VOLUME_DOWN_GPIO  91

//Register Addresses
#define PON_INT_RT_STS_REG  0x810

#define PON_KPDPWR_N_RESET_S1_TIMER_REG     0x840
#define PON_KPDPWR_N_RESET_S2_TIMER_REG     0x841
#define PON_KPDPWR_N_RESET_S2_CTL_REG       0x842
#define PON_KPDPWR_N_RESET_S2_CTL2_REG      0x843


#define PON_RESIN_AND_KPDPWR_RESET_S1_TIMER_REG     0x848
#define PON_RESIN_AND_KPDPWR_RESET_S2_TIMER_REG     0x849
#define PON_RESIN_AND_KPDPWR_RESET_S2_CTL_REG       0x84A
#define PON_RESIN_AND_KPDPWR_RESET_S2_CTL2_REG      0x84B

#define PON_DEBOUNCE_CTL 0x871
#define PON_S3_RESET_TIMER 0x875

//Register Masks
#define KPDPWR_ON_MASK      0x01
#define RESIN_ON_MASK       0x02

#define RESET_S2_CTL2_ENABLE  0x80
#define RESET_S2_CTL2_DISABLE 0x00


#define RESET_S2_CTL_SOFT_RESET      0x00
#define RESET_S2_CTL_WARM_RESET      0x01
#define RESET_S2_CTL_SHUTDOWN        0x04
#define RESET_S2_CTL_DVDD_SHUTDOWN   0x05
#define RESET_S2_CTL_HARD_RESET      0x07
#define RESET_S2_CTL_DVDD_HARD_RESET 0x08

#define S3_TIMER_0s   0x00
#define S3_TIMER_2s   0x01
#define S3_TIMER_4s   0x02
#define S3_TIMER_8s   0x03
#define S3_TIMER_16s  0x04
#define S3_TIMER_32s  0x05
#define S3_TIMER_64s  0x06
#define S3_TIMER_128s 0x07

//Register Values
#define S1_TIMER_0ms     0x0
#define S1_TIMER_32ms    0x01
#define S1_TIMER_56ms    0x02
#define S1_TIMER_80ms    0x03
#define S1_TIMER_128ms   0x04
#define S1_TIMER_184ms   0x05
#define S1_TIMER_272ms   0x06
#define S1_TIMER_408ms   0x07
#define S1_TIMER_608ms   0x08
#define S1_TIMER_904ms   0x09
#define S1_TIMER_1352ms  0x0A
#define S1_TIMER_2048ms  0x0B
#define S1_TIMER_3072ms  0x0C
#define S1_TIMER_4480ms  0x0D
#define S1_TIMER_6720ms  0x0E
#define S1_TIMER_10256ms 0x0F


#define S2_TIMER_0ms     0x0
#define S2_TIMER_10ms    0x1
#define S2_TIMER_50ms    0x2
#define S2_TIMER_100ms   0x3
#define S2_TIMER_250ms   0x4
#define S2_TIMER_500ms   0x5
#define S2_TIMER_1s      0x6
#define S2_TIMER_2s      0x7

#endif /* __BUTTONSLIBPRIVATE_H__ */
