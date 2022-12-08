object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 612
  ClientWidth = 890
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
    Width = 890
    Height = 73
    Align = alTop
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 888
      Height = 73
      Align = alTop
      TabOrder = 0
      object dbnvgr1: TDBNavigator
        Left = 1
        Top = 1
        Width = 886
        Height = 71
        DataSource = DataModule2.ds1
        VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 257
    Width = 890
    Height = 355
    Align = alClient
    TabOrder = 1
    object lbl: TLabel
      Left = 16
      Top = 8
      Width = 8
      Height = 13
      Caption = 'id'
      FocusControl = dbedtid
    end
    object lbl1: TLabel
      Left = 16
      Top = 48
      Width = 26
      Height = 13
      Caption = 'nome'
      FocusControl = dbedtnome
    end
    object lbl2: TLabel
      Left = 16
      Top = 88
      Width = 36
      Height = 13
      Caption = 'id_fone'
      FocusControl = dbedtid_fone
    end
    object dbedtid: TDBEdit
      Left = 16
      Top = 24
      Width = 134
      Height = 21
      DataField = 'id'
      DataSource = DataModule2.ds1
      TabOrder = 0
    end
    object dbedtnome: TDBEdit
      Left = 16
      Top = 63
      Width = 500
      Height = 21
      DataField = 'nome'
      DataSource = DataModule2.ds1
      TabOrder = 1
    end
    object dbedtid_fone: TDBEdit
      Left = 16
      Top = 104
      Width = 134
      Height = 21
      DataField = 'id_fone'
      DataSource = DataModule2.ds1
      TabOrder = 2
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 73
    Width = 890
    Height = 184
    Align = alTop
    TabOrder = 2
    object dbgrd1: TDBGrid
      Left = 1
      Top = 1
      Width = 888
      Height = 182
      Align = alClient
      DataSource = DataModule2.ds1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
