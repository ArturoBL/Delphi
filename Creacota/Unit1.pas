unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  GR32_Image, gr32, gr32_polygons, gr32_vectorutils, gr32_layers, gr32_misc, gr32_math, gr32_geometry, gr32_arrowheads, gr32_paths, gr32_backends, math, gr32_transforms, gr32_clipper,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    pb: TPaintBox32;
    Label1: TLabel;
    Label2: TLabel;
    procedure pbPaintBuffer(Sender: TObject);
    procedure pbMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure pbMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    nc : integer;
    p1,p2,p3 : tfloatpoint;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function CopyPoly(p: TArrayOfFloatPoint): TArrayOfFloatPoint;
var i : integer;
begin
  SetLength(Result,High(p)+1);
  for i := 0 to High(p) do
    result[i] := p[i];
end;

function PolyPolyFloatRect(polyPts: TArrayOfArrayOfFloatPoint): TFloatRect;
var
  i,j: integer;
  firstPointPending: boolean;
begin
  firstPointPending := true;
  for i := 0 to high(polyPts) do
    for j := 0 to high(polyPts[i]) do
      with polyPts[i][j], result do
        if firstPointPending then
        begin
          left := X ; top := Y; right := X; bottom := Y;
          firstPointPending := false;
        end else
        begin
          if X < left then left := X else if X > right then right := X;
          if Y < top then top := Y else if Y > bottom then bottom := Y;
        end;
  if firstPointPending then result := floatRect(0,0,0,0);
end;

Function BuildPolyPolyCota(p1,p2,p3 : tfloatpoint; pcad : string; parrowsize, pfontsize : integer) : TArrayOfArrayOfFloatPoint;
  var
    pt1, pt2, pp1, pp2, pr, pm1,pm2, lc : tfloatpoint;
    l : tarrayoffloatpoint;
    Arrow: TArrowHeadAbstract;
    FPath: TFlattenedPath;
    alfa, beta, d, sb, cb, sa, ca : tfloat;
    cad : string;
    Intf: ITextToPathSupport;
    fr : TFloatRect;
    T: TAffineTransformation;
    vt : TArrayOfArrayOfFloatPoint;
    i,j, nArrowSize : integer;
    bm : tbitmap32;
    d2 : tfloat;
  begin

    if p1 = p2 then exit;
    if p1 <> p2 then
    begin
      d2 := distance(p1,p2);
      narrowsize := parrowsize;
    end;

    //Àngulo perpendicular a la recta
    beta := pi/2 - gr32_geometry.GetAngleOfPt2FromPt1(p1, p2);  //Perpendicular a la lìnea
    gr32_math.SinCos(beta,sb,cb);

    //Obtenemos los puntps proyectados pp1 y pp2
    pt1 := floatpoint(p1.x + 50 * cb, p1.Y + 50 * sb);
    pt2 := floatpoint(p1.x - 50 * cb, p1.Y - 50 * sb);
    pp1 := ClosestPointOnLine(p3,pt1,pt2,false);

    pt1 := floatpoint(p2.x + 50 * cb, p2.Y + 50 * sb);
    pt2 := floatpoint(p2.x - 50 * cb, p2.Y - 50 * sb);
    pp2 := ClosestPointOnLine(p3,pt1,pt2,false);


    //Generar Objetos de texto
    bm := tbitmap32.Create;
    if Supports(bm.Backend, ITextToPathSupport, Intf) then
    begin
      FPath := TFlattenedPath.Create;
      bm.Font.Size := pFontsize;
      alfa := gr32_geometry.GetAngleOfPt2FromPt1(p1, p2);
      gr32_math.SinCos(alfa,sa,ca);

      if pcad <> ''
      then cad := pCad
      else cad := format('%.0f mm',[distance(p1,p2)]);

      Intf.TextToPath(FPath, 0,0, cad);
      fr := polypolyFloatRect(FPath.Path);

      d := distance(pp1,pp2);
      T := TAffineTransformation.Create;

      //Se calcula el centro del rectángulo del texto
      pr.X := (fr.Right + fr.Left)/2;
      pr.Y := (fr.Bottom + fr.Top)/2;

      form1.Label1.Caption := format('%.4f',[alfa*180/pi]);

      //Se calcula el centro de la linea
      lc.X := ((pp1.X + pp2.X) / 2)-(pr.X);
      lc.Y := ((pp1.Y + pp2.Y) / 2)-(pr.Y);

      if p1.X <= p2.X
      then T.Rotate(pr.X,pr.Y,alfa*180/pi)
      else T.Rotate(pr.X,pr.Y,(alfa+pi)*180/pi);

      t.Translate(lc.X,lc.y);

      vt := FPath.Path;
      for i := 0 to High(vt) do
        for j := 0 to High(vt[i]) do
          vt[i,j] := t.Transform(vt[i,j]);
    end;

    //tmppoints := BuildPolygonF([p1.X,p1.Y, pp1.X, pp1.Y, pp2.X, pp2.Y, p2.X, p2.Y ]);

    setlength(result,6);
    //Lìneas terminaciones
    result[0] := Line(p1,pp1);
    result[1] := Line(p2,pp2);

    //La línea principal se separa en dos partes, polígonos 2 y 3
    d := distance(p1,p2);
    l := Shorten(Shorten(line(pp1, pp2), pArrowSize, lpStart),d/2 + (fr.Right - fr.Left)/2 + 3,lpend);
    result[2] := l;
    l := Shorten(Shorten(line(pp1, pp2), pArrowSize, lpEnd),(d/2) + (fr.Right - fr.Left)/2 + 3,lpstart);
    result[3] := l;

    //Flechas en polígonos 4 y 5
    //Arrow := TArrowHeadFourPt.Create(pArrowSize);
    Arrow := TArrowHeadFourPt.Create(nArrowSize);
    result[4] := Arrow.GetPoints(result[2], false);    //Flecha inicio
    result[5] := Arrow.GetPoints(result[3], true);     //Flecha final


    j := high(result) + 1;
    setlength(result, high(result) + high(vt) + 2);
    for i := 0 to High(vt) do
    begin
      result[i+j] := CopyPoly(vt[i]);
    end;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  nc := 0;
end;

procedure TForm1.pbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if nc >= 3 then
    nc := 0;

  if nc = 0 then
  begin
    p1 := floatpoint(x,y);
    p2 := p1; p3 := p1;
  end
  else
  begin
    if nc = 1 then
    begin
      p2 := floatpoint(x,y);
      p3 := p2;
    end
    else
    begin
      p3 := floatpoint(x,y);
    end;
  end;
  inc(nc);
  label1.Caption := inttostr(nc);
  pb.Invalidate;
end;

procedure TForm1.pbMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if nc = 1 then
  begin
    p2 := floatpoint(x,y);
    p3 := floatpoint(x,y);
    pb.Invalidate;
  end
  else
  begin
    if nc = 2 then
      p3 := floatpoint(x,y);
    pb.Invalidate;
  end;
end;

procedure TForm1.pbMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if nc = 2 then
  begin
    //nc := 3;
    p3 := floatpoint(x,y);
    pb.Invalidate;
  end;
  //showmessage('click');
end;

procedure TForm1.pbPaintBuffer(Sender: TObject);
var
  c1 : TArrayOfArrayOfFloatPoint;

begin
//  p1 := floatpoint(50,50);
//  p2 := floatpoint(200,200);
//  p3 := floatpoint(200,220);

  c1 := BuildPolyPolyCota(p1,p2,p3, '', 20, 10);
  pb.Buffer.Clear(clwhite32);

  //label2.Caption := format('%.2f,%.2f',[pc.X, pc.Y]);

  if (nc >= 1) and (p2 <> p1) then
    polypolylinefs(pb.Buffer,c1,clblack32,true);
  //pb.Buffer.Line(0,0,round(pc.X),round(pc.Y),clred32);

end;

end.
