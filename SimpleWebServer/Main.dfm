object frmMain: TfrmMain
  Left = 421
  Top = 208
  Width = 555
  Height = 396
  Caption = 'Simple Web Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 292
    Width = 539
    Height = 66
    Align = alBottom
    TabOrder = 0
    object btnStart: TButton
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object BtnStop: TButton
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = BtnStopClick
    end
  end
  object mmLog: TcxMemo
    Left = 0
    Top = 0
    Align = alClient
    Properties.ScrollBars = ssVertical
    TabOrder = 1
    Height = 292
    Width = 539
  end
  object TcpServer: TTcpServer
    LocalPort = '8080'
    OnAccept = TcpServerAccept
    Left = 304
    Top = 128
  end
end
