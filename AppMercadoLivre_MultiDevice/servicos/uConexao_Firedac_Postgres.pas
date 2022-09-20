unit uConexao_Firedac_Postgres;

interface

uses uIConexao_bancoDeDados, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TConexaoFiredacPostgres = class(TInterfacedObject, IConexaoComBancoDeDados<TFDConnection, TFDQuery>)

    protected
      class var Conexao:TFDConnection;
    public
      function getConexao(): TFDConnection;
      procedure criaQuery(var query: TFDQuery; const sql: string);
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

procedure TConexaoFiredacPostgres.criaQuery(var query: TFDQuery; const sql: string);
begin
  query := tFDQuery.Create(nil);

  query.ConnectionName := self.getConexao().ConnectionName;

  query.SQL.Clear;
  query.SQL.add(sql);
end;

end.
