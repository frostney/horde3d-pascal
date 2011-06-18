unit ChicagoCrowd;

interface

uses
  Math,
  Horde3D,
  Horde3DUtils,
  Classes,
  SysUtils;

type
  PParticle = ^TParticle;
  TParticle = record
    px, pz: Single;  // Current postition
	dx, dz: Single;  // Destination position
	fx, fz: Single;  // Force on particle
	ox, oz: Single;  // Orientation vector
	node: TH3DNode;
	animTime: Single;
  end;
  
  TCrowdSim = class
  private
    _contentDir: String;
    _particles: TList;
    
    procedure chooseDestination(p: TParticle);
  public
    constructor Create(contentDir: AnsiString);
    
    procedure init;
    procedure update(fps: Single);
  end;

implementation

constructor TCrowdSim.Create(contentDir: AnsiString);
begin
  _contentDir := contentDir;
  
  _particles := TList.Create;
end;

procedure TCrowdSim.chooseDestination(p: TParticle);
var
  ang, rad: Single;
begin
  // Choose random destination within a circle
  ang := (Random(360) / 360.0) * 6.28;
  rad := Random(20) * 1.0;

  p.dx := sin(ang) * rad;
  p.dz := cos(ang) * rad;
end;

procedure TCrowdSim.init;
var
  characterRes, characterWalkRes: TH3DRes;
  i: Integer;
  p: TParticle;
begin
  Randomize;
  
  // Load character with walk animation
  characterRes := h3dAddResource(H3DResTypes_SceneGraph, 'models/man/man.scene.xml', 0);
  characterWalkRes := h3dAddResource(H3DResTypes_Animation, 'animations/man.anim', 0);
  h3dutLoadResourcesFromDisk(PAnsiChar(_contentDir));
  
  // Add characters
  for i := 0 to 100 do
  begin
    p.node := h3dAddNodes(H3DRootNode, characterRes);
    h3dSetupModelAnimStage(p.node, 0, characterWalkRes, 0, '', false);
    
    // Characters start in a circle formation
	p.px := sin((i / 100.0) * 6.28) * 10.0;
	p.pz := cos( (i / 100.0) * 6.28) * 10.0;
	
	chooseDestination(p);

	h3dSetNodeTransform(p.node, p.px, 0.02, p.pz, 0, 0, 0, 1, 1, 1);
	
	_particles.Add(@p);
  end;
end;

procedure TCrowdSim.update(fps: Single);
var
  // Parameters for three repulsion zones
  d1: Single = 0.25;
  d2: Single = 2.0;
  d3: Single = 4.5;
  
  f1: Single = 3.0;
  f2: Single = 1.0;
  f3: Single = 0.1;
  
  
  i: Integer;
  p: TParticle;
  
  
  vel: Single;
  ry: Single;
begin

  for i := 0 to _particles.Count - 1 do
  begin
    p := PParticle(_particles.Items[i])^;
    
    
    
    // Make movement framerate independent
	p.fx := p.fx * (30 / fps);
	p.fz := p.fz * (30 / fps);
	vel := sqrt(p.fx * p.fx + p.fz * p.fz);
	
	// Set new position
	p.px := p.px + p.fx; 
	p.pz := p.pz + p.fz;
	
	// Calculate orientation
	p.ox := (p.ox + p.fx) / 2;
	p.oz := (p.oz + p.fz) / 2;

	// Get rotation from orientation
	//ry := 0.0;
	//if (p.oz <> 0.0) then ry := arctan2(p.ox, p.oz);
	//ry := ry * 180 / PI;	// Convert from radians to degrees
	
	// Update character scene node position
	h3dSetNodeTransform(p.node, p.px, 0.02, p.pz, 0, ry, 0, 1, 1, 1);
	
	// Update animation
	p.animTime := p.animTime + vel * 35.0;
	h3dSetModelAnimParams(p.node, 0, p.animTime, 1.0);
  end;
end;

end.
