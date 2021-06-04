unit Funcion;

interface

procedure DoSomething();

implementation

uses dialogs;

procedure DoSomething();
begin
  Showmessage('Did');
end;

exports
  DoSomething;

end.
