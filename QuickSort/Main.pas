{
Este programa ha sido hecho como prueba de asistencia de ChatGPT en la
elaboración de un proyecto.
Las funciones Swap, Partition y QuickSort fueron entéramente escritas por ChatGPT.
La aplicación de la función Quicksort fue adaptada de la aplicación de consola
original escrita por ChatGPT para facilitar su prueba a nivel de usuario.
}

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
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

// función para intercambiar dos elementos de un array
procedure Swap(var A, B: Integer);
var
  Temp: Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
end;

// función para particionar un array y devolver el índice del pivote
function Partition(var Arr: array of Integer; L, R: Integer): Integer;
var
  Pivot, I, J: Integer;
begin
  Pivot := Arr[R];
  I := L - 1;

  for J := L to R - 1 do
  begin
    if Arr[J] <= Pivot then
    begin
      Inc(I);
      Swap(Arr[I], Arr[J]);
    end;
  end;

  Swap(Arr[I+1], Arr[R]);
  Result := I + 1;
end;

// función para ordenar un array usando el algoritmo quicksort
procedure QuickSort(var Arr: array of Integer; L, R: Integer);
var
  Pivot: Integer;
begin
  if L < R then
  begin
    Pivot := Partition(Arr, L, R);
    QuickSort(Arr, L, Pivot - 1);
    QuickSort(Arr, Pivot + 1, R);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i,n : integer;
  s : string;
  a : array of integer;
begin
  for i  := 0 to memo1.Lines.Count -1  do
    if trim(memo1.Lines[i]) <> '' then
    begin
      n := strtoint(memo1.Lines[i]);
      setlength(a,high(a)+2);
      a[high(a)] := n;
    end;

  //Ordenamos
  QuickSort(a,0, high(a));

  // imprimir el array ordenado
  for I := 0 to high(a) do
    memo2.lines.add(inttostr(a[i]));
end;

end.
