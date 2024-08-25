module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

  // TODO

  wire [3:0]t1;
  wire [3:0]t2;
  // Implement mux_4_1 using three instances of mux_2_1
  mux_2_1 m1 (.d0(d0), .d1(d1), .sel(sel[0]), .y(t1));
  mux_2_1 m2 (.d0(d2), .d1(d3), .sel(sel[0]), .y(t2));
  mux_2_1 m3 (.d0(t1), .d1(t2), .sel(sel[1]), .y(y));

endmodule

//----------------------------------------------------------------------------

module testbench;

  logic [3:0] d0, d1, d2, d3;
  logic [1:0] sel;
  logic [3:0] y;

  mux_4_1 inst
  (
    .d0  (d0), .d1 (d1), .d2 (d2), .d3 (d3),
    .sel (sel),
    .y   (y)
  );

  task test
    (
      input [3:0] td0, td1, td2, td3,
      input [1:0] tsel,
      input [3:0] ty
    );

    { d0, d1, d2, d3, sel } = { td0, td1, td2, td3, tsel };

    # 1;

    if (y !== ty)
      begin
        $display("FAIL %s", `__FILE__);
        $display("++ INPUT    => {d0:%h, d1:%h, d2:%h, d3:%h, sel:%d}", d0, d1, d2, d3, sel,);
        $display("++ EXPECTED => {y:%h}", ty);
        $display("++ ACTUAL   => {y:%h}", y);
        $fatal(1, "Test Failed");
      end

  endtask

  initial
    begin
      test ('ha, 'hb, 'hc, 'hd, 0, 'ha);
      test ('ha, 'hb, 'hc, 'hd, 1, 'hb);
      test ('ha, 'hb, 'hc, 'hd, 2, 'hc);
      test ('ha, 'hb, 'hc, 'hd, 3, 'hd);

      test (7, 10, 3, 'x, 0, 7);
      test (7, 10, 3, 'x, 1, 10);
      test (7, 10, 3, 'x, 2, 3);
      test (7, 10, 3, 'x, 3, 'x);

      $display ("PASS %s", `__FILE__);
      $finish;
    end

endmodule
