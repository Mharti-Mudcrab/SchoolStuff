MODULE Module1
    CONST robtarget HomeRight:=[[243.5,-145.945,302.406],[0,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget PickRight:=[[360.5,88.055,133.879],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right11:=[[305.5,-515.945,197.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right12:=[[305.5,-625.945,197.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right21:=[[305.5,-515.945,302.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right22:=[[305.5,-625.945,302.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR num stackCount := 1;
    VAR robtarget tempTarget;
    !***********************************************************
    !
    ! Module:  Right Stacker robot
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: madsw
    ! Version: 1.0
    !
    !***********************************************************
    PROC main()
        MoveL HomeRight, v1000, z100, tool0;
            ! Move when There is and object and Left arm is not in the way.
        IF diStackerRightPick = 1 THEN
                ! picking up, Claiming Pickup token if available.
            IF doLeftPickingUp = 0 THEN
                    ! Moving in to pick up while claiming Pickup token.
                SetDO doRightPickingUp, 1;
                MoveJ PickRight, v1000, z100, tool0;
                MoveJ Offs(PickRight, 0, 0, -20), v1000, z100, tool0;
                    ! Grippping with wait.
                SetDO doStackerRightGripper, 1;
                !WaitTime(0.5);
                    ! Moving out, unclaiming pickup token.
                MoveJ PickRight, v1000, z100, tool0;
                MoveJ HomeRight, v1000, z100, tool0;
                SetDO doRightPickingUp, 0;
                
                    ! Pickup token unclaimed, and moving in to place block.
                TEST stackCount
                CASE 1:
                    tempTarget := Right12;
                CASE 2:
                    tempTarget := Right11;
                CASE 3:
                    tempTarget := Right22;
                CASE 4:
                    tempTarget := Right21;
                DEFAULT:
                    TPWrite "Something went wrong";
                ENDTEST
                stackCount := stackCount +1;
                IF stackCount > 4 THEN
                    stackCount := 1;
                ENDIF
                MoveL tempTarget, v1000, z100, tool0;
                WaitTime(0.5);
                SetDO doStackerRightGripper, 0;
                WaitTime(0.2);
            ELSE
                TPWrite "Right Stacker wants to enter picup while Left is on it.";
            ENDIF
        ENDIF
    ENDPROC
ENDMODULE