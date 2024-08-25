module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

module not_gate_using_mux
(
    input  i,
    output o
);

  // Implement not gate using instance(s) of mux,
  // constants 0 and 1, and wire connections

  mux m(.d0(1'd1),.d1(1'd0),.y(o),.sel(i));
endmodule

//----------------------------------------------------------------------------

module xor_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  // TODO

  // Implement xor gate using instance(s) of mux,
  // constants 0 and 1, and wire connections

  wire t;
  not_gate_using_mux n(.i(a),.o(t));
  mux m(.d0(a),.d1(t),.sel(b),.y(o));
endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  xor_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        if (o !== (a ^ b))
          begin
            $display("FAIL %s", `__FILE__);
            $display("++ INPUT    => {a:%h, b:%h, i:%h, j:%h}", a, b, i, j);
            $display("++ EXPECTED => {o:%h}", a ^ b);
            $display("++ ACTUAL   => {o:%h}", o);
            $fatal(1, "Test Failed");

          end
      end

      $display ("PASS %s", `__FILE__);
      $finish;
    end

endmodule
