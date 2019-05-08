// EE 361
// LEGLite 
// 
// The control module for LEGLite
//   The control will input the opcode value (3 bits)
//   then determine what the control signals should be
//   in the datapath
// 
//---------------------------------------------------------------

//		regdst,

module Control(
        reg2loc,
		branch,
		memread,
		memtoreg,
		alu_select,
		memwrite,
		alusrc,
		regwrite,
		opcode,
		state // Input added
		);

output reg2loc;
output branch;
output memread;
output memtoreg;
output [2:0] alu_select; // Select to the ALU
output memwrite;
output alusrc;
output regwrite;
input [2:0] opcode;
input [1:0] state;

reg reg2loc;
reg branch;
reg memread;
reg memtoreg;
reg [2:0] alu_select;
reg memwrite;
reg alusrc;
reg regwrite;

// alu select       operation
//          0       add
//          1       sub
//          2       pass input 1
//          3       or
//          4       and

always @(opcode or state)
	begin
        if (state == 1)
        begin
            case(opcode)
            0:			// ADD instruction
                begin
                reg2loc = 0;   // Pick 2nd reg field
                branch = 0;    // Disable branch
                memread = 0;   // Disable memory
                memtoreg = 0;  // Select ALU to write to memory
                alu_select = 0; // Have ALU do an ADD
                memwrite = 0;  // Disable memory
                alusrc = 0;    // Select register for input to ALU
                regwrite = 1;  // Write result back to register file
                end
            1:          // SUB
                begin
                reg2loc = 0;
                branch = 0;
                memread = 0;
                memtoreg = 0;
                alu_select = 1;
                memwrite = 0;
                alusrc = 0;
                regwrite = 1;
                end
            3:          // LD
                begin
                reg2loc = 1; // Don't care
                branch = 0;
                memread = 1;
                memtoreg = 1;
                alu_select = 0;
                memwrite = 0;
                alusrc = 1;
                regwrite = 1;
                end
            4:          // ST
                begin
                reg2loc = 1;
                branch = 0;
                memread = 0;
                memtoreg = 0; // Don't care
                alu_select = 0;
                memwrite = 1;
                alusrc = 1;
                regwrite = 0;
                end
            5:          // CBZ
                begin
                reg2loc = 1;
                branch = 1;
                memread = 0;
                memtoreg = 0; // Don't care
                alu_select = 2;
                memwrite = 0;
                alusrc = 0;
                regwrite = 0;
                end
            6:          // ADDI
                begin
                reg2loc = 0; // Don't care
                branch = 0;
                memread = 0;
                memtoreg = 0;
                alu_select = 0;
                memwrite = 0;
                alusrc = 1;
                regwrite = 1;
                end
            7:          // ANDI
                begin
                reg2loc = 0; // Don't care
                branch = 0;
                memread = 0;
                memtoreg = 0;
                alu_select = 4;
                memwrite = 0;
                alusrc = 1;
                regwrite = 1;
                end
            default:  // Note that default is unnecessary if all case 
                    //    values are considered
                begin
                reg2loc = 0;   
                branch = 0;    // Disable branch
                memread = 0;   
                memtoreg = 0;  
                alu_select = 0; 
                memwrite = 0;  // Disable memory
                alusrc = 0;    
                regwrite = 0;  // Disable regiter file
                end
            endcase
        end
        else
        begin
            reg2loc = 0;   
            branch = 0;    // Disable branch
            memread = 0;   
            memtoreg = 0;  
            alu_select = 0; 
            memwrite = 0;  // Disable memory
            alusrc = 0;    
            regwrite = 0;  // Disable regiter file
        end
    end
endmodule




