object Form1: TForm1
  Left = 380
  Top = 213
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
    Left = 64
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Generar XML'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 200
    Top = 16
    Width = 545
    Height = 177
    Lines.Strings = (
      'Linea 1'
      '      akjhkwhk'
      '  alsdkjlaskal'
      '        wewelkwe')
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 200
    Top = 240
    Width = 545
    Height = 345
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
  object Memo3: TMemo
    Left = 816
    Top = 88
    Width = 465
    Height = 185
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object Button2: TButton
    Left = 824
    Top = 40
    Width = 265
    Height = 25
    Caption = 'Extraer Texto desde XML'
    TabOrder = 4
    OnClick = Button2Click
  end
end
