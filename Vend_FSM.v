module Vend_FSM(
     clock,
     reset,
     coin,
	  choice,
     cancel,
     state,
	  vend,
	  change);




	  
input clock;
input reset;
input cancel;
input [1:0]coin;
input [3:0]choice;
output [3:0]vend;
output [2:0]state;
output [2:0]change;

//states trackers

reg [2:0]next_state;
reg [2:0]change;
reg [3:0]vend;
reg [2:0]state;

//coins
parameter  [2:0]P_10=2'b01;
parameter  [2:0]P_20=2'b10;

parameter  [2:0]s_0 =3'b000;
parameter  [2:0]s_10=3'b001;
parameter  [2:0]s_20=3'b010;
parameter  [2:0]s_30=3'b011;
parameter  [2:0]s_40=3'b100;
parameter  [2:0]s_50=3'b101;


// vend output

parameter [3:0]snack =3'b0001;
parameter [3:0]coffe =3'b0010;
parameter [3:0]drink =3'b0100;
parameter [3:0]candy =3'b1000;




// continue to next state
always @(posedge clock ) begin 
	

if(clock)begin
if (vend)
state =3'b111;
else
state =state+ next_state;
end	

	
	
	
end

always @(coin) begin
 next_state <= s_0;
     case (state)
    s_0 :begin

     if (coin==P_10) begin
        next_state <= s_10;

        end
    else if(coin==P_20)begin
        next_state <= s_20;
        end
    end


    s_10:begin
        if (coin==P_10) begin
          next_state <= s_20;  
        end else begin
        if(coin==P_20)
            next_state <= s_30;
        end
    end

    s_20:begin
        if (coin==P_10) begin
          next_state <= s_30;  
        end else begin
        if(coin==P_20)
            next_state <= s_40;
        end
    end
    s_30:begin
        if (coin==P_10) begin
          next_state <= s_40;  
        end else begin
        if(coin==P_20)
            next_state <= s_50;
        end
    end
        
    endcase    
end

always @(state) begin
vend = 0;
     case (state)
    s_30:begin
        if (choice&(snack|candy)!=4'b0000)
		  vend=choice;
    end 
    endcase    
end










endmodule // Vend_FSM