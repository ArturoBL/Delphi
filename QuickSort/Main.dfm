object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'QuickSort'
  ClientHeight = 298
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 80
    Width = 129
    Height = 169
    Lines.Strings = (
      '4'
      '2'
      '5'
      '1'
      '3')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 216
    Top = 80
    Width = 129
    Height = 169
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button1: TButton
    Left = 144
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Ordenar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
