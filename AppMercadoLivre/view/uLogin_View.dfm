object fLogin_View: TfLogin_View
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Login'
  ClientHeight = 635
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 233
    Align = alTop
    Color = 8454143
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -6
  end
  object Panel2: TPanel
    Left = 0
    Top = 233
    Width = 874
    Height = 402
    Align = alClient
    Color = 16316664
    ParentBackground = False
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 272
    Top = 120
    Width = 353
    Height = 441
    BorderWidth = 1
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 80
      Top = 64
      Width = 59
      Height = 24
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 96
      Top = 335
      Width = 153
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 96
      Top = 219
      Width = 121
      Height = 21
      BorderStyle = bsNone
      TabOrder = 1
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 96
      Top = 264
      Width = 121
      Height = 21
      BorderStyle = bsNone
      TabOrder = 2
      Text = 'Edit2'
    end
  end
end
