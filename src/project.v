`default_nettype none
module tt_um_son_nion (
    input  wire [7:0] ui_in,    // 8 chân chỉ VÀO
    output wire [7:0] uo_out,   // 8 chân chỉ RA
    input  wire [7:0] uio_in,   // 8 chân hai chiều — giá trị ĐỌC VỀ
    output wire [7:0] uio_out,  // 8 chân hai chiều — giá trị ĐẨY RA
    output wire [7:0] uio_oe,   // chọn chiều: 1 = ra, 0 = vào
    input  wire ena,
    input  wire clk,
    input  wire rst_n
);
  assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Gán biến tín hiệu đầu vào theo tả đề bài
    wire [3:0] A      = ui_in[3:0];     //
    wire [3:0] B      = ui_in[7:4];     //[cite: 1]
    wire [2:0] opcode = uio_in[2:0];    // Mã phép tính 3-bit (8 chức năng)[cite: 1]

    // Khai báo biến tạm cho kết quả phép tính và cờ Carry (5 bit để bắt nhớ Carry)
    reg [4:0] alu_raw;
    wire [3:0] result;
    wire carry;
    wire zero;

    // Mã hóa 8 phép tính
    always @(*) begin
        case (opcode)
            3'b000: alu_raw = {1'b0, A & B};      // 1. AND[cite: 1]
            3'b001: alu_raw = {1'b0, A | B};      // 2. OR[cite: 1]
            3'b010: alu_raw = {1'b0, A ^ B};      // 3. XOR[cite: 1]
            3'b011: alu_raw = {1'b0, ~A};         // 4. NOT (phép NOT A)[cite: 1]
            3'b100: alu_raw = {1'b0, A} + {1'b0, B}; // 5. Cộng (A + B)[cite: 1]
            3'b101: alu_raw = {1'b0, A} - {1'b0, B}; // 6. Trừ (A - B)[cite: 1]
            3'b110: alu_raw = {A, 1'b0};          // 7. Dịch trái (A << 1)[cite: 1]
            3'b111: alu_raw = {A[0], 1'b0, A[3:1]}; // 8. Dịch phải (A >> 1, bit tràn vào C)[cite: 1]
            default: alu_raw = 5'b00000;
        endcase
    end
    assign result = alu_raw[3:0];
    assign carry  = alu_raw[4];
    assign zero   = (result == 4'b0000) ? 1'b1 : 1'b0; // Cờ Z[cite: 1]
    assign uo_out[3:0] = result;       
    assign uo_out[4]   = carry;        //[cite: 1]
    assign uo_out[5]   = zero;         //[cite: 1]
    assign uo_out[7:6] = 2'b00;        // Các chân còn lại đặt mức LOW

endmodule
