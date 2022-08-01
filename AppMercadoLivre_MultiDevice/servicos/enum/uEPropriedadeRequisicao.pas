unit uEPropriedadeRequisicao;

interface
type
  //enum  para verificar qual propriedade esta sendo adicionada a requisicao
  //se é cabecalho, corpo(raw ou x_www_form_urlencoded) ou parametro
  TPropriedadeRequisicao = (Header,Parameter,
                            X_WWW_Form_URLEncoded,
                            X_WWW_Form_URLEncoded_File);

implementation

end.
