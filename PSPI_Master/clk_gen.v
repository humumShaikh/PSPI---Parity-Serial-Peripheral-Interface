//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// Design Name: clk_gen
// Module Name: clk_gen
// Project Name: PSPI - Master
// Target Devices: xc7s50csga324-1 (Boolean)
// Description:    Clock generator for the PSPI Master , converts the boards inbuilt 100 MHz clock to a slower clock for PSPI operation
// Dependencies:
// Revision 0.01 - File Created
// Additional Comments:    The clock module is designed to only output 10 clock cycles that are required for a single transmission
//////////////////////////////////////////////////////////////////////////////////

module clk_gen(
    input wire run,                                        //the clock starts outputting the signal once the run signal goes high
    input wire clk_in,                                        //takes the board's onboard clock 
    output reg clk_out,                                        //outputs the desired clock frequency on SCLK
    output reg select,
    input wire error_control,                                    //The error control signal coming from outside is responsible for the retransmission initiation
    output reg prun
    );
 
    reg [3:0] tc = 0;                                //here the board we have used had a default board clock of 100MHz 
    reg [25:0] max_count = 25_000_000;            //change the max_count value to change the output frequency
    reg [25:0] counter = 0;
    reg [4:0] n = 0;
    reg set = 0;
   
   
    always @(*) prun <= run;
   
    initial begin
        clk_out <= 0;
        select <= 1;
    end
   
    always @(posedge clk_in) begin
        if(run) begin
            set <= 1;
            select <= 0;
            tc <= 0;
        end
        else if(n>=20) begin
            tc <= tc+1;
            if(error_control==0) begin
                set <= 0;
                select <= 1;
            end
            else if(error_control==1) begin
                if(tc==3) begin                        //tc is the transmission count which decides the max number of retries
                    set <= 0;
                    select <= 1;
                end
            end
        end
    end
   
    always @(posedge clk_in) begin
        if(n>=20) n <= 0;                            //The n indicates the number of times the clock signal negates itself
        else if((set) && (n<=20)) begin
            if(counter==max_count) begin
                clk_out <= ~clk_out;
                counter <= 0;
                n <= n+1;
            end
            else begin
                counter <= counter+1;
            end
        end
        else begin
            n <= 0;
            clk_out <= 0;
            counter <= 0;
        end
    end
     
endmodule
