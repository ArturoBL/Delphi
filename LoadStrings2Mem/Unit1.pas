unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, dxmdaset, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    mem: TdxMemData;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure CreateField(AMemData: TDataSet; AFieldName: string; AFieldType: TFieldType; pSize : Integer);
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
  sl : TStringList;
begin
  mem.DelimiterChar := ',';
  mem.Active := false;
  mem.FieldDefs.Clear;
  CreateField(mem, 'no_empleado',ftInteger,0);
  CreateField(mem, 'nombre',ftString,40);
  mem.Active := True;

  sl := TStringList.Create;
  sl.Add('no_empleado,nombre');
  sl.Add('1,Pepe Pérez');
  sl.Add('2,Toño');
  mem.LoadFromStrings(sl);
end;

end.
