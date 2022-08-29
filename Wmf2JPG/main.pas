unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure Convertir(Origen, Destino: string);
var
  Imagen: TPicture;
  Bitmap: TBitmap;
  Jpg: TJPEGImage;
begin
  Imagen:= TPicture.Create;
  Jpg:= TJPEGImage.Create;
  try
    Imagen.LoadFromFile(Origen);
    if not (Imagen.Graphic is TBitmap) then
    begin
      Bitmap:= TBitmap.Create;
      try
        Bitmap.Width:= Imagen.Width;
        Bitmap.Height:= Imagen.Height;
        Bitmap.Canvas.Draw(0,0,Imagen.Graphic);
        Jpg.Assign(Bitmap);
      finally
        Bitmap.Free;
      end;
    end
    else
      Jpg.Assign(Imagen.Graphic);
    Jpg.SaveToFile(Destino);
  finally
    Jpg.Free;
    Imagen.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Convertir('00015.wmf','00015.jpg');
end;

end.
