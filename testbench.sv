// Hamming Code Encoder Testbench with no error stimulus

module tb_hamming_encoder;
  
  reg [3:0] data_in;
  wire [6:0] data_out;
  
  wire [2:0] error_pos;
  
  wire [3:0] data_out_decoder;
  
  wire error_detected;
  
  wire [6:0] corrected_code;
  
  
  
  hamming_encoder dut(data_in,data_out);
  hamming_decoder dut2(data_out, data_out_decoder,error_pos,error_detected,corrected_code);
  
  initial
    begin
      data_in = 4'b1101;
      #1;
      $display("the value of data_out is %b",data_out);
      
      #10
      $display("the value of data_out is %b",error_pos);
    end
endmodule

// Hamming Code Encoder Testbench with error stimulus

module tb_hamming_encoder_2;
  
  reg [3:0] data_in;
  wire [6:0] data_out;
  reg [2:0] flip_pos;
  
  wire [6:0] data_out_temp;
  
  wire [2:0] error_pos;
  
  wire [3:0] data_out_decoder;
  
  wire error_detected;
  
  wire [6:0] corrected_code;
  
  assign data_out_temp = data_out ^ (7'b0000001 << flip_pos);
  
  hamming_encoder dut(data_in,data_out);
  hamming_decoder dut2(data_out_temp, data_out_decoder,error_pos,error_detected,corrected_code);
  
  initial
    begin
      data_in = 4'b1101;
     for (flip_pos = 0; flip_pos < 7; flip_pos = flip_pos + 1)
      begin
        #1;
        $display("flip_pos=%0d data_out=%b data_out_temp=%b error_pos=%b corrected=%b",
                   flip_pos, data_out, data_out_temp, error_pos, corrected_code);
    end
    end
 
endmodule