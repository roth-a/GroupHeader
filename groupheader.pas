{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit GroupHeader; 

interface

uses
  UGroupHeader, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('UGroupHeader', @UGroupHeader.Register); 
end; 

initialization
  RegisterPackage('GroupHeader', @Register); 
end.
