PROGRAM light_controller
  VAR
    ldr AT %IW100 : UINT;
    setpoint AT %MW0 : UINT := 5000;
    led AT %QX100.0 : BOOL;
  END_VAR
  VAR
    LE1_OUT : BOOL;
  END_VAR

  LE1_OUT := LE(ldr, setpoint);
  led := LE1_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : light_controller;
  END_RESOURCE
END_CONFIGURATION
