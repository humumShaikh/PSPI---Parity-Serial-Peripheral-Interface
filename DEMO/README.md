***Instructions***

1.  Download the hardware (xsa) file from the folder.
2.  Create a vitis platform project and select the downloaded hardware file.
3.  Create an application project based on this platform and copy the C program from the pspi_controller.c to run and test the PSPI working on the PYNQ board.

<br>
<br>
<br>

***Implementation Diagram***

<img width="1205" height="796" alt="image" src="https://github.com/user-attachments/assets/71e29bac-46bf-4461-aa79-68425eaa27fa" />

<br>
<br>
<br>

***Alternatively***
1.  Create a vivado project and add all the design module files from here.
2.  Add the block diagram file from the sources_1.zip to vivado to avoid manually setting up the block design.
3.  Add the constraint file const_pynq to vivado.
4.  Generate the bitstream and export it.
5.  Create a platform project in vitis based on the generated hardware.
6.  Write application project C program for running.

<br>
<br>
<br>

***NOTE***
<br>
The implemented PSPI communication runs at 20.83 MHz.
<br>
The clock to the system is given by the clocking wizard outputting a 100 MHz clock.
<br>
This 100 MHz divide by 10 (because max_count set at 4) gives 10 MHz
<br>
This figure was achieved by setting the max_count variable = 4 i.e 5 different counts in the clk_gen.v module in the design file.
