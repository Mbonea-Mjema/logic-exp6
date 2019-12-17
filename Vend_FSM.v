module Vend_FSM(
     clock,
     reset,
     coin,
	  _choice,
     _cancel,
     vend,
     state,
     _change
    
);



integer count =0;

input clock;
input reset;
input _cancel;
input [1:0]coin;
input [3:0]_choice;

output [3:0]vend;
output [5:0]state;
output [2:0]_change;

//states trackers
reg [5:0]next_state,state,change_state;
reg [3:0]vend_enable;
reg [2:0]_change;
reg [3:0]vend=0;

//coins
parameter  [2:0]P_10=3'b010;
parameter  [2:0]P_20=3'b100;

parameter  [5:0]s_0=6'b0000000;
parameter  [5:0]s_10=6'b0000010;
parameter  [5:0]s_20=6'b0000100;
parameter  [5:0]s_30=6'b0001000;
parameter  [5:0]s_40=6'b0010000;
parameter  [5:0]s_50=6'b0100000;


// vend output

parameter [3:0]snack =4'b1000;
parameter [3:0]coffe =4'b0100;
parameter [3:0]drink =4'b0010;
parameter [3:0]candy =4'b0001;


integer i ;




// continue to next state
always @(posedge clock or posedge reset or posedge _cancel) begin
    if (reset) begin
        state<=s_0;
    end else begin
        state<=next_state;
    end

    
end

always @(coin or state) begin
   
    // update the state 
    case (state)
    s_0 :begin

     if (coin==P_10) begin
        next_state <= s_10;
        vend_enable = 0;
        end
    else if(coin==P_20)begin
        next_state <= s_20;
        vend_enable = 0;
        end
    end


    s_10:begin
        if (coin==P_10) begin
          next_state <= s_20;  
        end else begin
        if(coin==P_20)
            next_state <= s_30;
            vend_enable <=  snack|candy;
        end
    end

    s_20:begin
        if (coin==P_10) begin
          next_state <= s_30;  
          vend_enable <=  snack|candy;
        end else begin
        if(coin==P_20)
            next_state <= s_40;
            vend_enable <=  drink|candy|snack|coffe;
        end
    end
    s_30:begin
        if (coin==P_10) begin
          next_state <= s_40;  
          vend_enable <=  drink|candy|snack|coffe;
        end else begin
        if(coin==P_20)
            next_state <= s_50;
            vend_enable <=  drink|candy|snack|coffe;
        end
    end
        
    endcase
end

always @(vend_enable) begin
vend <=vend_enable&_choice;
//calculate change

if (vend==coffe| vend == drink)
change_state = s_40;
else if (vend==candy| vend == snack)
change_state = s_30;
else
change_state=0;

if(vend)begin
reg stop = 1'b0;

for ( i= 0; i<=5;i=i+1) begin
if(!change_state[i] & (~stop))
count=count+1;
else
stop =1'b1;
end

_change <= state>>count;

end

end



endmodule // Vend_FSM