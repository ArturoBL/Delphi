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
    gtvid: TcxGridDBColumn;
    gtvnombre: TcxGridDBColumn;
    gtvapellido: TcxGridDBColumn;
    gtvsueldo: TcxGridDBColumn;
    gtvactivo: TcxGridDBColumn;
    procedure btnOpenClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TFormMain.btnOpenClick(Sender: TObject);
begin
  zconn.LibraryLocation := 'C:\Users\Arturo\OneDrive\Documentos\sqlite-tools-win32-x86-3410100\x86\sqlite3.dll';
  zconn.Protocol := 'sqlite-3';
  zconn.Database := extractfilepath(application.ExeName) + 'empleados.db';
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

end.