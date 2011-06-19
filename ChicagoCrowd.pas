unit ChicagoCrowd;

interface

uses
  Math,
  Horde3D,
  Horde3DUtils,
  Classes,
  glfw,
  SysUtils;

type
  TParticle = record
    px, pz: Single;  // Current postition
    dx, dz: Single;  // Destination position
    fx, fz: Single;  // Force on particle
    ox, oz: Single;  // Orientation vector
    node: TH3DNode;
    animTime: Single;
  end;
  TParticleArray = array[0..99] of TParticle;
  
  TCrowdSim = class
  private
    _contentDir: String;
    _particles: TParticleArray;

    procedure chooseDestination(var particle: TParticle);
  public
    constructor Create(contentDir: AnsiString);
    
    procedure init;
    procedure update(fps: Single);
  end;

implementation

constructor TCrowdSim.Create(contentDir: AnsiString);
var
  i: Integer;
begin
  Randomize;

  _contentDir := contentDir;

  // Clear
  for i := 0 to Length(_particles) - 1 do
  begin
    _particles[i].ox := 0;
    _particles[i].oz := 0;

    _particles[i].node := 0;
    _particles[i].animTime := 0;
  end;
end;

procedure TCrowdSim.chooseDestination(var particle: TParticle);
var
  ang, rad: Single;
begin
  particle.dx := sin((Random(360) / 360) * 6.28) * Random(20);
  particle.dz := cos((Random(360) / 360) * 6.28) * Random(20);
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
  for i := 0 to Length(_particles) - 1 do
  begin
    p.node := h3dAddNodes(H3DRootNode, characterRes);
    h3dSetupModelAnimStage(p.node, 0, characterWalkRes, 0, '', false);
    
    // Characters start in a circle formation
    p.px := sin((i / 100.0) * 6.28) * 10.0;
    p.pz := cos( (i / 100.0) * 6.28) * 10.0;

    chooseDestination(p);

    h3dSetNodeTransform(p.node, p.px, 0.02, p.pz, 0, 0, 0, 1, 1, 1);

    _particles[i] := p;
  end;
end;

procedure TCrowdSim.update(fps: Single);
// Parameters for three repulsion zones
const
  d1: Single = 0.25;
  d2: Single = 2.0;
  d3: Single = 4.5;

  f1: Single = 3.0;
  f2: Single = 1.0;
  f3: Single = 0.1;
var
  i, j: Integer;
  p: TParticle;

  dist: Single;
  afx, afz: Single;

  p2: TParticle;
  dist2: Single;

  strength: Single;
  rfx, rfz: Single;

  m3, t3, m2, t2, m1, t1: Single;

  
  vel: Single;
  ry: Single;
begin

  for i := 0 to Length(_particles) - 1 do
  begin
    p := _particles[i];

    // Reset force
    p.fx := 0;
    p.fz := 0;

    // Calculate distance to destination
    dist := sqrt((p.dx - p.px) * (p.dx - p.px) + (p.dz - p.pz) * (p.dz - p.pz));

    // If destination not reached walk to destination
    if dist > 3.0 then
    begin

      // Calculate normalized attraction force to destination
      afx := (p.dx - p.px) / dist;
      afz := (p.dz - p.pz) / dist;

      p.fx := p.fx + (afx * 0.035);
      p.fz := p.fz + (afz * 0.035);

      for j := 0 to Length(_particles) - 1 do
      begin
        if (i = j) then Continue;

        p2 := _particles[j];

        dist2 := sqrt((p.px - p2.px) * (p.px - p2.px) + (p.pz - p2.pz) * (p.pz - p2.pz));
	strength := 0;

	rfx := (p.px - p2.px) / dist2;
	rfz := (p.pz - p2.pz) / dist2;

        // Use three zones with different repulsion strengths
	if ((dist2 <= d3) and (dist2 > d2)) then
	begin
          m3 := (f3 - 0) / (d2 - d3);
	  t3 := 0 - m3 * d3;
	  strength := m3 * dist2 + t3;
	end else if ((dist2 <= d2) and (dist2 > d1)) then
	begin
	  m2 := (f2 - f3) / (d1 - d2);
	  t2 := f3 - m2 * d2;
	  strength := m2 * dist2 + t2;
	end else if (dist2 <= d1) then
	begin
	  m1 := (f1 - f2) / (0 - d1);
	  t1 := f2 - m1 * d1;
	  strength := m1 * dist2 + t1;
	end;

	p.fx := p.fx + rfx * strength;
        p.fz := p.fz + rfz * strength;
      end;
    end else
    begin
      // Choose new destination
      chooseDestination(p);
    end;
    
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
    ry := 0.0;
    if (p.oz <> 0.0) then ry := arctan2(p.ox, p.oz);
    ry := ry * (180 / PI);	// Convert from radians to degrees

    // Update character scene node position
    h3dSetNodeTransform(p.node, p.px, 0.02, p.pz, 0, ry, 0, 1, 1, 1);

    // Update animation
    p.animTime := p.animTime + vel * 35.0;
    h3dSetModelAnimParams(p.node, 0, p.animTime, 1.0);

    // Push new values back into the array
    _particles[i] := p;
  end;
end;

end.
