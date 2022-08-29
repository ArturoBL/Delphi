object Form1: TForm1
  Left = 324
  Top = 268
  Width = 1512
  Height = 671
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
  object Splitter1: TSplitter
    Left = 1009
    Top = 81
    Height = 563
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1504
    Height = 81
    Align = alTop
    TabOrder = 0
    object EditFac: TEdit
      Left = 32
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'A014849'
    end
    object Button2: TButton
      Left = 168
      Top = 32
      Width = 75
      Height = 25
      Caption = 'GenFile'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 256
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Load from file'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 512
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Guardar'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 600
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Checar'
      TabOrder = 4
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 344
      Top = 32
      Width = 153
      Height = 25
      Caption = 'Generar XML modificado'
      TabOrder = 5
      OnClick = Button5Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 1009
    Height = 563
    Align = alLeft
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 97
      Width = 1007
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 193
      Width = 1007
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 1007
      Height = 96
      Align = alTop
      TabOrder = 0
      object gtvDoc: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsDoc
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object gtvDocversion: TcxGridDBColumn
          Caption = 'Versi'#243'n'
          DataBinding.FieldName = 'version'
          Width = 43
        end
        object gtvDocserie: TcxGridDBColumn
          DataBinding.FieldName = 'serie'
          Width = 37
        end
        object gtvDocfolio: TcxGridDBColumn
          DataBinding.FieldName = 'folio'
          Width = 56
        end
        object gtvDocFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
        end
        object gtvDocsubtotal: TcxGridDBColumn
          DataBinding.FieldName = 'subtotal'
          Width = 92
        end
        object gtvDocdescuento: TcxGridDBColumn
          DataBinding.FieldName = 'descuento'
          Width = 83
        end
        object gtvDoctotal: TcxGridDBColumn
          DataBinding.FieldName = 'total'
          Width = 85
        end
        object gtvDocmoneda: TcxGridDBColumn
          DataBinding.FieldName = 'moneda'
          Width = 54
        end
        object gtvDoctipodecomprobante: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'tipodecomprobante'
          Width = 33
        end
        object gtvDocFormaPago: TcxGridDBColumn
          DataBinding.FieldName = 'FormaPago'
          Width = 66
        end
        object gtvDocMetodoPago: TcxGridDBColumn
          DataBinding.FieldName = 'MetodoPago'
          Width = 74
        end
        object gtvDocCondicionesDePago: TcxGridDBColumn
          DataBinding.FieldName = 'CondicionesDePago'
          Width = 132
        end
        object gtvDocTipoCambio: TcxGridDBColumn
          DataBinding.FieldName = 'TipoCambio'
          Width = 68
        end
        object gtvDocLugarExpedicion: TcxGridDBColumn
          DataBinding.FieldName = 'LugarExpedicion'
          Width = 90
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = gtvDoc
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 100
      Width = 1007
      Height = 93
      Align = alTop
      TabOrder = 1
      object Splitter3: TSplitter
        Left = 489
        Top = 1
        Height = 91
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 488
        Height = 91
        Align = alLeft
        TabOrder = 0
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 486
          Height = 19
          Align = alTop
          Caption = 'Emisor'
          TabOrder = 0
        end
        object cxGrid2: TcxGrid
          Left = 1
          Top = 20
          Width = 486
          Height = 70
          Align = alClient
          TabOrder = 1
          object gtvEmisor: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsEmisor
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object gtvEmisorRFC: TcxGridDBColumn
              DataBinding.FieldName = 'RFC'
            end
            object gtvEmisorNOMBRE: TcxGridDBColumn
              Caption = 'Nombre'
              DataBinding.FieldName = 'NOMBRE'
              Width = 192
            end
            object gtvEmisorRegimenFiscal: TcxGridDBColumn
              DataBinding.FieldName = 'RegimenFiscal'
              Width = 89
            end
          end
          object cxGrid2Level1: TcxGridLevel
            GridView = gtvEmisor
          end
        end
      end
      object Panel6: TPanel
        Left = 492
        Top = 1
        Width = 514
        Height = 91
        Align = alClient
        TabOrder = 1
        object Panel8: TPanel
          Left = 1
          Top = 1
          Width = 512
          Height = 19
          Align = alTop
          Caption = 'Receptor'
          TabOrder = 0
        end
        object cxGrid3: TcxGrid
          Left = 1
          Top = 20
          Width = 512
          Height = 70
          Align = alClient
          TabOrder = 1
          object gtvReceptor: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsReceptor
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object gtvReceptorRFC: TcxGridDBColumn
              DataBinding.FieldName = 'RFC'
            end
            object gtvReceptorNOMBRE: TcxGridDBColumn
              Caption = 'Nombre'
              DataBinding.FieldName = 'NOMBRE'
              Width = 283
            end
            object gtvReceptorUsoCFDI: TcxGridDBColumn
              DataBinding.FieldName = 'UsoCFDI'
              Width = 69
            end
          end
          object cxGrid3Level1: TcxGridLevel
            GridView = gtvReceptor
          end
        end
      end
    end
    object cxGrid4: TcxGrid
      Left = 1
      Top = 196
      Width = 1007
      Height = 366
      Align = alClient
      TabOrder = 2
      object gtvConceptos: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsConceptos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Total'
            Column = gtvConceptosTotal
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.Footer = True
        object gtvConceptosClaveProdServ: TcxGridDBColumn
          DataBinding.FieldName = 'ClaveProdServ'
          Width = 79
        end
        object gtvConceptosDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Width = 187
        end
        object gtvConceptosClaveUnidad: TcxGridDBColumn
          DataBinding.FieldName = 'ClaveUnidad'
          Width = 70
        end
        object gtvConceptosUnidad: TcxGridDBColumn
          DataBinding.FieldName = 'Unidad'
          Width = 48
        end
        object gtvConceptosCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          Width = 55
        end
        object gtvConceptosValorUnitario: TcxGridDBColumn
          DataBinding.FieldName = 'ValorUnitario'
          Width = 84
        end
        object gtvConceptosImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
        end
        object gtvConceptosBaseT: TcxGridDBColumn
          DataBinding.FieldName = 'BaseT'
        end
        object gtvConceptosImpuestoT: TcxGridDBColumn
          DataBinding.FieldName = 'ImpuestoT'
          Width = 60
        end
        object gtvConceptosTipoFactorT: TcxGridDBColumn
          DataBinding.FieldName = 'TipoFactorT'
        end
        object gtvConceptosImporteT: TcxGridDBColumn
          DataBinding.FieldName = 'ImporteT'
          Width = 69
        end
        object gtvConceptosTasaOCuotaT: TcxGridDBColumn
          DataBinding.FieldName = 'TasaOCuotaT'
          Width = 74
        end
        object gtvConceptosTotal: TcxGridDBColumn
          DataBinding.FieldName = 'Total'
          Width = 82
        end
      end
      object cxGrid4Level1: TcxGridLevel
        GridView = gtvConceptos
      end
    end
  end
  object Panel3: TPanel
    Left = 1012
    Top = 81
    Width = 492
    Height = 563
    Align = alClient
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 490
      Height = 561
      ActivePage = TabSheet3
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Original'
        object sedOri: TSynEdit
          Left = 0
          Top = 0
          Width = 482
          Height = 533
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
          Highlighter = SynXMLSyn1
          FontSmoothing = fsmNone
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Modificado'
        ImageIndex = 1
        object sedMod: TSynEdit
          Left = 0
          Top = 0
          Width = 482
          Height = 533
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
          Highlighter = SynXMLSyn1
          FontSmoothing = fsmNone
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Check'
        ImageIndex = 2
        object sedCheck: TSynEdit
          Left = 0
          Top = 0
          Width = 482
          Height = 533
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
          FontSmoothing = fsmNone
        end
      end
    end
  end
  object sesion: TOracleSession
    LogonUsername = 'siomgr'
    LogonPassword = 'p12.asp'
    LogonDatabase = 'SIOPRO11'
    Connected = True
    Left = 592
    Top = 8
  end
  object dsDoc: TDataSource
    DataSet = cdsDoc
    Left = 72
    Top = 128
  end
  object dsEmisor: TDataSource
    DataSet = cdsEmisor
    Left = 114
    Top = 214
  end
  object dsReceptor: TDataSource
    DataSet = cdsReceptor
    Left = 605
    Top = 206
  end
  object cdsReceptor: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 573
    Top = 206
    Data = {
      690000009619E0BD010000001800000003000000000003000000690003524643
      0100490000000100055749445448020002000F00064E4F4D4252450100490000
      0001000557494454480200020050000755736F43464449010049000000010005
      57494454480200020003000000}
    object cdsReceptorRFC: TStringField
      FieldName = 'RFC'
      Size = 15
    end
    object cdsReceptorNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 80
    end
    object cdsReceptorUsoCFDI: TStringField
      FieldName = 'UsoCFDI'
      Size = 3
    end
  end
  object cdsEmisor: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 82
    Top = 214
    Data = {
      6F0000009619E0BD0100000018000000030000000000030000006F0003524643
      0100490000000100055749445448020002000F00064E4F4D4252450100490000
      0001000557494454480200020050000D526567696D656E46697363616C010049
      00000001000557494454480200020003000000}
    object cdsEmisorRFC: TStringField
      FieldName = 'RFC'
      Size = 15
    end
    object cdsEmisorNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 80
    end
    object cdsEmisorRegimenFiscal: TStringField
      FieldName = 'RegimenFiscal'
      Size = 3
    end
  end
  object cdsDoc: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 121
    Data = {
      D80100009619E0BD01000000180000000E000000000003000000D80107566572
      73696F6E01004900000001000557494454480200020003000553657269650100
      49000000010005574944544802000200060005466F6C696F0100490000000100
      0557494454480200020006000546656368610100490000000100055749445448
      02000200140008537562746F74616C0800040000000100075355425459504502
      00490006004D6F6E657900094465736375656E746F0800040000000100075355
      42545950450200490006004D6F6E657900064D6F6E6564610100490000000100
      05574944544802000200030005546F74616C0800040000000100075355425459
      50450200490006004D6F6E657900115469706F4465436F6D70726F62616E7465
      010049000000010005574944544802000200010009466F726D615061676F0100
      4900000001000557494454480200020002000A4D65746F646F5061676F010049
      000000010005574944544802000200030011436F6E646963696F6E6573446550
      61676F01004900000001000557494454480200020050000A5469706F43616D62
      696F01004900000001000557494454480200020001000F4C7567617245787065
      646963696F6E01004900000001000557494454480200020006000000}
    object cdsDocVersion: TStringField
      FieldName = 'Version'
      Size = 3
    end
    object cdsDocSerie: TStringField
      FieldName = 'Serie'
      Size = 6
    end
    object cdsDocFolio: TStringField
      FieldName = 'Folio'
      Size = 6
    end
    object cdsDocFecha: TStringField
      FieldName = 'Fecha'
    end
    object cdsDocSubtotal: TCurrencyField
      FieldName = 'Subtotal'
    end
    object cdsDocDescuento: TCurrencyField
      FieldName = 'Descuento'
    end
    object cdsDocMoneda: TStringField
      FieldName = 'Moneda'
      Size = 3
    end
    object cdsDocTotal: TCurrencyField
      FieldName = 'Total'
    end
    object cdsDocTipoDeComprobante: TStringField
      FieldName = 'TipoDeComprobante'
      Size = 1
    end
    object cdsDocFormaPago: TStringField
      FieldName = 'FormaPago'
      Size = 2
    end
    object cdsDocMetodoPago: TStringField
      FieldName = 'MetodoPago'
      Size = 3
    end
    object cdsDocCondicionesDePago: TStringField
      FieldName = 'CondicionesDePago'
      Size = 80
    end
    object cdsDocTipoCambio: TStringField
      FieldName = 'TipoCambio'
      Size = 1
    end
    object cdsDocLugarExpedicion: TStringField
      FieldName = 'LugarExpedicion'
      Size = 6
    end
  end
  object cdsConceptos: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    OnCalcFields = cdsConceptosCalcFields
    Left = 128
    Top = 353
    Data = {
      8F0100009619E0BD01000000180000000C0000000000030000008F010D436C61
      766550726F64536572760100490000000100055749445448020002000A000B43
      6C617665556E6964616401004900000001000557494454480200020003000843
      616E7469646164080004000000000006556E6964616401004900000001000557
      494454480200020003000B4465736372697063696F6E02004900000001000557
      4944544802000200A00F0D56616C6F72556E69746172696F0800040000000100
      07535542545950450200490006004D6F6E65790007496D706F72746508000400
      0000010007535542545950450200490006004D6F6E6579000542617365540800
      04000000010007535542545950450200490006004D6F6E65790009496D707565
      73746F5401004900000001000557494454480200020003000B5469706F466163
      746F72540100490000000100055749445448020002000A0008496D706F727465
      54080004000000010007535542545950450200490006004D6F6E6579000B5461
      73614F43756F74615408000400000000000000}
    object cdsConceptosClaveProdServ: TStringField
      DisplayWidth = 14
      FieldName = 'ClaveProdServ'
      Size = 10
    end
    object cdsConceptosClaveUnidad: TStringField
      DisplayWidth = 12
      FieldName = 'ClaveUnidad'
      Size = 3
    end
    object cdsConceptosCantidad: TFloatField
      DisplayWidth = 12
      FieldName = 'Cantidad'
    end
    object cdsConceptosUnidad: TStringField
      DisplayWidth = 7
      FieldName = 'Unidad'
      Size = 3
    end
    object cdsConceptosDescripcion: TStringField
      DisplayWidth = 33
      FieldName = 'Descripcion'
      Size = 4000
    end
    object cdsConceptosValorUnitario: TCurrencyField
      DisplayWidth = 12
      FieldName = 'ValorUnitario'
    end
    object cdsConceptosImporte: TCurrencyField
      DisplayWidth = 12
      FieldName = 'Importe'
    end
    object cdsConceptosBaseT: TCurrencyField
      DisplayWidth = 12
      FieldName = 'BaseT'
    end
    object cdsConceptosImpuestoT: TStringField
      DisplayWidth = 10
      FieldName = 'ImpuestoT'
      Size = 3
    end
    object cdsConceptosTipoFactor: TStringField
      DisplayWidth = 12
      FieldName = 'TipoFactorT'
      Size = 10
    end
    object cdsConceptosImporteT: TCurrencyField
      FieldName = 'ImporteT'
    end
    object cdsConceptosTasaOCuota: TFloatField
      FieldName = 'TasaOCuotaT'
      DisplayFormat = '0.000000'
    end
    object cdsConceptosTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Total'
      Calculated = True
    end
  end
  object dsConceptos: TDataSource
    DataSet = cdsConceptos
    Left = 176
    Top = 369
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 1153
    Top = 186
  end
end
