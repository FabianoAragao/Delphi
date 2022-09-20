unit uSessao_Model;

interface

Uses
  uUsuario_Model;

type
  TSessao_Model = class
  private
    { Private declarations }

    class var _usuario: TUsuario_Model;

  public
    { Public declarations }

    function getUsuario(): TUsuario_Model;

    constructor Create(usuario: TUsuario_Model);
    destructor Destroy();
  end;

implementation

{ TSessao_Model }

constructor TSessao_Model.Create(usuario: TUsuario_Model);
begin
  _usuario := usuario;
end;

destructor TSessao_Model.Destroy;
begin
  if(_usuario <> nil)then
    _usuario.Free;
end;

function TSessao_Model.getUsuario: TUsuario_Model;
begin
  result := _usuario;
end;

end.
