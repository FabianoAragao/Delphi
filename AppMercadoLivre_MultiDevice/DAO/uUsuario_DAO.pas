unit uUsuario_DAO;

interface

uses

FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
FireDAC.VCLUI.Wait, FireDAC.Comp.Client,

Classes,uIConexao_bancoDeDados, SysUtils,uUsuario_Model,
uConexao_Firedac_Postgres;

type
  TUsuario_DAO = class

  public
    { Public declarations }
    procedure inserir(const Value: TUsuario_Model);
    procedure editar(const Value: TUsuario_Model);
    procedure apagar(const Value: integer);
    function buscar(const sql:string):TUsuario_Model;
    function listar(const Filtro:string):TList;

    Constructor Create;
    destructor destroy;

  private
    { Private declarations }
    const
      NomeTabela :string = 'usuario';

    var
      conexao: IConexaoComBancoDeDados<TFDConnection, TFDQuery>;

  end;

implementation

uses
  FMX.Dialogs;

{ TUsuario_DAO }

constructor TUsuario_DAO.Create;
begin
  self.conexao := nil;
  self.conexao := TConexaoFiredacPostgres.create;
end;

destructor TUsuario_DAO.destroy;
begin

end;

procedure TUsuario_DAO.apagar(const Value: integer);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'DELETE FROM ' + NomeTabela + ' WHERE id = ' + IntToStr(Value);

  conexao.CriaQuery(query, sql);
  query.ExecSQL;
end;

function TUsuario_DAO.buscar(const sql: string): TUsuario_Model;
var
  query   : TFDQuery;
  retorno : TUsuario_Model;
begin
  self.conexao.criaQuery(query, sql);

  try
    query.Active := true;

    retorno := nil;

    if(query.RecordCount > 0)then
      begin
        retorno := TUsuario_Model.Create;
        retorno.id              := query.FieldByName('id').AsInteger;
        retorno.nome            := query.FieldByName('nome').AsString;
        retorno.nome_de_usuario := query.FieldByName('nome_de_usuario').AsString;
        retorno.senha           := query.FieldByName('senha').AsString;
      end;

    Result := retorno;
  except
     On E: Exception do
       showMessage(E.Message);
  end;
end;

procedure TUsuario_DAO.editar(const Value: TUsuario_Model);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'UPDATE' + NomeTabela + ' SET ' +
         'id = '                + inttostr(Value.id) + ' ' +
         'nome = ' + Value.nome + ' ' +
         'nome_de_usuario = '   + Value.nome_de_usuario + ' ' +
         'senha = '             + Value.senha;

  conexao.CriaQuery(query, sql);

  try
    query.ExecSQL;
  except
     On E: Exception do
       showMessage(E.Message);
  end;
end;

procedure TUsuario_DAO.inserir(const Value: TUsuario_Model);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'INSERT INTO ' + NomeTabela +
         '(id, nome, nome_de_usuario, senha) ' +
         'VALUES ' +
         '( ' + Value.nome + ')';

  conexao.CriaQuery(query, sql);

  try
    query.Active := true;
  except
     On E: Exception do
       showMessage(E.Message);
  end;
end;

function TUsuario_DAO.listar(const Filtro:string): TList;
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'SELECT * FROM ' + NomeTabela + ' ' + Filtro;

  conexao.CriaQuery(query, sql);

  try
    query.Active := true;
  except
     On E: Exception do
       showMessage(E.Message);
  end;
end;

end.
