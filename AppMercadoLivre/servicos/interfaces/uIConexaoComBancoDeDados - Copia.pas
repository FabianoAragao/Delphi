unit uIConexaoComBancoDeDados;

interface
  type
    IConexaoComBancoDeDados<T> = interface
      ['{9291C67A-4342-4E6B-B8A4-0B765999598D}']

      function conexao(): T;
  end;
implementation

end.
