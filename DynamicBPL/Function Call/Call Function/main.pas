unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
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

procedure CallModuleFunc(opt : integer);
var
  H: THandle;
  P: procedure();
begin
  if opt = 0 then
    H := LoadPackage('..\BPL\dynbpl.bpl')
  else
    H := LoadPackage('..\BPL\dynbpl2.bpl');
  try
    if (H <> 0) then
    begin
      @P := GetProcAddress(H, 'DoSomething');

      if Assigned(P) then
        P();
    end;
  finally
    UnloadPackage(H);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CallModuleFunc(RadioGroup1.ItemIndex);
end;

end.
