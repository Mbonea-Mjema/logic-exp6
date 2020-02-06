module Vend_FSM(
     clock,
     reset,
     coin,
	  _choice,
     _cancel,
     product,
     state,
     _change,
	  return
);





input clock;
input reset;
input _cancel;
input [5:0]coin;
input [3:0]_choice;

output [5:0]state,return;
output [2:0]_change;

//states trackers
reg [5:0]next_state,state;
reg [2:0]_change;
reg [5:0]return;
//coins
parameter  [1:0]P_10=3'b01;
parameter  [1:0]P_20=3'b10;

parameter  [2:0]s_0 =3'b000;
parameter  [2:0]s_10=3'b001;
parameter  [2:0]s_20=3'b010;
parameter  [2:0]s_30=3'b011;
parameter  [2:0]s_40=3'b100;
parameter  [2:0]s_50=3'b101;


// vend output

parameter [3:0]snack =4'b00;
parameter [3:0]coffe =4'b01;
parameter [3:0]drink =4'b10;
parameter [3:0]candy =4'b11;


integer i ;




// continue to next state
always @(posedge clock,posedge reset,posedge clock ) begin
    if (reset) begin
        state=s_0;
    end 

	 if(clock) begin
        state=next_state;
	 end 
    
    if(_cancel)begin
	    return =state;
		state = s_0;
	end
	
	 
    
end

always @(coin) begin
   
	
	if (reset |_cancel)
	vend_enable = 0;
   
	
	
    case (state)
    s_0 :begin

	  
     if (coin==P_10) begin
        next_state = s_10;
        end
    else if(coin==P_20)begin
        next_state = s_20;
        end
    end


    s_10:begin
     
	  if (coin==P_10) begin
          next_state = s_20;  
        end else begin
        if(coin==P_20)
            next_state = s_30;
            vend_enable =  snack|candy;
        end
    end

    s_20:begin
        if (coin==P_10) begin
          next_state = s_30;  
          vend_enable =  snack|candy;
        end else begin
        if(coin==P_20)
            next_state = s_40;
            vend_enable =  drink|candy|snack|coffe;
        end
    end
    s_30:begin
        if (coin==P_10) begin
          next_state = s_40;  
          vend_enable =  drink|candy|snack|coffe;
        end else begin
        if(coin==P_20)
            next_state = s_50;
            vend_enable =  drink|candy|snack|coffe;
        end
    end
        
    endcase
	 
end



endmodule // Vend_FSM