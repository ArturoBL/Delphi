object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 662
  ClientWidth = 1044
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1044
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 643
    object Label1: TLabel
      Left = 232
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 384
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Button1: TButton
      Left = 24
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
    end
  end
  object pb: TPaintBox32
    Left = 0
    Top = 65
    Width = 1044
    Height = 597
    Align = alClient
    TabOrder = 1
    OnMouseDown = pbMouseDown
    OnMouseMove = pbMouseMove
    OnMouseUp = pbMouseUp
    OnPaintBuffer = pbPaintBuffer
    ExplicitLeft = 264
    ExplicitTop = 328
    ExplicitWidth = 192
    ExplicitHeight = 192
  end
end
