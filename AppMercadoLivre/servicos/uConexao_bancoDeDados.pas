unit uConexao_bancoDeDados;

interface
type
  TMonostateConexao = class
   private
     class var _instancia: TMonostateConexao;
   public

  end;


implementation

{ TMonostateConexao }

initialization
  _instancia := nil;

finalization
  if(_instancia <> nil)then
    _instancia.free;

end.
