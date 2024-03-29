unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GR32_Image, gr32, jpeg, gr32_polygons, gr32_vectorutils, gr32_geometry, gr32_layers;

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
    bk, sh : tbitmap32;
    rx,ry : integer;
    rr : tarrayoffloatpoint;
    mp : tfloatpoint;
    b : boolean;
    function rectpoly(px,py : integer): tarrayoffloatpoint;
    function getRect(px,py: integer): tfloatrect;
    function getShadowRect : tfloatrect;
    procedure draw;
    procedure actualiza(np : tfloatpoint);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Shadow;

const rectradius = 20; shadowradius = 20; shadowsep = 10;

procedure TForm1.actualiza(np: tfloatpoint);
begin
  rx := round(rx + np.X - mp.X);
  ry := round(ry + np.Y - mp.Y);
  rr := rectpoly(rx,ry);
end;

procedure TForm1.draw;
begin
  img.Bitmap.Clear(clwhite32);
  img.Bitmap.Draw(0,0,bk);

  img.Bitmap.Draw(round(rx - shadowradius + shadowsep), round(ry - shadowradius + shadowsep),sh);
  polygonfs(img.Bitmap,rr,clwhite32);
  polylinefs(img.Bitmap,rr,clblack32,true,2);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bk := tbitmap32.Create;
  bk.LoadFromFile('C:\Temp\penguins.jpg');
  img.Bitmap := tbitmap32.Create(bk.Width, bk.Height);
  rx := 30; ry := 30;
  rr := rectpoly(rx,ry);

  //el bitmap se genera una sola vez, el proceso de blur es tardado
  sh := rrBMShadow(getrect(rx,ry),rectradius,shadowradius,clblack32);
  sh.SaveToFile('c:\temp\sh.bmp');
  //img.Bitmap.Assign(bk);
  draw;
end;

function TForm1.getRect(px,py: integer): tfloatrect;
begin
  result := floatRect(px, py, px + 250, py + 150);
end;

function TForm1.getShadowRect: tfloatrect;
begin

end;

procedure TForm1.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var rp : tarrayoffloatpoint;
begin
  mp := floatpoint(x,y);
  rp :=rectpoly(rx,ry);
  //polylinefs(img.Bitmap,rp,clred32,true);
  b := PointInPolygon(mp,rp);
//  if b then
//    showmessage('as');
  //draw;
end;

procedure TForm1.imgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
  if b then
  begin
    actualiza(floatpoint(x,y));
    draw;
  end;
  mp := floatpoint(x,y);
end;

procedure TForm1.imgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  b := false;
end;

function TForm1.rectpoly(px,py : integer): tarrayoffloatpoint;
begin
  result := RoundRect(getrect(px,py),20);
end;

end.
