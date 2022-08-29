unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, gr32, gr32_polygons, gr32_paths, gr32_vectorutils,gr32_geometry, gr32_layers,
  GR32_Image;

type
  TForm1 = class(TForm)
    img: TImage32;
    procedure FormCreate(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer;
      Layer: TCustomLayer);
    procedure imgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    { Private declarations }
  public
    { Public declarations }
    si : integer;
    mp : tfloatpoint;
    pts, bp : tarrayoffloatpoint;
    function hittest(px,py: integer): integer;
    procedure draw;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function MakeBezierCurve(const CtrlPts: TArrayOfFloatPoint): TArrayOfFloatPoint;
var
  Index: Integer;
begin
  with TFlattenedPath.Create do
  try
    MoveTo(CtrlPts[0]);
    for Index := 0 to (High(CtrlPts) - 3) div 3 do
      CurveTo(CtrlPts[Index * 3 + 1], CtrlPts[Index * 3 + 2],
        CtrlPts[Index * 3 + 3]);
    Result := Points;
  finally
    Free;
  end;
end;

procedure TForm1.draw;
var
  i : integer;
  cp : tarrayoffloatpoint;
begin
  img.Bitmap.FillRectS(img.Bitmap.BoundsRect,clwhite32);
  bp := MakeBezierCurve(pts);
  polylinefs(img.Bitmap,pts,clgreen32);
  polylinefs(img.Bitmap,bp,clblue32);
  for i := 0 to High(pts) do
  begin
    cp := circle(pts[i],7);
    polygonfs(img.Bitmap,cp,clwhite32);
    polylinefs(img.Bitmap, cp,clred32,true)
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  si := -1;
  img.Bitmap := tbitmap32.Create(img.Width, img.Height);
  pts := BuildPolygonF([100,200,250,100, 300,250, 500,350]);

  draw;
end;

function TForm1.hittest(px,py: integer): integer;
var
  i : integer;
  cp : tarrayoffloatpoint;
begin
  result := -1;
  for i := 0 to High(pts) do
  begin
    cp := circle(pts[i],7);
    if PointInPolygon(floatpoint(px,py),cp) then
    begin
      result := i;
      exit;
    end;
  end;
end;

procedure TForm1.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  mp := floatpoint(x,y);
  si := hittest(x,y);
  draw;
end;

procedure TForm1.imgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
  if si >= 0 then
  begin
    pts[si].X := pts[si].X + x - mp.X;
    pts[si].Y := pts[si].Y + y - mp.Y;
    draw;
  end;
  mp.X := x;
  mp.Y := y;
end;

procedure TForm1.imgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  si := -1;
end;

end.
