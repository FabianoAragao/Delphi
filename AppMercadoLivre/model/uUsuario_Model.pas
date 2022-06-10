unit uUsuario_Model;

interface

uses Classes,uIConexaoComBancoDeDados,uConexao_Postgres;

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
    procedure apagar(const Value: TUsuario_Model);
    function buscar(const Query:string):TUsuario_Model;
    function listar():TList;
  private
    { Private declarations }
    _id             :integer;
    _nome           :string;
    _nome_de_usuario:string;
    _senha          :string;

    property id             :integer read getId              write setId;
    property nome           :string  read getNome            write setNome;
    property nome_de_usuario:string  read getNome_de_usuario write setNome_de_usuario;
    property senha          :string  read getSenha           write setSenha;
  end;

implementation

{ TUsuario_Model }

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
