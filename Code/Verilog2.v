
module Verilog2(
    input rst,
    input dir,
    input clk,
    input en,
    output reg [3:0] signal
    );
    
    
    localparam sig4 = 3'b001;
    localparam sig3 = 3'b011;
    localparam sig2 = 3'b010;
    localparam sig1 = 3'b110;
    localparam sig0 = 3'b000;
    
    
    reg [2:0] present_state, next_state;
    
    
    always @ (present_state, dir, en)
    begin
        
        case(present_state)
        
        sig4:
        begin
            
            if (dir == 1'b0 && en == 1'b1)
                next_state = sig3;
            else if (dir == 1'b1 && en == 1'b1)
                next_state = sig1;
            else 
                next_state = sig0;
        end  
        sig3:
        begin
           
            if (dir == 1'b0&& en == 1'b1)
                next_state = sig2;
            else if (dir == 1'b1 && en == 1'b1)
                next_state = sig4;
            else 
                next_state = sig0;
        end 
        sig2:
        begin
           
            if (dir == 1'b0&& en == 1'b1)
                next_state = sig1;
            else if (dir == 1'b1 && en == 1'b1)
                next_state = sig3;
            else 
                next_state = sig0;
        end 
        sig1:
        begin
          
            if (dir == 1'b0&& en == 1'b1)
                next_state = sig4;
            else if (dir == 1'b1 && en == 1'b1)
                next_state = sig2;
            else 
                next_state = sig0;
        end
        sig0:
        begin
            
            if (en == 1'b1)
                next_state = sig1;
            else 
                next_state = sig0;
        end
        default:
            next_state = sig0; 
        endcase
    end 
    
   
    always @ (posedge clk, posedge rst)
    begin
        if (rst == 1'b1)
            present_state = sig0;
        else 
            present_state = next_state;
    end
    
     
    always @ (posedge clk)
    begin
        if (present_state == sig4)
            signal = 4'b1000;
        else if (present_state == sig3)
            signal = 4'b0100;
        else if (present_state == sig2)
            signal = 4'b0010;
        else if (present_state == sig1)
            signal = 4'b0001;
        else
            signal = 4'b0000;
    end
endmodule
