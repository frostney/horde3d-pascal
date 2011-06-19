unit ChicagoApp;

interface

uses
  SysUtils,
  ChicagoCrowd,
  Horde3D,
  Horde3DUtils
  {$IFDEF DARWIN} //< On Mac OS X, you need to initalize OpenGL before initializing Horde3D (dglOpenGL.pas is not stable on Mac OS X)
  ,GL, GLU
  {$ENDIF}
  ;

type
  CApplication = class
  private
    _keys, _prevKeys: array [0 .. 319] of Boolean;
    _x, _y, _z, _rx, _ry: Single;
    _velocity: Single;
    _curFPS: Single;
    _text: AnsiString;

    _statMode: Integer;
    _freeze, _debugViewMode, _wireframeMode: Boolean;
    _animTime, _weight: Single;

    // Engine objects
    _fontMatRes, _panelMatRes: TH3DRes;
    _logoMatRes, _forwardPipeRes, _deferredPipeRes: TH3DRes;
    _cam: TH3DNode;

    _contentDir: AnsiString;
    _crowdSim: TCrowdSim;
  public
    constructor Create(contentDir: AnsiString);

    function init: Boolean;
    procedure mainLoop(fps: Single);
    procedure release;
    procedure resize(width, height: Integer);

    procedure keyStateHandler();
    procedure setKeyState(key: Integer; state: Boolean);
    procedure mouseMoveEvent(dX, dY: Single);
  end;

implementation

function degToRad(f: Single): Single;
begin
  Result := f * (PI / 180.0);
end;

{ Application }

constructor CApplication.Create(contentDir: AnsiString);
var
  I: Integer;
begin
  for I := 0 to 319 do
    _keys[I] := False;

  _x := 5;
  _y := 3;
  _z := 19;
  _rx := 7;
  _ry := 15;
  _velocity := 10.0;
  _curFPS := 30;

  _statMode := 0;
  _freeze := False;
  _debugViewMode := False;
  _wireframeMode := False;
  _animTime := 0;
  _weight := 1.0;
  _cam := 0;

  _contentDir := contentDir;
end;

function CApplication.init: Boolean;
var
  lightMatRes, envRes, skyBoxRes: TH3DRes;
  env, sky, light: TH3DNode;
begin
  Result := False;

  // Initialize engine
  if not h3dInit then
  begin
    h3dutDumpMessages;
    Exit;
  end;

  // Set options
  h3dSetOption(H3DOptions_LoadTextures, 1);
  h3dSetOption(H3DOptions_TexCompression, 0);
  h3dSetOption(H3DOptions_FastAnimation, 0);
  h3dSetOption(H3DOptions_MaxAnisotropy, 4);
  h3dSetOption(H3DOptions_ShadowMapSize, 2048);

  // Add resources
  // Pipelines
  _forwardPipeRes := h3dAddResource(H3DResTypes_Pipeline,
    'pipelines/forward.pipeline.xml', 0);
  _deferredPipeRes := h3dAddResource(H3DResTypes_Pipeline,
    'pipelines/deferred.pipeline.xml', 0);
  // Overlays
  _fontMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/font.material.xml', 0);
  _panelMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/panel.material.xml', 0);
  _logoMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/logo.material.xml', 0);
  // Shader for deferred shading
  lightMatRes := h3dAddResource(H3DResTypes_Material, 'materials/light.material.xml', 0);
  // Environment
  envRes := h3dAddResource(H3DResTypes_SceneGraph, 'models/platform/platform.scene.xml', 0);
  // Skybox
  skyBoxRes := h3dAddResource(H3DResTypes_SceneGraph, 'models/skybox/skybox.scene.xml', 0);
  

  // Load resources
  h3dutLoadResourcesFromDisk(PAnsiChar(_contentDir));

  // Add scene nodes
  // Add camera
  _cam := h3dAddCameraNode(H3DRootNode, 'Camera', _forwardPipeRes);
  // h3dSetNodeParamI( _cam, H3DCamera_OccCullingI, 1 );
  // Add environment
  env := h3dAddNodes(H3DRootNode, envRes);
  h3dSetNodeTransform(env, 0, 0, 0, 0, 0, 0, 0.23, 0.23, 0.23);
  // Add skybox
  sky := h3dAddNodes(H3DRootNode, skyBoxRes);
  h3dSetNodeTransform(sky, 0, 0, 0, 0, 0, 0, 210, 50, 210);
  h3dSetNodeFlags(sky, Integer(H3DNodeFlags_NoCastShadow), true);
  // Add light source
  light := h3dAddLightNode(H3DRootNode, 'Light1', lightMatRes, 'LIGHTING', 'SHADOWMAP');
  h3dSetNodeTransform(light, 0, 20, 50, -30, 0, 0, 1, 1, 1);
  h3dSetNodeParamF(light, Integer(H3DLight_RadiusF), 0, 200);
  h3dSetNodeParamF(light, Integer(H3DLight_FovF), 0, 90);
  h3dSetNodeParamI(light, Integer(H3DLight_ShadowMapCountI), 3);
  h3dSetNodeParamF(light, Integer(H3DLight_ShadowSplitLambdaF), 0, 0.9);
  h3dSetNodeParamF(light, Integer(H3DLight_ShadowMapBiasF), 0, 0.001);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 0, 0.9);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 1, 0.7);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 2, 0.75);

  _crowdSim := TCrowdSim.Create(_contentDir);
  _crowdSim.init;

  Result := true;
end;

procedure CApplication.keyStateHandler;
var
  curVel: Single;
begin
  if (_keys[32] and not _prevKeys[32]) then // Space
    _freeze := not _freeze;

  if (_keys[260] and not _prevKeys[260]) then // F3
  begin
    if (h3dGetNodeParamI(_cam, Integer(H3DCamera_PipeResI)) = _forwardPipeRes) then
      h3dSetNodeParamI(_cam, Integer(H3DCamera_PipeResI), _deferredPipeRes)
    else
      h3dSetNodeParamI(_cam, Integer(H3DCamera_PipeResI), _forwardPipeRes);
  end;

  if (_keys[264] and not _prevKeys[264]) then // F7
    _debugViewMode := not _debugViewMode;

  if (_keys[265] and not _prevKeys[265]) then // F8
    _wireframeMode := not _wireframeMode;

  if (_keys[266] and not _prevKeys[266]) then // F9
  begin
    Inc(_statMode);
    if (_statMode > H3DUTMaxStatMode) then
      _statMode := 0;
  end;
  

  curVel := _velocity / _curFPS;

  if (_keys[287]) then
    curVel := curVel * 5; // LShift

  if (_keys[Ord('W')]) then
  begin
    // Move forward
    _x := _x - sin(degToRad(_ry)) * cos(-degToRad(_rx)) * curVel;
    _y := _y - sin(-degToRad(_rx)) * curVel;
    _z := _z - cos(degToRad(_ry)) * cos(-degToRad(_rx)) * curVel;
  end;

  if (_keys[Ord('S')]) then
  begin
    // Move backward
    _x := _x + sin(degToRad(_ry)) * cos(-degToRad(_rx)) * curVel;
    _y := _y + sin(-degToRad(_rx)) * curVel;
    _z := _z + cos(degToRad(_ry)) * cos(-degToRad(_rx)) * curVel;
  end;

  if (_keys[Ord('A')]) then
  begin
    // Strafe left
    _x := _x + sin(degToRad(_ry - 90)) * curVel;
    _z := _z + cos(degToRad(_ry - 90)) * curVel;
  end;

  if (_keys[Ord('D')]) then
  begin
    // Strafe right
    _x := _x + sin(degToRad(_ry + 90)) * curVel;
    _z := _z + cos(degToRad(_ry + 90)) * curVel;
  end;

  if (_keys[Ord('1')]) then
  begin
    // Change blend weight
    _weight := _weight + 2 / _curFPS;
    if (_weight > 1) then
      _weight := 1;
  end;

  if (_keys[Ord('2')]) then
  begin
    // Change blend weight
    _weight := _weight - 2 / _curFPS;
    if (_weight < 0) then
      _weight := 0;
  end;
end;

procedure CApplication.setKeyState(key: Integer; state: Boolean);
begin
  _prevKeys[key] := _keys[key]; 
  _keys[key] := state;
end;

procedure CApplication.mainLoop(fps: Single);
var
  ww: Single;
  ovLogo: array[0..15] of Single;
begin
  _curFPS := fps;

  if _debugViewMode then
    h3dSetOption(H3DOptions_DebugViewMode, 1.0)
  else
    h3dSetOption(H3DOptions_DebugViewMode, 0.0);

  if _wireframeMode then
    h3dSetOption(H3DOptions_WireframeMode, 1.0)
  else
    h3dSetOption(H3DOptions_WireframeMode, 0.0);

  if not _freeze then
  begin
    _crowdSim.update(fps);
  end;

  // Set camera parameters
  h3dSetNodeTransform(_cam, _x, _y, _z, _rx, _ry, 0, 1, 1, 1);

  // Show stats
  //h3dutShowFrameStats(_fontMatRes, _panelMatRes, _statMode);
  if _statMode > 0 then
  begin
    // Display weight
    _text := 'Weight: ' + AnsiString(FormatFloat('0.00', _weight));
    h3dutShowText(PAnsiChar(_text), 0.03, 0.24, 0.026, 1, 1, 1, _fontMatRes);
  end;

  ww := h3dGetNodeParamI(_cam, Integer(H3DCamera_ViewportWidthI)) / h3dGetNodeParamI(_cam, Integer(H3DCamera_ViewportHeightI));

  // Show logo
   ovLogo[0] := ww - 0.4;
   ovLogo[1] := 0.8;
   ovLogo[2] := 0;
   ovLogo[3] := 1;

   ovLogo[4] := ww - 0.4;
   ovLogo[5] := 1;
   ovLogo[6] := 0;
   ovLogo[7] := 0;

   ovLogo[8] := ww;
   ovLogo[9] := 1;
   ovLogo[10] := 1;
   ovLogo[11] := 0;

   ovLogo[12] := ww;
   ovLogo[13] := 0.8;
   ovLogo[14] := 1;
   ovLogo[15] := 1;

  h3dShowOverlays(ovLogo, 4, 1, 1, 1, 1, _logoMatRes, 0);

  // Render scene
  h3dRender(_cam);

  // Finish rendering of frame
  h3dFinalizeFrame;

  // Remove all overlays
  h3dClearOverlays;

  // Write all messages to log file
  h3dutDumpMessages;
end;

procedure CApplication.mouseMoveEvent(dX, dY: Single);
begin
  // Look left/right
  _ry := _ry - dX / 100 * 30;

  // Loop up/down but only in a limited range
  _rx := _rx + dY / 100 * 30;
  if (_rx > 90) then
    _rx := 90;
  if (_rx < -90) then
    _rx := -90;
end;

procedure CApplication.release;
begin
  // Release engine
  h3dRelease;
end;

procedure CApplication.resize(width, height: Integer);
begin
  // Resize viewport
  h3dSetNodeParamI( _cam, Integer(H3DCamera_ViewportXI), 0 );
  h3dSetNodeParamI( _cam, Integer(H3DCamera_ViewportYI), 0 );
  h3dSetNodeParamI( _cam, Integer(H3DCamera_ViewportWidthI), width );
  h3dSetNodeParamI( _cam, Integer(H3DCamera_ViewportHeightI), height );

  // Set virtual camera parameters
  h3dSetupCameraView( _cam, 45.0, width / height, 0.1, 1000.0 );
  h3dResizePipelineBuffers( _deferredPipeRes, width, height );
  h3dResizePipelineBuffers( _forwardPipeRes, width, height );
end;

end.
