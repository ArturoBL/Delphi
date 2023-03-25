program GridSave;

uses
  Vcl.Forms,
  main in 'main.pas' {FormMain},
  IXMLData in '..\IXMLData.pas',
  GridXML in 'GridXML.pas',
  DSUnit in 'DSUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
