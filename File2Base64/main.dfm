object Form1: TForm1
  Left = 293
  Top = 170
  Width = 776
  Height = 453
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
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Encode'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Decode'
    TabOrder = 1
    OnClick = Button2Click
  end
  object OpenDialog: TOpenDialog
    Left = 40
    Top = 80
  end
  object SaveDialog: TSaveDialog
    Left = 96
    Top = 80
  end
  object encoder: TIdEncoderMIME
    FillChar = '='
    Left = 176
    Top = 88
  end
  object decoder: TIdDecoderMIME
    FillChar = '='
    Left = 176
    Top = 144
  end
end
