unit uUsuario_Model;

interface

uses SysUtils, uORM_ObjetoPersistente, uORM_AtributosDosCampos;

type
  [Tablename('usuario')]
  TUsuario_Model = class(TPersintentObject)
  private
    { Private declarations }

    _id: integer;
    _nome: string;
    _nome_de_usuario: string;
    _senha: string;
    procedure Load(const AValue: Integer);

  public
    { Public declarations }
    [FieldName('id',True,True)]
    property id             :integer read _id              write _id;
    [FieldName('nome')]
    property nome           :string  read _nome            write _nome;
    [FieldName('nome-de_usuario')]
    property nome_de_usuario:string  read _nome_de_usuario write _nome_de_usuario;
    [FieldName('senha')]
    property senha          :string  read _senha           write _senha;
  end;

implementation

{ TUsuario_Model }

procedure TUsuario_Model.Load(const AValue: Integer);
begin
  ID := AValue;

  inherited Load;
end;

end.
