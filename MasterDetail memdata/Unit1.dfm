object Form1: TForm1
  Left = 309
  Top = 190
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
    Left = 16
    Top = 24
    Width = 641
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 64
    Top = 272
    Width = 801
    Height = 193
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dmdDeptos: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = dmdDeptosAfterScroll
    Left = 56
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = dmdDeptos
    Left = 96
    Top = 96
  end
  object dmdEmp: TdxMemData
    Indexes = <>
    SortOptions = []
    OnFilterRecord = dmdEmpFilterRecord
    Left = 208
    Top = 304
  end
  object DataSource2: TDataSource
    DataSet = dmdEmp
    Left = 264
    Top = 304
  end
end
