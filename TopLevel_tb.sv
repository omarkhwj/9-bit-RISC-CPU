// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//
// Verilog Test Fixture created for module: TopLevel

module TopLevel_tb;	     // Lab 17

// To DUT Inputs
  bit start;
  bit CLK;

// From DUT Outputs
  wire halt;		   // done flag

// Instantiate the Device Under Test (DUT)
  top DUT (
	.reset (start)           , 
	.clk  (CLK)            , 
	.done (halt)             
	);

initial begin
  start = 1;
// Initialize DUT's data memory
  #10ns for(int i=0; i<256; i++) begin
    DUT.dm1.guts[i] = 8'h0;	 // clear data_mem
    DUT.dm1.guts[1] = 8'h03;      // MSW of operand A
    DUT.dm1.guts[2] = 8'hff;
    DUT.dm1.guts[3] = 8'hff;      // MSW of operand B
    DUT.dm1.guts[4] = 8'hfb;
  end
// students may also pre_load desired constants into data_mem
// Initialize DUT's register file
  for(int j=0; j<8; j++)
    DUT.rf1.core[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file
    
// launch program in DUT
  #10ns start = 0;
// Wait for done flag, then display results
  wait (halt);
   #10ns $stop;			   
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
$display(
" r0 = %d \n r1 = %d \n r2 = %d \n r3 = %d \n \
r4 = %d \n r5 = %d \n r6 = %d \n r7 = %d \n PC = %d\n INSTR = %b\n",
		DUT.rf1.core[0],
                DUT.rf1.core[1],
                DUT.rf1.core[2],
                DUT.rf1.core[3],
					  DUT.rf1.core[4],
					  DUT.rf1.core[5],
					  DUT.rf1.core[6],
					  DUT.rf1.core[7],
		DUT.im1.PC,
DUT.im1.inst
);
end
      
endmodule

