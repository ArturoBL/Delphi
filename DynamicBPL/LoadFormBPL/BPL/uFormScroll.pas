unit uFormScroll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, StdCtrls, Buttons,
  dxColorPicker;

type
  TFormScroll = class(TForm)
    dxColorPicker1: TdxColorPicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure dxColorPicker1ColorChanged(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    fSelectedColor: TColor;
    fstring: string;
    procedure SetSelectedColor(const Value: TColor);
    { Private declarations }
  public
    { Public declarations }
  published
    property SelectedColor : TColor read fSelectedColor write SetSelectedColor;
    property Texto : string read fstring write fstring;
  end;

var
  FormScroll: TFormScroll;



implementation

{$R *.dfm}

procedure TFormScroll.FormCreate(Sender: TObject);
begin
  SelectedColor := dxColorPicker1.Color;
  Texto := Edit1.Text;
end;

procedure TFormScroll.SetSelectedColor(const Value: TColor);
begin
  dxColorPicker1.Color := value;
  fSelectedColor := Value;

//  if Value = clgreen then
//    ShowMessage('cambiado a verde')
//  else
//    ShowMessage('Otro color');
end;

procedure TFormScroll.dxColorPicker1ColorChanged(Sender: TObject);
begin
  SelectedColor := dxColorPicker1.Color;
end;


procedure TFormScroll.Edit1Change(Sender: TObject);
begin
  Texto := Edit1.Text;
end;

initialization
  RegisterClass (TFormScroll);


end.
