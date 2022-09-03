object frmMain: TfrmMain
  Left = 354
  Top = 195
  Width = 1370
  Height = 739
  Caption = 'Grid2XML'
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
    Left = 8
    Top = 24
    Width = 633
    Height = 337
    TabOrder = 0
    object TVCompras: TcxGridDBTableView
      OnMouseDown = TVComprasMouseDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = wdsCompras
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object TVComprasNO_ORDEN_COMPRA: TcxGridDBColumn
        Caption = 'No. Orden'
        DataBinding.FieldName = 'NO_ORDEN_COMPRA'
      end
      object TVComprasFECHA: TcxGridDBColumn
        Caption = 'Fecha'
        DataBinding.FieldName = 'FECHA'
      end
      object TVComprasNOMBRE: TcxGridDBColumn
        Caption = 'Nombre'
        DataBinding.FieldName = 'NOMBRE'
        Width = 132
      end
      object TVComprasCVE_PROVEEDOR: TcxGridDBColumn
        Caption = 'Proveedor'
        DataBinding.FieldName = 'CVE_PROVEEDOR'
      end
      object TVComprasFOLIO: TcxGridDBColumn
        DataBinding.FieldName = 'FOLIO'
      end
      object TVComprasLUGAR_ENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'LUGAR_ENTREGA'
      end
      object TVComprasFEC_ESP_ENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'FEC_ESP_ENTREGA'
      end
      object TVComprasATENCION_PROVEEDOR: TcxGridDBColumn
        DataBinding.FieldName = 'ATENCION_PROVEEDOR'
      end
      object TVComprasNO_CENTRO_COSTO: TcxGridDBColumn
        DataBinding.FieldName = 'NO_CENTRO_COSTO'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = TVCompras
    end
  end
  object sedXML: TSynEdit
    Left = 672
    Top = 48
    Width = 633
    Height = 289
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
    Highlighter = SynXMLSyn1
    FontSmoothing = fsmNone
  end
  object Button1: TButton
    Left = 768
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Generar XML'
    TabOrder = 2
    OnClick = Button1Click
  end
  object cxGrid2: TcxGrid
    Left = 16
    Top = 448
    Width = 609
    Height = 200
    TabOrder = 3
    object cxGrid2DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = wdsDest
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
  object Button2: TButton
    Left = 24
    Top = 400
    Width = 137
    Height = 25
    Caption = 'Cargar desde XML'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 488
    Top = 392
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 680
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 6
    OnClick = Button4Click
  end
  object sedXML2: TSynEdit
    Left = 664
    Top = 376
    Width = 633
    Height = 289
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 7
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynXMLSyn1
    FontSmoothing = fsmNone
  end
  object odsCompras: TOracleDataSet
    SQL.Strings = (
      
        'select no_orden_compra, cve_proveedor, e.nombre, o.folio, o.fech' +
        'a,'
      '       decode(lugar_entrega'
      '                , '#39'A'#39' , '#39'Bodega Arroz'#39
      '                , '#39'O'#39' , '#39'Obra'#39
      '                , '#39'M'#39' , '#39'Maquilador'#39
      '                , '#39'R'#39' , '#39'Recogen'#39
      '                , '#39'T'#39' , '#39'Otro'#39
      '                , '#39'B'#39' , '#39'Bodega Arroyo'#39
      '                , '#39'C'#39' , '#39'Bodega Sabadell'#39
      '                , '#39'D'#39' , '#39'Bodega Tlahuac'#39
      '                , '#39'P'#39' , '#39'Por Definir'#39') lugar_entrega'
      '       , fec_esp_entrega, atencion_proveedor, no_centro_costo   '
      '  from ordenes_Compra o, empleados e'
      ' where o.no_empleado = e.no_empleado'
      '  and rownum < 10'
      ' order by no_orden_compra')
    QBEDefinition.QBEFieldDefs = {
      04000000090000000F0000004E4F5F4F5244454E5F434F4D5052410100000000
      000D0000004356455F50524F564545444F52010000000000060000004E4F4D42
      524501000000000005000000464F4C494F010000000000050000004645434841
      0100000000000D0000004C554741525F454E54524547410100000000000F0000
      004645435F4553505F454E5452454741010000000000120000004154454E4349
      4F4E5F50524F564545444F520100000000000F0000004E4F5F43454E54524F5F
      434F53544F010000000000}
    Session = sesion
    Active = True
    Left = 48
    Top = 32
  end
  object sesion: TOracleSession
    LogonUsername = 'siomgr'
    LogonPassword = 'p12.asp'
    LogonDatabase = 'SIOPRO11'
    Connected = True
    Left = 16
    Top = 32
  end
  object wdsCompras: TwwDataSource
    DataSet = odsCompras
    Left = 80
    Top = 32
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 776
    Top = 112
  end
  object ODSDest: TOracleDataSet
    Session = sesion
    Left = 80
    Top = 432
  end
  object wdsDest: TwwDataSource
    DataSet = ODSDest
    Left = 120
    Top = 432
  end
end
