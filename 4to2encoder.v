`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 03:29:07 PM
// Design Name: 
// Module Name: 4to2encoder
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


module encode_4_to_2(
    input d0,d1,d2,d3,
    output a0,a1
    );
wire x,y,z;
not g1(x,d2);
and g2(y,x,d1);
or g3(a0,y,d3);
or g4(a1,d2,d3);
endmodule
