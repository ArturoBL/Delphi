program GridXML;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  MiscUtils in 'L:\0- shared\MiscUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
