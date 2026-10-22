`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 03:29:41 PM
// Design Name: 
// Module Name: sipo
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


module sipo
(
    input   wire            clk,
    input   wire            reset,
    input   wire            sin,
    output  wire    [07:00] out,
    output  reg             err
);

    
    reg [7:0]   p_out;
    assign out = p_out;
    
    
    reg [3:0]   rCounter;
    
    
    initial
    begin
        p_out <= 0;
        err <= 0;
        rCounter <= 9;
    end
    
    always @(negedge clk    or  posedge reset)
    begin
    
        if(reset == 1)
        begin
            p_out <= 0;
            err <= 0;
            rCounter <= 9;
        end
    
        else 
        begin
        
            if(rCounter > 1)
            begin
                p_out[rCounter-2] <= sin;
                rCounter <= rCounter - 1;
            end
            
            else if(rCounter == 1)
            begin
                err <= ~sin;
                rCounter <= rCounter - 1;
            end
            
            else
            begin
                rCounter <= 9;
            end
        
        end
    
    end

endmodule

