object Form1: TForm1
  Left = 320
  Top = 212
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
  object cxGrid1: TcxGrid
    Left = 72
    Top = 296
    Width = 793
    Height = 200
    TabOrder = 0
    object gtv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = gtv
    end
  end
  object DBGrid1: TDBGrid
    Left = 64
    Top = 128
    Width = 793
    Height = 120
    DataSource = datasource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 48
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object memd: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 56
    Top = 72
  end
  object datasource: TDataSource
    DataSet = memd
    Left = 96
    Top = 72
  end
end
