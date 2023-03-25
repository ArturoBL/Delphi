unit DSUnit;

interface

uses DB, ZDataset;

Procedure AssignSQL(pSQL : string; dset : tdataset);

implementation

Procedure AssignSQL(pSQL : string; dset : tdataset);
begin
  if dset.ClassName = 'TZQuery'  then
  with TZQuery(dset) do
  begin
    active := false;
    SQL.Text := pSQL;
    active := true;
  end;

end;

end.
