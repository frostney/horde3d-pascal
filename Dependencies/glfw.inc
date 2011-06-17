{$IFDEF MSWINDOWS}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN64}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN}
  {$DEFINE WINDOWS}
{$ENDIF}

// Use standard linking method
// This means links dynamically to glfw.dll on Windows, glfw.so on Linux
// and statically on Mac OS X
//
// If you don't like that, comment this define
{$DEFINE LINK_STANDARD}

// If the define above is commented, remove the dot on your favorite option
{$IFDEF LINK_STANDARD}
  {$IFDEF DARWIN}
    {$DEFINE LINK_STATIC}
  {$ELSE}
    {$DEFINE LINK_DYNAMIC}
  {$ENDIF}
{$ELSE}
  {$DEFINE LINK_DYNAMIC}
  {.$DEFINE LINK_STATIC}
{$ENDIF}

{$IFDEF LINK_STATIC}
  {$LINK libglfw.a}
{$ENDIF}


{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
