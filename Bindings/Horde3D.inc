{$IFDEF MSWINDOWS}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN}
  {$DEFINE WINDOWS}
{$ENDIF}


{$IFDEF FPC}
  {$INLINE ON}

  {$DEFINE CAN_METHODS}
  {$DEFINE CAN_INLINE}
{$ELSE}
  {$IFDEF VER170}
    {$DEFINE DELPHI2005UP}
  {$ENDIF}
  {$IFDEF VER180}
    {$DEFINE DELPHI2005UP}
  {$ENDIF}
  {$IFDEF VER185}
    {$DEFINE DELPHI2005UP}
  {$ENDIF}
  {$IFDEF VER200}
    {$DEFINE DELPHI2005UP}
  {$ENDIF}

  {$IFDEF DELPHI2005UP}
    {$DEFINE CAN_METHODS}
    {$DEFINE CAN_INLINE}
  {$ENDIF}
{$ENDIF}