unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GR32_Image,gr32, GR32_VectorUtils, GR32_polygons, GR32_Geometry, GR32_layers, GR32_paths, gr32_arrowheads;

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
    lo : TArrayOfArrayOfFloatPoint;
    lp : array of tfloatpoint;
    c1,c2, ip1,ip2, mp : tfloatpoint;
    si : integer;
    Arrow: TArrowHeadAbstract;
    procedure move(np : tfloatpoint);
    function centropoly(p : tarrayoffloatpoint) : tfloatpoint;
    procedure calcpolys;
    procedure draw;
    function LinePolyIntersect(p1,p2: tfloatpoint; poly : tarrayoffloatpoint; var p :tfloatpoint) : boolean;
    function breakline(p1,p2 : tfloatpoint) : tarrayoffloatpoint;
    function hittest(p : tfloatpoint) : integer;
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

function TForm1.breakline(p1, p2: tfloatpoint): tarrayoffloatpoint;
var
  d : single;
  pm1, pm2 : tfloatpoint;
begin
  d := Distance(p2, p1)*2 / 3;

  //Arrow := TArrowHeadFourPt.Create(15);


  if abs(p2.X - p1.X) > abs(p2.Y - p1.Y) then
  begin
    if p2.X > p1.X then d := -d;
    pm1 := FloatPoint(p2.X + d, p2.Y);
    pm2 := FloatPoint(p1.X - d, p1.Y);
  end
  else
  begin
    if p2.Y > p1.Y then d := -d;
    pm1 := FloatPoint(p2.X, p2.Y + d);
    pm2 := FloatPoint(p1.X, p1.Y - d);
  end;
  result := MakeBezierCurve(BuildPolygonF([p2.X, p2.Y,
                                           pm1.X, pm1.Y,
                                           pm2.X, pm2.Y,
                                           p1.X, p1.Y]));
end;

procedure TForm1.calcpolys;
var
  i : integer;
begin
  for I := 0 to High(lo) do
    lo[i] :=  RoundRect(floatRect(lp[i], floatpoint(lp[i].X + 100, lp[i].Y + 50)), 20);
  c1 := centropoly(lo[0]);
  c2 := centropoly(lo[1]);
  LinePolyIntersect(c1,c2, lo[0], ip1);
  LinePolyIntersect(c1,c2, lo[1], ip2);
end;

function TForm1.centropoly(p: tarrayoffloatpoint): tfloatpoint;
var
  i : integer;
  fx, fy : tfloat;
begin
  fx := 0; fy := 0;
  for i := 0 to High(p) do
  begin
    fx := fx + p[i].X;
    fy := fy + p[i].Y;
  end;
  result := floatpoint(fx/(high(p)+1),fy/(high(p)+1));
end;

procedure TForm1.draw;
var
  i : integer;
  bl,l,a1,a2 : tarrayoffloatpoint;
begin
  Img.Bitmap.FillRectS(Img.Bitmap.BoundsRect, clWhite32);

  if si = 0
  then PolylineFS(img.Bitmap,Lo[0], clred32, true)
  else PolylineFS(img.Bitmap,Lo[0], clblack32, true);
  if si = 1
  then PolylineFS(img.Bitmap,Lo[1], clred32, true)
  else PolylineFS(img.Bitmap,Lo[1], clblack32, true);
  l := BuildpolygonF([c1.X,c1.Y,c2.X,c2.Y]);
  //PolylineFS(img.Bitmap,L, clgray32, true);
  //bl := BuildpolygonF([ip1.X,ip1.Y,ip2.X,ip2.Y]);
  bl := breakline(ip1,ip2);

  bl := Shorten(bl, 15, lpStart);
  bl := Shorten(bl, 15, lpEnd);
  PolylineFS(img.Bitmap,bl,clred32,false);

  a1 := Arrow.GetPoints(bl, False);
  a2 := Arrow.GetPoints(bl, true);
  PolylineFS(img.Bitmap, Arrow.GetPoints(bl, False), clred32, true);
  PolylineFS(img.Bitmap, Arrow.GetPoints(bl, true), clred32, true);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  img.Bitmap := tbitmap32.Create(img.Width, img.Height);

  setlength(lp,2);
  lp[0] := floatpoint(100, 100);
  lp[1] := floatpoint(450, 300);

  setlength(lo,high(lp)+1);
  Arrow := TArrowHeadFourPt.Create(15);
  calcpolys;
  si := -1;
  draw;
end;

function TForm1.hittest(p: tfloatpoint): integer;
var
  i : integer;
begin
  result := -1;
  for i := High(lo) downto 0 do
  begin
    if PointInPolygon(p,lo[i]) then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TForm1.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  mp := floatpoint(x,y);
  si := hittest(mp);
  draw;
end;

procedure TForm1.imgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var
  p :tfloatpoint;
begin
  p := floatpoint(x,y);
  if si >= 0 then
  begin
    move(p);
    draw;
  end;
  mp := p;
end;

procedure TForm1.imgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  si := -1;
  draw;
end;

function TForm1.LinePolyIntersect(p1, p2: tfloatpoint; poly: tarrayoffloatpoint;
  var p: tfloatpoint): boolean;
var
  i : integer;
  pi,pf : tfloatpoint;
begin
  result := SegmentIntersect(p1, p2, poly[0], poly[high(poly)],p);

  if not result then
  for I := 1 to High(poly) do
  begin
    pi := poly[i-1];
    pf := poly[i];
    result := SegmentIntersect(p1, p2, pi, pf,p);
    if result then
      break;
  end;
end;

procedure TForm1.move(np: tfloatpoint);
begin
  if (si >= 0) and ((np.X <> mp.X)or(np.Y <> mp.Y)) then
  begin
    lp[si].X := lp[si].X + np.X - mp.X;
    lp[si].Y := lp[si].Y + np.Y - mp.Y;
    calcpolys;
  end;
end;

end.
