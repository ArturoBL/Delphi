unit GridXML;

interface

uses
  cxGridDBTableView, IXMLData, XMLIntf, sysutils
  , cxCustomData, cxDBData;

Const
  SummaryKindStrings : array[0..5] of string = ('skNone','skSum','skMin','skMax','skCount','skAverage');
  //TcxSummaryKind = (skNone, skSum, skMin, skMax, skCount, skAverage);

type
  TGridXML = class
    private
      fSQL : string;
      fgtv : TcxGridDBTableView;
      function getXML: string;
    public
      property XML : string read getXML;
      constructor create(SQL : string; gtv : TcxGridDBTableView);
  end;

implementation

{ TGridXML }

constructor TGridXML.create(SQL: string; gtv: TcxGridDBTableView);
begin
  fsql := sql;
  fgtv := gtv;
end;

function TGridXML.getXML: string;
var
  d : tIxmldoc;

  Procedure CrearDoc;
  begin
    d := tixmldoc.Create('GridView');
  end;

  Procedure addSQL;
  begin
    d.addNode('SQL').Text := fsql;
  end;

  function sumkind(aColumn : tcxgriddbcolumn) : TcxSummaryKind;
  var
    i : integer;
    k : TcxSummaryKind;
    sit : tcxdatasummaryitem;
    Item: TcxGridDBTableSummaryItem;
  begin
    //TcxSummaryKind = (skNone, skSum, skMin, skMax, skCount, skAverage);
    k := skNone;
    result := k;
    //fgtv.DataController.Summary.FooterSummaryValues
    with fgtv.DataController.Summary.FooterSummaryItems do
    for i := 0 to Count - 1 do
    begin
      Item:=TcxGridDBTableSummaryItem(items[i]);
      if lowercase(item.FieldName) = lowercase(acolumn.DataBinding.FieldName) then
      begin
        k := items[i].Kind;
        break;
      end;
    end;
    result := k;
//
//    result := inttostr(ord(k));
  end;

  procedure addColumns;
  var
    i : integer;
    col : tcxgriddbcolumn;
    n,c : ixmlnode;
    s : string;
    sk : TcxSummaryKind;
  begin
    n := d.addNode('Columns');
    for I := 0 to fgtv.ColumnCount - 1 do
    begin
      col := fgtv.columns[i];
      c := d.addNode(n,'Column');
      c.Attributes['fieldname'] := col.DataBinding.FieldName;
      c.Attributes['caption'] := col.Caption;
      c.Attributes['index'] := inttostr(col.Index);
      if col.Visible
      then c.Attributes['visible'] := 'S'
      else c.Attributes['visible'] := 'N';
      c.Attributes['width'] := inttostr(col.Width);
      sk := sumkind(col);
      if sk <> sknone then
        c.Attributes['sumkind'] := SummaryKindStrings[ord(sk)];
    end;
  end;
begin
  CrearDoc;
  addSQL;
  addColumns;
  result := d.XML;
  d.Free;
end;

end.
