MODULE Module1
    CONST robtarget LeftPick:=[[360.5,88.055,133.879],[0,1,0,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Left11:=[[415.5,-515.945,197.406],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Left12:=[[415.5,-625.945,197.406],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Left21:=[[415.5,-515.945,302.406],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Left22:=[[415.5,-625.945,302.406],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget LeftHome:=[[477.5,-145.945,302.406],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR num stackCount := 1;
    VAR robtarget tempTarget;
    VAR speeddata speed := v7000;
    !***********************************************************
    !
    ! Module:  Left Stacker robot
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: madsw
    ! Version: 1.0
    !
    !***********************************************************
    PROC main()
        MoveL LeftHome, speed, z100, tool0;
            ! Move when There is and object and Left arm is not in the way.
        IF diStackerLeftPick = 1 THEN
            WaitRob \InPos;
                ! picking up, Claiming Pickup token if available.
            IF doStackerRightPickingUp = 0 THEN
                    ! Moving in to pick up while claiming Pickup token.
                SetDO doStackerLeftPickingUp, 1;
                WaitDO doStackerLeftPickingUp, 1;
                MoveJ LeftPick, speed, z100, tool0;
                MoveJ Offs(LeftPick, 0, 0, -20), speed, z100, tool0;
                WaitRob \InPos;
                    ! Grippping with wait.
                SetDO doStackerRightGripper, 1;
                WaitDO doStackerRightGripper, 1;
                !WaitTime(0.5);
                    ! Moving out, unclaiming pickup token.
                MoveJ LeftPick, speed, z100, tool0;
                MoveJ LeftHome, speed, z100, tool0;
                WaitRob \InPos;
                SetDO doStackerLeftPickingUp, 0;
                WaitDO doStackerLeftPickingUp, 0;
                
                    ! Pickup token unclaimed, and moving in to place block.
                TEST stackCount
                CASE 1:
                    tempTarget := Left12;
                CASE 2:
                    tempTarget := Left11;
                CASE 3:
                    tempTarget := Left22;
                CASE 4:
                    tempTarget := Left21;
                DEFAULT:
                    TPWrite "Something went wrong";
                ENDTEST
                stackCount := stackCount +1;
                IF stackCount > 4 THEN
                    stackCount := 1;
                ENDIF
                SetDO doStackerLeftDelivering, 1;
                WaitDO doStackerLeftDelivering, 1;
                MoveL tempTarget, speed, z100, tool0;
                WaitRob \InPos;
                SetDO doStackerRightGripper, 0;
                WaitDO doStackerRightGripper, 0;
                SetDO doStackerLeftDelivering, 0;
                WaitDO doStackerLeftDelivering, 0;
            ELSE
                TPWrite "Left Stacker wants to enter picup while Right is on it.";
            ENDIF
        ENDIF
    ENDPROC
ENDMODULE