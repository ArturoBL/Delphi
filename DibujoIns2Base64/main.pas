unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MiscUtils, Oracle, JPeG, db, StdCtrls, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME;

type
  TForm1 = class(TForm)
    OracleSession1: TOracleSession;
    Button1: TButton;
    IdEncoderMIME1: TIdEncoderMIME;
    Memo1: TMemo;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  sql : string;
  jpg : TJPEGImage;
  bS, bs2  : TStream;
  bm : TBitmap;
  Wmf : TMetafile;
  Imagen: TPicture;
begin
  sql := 'Select imagen, substr(regexp_substr(lower(archivo_dibujo),''[a-z]{3,4}$''),1,1) tipo ' +
         '  from insumos_genericos where cve_generica = :cve_generica ';
  with resultSQL(OracleSession1, sql,['00015']) do
  begin
    if not FieldByName('imagen').IsNull then
    begin
      bS := CreateBlobStream(FieldByName('imagen'), bmRead);
      if (FieldByName('tipo').AsString = 'j') then
      begin
        jpg := TJPEGImage.Create;
        jpg.LoadFromStream(bs);
      end
      else
      if FieldByName('tipo').AsString = 'w' then
      begin
        try
          Wmf := TMetafile.Create;
          Wmf.LoadFromStream(bs);
          bm := TBitmap.Create;
          bm.Width := wmf.Width;
          bm.Height := Wmf.Height;
          bm.Canvas.Draw(0,0,wmf);
          jpg := TJPEGImage.Create;
          jpg.Assign(bm);
        finally
          {Jpg.Free;}
          Wmf.Free;
          bm.Free;
        end;
      end;
      if jpg <> nil then
      begin
        bs2 := TMemoryStream.Create;
        jpg.SaveToStream(bs2);
        bs2.Position := 0;
        memo1.Text := IdEncoderMIME1.Encode(bs2);

        //jpg.SaveToFile('arch.jpg');
        jpg.Free;
      end;
    end;
    close;Free;
  end;
end;

end.
