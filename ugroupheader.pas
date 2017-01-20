unit UGroupHeader;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, extctrls;

type
  //THeaderLabel = class(TBoundLabel)
  //private

  //public
  //end;


  { TBoundPanel }

  TBoundPanel = class(TPanel)
  private

  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;


  { TGroupHeader }

  TGroupHeader = class(TPanel)
  private
    { Private declarations }
    FBoundLabel:TBoundLabel;
    FBoundPanelLeft:TBoundPanel;
    FBoundPanelRight:TBoundPanel;

    procedure OnLabelResize(Sender: TObject);
    procedure DoOnResize;  override;
   protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Arrange;

    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property BoundLabel:TBoundLabel read FBoundLabel;
    property BoundPanelLeft:TBoundPanel read FBoundPanelLeft;
    property BoundPanelRight:TBoundPanel read FBoundPanelRight;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Misc',[TGroupHeader]);
end;

{ TGroupHeader }


procedure TGroupHeader.OnLabelResize(Sender: TObject);
begin
  Arrange;
end;

procedure TGroupHeader.DoOnResize;
begin
  inherited;

  Arrange;
end;



procedure TGroupHeader.Arrange;
const abstand=10;
var wi:integer;
begin
  Self.Caption:='';
  if (FBoundLabel=nil)or(FBoundPanelLeft=nil)or(FBoundPanelRight=nil)then
    exit;

  wi:=(Self.Width-FBoundLabel.Width-abstand*2) div 2;
  if wi<0 then
    wi:=0;

  with FBoundLabel do
    begin
    Left:=wi+abstand;
    Top:=(Self.Height - Height) div 2;
    end;
  with FBoundPanelLeft do
    begin
    Left:=0;
    Top:=(Self.Height - Height) div 2;
    Width:=wi;
    end;
  with FBoundPanelRight do
    begin
    Top:=FBoundPanelLeft.Top;
    Width:=wi;
    Left:=Self.Width-Width;
    end;
end;



constructor TGroupHeader.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  BevelOuter:=bvNone;

  FBoundLabel:=TBoundLabel.Create(self);
  with FBoundLabel do
    begin
    Name:='SubLabel';
    Parent:=self;
    Font.Style:=[fsBold];
    Font.Size:=10;
    AutoSize:=true;
    FocusControl:=self;
    OnResize:=@OnLabelResize;
    ControlStyle := ControlStyle + [csNoFocus, csNoDesignSelectable];
    end;

  FBoundPanelLeft:=TBoundPanel.Create(self);
  with FBoundPanelLeft do
    begin
    Name:='SubPanelLeft';
    Caption:='';
    Parent:=self;
    Height:=5;
    ControlStyle := ControlStyle + [csNoFocus, csNoDesignSelectable];
    end;

  FBoundPanelRight:=TBoundPanel.Create(self);
  with FBoundPanelRight do
    begin
    Name:='SubPanelRight';
    Caption:='';
    Parent:=self;
    Height:=FBoundPanelLeft.Height;
    ControlStyle := ControlStyle + [csNoFocus, csNoDesignSelectable];
    end;
  Width:=200;
  Height:=18;
end;

destructor TGroupHeader.Destroy;
begin
  FBoundLabel.Free;
  FBoundPanelLeft.Free;
  FBoundPanelRight.Free;

  inherited Destroy;
end;


{ TBoundPanel }

constructor TBoundPanel.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  SetSubComponent(True);
end;

destructor TBoundPanel.Destroy;
begin
  inherited Destroy;
end;

end.
