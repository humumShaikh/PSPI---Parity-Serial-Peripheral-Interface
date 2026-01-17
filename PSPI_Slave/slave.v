//////////////////////////////////////////////////////////////////////////////////
// Company: CWIR3
// Engineer: copperwire
// Design Name: main_slave
// Module Name: main_slave
// Project Name: PSPI - Slave
// Target Devices: xc7s50csga324-1 (Boolean)
// Description:    Top module for the PSPI Slave 
// Dependencies:   None
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module slave(
    input wire [7:0] Pin,        //parallel Input
    output reg Sout,             //basically MISO
    input wire Sin,              //basically MOSI
    output reg [7:0] Pout,
    input wire SS,
    input wire EN,
    input wire clkin
    );
   
    reg signed [5:0] tcounter = 7;
    reg signed [5:0] rcounter = 7;
    reg parity = 0;
    reg [7:0] data_reg = 0;
       
    initial begin
        Sout <= 0;
        Pout <= 0;
    end
   
    always @(posedge clkin) begin
        if((SS==0) && (EN==1)) begin
            if(tcounter>=0) begin
                Sout = Pin[tcounter];
                tcounter = tcounter-1;
            end
            else if(tcounter==-1) begin
                Sout = parity;
                tcounter = tcounter-1;
            end
            else if(tcounter==-2) begin
                Sout <= 0;
                tcounter <= 7;
            end
        end
    end
   
    always @(negedge clkin) begin
        if((SS==0) && (EN==1)) begin
            if(rcounter>=0) begin
                Pout[rcounter] = Sin;
                data_reg[rcounter] = Sin;
                parity = ~(^data_reg);
                rcounter = rcounter-1;
            end
            else if(rcounter==-1) begin
                rcounter = rcounter-1;
            end
            else if(rcounter==-2) begin
                parity <= 0;
                rcounter <= 7;
            end
        end
    end
   
endmodule
