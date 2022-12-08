unit uIConexao_bancoDeDados;

interface
  type
    IConexaoComBancoDeDados<T,U> = interface
    ['{C2A4618E-A3D1-4196-9B84-776B0274FE73}']
      function getConexao(): T;
      function criaConexao(): T;
      procedure iniciaTransacao;
      procedure commit;
      procedure rollback;

      function Execute(const ACmd: String; var Error: String): Boolean;
      function ExecuteQuery(const ACmd: String): U;

      property Conexao: T read getConexao;
  end;
implementation

end.
