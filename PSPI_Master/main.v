module main(
    input wire Run,
    input wire Clk_in,
    input wire [7:0] Din,
    output wire Dout,
    output wire [3:0] Select,
    input wire Data_in,
    output wire [7:0] Pout,
    output wire err,
    output wire sclk,
    input wire PGen,
    input wire [1:0] SS,
    output wire SCLK
);

    wire g0,g1,g2,g3;
    wire [7:0] w;

    assign sclk = g0;
    assign err = g1;
    assign SCLK = g0;

    clk_gen CG(
        .run(Run),
        .clk_in(Clk_in),
        .clk_out(g0),
        .select(g3),
        .error_control(g1),
        .prun(g2)
    );
   
    piso SR(
        .din(w),
        .clk(g0),
        .dout(Dout)
    );
   
    sipo RS(
        .clk(g0),
        .din(Data_in),
        .pout(Pout),
        .err(g1)
    );
   
    parity_gen PG(
        .pgin(Din),
        .en(PGen),
        .run(g2),
        .pgout(w)
    );
   
    demux DMUX(
        .ss(SS),
        .s(g3),
        .select(Select)
    );
       
       
endmodule