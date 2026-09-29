/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_<Son-nion> (
    input  wire [7:0] ui_in,    // 8 chân chỉ VÀO
    output wire [7:0] uo_out,   // 8 chân chỉ RA
    input  wire [7:0] uio_in,   // 8 chân hai chiều — giá trị ĐỌC VỀ
    output wire [7:0] uio_out,  // 8 chân hai chiều — giá trị ĐẨY RA
    output wire [7:0] uio_oe,   // chọn chiều: 1 = ra, 0 = vào
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
