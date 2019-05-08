README for EE 361 HW 6

Name:
	Lance Hwang

Description of what I have completed:
	I have completed Stage 3.  I have included IM2.V.

Description of what I have in this folder:
	TO RUN Stage 3, SIMPLY OPEN THE FILE HW6.xpr IN THE HW6 FOLDER (hwanglance_ee361hw6/HW6/HW6.xpr) USING Vivado AND CLICK Run Simulation.



	If just opening the HW6.xpr file and then running the simulation does not work, then please check to see if the verilog files for Stage 3 described below are added to the project and that they are the only verilog files enabled.  I apologize for any inconvenience that may occur during this process.
	Not that I have personally opened the HW6.xpr file and then added all of the verilog files in the stage1 to stage3 folders as sources to the project and then disabled the irrelevant files not involved in Stage 3 so that by simply opening the HW6.xpr file with Vivado and then running the simulation, the simulation should run Stage 3 properly without needing any further modification.
	IN ORDER TO RUN STAGE 3, MAKE SURE THAT THE FOLLOWING VERILOG FILES ARE IN THE PROJECT, ARE ENABLED, AND ARE THE ONLY VERILOG FILES ENABLED.

From folder stage3:
IM2_edit.v
testbenchLEGLiteSingle-Stage3_edit.v

From folder stage2:
LEGLite-Control_edit.v
LEGLite-PC_edit.v
LEGLiteSingle_edit.v

From folder stage1:
Parts_edit.v

	If you open the HW6.xpr file contained in the HW6 folder (contained in hwanglance_ee361hw6) with Vivado, then these verilog files may already be enabled with all other verilog files disabled.



	IN THE EVENT THAT YOU WOULD LIKE TO SEE STAGE 2 RUN, MAKE SURE THAT THE FOLLOWING VERILOG FILES ARE IN THE PROJECT, ARE ENABLED, ARE ARE THE ONLY VERILOG FILES ENABLED.  AGAIN, THE FOLLOWING IS ONLY IF YOU WANT TO SEE STAGE 2 RUN, NOT STAGE 3. IF YOU WANT TO SEE STAGE 3 RUN, PLEASE REFER TO THE INFORMATION ABOUT RUNNING STAGE 3 ABOVE.

From folder stage2:
IM1_edit.v
LEGLite-Control_edit.v
LEGLite-PC_edit.v
LEGLiteSingle_edit.v
testbench-LEGLiteSingle-Stage2_edit.v

From folder stage1:
Parts_edit.v



	THE FOLLOWING IS A DESCRIPTION OF ALL OF THE VERILOG FILES CONTAINED IN FOLDERS stage1 TO stage3.

All files in folder stage3:
IM2_edit.v				// Used in Stage 3.  Contains instruction memory for Stage 3.
testbenchLEGLiteSingle-Stage3_edit.v	// Used in Stage 3.  Contains the testbench for the complete Stage 3.

All files in folder stage2:
IM1_edit.v				// Used in Stage 2.  Contains instruction memory for Stage 2.
LEGLite-Control_edit.v			// Used in Stages 3 and 2.  Contains the verilog module for the controller.
LEGLite-PC_edit.v			// Used in Stages 3 and 2.  The program counter increments by 4 when not branching and jumps according to the PC offset when branching.
LEGLiteSingle_edit.v			// Used in Stages 3 and 2.  Contains the main components of the single-cycle CPU and integrates several modules throughout the project.
testbench-Control_edit.v		// Not used in complete stages.  Used to test and analyze control module.
testbench-LEGLiteSingle-Stage2_edit.v	// Used in Stage 2.  Contains the testbench for the complete Stage 2.
testbench-PC_edit.v			// Not used in complete stages.  Used to test and analyze the program counter.

All files in folder stage1:
Parts_edit.v				// Used in Stages 3 and 2.  Contains various modules used throughout
testbench-Parts-CombCirc_edit.v		// Not used in complete stages.  Used to test and analyze some combinational circuit modules from Parts_edit.v.
testbench-Parts-Dmem_edit.v		// Not used in complete stages.  Used to test and analyze the data memory module.
testbench-Parts-RFile_edit.v		// Not used in complete stages.  Used to test and analyze the register file module.



	Elaboration: The verilog files are catagorized according to the stage each file was first used in.  This does not mean that verilog files in the stage1 folder are not used in Stages 2 and 3.  Similarly, this does not mean that the verilog files in the stage2 folder are not used in Stage 3.