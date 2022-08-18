unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XMLDoc, xmldom, XMLIntf, msxmldom;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Xd : TXMLDocument;
  d, nodo : IXMLNode;
begin
  Xd := TXMLDocument.Create(nil);
  xd.Active := true;
  d := xd.Node.AddChild('vista','');
  nodo := d.AddChild('sql');
  nodo.Text := Memo1.Text;
  Memo2.Text := xd.XML.Text;
  xd.XML.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Xd : TXMLDocument;
  d, nodo : IXMLNode;
  c : string;
begin
  Xd := TXMLDocument.Create(Self) ;
  xd.XML.Text := Memo2.Text;
  Xd.Active := true;
  d := xd.Node.ChildNodes.FindNode('vista');
  nodo := d.ChildNodes.FindNode('sql');

  //Si sólo extraemos el texto desde nodo.text se pierden los saltos de línea
  c := nodo.xml;
  delete(c,1,length('<sql>'));
  delete(c,Length(c) - length('</sql>')+1,length('</sql>'));
  Memo3.Text := c;
end;

end.
