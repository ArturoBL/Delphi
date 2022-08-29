unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Grids, DBGrids;

type
  TForm1 = class(TForm)
    cds: TClientDataSet;
    DataSource1: TDataSource;
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
begin
  CreateField(cds,'col1',ftInteger,0);
  CreateField(cds,'col2',ftInteger,0);
  cds.CreateDataSet;
  cds.Open;
end;

end.
