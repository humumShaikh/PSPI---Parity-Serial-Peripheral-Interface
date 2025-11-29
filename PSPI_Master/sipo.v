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