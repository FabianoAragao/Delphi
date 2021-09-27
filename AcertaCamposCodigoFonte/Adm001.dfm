object fAdm001: TfAdm001
  Left = 6
  Top = 26
  Caption = 'fAdm001 - Acerta Campos em c'#243'digo fonte DELPHI'
  ClientHeight = 659
  ClientWidth = 1264
  Color = clBtnFace
  Constraints.MaxHeight = 698
  Constraints.MaxWidth = 1280
  Constraints.MinHeight = 698
  Constraints.MinWidth = 1280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object label1: TLabel
    Left = 8
    Top = 4
    Width = 91
    Height = 13
    Caption = 'Nomes Das Querys'
  end
  object Label3: TLabel
    Left = 192
    Top = 4
    Width = 41
    Height = 13
    Caption = 'Fontes'
  end
  object Label101: TLabel
    Left = 0
    Top = 646
    Width = 1264
    Height = 13
    Align = alBottom
    Alignment = taCenter
    Caption = 'Label101'
    ExplicitWidth = 43
  end
  object BitBtn1: TBitBtn
    Left = 1168
    Top = 624
    Width = 89
    Height = 25
    Caption = 'Transformar'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 192
    Top = 23
    Width = 1065
    Height = 601
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 8
    Top = 23
    Width = 178
    Height = 601
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 1073
    Top = 624
    Width = 89
    Height = 25
    Caption = 'Gera Convers'#227'o'
    Enabled = False
    TabOrder = 3
    Visible = False
  end
end
