
PROGRAM _INIT
	// Timer initialization
END_PROGRAM

PROGRAM _CYCLIC
	R_TRIG_Stacked.CLK := Stacked;
	R_TRIG_diGoBtn.CLK := diGoBtn;
	F_TRIG_BoxBlocked.CLK := diPlateBoxBlocked;
	R_TRIG_StackerCount.CLK := diStackerInputSensor;
	
	IF diGoBtn THEN
		// Stop belt when box is exactly in place.
		doStackerInputBelt := NOT diStackerInputSensor;
		
		// Activate stackers
		IF diStackerInputSensor THEN
			// Increase count on rising edge
			IF R_TRIG_StackerCount.Q THEN
	  			stackCount := stackCount +1;
			END_IF;
			
			doStackerPick := NOT (stackCount > 8) AND NOT doConvSideStart;
		ELSE
			doStackerPick := FALSE;
		END_IF;
		
		// Initiate plate serving
		IF R_TRIG_diGoBtn.Q THEN
			doConvSideStart := TRUE;
		END_IF;
		
		// Move output belt when the stack is stacked, and stop it again.
		IF R_TRIG_Stacked.Q THEN
			doConvSideStart := TRUE;
		END_IF;
		IF F_TRIG_BoxBlocked.Q THEN
			doConvSideStart := FALSE;
			// Reset count according to wether a block is ready for pickup or not
			IF diStackerInputSensor THEN
				stackCount := 1;
			ELSE
				stackCount := 0;
			END_IF;
		END_IF;
		
	ELSE
		// Reset all.
		doStackerPick := FALSE;
		doConvSideStart := FALSE;
		doStackerInputBelt := FALSE;
		stackCount := 0;
	END_IF;
	 
	// Functionblock Calls
	R_TRIG_Stacked();
	R_TRIG_diGoBtn();
	F_TRIG_BoxBlocked();
	R_TRIG_StackerCount();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

