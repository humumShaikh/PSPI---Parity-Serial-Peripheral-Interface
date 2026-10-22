`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 03:29:35 PM
// Design Name: 
// Module Name: piso
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


module piso
(
    input   wire            clk,
    input   wire            reset,
    input   wire    [07:00] min,
    output  wire            out
);

    
    reg [3:0]   tCounter;
    reg         s_out;
    assign out = s_out;
    
    initial
    begin
        tCounter <= 9;
        s_out <= 0;
    end
    
    always @(posedge clk    or  posedge reset)
    begin
    
        if(reset == 1)
        begin
            tCounter <= 9;
            s_out <= 0;
        end
        
        else
        begin
        
            if(tCounter > 1)
            begin
                s_out <= min[tCounter-2];
                tCounter <= tCounter - 1;
            end
            
            else if(tCounter == 1)
            begin
                s_out <= 0;
                tCounter <= tCounter - 1;
            end
            
            else
            begin
                tCounter <= 9;
            end      
        
        end  
        
    end
    


endmodule
