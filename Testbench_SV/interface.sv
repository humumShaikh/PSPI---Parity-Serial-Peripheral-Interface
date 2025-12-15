interface intf(input bit Clk_in , input bit PGen);

       logic [7:0] Din;
       logic [1:0] SS;
       logic Run;
       logic Data_in;
       logic Dout;
       logic [3:0] Select;
       logic SCLK;
       logic sclk;
       logic err;
       logic [7:0] Pout;       
       
endinterface