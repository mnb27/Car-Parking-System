`timescale 1ns / 1ps
module tb_parking_system;

  
  reg clk;
  reg reset_n;
  reg sensor_entrance;
  reg sensor_exit;
  reg [3:0] password;

  wire GREEN_LED;
  wire RED_LED;
  wire [2:0] indicator;
  wire [3:0] countcar;

  parking_system uut (
  .clk(clk),
  .reset_n(reset_n),
  .sensor_entrance(sensor_entrance),
  .sensor_exit(sensor_exit),
  .password(password),
  .GREEN_LED(GREEN_LED),
  .RED_LED(RED_LED),
  .countcar(countcar),
  .indicator(indicator)
 );
 initial begin
 clk = 0;
 forever #10 clk = ~clk;
 end
 initial begin
 reset_n = 1'b0;
 sensor_entrance = 1'b0;
 sensor_exit = 1'b0;
 password = 4'b1001;

 #100;
      reset_n = 1'b0;
 #20;
 sensor_entrance = 1'b1;
 #1000;
 sensor_entrance = 1'b1;
 password = 4'b1011;
 
  #100;
      reset_n = 1'b0;
 #20;
 sensor_entrance = 1'b1;
 #1000;
 sensor_entrance = 1'b0;
 password = 4'b1011;
  #100;
      reset_n = 1'b1;
 #20;
 sensor_entrance = 1'b1;
 #1000;
 sensor_entrance = 1'b0;
 password = 4'b1011;
  #100;
      reset_n = 1'b0;
 #20;
 sensor_entrance = 1'b1;
 #1000;
 sensor_entrance = 1'b1;
 password = 4'b1011;
  #100;
      reset_n = 1'b0;
 #20;
 sensor_entrance = 1'b1;
 #1000;
 sensor_entrance = 1'b1;
 password = 4'b1111;
 #2000;
 sensor_exit =1'b1;

 end

endmodule
