unit uORM_ObjetoPersistente;

interface

uses
  FireDAC.Comp.Client,

  Rtti,StrUtils,Variants,Classes,SysUtils,
  uIConexao_bancoDeDados, uConexao_Firedac_Postgres,
  uORM_AtributosDosCampos;

type
  TPersintentObject = class
  private
    var
      FSQL: WideString;
      conexao: IConexaoComBancoDeDados<TFDConnection, TFDQuery>;

    function GetValue(const ARTP: TRttiProperty; const AFK: Boolean): String;
    procedure SetValue(P: TRttiProperty; S: Variant);
  public
    property CustomSQL: WideString read FSQL write FSQL;
    function Insert: Boolean;
    function Update: Boolean;
    function Delete: Boolean;
    procedure Load(const AValue: Integer); overload; virtual; abstract;
    function Load: Boolean; overload;

    Constructor Create(novaConexao : IConexaoComBancoDeDados<TFDConnection, TFDQuery>);
  end;

implementation

{ TPersintentObject }

constructor TPersintentObject.Create(
  novaConexao: IConexaoComBancoDeDados<TFDConnection, TFDQuery>);
begin
  self.conexao := nil;
  self.conexao := novaConexao;
end;

function TPersintentObject.Delete: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Where,
  Error: String;
begin
  Field := '';
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
      begin
        if Att is TableName then
          SQL := 'DELETE FROM ' + TableName(ATT).Name + ' ';
      end;

    for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
           begin
             if Att is FieldName then
               begin
                 if (FieldName(ATT).PK) then
                   Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK);
               end;
           end;
      end;

    SQL := SQL + ' WHERE ' + Where;

    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;

    Result := conexao.Execute(SQL,Error);

    if not Result then
      raise Exception.Create(Error);
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

function TPersintentObject.GetValue(const ARTP: TRttiProperty;
  const AFK: Boolean): String;
begin
  case ARTP.PropertyType.TypeKind of
    tkUnknown, tkInteger,
    tkInt64: Result := ARTP.GetValue(Self).ToString;
    tkEnumeration: Result := IntToStr(Integer(ARTP.GetValue(Self).AsBoolean));
    tkChar, tkString,
    tkWChar, tkLString,
    tkWString, tkUString: Result := QuotedStr(ARTP.GetValue(Self).ToString);
    tkFloat: Result := StringReplace(FormatFloat('0.00',ARTP.GetValue(Self).AsCurrency)
              ,FormatSettings.DecimalSeparator,'.',[rfReplaceAll,rfIgnoreCase]);
  end;

  if (AFK) and (Result = '0') then
    Result := 'null';
end;

function TPersintentObject.Insert: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Value,
  FieldID,
  NomeTabela,Error: String;
  Qry: TFDQuery;
begin
  Field := '';
  Value := '';
  conexao.iniciaTransacao;
  Ctx := TRttiContext.Create;
  try
    try
      RTT := CTX.GetType(ClassType);
      for Att in RTT.GetAttributes do
        begin
          if Att is TableName then
            begin
              SQL := 'INSERT INTO ' + TableName(ATT).Name;
              NomeTabela := TableName(ATT).Name;
            end;
        end;

      for RTP in RTT.GetProperties do
        begin
           for Att in RTP.GetAttributes do
             begin
               if Att is FieldName then
                 begin
                   if not (FieldName(ATT).AutoInc) then {Auto incremento não pode entrar no insert}
                     begin
                       Field := Field + FieldName(ATT).Name + ',';
                       Value := Value + GetValue(RTP,FieldName(ATT).FK) + ',';
                     end
                   else
                     FieldID := FieldName(ATT).Name;
                 end;
             end;
        end;

      Field := Copy(Field,1,Length(Field)-1);
      Value := Copy(Value,1,Length(Value)-1);

      SQL := SQL + ' (' + Field + ') VALUES (' + Value + ')';

      if Trim(CustomSQL) <> '' then
        SQL := CustomSQL;

      Result := conexao.Execute(SQL,Error);

      SQL := 'SELECT ' + FieldID + ' FROM ' + NomeTabela + ' ORDER BY ' + FieldID + ' DESC';
      Qry := conexao.ExecuteQuery(SQL);

      for RTP in RTT.GetProperties do
        begin
           for Att in RTP.GetAttributes do
             begin
               if (Att is FieldName) and (FieldName(ATT).AutoInc) then
                 begin
                   RTP.SetValue(Self,TValue.FromVariant(qry.Fields[0].AsInteger));
                 end;
             end;
        end;
    finally
      CustomSQL := '';
      conexao.Commit;
      CTX.Free;
    end;
  except
    conexao.Rollback;
    raise;
  end;
end;

function TPersintentObject.Load: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Where: String;
  Reader: TFDQuery;
begin
  Result := True;
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
      begin
        if Att is TableName then
          SQL := 'SELECT * FROM ' + TableName(ATT).Name;
      end;

    for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
           begin
             if Att is FieldName then
               begin
                 if (FieldName(ATT).PK) then
                   Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK);
               end;
           end;
      end;

    SQL := SQL + ' WHERE ' + Where;

    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;

    Reader := conexao.ExecuteQuery(SQL);

    if (Assigned(Reader)) and (Reader.RecordCount > 0) then
      begin
        with Reader do
          begin
            First;
            while not EOF do
              begin
                for RTP in RTT.GetProperties do
                  begin
                     for Att in RTP.GetAttributes do
                       begin
                         if Att is FieldName then
                           begin
                             if Assigned(FindField(FieldName(ATT).Name)) then
                               SetValue(RTP,FieldByName(FieldName(ATT).Name).Value);
                           end;
                       end;
                  end;
                Next;
              end;
          end;
      end
    else
      Result := False;
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

procedure TPersintentObject.SetValue(P: TRttiProperty; S: Variant);
var
  V: TValue;
  w: Word;
begin
  w := VarType(S);
  case w of
    271: v := StrToFloat(S); {smallmoney}
    272: v := StrToDateTime(S); {smalldatetime}
    3: v := StrToInt(S);
  else
    begin
      P.SetValue(Self,TValue.FromVariant(S));
      exit;
    end;
  end;
  p.SetValue(Self,v);
end;

function TPersintentObject.Update: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Where,
  Error: String;
begin
  Field := '';
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
      begin
        if Att is TableName then
          SQL := 'UPDATE ' + TableName(ATT).Name + ' SET';
      end;

    for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
           begin
             if Att is FieldName then
               begin
                 if (not (FieldName(ATT).AutoInc)) and (not (FieldName(ATT).PK)) then {Auto incremento não pode entrar no update}
                   begin
                     Field := Field + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK) + ',';
                   end
                 else if (FieldName(ATT).PK) then
                   Where := Where + Ifthen(Trim(where)='','',' AND ') + FieldName(ATT).Name + ' = ' + GetValue(RTP,FieldName(ATT).FK);
               end;
           end;
      end;

    Field := Copy(Field,1,Length(Field)-1);
    SQL := SQL + ' ' + Field + ' WHERE ' + Where;

    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;

    Result := conexao.Execute(SQL,Error);

    if not Result then
      raise Exception.Create(Error);
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

end.
