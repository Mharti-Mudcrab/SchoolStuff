MODULE Module1
    CONST robtarget SortPick:=[[360.5,3333.055,113.666],[0,1,0,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget SortDrop:=[[1331.5,4304.055,212.998],[0,-0.707106781,0.707106781,0],[-2,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget SortHome:=[[360.5,3333.055,213.666],[0,1,0,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR speeddata speed := v1000;
    !***********************************************************
    !
    ! Module:  Sorter robot
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: madsw
    ! Version: 1.0
    !
    !***********************************************************

    PROC main()
        MoveJ SortHome, speed, z100, tool0;
        IF diSorterPick = 1 THEN
            MoveJ SortPick, speed, z100, tool0;
            WaitRob \InPos;
            SetDO doSorterGripper, 1;
            WaitDO doSorterGripper, 1;
            MoveJ SortHome, speed, z100, tool0;
            MoveJ SortDrop, speed, z100, tool0;
            WaitRob \InPos;
            SetDO doSorterGripper, 0;
            WaitDO doSorterGripper, 0;
        ENDIF
    ENDPROC
ENDMODULE