unit uIRequisicoes_REST;

interface

uses uEPropriedadeRequisicao;

  type
    ['{F0082E73-47EC-4845-B716-570B9C58666E}']
    IRequisicoes_REST = interface
      function Post(pUrl:String):String;
      function Put(pUrl: String): String;
      function Get(pUrl: String): String;
      function Delete(pUrl: String): String;
      procedure AddPropriedade(pNome, pValor: String;pPropriedade:TPropriedadeRequisicao = Parameter); Overload;
      procedure AddPropriedade(pBody: String); Overload;    // quando for RawBody
  end;
implementation

end.
