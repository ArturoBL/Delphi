unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, StdCtrls, Grids, DBGrids, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxmdaset;

type
  TForm1 = class(TForm)
    memd: TdxMemData;
    datasource: TDataSource;
    gtv: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DBGrid1: TDBGrid;
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

procedure CreateField(AMemData: TDataSet; AFieldName: string; AFieldType: TFieldType; psize : integer);
begin
  if (AMemData = nil) or (AFieldName = '') then
    Exit;
  with AMemData.FieldDefs.AddFieldDef do
  begin
    Name := AFieldName;
    DataType := AFieldType;
    CreateField(AMemData);
    if psize > 0 then
      Size := psize;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  AColumn: TcxGridDBColumn;
begin
  CreateField(memd, 'Partida',ftInteger,0);
  CreateField(memd, 'Descripcion',ftString,80);
  CreateField(memd, 'Costo',ftCurrency,0);
  CreateField(memd, 'Sem1',ftInteger,0);
  CreateField(memd, 'Sem2',ftInteger,0);
  CreateField(memd, 'Sem3',ftInteger,0);
  memd.Open;
//  memd.Insert;
  //memd.FieldByName('Data').AsString  := 'a';
//  memd.Post;
  gtv.DataController.DataSource := DataSource;
  gtv.DataController.CreateAllItems(false);
  acolumn := gtv.GetColumnByFieldName('Descripcion');
  AColumn.Caption := 'Descripción';
  acolumn := gtv.GetColumnByFieldName('Sem1');
  AColumn.Caption := 'Sem'#10#13'21/15';
end;

end.
