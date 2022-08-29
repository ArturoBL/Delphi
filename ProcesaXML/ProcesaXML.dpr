program ProcesaXML;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MiscUtils in 'L:\0- shared\MiscUtils.pas',
  XMLProfact2 in 'L:\4- cxc\XMLProfact2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
