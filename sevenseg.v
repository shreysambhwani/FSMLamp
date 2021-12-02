`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2021 01:03:41 PM
// Design Name: 
// Module Name: sevenseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenseg(
    input  [7:0]x,
    output reg [6:0]z
    );
always @*
case (x)
8'b00000000:      	//Hexadecimal 0
z = 7'b0111111;
8'b00000001:    		//Hexadecimal 1
z = 7'b0000110  ;
8'b00000010:  		// Hexadecimal 2
z = 7'b1011011 ; 
8'b00000011: 		// Hexadecimal 3
z = 7'b1001111 ;
8'b00000100: 		// Hexadecimal 4
z = 7'b1100110 ;
8'b00000101:		// Hexadecimal 5
z =7'b1101101 ;  
8'b00000110:		// Hexadecimal 6
z = 7'b1111100 ;
8'b0000111:		// Hexadecimal 7
z = 7'b0000111;
8'b00001000:     		 //Hexadecimal 8
z = 7'b1111111;
8'b00001001:     		//Hexadecimal 9
z = 7'b1100111 ;
8'b00001010:   		// Hexadecimal A
z = 7'b1110111 ;
8'b00001011:  		// Hexadecimal B
z = 7'b1111111 ;
8'b00001100: 		// Hexadecimal C
z = 7'b0111001 ;
8'b00001101: 		// Hexadecimal D
z = 7'b0111111 ;
8'b00001110: 		// Hexadecimal E
z = 7'b1111001 ;
8'b00001111: 		// Hexadecimal F
z = 7'b1110001 ;
endcase
 
endmodule
