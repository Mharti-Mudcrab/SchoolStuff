
PROGRAM _INIT
		(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	R_TRIG_StackDone.CLK := diStackDone;
	R_TRIG_diGoBtn.CLK := diGoBtn;
	F_TRIG_BoxBlocked.CLK := diPlateBoxBlocked;
	R_TRIG_StackerCount.CLK := diStackerInputSensor;
	F_TRIG_StackDone.CLK := diStackDone;
	
	IF diGoBtn THEN
		// Stop belt when box is exactly in place.
		doStackerInputBelt := NOT diStackerInputSensor;
		
		// Increase count on rising edge.
		IF R_TRIG_StackerCount.Q THEN
			stackCount := stackCount +1;
		END_IF;
		
		// Initiate plate serving in start of program.
		IF R_TRIG_diGoBtn.Q THEN
			doConvSideStart := TRUE;
		END_IF;
		
		// Move output belt when the stack is stacked,
		IF R_TRIG_StackDone.Q THEN
			doConvSideStart := TRUE;
		END_IF;
		// and stop it again.
		IF F_TRIG_BoxBlocked.Q THEN
			doConvSideStart := FALSE;
			// Reset count according to wether a block is ready for pickup or not.
			IF diStackerInputSensor THEN
				stackCount := 1;
			ELSE
				stackCount := 0;
			END_IF;
			
			// Reset for stackers
			IF diStackDone THEN
				doResetStackers := TRUE;
			END_IF;
		END_IF;
		
		// Activate stackers
		doStackerPick := diStackerInputSensor AND
						 NOT (stackCount > 8) AND 
						 NOT doConvSideStart AND 
						 NOT diStackDone;
		
		// Reset stacker Reset
		IF F_TRIG_StackDone.Q THEN
			doResetStackers := FALSE;
		END_IF;
	ELSE
		// Reset all.
		doStackerPick := FALSE;
		doConvSideStart := FALSE;
		doStackerInputBelt := FALSE;
		stackCount := 0;
	END_IF;
	 
	// Functionblock Calls
	R_TRIG_StackDone();
	R_TRIG_diGoBtn();
	F_TRIG_BoxBlocked();
	R_TRIG_StackerCount();
	F_TRIG_StackDone();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

