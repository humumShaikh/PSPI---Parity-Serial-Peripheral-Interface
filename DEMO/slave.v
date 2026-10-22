`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 03:30:10 PM
// Design Name: 
// Module Name: slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slave
(
    input   wire    [07:00] DIN,
    input   wire            SCLK,
    input   wire            MOSI,
    output  wire            MISO,
    input   wire            SS,
    output  wire    [07:00] SOUT
);

    
    reg [3:0]   txCounter;
    reg [3:0]   rxCounter;
    
    reg miso;
    assign MISO = miso;
    
    reg [7:0]   dataRx;
    assign  SOUT    =   dataRx;
    
    initial
    begin
        miso <= 0;
        dataRx <= 0;
        txCounter <= 9;
        rxCounter <= 9;
    end

    
    always @(posedge SCLK)
    begin
        if(SS == 0)
        begin
        
            if(txCounter > 1)
            begin
                miso <= DIN[txCounter-2];
                txCounter <= txCounter - 1;
            end
            
            else if(txCounter == 1)
            begin
                miso <= ~(^dataRx);
                txCounter <= txCounter - 1;
            end
            
            else if(txCounter == 0)
            begin
                miso <= 0;
                txCounter <= 9;
            end
        
        end
    end
    
    
    always @(negedge SCLK)
    begin
        if(SS == 0)
        begin
            
            if(rxCounter > 1)
            begin
                dataRx[rxCounter-2] <= MOSI;
                rxCounter <= rxCounter - 1;
            end
            
            else if(rxCounter == 1)
            begin
                rxCounter <= rxCounter - 1;
            end
            
            else if(rxCounter == 0)
            begin
                rxCounter <= 9;
            end
            
        end
    end

endmodule
