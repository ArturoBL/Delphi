unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,XMLDoc, xmldom, XMLIntf, msxmldom,
  Dialogs, StdCtrls, Oracle,MidasLib, DB, DBClient, ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DateUtils, cxPC,
  dxDockControl, dxDockPanel, Grids, DBGrids, SynEditHighlighter,
  SynHighlighterXML, SynEdit, ComCtrls;

type
  TForm1 = class(TForm)
    sesion: TOracleSession;
    Panel1: TPanel;
    EditFac: TEdit;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    dsDoc: TDataSource;
    Panel2: TPanel;
    cxGrid1: TcxGrid;
    gtvDoc: TcxGridDBTableView;
    gtvDocversion: TcxGridDBColumn;
    gtvDocserie: TcxGridDBColumn;
    gtvDocfolio: TcxGridDBColumn;
    gtvDocsubtotal: TcxGridDBColumn;
    gtvDocdescuento: TcxGridDBColumn;
    gtvDoctotal: TcxGridDBColumn;
    gtvDocmoneda: TcxGridDBColumn;
    gtvDoctipodecomprobante: TcxGridDBColumn;
    gtvDocFormaPago: TcxGridDBColumn;
    gtvDocMetodoPago: TcxGridDBColumn;
    gtvDocCondicionesDePago: TcxGridDBColumn;
    gtvDocTipoCambio: TcxGridDBColumn;
    gtvDocLugarExpedicion: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter3: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    dsEmisor: TDataSource;
    dsReceptor: TDataSource;
    cdsReceptor: TClientDataSet;
    cdsReceptorRFC: TStringField;
    cdsReceptorNOMBRE: TStringField;
    cdsReceptorUsoCFDI: TStringField;
    gtvReceptor: TcxGridDBTableView;
    cxGrid3Level1: TcxGridLevel;
    cxGrid3: TcxGrid;
    gtvReceptorRFC: TcxGridDBColumn;
    gtvReceptorNOMBRE: TcxGridDBColumn;
    gtvReceptorUsoCFDI: TcxGridDBColumn;
    cdsEmisor: TClientDataSet;
    cdsEmisorRFC: TStringField;
    cdsEmisorNOMBRE: TStringField;
    cdsEmisorRegimenFiscal: TStringField;
    gtvEmisor: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    gtvEmisorRFC: TcxGridDBColumn;
    gtvEmisorNOMBRE: TcxGridDBColumn;
    gtvEmisorRegimenFiscal: TcxGridDBColumn;
    cdsDoc: TClientDataSet;
    cdsDocVersion: TStringField;
    cdsDocSerie: TStringField;
    cdsDocFolio: TStringField;
    cdsDocFecha: TStringField;
    cdsDocSubtotal: TCurrencyField;
    cdsDocDescuento: TCurrencyField;
    cdsDocMoneda: TStringField;
    cdsDocTotal: TCurrencyField;
    cdsDocTipoDeComprobante: TStringField;
    cdsDocFormaPago: TStringField;
    cdsDocMetodoPago: TStringField;
    cdsDocCondicionesDePago: TStringField;
    cdsDocTipoCambio: TStringField;
    cdsDocLugarExpedicion: TStringField;
    gtvDocFecha: TcxGridDBColumn;
    cdsConceptos: TClientDataSet;
    cdsConceptosClaveProdServ: TStringField;
    cdsConceptosClaveUnidad: TStringField;
    cdsConceptosCantidad: TFloatField;
    cdsConceptosUnidad: TStringField;
    cdsConceptosDescripcion: TStringField;
    cdsConceptosValorUnitario: TCurrencyField;
    cdsConceptosImporte: TCurrencyField;
    dsConceptos: TDataSource;
    gtvConceptos: TcxGridDBTableView;
    cxGrid4Level1: TcxGridLevel;
    cxGrid4: TcxGrid;
    Splitter4: TSplitter;
    cdsConceptosBaseT: TCurrencyField;
    cdsConceptosImpuestoT: TStringField;
    cdsConceptosTipoFactor: TStringField;
    gtvConceptosClaveProdServ: TcxGridDBColumn;
    gtvConceptosClaveUnidad: TcxGridDBColumn;
    gtvConceptosCantidad: TcxGridDBColumn;
    gtvConceptosUnidad: TcxGridDBColumn;
    gtvConceptosDescripcion: TcxGridDBColumn;
    gtvConceptosValorUnitario: TcxGridDBColumn;
    gtvConceptosImporte: TcxGridDBColumn;
    gtvConceptosBaseT: TcxGridDBColumn;
    gtvConceptosImpuestoT: TcxGridDBColumn;
    gtvConceptosTipoFactorT: TcxGridDBColumn;
    gtvConceptosImporteT: TcxGridDBColumn;
    gtvConceptosTasaOCuotaT: TcxGridDBColumn;
    cdsConceptosImporteT: TCurrencyField;
    cdsConceptosTasaOCuota: TFloatField;
    Button4: TButton;
    cdsConceptosTotal: TCurrencyField;
    gtvConceptosTotal: TcxGridDBColumn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sedOri: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    sedMod: TSynEdit;
    Button5: TButton;
    TabSheet3: TTabSheet;
    sedCheck: TSynEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cdsConceptosCalcFields(DataSet: TDataSet);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Xd : TXMLDocument;
    procedure procesar;
    procedure ds2XML;
  end;

var
  Form1: TForm1;

implementation

uses
  MiscUtils, XMLProfact2;

{$R *.dfm}




procedure TForm1.Button1Click(Sender: TObject);

begin
  xd.LoadFromFile('c:\temp\factura.xml');
  Xd.Active := true;
  sedOri.Lines.Text := Xd.XML.Text;
  procesar;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  fd : integer;
begin
  fd := SQLint(sesion, 'Select foldoc_Cxc from documentos_cxc where folio_fisico = :folio_fisico',[EditFac.Text]);
  xd.XML.Text := GetXMLPref(sesion,fd,'F',0);
  Xd.Active := true;


  sedOri.Lines.Text := XMLDoc.FormatXMLData(Xd.XML.Text);
  procesar;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Xd := TXMLDocument.Create(Self) ;
end;

procedure TForm1.procesar;
var
  d, de, dd, dc,di, dt : IXMLNode;
  cfecha, s : string;
  i : integer;
  f : Real;

  function str2fec(sf : string) : TDateTime;
  var
    cf, ct : string;
    y,m,d,h,mi,s : Word;
  begin
    cf := token(sf,'T');
    ct := sf;
    y := strtoint(token(cf,'-'));
    m := strtoint(token(cf,'-'));
    d := strtoint(cf);
    h := strtoint(token(ct,':'));
    mi := strtoint(token(ct,':'));
    s := strtoint(ct);
    Result := EncodeDateTime(y,m,d,h,mi,s,0)
  end;
begin
  d := xd.Node.ChildNodes.FindNode('cfdi:Comprobante');
  with cdsDoc do
  begin
    if Active then Active := False;
    Active := True;

    Insert;

    FieldByName('version').Value := d.Attributes['Version'];
    FieldByName('Serie').Value := d.Attributes['Serie'];
    FieldByName('Folio').Value := d.Attributes['Folio'];
    FieldByName('fecha').Value := d.Attributes['Fecha'];
    FieldByName('SubTotal').Value := d.Attributes['SubTotal'];
    FieldByName('Moneda').Value := d.Attributes['Moneda'];
    FieldByName('Total').Value := d.Attributes['Total'];
    FieldByName('TipoDeComprobante').Value := d.Attributes['TipoDeComprobante'];
    FieldByName('FormaPago').Value := d.Attributes['FormaPago'];
    FieldByName('MetodoPago').Value := d.Attributes['MetodoPago'];
    FieldByName('CondicionesDePago').Value := d.Attributes['CondicionesDePago'];
    FieldByName('TipoCambio').Value := d.Attributes['TipoCambio'];
    FieldByName('LugarExpedicion').Value := d.Attributes['LugarExpedicion'];
    Post;
  end;

  with cdsEmisor do
  begin
    if Active then Active := False;
    Active := true;
    dd := d.ChildNodes.FindNode('cfdi:Emisor');
    if dd <> nil then
    begin
      insert;
      FieldByName('Rfc').Value := dd.Attributes['Rfc'];
      FieldByName('Nombre').Value := dd.Attributes['Nombre'];
      FieldByName('RegimenFiscal').Value := dd.Attributes['RegimenFiscal'];
      Post;
    end;
  end;

  with cdsReceptor do
  begin
    if Active then Active := False;
    Active := true;
    dd := d.ChildNodes.FindNode('cfdi:Receptor');

    if dd <> nil then
    begin
      insert;
      FieldByName('Rfc').Value := dd.Attributes['Rfc'];
      FieldByName('Nombre').Value := dd.Attributes['Nombre'];
      Fields[2].Value := dd.Attributes['UsoCFDI'];
      Post;
    end;
  end;

  with cdsConceptos do
  begin
    dd := d.ChildNodes.FindNode('cfdi:Conceptos');
    for i := 0 to dd.ChildNodes.Count - 1 do
    begin
      dc := dd.ChildNodes[i];
      Insert;
      FieldByName('ClaveProdServ').Value := dc.Attributes['ClaveProdServ'];
      FieldByName('ClaveUnidad').Value := dc.Attributes['ClaveUnidad'];
      FieldByName('Cantidad').Value := dc.Attributes['Cantidad'];
      FieldByName('Unidad').Value := dc.Attributes['Unidad'];
      FieldByName('Descripcion').Value := dc.Attributes['Descripcion'];
      FieldByName('ValorUnitario').Value := dc.Attributes['ValorUnitario'];
      FieldByName('Importe').Value := dc.Attributes['Importe'];

      di := dc.ChildNodes.FindNode('cfdi:Impuestos');
      dt := di.ChildNodes.FindNode('cfdi:Traslados').ChildNodes.FindNode('cfdi:Traslado');
      FieldByName('BaseT').Value := dt.Attributes['Base'];
      FieldByName('ImpuestoT').Value := dt.Attributes['Impuesto'];
      FieldByName('TipoFactorT').Value := dt.Attributes['TipoFactor'];
      f := strtofloat(dt.Attributes['TasaOCuota']);
      FieldByName('TasaOCuotaT').Value := f;
      FieldByName('ImporteT').Value := dt.Attributes['Importe'];

      Post;
    end;
    close;
    open;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ds2xml;
  Xd.SaveToFile('C:\temp\factura2.xml');
end;



procedure TForm1.ds2XML;
var
  d, dd, dc, di, dt : IXMLNode;
  i : integer;
begin
  d := xd.Node.ChildNodes.FindNode('cfdi:Comprobante');

  with cdsDoc do
  begin
    d.Attributes['Version'] := FieldByName('version').Value;
    d.Attributes['Serie'] := FieldByName('Serie').Value ;

    d.Attributes['Folio'] := FieldByName('Folio').Value ;
    d.Attributes['Fecha'] := FieldByName('fecha').Value;

    d.Attributes['SubTotal'] := FieldByName('SubTotal').Value;

    d.Attributes['Moneda'] := FieldByName('Moneda').Value;
    d.Attributes['Total'] := FieldByName('Total').Value;
    d.Attributes['TipoDeComprobante'] := FieldByName('TipoDeComprobante').Value;
    d.Attributes['FormaPago'] := FieldByName('FormaPago').Value;
    d.Attributes['MetodoPago'] := FieldByName('MetodoPago').Value;
    d.Attributes['CondicionesDePago'] := FieldByName('CondicionesDePago').Value;
    d.Attributes['TipoCambio'] := FieldByName('TipoCambio').Value;
    d.Attributes['LugarExpedicion'] := FieldByName('LugarExpedicion').Value;
  end;

  dd := d.ChildNodes.FindNode('cfdi:Emisor');
  if dd <> nil then
  with cdsEmisor do
  begin
    dd.Attributes['Rfc'] := FieldByName('Rfc').Value;
    dd.Attributes['Nombre'] := FieldByName('Nombre').Value;
    dd.Attributes['RegimenFiscal'] := FieldByName('RegimenFiscal').Value;
  end;

  dd := d.ChildNodes.FindNode('cfdi:Receptor');
  if dd <> nil then
  with cdsReceptor do
  begin
    dd.Attributes['Rfc'] := FieldByName('Rfc').Value;
    dd.Attributes['Nombre'] := FieldByName('Nombre').Value;
    dd.Attributes['UsoCFDI'] := FieldByName('UsoCFDI').Value;
  end;

  dd := d.ChildNodes.FindNode('cfdi:Conceptos');
  if dd <> nil then
  with cdsConceptos do
  begin
    cdsConceptos.First;
    for i := 0 to dd.ChildNodes.Count - 1 do
    begin
      dc := dd.ChildNodes[i];

      dc.Attributes['ClaveProdServ'] := FieldByName('ClaveProdServ').Value;
      dc.Attributes['ClaveUnidad'] := FieldByName('ClaveUnidad').Value;
      dc.Attributes['Cantidad'] := FieldByName('Cantidad').Value;
      dc.Attributes['Unidad'] := FieldByName('Unidad').Value;
      dc.Attributes['Descripcion'] := FieldByName('Descripcion').Value;
      dc.Attributes['ValorUnitario'] := Format('%.2f',[FieldByName('ValorUnitario').AsCurrency]);
      dc.Attributes['Importe'] := Format('%.2f',[FieldByName('Importe').AsCurrency]);

      di := dc.ChildNodes.FindNode('cfdi:Impuestos');
      dt := di.ChildNodes.FindNode('cfdi:Traslados').ChildNodes.FindNode('cfdi:Traslado');
      dt.Attributes['Base'] := Format('%.2f',[FieldByName('BaseT').AsCurrency]);
      dt.Attributes['Impuesto'] := FieldByName('ImpuestoT').Value;
      dt.Attributes['TipoFactor'] := FieldByName('TipoFactorT').Value;


      dt.Attributes['TasaOCuota'] := Format('%.6f',[FieldByName('TasaOCuotaT').AsFloat]);

      dt.Attributes['Importe'] := Format('%.2f',[FieldByName('ImporteT').AsCurrency]);
      cdsConceptos.Next;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  col : TcxGridDBColumn;
  Si : TcxGridDBTableSummaryItem;
  f : TcxDBDataField;
  s : single;

begin
  sedCheck.Clear;

  //gtvConceptos.CopyToClipboard(true);
  //col := gtvConceptos.GetColumnByFieldName('Total');
  //gtvConceptos.DataController.Summary.FooterSummaryItems.Items[0].
  //si := TcxGridDBTableSummaryItem(gtvConceptos.DataController.Summary.FooterSummaryItems[0]);

  s:= var2single(gtvConceptos.DataController.Summary.FooterSummaryValues[0]);

  if cdsDoc.FieldByName('Total').AsCurrency <> s then
  begin
    sedCheck.Lines.Add('El total y la suma de conceptos no concuerdan.')
  end;
  showmessage(var2str(gtvConceptos.DataController.Summary.FooterSummaryValues[0]));
//  View_Client.DataController.Summary.FooterSummaryValues [0],//get the value
//View_Client.DataController.Summary.FooterSummaryTexts//display text obtained
//View_Client.DataController.Summary.FooterSummarys//get objects Total
//  ShowMessage(Si.FieldName);
//  f := Si.DataField;

//  s := gtvConceptos.DataController.Summary.FooterSummaryValues[0];
  //ShowMessage(FloatToStr(var2single(s)));


//  VarToStr(dxdbgReportDBTableView1.DataController.Summary.FooterSummaryValues[
//    dxdbgReportDBTableView1.GetColumnByFieldName('ITEMVALUE').Index]);
end;

procedure TForm1.cdsConceptosCalcFields(DataSet: TDataSet);

begin
  cdsConceptos.FieldByName('Total').Value := cdsConceptos.fieldbyname('Importe').AsCurrency + cdsConceptos.fieldbyname('ImporteT').AsCurrency;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ds2xml;
  sedMod.Text := XMLDoc.FormatXMLData(Xd.XML.Text);
end;



end.
