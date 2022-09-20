unit uUsuario_Model;

interface

uses SysUtils;

type
  TUsuario_Model = class
  private
    { Private declarations }

    _id: integer;
    _nome: string;
    _nome_de_usuario: string;
    _senha: string;

  public
    { Public declarations }

    property id             :integer read _id              write _id;
    property nome           :string  read _nome            write _nome;
    property nome_de_usuario:string  read _nome_de_usuario write _nome_de_usuario;
    property senha          :string  read _senha           write _senha;
  end;

implementation

{ TUsuario_Model }

end.
