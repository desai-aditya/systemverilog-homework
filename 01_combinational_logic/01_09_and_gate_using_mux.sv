module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module and_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  // TODO

  // Implement and gate using instance(s) of mux,
  // constants 0 and 1, and wire connections
  wire t;
  mux m1(.d0(0),.d1(1),.sel(a),.y(t));
  mux m2(.d0(0),.d1(t),.sel(b),.y(o));

endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  and_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        if (o !== (a & b))
          begin
            $display("FAIL %s", `__FILE__);
            $display("++ INPUT    => {a:%h, b:%h, i:%h, j:%h}", a, b, i, j);
            $display("++ EXPECTED => {o:%h}", a & b);
            $display("++ ACTUAL   => {o:%h}", o);
            $fatal(1, "Test Failed");
          end
      end

      $display ("PASS %s", `__FILE__);
      $finish;
    end

endmodule
