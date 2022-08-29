unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, dxmdaset, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, Grids, DBGrids;

type
  TForm1 = class(TForm)
    dmdDeptos: TdxMemData;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    dmdEmp: TdxMemData;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure dmdEmpFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure dmdDeptosAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure CreateField(AMemData: TDataSet; AFieldName: string; AFieldType: TFieldType;pSize : integer);
begin
 if (AMemData = nil) or (AFieldName = '') then
   Exit;

 with AMemData.FieldDefs.AddFieldDef do
 begin
   Name := AFieldName;
   DataType := AFieldType;
   if pSize > 0 then
     Size := pSize;
   CreateField(AMemData);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  SL: TStringList;
begin
  CreateField(dmdDeptos,'no_depto',ftInteger,0);
  CreateField(dmdDeptos,'departamento',ftString,50);
  dmdDeptos.Open;

  SL := TStringList.Create;
  SL.Add('no_depto,departamento');
  SL.Add('1,Sistemas');
  SL.Add('2,Compras');
  SL.Add('3,Control de obras');
  SL.Add('4,CXC');

  dmdDeptos.DelimiterChar :=',';
  dmdDeptos.LoadFromStrings(SL);


  CreateField(dmdEmp,'no_empleado',ftInteger,0);
  CreateField(dmdEmp,'no_depto',ftInteger,0);
  CreateField(dmdEmp,'nombre',ftString,80);
  sl.Clear;
  SL.Add('no_empleado,no_depto,nombre');
  SL.Add('1,2,Gaby');
  sl.Add('2,1,Arturo');
  sl.Add('3,3,Jorge');
  sl.Add('4,1,Ernesto');
  dmdEmp.DelimiterChar :=',';
  dmdEmp.LoadFromStrings(SL);
  SL.Free;
  dmdEmp.Filtered := True;
end;

procedure TForm1.dmdEmpFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet['no_depto'] = dmdDeptos['no_depto']; 
end;

procedure TForm1.dmdDeptosAfterScroll(DataSet: TDataSet);
begin
  dmdEmp.UpdateFilters;
end;

end.
