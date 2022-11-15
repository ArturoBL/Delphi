unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label2: TLabel;
    sedN: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    a : array of word;
    n : integer;
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



  function isdescorder(x : Integer) : Boolean;
  var i,v : Integer;
  begin
    Result := True;
    //if x = n then Exit;

    v := a[x];
    for i := x + 1 to n - 1 do
    begin
      if a[i] > a[i-1] then
      begin
        result := false;
        Break;
      end;
    end;
  end;

  function finalCombination : boolean;
  var i,x : integer;
  begin
    result := isdescorder(0);
  end;

  procedure swap(i,j:integer);
  var v : integer;
  begin
    v := a[i];
    a[i] := a[j];
    a[j] := v;
  end;

  procedure ascorder(x : Integer);
  var i, j, v : integer;
  begin
    for i := x to n-2 do
      for j := i + 1 to n - 1 do
      if a[j] < a[i] then
        swap(i,j);
  end;

  procedure incCombination;
  var i,x,y : integer;
  begin
    //search for index to inc
    x:= -1;
    for i := n-1 downto 0 do
    begin
      if not isdescorder(i) then
      begin
        x := i;
        Break;
      end;
    end;

    //Search index of minimum number higher than a[x] from a[x+1] to a[n-1]
    y := x+1;
    for i := x+2 to n-1 do
    begin
      if (a[i] > a[x]) and (a[i] < a[y]) then
        y := i;
    end;

    //Swap values
    swap(x,y);
    
    //order from a[x+1] to a[n-1] in asc order
    ascorder(x+1);
  end;

begin
  memo1.Clear;

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
  ShowMessage('Permutations: ' + IntToStr(Memo1.Lines.Count));

  // Number of combinations with repetition:  P(n) = n!
end;

end.
