object Form1: TForm1
  Left = 355
  Top = 199
  Width = 487
  Height = 245
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
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 92
    Height = 13
    Caption = 'Total elements (m) :'
  end
  object Label2: TLabel
    Left = 32
    Top = 64
    Width = 55
    Height = 13
    Caption = 'Set size (n):'
  end
  object Memo1: TMemo
    Left = 280
    Top = 8
    Width = 169
    Height = 193
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object sedM: TSpinEdit
    Left = 176
    Top = 24
    Width = 65
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 5
  end
  object sedN: TSpinEdit
    Left = 176
    Top = 64
    Width = 65
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 2
  end
  object Button1: TButton
    Left = 32
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Calc'
    TabOrder = 3
    OnClick = Button1Click
  end
end
