/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"
#include "sleep.h"


int main()
{
    init_platform();

    XGpio	run_rst;
    XGpio	clk_err;
    XGpio	masterData;
    XGpio	slaveData;

    XGpio_Initialize(&run_rst, XPAR_AXI_GPIO_RUN_RST_DEVICE_ID);
    XGpio_Initialize(&clk_err, XPAR_AXI_GPIO_CLK_ERR_DEVICE_ID);
    XGpio_Initialize(&masterData, XPAR_AXI_GPIO_MASTERDATA_DEVICE_ID);
    XGpio_Initialize(&slaveData, XPAR_AXI_GPIO_SLAVEDATA_DEVICE_ID);

    XGpio_SetDataDirection(&run_rst, 1, 0);
    XGpio_SetDataDirection(&run_rst, 2, 0);
    XGpio_SetDataDirection(&clk_err, 1, 1);
    XGpio_SetDataDirection(&clk_err, 2, 1);
    XGpio_SetDataDirection(&masterData, 1, 0);
    XGpio_SetDataDirection(&masterData, 2, 1);
    XGpio_SetDataDirection(&slaveData, 1, 0);
	XGpio_SetDataDirection(&slaveData, 2, 1);



	sleep(1);

	int choice;

	int masterTxVal;
	u8 masterTxHex;

	int masterRxVal;
	u8 masterRxHex;

	int slaveTxVal;
	u8 slaveTxHex;

	int slaveRxVal;
	u8 slaveRxHex;

	int errStat;


	printf("PSPI TESTBED \n\n");


	while(1)
	{
		printf("1. Set  Master Data : \n");
		printf("2. Set  Slave  Data : \n");
		printf("3. Read Master Data : \n");
		printf("4. Read Slave  Data : \n");
		printf("5. Check Error      : \n");
		printf("6. Run              : \n");
		printf("7. Reset            : \n");
		scanf("%d" , &choice);
		printf("\n\n");


		if(choice == 1)
		{
			printf("Enter the master data : \n");
			scanf("%x" , &masterTxVal);
			masterTxHex = (u8)(masterTxVal & 0xFF);
			XGpio_DiscreteWrite(&masterData, 1, masterTxHex);
			printf("You entered : 0x%02X \n\n" , masterTxHex);
		}

		else if(choice == 2)
		{
			printf("Enter the slave data : \n");
			scanf("%x" , &slaveTxVal);
			slaveTxHex = (u8)(slaveTxVal & 0xFF);
			XGpio_DiscreteWrite(&slaveData, 1, slaveTxHex);
			printf("You entered : 0x%02X \n\n" , slaveTxHex);
		}

		else if(choice == 3)
		{
			masterRxVal = XGpio_DiscreteRead(&masterData, 2);
			masterRxHex = (u8)(masterRxVal & 0xFF);
			printf("Master received data : 0x%02X \n\n" , masterRxHex);
		}

		else if(choice == 4)
		{
			slaveRxVal = XGpio_DiscreteRead(&slaveData, 2);
			slaveRxHex = (u8)(slaveRxVal & 0xFF);
			printf("Slave received data : 0x%02X \n\n" , slaveRxHex);
		}

		else if(choice == 5)
		{
			errStat = XGpio_DiscreteRead(&clk_err, 2);
			printf("Error Status : %d \n" , errStat);
		}

		else if(choice == 6)
		{
			int clkStat = XGpio_DiscreteRead(&clk_err, 1);

			if(clkStat == 1)
			{
				while(clkStat != 0)
				{
					clkStat = XGpio_DiscreteRead(&clk_err, 1);
				}
			}

			else if(clkStat == 0)
			{
				XGpio_DiscreteWrite(&run_rst, 1, 1);
				usleep(0.01);
				XGpio_DiscreteWrite(&run_rst, 1, 0);
			}

//			while(clkStat != 1)
//			{
//				clkStat = XGpio_DiscreteRead(&clk_err, 1);
//			}
//
//			XGpio_DiscreteWrite(&run_rst, 1, 0);
		}

		else if(choice == 7)
		{
			XGpio_DiscreteWrite(&run_rst, 2, 1);
			usleep(0.1);
			XGpio_DiscreteWrite(&run_rst, 2, 0);
		}
	}


    cleanup_platform();
    return 0;
}
