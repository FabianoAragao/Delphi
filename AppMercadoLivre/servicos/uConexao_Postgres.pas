unit uConexao_Postgres;

interface

uses uIConexaoComBancoDeDados, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TConexaoPostgres<T> = class(TInterfacedObject, IConexaoComBancoDeDados<TFDConnection>)

    protected
      class var Conexao:TFDConnection;
    public
      function getConexao(): TFDConnection;
    private
      function criaConexao(): TFDConnection;
  end;

implementation

{ TConexaoPostgres<T> }

function TConexaoPostgres<T>.criaConexao: TFDConnection;
var
  driver : TFDPhysPgDriverLink;
  conexao:TFDConnection;
begin
  conexao := nil;
  driver  := nil;

  conexao := TFDConnection.Create(nil);
  driver  := TFDPhysPgDriverLink.Create(nil);

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
  finally
    if(driver <> nil)then
      driver.Free;
  end;
end;

function TConexaoPostgres<T>.getConexao(): TFDConnection;
begin

  if(self.Conexao = nil)then
    self.Conexao := self.criaConexao();

  result := self.Conexao;
end;

end.
