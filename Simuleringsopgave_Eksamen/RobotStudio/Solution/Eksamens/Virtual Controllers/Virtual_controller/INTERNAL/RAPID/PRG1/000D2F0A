MODULE Module1
    CONST robtarget RightPick:=[[360.5,88.055,133.879],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right11:=[[305.5,-515.945,197.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right12:=[[305.5,-625.945,197.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right21:=[[305.5,-515.945,302.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Right22:=[[305.5,-625.945,302.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget RightHome:=[[243.5,-145.945,302.406],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR num stackCount := 1;
    VAR robtarget tempTarget;
    VAR speeddata speed := v7000;    
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
        MoveL RightHome, speed, z100, tool0;
            ! Move when There is and object and Left arm is not in the way.
        IF diStackerRightPick = 1 THEN
            WaitRob \InPos;
                ! picking up, Claiming Pickup token if available.
            IF doStackerLeftPickingUp = 0 THEN
                    ! Moving in to pick up while claiming Pickup token.
                SetDO doStackerRightPickingUp, 1;
                WaitDO doStackerRightPickingUp, 1;
                ! In case the left stacker is also entering this if at the same time, the right will wait.
                IF doStackerLeftPickingUp = 1 THEN
                    SetDO doStackerRightPickingUp, 0;
                    WaitDO doStackerRightPickingUp, 0;
                    ExitCycle;
                ENDIF
                MoveJ RightPick, speed, z100, tool0;
                MoveJ Offs(RightPick, 0, 0, -20), speed, z100, tool0;
                WaitRob \InPos;
                    ! Grippping with wait.
                SetDO doStackerRightGripper, 1;
                WaitDO doStackerRightGripper, 1;
                !WaitTime(0.5);
                    ! Moving out, unclaiming pickup token.
                MoveJ RightPick, speed, z100, tool0;
                MoveJ RightHome, speed, z100, tool0;
                WaitRob \InPos;
                SetDO doStackerRightPickingUp, 0;
                WaitDO doStackerRightPickingUp, 0;
                
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
                    TPWrite "Something went wrong.";
                ENDTEST
                stackCount := stackCount +1;
                IF stackCount > 4 THEN
                    stackCount := 1;
                ENDIF
                SetDO doStackerRightDelivering, 1;
                WaitDO doStackerRightDelivering, 1;
                MoveL tempTarget, speed, z100, tool0;
                WaitRob \InPos;
                SetDO doStackerRightGripper, 0;
                WaitDO doStackerRightGripper, 0;
                SetDO doStackerRightDelivering, 0;
                WaitDO doStackerRightDelivering, 0;
            ELSE
                TPWrite "Right Stacker wants to enter picup while Left is on it.";
            ENDIF
        ENDIF
    ENDPROC
ENDMODULE