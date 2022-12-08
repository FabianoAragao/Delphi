object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 184
  Width = 370
  object con1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=teste' +
      'Postgres'
    LoginPrompt = False
    Left = 32
    Top = 40
  end
  object qry1: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from public.cliente')
    Left = 96
    Top = 40
    object qry1id: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qry1nome: TStringField
      FieldName = 'nome'
      Size = 8190
    end
    object qry1id_fone: TIntegerField
      FieldName = 'id_fone'
    end
  end
  object ds1: TDataSource
    DataSet = qry1
    Left = 144
    Top = 40
  end
end
