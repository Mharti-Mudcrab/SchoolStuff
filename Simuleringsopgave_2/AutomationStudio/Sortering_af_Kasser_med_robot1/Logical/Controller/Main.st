
PROGRAM _INIT
	doBeltMotor1 := TRUE;
	doBeltMotor2 := TRUE;
	doBeltMotor3 := TRUE;
	TON_Weight.PT := T#0.5s;
	
END_PROGRAM

PROGRAM _CYCLIC
	R_TRIG_Weight.CLK := diWeight_activated;
	F_TRIG_Weight.CLK := diWeight_activated;
	CTU_Small.CU := diEaterSmall;
	CTU_Medium.CU := diEaterMedium;
	CTU_Large.CU := diEaterLarge;
	
	// Box has entered the weight.
	IF R_TRIG_Weight.Q THEN
		// Default is we set timer to stop belt.
		TON_Weight.IN := TRUE;
		
		// Depending on bagage size, telling robot what to do.
		doRobotActivate := TRUE;
		IF diWeight_measurement < 5000 THEN
			doRobotMoveRight := TRUE;
		ELSIF diWeight_measurement < 7500 THEN
			doRobotMoveRight := FALSE;
		ELSE
			// Box can pass and Robot should do nothing.
			TON_Weight.IN := FALSE;
			doRobotActivate := FALSE;
		END_IF;
		
		// Setting correct light indicator
		IF diWeight_measurement < 5000 THEN
			doLightSmall := TRUE;
		ELSIF diWeight_measurement < 7500 THEN
			doLightMedium := TRUE;
		ELSE
			doLightLarge := TRUE;
		END_IF;
	END_IF;
	
	// Timer for box placement is done.
	IF TON_Weight.Q THEN
		// Box is in place to be picked up, stopping BeltMotor.
		doBeltMotor1 := FALSE;
		TON_Weight.IN := FALSE;
	END_IF;
	
	// Reset stuff.
	IF F_TRIG_Weight.Q THEN
		// Resetting lights.
		doLightSmall := FALSE;
		doLightMedium := FALSE;
		doLightLarge := FALSE;
		
		// Starting BeltMotor wether it's going or not.
		doBeltMotor1 := TRUE;
		
		// Setting Robot Activation to low
		doRobotActivate := FALSE;
	END_IF;
	
	
	// Update Counters.
	doEaterSmall := UINT_TO_WORD( CTU_Small.CV );
	doEaterMedium := UINT_TO_WORD( CTU_Medium.CV );
	doEaterLarge := UINT_TO_WORD( CTU_Large.CV );
	
	// Call Function Blocks.
	CTU_Small();
	CTU_Medium();
	CTU_Large();
	TON_Weight();
	R_TRIG_Weight();
	F_TRIG_Weight();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

