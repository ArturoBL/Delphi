object Form1: TForm1
  Left = 336
  Top = 181
  Width = 1305
  Height = 675
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 96
    Width = 865
    Height = 457
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OracleSession1: TOracleSession
    LogonUsername = 'siomgr'
    LogonPassword = 'p12.asp'
    LogonDatabase = 'SIOPRO11'
    Connected = True
    Left = 64
    Top = 48
  end
  object IdEncoderMIME1: TIdEncoderMIME
    FillChar = '='
    Left = 248
    Top = 24
  end
end
