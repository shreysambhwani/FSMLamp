`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 04:46:04 PM
// Design Name: 
// Module Name: testboard
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


module board(
  input up, 
  input down, 
  input right,
  input left,
  input clk,
  input rst,
  //input btnD,
  input echo,
  output trig,
 // output reg[7:0] ledMap,
  output ready,
  output [6:0] seg,
  output [3:0] an,
  input sw,
  //output ledwithin,
  //output [7:0] led8,
  output [6:0] sevensegVal,
  output [1:0] state,
  output reg3Val1,
  output reg3Val2,
  output moveservo,
  output [7:0] led8,
  output buttonPressed);
  //reg ledwithin;
  wire [21:0] distance;
  wire measure, measure_single, measure_cont;
  reg[0:3] counterLed;
  reg [9:0] distance10cyc;
  wire clknew;
  //wire reg3Val;
  wire [7:0] regVal3;
  always@(posedge clk)
    begin
        counterLed<=(counterLed + 4'b0001)%10;
        distance10cyc[counterLed]<= !distance[16];
    end
  
    assign buttonPressed = upone|downone|leftone|rightone; //upSig | downSig | leftSig | rightSig;
    
    wire uphold,upone,updownone,downhold,downone,downdownone, lefthold, leftone, downleftone, righthold,rightone,downrightone; 
    
    PushButton_Debouncer debounce1(clk,up,uphold, upone, updownone); 
    PushButton_Debouncer debounce2(clk,down,downhold, downone, downdownone); 
    PushButton_Debouncer debounce3(clk,left,lefthold, leftone, downleftone);
    PushButton_Debouncer debounce4(clk,right,righthold, rightone, downrightone);
    
    wire hasReachedEightOne; 
    assign hasReachedEightOne = !outputstate[3] & !outputstate[2] & !outputstate[1] & !outputstate[0];
   
    wire[7:0] configData;
    
    Wrapper maincontrol(clknew,rst,buttonPressed,reg3Val1, reg3Val2, regVal3,hasReachedEightOne,configData); 
    clk_wiz_0 newclock(.reset(rst),.clk_in1(clk),.clk_out1(clknew)); 
   

    
  
//  reg clockTest=0; 
//  reg[5:0] counter =0; 
//  assing CounterLimit = 
//  always @(posedge clk) begin 
//    if(counter< CounterLimit)
//        counter <= counter +1; 
//    else begin 
//        counter <= 0; 
//        clockTest <= ~clockTest;
//        end 
// end    
//wire clknew; 
//clk_wiz_0 newclock(.reset(rst),.clk_in1(clk),.clk_out1(clknew)); 
//  always@(posedge clknew)
//    begin
//        ledwithin <= &distance10cyc; 
//    end         

// reg[7:0] ledMap; 
 
  assign moveservo = regVal3 == 8'b00000101;
  sevenseg displayVal(regVal3,sevensegVal);
 
  wire upSig; 
  debouncer upbtn(clk, rst, up, upSig);
  wire leftSig; 
  debouncer upbtn1(clk, rst, left, leftSig);
  wire rightSig; 
  debouncer upbtn2(clk, rst, right, rightSig);
  wire downSig; 
  debouncer upbtn3(clk, rst, down, downSig);  
  
  
 
 //assing led1 = 
  wire [3:0] outputstate;
  assign measure = measure_single | measure_cont;
 // assign led = distance[20:16];

  assign ledwithin = distance[16];//distance[20:0] < 21'd65535;
  lightlogic logic(upSig, downSig, leftSig, rightSig, clk, 1'b1, 1'b0, outputstate);
  decoder48(led8, outputstate,configData);
  refresher250ms contMeA(clk, sw, measure_cont);
  ssdController4 ssdCntr(clk, rst, 4'b1111, distance[15:12], distance[11:8], distance[7:4], distance[3:0], seg, an);
  debouncer dbbtn(clk, rst, btnD, measure_single);
  hc_sr04 uut(clk, rst, measure, state, ready, echo, trig, distance);
endmodule