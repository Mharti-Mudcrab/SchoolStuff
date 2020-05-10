
PROGRAM _INIT
	(* Init værdier for alt i programmet *)
	
	diGoBtn := FALSE; // input fra experior
	diPos1OutOfPlace := FALSE; // input fra experior weight 1
	diPos2OutOfPlace := FALSE; // input fra experior weight 2
	diConvMainRunning := FALSE; // input fra experior om bånd status på hovedbånd
	diConvSideRunning := FALSE; // input fra experior om bånd status på afleverings bånd
	diConvMainStart := FALSE; // output til experior
	diConvMainStop := FALSE; // output til experior
	doRobotToPos1 := FALSE; // output til robot
	doRobotToPos2 := FALSE; // output til robot
	Timer.PT := T#10s;

	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Go knappen som starter hele programmet*)
	IF diGoBtn = TRUE THEN
		diConvMainStart := TRUE;
		Timer.IN := TRUE;
	ELSE
		diConvMainStop := TRUE;
	END_IF;
	(*Hvis der trykkes stop eller bliver sendt stop signal skal båndet stoppe.*)
	IF diConvMainStop = TRUE THEN
			diConvMainStart := FALSE;
			diConvMainStop := FALSE;
	END_IF;
	IF diConvMainRunning = TRUE AND diPos1OutOfPlace = TRUE AND diPos2OutOfPlace = FALSE THEN
		doRobotToPos1 := TRUE;
	ELSE
		doRobotToPos1 := FALSE;
	END_IF;
	IF diConvMainRunning = TRUE AND diPos2OutOfPlace = TRUE AND diPos1OutOfPlace = FALSE THEN
		doRobotToPos2 := TRUE;
	ELSE
		doRobotToPos2 := FALSE;
	END_IF;	
	IF diConvMainRunning = TRUE AND diPos2OutOfPlace = TRUE AND diPos1OutOfPlace = TRUE THEN
		diConvMainStop := TRUE;
		doRobotToPos1 := TRUE;
		
		IF SorterRobot.Delivering = TRUE THEN
			doRobotToPos1 := FALSE;
			doRobotToPos2 := TRUE;
			SorterRobot.Delivering := FALSE;
			
			IF SorterRobot.Delivering = TRUE THEN
				doRobotToPos2 := FALSE;
			END_IF;
			
		END_IF;	
// denne IF sætning styrer fodning af kasser. tæller op til 2, går derefter ned til 0 igen og starter forfra. stiger 1 hver gang Timer.Q pulser.
	END_IF;
	IF FeedCount = 0 AND Timer.Q THEN
		doFeederLeft := TRUE;
		doFeederLeft := FALSE;
		FeedCount := FeedCount+1;
		Timer.IN := FALSE;
	ELSIF FeedCount = 1 AND Timer.Q THEN
		doFeederMid := TRUE;
		doFeederMid := FALSE;
		FeedCount := FeedCount+1;
		Timer.IN := FALSE;
	ELSIF FeedCount = 2 AND Timer.Q THEN
	
		doFeederRight := TRUE;
		doFeederRight := FALSE;
		Timer.IN := FALSE;
		FeedCount := 0;
	END_IF;

	IF toPicker.Q THEN
		toBePicked := toBePicked+1;
	END_IF;
	Timer();
	toPicker(CLK := diPickingSensor);
			END_PROGRAM

			PROGRAM _EXIT
			(* Insert code here *)
	 
			END_PROGRAM

