MODULE Module1
    CONST robtarget mediumPos:=[[-3.693603449,819.543408383,615.626909749],[0.002655391,-0.746102909,0.665821308,-0.002320117],[1,-5,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget pickupPos:=[[996.139868276,-0.000086478,160.226118879],[0.000036866,0.000002225,0.999993783,-0.00352606],[0,-5,4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget homePos:=[[996.139869233,-0.000090103,615.626718052],[0.000036871,0.000002267,0.999993783,-0.003526076],[0,-5,4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget smallPos:=[[6.065690573,-828.445663962,615.626912126],[0.002646429,-0.757323064,-0.653030889,0.002330404],[-1,-5,4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: madsw
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        MoveJ homePos, v1000, z100, tool0;
        IF diPick = 1 THEN
            ! Pick up box
            !WaitTime(1);
            MoveJ pickupPos, v1000, z100, tool0;
            SetDO doGripper, 1;
            !WaitTime(1);
            MoveJ homePos, v1000, z100, tool0;
            !WaitTime(1);
            
            ! Move to drop off box
            IF diMoveRight = 1 THEN
                MoveJ smallPos, v1000, z100, tool0;
            ELSE
                MoveJ mediumPos, v1000, z100, tool0;
            ENDIF
            WaitTime(1);
            
            ! Drop box
            SetDO doGripper, 0;
            WaitTime(1);
        ENDIF
    ENDPROC
ENDMODULE