`timescale 1ns / 1ps
module parking_system(
input clk,reset_n,
input sensor_entrance, sensor_exit,
input [3:0] password,
output wire GREEN_LED,RED_LED, output reg [3:0] countcar,
output reg [2:0] indicator
// output reg [6:0] saat,
// output reg [6:0] saati
);
parameter IDLE = 3'b000, WAIT_PASSWORD = 3'b001, WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011,STOP = 3'b100;
reg[2:0] current_state, next_state;
reg[31:0] counter_wait;                                                                                                                                                                                                                          
reg red_tmp,green_tmp;
reg [3:0] totalcars; 
always @(posedge clk or posedge reset_n)
begin
if(reset_n) begin
current_state = IDLE;
// countcar = 4'b0000;
end
else
current_state = next_state;
end
always @(posedge clk or posedge reset_n)
begin
if(reset_n)
counter_wait <= 0;
else if(current_state==WAIT_PASSWORD)
counter_wait <= counter_wait + 4'b0001;
else
counter_wait <= 0;
end

always @(*)
begin
case(current_state)
IDLE: begin
if(sensor_entrance == 1)
next_state = WAIT_PASSWORD;
if(sensor_entrance == 0)
next_state = IDLE;
//if(out == 1 && counter>=1)
//begin
//totalcars <= totalcars - 4'b0001;
//next_state = IDLE;
//end
//(out == 1 && counter<=0)
end
WAIT_PASSWORD: begin
if(counter_wait <= 3)
next_state = WAIT_PASSWORD;
else
begin
if(password==4'b1011)
begin
countcar <= countcar + 4'b0001;
next_state = RIGHT_PASS;
end
else
next_state = WRONG_PASS;
end
end
WRONG_PASS: begin
if(password==4'b1011)
begin
countcar <= countcar + 4'b0001;
next_state = RIGHT_PASS;
end
else
next_state = WRONG_PASS;
end
RIGHT_PASS: begin
if(sensor_entrance==1 && sensor_exit == 1) begin
next_state = STOP;
totalcars <= totalcars + 4'b0001;
end
else if(sensor_exit ==1) begin
next_state = IDLE;
countcar <= countcar + 4'b0001;
end
else
begin
//countcar <= countcar + 4'b0001;
next_state = RIGHT_PASS;
end
end
STOP: begin
if(password==4'b1011)
begin
countcar <= countcar + 4'b0001;
next_state = RIGHT_PASS;
end
else
next_state = STOP;
end
default: next_state = IDLE;
endcase
end

always @(posedge clk) begin
case(current_state)
IDLE: begin
green_tmp = 1'b0;
red_tmp = 1'b0;
indicator = 3'b000;
end
WAIT_PASSWORD: begin
green_tmp = 1'b0;
red_tmp = 1'b1;
indicator = 3'b001;
end
WRONG_PASS: begin
green_tmp = 1'b0;
red_tmp = ~red_tmp;
indicator = 3'b010;
end
RIGHT_PASS: begin
green_tmp = ~green_tmp;
red_tmp = 1'b0;
indicator = 3'b011;
end
STOP: begin
green_tmp = 1'b0;
red_tmp = ~red_tmp;
indicator = 3'b100;
end
endcase
end
assign RED_LED = red_tmp  ;
assign GREEN_LED = green_tmp;
//begin
//assign countcar[3] = totalcars[3];
//assign countcar[2] = totalcars[2];
//assign countcar[1] = totalcars[1];
//assign countcar[0] = totalcars[0];
//end
//Seven_segment_LED_Display_Controller g1(countcar);
endmodule
