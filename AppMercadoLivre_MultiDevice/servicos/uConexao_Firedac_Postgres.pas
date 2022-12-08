unit uConexao_Firedac_Postgres;

interface

uses uIConexao_bancoDeDados, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TConexaoFiredacPostgres = class(TInterfacedObject, IConexaoComBancoDeDados<TFDConnection, TFDQuery>)

    protected
      class var Conexao:TFDConnection;
    public
      function getConexao(): TFDConnection;
      procedure iniciaTransacao;
      procedure commit;
      procedure rollback;

      function Execute(const ACmd: String; var Error: String): Boolean;
      function ExecuteQuery(const ACmd: String): TFDQuery;

      constructor create;
    private
      function criaConexao(): TFDConnection;
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs;

{ TConexaoFiredacPostgres<T> }

constructor TConexaoFiredacPostgres.create;
begin
  if(Conexao = nil)then
    Conexao := criaConexao();
end;

function TConexaoFiredacPostgres.criaConexao: TFDConnection;
var
  driver : TFDPhysPgDriverLink;
  conexao:TFDConnection;
begin
  conexao := nil;
  driver  := nil;

  conexao := TFDConnection.Create(nil);
  driver  := TFDPhysPgDriverLink.Create(nil);

  try
    try
      driver.DriverID := 'PG';
      driver.VendorLib    := 'C:\Program Files\PostgreSQL\psqlODBC\bin\libpq.dll';

      conexao.Params.Database := 'client_api_mercado_livre';
      conexao.Params.UserName := 'postgres';
      conexao.Params.Password := '123456';
      conexao.Params.DriverID := driver.DriverID;
      conexao.DriverName      := driver.DriverID;
      conexao.Connected       := true;
      conexao.ConnectionName  := 'conexao_postgres';

      result := conexao;
    except
       On E: Exception do
         showMessage(E.Message);
    end;
  finally
    if(driver <> nil)then
      driver.Free;
  end;
end;

function TConexaoFiredacPostgres.getConexao(): TFDConnection;
begin
  if(self.Conexao = nil)then
    self.Conexao := self.criaConexao();

  result := self.Conexao;
end;

procedure TConexaoFiredacPostgres.iniciaTransacao;
begin
  Conexao.TxOptions.EnableNested := true;
  Conexao.TxOptions.AutoCommit   := false;

  Conexao.StartTransaction;
end;

procedure TConexaoFiredacPostgres.commit;
begin
  if(conexao.InTransaction)then
    begin
      Conexao.Commit;
    end
  else
    raise Exception.Create('Tentatva de commit sem transação iniciada');
end;

procedure TConexaoFiredacPostgres.rollback;
begin
  if(conexao.InTransaction)then
    begin
      Conexao.Rollback;
    end
  else
    raise Exception.Create('Tentatva de commit sem transação iniciada');
end;

function TConexaoFiredacPostgres.Execute(const ACmd: String; var Error: String): Boolean;
begin
  Result := True;
  try
    conexao.ExecSQL(ACmd);
  except
    on E: Exception do
      begin
        Error := E.Message;
        Result := False;
      end;
  end;
end;

function TConexaoFiredacPostgres.ExecuteQuery(const ACmd: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    with Result do
      begin
        Connection := conexao;
        Close;
        SQL.Clear;
        SQL.Add(ACmd);
        Open;
      end;
  except
    Result := nil;
  end;
end;

end.
