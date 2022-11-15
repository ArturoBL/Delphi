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
    i,x : integer;
  begin
    SetLength(a,n);
    x := 1;
    for i := 0 to n - 1 do
    begin
      a[i] := x;
      Inc(x);
    end;
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
  var i,x : integer;
  begin
    result := true;
    x := m;
    for i :=n-1 downto 0 do
    begin
      if a[i] <> x then
      begin
        result := false;
        break;
      end;
      dec(x);
    end;
  end;

  procedure incCombination;
  var i,x,y : integer;
  begin
    //search for index to inc
    x:= -1;
    y := m;
    for i := n-1 downto 0 do
    begin
      if a[i] <> y then
      begin
        x := i;
        break;
      end;
      dec(y);
    end;

    //Set values for next array indexes
    if x >= 0 then Inc(a[x]);
    y := a[x] + 1;
    for i := x + 1 to n - 1 do
    begin
      a[i] := y;
      Inc(y);
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

  // Number of combinations with repetition:  C(m,n) = m!/(n!(m-n)!)
end;

end.
