module demux(
    input wire [1:0] ss,
    input wire s,
    output reg [3:0] select
    );
   
    always @(*) begin
        if(ss==2'b00) begin
            select[3] <= 1;
            select[2] <= 1;
            select[1] <= 1;
            select[0] <= s;
        end
        else if(ss==2'b01) begin
            select[3] <= 1;
            select[2] <= 1;
            select[1] <= s;
            select[0] <= 1;
        end
        else if(ss==2'b10) begin
            select[3] <= 1;
            select[2] <= s;
            select[1] <= 1;
            select[0] <= 1;
        end
        else if(ss==2'b11) begin
            select[3] <= s;
            select[2] <= 1;
            select[1] <= 1;
            select[0] <= 1;
        end
    end
   
endmodule