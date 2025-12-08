//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// Design Name: sipo
// Module Name: sipo
// Project Name: PSPI - Master
// Target Devices: xc7s50csga324-1 (Boolean Board by Real Digital)
// Description:    Serial In Parallel Out Shift Register for the PSPI Master , takes the data through the MISO pin serially and outputs it parallely on the onboard LEDs 
// Dependencies: (clk_gen) for clocking
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////

module sipo(
    input wire clk,
    input wire din,
    output reg [7:0] pout,
    output reg err
    );
   
    reg signed [4:0] counter = 7;
   
    initial pout <= 0;
    initial err <= 0;
   
    always @(negedge clk) begin
        if(counter>=0) begin
            pout[counter] <= din;
            counter <= counter-1;
        end
        else if(counter<0) begin
            if(counter==-1) begin
                if(din==1) begin
                    err <= 0;
                end
                else if(din==0) begin
                    err <= 1;
                end
                counter = counter-1;
            end
            else if(counter==-2) begin
                counter <= 7;
            end
        end
    end
   
endmodule
