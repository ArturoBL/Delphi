unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  gr32_math, gr32_geometry, gr32_arrowheads, gr32_paths, gr32_backends, math, gr32_transforms,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GR32_Image, gr32, gr32_vectorutils, gr32_polygons, gr32_layers,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Img: TImage32;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer;
      Layer: TCustomLayer);
  private
    { Private declarations }
    iv : integer;
  public
    { Public declarations }
    st, rc : TArrayOfFloatPoint;
    p : tfloatpoint;
    procedure draw;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function FindNearestPointIndex(Point: TFloatPoint; Points: TArrayOfFloatPoint): Integer;
var
  Index: Integer;
  Distance: TFloat;
  NearestDistance: TFloat;
begin
  Result := 0;
  NearestDistance := SqrDistance(Point, Points[0]);
  for Index := 1 to High(Points) do
  begin
    Distance := SqrDistance(Point, Points[Index]);
    if Distance < NearestDistance then
    begin
      NearestDistance := Distance;
      Result := Index;
    end;
  end;
end;

function prPoint(pn : tfloatpoint; p1, p2 : tfloatpoint) : tfloatpoint;
var
  v1, v2 : tfloatpoint;
  lenlineE1, lenlineE2, cs, projLenOfLine : tfloat;
  valdp : tfloat;
begin
  //if p2 <> p1 then
  begin
    v1 := floatpoint(p2.X - p1.X, p2.Y - p1.Y);  //Vector de la l�nea
    v2 := floatpoint(pn.X - p1.X, pn.Y - p1.Y);  //Vector del punto p1 hacia el punto a proyectar
    valdp := Dot(v1,v2);
    lenlinee1 := distance(floatpoint(0,0),v1);  //Magnitud del vector v1
    lenlinee2 := distance(floatpoint(0,0),v2);  //Magnitud del vector v2
    if (lenlinee1 <> 0) and (lenlinee2 <> 0)  then
      cs := valdp/(lenlinee1 * lenlinee2);
    projLenOfLine := cs * lenlineE2;
    result := floatpoint(p1.X + projlenofline * v1.X / lenlineE1, p1.Y + projlenofline * v1.Y / lenlinee1);
  end

end;


function PointInLine(p, p1, p2 : tfloatpoint): Boolean;
var
  Theta,  sine, cosinus, dxl, dyl: single;
begin
  dxl := p2.x - p1.x;
  dyl := p2.y - p1.y;

  if abs(dxl) > abs(dyl) then
  begin
    if dxl>0 then
      result := (p1.x <= p.x) and (p.X <= p2.X)
    else
      result := (p2.x <= p.x) and (p.X <= p1.X);
  end
  else
  begin
    if dyl > 0 then
      result := (p1.y <= p.y) and (p.y <= p2.y)
    else
      result := (p2.y <= p.y) and (p.y <= p1.y);
  end;
end;


function nearestpt(p: tfloatpoint; poly: tarrayoffloatpoint;
    cerrado: boolean; var d : tfloat): tfloatpoint;
  var
    i1, i2, i3 : integer;
    d1,d2,d3,dx : tfloat;
    p1, p2, p3, px : TFloatPoint;
  begin
    i1 := FindNearestPointIndex(p,poly);
    p1 := poly[i1];
    d1 := sqrdistance(p,p1);
    px := p1;
    dx := d1;


    d2 := -1;
    d3 := -1;
    i2 := (i1 + 1) mod (high(poly) + 1);
    if (not cerrado) and (i2 < i1) then i2 := -1;

    if i1 > 0
    then i3 := i1 - 1
    else i3 := high(poly);
    if (not cerrado) and (i3 > i1) then i3 := -1;



    if (i2 >= 0)and (poly[i1] <> poly[i2]) then
    begin
      p2 := prPoint(p,poly[i1],poly[i2]);
      d2 := sqrdistance(p,p2);

      if (PointInLine(p2,poly[i1],poly[i2])) and (d2 < dx) then
      begin
        px := p2;
        dx := d2;
      end;

    end;

    if (i3 >= 0)and (poly[i1] <> poly[i3]) then
    begin
      if poly[i1] <> poly[i3] then

      p3 := prPoint(p,poly[i1],poly[i3]);
      d3 := sqrdistance(p,p3);

      if (PointInLine(p3,poly[i1],poly[i3])) and (d3 < dx) then
      begin
        px := p3;
        dx := d3;
      end;
    end;

    result := px;
    d := dx;
  end;


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
  pt, pm1, pm2 : tfloatpoint;
  d : single;
  lp : TArrayOfFloatPoint;
  Arrow: TArrowHeadAbstract;

  function dist(p1,p2 : tfloatpoint) : single;
  begin
    Result := (p1.X - p2.X)*(p1.X - p2.X) + (p1.Y - p2.Y)*(p1.Y - p2.Y);
  end;
begin
  Img.Bitmap.FillRectS(Img.Bitmap.BoundsRect, clWhite32);
  PolylineFS(img.Bitmap,st,clblack32,true,1);
  pt := nearestpt(p,st,true,d);

  //PolylineFS(img.Bitmap,Circle(pt,3),clred32,true);

  d := Distance(pt, p)*2 / 3;

  Arrow := TArrowHeadFourPt.Create(15);

  label2.Caption := floattostr(pt.X);
  if abs(pt.X - p.X) > abs(pt.Y - p.Y) then
  begin
    if pt.X > p.X then d := -d;
    pm1 := FloatPoint(pt.X + d, pt.Y);
    pm2 := FloatPoint(p.X - d, p.Y);
  end
  else
  begin
    if pt.Y > p.Y then d := -d;
    pm1 := FloatPoint(pt.X, pt.Y + d);
    pm2 := FloatPoint(p.X, p.Y - d);
  end;

  lp := BuildPolygonF([pt.X, pt.Y,
         pm1.X, pm1.Y,
         pm2.X, pm2.Y,
    p.X, p.Y]);

  lp := MakeBezierCurve(lp);


  lp := Shorten(lp, 15, lpStart);

  PolylineFS(img.Bitmap,lp,clred32,false);

  PolylineFS(img.Bitmap, Arrow.GetPoints(lp, False), clred32, true);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  img.Bitmap := tbitmap32.create(img.Width, img.Height);
  //st := Star(200,200, 40.0, 60.0, 7);
  st := RoundRect(floatRect(100, 100, 100 + 100, 100 + 50), 20);
  iv := -1;
  draw;
end;

procedure TForm1.ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);

begin
  //iv := FindNearestPointIndex(floatpoint(x,y),st);
  //st[i]
  p := floatpoint(x,y);
  label1.Caption := inttostr(iv);
  draw;
end;

end.
