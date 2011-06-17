unit KnightApp;

interface

uses
  SysUtils,
  Horde3D,
  Horde3DUtils;

type
  CApplication = class
  private
    _keys: array [0 .. 319] of Boolean;
    _x, _y, _z, _rx, _ry: Single;
    _velocity: Single;
    _curFPS: Single;
    _text: AnsiString;

    _statMode: Integer;
    _freeze, _debugViewMode, _wireframeMode: Boolean;
    _animTime, _weight: Single;

    // Engine objects
    _fontMatRes, _panelMatRes: TH3DRes;
    _logoMatRes, _hdrPipeRes, _forwardPipeRes: TH3DRes;
    _cam, _knight, _particleSys: TH3DNode;

    _contentDir: AnsiString;

    procedure keyHandler;
  public
    constructor Create(contentDir: AnsiString);

    function init: Boolean;
    procedure mainLoop(fps: Single);
    procedure release;
    procedure resize(width, height: Integer);

    procedure keyPressEvent(key: Integer);
    procedure keyStateChange(key: Integer; state: Boolean);
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
  envRes, knightRes, knightAnim1Res, knightAnim2Res, particleSysRes: TH3DRes;
  env, hand, light, matRes: TH3DNode;
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
  _hdrPipeRes := h3dAddResource(H3DResTypes_Pipeline,
    'pipelines/hdr.pipeline.xml', 0);
  _forwardPipeRes := h3dAddResource(H3DResTypes_Pipeline,
    'pipelines/forward.pipeline.xml', 0);
  // Overlays
  _fontMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/font.material.xml', 0);
  _panelMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/panel.material.xml', 0);
  _logoMatRes := h3dAddResource(H3DResTypes_Material,
    'overlays/logo.material.xml', 0);
  // Environment
  envRes := h3dAddResource(H3DResTypes_SceneGraph,
    'models/sphere/sphere.scene.xml', 0);
  // Knight
  knightRes := h3dAddResource(H3DResTypes_SceneGraph,
    'models/knight/knight.scene.xml', 0);
  knightAnim1Res := h3dAddResource(H3DResTypes_Animation,
    'animations/knight_order.anim', 0);
  knightAnim2Res := h3dAddResource(H3DResTypes_Animation,
    'animations/knight_attack.anim', 0);
  // Particle system
  particleSysRes := h3dAddResource(H3DResTypes_SceneGraph,
    'particles/particleSys1/particleSys1.scene.xml', 0);

  // Load resources
  h3dutLoadResourcesFromDisk(PAnsiChar(_contentDir));

  // Add scene nodes
  // Add camera
  _cam := h3dAddCameraNode(H3DRootNode, 'Camera', _hdrPipeRes);
  // h3dSetNodeParamI( _cam, H3DCamera_OccCullingI, 1 );
  // Add environment
  env := h3dAddNodes(H3DRootNode, envRes);
  h3dSetNodeTransform(env, 0, -20, 0, 0, 0, 0, 20, 20, 20);
  // Add knight
  _knight := h3dAddNodes(H3DRootNode, knightRes);
  h3dSetNodeTransform(_knight, 0, 0, 0, 0, 180, 0, 0.1, 0.1, 0.1);
  h3dSetupModelAnimStage(_knight, 0, knightAnim1Res, 0, '', False);
  h3dSetupModelAnimStage(_knight, 1, knightAnim2Res, 0, '', False);
  // Attach particle system to hand joint
  h3dFindNodes(_knight, 'Bip01_R_Hand', H3DNodeTypes_Joint);
  hand := h3dGetNodeFindResult(0);
  _particleSys := h3dAddNodes(hand, particleSysRes);
  h3dSetNodeTransform(_particleSys, 0, 40, 0, 90, 0, 0, 1, 1, 1);

  // Add light source
  light := h3dAddLightNode(H3DRootNode, 'Light1', 0, 'LIGHTING', 'SHADOWMAP');
  h3dSetNodeTransform(light, 0, 15, 10, -60, 0, 0, 1, 1, 1);
  h3dSetNodeParamF(light, Integer(H3DLight_RadiusF), 0, 30);
  h3dSetNodeParamF(light, Integer(H3DLight_FovF), 0, 90);
  h3dSetNodeParamI(light, Integer(H3DLight_ShadowMapCountI), 1);
  h3dSetNodeParamF(light, Integer(H3DLight_ShadowMapBiasF), 0, 0.01);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 0, 1.0);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 1, 0.8);
  h3dSetNodeParamF(light, Integer(H3DLight_ColorF3), 2, 0.7);

  // Customize post processing effects
  matRes := h3dFindResource(H3DResTypes_Material,
    'pipelines/postHDR.material.xml');

  h3dSetMaterialUniform(matRes, 'hdrExposure', 2.5, 0, 0, 0);
  h3dSetMaterialUniform(matRes, 'hdrBrightThres', 0.5, 0, 0, 0);
  h3dSetMaterialUniform(matRes, 'hdrBrightOffset', 0.08, 0, 0, 0);

  Result := true;
end;

procedure CApplication.keyHandler;
var
  curVel: Single;
begin
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

procedure CApplication.keyPressEvent(key: Integer);
begin
  if (key = 32) then // Space
    _freeze := not _freeze;

  if (key = 260) then // F3
  begin
    if (h3dGetNodeParamI(_cam, Integer(H3DCamera_PipeResI)) = _hdrPipeRes) then
      h3dSetNodeParamI(_cam, Integer(H3DCamera_PipeResI), _forwardPipeRes)
    else
      h3dSetNodeParamI(_cam, Integer(H3DCamera_PipeResI), _hdrPipeRes);
  end;

  if (key = 264) then // F7
    _debugViewMode := not _debugViewMode;

  if (key = 265) then // F8
    _wireframeMode := not _wireframeMode;

  if (key = 266) then // F9
  begin
    Inc(_statMode);
    if (_statMode > H3DUTMaxStatMode) then
      _statMode := 0;
  end;
end;

procedure CApplication.keyStateChange(key: Integer; state: Boolean);
begin
  _keys[key] := state;
end;

procedure CApplication.mainLoop(fps: Single);
var
  cnt, I: Integer;
  ww: Single;
  ovLogo: array[0..15] of Single;
begin
  _curFPS := fps;

  keyHandler;

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
    _animTime := _animTime + 1.0 / _curFPS;

    // Do animation blending
    h3dSetModelAnimParams(_knight, 0, _animTime * 24.0, _weight);
    h3dSetModelAnimParams(_knight, 1, _animTime * 24.0, 1.0 - _weight);

    // Animate particle systems (several emitters in a group node)
    cnt := h3dFindNodes(_particleSys, '', H3DNodeTypes_Emitter);
    for I := 0 to cnt - 1 do
      h3dAdvanceEmitterTime(h3dGetNodeFindResult(I), 1.0 / _curFPS);
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

  WriteLn(Integer(H3DCamera_ViewportXI));

  // Set virtual camera parameters
  h3dSetupCameraView( _cam, 45.0, width / height, 0.1, 1000.0 );
  h3dResizePipelineBuffers( _hdrPipeRes, width, height );
  h3dResizePipelineBuffers( _forwardPipeRes, width, height );
end;

end.
