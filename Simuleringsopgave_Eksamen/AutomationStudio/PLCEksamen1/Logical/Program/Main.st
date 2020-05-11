
PROGRAM _INIT
	(* Init værdier for alt i programmet *)
	
	doGoBtn := FALSE; // input fra experior
	diPos1OutOfPlace := FALSE; // input fra experior weight 1
	diPos2OutOfPlace := FALSE; // input fra experior weight 2
	diConvMainRunning := FALSE; // input fra experior om bånd status på hovedbånd
	diConvSideRunning := FALSE; // input fra experior om bånd status på afleverings bånd
	doConvMainStart := FALSE; // output til experior
	ConvMainStop := FALSE;
	doRobotToPos1 := FALSE; // output til robot
	doRobotToPos2 := FALSE; // output til robot
	Timer.PT := T#2s;
	TimerSideConv.PT := T#4s;

	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Go knappen som starter hele programmet*)
	IF doGoBtn = TRUE AND ConvMainStop = FALSE THEN
		doConvMainStart := TRUE;
		Timer.IN := TRUE;
		
	ELSIF doGoBtn = TRUE AND ConvMainStop = TRUE THEN
		doConvMainStart := FALSE;
		Timer.IN := FALSE;
		
	ELSIF doGoBtn = FALSE AND ConvMainStop = TRUE THEN
		ConvMainStop := FALSE;
		doConvMainStart := FALSE;
		
	ELSE
		ConvMainStop := TRUE;
		Timer.IN := FALSE;
	END_IF;
	(*Hvis der trykkes stop eller bliver sendt stop signal skal båndet stoppe.*)
	//IF diConvMainStop = TRUE THEN
	//diConvMainStart := FALSE;
	//diConvMainStop := FALSE;
	//END_IF;
	
	IF diConvMainRunning = TRUE AND diPos1OutOfPlace = TRUE AND diPos2OutOfPlace = FALSE THEN
		doRobotToPos1 := TRUE;
		doSorterPick := TRUE;
	ELSE
		doRobotToPos1 := FALSE;
	END_IF;
	IF diConvMainRunning = TRUE AND diPos2OutOfPlace = TRUE AND diPos1OutOfPlace = FALSE THEN
		doRobotToPos2 := TRUE;
		doSorterPick := TRUE;
	ELSE
		doRobotToPos2 := FALSE;
	END_IF;	
	IF diConvMainRunning = TRUE AND diPos2OutOfPlace = TRUE AND diPos1OutOfPlace = TRUE THEN
		ConvMainStop := TRUE;
		doRobotToPos1 := TRUE;
		doSorterPick := TRUE;
		
		IF SorterRobot.Delivering = TRUE THEN
			doRobotToPos1 := FALSE;
			doRobotToPos2 := TRUE;
			SorterRobot.Delivering := FALSE;
			
			IF SorterRobot.Delivering = TRUE THEN
				doRobotToPos2 := FALSE;
				ConvMainStop := FALSE;
			END_IF;
			
		END_IF;	

	END_IF;
	// denne IF sætning styrer fodning af kasser. tæller op til 2, går derefter ned til 0 igen og starter forfra. stiger 1 hver gang Timer.Q pulser.
	IF FeedCount = 0 AND Timer.Q THEN
		doFeederLeft := TRUE;
		doFeederRight := FALSE;
		FeedCount := FeedCount+1;
		Timer.IN := FALSE;
	ELSIF FeedCount = 1 AND Timer.Q THEN
		doFeederMid := TRUE;
		doFeederLeft := FALSE;
		FeedCount := FeedCount+1;
		Timer.IN := FALSE;
	ELSIF FeedCount = 2 AND Timer.Q THEN
		doFeederRight := TRUE;
		doFeederMid := FALSE;
		Timer.IN := FALSE;
		FeedCount := 0;
	END_IF;
	//stacker kontrol kode
	IF toPicker.Q THEN
		toBePicked := toBePicked+1;
	END_IF;
	IF toBePicked = 1 THEN
		doStackerLeft := TRUE;
		IF pickerRobotLeft.Getting = TRUE OR pickerRobotLeft.Delivering = TRUE THEN
			doStackerRight := TRUE;
		END_IF;
	ELSIF toBePicked <= 2 THEN
		doStackerPick := TRUE;
	END_IF;
	IF toBePicked <= 1 AND leftTrig.Q THEN
		toBePicked := toBePicked-1;
	ELSIF toBePicked >= 1 AND rightTrig.Q THEN
		toBePicked := toBePicked-1;
	END_IF;
	IF stackingTrig.Q THEN
		doConvSideStart := TRUE;
		TimerSideConv.IN := TRUE;
	ELSIF diConvSideRunning = TRUE AND TimerSideConv.Q THEN
		doConvSideStart := FALSE;
		TimerSideConv.IN := FALSE;
	END_IF;
	
	TimerSideConv();
	Timer();
	toPicker(CLK := diPickingSensor);
	stackingTrig(CLK := Stacked);
	rightTrig (CLK := pickerRobotRight.Delivering)
	leftTrig (CLK := pickerRobotLeft.Delivering)
			END_PROGRAM

			PROGRAM _EXIT
			(* Insert code here *)
	 
			END_PROGRAM

