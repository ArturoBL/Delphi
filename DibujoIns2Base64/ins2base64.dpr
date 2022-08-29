program ins2base64;

uses
  Forms,
  main in 'main.pas' {Form1},
  MiscUtils in 'L:\0- shared\MiscUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
