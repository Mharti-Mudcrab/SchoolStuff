(*Denne Type er de 3 stadier som vores robot arm kan befinde sig i.*)

TYPE
	RobotArm : 	STRUCT 
		Home : BOOL;
		Getting : BOOL;
		Delivering : BOOL;
	END_STRUCT;
END_TYPE
