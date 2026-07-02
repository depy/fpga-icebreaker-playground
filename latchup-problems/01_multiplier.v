// Stream-based solution component
//
// Input stream interface:
//   i_ready (output): Assert when ready to accept input
//   i_valid (input): Asserted when input data is valid
//   i_payload_* (input): Input payload fields
//
// Output interface:
//   o_valid (output): Assert when output data is valid
//   o_payload* (output): Output payload fields
//
// Handshaking: Data transfers when both ready and valid are high

module Solution (
  input wire clk,
  input wire reset,
  output wire i_ready,
  input wire i_valid,
  input wire [16-1:0] i_payload_a,
  input wire [16-1:0] i_payload_b,
  output wire [32-1:0] o_payload,
  output wire o_valid
);
  
// Define your design here
  
  assign i_ready = 1'b1;
  assign o_valid = i_valid;
  assign o_payload = i_payload_a * i_payload_b;
  
endmodule

