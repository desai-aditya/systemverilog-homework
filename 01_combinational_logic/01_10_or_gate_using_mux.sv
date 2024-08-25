module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module or_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  // TODO

  // Implement or gate using instance(s) of mux,
  // constants 0 and 1, and wire connections
  wire t;
  mux m1(.d0(0),.d1(1),.sel(a),.y(t));
  mux m2(.d0(t),.d1(1),.sel(b),.y(o));


endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  or_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        $display ("TEST %b | %b = %b", a, b, o);

        if (o !== (a | b))
          begin
            $display("FAIL %s", `__FILE__);
            $display("++ INPUT    => {a:%h, b:%h, i:%h, j:%h}", a, b, i, j);
            $display("++ EXPECTED => {o:%h}", a | b);
            $display("++ ACTUAL   => {o:%h}", o);
            $fatal(1, "Test Failed");
          end
      end

      $display ("PASS %s", `__FILE__);
      $finish;
    end

endmodule
