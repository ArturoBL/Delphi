unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, StdCtrls, cxTextEdit,
  cxMemo, ExtCtrls, Sockets;

type
  TfrmMain = class(TForm)
    TcpServer: TTcpServer;
    Panel1: TPanel;
    mmLog: TcxMemo;
    btnStart: TButton;
    BtnStop: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure TcpServerAccept(Sender: TObject;
      ClientSocket: TCustomIpClient);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  tcpserver.Open;
  mmLog.Lines.Add(DateTimeToStr(now) + ': ' + 'Server started.');
end;

procedure TfrmMain.BtnStopClick(Sender: TObject);
begin
  TcpServer.Close;
  mmLog.Lines.Add(DateTimeToStr(now) + ': ' + 'Server stopped.');
end;

procedure TfrmMain.TcpServerAccept(Sender: TObject;
  ClientSocket: TCustomIpClient);
var
  line, path : string;
  HTTPos : integer;
begin
  line := ' ';

  mmLog.Lines.Add(DateTimeToStr(now) + ': ');
//  while (ClientSocket.Connected) and (line <> '') do
//  begin
//     line := ClientSocket.Receiveln();
//     mmLog.Lines.Add(line);
//     if Copy(line,1,3) = 'GET' then
//     begin
//       HTTPos := Pos('HTTP',line);
//       path := copy(line,5,HTTPos-6);
//
//       mmLog.Lines.Add('Path: ' + path);
//       path := stringreplace(path, '/', '\',
//                          [rfReplaceAll, rfIgnoreCase]);
//       if path = '\' then
//         path := '\index.html';
//
//       if fileexists('htdocs'+path) then
//         with tstringlist.Create do
//         begin
//           LoadFromFile('htdocs\'+path);
//           ClientSocket.Sendln('HTTP/1.0 200 OK');
//           ClientSocket.Sendln('');
//           ClientSocket.Sendln(Text);
//           ClientSocket.Close;
//           Free;
//           exit;
//         end
//       else
//       begin
//         ClientSocket.Sendln('HTTP/1.0 200 OK');
//         ClientSocket.Sendln('');
//         ClientSocket.Close;
//       end;
//     end;
//  end;
  ClientSocket.Sendln('HTTP/1.0 200 OK');
  ClientSocket.Sendln('');
  ClientSocket.Close;
end;

end.
