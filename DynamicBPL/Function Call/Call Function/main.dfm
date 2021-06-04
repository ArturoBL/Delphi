object Form1: TForm1
  Left = 224
  Top = 125
  Width = 289
  Height = 270
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
    Left = 72
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Ejecutar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 24
    Width = 185
    Height = 105
    Caption = 'Opci'#243'n'
    ItemIndex = 0
    Items.Strings = (
      'Funcion 1'
      'Funcion 2')
    TabOrder = 1
  end
end
