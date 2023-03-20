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
    Properties.ActivePage = tsGrid
    Properties.CustomButtons.Buttons = <>
    ExplicitLeft = 8
    ExplicitTop = 16
    ExplicitWidth = 745
    ExplicitHeight = 377
    ClientRectBottom = 412
    ClientRectLeft = 4
    ClientRectRight = 791
    ClientRectTop = 24
    object tsSQL: TcxTabSheet
      Caption = 'SQL'
      ImageIndex = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
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
        CodeFolding.GutterShapeSize = 11
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        CodeFolding.ShowCollapsedLine = False
        CodeFolding.ShowHintMark = True
        UseCodeFolding = False
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
        ExplicitLeft = 48
        ExplicitTop = 32
        ExplicitWidth = 200
        ExplicitHeight = 150
      end
    end
    object tsGrid: TcxTabSheet
      Caption = 'Grid'
      ImageIndex = 1
      ExplicitLeft = 5
      ExplicitTop = 25
      object PanelMain: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 104
        ExplicitTop = 48
        ExplicitWidth = 185
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
        ExplicitLeft = 152
        ExplicitTop = 64
        ExplicitWidth = 250
        ExplicitHeight = 200
        object gtv: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = ds
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skMax
              FieldName = 'id'
              Column = gtvid
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          object gtvid: TcxGridDBColumn
            DataBinding.FieldName = 'id'
          end
          object gtvnombre: TcxGridDBColumn
            DataBinding.FieldName = 'nombre'
          end
          object gtvapellido: TcxGridDBColumn
            DataBinding.FieldName = 'apellido'
          end
          object gtvsueldo: TcxGridDBColumn
            DataBinding.FieldName = 'sueldo'
          end
          object gtvactivo: TcxGridDBColumn
            DataBinding.FieldName = 'activo'
          end
        end
        object glv: TcxGridLevel
          GridView = gtv
        end
      end
    end
    object tsXML: TcxTabSheet
      Caption = 'XML'
      ImageIndex = 2
      ExplicitLeft = 5
      ExplicitTop = 25
      object Panel: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 144
        ExplicitTop = 72
        ExplicitWidth = 185
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
        CodeFolding.GutterShapeSize = 11
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        CodeFolding.ShowCollapsedLine = False
        CodeFolding.ShowHintMark = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynSQLSyn
        FontSmoothing = fsmNone
        ExplicitTop = 39
      end
    end
    object tsGenGrid: TcxTabSheet
      Caption = 'Generated Grid'
      ImageIndex = 3
      ExplicitLeft = 3
      ExplicitTop = 25
      object grdGen: TcxGrid
        Left = 0
        Top = 41
        Width = 787
        Height = 347
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 144
        ExplicitTop = 64
        ExplicitWidth = 250
        ExplicitHeight = 200
        object gtvGen: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
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
        ExplicitLeft = 216
        ExplicitTop = 56
        ExplicitWidth = 185
        object btnLoad: TcxButton
          Left = 24
          Top = 8
          Width = 97
          Height = 25
          Caption = 'Load From XML'
          TabOrder = 0
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
    Connected = True
    HostName = ''
    Port = 0
    Database = 
      'C:\Users\Arturo\OneDrive\Documentos\Proyectos\Repos\Delphi\GridS' +
      'ave\Win32\Debug\employees.db'
    User = ''
    Password = ''
    Protocol = 'sqlite-3'
    LibraryLocation = 
      'C:\Users\Arturo\OneDrive\Documentos\sqlite-tools-win32-x86-34101' +
      '00\x86\sqlite3.dll'
    Left = 268
    Top = 152
  end
  object zq: TZQuery
    Connection = ZConn
    Active = True
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
    Left = 364
    Top = 272
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = grd
    PopupMenus = <>
    Left = 476
    Top = 328
  end
end
