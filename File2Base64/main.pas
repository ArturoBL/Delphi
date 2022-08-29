unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, StdCtrls, IdGlobal;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    encoder: TIdEncoderMIME;
    Button2: TButton;
    decoder: TIdDecoderMIME;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  F1,F2: TFileStream;
  s : string;
begin
  OpenDialog.FileName := '';
  SaveDialog.FileName := '';
  if OpenDialog.Execute and SaveDialog.Execute then
  begin
    try
      F1 := TFileStream.Create( OpenDialog.FileName, fmOpenRead );
      F2 := TFileStream.Create( SaveDialog.FileName, fmCreate );
      s := encoder.Encode(f1);
      F2.Write( s[1], Length( s ) );
      F1.Free;
      F2.Free;
      ShowMessage('Archivo guardado correctamente');
    except
      on e: exception do
        ShowMessage('Error: ' + e.Message);
    end
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  a1,a2,s : string;
  Bytes: TIdBytes;
  F1, F2 : TFileStream;
begin
  a1 := SaveDialog.FileName; a2 := OpenDialog.FileName;
  OpenDialog.FileName := a1; SaveDialog.FileName := a2;
  if OpenDialog.Execute and SaveDialog.Execute then
  begin
    F1 := TFileStream.Create( OpenDialog.FileName, fmOpenRead );
    F1.Read(s[1], f1.Size);



    Bytes := decoder.DecodeBytes(s);
    F2 := TFileStream.Create( SaveDialog.FileName, fmCreate );
    f2.write(bytes, length(bytes));

    f1.Free;f2.Free;
  end;
end;

end.
