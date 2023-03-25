object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Grid Properties Save'
  ClientHeight = 416
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cpc: TcxPageControl
    Left = 0
    Top = 0
    Width = 795
    Height = 416
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tsGenGrid
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 412
    ClientRectLeft = 4
    ClientRectRight = 791
    ClientRectTop = 24
    object tsSQL: TcxTabSheet
      Caption = 'SQL'
      ImageIndex = 0
      object seSQL: TSynEdit
        Left = 0
        Top = 0
        Width = 787
        Height = 388
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynSQLSyn
        Lines.Strings = (
          'select *'
          '  from employees')
        FontSmoothing = fsmNone
      end
    end
    object tsGrid: TcxTabSheet
      Caption = 'Grid'
      ImageIndex = 1
      object PanelMain: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        TabOrder = 0
        object btnOpen: TcxButton
          Left = 16
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Open'
          TabOrder = 0
          OnClick = btnOpenClick
        end
        object Button1: TButton
          Left = 136
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 1
          OnClick = Button1Click
        end
      end
      object grd: TcxGrid
        Left = 0
        Top = 41
        Width = 787
        Height = 347
        Align = alClient
        TabOrder = 1
        object gtv: TcxGridDBTableView
          OnMouseDown = gtvMouseDown
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellClick = gtvCellClick
          DataController.DataSource = ds
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skMax
              FieldName = 'id'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
        end
        object glv: TcxGridLevel
          GridView = gtv
        end
      end
    end
    object tsXML: TcxTabSheet
      Caption = 'XML'
      ImageIndex = 2
      object Panel: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        TabOrder = 0
        object cxButton1: TcxButton
          Left = 16
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Generate'
          TabOrder = 0
          OnClick = cxButton1Click
        end
      end
      object seXML: TSynEdit
        Left = 0
        Top = 41
        Width = 787
        Height = 347
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 1
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynSQLSyn
        FontSmoothing = fsmNone
      end
    end
    object tsGenGrid: TcxTabSheet
      Caption = 'Generated Grid'
      ImageIndex = 3
      object grdGen: TcxGrid
        Left = 0
        Top = 41
        Width = 787
        Height = 347
        Align = alClient
        TabOrder = 0
        object gtvGen: TcxGridDBTableView
          OnMouseDown = gtvGenMouseDown
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = ds2
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object glvGen: TcxGridLevel
          GridView = gtvGen
        end
      end
      object pnlGen: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        TabOrder = 1
        object btnLoad: TcxButton
          Left = 24
          Top = 10
          Width = 97
          Height = 25
          Caption = 'Load From XML'
          TabOrder = 0
          OnClick = btnLoadClick
        end
      end
    end
  end
  object SynSQLSyn: TSynSQLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 108
    Top = 136
  end
  object SynXMLSyn: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 100
    Top = 192
  end
  object ZConn: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16')
    HostName = ''
    Port = 0
    Database = 
      'D:\Progra\Proyectos\Github\Delphi\GridSave\Win32\Debug\employees' +
      '.db'
    User = ''
    Password = ''
    Protocol = 'sqlite-3'
    LibraryLocation = 
      'C:\Users\artyb\Documents\SQLite\sqlite-dll-win32-x86-3410100\sql' +
      'ite3.dll'
    Left = 268
    Top = 152
  end
  object zq: TZQuery
    Connection = ZConn
    SQL.Strings = (
      'select *'
      '  from employees')
    Params = <>
    Left = 268
    Top = 208
  end
  object ds: TDataSource
    DataSet = zq
    Left = 264
    Top = 264
  end
  object zq2: TZQuery
    Connection = ZConn
    Params = <>
    Left = 356
    Top = 216
  end
  object ds2: TDataSource
    DataSet = zq2
    Left = 364
    Top = 272
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = grd
    PopupMenus = <>
    Left = 476
    Top = 328
  end
  object pum: TPopupMenu
    Left = 428
    Top = 184
    object Ocultar1: TMenuItem
      Caption = 'Ocultar'
    end
  end
end
