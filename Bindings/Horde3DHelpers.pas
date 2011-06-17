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

// This unit provides classes and stuff

unit Horde3DHelpers;

(*	Topic: Conventions
		Some conventions for the API.
	
	Horde3D uses a right-handed coordinate system, where y is the up-axis and the positive z-axis is
	pointing out of the screen. The rotations are specified in degrees and rotation direction is
	counter-clockwise when looking down the axis from the the positive end towards the origin. View
	vectors like the camera or light direction are always pointing along the negative z-axis when no
	transformation is applied. Matrices in Horde are stored in a column-major memory layout. When
	Euler angles are used, the rotation order is YXZ [*vec], so the z-rotation is applied first.
*)

interface

{$I Horde3D.inc}

uses
  Horde3D, Horde3DUtils;
  
type
  { TH3DOptionsHelper }

  TH3DOptionsHelper = class
  private
    function GetDebugViewMode: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetDumpFailedShaders: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetFastAnimation: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGatherTimeStats: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLoadTextures: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaxAnisotropy: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaxLogLevel: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaxNumMessages: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSampleCount: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowMapSize: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSRGBLinearization: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexCompression: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTrilinearFiltering: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetWireframeMode: TH3DOptions; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property MaxLogLevel: TH3DOptions read GetMaxLogLevel;
    property MaxNumMessages: TH3DOptions read GetMaxNumMessages;
    property TrilinearFiltering: TH3DOptions read GetTrilinearFiltering;
    property MaxAnisotropy: TH3DOptions read GetMaxAnisotropy;
    property TexCompression: TH3DOptions read GetTexCompression;
    property SRGBLinearization: TH3DOptions read GetSRGBLinearization;
    property LoadTextures: TH3DOptions read GetLoadTextures;
    property FastAnimation: TH3DOptions read GetFastAnimation;
    property ShadowMapSize: TH3DOptions read GetShadowMapSize;
    property SampleCount: TH3DOptions read GetSampleCount;
    property WireframeMode: TH3DOptions read GetWireframeMode;
    property DebugViewMode: TH3DOptions read GetDebugViewMode;
    property DumpFailedShaders: TH3DOptions read GetDumpFailedShaders;
    property GatherTimeStats: TH3DOptions read GetGatherTimeStats;
  end;


  { TH3DStatsHelper }

  TH3DStatsHelper = class
  private
    function GetAnimationTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetBatchCount: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetDefLightsGPUTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetFrameTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetFwdLightsGPUTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeometryVMem: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoUpdateTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLightPassCount: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetParticleGPUTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetParticleSimTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowsGPUTime: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTextureVMem: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTriCount: TH3DStats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property TriCount: TH3DStats read GetTriCount;
    property BatchCount: TH3DStats read GetBatchCount;
    property LightPassCount: TH3DStats read GetLightPassCount;
    property FrameTime: TH3DStats read GetFrameTime;
    property AnimationTime: TH3DStats read GetAnimationTime;
    property GeoUpdateTime: TH3DStats read GetGeoUpdateTime;
    property ParticleSimTime: TH3DStats read GetParticleSimTime;
    property FwdLightsGPUTime: TH3DStats read GetFwdLightsGPUTime;
    property DefLightsGPUTime: TH3DStats read GetDefLightsGPUTime;
    property ShadowsGPUTime: TH3DStats read GetShadowsGPUTime;
    property ParticleGPUTime: TH3DStats read GetParticleGPUTime;
    property TextureVMem: TH3DStats read GetTextureVMem;
    property GeometryVMem: TH3DStats read GetGeometryVMem;
  end;


  { TH3DResTypesHelper }

  TH3DResTypesHelper = class
  private
    function GetAnimation: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetCode: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeometry: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaterial: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetParticleEffect: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetPipeline: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSceneGraph: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShader: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexture: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUndefined: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property Undefined: TH3DResTypes read GetUndefined;
    property SceneGraph: TH3DResTypes read GetSceneGraph;
    property Geometry: TH3DResTypes read GetGeometry;
    property Animation: TH3DResTypes read GetAnimation;
    property Material: TH3DResTypes read GetMaterial;
    property Code: TH3DResTypes read GetCode;
    property Shader: TH3DResTypes read GetShader;
    property Texture: TH3DResTypes read GetTexture;
    property ParticleEffect: TH3DResTypes read GetParticleEffect;
    property Pipeline: TH3DResTypes read GetPipeline;
  end;


  { TH3DResFlagsHelper }

  TH3DResFlagsHelper = class
  private
    function GetNoQuery: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNoTexCompression: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNoTexMipmaps: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexCubemap: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexDynamic: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexRenderable: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexSRGB: TH3DResFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property NoQuery: TH3DResFlags read GetNoQuery;
    property NoTexCompression: TH3DResFlags read GetNoTexCompression;
    property NoTexMipmaps: TH3DResFlags read GetNoTexMipmaps;
    property TexCubemap: TH3DResFlags read GetTexCubemap;
    property TexDynamic: TH3DResFlags read GetTexDynamic;
    property TexRenderable: TH3DResFlags read GetTexRenderable;
    property TexSRGB: TH3DResFlags read GetTexSRGB;
  end;


  { TH3DFormatsHelper }

  TH3DFormatsHelper = class
  private
    function GetTEX_BGRA8: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTEX_DXT1: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTEX_DXT3: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTEX_DXT5: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTEX_RGBA16F: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTEX_RGBA32F: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnknown: TH3DFormats; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property Unknown: TH3DFormats read GetUnknown;
    property TEX_BGRA8: TH3DFormats read GetTEX_BGRA8;
    property TEX_DXT1: TH3DFormats read GetTEX_DXT1;
    property TEX_DXT3: TH3DFormats read GetTEX_DXT3;
    property TEX_DXT5: TH3DFormats read GetTEX_DXT5;
    property TEX_RGBA16F: TH3DFormats read GetTEX_RGBA16F;
    property TEX_RGBA32F: TH3DFormats read GetTEX_RGBA32F;
  end;


  { TH3DGeoResHelper }

  TH3DGeoResHelper = class
  private
    function GetGeoIndexCountI: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoIndexStream: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoIndices16I: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeometryElem: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoVertexCountI: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoVertPosStream: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoVertStaticStream: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGeoVertTanStream: TH3DGeoRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property GeometryElem: TH3DGeoRes read GetGeometryElem;
    property GeoIndexCountI: TH3DGeoRes read GetGeoIndexCountI;
    property GeoVertexCountI: TH3DGeoRes read GetGeoVertexCountI;
    property GeoIndices16I: TH3DGeoRes read GetGeoIndices16I;
    property GeoIndexStream: TH3DGeoRes read GetGeoIndexStream;
    property GeoVertPosStream: TH3DGeoRes read GetGeoVertPosStream;
    property GeoVertTanStream: TH3DGeoRes read GetGeoVertTanStream;
    property GeoVertStaticStream: TH3DGeoRes read GetGeoVertStaticStream;
  end;


  { TH3DAnimResHelper }

  TH3DAnimResHelper = class
  private
    function GetEntFrameCountI: TH3DAnimRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetEntityElem: TH3DAnimRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property EntityElem: TH3DAnimRes read GetEntityElem;
    property EntFrameCountI: TH3DAnimRes read GetEntFrameCountI;
  end;


  { TH3DMatResHelper }

  TH3DMatResHelper = class
  private
    function GetMatClassStr: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaterialElem: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMatLinkI: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMatShaderI: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSamplerElem: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSampNameStr: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSampTexResI: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnifNameStr: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUniformElem: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnifValueF4: TH3DMatRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property MaterialElem: TH3DMatRes read GetMaterialElem;
    property SamplerElem: TH3DMatRes read GetSamplerElem;
    property UniformElem: TH3DMatRes read GetUniformElem;
    property MatClassStr: TH3DMatRes read GetMatClassStr;
    property MatLinkI: TH3DMatRes read GetMatLinkI;
    property MatShaderI: TH3DMatRes read GetMatShaderI;
    property SampNameStr: TH3DMatRes read GetSampNameStr;
    property SampTexResI: TH3DMatRes read GetSampTexResI;
    property UnifNameStr: TH3DMatRes read GetUnifNameStr;
    property UnifValueF4: TH3DMatRes read GetUnifValueF4;
  end;


  { TH3DShaderResHelper }

  TH3DShaderResHelper = class
  private
    function GetContextElem: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetContNameStr: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSamplerElem: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSampNameStr: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnifDefValueF: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnifNameStr: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUniformElem: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUnifSizeI: TH3DShaderRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property ContextElem: TH3DShaderRes read GetContextElem;
    property SamplerElem: TH3DShaderRes read GetSamplerElem;
    property UniformElem: TH3DShaderRes read GetUniformElem;
    property ContNameStr: TH3DShaderRes read GetContNameStr;
    property SampNameStr: TH3DShaderRes read GetSampNameStr;
    property UnifNameStr: TH3DShaderRes read GetUnifNameStr;
    property UnifSizeI: TH3DShaderRes read GetUnifSizeI;
    property UnifDefValueF4: TH3DShaderRes read GetUnifDefValueF;
  end;

  { TH3DTexResHelper }

  TH3DTexResHelper = class
  private
    function GetImageElem: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetImgHeightI: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetImgPixelStream: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetImgWidthI: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexFormatI: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTexSliceCountI: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTextureElem: TH3DTexRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property TextureElem: TH3DTexRes read GetTextureElem;
    property ImageElem: TH3DTexRes read GetImageElem;
    property TexFormatI: TH3DTexRes read GetTexFormatI;
    property TexSliceCountI: TH3DTexRes read GetTexSliceCountI;
    property ImgWidthI: TH3DTexRes read GetImgWidthI;
    property ImgHeightI: TH3DTexRes read GetImgHeightI;
    property ImgPixelStream: TH3DTexRes read GetImgPixelStream;
  end;

  { TH3DPartEffResHelper }

  TH3DPartEffResHelper = class
  private
    function GetChanColAElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanColBElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanColGElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanColRElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanDragElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanEndRateF: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanMoveVelElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanRotVelElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanSizeElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanStartMaxF: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetChanStartMinF: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetParticleElem: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetPartLifeMaxF: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetPartLifeMinF: TH3DPartEffRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property ParticleElem: TH3DPartEffRes read GetParticleElem;
    property ChanMoveVelElem: TH3DPartEffRes read GetChanMoveVelElem;
    property ChanRotVelElem: TH3DPartEffRes read GetChanRotVelElem;
    property ChanSizeElem: TH3DPartEffRes read GetChanSizeElem;
    property ChanColRElem: TH3DPartEffRes read GetChanColRElem;
    property ChanColGElem: TH3DPartEffRes read GetChanColGElem;
    property ChanColBElem: TH3DPartEffRes read GetChanColBElem;
    property ChanColAElem: TH3DPartEffRes read GetChanColAElem;
    property PartLifeMinF: TH3DPartEffRes read GetPartLifeMinF;
    property PartLifeMaxF: TH3DPartEffRes read GetPartLifeMaxF;
    property ChanStartMinF: TH3DPartEffRes read GetChanStartMinF;
    property ChanStartMaxF: TH3DPartEffRes read GetChanStartMaxF;
    property ChanEndRateF: TH3DPartEffRes read GetChanEndRateF;
    property ChanDragElem: TH3DPartEffRes read GetChanDragElem;
  end;

  { TH3DPipeResHelper }

  TH3DPipeResHelper = class
  private
    function GetStageActivationI: TH3DPipeRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetStageElem: TH3DPipeRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetStageNameStr: TH3DPipeRes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property StageElem: TH3DPipeRes read GetStageElem;
    property StageNameStr: TH3DPipeRes read GetStageNameStr;
    property StageActivationI: TH3DPipeRes read GetStageActivationI;
  end;


  { TH3DNodeTypesHelper }

  TH3DNodeTypesHelper = class
  private
    function GetCamera: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetEmitter: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetGroup: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetJoint: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLight: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMesh: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetModel: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetUndefined: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property Undefined: TH3DNodeTypes read GetUndefined;
    property Group: TH3DNodeTypes read GetGroup;
    property Model: TH3DNodeTypes read GetModel;
    property Mesh: TH3DNodeTypes read GetMesh;
    property Joint: TH3DNodeTypes read GetJoint;
    property Light: TH3DNodeTypes read GetLight;
    property Camera: TH3DNodeTypes read GetCamera;
    property Emitter: TH3DNodeTypes read GetEmitter;
  end;

  { TH3DNodeFlagsHelper }

  TH3DNodeFlagsHelper = class
  private
    function GetInactive: TH3DNodeFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNoCastShadow: TH3DNodeFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNoDraw: TH3DNodeFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNoRayQuery: TH3DNodeFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property NoDraw: TH3DNodeFlags read GetNoDraw;
    property NoCastShadow: TH3DNodeFlags read GetNoCastShadow;
    property NoRayQuery: TH3DNodeFlags read GetNoRayQuery;
    property Inactive: TH3DNodeFlags read GetInactive;
  end;

  { TH3DNodeParamsHelper }

  TH3DNodeParamsHelper = class
  private
    function GetAttachmentStr: TH3DNodeParams; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNameStr: TH3DNodeParams; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property NameStr: TH3DNodeParams read GetNameStr;
    property AttachmentStr: TH3DNodeParams read GetAttachmentStr;
  end;

  { TH3DModelHelper }

  TH3DModelHelper = class
  private
    function GetGeoResI: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLodDist1F: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLodDist2F: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLodDist3F: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLodDist4F: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSWSkinningI: TH3DModel; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property GeoResI: TH3DModel read GetGeoResI;
    property SWSkinningI: TH3DModel read GetSWSkinningI;
    property LodDist1F: TH3DModel read GetLodDist1F;
    property LodDist2F: TH3DModel read GetLodDist2F;
    property LodDist3F: TH3DModel read GetLodDist3F;
    property LodDist4F: TH3DModel read GetLodDist4F;
  end;

  { TH3DMeshHelper }

  TH3DMeshHelper = class
  private
    function GetBatchCountI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetBatchStartI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLodLevelI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMatResI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetVertREndI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetVertRStartI: TH3DMesh; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property MatResI: TH3DMesh read GetMatResI;
    property BatchStartI: TH3DMesh read GetBatchStartI;
    property BatchCountI: TH3DMesh read GetBatchCountI;
    property VertRStartI: TH3DMesh read GetVertRStartI;
    property VertREndI: TH3DMesh read GetVertREndI;
    property LodLevelI: TH3DMesh read GetLodLevelI;
  end;

  { TH3DJointHelper }

  TH3DJointHelper = class
  private
    function GetJointIndexI: TH3DJoint; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property JointIndexI: TH3DJoint read GetJointIndexI;
  end;

  { TH3DLightHelper }

  TH3DLightHelper = class
  private
    function GetColorF3: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetColorMultiplierF: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetFovF: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLightingContextStr: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMatResI: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetRadiusF: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowContextStr: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowMapBiasF: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowMapCountI: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetShadowSplitLambdaF: TH3DLight; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property MatResI: TH3DLight read GetMatResI;
    property RadiusF: TH3DLight read GetRadiusF;
    property FovF: TH3DLight read GetFovF;
    property ColorF3: TH3DLight read GetColorF3;
    property ColorMultiplierF: TH3DLight read GetColorMultiplierF;
    property ShadowMapCountI: TH3DLight read GetShadowMapCountI;
    property ShadowSplitLambdaF: TH3DLight read GetShadowSplitLambdaF;
    property ShadowMapBiasF: TH3DLight read GetShadowMapBiasF;
    property LightingContextStr: TH3DLight read GetLightingContextStr;
    property ShadowContextStr: TH3DLight read GetShadowContextStr;
  end;

  { TH3DCameraHelper }

  TH3DCameraHelper = class
  private
    function GetBottomPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetFarPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetLeftPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetNearPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetOccCullingI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetOrthoI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetOutBufIndexI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetOutTexResI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetPipeResI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetRightPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetTopPlaneF: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetViewportHeightI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetViewportWidthI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetViewportXI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetViewportYI: TH3DCamera; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property PipeResI: TH3DCamera read GetPipeResI;
    property OutTexResI: TH3DCamera read GetOutTexResI;
    property OutBufIndexI: TH3DCamera read GetOutBufIndexI;
    property LeftPlaneF: TH3DCamera read GetLeftPlaneF;
    property RightPlaneF: TH3DCamera read GetRightPlaneF;
    property BottomPlaneF: TH3DCamera read GetBottomPlaneF;
    property TopPlaneF: TH3DCamera read GetTopPlaneF;
    property NearPlaneF: TH3DCamera read GetNearPlaneF;
    property FarPlaneF: TH3DCamera read GetFarPlaneF;
    property ViewportXI: TH3DCamera read GetViewportXI;
    property ViewportYI: TH3DCamera read GetViewportYI;
    property ViewportWidthI: TH3DCamera read GetViewportWidthI;
    property ViewportHeightI: TH3DCamera read GetViewportHeightI;
    property OrthoI: TH3DCamera read GetOrthoI;
    property OccCullingI: TH3DCamera read GetOccCullingI;
  end;

  { TH3DEmitterHelper }

  TH3DEmitterHelper = class
  private
    function GetDelayF: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetEmissionRateF: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetForceF3: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMatResI: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetMaxCountI: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetPartEffResI: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetRespawnCountI: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
    function GetSpreadAngleF: TH3DEmitter; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  published
    property MatResI: TH3DEmitter read GetMatResI;
    property PartEffResI: TH3DEmitter read GetPartEffResI;
    property MaxCountI: TH3DEmitter read GetMaxCountI;
    property RespawnCountI: TH3DEmitter read GetRespawnCountI;
    property DelayF: TH3DEmitter read GetDelayF;
    property EmissionRateF: TH3DEmitter read GetEmissionRateF;
    property SpreadAngleF: TH3DEmitter read GetSpreadAngleF;
    property ForceF3: TH3DEmitter read GetForceF3;
  end;

THorde3DColor = record
  R, G, B, A: Single;
end;

THorde3DVector = record
  X, Y, Z: Single;
end;

THorde3DVertices = record
  Verts: array of Single;
  Count: Integer;
end;

THorde3DNode = class; // Forward declaration
THorde3DResource = class; // Forward declaration

{ THorde3DContainer }

THorde3DContainer = class
private
  function GetError: Boolean;
  function GetOption(Param: TH3DOptions): Single; {$IFDEF CAN_INLINE} inline;
  function GetRootNode: TH3DNode;
 {$ENDIF}
  function GetVersionString: AnsiString; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetOption(Param: TH3DOptions; const AValue: Single); {$IFDEF CAN_INLINE} inline; {$ENDIF}
public
  function Init(): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure Release(); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure ReleaseUnusedResources(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  procedure Render(CameraNode: TH3DNode); Overload; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure Render(CameraNode: THorde3DNode); Overload; {$IFDEF CAN_INLINE} inline; {$ENDIF}

  procedure FinalizeFrame(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  procedure ShowOverlays(Vertices: THorde3DVertices; Color: THorde3DColor; Material: TH3DRes; Flags: Integer = 0); Overload; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure ShowOverlays(Vertices: THorde3DVertices; Color: THorde3DColor; Material: THorde3DResource; Flags: Integer = 0); Overload; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure ClearOverlays(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  function CheckExtension(ExtensionName: AnsiString): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
published
  property RootNode: TH3DNode read GetRootNode;

  property Error: Boolean read GetError;
  property VersionString: AnsiString read GetVersionString;

  property Option[Param: TH3DOptions]: Single read GetOption write SetOption;
end;

{ THorde3DUtilsContainer }

THorde3DUtilsContainer = class
private
  function GetResourcePath(Index: TH3DResTypes): AnsiString; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetResourcePath(Index: TH3DResTypes; const AValue: AnsiString); {$IFDEF CAN_INLINE} inline; {$ENDIF}

public
  function DumpMessages(): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure ReleaseOpenGL(); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SwapBuffers(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  function LoadResourcesFromDisk(contentDir: AnsiString): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}

  function Screenshot(const Filename: AnsiString): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
published
  property ResourcePath[Index: TH3DResTypes]: AnsiString read GetResourcePath write SetResourcePath;
end;

{ THorde3DNode }

THorde3DNode = class
private
  fID: TH3DNode;

  fTransform: THorde3DVector;
  fRotation: THorde3DVector;
  fScale: THorde3DVector;

  function GetNodeType: TH3DNodeTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetParent: TH3DNode; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetRotation: THorde3DVector; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetScale: THorde3DVector; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetTransform: THorde3DVector; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetParent(const AValue: TH3DNode); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetRotation(const AValue: THorde3DVector); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetScale(const AValue: THorde3DVector); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetTransform(const AValue: THorde3DVector); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  procedure GetNodeTransform(); {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetNodeTransform(); {$IFDEF CAN_INLINE} inline; {$ENDIF}
public
  constructor Create(Resource: TH3DRes; Parent: TH3DNode = 1); Overload;
  constructor Create(Resource: THorde3DResource; Parent: THorde3DNode = nil); Overload;

  destructor Destroy; Override;

  procedure Remove(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  function GetFlags(): TH3DNodeFlags; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure SetFlags(Flags: TH3DNodeFlags; Recursive: Boolean = False); {$IFDEF CAN_INLINE} inline; {$ENDIF}
public
  property Transform: THorde3DVector read GetTransform write SetTransform;
  property Rotation: THorde3DVector read GetRotation write SetRotation;
  property Scale: THorde3DVector read GetScale write SetScale;
published
  property ID: TH3DNode read fID;
  property Parent: TH3DNode read GetParent write SetParent;
  property NodeType: TH3DNodeTypes read GetNodeType;
end;

{ THorde3DResource }

THorde3DResource = class
private
  fID: TH3DRes;
  function GetIsLoaded: Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetName: AnsiString; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  function GetResType: TH3DResTypes; {$IFDEF CAN_INLINE} inline; {$ENDIF}
public
  constructor Create(Type_: TH3DResTypes; const Name: AnsiString; Flags: Integer = 0);
  destructor Destroy; Override;

  function Load(const Name: AnsiString; Size: Integer): Boolean; {$IFDEF CAN_INLINE} inline; {$ENDIF}
  procedure Unload(); {$IFDEF CAN_INLINE} inline; {$ENDIF}

  procedure Remove(); {$IFDEF CAN_INLINE} inline; {$ENDIF}
published
  property ID: TH3DRes read fID;

  property IsLoaded: Boolean read GetIsLoaded;
  property ResType: TH3DResTypes read GetResType;
  property Name: AnsiString read GetName;
end;

var
  H3DOptions: TH3DOptionsHelper;
  H3DStats: TH3DStatsHelper;
  H3DResTypes: TH3DResTypesHelper;
  H3DResFlags: TH3DResFlagsHelper;
  H3DFormats: TH3DFormatsHelper;
  H3DGeoRes: TH3DGeoResHelper;
  H3DAnimRes: TH3DAnimResHelper;
  H3DMatRes: TH3DMatResHelper;
  H3DShaderRes: TH3DShaderResHelper;
  H3DTexRes: TH3DTexResHelper;
  H3DPartEffRes: TH3DPartEffResHelper;
  H3DPipeRes: TH3DPipeResHelper;
  H3DNodeTypes: TH3DNodeTypesHelper;
  H3DNodeFlags: TH3DNodeFlagsHelper;
  H3DNodeParams: TH3DNodeParamsHelper;
  H3DModel: TH3DModelHelper;
  H3DMesh: TH3DMeshHelper;
  H3DJoint: TH3DJointHelper;
  H3DLight: TH3DLightHelper;
  H3DCamera: TH3DCameraHelper;
  H3DEmitter: TH3DEmitterHelper;

  H3D: THorde3DContainer;
  H3DUtils: THorde3DUtilsContainer;


implementation

{ THorde3DUtilsContainer }

function THorde3DUtilsContainer.GetResourcePath(Index: TH3DResTypes
  ): AnsiString;
begin
  Result := h3dutGetResourcePath(Integer(Index));
end;

procedure THorde3DUtilsContainer.SetResourcePath(Index: TH3DResTypes;
  const AValue: AnsiString);
begin
  h3dutSetResourcePath(Integer(Index), PAnsiChar(AValue));
end;

function THorde3DUtilsContainer.DumpMessages(): Boolean;
begin
  Result := h3dutDumpMessages;
end;

procedure THorde3DUtilsContainer.ReleaseOpenGL();
begin
  h3dutReleaseOpenGL;
end;

procedure THorde3DUtilsContainer.SwapBuffers();
begin
  h3dutSwapBuffers;
end;

function THorde3DUtilsContainer.LoadResourcesFromDisk(contentDir: AnsiString
  ): Boolean;
begin
  Result := h3dutLoadResourcesFromDisk(PAnsiChar(contentDir));
end;

function THorde3DUtilsContainer.Screenshot(const Filename: AnsiString
  ): Boolean;
begin
  Result := h3dutScreenshot(PAnsiChar(Filename));
end;

{ THorde3DResource }

function THorde3DResource.GetIsLoaded: Boolean;
begin
  Result := h3dIsResLoaded(Self.ID);
end;

function THorde3DResource.GetName: AnsiString;
begin
  Result := AnsiString(h3dGetResName(Self.ID));
end;

function THorde3DResource.GetResType: TH3DResTypes;
begin
  Result := TH3DResTypes(h3dGetResType(Self.ID));
end;

constructor THorde3DResource.Create(Type_: TH3DResTypes;
  const Name: AnsiString; Flags: Integer = 0);
begin
  inherited Create;

  fID := h3dAddResource(Type_, PAnsiChar(Name), Flags);
end;

destructor THorde3DResource.Destroy;
begin
  Remove();

  inherited Destroy;
end;

function THorde3DResource.Load(const Name: AnsiString; Size: Integer): Boolean;
begin
  Result := h3dLoadResource(fID, PAnsiChar(Name), Size);
end;

procedure THorde3DResource.Unload();
begin
  h3dUnloadResource(fID);
end;

procedure THorde3DResource.Remove();
begin
  h3dRemoveResource(fID);
end;

{ THorde3DNode }

function THorde3DNode.GetNodeType: TH3DNodeTypes;
begin
  Result := TH3DNodeTypes(h3dGetNodeType(Self.ID));
end;

function THorde3DNode.GetParent: TH3DNode;
begin
  Result := h3dGetNodeParent(fID);
end;

function THorde3DNode.GetRotation: THorde3DVector;
begin
  GetNodeTransform();

  Result := fRotation;
end;

function THorde3DNode.GetScale: THorde3DVector;
begin
  GetNodeTransform();

  Result := fScale;
end;

function THorde3DNode.GetTransform: THorde3DVector;
begin
  GetNodeTransform();

  Result := fTransform;
end;

procedure THorde3DNode.SetParent(const AValue: TH3DNode);
begin
  h3dSetNodeParent(fID, AValue);
end;

procedure THorde3DNode.SetRotation(const AValue: THorde3DVector);
begin
  fRotation := AValue;

  SetNodeTransform();
end;

procedure THorde3DNode.SetScale(const AValue: THorde3DVector);
begin
  fScale := AValue;

  SetNodeTransform();
end;

procedure THorde3DNode.SetTransform(const AValue: THorde3DVector);
begin
  fTransform := AValue;

  SetNodeTransform();
end;

procedure THorde3DNode.GetNodeTransform();
begin
  h3dGetNodeTransform(fID, fTransform.X, fTransform.Y, fTransform.Z,
                           fRotation.X, fRotation.Y, fRotation.Z,
                           fScale.X, fScale.Y, fScale.Z);
end;

procedure THorde3DNode.SetNodeTransform();
begin
  h3dSetNodeTransform(fID, fTransform.X, fTransform.Y, fTransform.Z,
                           fRotation.X, fRotation.Y, fRotation.Z,
                           fScale.X, fScale.Y, fScale.Z);
end;

constructor THorde3DNode.Create(Resource: TH3DRes; Parent: TH3DNode = 1);
begin
  inherited Create;

  fID := h3dAddNodes(Resource, Parent);
end;

constructor THorde3DNode.Create(Resource: THorde3DResource;
  Parent: THorde3DNode);
var
  tmpID: Integer;
begin
  if Parent = nil then tmpID := 1
  else tmpID := Parent.ID;

  Create(Resource.ID, tmpID);
end;

destructor THorde3DNode.Destroy;
begin
  Remove;

  inherited Destroy;
end;

procedure THorde3DNode.Remove();
begin
  h3dRemoveNode(fID);
end;

function THorde3DNode.GetFlags(): TH3DNodeFlags;
begin
  Result := TH3DNodeFlags(h3dGetNodeFlags(fID));
end;

procedure THorde3DNode.SetFlags(Flags: TH3DNodeFlags; Recursive: Boolean = False);
begin
  h3dSetNodeFlags(fID, Integer(Flags), Recursive);
end;

{ TH3DEmitterHelper }

function TH3DEmitterHelper.GetDelayF: TH3DEmitter;
begin
  Result := H3DEmitter_DelayF;
end;

function TH3DEmitterHelper.GetEmissionRateF: TH3DEmitter;
begin
  Result := H3DEmitter_EmissionRateF;
end;

function TH3DEmitterHelper.GetForceF3: TH3DEmitter;
begin
  Result := H3DEmitter_ForceF3;
end;

function TH3DEmitterHelper.GetMatResI: TH3DEmitter;
begin
  Result := H3DEmitter_MatResI;
end;

function TH3DEmitterHelper.GetMaxCountI: TH3DEmitter;
begin
  Result := H3DEmitter_MaxCountI;
end;

function TH3DEmitterHelper.GetPartEffResI: TH3DEmitter;
begin
  Result := H3DEmitter_PartEffResI;
end;

function TH3DEmitterHelper.GetRespawnCountI: TH3DEmitter;
begin
  Result := H3DEmitter_RespawnCountI;
end;

function TH3DEmitterHelper.GetSpreadAngleF: TH3DEmitter;
begin
  Result := H3DEmitter_SpreadAngleF;
end;

{ TH3DCameraHelper }

function TH3DCameraHelper.GetBottomPlaneF: TH3DCamera;
begin
  Result := H3DCamera_BottomPlaneF;
end;

function TH3DCameraHelper.GetFarPlaneF: TH3DCamera;
begin
  Result := H3DCamera_FarPlaneF;
end;

function TH3DCameraHelper.GetLeftPlaneF: TH3DCamera;
begin
  Result := H3DCamera_LeftPlaneF;
end;

function TH3DCameraHelper.GetNearPlaneF: TH3DCamera;
begin
  Result := H3DCamera_NearPlaneF;
end;

function TH3DCameraHelper.GetOccCullingI: TH3DCamera;
begin
  Result := H3DCamera_OccCullingI;
end;

function TH3DCameraHelper.GetOrthoI: TH3DCamera;
begin
  Result := H3DCamera_OrthoI;
end;

function TH3DCameraHelper.GetOutBufIndexI: TH3DCamera;
begin
  Result := H3DCamera_OutBufIndexI;
end;

function TH3DCameraHelper.GetOutTexResI: TH3DCamera;
begin
  Result := H3DCamera_OutTexResI;
end;

function TH3DCameraHelper.GetPipeResI: TH3DCamera;
begin
  Result := H3DCamera_PipeResI;
end;

function TH3DCameraHelper.GetRightPlaneF: TH3DCamera;
begin
  Result := H3DCamera_RightPlaneF;
end;

function TH3DCameraHelper.GetTopPlaneF: TH3DCamera;
begin
  Result := H3DCamera_TopPlaneF;
end;

function TH3DCameraHelper.GetViewportHeightI: TH3DCamera;
begin
  Result := H3DCamera_ViewportHeightI;
end;

function TH3DCameraHelper.GetViewportWidthI: TH3DCamera;
begin
  Result := H3DCamera_ViewportWidthI;
end;

function TH3DCameraHelper.GetViewportXI: TH3DCamera;
begin
  Result := H3DCamera_ViewportXI;
end;

function TH3DCameraHelper.GetViewportYI: TH3DCamera;
begin
  Result := H3DCamera_ViewportYI;
end;

{ TH3DLightHelper }

function TH3DLightHelper.GetColorF3: TH3DLight;
begin
  Result := H3DLight_ColorF3;
end;

function TH3DLightHelper.GetColorMultiplierF: TH3DLight;
begin
  Result := H3DLight_ColorMultiplierF;
end;

function TH3DLightHelper.GetFovF: TH3DLight;
begin
  Result := H3DLight_FovF;
end;

function TH3DLightHelper.GetLightingContextStr: TH3DLight;
begin
  Result := H3DLight_LightingContextStr;
end;

function TH3DLightHelper.GetMatResI: TH3DLight;
begin
  Result := H3DLight_MatResI;
end;

function TH3DLightHelper.GetRadiusF: TH3DLight;
begin
  Result := H3DLight_RadiusF;
end;

function TH3DLightHelper.GetShadowContextStr: TH3DLight;
begin
  Result := H3DLight_ShadowContextStr;
end;

function TH3DLightHelper.GetShadowMapBiasF: TH3DLight;
begin
  Result := H3DLight_ShadowMapBiasF;
end;

function TH3DLightHelper.GetShadowMapCountI: TH3DLight;
begin
  Result := H3DLight_ShadowMapCountI;
end;

function TH3DLightHelper.GetShadowSplitLambdaF: TH3DLight;
begin
  Result := H3DLight_ShadowSplitLambdaF;
end;

{ TH3DJointHelper }

function TH3DJointHelper.GetJointIndexI: TH3DJoint;
begin
  Result := H3DJoint_JointIndexI;
end;

{ TH3DMeshHelper }

function TH3DMeshHelper.GetBatchCountI: TH3DMesh;
begin
  Result := H3DMesh_BatchCountI;
end;

function TH3DMeshHelper.GetBatchStartI: TH3DMesh;
begin
  Result := H3DMesh_BatchStartI;
end;

function TH3DMeshHelper.GetLodLevelI: TH3DMesh;
begin
  Result := H3DMesh_LodLevelI;
end;

function TH3DMeshHelper.GetMatResI: TH3DMesh;
begin
  Result := H3DMesh_MatResI;
end;

function TH3DMeshHelper.GetVertREndI: TH3DMesh;
begin
  Result := H3DMesh_VertREndI;
end;

function TH3DMeshHelper.GetVertRStartI: TH3DMesh;
begin
  Result := H3DMesh_VertRStartI;
end;

{ TH3DModelHelper }

function TH3DModelHelper.GetGeoResI: TH3DModel;
begin
  Result := H3DModel_GeoResI;
end;

function TH3DModelHelper.GetLodDist1F: TH3DModel;
begin
  Result := H3DModel_LodDist1F;
end;

function TH3DModelHelper.GetLodDist2F: TH3DModel;
begin
  Result := H3DModel_LodDist2F;
end;

function TH3DModelHelper.GetLodDist3F: TH3DModel;
begin
  Result := H3DModel_LodDist3F;
end;

function TH3DModelHelper.GetLodDist4F: TH3DModel;
begin
  Result := H3DModel_LodDist4F;
end;

function TH3DModelHelper.GetSWSkinningI: TH3DModel;
begin
  Result := H3DModel_SWSkinningI;
end;

{ TH3DNodeParamsHelper }

function TH3DNodeParamsHelper.GetAttachmentStr: TH3DNodeParams;
begin
  Result := H3DNodeParams_AttachmentStr;
end;

function TH3DNodeParamsHelper.GetNameStr: TH3DNodeParams;
begin
  Result := H3DNodeParams_NameStr;
end;

{ TH3DNodeFlagsHelper }

function TH3DNodeFlagsHelper.GetInactive: TH3DNodeFlags;
begin
  Result := H3DNodeFlags_Inactive;
end;

function TH3DNodeFlagsHelper.GetNoCastShadow: TH3DNodeFlags;
begin
  Result := H3DNodeFlags_NoCastShadow;
end;

function TH3DNodeFlagsHelper.GetNoDraw: TH3DNodeFlags;
begin
  Result := H3DNodeFlags_NoDraw;
end;

function TH3DNodeFlagsHelper.GetNoRayQuery: TH3DNodeFlags;
begin
  Result := H3DNodeFlags_NoRayQuery;
end;

{ TH3DNodeTypesHelper }

function TH3DNodeTypesHelper.GetCamera: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Camera;
end;

function TH3DNodeTypesHelper.GetEmitter: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Emitter;
end;

function TH3DNodeTypesHelper.GetGroup: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Group;
end;

function TH3DNodeTypesHelper.GetJoint: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Joint;
end;

function TH3DNodeTypesHelper.GetLight: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Light;
end;

function TH3DNodeTypesHelper.GetMesh: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Mesh;
end;

function TH3DNodeTypesHelper.GetModel: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Model;
end;

function TH3DNodeTypesHelper.GetUndefined: TH3DNodeTypes;
begin
  Result := H3DNodeTypes_Undefined;
end;

{ TH3DPipeResHelper }

function TH3DPipeResHelper.GetStageActivationI: TH3DPipeRes;
begin
  Result := H3DPipeRes_StageActivationI;
end;

function TH3DPipeResHelper.GetStageElem: TH3DPipeRes;
begin
  Result := H3DPipeRes_StageElem;
end;

function TH3DPipeResHelper.GetStageNameStr: TH3DPipeRes;
begin
  Result := H3DPipeRes_StageNameStr;
end;

{ TH3DPartEffResHelper }

function TH3DPartEffResHelper.GetChanColAElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanColAElem;
end;

function TH3DPartEffResHelper.GetChanColBElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanColBElem;
end;

function TH3DPartEffResHelper.GetChanColGElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanColGElem;
end;

function TH3DPartEffResHelper.GetChanColRElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanColRElem;
end;

function TH3DPartEffResHelper.GetChanDragElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanDragElem;
end;

function TH3DPartEffResHelper.GetChanEndRateF: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanEndRateF;
end;

function TH3DPartEffResHelper.GetChanMoveVelElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanMoveVelElem;
end;

function TH3DPartEffResHelper.GetChanRotVelElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanRotVelElem;
end;

function TH3DPartEffResHelper.GetChanSizeElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanSizeElem;
end;

function TH3DPartEffResHelper.GetChanStartMaxF: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanStartMaxF;
end;

function TH3DPartEffResHelper.GetChanStartMinF: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ChanStartMinF;
end;

function TH3DPartEffResHelper.GetParticleElem: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_ParticleElem;
end;

function TH3DPartEffResHelper.GetPartLifeMaxF: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_PartLifeMaxF;
end;

function TH3DPartEffResHelper.GetPartLifeMinF: TH3DPartEffRes;
begin
  Result := H3DPartEffRes_PartLifeMinF;
end;

{ THorde3DContainer }

function THorde3DContainer.GetError: Boolean;
begin
  Result := h3dGetError;
end;

function THorde3DContainer.GetOption(Param: TH3DOptions): Single;
begin
  Result := h3dGetOption(Param);
end;

function THorde3DContainer.GetRootNode: TH3DNode;
begin
  Result := H3DRootNode;
end;

function THorde3DContainer.GetVersionString: AnsiString;
begin
  Result := AnsiString(h3dGetVersionString);
end;

procedure THorde3DContainer.SetOption(Param: TH3DOptions; const AValue: Single);
begin
  h3dSetOption(Param, AValue);
end;

function THorde3DContainer.Init(): Boolean;
begin
  Result := h3dInit;
end;

procedure THorde3DContainer.Release();
begin
  h3dRelease;
end;

procedure THorde3DContainer.ReleaseUnusedResources();
begin
  h3dReleaseUnusedResources;
end;

procedure THorde3DContainer.Render(CameraNode: TH3DNode);
begin
  h3dRender(CameraNode);
end;

procedure THorde3DContainer.Render(CameraNode: THorde3DNode);
begin
  h3dRender(CameraNode.ID);
end;

procedure THorde3DContainer.FinalizeFrame();
begin
  h3dFinalizeFrame;
end;

procedure THorde3DContainer.ShowOverlays(Vertices: THorde3DVertices;
  Color: THorde3DColor; Material: TH3DRes; Flags: Integer = 0);
begin
  h3dShowOverlays(PSingle(Vertices.Verts), Vertices.Count, Color.R, Color.G, Color.B, Color.A, Material, Flags);
end;

procedure THorde3DContainer.ShowOverlays(Vertices: THorde3DVertices;
  Color: THorde3DColor; Material: THorde3DResource; Flags: Integer = 0);
begin
  ShowOverlays(Vertices, Color, Material.ID, Flags);
end;

procedure THorde3DContainer.ClearOverlays();
begin
  h3dClearOverlays;
end;

function THorde3DContainer.CheckExtension(ExtensionName: AnsiString): Boolean;
begin
  Result := h3dCheckExtension(PAnsiChar(ExtensionName));
end;

{ TH3DTexResHelper }

function TH3DTexResHelper.GetImageElem: TH3DTexRes;
begin
  Result := H3DTexRes_ImageElem;
end;

function TH3DTexResHelper.GetImgHeightI: TH3DTexRes;
begin
  Result := H3DTexRes_ImgHeightI;
end;

function TH3DTexResHelper.GetImgPixelStream: TH3DTexRes;
begin
  Result := H3DTexRes_ImgPixelStream;
end;

function TH3DTexResHelper.GetImgWidthI: TH3DTexRes;
begin
  Result := H3DTexRes_ImgWidthI;
end;

function TH3DTexResHelper.GetTexFormatI: TH3DTexRes;
begin
  Result := H3DTexRes_TexFormatI;
end;

function TH3DTexResHelper.GetTexSliceCountI: TH3DTexRes;
begin
  Result := H3DTexRes_TexSliceCountI;
end;

function TH3DTexResHelper.GetTextureElem: TH3DTexRes;
begin
  Result := H3DTexRes_TextureElem;
end;

{ TH3DShaderResHelper }

function TH3DShaderResHelper.GetContextElem: TH3DShaderRes;
begin
  Result := H3DShaderRes_ContextElem;
end;

function TH3DShaderResHelper.GetContNameStr: TH3DShaderRes;
begin
  Result := H3DShaderRes_ContNameStr;
end;

function TH3DShaderResHelper.GetSamplerElem: TH3DShaderRes;
begin
  Result := H3DShaderRes_SamplerElem;
end;

function TH3DShaderResHelper.GetSampNameStr: TH3DShaderRes;
begin
  Result := H3DShaderRes_SampNameStr;
end;

function TH3DShaderResHelper.GetUnifDefValueF: TH3DShaderRes;
begin
  Result := H3DShaderRes_UnifDefValueF4;
end;

function TH3DShaderResHelper.GetUnifNameStr: TH3DShaderRes;
begin
  Result := H3DShaderRes_UnifNameStr;
end;

function TH3DShaderResHelper.GetUniformElem: TH3DShaderRes;
begin
  Result := H3DShaderRes_UniformElem;
end;

function TH3DShaderResHelper.GetUnifSizeI: TH3DShaderRes;
begin
  Result := H3DShaderRes_UnifSizeI;
end;

{ TH3DMatResHelper }

function TH3DMatResHelper.GetMatClassStr: TH3DMatRes;
begin
  Result := H3DMatRes_MatClassStr;
end;

function TH3DMatResHelper.GetMaterialElem: TH3DMatRes;
begin
  Result := H3DMatRes_MaterialElem;
end;

function TH3DMatResHelper.GetMatLinkI: TH3DMatRes;
begin
  Result := H3DMatRes_MatLinkI;
end;

function TH3DMatResHelper.GetMatShaderI: TH3DMatRes;
begin
  Result := H3DMatRes_MatShaderI;
end;

function TH3DMatResHelper.GetSamplerElem: TH3DMatRes;
begin
  Result := H3DMatRes_SamplerElem;
end;

function TH3DMatResHelper.GetSampNameStr: TH3DMatRes;
begin
  Result := H3DMatRes_SampNameStr;
end;

function TH3DMatResHelper.GetSampTexResI: TH3DMatRes;
begin
  Result := H3DMatRes_SampTexResI;
end;

function TH3DMatResHelper.GetUnifNameStr: TH3DMatRes;
begin
  Result := H3DMatRes_UnifNameStr;
end;

function TH3DMatResHelper.GetUniformElem: TH3DMatRes;
begin
  Result := H3DMatRes_UniformElem;
end;

function TH3DMatResHelper.GetUnifValueF4: TH3DMatRes;
begin
  Result := H3DMatRes_UnifValueF4;
end;

{ TH3DAnimResHelper }

function TH3DAnimResHelper.GetEntFrameCountI: TH3DAnimRes;
begin
  Result := H3DAnimRes_EntFrameCountI;
end;

function TH3DAnimResHelper.GetEntityElem: TH3DAnimRes;
begin
  Result := H3DAnimRes_EntityElem;
end;

{ TH3DGeoResHelper }

function TH3DGeoResHelper.GetGeoIndexCountI: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoIndexCountI;
end;

function TH3DGeoResHelper.GetGeoIndexStream: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoIndexStream;
end;

function TH3DGeoResHelper.GetGeoIndices16I: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoIndices16I;
end;

function TH3DGeoResHelper.GetGeometryElem: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeometryElem;
end;

function TH3DGeoResHelper.GetGeoVertexCountI: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoVertexCountI;
end;

function TH3DGeoResHelper.GetGeoVertPosStream: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoVertPosStream;
end;

function TH3DGeoResHelper.GetGeoVertStaticStream: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoVertStaticStream;
end;

function TH3DGeoResHelper.GetGeoVertTanStream: TH3DGeoRes;
begin
  Result := H3DGeoRes_GeoVertTanStream;
end;

{ TH3DFormatsHelper }

function TH3DFormatsHelper.GetTEX_BGRA8: TH3DFormats;
begin
  Result := H3DFormats_TEX_BGRA8;
end;

function TH3DFormatsHelper.GetTEX_DXT1: TH3DFormats;
begin
  Result := H3DFormats_TEX_DXT1;
end;

function TH3DFormatsHelper.GetTEX_DXT3: TH3DFormats;
begin
  Result := H3DFormats_TEX_DXT3;
end;

function TH3DFormatsHelper.GetTEX_DXT5: TH3DFormats;
begin
  Result := H3DFormats_TEX_DXT5;
end;

function TH3DFormatsHelper.GetTEX_RGBA16F: TH3DFormats;
begin
  Result := H3DFormats_TEX_RGBA16F;
end;

function TH3DFormatsHelper.GetTEX_RGBA32F: TH3DFormats;
begin
  Result := H3DFormats_TEX_RGBA32F;
end;

function TH3DFormatsHelper.GetUnknown: TH3DFormats;
begin
  Result := H3DFormats_Unknown;
end;

{ TH3DResFlagsHelper }

function TH3DResFlagsHelper.GetNoQuery: TH3DResFlags;
begin
  Result := H3DResFlags_NoQuery;
end;

function TH3DResFlagsHelper.GetNoTexCompression: TH3DResFlags;
begin
  Result := H3DResFlags_NoTexCompression;
end;

function TH3DResFlagsHelper.GetNoTexMipmaps: TH3DResFlags;
begin
  Result := H3DResFlags_NoTexMipmaps;
end;

function TH3DResFlagsHelper.GetTexCubemap: TH3DResFlags;
begin
  Result := H3DResFlags_TexCubemap;
end;

function TH3DResFlagsHelper.GetTexDynamic: TH3DResFlags;
begin
  Result := H3DResFlags_TexDynamic;
end;

function TH3DResFlagsHelper.GetTexRenderable: TH3DResFlags;
begin
  Result := H3DResFlags_TexRenderable;
end;

function TH3DResFlagsHelper.GetTexSRGB: TH3DResFlags;
begin
  Result := H3DResFlags_TexSRGB;
end;

{ TH3DResTypesHelper }

function TH3DResTypesHelper.GetAnimation: TH3DResTypes;
begin
  Result := H3DResTypes_Animation;
end;

function TH3DResTypesHelper.GetCode: TH3DResTypes;
begin
  Result := H3DResTypes_Code;
end;

function TH3DResTypesHelper.GetGeometry: TH3DResTypes;
begin
  Result := H3DResTypes_Geometry;
end;

function TH3DResTypesHelper.GetMaterial: TH3DResTypes;
begin
  Result := H3DResTypes_Material;
end;

function TH3DResTypesHelper.GetParticleEffect: TH3DResTypes;
begin
  Result := H3DResTypes_ParticleEffect;
end;

function TH3DResTypesHelper.GetPipeline: TH3DResTypes;
begin
  Result := H3DResTypes_Pipeline;
end;

function TH3DResTypesHelper.GetSceneGraph: TH3DResTypes;
begin
  Result := H3DResTypes_SceneGraph;
end;

function TH3DResTypesHelper.GetShader: TH3DResTypes;
begin
  Result := H3DResTypes_Shader;
end;

function TH3DResTypesHelper.GetTexture: TH3DResTypes;
begin
  Result := H3DResTypes_Texture;
end;

function TH3DResTypesHelper.GetUndefined: TH3DResTypes;
begin
  Result := H3DResTypes_Undefined;
end;

{ TH3DStatsHelper }

function TH3DStatsHelper.GetAnimationTime: TH3DStats;
begin
  Result := H3DStats_AnimationTime;
end;

function TH3DStatsHelper.GetBatchCount: TH3DStats;
begin
  Result := H3DStats_BatchCount;
end;

function TH3DStatsHelper.GetDefLightsGPUTime: TH3DStats;
begin
  Result := H3DStats_DefLightsGPUTime;
end;

function TH3DStatsHelper.GetFrameTime: TH3DStats;
begin
  Result := H3DStats_FrameTime;
end;

function TH3DStatsHelper.GetFwdLightsGPUTime: TH3DStats;
begin
  Result := H3DStats_FwdLightsGPUTime;
end;

function TH3DStatsHelper.GetGeometryVMem: TH3DStats;
begin
  Result := H3DStats_GeometryVMem;
end;

function TH3DStatsHelper.GetGeoUpdateTime: TH3DStats;
begin
  Result := H3DStats_GeoUpdateTime;
end;

function TH3DStatsHelper.GetLightPassCount: TH3DStats;
begin
  Result := H3DStats_LightPassCount;
end;

function TH3DStatsHelper.GetParticleGPUTime: TH3DStats;
begin
  Result := H3DStats_ParticleGPUTime;
end;

function TH3DStatsHelper.GetParticleSimTime: TH3DStats;
begin
  Result := H3DStats_ParticleSimTime;
end;

function TH3DStatsHelper.GetShadowsGPUTime: TH3DStats;
begin
  Result := H3DStats_ShadowsGPUTime;
end;

function TH3DStatsHelper.GetTextureVMem: TH3DStats;
begin
  Result := H3DStats_TextureVMem;
end;

function TH3DStatsHelper.GetTriCount: TH3DStats;
begin
  Result := H3DStats_TriCount;
end;

{ TH3DOptionsHelper }

function TH3DOptionsHelper.GetDebugViewMode: TH3DOptions;
begin
  Result := H3DOptions_DebugViewMode;
end;

function TH3DOptionsHelper.GetDumpFailedShaders: TH3DOptions;
begin
  Result := H3DOptions_DumpFailedShaders;
end;

function TH3DOptionsHelper.GetFastAnimation: TH3DOptions;
begin
  Result := H3DOptions_FastAnimation;
end;

function TH3DOptionsHelper.GetGatherTimeStats: TH3DOptions;
begin
  Result := H3DOptions_GatherTimeStats;
end;

function TH3DOptionsHelper.GetLoadTextures: TH3DOptions;
begin
  Result := H3DOptions_LoadTextures;
end;

function TH3DOptionsHelper.GetMaxAnisotropy: TH3DOptions;
begin
  Result := H3DOptions_MaxAnisotropy;
end;

function TH3DOptionsHelper.GetMaxLogLevel: TH3DOptions;
begin
  Result := H3DOptions_MaxLogLevel;
end;

function TH3DOptionsHelper.GetMaxNumMessages: TH3DOptions;
begin
  Result := H3DOptions_MaxNumMessages;
end;

function TH3DOptionsHelper.GetSampleCount: TH3DOptions;
begin
  Result := H3DOptions_SampleCount;
end;

function TH3DOptionsHelper.GetShadowMapSize: TH3DOptions;
begin
  Result := H3DOptions_ShadowMapSize;
end;

function TH3DOptionsHelper.GetSRGBLinearization: TH3DOptions;
begin
  Result := H3DOptions_SRGBLinearization;
end;

function TH3DOptionsHelper.GetTexCompression: TH3DOptions;
begin
  Result := H3DOptions_TexCompression;
end;

function TH3DOptionsHelper.GetTrilinearFiltering: TH3DOptions;
begin
  Result := H3DOptions_TrilinearFiltering;
end;

function TH3DOptionsHelper.GetWireframeMode: TH3DOptions;
begin
  Result := H3DOptions_WireframeMode;
end;

initialization
  H3D := THorde3DContainer.Create;
  H3DUtils := THorde3DUtilsContainer.Create;

  H3DOptions := TH3DOptionsHelper.Create;
  H3DStats := TH3DStatsHelper.Create;
  H3DResTypes := TH3DResTypesHelper.Create;
  H3DResFlags := TH3DResFlagsHelper.Create;
  H3DFormats := TH3DFormatsHelper.Create;
  H3DGeoRes := TH3DGeoResHelper.Create;
  H3DAnimRes := TH3DAnimResHelper.Create;
  H3DMatRes := TH3DMatResHelper.Create;
  H3DShaderRes := TH3DShaderResHelper.Create;
  H3DTexRes := TH3DTexResHelper.Create;
  H3DPartEffRes := TH3DPartEffResHelper.Create;
  H3DPipeRes := TH3DPipeResHelper.Create;
  H3DNodeTypes := TH3DNodeTypesHelper.Create;
  H3DNodeFlags := TH3DNodeFlagsHelper.Create;
  H3DNodeParams := TH3DNodeParamsHelper.Create;
  H3DModel := TH3DModelHelper.Create;
  H3DMesh := TH3DMeshHelper.Create;
  H3DJoint := TH3DJointHelper.Create;
  H3DLight := TH3DLightHelper.Create;
  H3DCamera := TH3DCameraHelper.Create;
  H3DEmitter := TH3DEmitterHelper.Create;

finalization
  H3D.Free;
  H3DUtils.Free;

  H3DOptions.Free;
  H3DStats.Free;
  H3DResTypes.Free;
  H3DResFlags.Free;
  H3DFormats.Free;
  H3DGeoRes.Free;
  H3DAnimRes.Free;
  H3DMatRes.Free;
  H3DShaderRes.Free;
  H3DTexRes.Free;
  H3DPartEffRes.Free;
  H3DPipeRes.Free;
  H3DNodeTypes.Free;
  H3DNodeFlags.Free;
  H3DNodeParams.Free;
  H3DModel.Free;
  H3DMesh.Free;
  H3DJoint.Free;
  H3DLight.Free;
  H3DCamera.Free;
  H3DEmitter.Free;

end.
