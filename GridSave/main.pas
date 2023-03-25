unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC, Vcl.Menus,
  SynHighlighterXML, SynEditHighlighter, SynHighlighterSQL, SynEdit,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, ZAbstractConnection, ZConnection,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, XMLIntf, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TFormMain = class(TForm)
    cpc: TcxPageControl;
    tsSQL: TcxTabSheet;
    tsGrid: TcxTabSheet;
    tsXML: TcxTabSheet;
    Panel: TPanel;
    cxButton1: TcxButton;
    seSQL: TSynEdit;
    SynSQLSyn: TSynSQLSyn;
    seXML: TSynEdit;
    SynXMLSyn: TSynXMLSyn;
    ZConn: TZConnection;
    PanelMain: TPanel;
    btnOpen: TcxButton;
    zq: TZQuery;
    ds: TDataSource;
    gtv: TcxGridDBTableView;
    glv: TcxGridLevel;
    grd: TcxGrid;
    zq2: TZQuery;
    ds2: TDataSource;
    tsGenGrid: TcxTabSheet;
    gtvGen: TcxGridDBTableView;
    glvGen: TcxGridLevel;
    grdGen: TcxGrid;
    pnlGen: TPanel;
    btnLoad: TcxButton;
    Button1: TButton;
    cxGridPopupMenu1: TcxGridPopupMenu;
    pum: TPopupMenu;
    Ocultar1: TMenuItem;
    procedure btnOpenClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure gtvCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure gtvMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnLoadClick(Sender: TObject);
    procedure gtvGenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses IXMLData, GridXML;

procedure TFormMain.btnLoadClick(Sender: TObject);
var
  gx : TGridXML;
begin
  gx := TGridXML.createFromXML(sexml.Text,gtvgen);
end;

procedure TFormMain.btnOpenClick(Sender: TObject);
begin
  zconn.LibraryLocation := extractfilepath(application.ExeName) + 'sqlite3.dll';
  zconn.Protocol := 'sqlite-3';
  zconn.Database := extractfilepath(application.ExeName) + 'employees.db';
  zconn.Connect;
  zq.SQL.Text := sesql.Lines.Text;
  zq.Active := true;
  gtv.DataController.DataSource := ds;
  gtv.DataController.CreateAllItems();
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  showmessage(gtv.DataController.DataSource.DataSet.ClassName);
end;

procedure TFormMain.cxButton1Click(Sender: TObject);
var
  gx : TGridXML;

begin
  gx := tgridxml.create(sesql.Text, gtv);
  sexml.Text := gx.XML;
//  gtv.DataController.Summary.FooterSummaryItems
end;

procedure TFormMain.gtvCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  f : TcxFilterCriteriaItemList;
begin
  //showmessage(TcxGridDBColumn(ACellViewInfo.Item).DataBinding.FieldName);
end;

procedure TFormMain.gtvGenMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  showmessage(TcxGridLevel(TcxGridDBTableView(sender).Level).Name);

//  showmessage(TcxGridLevel(TcxGridDBTableView(sender).Level).Control.ClassName);
//  pum.Popup(x,y);
end;

procedure TFormMain.gtvMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AColumnCaption: String;

begin
//  AHitTest := TcxGridSite(Sender).ViewInfo.GetHitTest(X, Y);
//  if AHitTest.HitTestCode = htColumnHeader then
//  AColumnCaption := TcxGridColumnHeaderHitTest(AHitTest).Column.Caption
//else
//  if AHitTest.HitTestCode = htCell then
//    AColumnCaption := TcxGridRecordCellHitTest(AHitTest).Item.Caption;
//  showmessage(AColumnCaption);

end;

end.
