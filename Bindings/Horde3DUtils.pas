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

unit Horde3DUtils;

interface

{$I Horde3D.inc}

uses
  Horde3D;
  
const
  {$IFDEF UNIX}
    {$IFDEF DARWIN}
	  Horde3DUtilsLib = 'Horde3DUtils';
	  
	  {$IFDEF AUTO_LINK}
	    {$LINKFRAMEWORK Horde3DUtils}
	  {$ENDIF}
	{$ELSE}
	  Horde3DUtilsLib = 'libHorde3DUtils.so';
	  
	  {$IFDEF AUTO_LINK}
	    {$LINKLIB Horde3DUtils}
	  {$ENDIF}
	{$ENDIF}
  {$ELSE}
    Horde3DUtilsLib = 'Horde3DUtils.dll';
  {$ENDIF}
  
  (**   Group: Typedefs and constants 
   *	Constants: Predefined constants
   *	H3DUTMaxStatMode  - Maximum stat mode number supported in showFrameStats
   *)
const
  H3DUTMaxStatMode: Integer = 2;


(*	Topic: Introduction
		Some words about the Utility Library.
	
	Horde3D has a simple core API which offers all the functionality needed to control the engine. The
	engine core is intended to be as generic as possible to make the complete system lightweight and clean.
	Nevertheless, it is sometimes useful to have more specific functions in order to increase productivity.
	For this reason the Utility Library is offered. It has some very handy functions that can help
	to make your life easier.
*)


(*	Group: General functions *)
procedure h3dutFreeMem(Ptr: PPChar); cdecl; external Horde3DUtilsLib;
function h3dutDumpMessages(): Boolean; cdecl; external Horde3DUtilsLib;
function h3dutInitOpenGL(hDC: Integer): Boolean; cdecl; external Horde3DUtilsLib;
procedure h3dutReleaseOpenGL(); cdecl; external Horde3DUtilsLib;
procedure h3dutSwapBuffers(); cdecl; external Horde3DUtilsLib;

(*	Group: Resource management *)
function h3dutGetResourcePath(type_: Integer): PAnsiChar; cdecl; external Horde3DUtilsLib;
procedure h3dutSetResourcePath(type_: Integer; const path: PAnsiChar); cdecl; external Horde3DUtilsLib;
function h3dutLoadResourcesFromDisk(contentDir: PAnsiChar): Boolean; cdecl; external Horde3DUtilsLib;
function h3dutCreateGeometryRes(name: PAnsiChar; numVertices: Integer; numTriangleIndices: Integer; 
         posData: PSingle; indexData: PCardinal; normalData: PSmallInt;
	 tangentData: PSmallInt; bitangentData: PSmallInt;
	 texData1: PSingle; texData2: PSingle): TH3DRes; cdecl; external Horde3DUtilsLib;
function h3dutCreateTGAImage(const pixels: PByte; width: Integer; height: Integer; bpp: Integer;
                              var outData: PAnsiChar; var outSize: Integer): Boolean; cdecl; external Horde3DUtilsLib;

(*	Group: Utils *)
function h3dutScreenshot(const filename: PAnsiChar): Boolean; cdecl; external Horde3DUtilsLib;

(*	Group: Scene graph *)
procedure h3dutPickRay(cameraNode: TH3DNode; nwx: Single; nwy: Single; ox: PSingle; oy: PSingle; oz: PSingle;
                       dx: PSingle; dy: PSingle; dz: PSingle); cdecl; external Horde3DUtilsLib;
function h3dutPickNode(cameraNode: TH3DNode; nwx: Single; nwy: Single): TH3DNode; cdecl; external Horde3DUtilsLib;

(*	Group: Overlays *)
procedure h3dutShowText(text: PAnsiChar; x: Single; y: Single; size: Single;
                        colR: Single; colG: Single; colB: Single; fontMaterialRes: TH3DRes); cdecl; external Horde3DUtilsLib;
procedure h3dutShowFrameStats(fontMaterialRes: TH3DRes; panelMaterialRes: TH3DRes; mode: Integer); cdecl; external Horde3DUtilsLib;

implementation

end.
