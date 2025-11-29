module piso(
    input wire [7:0] din,
    input wire clk,
    output reg dout
    );
   
    reg signed [4:0] counter = 7;
    reg [7:0] data_reg = 0;
   
    initial dout = 0;
   
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