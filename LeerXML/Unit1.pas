unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XMLDoc, xmldom, XMLIntf, msxmldom;

type
  TForm1 = class(TForm)
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

procedure TForm1.Button1Click(Sender: TObject);
var
  xd : TXMLDocument;
  ivac : Single;
  d : IXMLNode;
begin
  Xd := TXMLDocument.Create(self);
  xd.FileName := 'c:\temp\factura.xml';
  xd.Active := true;
  d := xd.DocumentElement;

  ivac := (StrToFloat(d.Attributes['Total']) - StrToFloat(d.Attributes['SubTotal']));
  with d.ChildNodes.FindNode('cfdi:Impuestos') do
  begin
    showmessage(Attributes['TotalImpuestosTrasladados']);
    ShowMessage(ChildNodes.FindNode('cfdi:Traslados').ChildNodes.FindNode('cfdi:Traslado').Attributes['Importe']);
    //Attributes['TotalImpuestosTrasladados'] := Format('%.2f',[ivac]);
    //ChildNodes.FindNode('cfdi:Traslados').ChildNodes.FindNode('cfdi:Traslado').Attributes['Importe'] := Format('%.2f',[ivac]);
  end;


  with d.ChildNodes.FindNode('cfdi:Conceptos').ChildNodes.FindNode('cfdi:Concepto').ChildNodes.FindNode('cfdi:Impuestos').ChildNodes.FindNode('cfdi:Traslados').ChildNodes.FindNode('cfdi:Traslado') do
  begin
    ShowMessage(Attributes['Importe']);
    ShowMessage(Attributes['Base']);
//    Attributes['Importe'] := Format('%.2f',[ivac]);
//    Attributes['Base'] := format('%.2f',[ivac / strtofloat(Attributes['TasaOCuota'])]);
//    ShowMessage(Attributes['Base']);
  end;
//  showmessage(floattostr(ivac));
end;

end.
