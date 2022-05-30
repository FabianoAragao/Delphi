object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'fFormPrincipal'
  ClientHeight = 216
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 352
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Post Token'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 431
    Height = 146
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
