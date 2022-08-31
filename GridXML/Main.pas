unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XMLDoc, xmldom, XMLIntf, msxmldom,
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
  cxDBData, StdCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Wwdatsrc, Oracle, OracleData;

type
  TfrmMain = class(TForm)
    odsCompras: TOracleDataSet;
    sesion: TOracleSession;
    wdsCompras: TwwDataSource;
    TVCompras: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    TVComprasNO_ORDEN_COMPRA: TcxGridDBColumn;
    TVComprasCVE_PROVEEDOR: TcxGridDBColumn;
    TVComprasNOMBRE: TcxGridDBColumn;
    TVComprasFOLIO: TcxGridDBColumn;
    TVComprasFECHA: TcxGridDBColumn;
    TVComprasLUGAR_ENTREGA: TcxGridDBColumn;
    TVComprasFEC_ESP_ENTREGA: TcxGridDBColumn;
    TVComprasATENCION_PROVEEDOR: TcxGridDBColumn;
    TVComprasNO_CENTRO_COSTO: TcxGridDBColumn;
    sedXML: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    Button1: TButton;
    ODSDest: TOracleDataSet;
    wdsDest: TwwDataSource;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  MiscUtils;

{$R *.dfm}

function Grid2XML(pgrid : TcxGrid) : string;
var
  Xd : TXMLDocument;
  d, vs, nv, nodo, n : IXMLNode;
  i : integer;
  s : string;

  function LevelType(plevel : TcxGridLevel) : string;
  begin
    if plevel.GridView is  TcxGridDBTableView then
      Result := 'DBTableView'
    else
      Result := 'Desconocido';
  end;

  function getSQL(gview : TcxCustomGridView) : string;
  begin
    if gview is TcxGridDBTableView then
    begin
      Result := TOracleDataSet(TcxGridDBTableView(gview).DataController.DataSet).SQL.Text
    end;
  end;

  procedure GenColumns(gview : TcxCustomGridView; nview : IXMLNode);
  var
    cs, c : IXMLNode;
    i : Integer;
  begin
    if gview is TcxGridDBTableView then
    begin
      if TcxGridDBTableView(gview).ColumnCount > 0 then
      begin
        cs := nview.AddChild('Columns');
        for i := 0 to TcxGridDBTableView(gview).ColumnCount -1 do
        begin
          c := cs.AddChild('Column');
          c.Attributes['Fieldname'] := TcxGridDBTableView(gview).Columns[i].DataBinding.FieldName;
          c.Attributes['Caption'] := TcxGridDBTableView(gview).Columns[i].Caption;
          c.Attributes['Index'] := TcxGridDBTableView(gview).Columns[i].Index;
        end;
      end;
    end;
  end;

begin
  Xd := TXMLDocument.Create(nil);
  xd.Active := true;
  d := xd.Node.AddChild('Grid','');
  vs := d.AddChild('Views');

  for i := 0 to pgrid.Levels.count -1 do
  begin
    //Level info
    nv := vs.AddChild('View');
    nv.Attributes['Type'] := LevelType(pgrid.Levels[i]);
    if pgrid.Levels[i].Caption <> '' then
      nodo.Attributes['Caption'] := pgrid.Levels[i].Caption;

    //Dataset
    s := getSQL(pgrid.Levels[i].GridView);
    if s <> '' then
    begin
      n := nv.AddChild('SQL');
      n.Text := getSQL(pgrid.Levels[i].GridView);
    end;

    //Columns
    GenColumns(pgrid.Levels[i].GridView,nv);

    //ShowMessage(pgrid.Levels[0].GridView.ClassName);
  end;


  //nodo := d.AddChild('sql');
  //nodo.Text := Memo1.Text;
  Result := Xd.XML.Text;
end;


procedure XML2Grid(pXML : string; var pgrid : TcxGrid);
var
  Xd : IXMLDocument;
  d, vs, nv  : IXMLNode;

  s : string;
  i : Integer;

  Procedure ConfigDS(pViewNode : IXMLNode; pview : TcxCustomGridView);
  var
    nsql : IXMLNode;
    s : string;
    ods : TOracleDataSet;
  begin
    nsql := pViewNode.ChildNodes.FindNode('SQL');
    s := StringReplace(nsql.Text,#10,#13#10,[rfReplaceAll, rfIgnoreCase]);
    with TcxGridDBTableView(pview) do
    begin
      BeginUpdate(lsimImmediate);
      ClearItems;
      ods := TOracleDataSet(DataController.DataSource.DataSet);
      ods.Active := false;
      ods.SQL.Text := s;
      ods.Active := true;
      DataController.CreateAllItems;
      EndUpdate;
    end;
  end;

  procedure configColumns(pViewNode : IXMLNode; pview : TcxCustomGridView);
  var
    i : Integer;
    cs, c : IXMLNode;
    acolumn : TcxGridDBColumn;
  begin
    with TcxGridDBTableView(pview) do
    begin
      cs := pViewNode.ChildNodes.FindNode('Columns');
      for i := 0 to cs.ChildNodes.Count - 1 do
      begin
        c := cs.ChildNodes[i];
        acolumn := GetColumnByFieldName(c.Attributes['Fieldname']);
        if (acolumn <> nil) then
        begin
          acolumn.Index := strtoint(c.Attributes['Index']);
          acolumn.Caption := c.Attributes['Caption']
        end;
      end;
    end;
  end;

begin
  Xd := LoadXMLData(pXML);
  Xd.Active := true;
  d := Xd.DocumentElement;
  vs := d.ChildNodes.FindNode('Views');
  for i := 0 to vs.ChildNodes.Count - 1 do
  begin
    nv := vs.ChildNodes[i];
    s := var2str(nv.Attributes['Caption']);
    pgrid.Levels[i].Caption := s;

    //TableView
    ConfigDS(nv,pgrid.Levels[i].GridView);

    //Columns
    configColumns(nv,pgrid.Levels[i].GridView);
  end;

end;


procedure TfrmMain.Button1Click(Sender: TObject);
begin
  sedXML.Lines.Text := Grid2XML(cxGrid1);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  XML2Grid(sedXML.Lines.Text, cxgrid2);
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  acolumn : TcxGridDBColumn;
  i : Integer;
begin

  ShowMessage(TVCompras.Columns[3].DataBinding.FieldName);
  //ShowMessage(IntToStr(tvcompras.ColumnCount));

//  acolumn := cxGrid2DBTableView1.GetColumnByFieldName('NOMBRE');
//  acolumn.Index := 0;
end;

end.
