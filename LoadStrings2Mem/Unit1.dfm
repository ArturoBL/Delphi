object Form1: TForm1
  Left = 273
  Top = 152
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 48
    Top = 120
    Width = 337
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 88
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object mem: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 88
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = mem
    Left = 144
    Top = 64
  end
end
