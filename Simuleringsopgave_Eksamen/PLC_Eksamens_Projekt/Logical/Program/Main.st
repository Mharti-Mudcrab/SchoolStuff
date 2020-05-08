
PROGRAM _INIT
	(* Init værdier for alt i programmet *)
	
	goBtn := FALSE; // input fra experior
	pos1OutOfPlace := FALSE; // input fra experior weight 1
	pos2OutOfPlace := FALSE; // input fra experior weight 2
	convStart := FALSE; // output til experior
	convStop := FALSE; // output til experior
	robotToPos1 := FALSE; // output til robot
	robotToPos2 := FALSE; // output til robot
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Go knappen som starter hele programmet*)
	IF goBtn = TRUE THEN
		convStart := TRUE;
		SorterRobot.Home := TRUE;
		pickerRobotLeft.Home := TRUE;
		pickerRobotRight.Home := TRUE;
	ELSE
		convStop := TRUE;
	END_IF;
	(*Hvis der trykkes stop eller bliver sendt stop signal skal båndet stoppe.*)
	IF convStop = TRUE THEN
		convStart := FALSE;
	END_IF;
	IF SorterRobot.Home = TRUE AND pos1OutOfPlace = TRUE AND pos2OutOfPlace = FALSE THEN
		robotToPos1 := TRUE;
		IF SorterRobot.Delivering = TRUE AND Eater = TRUE THEN
			SorterRobot.Home := TRUE;
			SorterRobot.Delivering := FALSE;
		END_IF;
	END_IF;
	IF SorterRobot.Home = TRUE AND pos2OutOfPlace = TRUE AND pos1OutOfPlace = FALSE THEN
		
			robotToPos2 := TRUE;
			IF SorterRobot.Delivering = TRUE AND Eater = TRUE THEN
				SorterRobot.Home := TRUE;
				SorterRobot.Delivering := FALSE;
		END_IF;
	END_IF;	
	IF SorterRobot.Home = TRUE AND pos2OutOfPlace = TRUE AND pos1OutOfPlace = TRUE THEN
		convStop := TRUE;
		robotToPos1 := TRUE;
		IF SorterRobot.Delivering = TRUE AND Eater = TRUE THEN
			SorterRobot.Home := TRUE;
			robotToPos2 := TRUE;
			SorterRobot.Delivering := FALSE;
		END_IF;
		
	END_IF;
			END_PROGRAM

			PROGRAM _EXIT
			(* Insert code here *)
	 
			END_PROGRAM

