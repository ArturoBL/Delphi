unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,TypInfo,
  Buttons, sSpeedButton, sColorSelect, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    sColorSelect1: TsColorSelect;
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
  FormScroll : TForm;
  FormClass : TFormClass;
  HandlePack : HModule;
  s : string;
  i : Integer;
  f : function(frm:TForm):tcolor;
begin
  HandlePack := LoadPackage ('..\BPL\PackWithForm.bpl');
  if HandlePack > 0 then
  begin
    //La aplicación debe ser compilada con "build with runtime packages vcl;rtl para que se pueda obtener la clase"
    FormClass := TFormClass(GetClass ('TFormScroll'));
    if Assigned (FormClass) then
    begin
      FormScroll := FormClass.Create (Application);
      try

        // initialize the data
        SetPropValue (FormScroll, 'SelectedColor', clred);
        SetPropValue (FormScroll, 'Texto', 'prueba');
        // show the form
        if FormScroll.ShowModal = mrOK then
        begin

           s := GetPropValue(FormScroll, 'Texto');
           ShowMessage(s);
           sColorSelect1.colorValue := GetPropValue (FormScroll, 'SelectedColor');

        end;

      finally
        FormScroll.Free;
      end;
    end
    else
      ShowMessage ('Form class not found');
    UnloadPackage (HandlePack);
  end
  else
    ShowMessage ('Package not found');
end;

end.
