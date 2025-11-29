module parity_gen(
    input wire run,
    input wire en,
    input wire [7:0] pgin,
    output reg [7:0] pgout
    );

    reg [7:0] data_reg = 0;
   
    initial pgout <= 0;
   
   always @(*) begin
        data_reg <= pgin;
   end
   
   always @(*) begin
        if(en==1) begin
            pgout[7] <= data_reg[6];
            pgout[6] <= data_reg[5];
            pgout[5] <= data_reg[4];
            pgout[4] <= data_reg[3];
            pgout[3] <= data_reg[2];
            pgout[2] <= data_reg[1];
            pgout[1] <= data_reg[0];
            pgout[0] <= data_reg[6]^data_reg[5]^data_reg[4]^data_reg[3]^data_reg[2]^data_reg[1]^data_reg[0];
        end
        else begin
            pgout <= pgin;
        end
   end
   
endmodule