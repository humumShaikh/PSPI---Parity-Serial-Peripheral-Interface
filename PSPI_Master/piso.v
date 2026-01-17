//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// Design Name: piso
// Module Name: piso
// Project Name: PSPI - Master
// Target Devices: xc7s50csga324-1 (Boolean Board by Real Digital)
// Description:  Parallel In Serial Out shift register for the PSPI Master  
// Dependencies: (clk_gen for clocking) 
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////

module piso(
    input wire [7:0] din,
    input wire clk,
    output reg dout
    );
   
    reg signed [4:0] counter = 7;        //signed counter because the value is supposed to go below 0
    reg [7:0] data_reg = 0;
   
    initial dout = 0;                    //line ignored during synthesis
   
    always @(posedge clk) begin
        if(counter>=0) begin
            dout <= din[counter];
            counter <= counter-1;
        end
        else if(counter<0) begin
            if(counter==-1) begin
                dout <= 0;
                counter <= counter-1;
            end
            else if(counter==-2) begin
                counter <= 7;
            end
        end
    end
   
     
endmodule
