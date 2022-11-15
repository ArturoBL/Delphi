unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    sedM: TSpinEdit;
    Label2: TLabel;
    sedN: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    a : array of word;
    m,n : integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
  procedure initArray;
  var
    i : integer;
  begin
    SetLength(a,n);
    for i := 0 to n - 1 do
      a[i] := 1;
  end;

  procedure printElement;
  var
    i : Integer;
    s : string;
  begin
    s := '';
    for i := 0 to n - 1 do
    begin
      if s <> '' then
        s := s + ', ';
      s := s + IntToStr(a[i]);
    end;
    Memo1.Lines.Add(s);
  end;

  function finalCombination : boolean;
  var i : integer;
  begin
    result := true;
    for i :=0 to n - 1 do
    if a[i] <> m then
    begin
      Result := false;
      Break;
    end;
  end;

  procedure incCombination;
  var i,x : integer;
  begin
    //search for index to inc
    x:= -1;
    for i := n-1 downto 0 do
      if a[i] < m then
      begin
        x := i;
        Break;
      end;

    //Set values for next array indexes
    if x >= 0 then Inc(a[x]);
    for i := x + 1 to n - 1 do
    begin
      a[i] := a[x];
    end;
  end;

begin
  memo1.Clear;
  m := sedm.Value;
  n := sedn.Value;
  Memo1.Lines.BeginUpdate;
  initArray;
  printElement;
  while not finalCombination do
  begin
    incCombination;
    printElement;
  end;
  Memo1.Lines.EndUpdate;
  ShowMessage('Combinations: ' + IntToStr(Memo1.Lines.Count));

  // Number of combinations with repetition:  CR(m,n) = (m+n-1)!/(n!(m-1)!)
end;

end.
