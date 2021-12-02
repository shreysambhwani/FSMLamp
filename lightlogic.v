`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 03:06:11 PM
// Design Name: 
// Module Name: lightlogic
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


module lightlogic(
    input up, down, left, right, clk, en, clr,
    output [3:0] presentstate
);
    wire [3:0] presentstatedffin;
    wire ps1, p2, ps3, ps0, in1, in2 , in0, in3;
    //wire[3:0] check;
    //assign check[3]=up;
    //assign check[2]=down;
    //assign check[1]=left;
    //assign check[0]=right;
    wire [1:0] bitcheck2;
    encode_4_to_2 encode(right,left,down,up,bitcheck2[0],bitcheck2[1]);
    //Ps3
   // and(presentstatedffin[3], presentstate[2], presentstate[1], bitcheck2[1], !bitcheck2[0]);
    assign presentstatedffin[3] = (~ps3 & ps2 & ps1 & in2) | (ps3 & ~ps2 & ~ps1 & ~ps0 & ~in3 & ~in2 & ~in1 & ~in0);
    //ps2
    assign presentstatedffin[2]=(~ps3 & ~ps2 & ps1 & in2) | (~ps3 & ps2 & ~ps1 & ~in3) | (~ps3 & ps2 & ps1 & ~in2);
//    or(presentstatedffin[2],abit2, bbit2, cbit2, dbit2);
//    and(abit2, presentstate[2], !bitcheck2[1]);
//    and(bbit2, presentstate[2], !presentstate[1], !bitcheck2[0]);
//    and(cbit2, presentstate[2], presentstate[1], presentstate[0]);
//    and(dbit2, !presentstate[2], presentstate[1], bitcheck2[1], !bitcheck2[0]);
//    //ps1
    assign presentstatedffin[1] = (~ps3 & ~ps1 & in2) | (~ps3 & ps1 & ~in3 & ~in2) | (~ps3 & ps2 & ~ps1 & in3);
//    or(presentstatedffin[1],abit1, bbit1, cbit1);
//    and(abit1, presentstate[1], !bitcheck2[1]);
//    and(bbit1, presentstate[2], !presentstate[1], bitcheck2[1]);
//    and(cbit1, !presentstate[3], !presentstate[1], bitcheck2[1], !bitcheck2[0]);
//    //ps0
    assign presentstatedffin[0] = (~ps3 & in0) | (~ps3 & ps0 & ~in2 & ~in1) | (~ps3 & ~ps2 & ps0 & ~in1) | (~ps3 & ~ps1 & ps0 & ~in1);
//    or(presentstatedffin[0],abit0, bbit0, cbit0, dbit0);
//    and(abit0, !presentstate[3],!bitcheck2[1], !bitcheck2[0]);
//    and(bbit0, !presentstate[2], presentstate[0], !bitcheck2[0]);
//    and(cbit0, !presentstate[1], presentstate[0], !bitcheck2[0]);
//    and(dbit0, presentstate[0], bitcheck2[1], bitcheck2[0]);

    assign in3=up;
    assign in2=down;
    assign in1=left;
    assign in0=right;
    
    assign ps3=presentstate[3];
    assign ps2=presentstate[2];
    assign ps1=presentstate[1];
    assign ps0=presentstate[0];
    
    
    





    dff(presentstate[3], presentstatedffin[3], clk, en, clr);
    dff(presentstate[2], presentstatedffin[2], clk, en, clr);
    dff(presentstate[1], presentstatedffin[1], clk, en, clr);
    dff(presentstate[0], presentstatedffin[0], clk, en, clr);

endmodule

