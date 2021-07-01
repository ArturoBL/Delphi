object FormScroll: TFormScroll
  Left = 483
  Top = 232
  Width = 528
  Height = 505
  Caption = 'FormScroll'
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
  object dxColorPicker1: TdxColorPicker
    Left = 40
    Top = 48
    Width = 458
    Height = 328
    OnColorChanged = dxColorPicker1ColorChanged
  end
  object BitBtn1: TBitBtn
    Left = 184
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    ModalResult = 1
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 304
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 40
    Top = 408
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object RadioButton1: TRadioButton
    Left = 400
    Top = 416
    Width = 113
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 4
  end
end
