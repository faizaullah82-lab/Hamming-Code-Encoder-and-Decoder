// Hamming Code Encoder

module hamming_encoder(input [3:0] data_in,output [6:0] data_out);

  wire p1,p2,p3;
  
  wire d1,d2,d3,d4;
  
  assign d1 = data_in[0];
  assign d2 = data_in[1];
  assign d3 = data_in[2];
  assign d4 = data_in[3];
  
  
  
  assign data_out = {d4,d3,d2,p3,d1,p2,p1};
  
  //p1 : positions 1,3,5,7
  
  assign p1 = d1 ^ d2 ^ d4;
  
  //p2 : positions 2,3,6,7
  
  assign p2 = d1 ^ d3 ^ d4;
  
  //p3 : positions 4,5,6,7
  
  assign p3 = d2 ^ d3 ^ d4;

endmodule


//Hamming Code Decoder

module hamming_decoder(input [6:0] code_in,output [3:0] data_out,output [2:0]
                       error_pos, output error_detected, output [6:0] corrected_code);
  
  wire d1,d2,d3,d4;
  wire p1,p2,p3;
  
  wire s1,s2,s3;
  
  wire [2:0] syndrome;
  
  reg [6:0] corrected;
  
  assign {d4,d3,d2,p3,d1,p2,p1} = code_in;
  
  assign s1 = p1 ^ d1 ^ d2 ^ d4;
  assign s2 = p2 ^ d1 ^ d3 ^ d4;
  assign s3 = p3 ^ d2 ^ d3 ^ d4;
  
  assign syndrome = {s3,s2,s1};
  
  assign error_pos = syndrome;
  
  assign error_detected = |syndrome;
  
  always@(*)
    begin
       corrected = code_in;
     case(syndrome)
        3'b000 : corrected = code_in; //no error;
        3'b001 : corrected = code_in ^ 7'b0000001;
        3'b010 : corrected = code_in ^ 7'b0000010;
        3'b011 : corrected = code_in ^ 7'b0000100;
        3'b100 : corrected = code_in ^ 7'b0001000;
        3'b101 : corrected = code_in ^ 7'b0010000;
        3'b110 : corrected = code_in ^ 7'b0100000;
        3'b111 : corrected = code_in ^ 7'b1000000;
     endcase
     end
  
      
      assign corrected_code = corrected;
      assign data_out [0] = corrected[2];
      assign data_out [1] = corrected [4];
      assign data_out [2] = corrected [5];
      assign data_out [3] = corrected [6];
      
      endmodule

