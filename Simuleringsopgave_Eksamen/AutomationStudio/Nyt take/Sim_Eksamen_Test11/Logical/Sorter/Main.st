
PROGRAM _INIT
	// Timer initialization
	TON_DelayTimer.PT := T#1s;
END_PROGRAM

PROGRAM _CYCLIC
	R_TRIG_RightPos.CLK := bigBoxDetected;
	R_TRIG_PickInitiated.CLK := sorterRobot.Delivering;
	// Detecting bigBox
	IF diWeightScale > 300 THEN
		bigBoxDetected := TRUE;
	ELSE
		bigBoxDetected := FALSE;
	END_IF;
		
	IF GoBtn THEN
		
		// Weight gets activated.
		IF R_TRIG_RightPos.Q  THEN
			// If it's notv right, then we pick
			TON_DelayTimer.IN := TRUE;
		END_IF;
		
		// Delay timer for activating Sorter
		IF TON_DelayTimer.Q THEN
			TON_DelayTimer.IN := FALSE;
			doSorterPick := TRUE;
		END_IF;
		
		// Delay timer for switching input off. (Might be error if Blocks are too close to one another)
		IF R_TRIG_PickInitiated.Q THEN
			doSorterPick := FALSE;
		END_IF;
		
	ELSE
		// Reset all.
		TON_DelayTimer.IN := FALSE;
		doSorterPick := FALSE;
		
	END_IF;
	 
	// Functionblock Calls
	TON_DelayTimer();
	R_TRIG_PickInitiated();
	R_TRIG_RightPos();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

