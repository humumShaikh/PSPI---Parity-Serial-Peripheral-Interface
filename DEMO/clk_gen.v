`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 03:29:28 PM
// Design Name: 
// Module Name: clk_gen
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


module clk_gen
(
    input   wire            clkin,
    input   wire            reset,
    input   wire            run,
    input   wire            err,
    output  reg             clkout,
    output  reg             ss
);

    
    reg [26:00] cCounter;
    reg [26:00] maxCount;
    reg         clk_flag;
    reg [3:0]   tc;
    reg [4:0]   n;
    
    initial
    begin
        clkout <= 0;
        cCounter <= 0;
        maxCount <= 3;
        clk_flag <= 0;
        n <= 0;
        tc <= 0;
        ss <= 1;
    end
    
    
//    always @(posedge run    or  posedge clkin   or  posedge reset)
    always @(posedge clkin   or  posedge reset)  
    begin
        
        if(reset == 1)
        begin
            clkout <= 0;
            cCounter <= 0;
            maxCount <= 3;
            clk_flag <= 0;
            n <= 0;
            tc <= 0;
            ss <= 1;
        end
    
        else if(run == 1 &&  clk_flag == 0)
        begin
            
            clk_flag <= 1;
            ss <= 0;
                        
        end
        
        else
        begin
        
            if(clk_flag == 1    &&  n != 20)
            begin
                
                if(cCounter == maxCount)
                begin
                    cCounter <= 0;
                    clkout <= ~clkout;
                    n <= n + 1;
                end
                
                else
                begin
                    cCounter <= cCounter + 1;
                end
                
            end
            
            else if(n == 20)
            begin
                
                if(err == 1)
                begin
                    if(tc < 3)
                    begin
                        tc <= tc + 1;
                        clkout <= 0;
                        n <= 0;
                    end
                    
                    else
                    begin
                        clkout <= 0;
                        clk_flag <= 0;
                        n <= 0;
                        tc <= 0;
                        ss <= 1;
                    end
                end
                
                else
                begin
                    clkout <= 0;
                    clk_flag <= 0;
                    n <= 0;
                    tc <= 0;
                    ss <= 1;
                end

            end
        
        end
    end

endmodule
