# Hamming(7,4) Encoder and Decoder in Verilog

A Verilog implementation of Hamming(7,4) error detection and correction. Takes 4 bits of data, encodes it into a 7-bit codeword using even parity, and includes a decoder that can detect and correct a single-bit error using syndrome decoding.

## What's in this repo
- `design.sv` includes
   -`hamming_encoder module` - Encodes 4-bit input data into a 7-bit Hamming codeword
   -`hamming_decoder modeule` - Decodes a 7-bit codeword, computes the syndrome, and corrects a single-bit error if one is found
- `testbench.sv` includes
   - `tb_hamming_encoder_2  module` - Testbench with a channel model that flips a bit in the codeword to simulate transmission errors

## How it works

### Encoding

The 4 data bits are placed at positions 3, 5, 6, and 7 of the 7-bit codeword. Parity bits are placed at positions 1, 2, and 4, following the standard Hamming(7,4) layout:

| Position | 7  | 6  | 5  | 4  | 3  | 2  | 1  |
|----------|----|----|----|----|----|----|----|
| Bit      | d4 | d3 | d2 | p3 | d1 | p2 | p1 |

Each parity bit is calculated using XOR across the data bits that fall within its coverage group, so the total number of 1s in that group stays even:

- p1 covers positions 1, 3, 5, 7
- p2 covers positions 2, 3, 6, 7
- p3 covers positions 4, 5, 6, 7

### Decoding

The decoder recalculates each parity check on the received codeword. If a bit got flipped somewhere during transmission, one or more of these checks will fail, and the pattern of failures (the syndrome) points directly to the position of the flipped bit. A syndrome of `000` means no error. Any other value tells you exactly which bit to flip back.

### Channel model

Since Hamming(7,4) is built to fix exactly one flipped bit, the testbench uses XOR (not addition) to flip a single, specific bit position in the codeword before it reaches the decoder. This guarantees a clean single-bit error for testing, rather than accidentally corrupting multiple bits at once.

## Running the testbench

The testbench sets a 4-bit input, flips one bit in the encoded output, and confirms the decoder both detects and corrects the error. Simulate with your preferred Verilog simulator (tested using Riviera-PRO on EDA Playground).

## Notes

This project was built to understand Hamming code error correction at the RTL level, including how syndrome decoding maps back to bit position, and how a single XOR-based bit flip differs from other ways of corrupting data during simulation.
