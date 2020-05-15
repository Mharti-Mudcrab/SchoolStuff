
PROGRAM _INIT
	// Feeder timer initialization
	TON_Timer.PT := T#2s;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF GoBtn THEN
		doConvMainStart := TRUE;
		TON_Timer.IN := TRUE;
		
		// Johans Feeder roundtable.
		IF FeedCount = 0 AND TON_Timer.Q THEN
			doFeederLeft := TRUE;
			doFeederRight := FALSE;
			FeedCount := 1;
			TON_Timer.IN := FALSE;
		ELSIF FeedCount = 1 AND TON_Timer.Q THEN
			doFeederMid := TRUE;
			doFeederLeft := FALSE;
			FeedCount := 2;
			TON_Timer.IN := FALSE;
		ELSIF FeedCount = 2 AND TON_Timer.Q THEN
			doFeederRight := TRUE;
			doFeederMid := FALSE;
			TON_Timer.IN := FALSE;
			FeedCount := 0;
		END_IF;
		
	ELSE
		// Reset all.
		doConvMainStart := FALSE;
		doFeederLeft := FALSE;
		doFeederMid := FALSE;
		doFeederRight := FALSE;
		TON_Timer.IN := FALSE;
	END_IF;
	 
	// Functionblock Calls
	TON_Timer();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

