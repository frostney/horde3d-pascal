// *************************************************************************************************
//
// Horde3D
//   Next-Generation Graphics Engine
// --------------------------------------
// Copyright (C) 2006-2009 Nicolas Schulz
//
// This software is distributed under the terms of the Eclipse Public License v1.0.
// A copy of the license may be obtained at: http://www.eclipse.org/legal/epl-v10.html
//
// *************************************************************************************************
//
// Version 1.0 Beta5
// (License: MIT and/or EPL)
//
// Pascal bindings by Johannes Stein (https://github.com/Stoney-FD/horde3d-pascal)
// 		Special thanks to Srki_82 (who made Pascal bindings for Horde3D Version 1.0 Beta4),
//		the Horde3D development team and the university of Augsburg
//
//

// Core Unit - This is a more or less exact translation of the C header

unit Horde3D;

interface

{$I Horde3D.inc}

// *************************************************************************************************
// Core Library
// *************************************************************************************************

(*	Constants: Predefined constants
	H3DRootNode  - Scene root node handle
*)
const
  {$IFDEF UNIX}
    {$IFDEF DARWIN}
	  Horde3DLib = 'Horde3D';

      {$IFDEF AUTO_LINK}
	    {$LINKFRAMEWORK Horde3D}
	  {$ENDIF}
	{$ELSE}
	  Horde3DLib = 'libHorde3D.so';
	  
	  {$IFDEF AUTO_LINK}
	    {$LINKLIB Horde3D}
	  {$ENDIF}
	{$ENDIF}
  {$ELSE}
    Horde3DLib = 'Horde3D.dll';
  {$ENDIF}

(* Group: Typedefs and constants *)

type
(*	Constants: Typedefs
	H3DRes   - handle to resource (type: int32)
	H3DNode  - handle to scene node (type: int32)
*)
  TH3DRes = Integer;
  TH3DNode = Integer;

  PH3DRes = ^TH3DRes;
  PH3DNode = ^TH3DNode;

const
  H3DRootNode: TH3DNode = 1;

type
(* Group: Enumerations *)
  TH3DOptions = (
(* Enum: H3DOptions
	    The available engine option parameters.

    MaxLogLevel         - Defines the maximum log level; only messages which are smaller or equal to this value
		          (hence more important) are published in the message queue. (Default: 4)
    MaxNumMessages      - Defines the maximum number of messages that can be stored in the message queue (Default: 512)
    TrilinearFiltering  - Enables or disables trilinear filtering for textures. (Values: 0, 1; Default: 1)
    MaxAnisotropy       - Sets the maximum quality for anisotropic filtering. (Values: 1, 2, 4, 8; Default: 1)
    TexCompression      - Enables or disables texture compression; only affects textures that are
		          loaded after setting the option. (Values: 0, 1; Default: 0)
    SRGBLinearization   - Eanbles or disables gamma-to-linear-space conversion of input textures that are tagged as sRGB (Values: 0, 1; Default: 0)
    LoadTextures        - Enables or disables loading of textures referenced by materials; this can be useful to reduce
		          loading times for testing. (Values: 0, 1; Default: 1)
    FastAnimation       - Disables or enables inter-frame interpolation for animations. (Values: 0, 1; Default: 1)
    ShadowMapSize       - Sets the size of the shadow map buffer (Values: 128, 256, 512, 1024, 2048; Default: 1024)
    SampleCount         - Maximum number of samples used for multisampled render targets; only affects pipelines
		          that are loaded after setting the option. (Values: 0, 2, 4, 8, 16; Default: 0)
    WireframeMode       - Enables or disables wireframe rendering
    DebugViewMode       - Enables or disables debug view where geometry is rendered in wireframe without shaders and
		          lights are visualized using their screen space bounding box. (Values: 0, 1; Default: 0)
    DumpFailedShaders   - Enables or disables storing of shader code that failed to compile in a text file; this can be
		          useful in combination with the line numbers given back by the shader compiler. (Values: 0, 1; Default: 0)
    GatherTimeStats     - Enables or disables gathering of time stats that are useful for profiling (Values: 0, 1; Default: 1)
*)

    H3DOptions_MaxLogLevel = 1,
    H3DOptions_MaxNumMessages,
    H3DOptions_TrilinearFiltering,
    H3DOptions_MaxAnisotropy,
    H3DOptions_TexCompression,
    H3DOptions_SRGBLinearization,
    H3DOptions_LoadTextures,
    H3DOptions_FastAnimation,
    H3DOptions_ShadowMapSize,
    H3DOptions_SampleCount,
    H3DOptions_WireframeMode,
    H3DOptions_DebugViewMode,
    H3DOptions_DumpFailedShaders,
    H3DOptions_GatherTimeStats
  );


  TH3DStats = (
(* Enum: H3DStats
	    The available engine statistic parameters.

    TriCount          - Number of triangles that were pushed to the renderer
    BatchCount        - Number of batches (draw calls)
    LightPassCount    - Number of lighting passes
    FrameTime         - Time in ms between two h3dFinalizeFrame calls
    AnimationTime     - CPU time in ms spent for animation
    GeoUpdateTime     - CPU time in ms spent for software skinning and morphing
    ParticleSimTime   - CPU time in ms spent for particle simulation and updates
    FwdLightsGPUTime  - GPU time in ms spent for forward lighting passes
    DefLightsGPUTime  - GPU time in ms spent for drawing deferred light volumes
    ShadowsGPUTime    - GPU time in ms spent for generating shadow maps
    ParticleGPUTime   - GPU time in ms spent for drawing particles
    TextureVMem       - Estimated amount of video memory used by textures (in Mb)
    GeometryVMem      - Estimated amount of video memory used by geometry (in Mb)
*)
    H3DStats_TriCount = 100,
    H3DStats_BatchCount,
    H3DStats_LightPassCount,
    H3DStats_FrameTime,
    H3DStats_AnimationTime,
    H3DStats_GeoUpdateTime,
    H3DStats_ParticleSimTime,
    H3DStats_FwdLightsGPUTime,
    H3DStats_DefLightsGPUTime,
    H3DStats_ShadowsGPUTime,
    H3DStats_ParticleGPUTime,
    H3DStats_TextureVMem,
    H3DStats_GeometryVMem
  );


  TH3DResTypes = (
(* Enum: H3DResTypes
	    The available resource types.

    Undefined       - An undefined resource, returned by getResourceType in case of error
    SceneGraph      - Scene graph subtree stored in XML format
    Geometry        - Geometrical data containing bones, vertices and triangles
    Animation       - Animation data
    Material        - Material script
    Code            - Text block containing shader source code
    Shader          - Shader program
    Texture         - Texture map
    ParticleEffect  - Particle configuration
    Pipeline        - Rendering pipeline
*)
    H3DResTypes_Undefined = 0,
    H3DResTypes_SceneGraph,
    H3DResTypes_Geometry,
    H3DResTypes_Animation,
    H3DResTypes_Material,
    H3DResTypes_Code,
    H3DResTypes_Shader,
    H3DResTypes_Texture,
    H3DResTypes_ParticleEffect,
    H3DResTypes_Pipeline
  );


  TH3DResFlags = (
(* Enum: H3DResFlags
	    The available flags used when adding a resource.

    NoQuery           - Excludes resource from being listed by queryUnloadedResource function.
    NoTexCompression  - Disables texture compression for Texture resource.
    NoTexMipmaps      - Disables generation of mipmaps for Texture resource.
    TexCubemap        - Sets Texture resource to be a cubemap.
    TexDynamic        - Enables more efficient updates of Texture resource streams.
    TexRenderable     - Makes Texture resource usable as render target.
    TexSRGB           - Indicates that Texture resource is in sRGB color space and should be converted
		        to linear space when being sampled.
*)
    H3DResFlags_NoQuery = 1,
    H3DResFlags_NoTexCompression = 2,
    H3DResFlags_NoTexMipmaps = 4,
    H3DResFlags_TexCubemap = 8,
    H3DResFlags_TexDynamic = 16,
    H3DResFlags_TexRenderable = 32,
    H3DResFlags_TexSRGB = 64
  );


  TH3DFormats = (
(* Enum: H3DFormats
	    The available resource stream formats.

    Unknown      - Unknown format
    TEX_BGRA8    - 8-bit BGRA texture
    TEX_DXT1     - DXT1 compressed texture
    TEX_DXT3     - DXT3 compressed texture
    TEX_DXT5     - DXT5 compressed texture
    TEX_RGBA16F  - Half float RGBA texture
    TEX_RGBA32F  - Float RGBA texture
*)
    H3DFormats_Unknown = 0,
    H3DFormats_TEX_BGRA8,
    H3DFormats_TEX_DXT1,
    H3DFormats_TEX_DXT3,
    H3DFormats_TEX_DXT5,
    H3DFormats_TEX_RGBA16F,
    H3DFormats_TEX_RGBA32F
  );


  TH3DGeoRes = (
(* Enum: H3DGeoRes
	    The available Geometry resource accessors.

    GeometryElem         - Base element
    GeoIndexCountI       - Number of indices [read-only]
    GeoVertexCountI      - Number of vertices [read-only]
    GeoIndices16I        - Flag indicating whether index data is 16 or 32 bit [read-only]
    GeoIndexStream       - Triangle index data (uint16 or uint32, depending on flag)
    GeoVertPosStream     - Vertex position data (float x, y, z)
    GeoVertTanStream     - Vertex tangent frame data (float nx, ny, nz, tx, ty, tz, tw)
    GeoVertStaticStream  - Vertex static attribute data (float u0, v0,
		             float4 jointIndices, float4 jointWeights, float u1, v1)
*)
    H3DGeoRes_GeometryElem = 200,
    H3DGeoRes_GeoIndexCountI,
    H3DGeoRes_GeoVertexCountI,
    H3DGeoRes_GeoIndices16I,
    H3DGeoRes_GeoIndexStream,
    H3DGeoRes_GeoVertPosStream,
    H3DGeoRes_GeoVertTanStream,
    H3DGeoRes_GeoVertStaticStream
  );


  TH3DAnimRes = (
(* Enum: H3DAnimRes
	    The available Animation resource accessors.

    EntityElem      - Stored animation entities (joints and meshes)
    EntFrameCountI  - Number of frames stored for a specific entity [read-only]
*)
    H3DAnimRes_EntityElem = 300,
    H3DAnimRes_EntFrameCountI
  );


  TH3DMatRes = (
(* Enum: H3DMatRes
	    The available Material resource accessors.

    MaterialElem  - Base element
    SamplerElem   - Sampler element
    UniformElem   - Uniform element
    MatClassStr   - Material class
    MatLinkI      - Material resource that is linked to this material
    MatShaderI    - Shader resource
    SampNameStr   - Name of sampler [read-only]
    SampTexResI   - Texture resource bound to sampler
    UnifNameStr   - Name of uniform [read-only]
    UnifValueF4   - Value of uniform (a, b, c, d)
*)
    H3DMatRes_MaterialElem = 400,
    H3DMatRes_SamplerElem,
    H3DMatRes_UniformElem,
    H3DMatRes_MatClassStr,
    H3DMatRes_MatLinkI,
    H3DMatRes_MatShaderI,
    H3DMatRes_SampNameStr,
    H3DMatRes_SampTexResI,
    H3DMatRes_UnifNameStr,
    H3DMatRes_UnifValueF4
  );


  TH3DShaderRes = (
(* Enum: H3DShaderRes
	    The available Shader resource accessors.

    ContextElem     - Context element
    SamplerElem     - Sampler element
    UniformElem     - Uniform element
    ContNameStr     - Name of context [read-only]
    SampNameStr     - Name of sampler [read-only]
    UnifNameStr     - Name of uniform [read-only]
    UnifSizeI       - Size (number of components) of uniform [read-only]
    UnifDefValueF4  - Default value of uniform (a, b, c, d)
*)
    H3DShaderRes_ContextElem = 600,
    H3DShaderRes_SamplerElem,
    H3DShaderRes_UniformElem,
    H3DShaderRes_ContNameStr,
    H3DShaderRes_SampNameStr,
    H3DShaderRes_UnifNameStr,
    H3DShaderRes_UnifSizeI,
    H3DShaderRes_UnifDefValueF4
  );

  TH3DTexRes = (
(* Enum: H3DTexRes
	    The available Texture resource accessors.

    TextureElem     - Base element
    ImageElem       - Subresources of the texture. A texture consists, depending on the type,
		      of a number of equally sized slices which again can have a fixed number
		      of mipmaps. Each image element represents the base image of a slice or
		      a single mipmap level of the corresponding slice.
    TexFormatI      - Texture format [read-only]
    TexSliceCountI  - Number of slices (1 for 2D texture and 6 for cubemap) [read-only]
    ImgWidthI       - Image width [read-only]
    ImgHeightI      - Image height [read-only]
    ImgPixelStream  - Pixel data of an image. The data layout matches the layout specified
		      by the texture format with the exception that half-float is converted
		      to float. The first element in the data array corresponds to the lower
		      left corner.
*)
    H3DTexRes_TextureElem = 700,
    H3DTexRes_ImageElem,
    H3DTexRes_TexFormatI,
    H3DTexRes_TexSliceCountI,
    H3DTexRes_ImgWidthI,
    H3DTexRes_ImgHeightI,
    H3DTexRes_ImgPixelStream
  );

  TH3DPartEffRes = (
(* Enum: H3DPartEffRes
	    The available ParticleEffect resource accessors.

    ParticleElem     - General particle configuration
    ChanMoveVelElem  - Velocity channel
    ChanRotVelElem   - Angular velocity channel
    ChanSizeElem     - Size channel
    ChanColRElem     - Red color component channel
    ChanColGElem     - Green color component channel
    ChanColBElem     - Blue color component channel
    ChanColAElem     - Alpha channel
    PartLifeMinF     - Minimum value of random life time (in seconds)
    PartLifeMaxF     - Maximum value of random life time (in seconds)
    ChanStartMinF    - Minimum for selecting initial random value of channel
    ChanStartMaxF    - Maximum for selecting initial random value of channel
    ChanEndRateF     - Remaining percentage of initial value when particle is dying
*)
    H3DPartEffRes_ParticleElem = 800,
    H3DPartEffRes_ChanMoveVelElem,
    H3DPartEffRes_ChanRotVelElem,
    H3DPartEffRes_ChanSizeElem,
    H3DPartEffRes_ChanColRElem,
    H3DPartEffRes_ChanColGElem,
    H3DPartEffRes_ChanColBElem,
    H3DPartEffRes_ChanColAElem,
    H3DPartEffRes_PartLifeMinF,
    H3DPartEffRes_PartLifeMaxF,
    H3DPartEffRes_ChanStartMinF,
    H3DPartEffRes_ChanStartMaxF,
    H3DPartEffRes_ChanEndRateF,
    H3DPartEffRes_ChanDragElem
  );

  TH3DPipeRes = (
(* Enum: H3DPipeRes
	    The available Pipeline resource accessors.

    StageElem         - Pipeline stage
    StageNameStr      - Name of stage [read-only]
    StageActivationI  - Flag indicating whether stage is active
*)
    H3DPipeRes_StageElem = 900,
    H3DPipeRes_StageNameStr,
    H3DPipeRes_StageActivationI
  );


  TH3DNodeTypes = (
(*	Enum: H3DNodeTypes
	    The available scene node types.

    Undefined  - An undefined node type, returned by getNodeType in case of error
    Group      - Group of different scene nodes
    Model      - 3D model with optional skeleton
    Mesh       - Subgroup of a model with triangles of one material
    Joint      - Joint for skeletal animation
    Light      - Light source
    Camera     - Camera giving view on scene
    Emitter    - Particle system emitter
*)
    H3DNodeTypes_Undefined = 0,
    H3DNodeTypes_Group,
    H3DNodeTypes_Model,
    H3DNodeTypes_Mesh,
    H3DNodeTypes_Joint,
    H3DNodeTypes_Light,
    H3DNodeTypes_Camera,
    H3DNodeTypes_Emitter
  );

  TH3DNodeFlags = (
(*	Enum: H3DNodeFlags
	    The available scene node flags.

    NoDraw         - Excludes scene node from all rendering
    NoCastShadow   - Excludes scene node from list of shadow casters
    NoRayQuery     - Excludes scene node from ray intersection queries
    Inactive       - Deactivates scene node so that it is completely ignored
		     (combination of all flags above)
*)
    H3DNodeFlags_NoDraw = 1,
    H3DNodeFlags_NoCastShadow = 2,
    H3DNodeFlags_NoRayQuery = 4,
    H3DNodeFlags_Inactive = 7  // NoDraw | NoCastShadow | NoRayQuery
  );

  TH3DNodeParams = (
(*	Enum: H3DNodeParams
	    The available scene node parameters.

    NameStr        - Name of the scene node
    AttachmentStr  - Optional application-specific meta data for a node encapsulated
		     in an 'Attachment' XML string
*)
    H3DNodeParams_NameStr = 1,
    H3DNodeParams_AttachmentStr
  );

  TH3DModel = (
(*	Enum: H3DModel
	    The available Model node parameters

    GeoResI      - Geometry resource used for the model
    SWSkinningI  - Enables or disables software skinning (default: 0)
    LodDist1F    - Distance to camera from which on LOD1 is used (default: infinite)
		   (must be a positive value larger than 0.0)
    LodDist2F    - Distance to camera from which on LOD2 is used
		   (may not be smaller than LodDist1) (default: infinite)
    LodDist3F    - Distance to camera from which on LOD3 is used
		   (may not be smaller than LodDist2) (default: infinite)
    LodDist4F    - Distance to camera from which on LOD4 is used
		   (may not be smaller than LodDist3) (default: infinite)
*)
    H3DModel_GeoResI = 200,
    H3DModel_SWSkinningI,
    H3DModel_LodDist1F,
    H3DModel_LodDist2F,
    H3DModel_LodDist3F,
    H3DModel_LodDist4F
  );

  TH3DMesh = (
(*	Enum: H3DMesh
	    The available Mesh node parameters.

    MatResI      - Material resource used for the mesh
    BatchStartI  - First triangle index of mesh in Geometry resource of parent Model node [read-only]
    BatchCountI  - Number of triangle indices used for drawing mesh [read-only]
    VertRStartI  - First vertex in Geometry resource of parent Model node [read-only]
    VertREndI    - Last vertex in Geometry resource of parent Model node [read-only]
    LodLevelI    - LOD level of Mesh; the mesh is only rendered if its LOD level corresponds to
		   the model's current LOD level which is calculated based on the LOD distances (default: 0)
*)
    H3DMesh_MatResI = 300,
    H3DMesh_BatchStartI,
    H3DMesh_BatchCountI,
    H3DMesh_VertRStartI,
    H3DMesh_VertREndI,
    H3DMesh_LodLevelI
  );

  TH3DJoint = (
(*	Enum: H3DJoint
	    The available Joint node parameters.

    JointIndexI  - Index of joint in Geometry resource of parent Model node [read-only]
*)
    H3DJoint_JointIndexI = 400
  );

  TH3DLight = (
(*	Enum: H3DLight
	    The available Light node parameters.

    MatResI             - Material resource used for the light
    RadiusF             - Radius of influence (default: 100.0)
    FovF                - Field of view (FOV) angle (default: 90.0)
    ColorF3             - Diffuse color RGB (default: 1.0, 1.0, 1.0)
    ColorMultiplierF    - Diffuse color multiplier for altering intensity, mainly useful for HDR (default: 1.0)
    ShadowMapCountI     - Number of shadow maps used for light source (values: 0, 1, 2, 3, 4; default: 0)]
    ShadowSplitLambdaF  - Constant determining segmentation of view frustum for Parallel Split Shadow Maps (default: 0.5)
    ShadowMapBiasF      - Bias value for shadow mapping to reduce shadow acne (default: 0.005)
    LightingContextStr  - Name of shader context used for computing lighting
    ShadowContextStr    - Name of shader context used for generating shadow map
*)
    H3DLight_MatResI = 500,
    H3DLight_RadiusF,
    H3DLight_FovF,
    H3DLight_ColorF3,
    H3DLight_ColorMultiplierF,
    H3DLight_ShadowMapCountI,
    H3DLight_ShadowSplitLambdaF,
    H3DLight_ShadowMapBiasF,
    H3DLight_LightingContextStr,
    H3DLight_ShadowContextStr
  );

  TH3DCamera = (
(*	Enum: H3DCamera
	    The available Camera node parameters.

    PipeResI         - Pipeline resource used for rendering
    OutTexResI       - 2D Texture resource used as output buffer (can be 0 to use main framebuffer) (default: 0)
    OutBufIndexI     - Index of the output buffer for stereo rendering (values: 0 for left eye, 1 for right eye) (default: 0)
    LeftPlaneF       - Coordinate of left plane relative to near plane center (default: -0.055228457)
    RightPlaneF      - Coordinate of right plane relative to near plane center (default: 0.055228457)
    BottomPlaneF     - Coordinate of bottom plane relative to near plane center (default: -0.041421354f)
    TopPlaneF        - Coordinate of top plane relative to near plane center (default: 0.041421354f)
    NearPlaneF       - Distance of near clipping plane (default: 0.1)
    FarPlaneF        - Distance of far clipping plane (default: 1000)
    ViewportXI       - Position x-coordinate of the lower left corner of the viewport rectangle (default: 0)
    ViewportYI       - Position y-coordinate of the lower left corner of the viewport rectangle (default: 0)
    ViewportWidthI   - Width of the viewport rectangle (default: 320)
    ViewportHeightI  - Height of the viewport rectangle (default: 240)
    OrthoI           - Flag for setting up an orthographic frustum instead of a perspective one (default: 0)
    OccCullingI      - Flag for enabling occlusion culling (default: 0)
*)
    H3DCamera_PipeResI = 600,
    H3DCamera_OutTexResI,
    H3DCamera_OutBufIndexI,
    H3DCamera_LeftPlaneF,
    H3DCamera_RightPlaneF,
    H3DCamera_BottomPlaneF,
    H3DCamera_TopPlaneF,
    H3DCamera_NearPlaneF,
    H3DCamera_FarPlaneF,
    H3DCamera_ViewportXI,
    H3DCamera_ViewportYI,
    H3DCamera_ViewportWidthI,
    H3DCamera_ViewportHeightI,
    H3DCamera_OrthoI,
    H3DCamera_OccCullingI
  );

  TH3DEmitter = (
(*	Enum: H3DEmitter
	    The available Emitter node parameters.

    MatResI        - Material resource used for rendering
    PartEffResI    - ParticleEffect resource which configures particle properties
    MaxCountI      - Maximal number of particles living at the same time
    RespawnCountI  - Number of times a single particle is recreated after dying (-1 for infinite)
    DelayF         - Time in seconds before emitter begins creating particles (default: 0.0)
    EmissionRateF  - Maximal number of particles to be created per second (default: 0.0)
    SpreadAngleF   - Angle of cone for random emission direction (default: 0.0)
    ForceF3        - Force vector XYZ applied to particles (default: 0.0, 0.0, 0.0)
*)
    H3DEmitter_MatResI = 700,
    H3DEmitter_PartEffResI,
    H3DEmitter_MaxCountI,
    H3DEmitter_RespawnCountI,
    H3DEmitter_DelayF,
    H3DEmitter_EmissionRateF,
    H3DEmitter_SpreadAngleF,
    H3DEmitter_ForceF3
  );

  (* Group: Basic functions *)
  function h3dGetVersionString(): PAnsiChar; cdecl; external Horde3DLib;
  function h3dCheckExtension(extensionName: PAnsiChar): Boolean; cdecl; external Horde3DLib;
  function h3dGetError(): Boolean; cdecl; external Horde3DLib;
  function h3dInit(): Boolean; cdecl; external Horde3DLib;
  procedure h3dRelease(); cdecl; external Horde3DLib;
  procedure h3dRender(cameraNode: TH3DNode); cdecl; external Horde3DLib;
  procedure h3dFinalizeFrame(); cdecl; external Horde3DLib;
  procedure h3dClear(); cdecl; external Horde3DLib;


  // --- General functions ---
  function h3dGetMessage(var level: Integer; var time: Single): PAnsiChar; cdecl; external Horde3DLib;
  function h3dGetOption(param: TH3DOptions): Single; cdecl; external Horde3DLib;
  function h3dSetOption(param: TH3DOptions; value: Single): Boolean; cdecl; external Horde3DLib;
  function h3dGetStat(param: TH3DStats; reset: Boolean): Single; cdecl; external Horde3DLib;
  procedure h3dShowOverlays(const verts: PSingle; vertCount: Integer; colR: Single; colG: Single; colB: Single;
                            colA: Single; materialRes: TH3DRes; flags: Integer); cdecl; external Horde3DLib;
  procedure h3dClearOverlays(); cdecl; external Horde3DLib;
  function h3dGetResType(res: TH3DRes): Integer; cdecl; external Horde3DLib;
  function h3dGetResName(res: TH3DRes): PAnsiChar; cdecl; external Horde3DLib;
  function h3dGetNextResource(type_: Integer; start: TH3DRes): TH3DRes; cdecl; external Horde3DLib;
  function h3dFindResource(type_: TH3DResTypes; const name: PAnsiChar): TH3DRes; cdecl; external Horde3DLib;
  function h3dAddResource(type_: TH3DResTypes; const name: PAnsiChar; flags: Integer): TH3DRes; cdecl; external Horde3DLib;
  function h3dCloneResource(sourceRes: TH3DRes; const name: PAnsiChar): TH3DRes; cdecl; external Horde3DLib;
  function h3dRemoveResource(res: TH3DRes): Integer; cdecl; external Horde3DLib;
  function h3dIsResLoaded(res: TH3DRes): Boolean; cdecl; external Horde3DLib;
  function h3dLoadResource(res: TH3DRes; const data: PAnsiChar; size: Integer): Boolean; cdecl; external Horde3DLib;
  procedure h3dUnloadResource(res: TH3DRes); cdecl; external Horde3DLib;
  function h3dGetResElemCount(res: TH3DRes; elem: Integer): Integer; cdecl; external Horde3DLib;
  function h3dFindResElem(res: TH3DRes; elem: Integer; param: Integer; const value: PAnsiChar): Integer; cdecl; external Horde3DLib;
  function h3dGetResParamI(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer): Integer; cdecl; external Horde3DLib;
  procedure h3dSetResParamI(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer; value : Integer); cdecl; external Horde3DLib;
  function h3dGetResParamF(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer; compIdx: Integer): Single; cdecl; external Horde3DLib;
  procedure h3dSetResParamF(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer; compIdx: Integer; value: Single); cdecl; external Horde3DLib;
  function h3dGetResParamStr(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer): PAnsiChar; cdecl; external Horde3DLib;
  procedure h3dSetResParamStr(res: TH3DRes; elem: Integer; elemIdx: Integer; param: Integer; const value: PAnsiChar); cdecl; external Horde3DLib;
  function h3dMapResStream(res: TH3DRes; elem: Integer; elemIdx: Integer; stream: Integer; read: Boolean; write: Boolean): Pointer; cdecl; external Horde3DLib;
  procedure h3dUnmapResStream(res: TH3DRes); cdecl; external Horde3DLib;
  function h3dQueryUnloadedResource(index: Integer): TH3DRes; cdecl; external Horde3DLib;
  procedure h3dReleaseUnusedResources(); cdecl; external Horde3DLib;


  (* Group: Specific resource management functions *)
  function h3dCreateTexture(const name: PAnsiChar; width: Integer; height: Integer; fmt: Integer; flags: Integer): TH3DRes; cdecl; external Horde3DLib;
  procedure h3dSetShaderPreambles(const vertPreamble: PAnsiChar; const fragPreamble: PAnsiChar); cdecl; external Horde3DLib;
  function h3dSetMaterialUniform(materialRes: TH3DRes; const name: PAnsiChar; a: Single; b: Single; c: Single; d: Single): Boolean; cdecl; external Horde3DLib;
  procedure h3dResizePipelineBuffers(pipeRes: TH3DRes; width: Integer; height: Integer); cdecl; external Horde3DLib;
  function h3dGetRenderTargetData(pipelineRes: TH3DRes; const targetName: PAnsiChar; bufIndex: Integer;
                                  var width: Integer; var height: Integer; var compCount: Integer; dataBuffer: Pointer; bufferSize: Integer): Boolean; cdecl; external Horde3DLib;


  (* Group: General scene graph functions *)
  function h3dGetNodeType(node: TH3DNode): Integer; cdecl; external Horde3DLib;
  function h3dGetNodeParent(node: TH3DNode): TH3DNode; cdecl; external Horde3DLib;
  function h3dSetNodeParent(node: TH3DNode; parent: TH3DNode): Boolean; cdecl; external Horde3DLib;
  function h3dGetNodeChild(node: TH3DNode; index: Integer): TH3DNode; cdecl; external Horde3DLib;
  function h3dAddNodes(parent: TH3DNode; sceneGraphRes: TH3DRes): TH3DNode; cdecl; external Horde3DLib;
  procedure h3dRemoveNode(node: TH3DNode); cdecl; external Horde3DLib;
  function h3dCheckNodeTransFlag(node: TH3DNode; reset: Boolean): Boolean; cdecl; external Horde3DLib;
  procedure h3dGetNodeTransform(node: TH3DNode; var tx: Single; var ty: Single; var tz: Single;
                                var rx: Single; var ry: Single; var rz: Single; var sx: Single; var sy: Single; var sz: Single); cdecl; external Horde3DLib;
  procedure h3dSetNodeTransform(node: TH3DNode; tx: Single; ty: Single; tz: Single;
                                rx: Single; ry: Single; rz: Single; sx: Single; sy: Single; sz: Single); cdecl; external Horde3DLib;
  procedure h3dGetNodeTransMats(node: TH3DNode; var relMat: PSingle; var absMat: PSingle); cdecl; external Horde3DLib;
  procedure h3dSetNodeTransMat(node: TH3DNode; const mat4x4: PSingle); cdecl; external Horde3DLib;
  function h3dGetNodeParamI(node: TH3DNode; param: Integer): Integer; cdecl; external Horde3DLib;
  procedure h3dSetNodeParamI(node: TH3DNode; param: Integer; value: Integer); cdecl; external Horde3DLib;
  function h3dGetNodeParamF(node: TH3DNode; param: Integer; compIdx: Integer): Single; cdecl; external Horde3DLib;
  procedure h3dSetNodeParamF(node: TH3DNode; param: Integer; compIdx: Integer; value: Single); cdecl; external Horde3DLib;
  function h3dGetNodeParamStr(node: TH3DNode; param: Integer): PAnsiChar; cdecl; external Horde3DLib;
  procedure h3dSetNodeParamStr(node: TH3DNode; param: Integer; const value: PAnsiChar); cdecl; external Horde3DLib;
  function h3dGetNodeFlags(node: TH3DNode): Integer; cdecl; external Horde3DLib;
  procedure h3dSetNodeFlags(node: TH3DNode; flags: Integer; recursive: Boolean); cdecl; external Horde3DLib;
  procedure h3dGetNodeAABB(node: TH3DNode; var minX: Single; var minY: Single; var minZ: Single;
                           var maxX: Single; var maxY: Single; var maxZ: Single); cdecl; external Horde3DLib;
  function h3dFindNodes(startNode: TH3DNode; name: PAnsiChar; type_: TH3DNodeTypes): Integer; cdecl; external Horde3DLib;
  function h3dGetNodeFindResult(index: Integer): TH3DNode; cdecl; external Horde3DLib;
  function h3dCastRay(node: TH3DNode; ox: Single; oy: Single; oz: Single; dx: Single; dy: Single; dz: Single; numNearest: Integer): Integer; cdecl; external Horde3DLib;
  function h3dGetCastRayResult(index: Integer; node: PH3DNode; var distance: Single; var intersection: Single): Boolean; cdecl; external Horde3DLib;
  function h3dCheckNodeVisibility(node: TH3DNode; cameraNode: TH3DNode; checkOcclusion: Boolean; calcLod: Boolean): Integer; cdecl; external Horde3DLib;


  (* Group: Group-specific scene graph functions *)
  function h3dAddGroupNode(parent: TH3DNode; const name: PAnsiChar): TH3DNode; cdecl; external Horde3DLib;


  (* Group: Model-specific scene graph functions *)
  function h3dAddModelNode(parent: TH3DNode; const name: PAnsiChar; geometryRes: TH3DRes): TH3DNode; cdecl; external Horde3DLib;
  procedure h3dSetupModelAnimStage(modelNode: TH3DNode; stage: Integer; animationRes: TH3DRes; layer: Integer;
                                   const startNode: PAnsiChar; additive: Boolean); cdecl; external Horde3DLib;
  procedure h3dSetModelAnimParams(modelNode: TH3DNode; stage: Integer; time: Single; weight: Single); cdecl; external Horde3DLib;
  function h3dSetModelMorpher(modelNode: TH3DNode; const target: PAnsiChar; weight: Single): Boolean; cdecl; external Horde3DLib;


  (* Group: Mesh-specific scene graph functions *)
  function h3dAddMeshNode(parent: TH3DNode; const name: PAnsiChar; materialRes: TH3DRes;
                          batchStart: Integer; batchCount: Integer; vertRStart: Integer; vertREnd: Integer): TH3DNode; cdecl; external Horde3DLib;


  (* Group: Joint-specific scene graph functions *)
  function h3dAddJointNode(parent: TH3DNode; const name: PAnsiChar; jointIndex: Integer): TH3DNode; cdecl; external Horde3DLib;


  (* Group: Light-specific scene graph functions *)
  function h3dAddLightNode(parent: TH3DNode; const name: PAnsiChar; materialRes: TH3DRes;
                           const lightingContext: PAnsiChar; const shadowContext: PAnsiChar): TH3DNode; cdecl; external Horde3DLib;


  (* Group: Camera-specific scene graph functions *)
  function h3dAddCameraNode(parent: TH3DNode; const name: PAnsiChar; pipelineRes: TH3DRes): TH3DNode; cdecl; external Horde3DLib;
  procedure h3dSetupCameraView(cameraNode: TH3DNode; fov: Single; aspect: Single; nearDist: Single; farDist: Single); cdecl; external Horde3DLib;
  procedure h3dGetCameraProjMat(cameraNode: TH3DNode; var projMat: Single); cdecl; external Horde3DLib;


  (* Group: Emitter-specific scene graph functions *)
  function h3dAddEmitterNode(parent: TH3DNode; const name: PAnsiChar; materialRes: TH3DRes;
                             particleEffectRes: TH3DRes; maxParticleCount: Integer; respawnCount: Integer): TH3DNode; cdecl; external Horde3DLib;
  procedure h3dAdvanceEmitterTime(emitterNode: TH3DNode; timeDelta: Single); cdecl; external Horde3DLib;
  function h3dHasEmitterFinished(emitterNode: TH3DNode): Boolean; cdecl; external Horde3DLib;

implementation

end.

