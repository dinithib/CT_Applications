PROGRAM light_controller
  VAR
    photoresistor AT %IW100 : INT := 200;
    start_command AT %IX100.0 : BOOL;
    start_command_memory AT %MW2 : INT := 0;
  END_VAR
  VAR_OUTPUT
    ET_value : TIME;
  END_VAR
  VAR
    led AT %QX100.0 : BOOL;
    setting AT %MW0 : INT := 9800;
    run_duration AT %MW1 : INT := 30;
  END_VAR
  VAR
    TOF0 : TOF;
    LE13_OUT : BOOL;
    INT_TO_BOOL36_OUT : BOOL;
    INT_TO_TIME31_OUT : TIME;
    AND17_OUT : BOOL;
  END_VAR

  LE13_OUT := LE(photoresistor, setting);
  INT_TO_BOOL36_OUT := INT_TO_BOOL(start_command_memory);
  INT_TO_TIME31_OUT := INT_TO_TIME(run_duration);
  TOF0(IN := INT_TO_BOOL36_OUT, PT := INT_TO_TIME31_OUT);
  AND17_OUT := AND(LE13_OUT, TOF0.Q);
  led := AND17_OUT;
  ET_value := TOF0.ET;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    VAR_GLOBAL
      PT_G : TIME;
    END_VAR
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : light_controller;
  END_RESOURCE
END_CONFIGURATION
