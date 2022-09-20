unit uUsuario_Controller;

interface

uses
  System.Classes, uUsuario_DAO,uUsuario_Model;


type
  TUsuario_Controller = class

  public
    { Public declarations }

    procedure apagar(const Value: integer);
    function buscar(const sql: string): TUsuario_Model;
    procedure editar(const Value: TUsuario_Model);
    procedure inserir(const Value: TUsuario_Model);
    function listar(const Filtro: string): TList;

    constructor Create();
    destructor destroy;

  private
    { Private declarations }
    var
      usuario_Dao : TUsuario_DAO;
  end;

implementation

{ TUsuario_Controller }

procedure TUsuario_Controller.apagar(const Value: integer);
begin
  usuario_Dao.apagar(Value);
end;

function TUsuario_Controller.buscar(const sql: string): TUsuario_Model;
begin
  result :=  usuario_Dao.buscar(sql);
end;

constructor TUsuario_Controller.Create();
begin
  Self.usuario_Dao := nil;
  Self.usuario_Dao := TUsuario_DAO.create;
end;

destructor TUsuario_Controller.Destroy;
begin
  Self.usuario_Dao.Free;
end;

procedure TUsuario_Controller.editar(const Value: TUsuario_Model);
begin
  usuario_Dao.editar(Value);
end;

procedure TUsuario_Controller.inserir(const Value: TUsuario_Model);
begin
  usuario_Dao.inserir(Value);
end;

function TUsuario_Controller.listar(const Filtro: string): TList;
begin
  result := usuario_Dao.listar(Filtro);
end;

end.
