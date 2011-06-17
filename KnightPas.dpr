program KnightPas;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  SysUtils,
  Horde3D,
  Horde3DUtils,
  glfw,
  KnightApp;

const
  caption: AnsiString = 'Knight - Horde3D Sample';
  appWidth: Integer = 1024;
  appHeight: Integer = 576;

var
  fullScreen: Boolean = false;
  benchmarkLength: Integer = 600;

function setupWindow(width, height: Integer; fullScreen: Boolean): Boolean;
  forward;

var
  running: Boolean;
  t0: Double;
  mx0, my0: Integer;
  app: CApplication;

function windowCloseListener: Integer; stdcall;
begin
  running := false;
  Result := 0;
end;

procedure keyPressListener(key, action: Integer); stdcall;
var
  width, height: Integer;
  mode: GLFWvidmode;
  aspect: Single;
begin
  if not running then
    Exit;

  if (action = GLFW_PRESS) then
  begin
    width := appWidth;
    height := appHeight;

    case key of
      GLFW_KEY_ESC:
        running := false;
      GLFW_KEY_SPACE:
        app.keyPressEvent(key);
      GLFW_KEY_F1:
        begin
          app.release;
          glfwCloseWindow;

          // Toggle fullscreen mode
          fullScreen := not fullScreen;

          if fullScreen then
          begin
            glfwGetDesktopMode(@mode);

            aspect := mode.width / mode.height;
            if (Trunc(aspect * 100) = 133) or (Trunc(aspect * 100) = 125) then
            // Standard
            begin
              width := 1280;
              height := 1024;
            end
            else if (Trunc(aspect * 100) = 177) then // Widescreen
            begin
              width := 1280;
              height := 720;
            end
            else if (Trunc(aspect * 100) = 160) then // Widescreen
            begin
              width := 1280;
              height := 800;
            end
            else // Unknown
            begin
              // Use desktop resolution
              width := mode.width;
              height := mode.height;
            end;
          end;

          if not setupWindow(width, height, fullScreen) then
          begin
            glfwTerminate;
            Halt(1);
          end;

          app.init;
          app.resize(width, height);
          t0 := glfwGetTime;
        end;
    else
      app.keyPressEvent(key);
    end;
  end;

  if (key >= 0) then
    app.keyStateChange(key, action = GLFW_PRESS);
end;

procedure mouseMoveListener(x, y: Integer); stdcall;
begin
  if not running then
  begin
    mx0 := x;
    my0 := y;
    Exit;
  end;

  app.mouseMoveEvent((x - mx0), (my0 - y));
  mx0 := x;
  my0 := y;
end;

function setupWindow(width, height: Integer; fullScreen: Boolean): Boolean;
var
  mode: Integer;
begin
  Result := false;
  // Create OpenGL window
  if fullScreen then
    mode := GLFW_FULLSCREEN
  else
    mode := GLFW_WINDOW;
  if glfwOpenWindow(width, height, 8, 8, 8, 8, 24, 8, mode) = 0 then
  begin
    glfwTerminate;
    Exit;
  end;

  if not fullScreen then
    glfwSetWindowTitle(PAnsiChar(caption));

  // Disable vertical synchronization
  glfwSwapInterval(0);

  // Set listeners
  glfwSetWindowCloseCallback(windowCloseListener);
  glfwSetKeyCallback(keyPressListener);
  glfwSetMousePosCallback(mouseMoveListener);

  Result := True;
end;

var
  benchmark: Boolean;
  frames: Integer;
  fps: Single;
  t: Double;
  avgFPS: Double;
  title: AnsiString;

{$R *.res}

begin
  // Initialize GLFW
  glfwInit;
  if not setupWindow(appWidth, appHeight, fullScreen) then
    Halt(1);

  // Check if benchmark mode is requested
  benchmark := false;
  if (ParamCount > 1) and (ParamStr(1) = '-bm') then
  begin
    benchmark := True;
    glfwDisable(GLFW_AUTO_POLL_EVENTS);
  end;

  // Initialize application and engine
  app := CApplication.Create(AnsiString(ExtractFilePath(ParamStr(0)))
      + '../Content');
  if not app.init then
  begin
    // Fake message box
    glfwCloseWindow;
    glfwOpenWindow(800, 16, 8, 8, 8, 8, 24, 8, GLFW_WINDOW);
    glfwSetWindowTitle(
      'Unable to initalize engine - Make sure you have an OpenGL 2.0 compatible graphics card');
    glfwSleep(5);

    glfwTerminate;
    Halt(1);
  end;

  app.resize(appWidth, appHeight);

  glfwDisable(GLFW_MOUSE_CURSOR);

  frames := 0;
  fps := 30.0;
  t0 := glfwGetTime;
  running := True;

  // Game loop
  while running do
  begin
    // Calc FPS
    Inc(frames);
    if (not benchmark) and (frames >= 3) then
    begin
      t := glfwGetTime;
      fps := frames / (t - t0);
      frames := 0;
      t0 := t;
    end;

    // Render
    if benchmark then
      app.mainLoop(60)
    else
      app.mainLoop(fps);
    glfwSwapBuffers;

    if benchmark and (frames = benchmarkLength) then
      Break;
  end;

  glfwEnable(GLFW_MOUSE_CURSOR);

  // Show benchmark results
  if (benchmark) then
  begin
    avgFPS := benchmarkLength / (glfwGetTime - t0);
    title := 'Average FPS: ' + AnsiString(FormatFloat('0.00', avgFPS));
    glfwCloseWindow;
    glfwOpenWindow(800, 16, 8, 8, 8, 8, 24, 8, GLFW_WINDOW);
    glfwSetWindowTitle(PAnsiChar(title));
    glfwSleep(5);
  end;

  // Quit
  app.release;
  app.Free;
  glfwTerminate;

end.
