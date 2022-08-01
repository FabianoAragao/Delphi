unit uUsuario_Model;

interface

uses Classes,uIConexaoComBancoDeDados,uConexao_Postgres,

SysUtils,

FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type
  TUsuario_Model = class

  public
    { Public declarations }
    function getId: integer;
    function getNome: string;
    function getNome_de_usuario: string;
    function getSenha: string;
    procedure setId(const Value: integer);
    procedure setNome(const Value: string);
    procedure setNome_de_usuario(const Value: string);
    procedure setSenha(const Value: string);
    procedure inserir(const Value: TUsuario_Model);
    procedure editar(const Value: TUsuario_Model);
    procedure apagar(const Value: integer);
    function buscar(const sql:string):TUsuario_Model;
    function listar(const Filtro:string):TList;

  private
    { Private declarations }
    _id              :integer;
    _nome            :string;
    _nome_de_usuario :string;
    _senha           :string;

    const NomeTabela :string = 'usuario';

    procedure CriaQuery(var query: TFDQuery; const sql: string);

    property id             :integer read getId              write setId;
    property nome           :string  read getNome            write setNome;
    property nome_de_usuario:string  read getNome_de_usuario write setNome_de_usuario;
    property senha          :string  read getSenha           write setSenha;
  end;

implementation

{ TUsuario_Model }

procedure TUsuario_Model.CriaQuery(var query:TFDQuery;const sql:string);
var
  conexao : IConexaoComBancoDeDados<TFDConnection>;
begin
  query   := tFDQuery.Create(nil);
  conexao := TConexaoPostgres<TFDConnection>.create;

  query.ConnectionName := conexao.Conexao.ConnectionName;

  query.SQL.Clear;
  query.SQL.add(sql);
end;

procedure TUsuario_Model.apagar(const Value: integer);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'DELETE FROM ' + NomeTabela + ' WHERE id = ' + IntToStr(Value);

  CriaQuery(query,sql);
  query.ExecSQL;
end;

function TUsuario_Model.buscar(const sql: string): TUsuario_Model;
var
  query   : TFDQuery;
  retorno : TUsuario_Model;
begin
  CriaQuery(query,sql);
  query.Active := true;

  retorno := nil;
  retorno := TUsuario_Model.Create;

  retorno.id              := query.FieldByName('id').AsInteger;
  retorno.nome            := query.FieldByName('nome').AsString;
  retorno.nome_de_usuario := query.FieldByName('nome_de_usuario').AsString;
  retorno.senha           := query.FieldByName('senha').AsString;

  Result := retorno;
end;

procedure TUsuario_Model.editar(const Value: TUsuario_Model);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'UPDATE' + NomeTabela + ' SET ' +
         'id = '                + inttostr(Value.id) + ' ' +
         'nome = ' + Value.nome + ' ' +
         'nome_de_usuario = '   + Value.nome_de_usuario + ' ' +
         'senha = '             + Value.senha;

  CriaQuery(query,sql);
  query.ExecSQL;
end;

function TUsuario_Model.getId: integer;
begin
  result := self.id;
end;

function TUsuario_Model.getNome: string;
begin
  result := self.nome;
end;

function TUsuario_Model.getNome_de_usuario: string;
begin
  result := self.getNome_de_usuario;
end;

function TUsuario_Model.getSenha: string;
begin
  result := self.getSenha;
end;

procedure TUsuario_Model.inserir(const Value: TUsuario_Model);
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'INSERT INTO ' + NomeTabela +
         '(id, nome, nome_de_usuario, senha) ' +
         'VALUES ' +
         '( ' + Value.getNome + ')';

  CriaQuery(query,sql);
  query.Active := true;
end;

function TUsuario_Model.listar(const Filtro:string): TList;
var
  query : TFDQuery;
  sql   :string;
begin
  sql := 'SELECT * FROM ' + NomeTabela + ' ' + Filtro;

  CriaQuery(query,sql);
  query.Active := true;
end;

procedure TUsuario_Model.setId(const Value: integer);
begin
  self.id := value;
end;

procedure TUsuario_Model.setNome(const Value: string);
begin
  self.nome := value;
end;

procedure TUsuario_Model.setNome_de_usuario(const Value: string);
begin
  self.nome_de_usuario := value;
end;

procedure TUsuario_Model.setSenha(const Value: string);
begin
  self.senha := value;
end;

end.
