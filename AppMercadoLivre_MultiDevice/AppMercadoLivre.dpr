program AppMercadoLivre;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormPrincipal_View in 'view\uFormPrincipal_View.pas' {FormPrincipal},
  uLogin_View in 'view\uLogin_View.pas' {fLogin_View},
  uBase_Controller in 'controller\uBase_Controller.pas',
  uUsuario_Controller in 'controller\uUsuario_Controller.pas',
  uUsuario_Model in 'model\uUsuario_Model.pas',
  uSessao_Model in 'model\uSessao_Model.pas',
  uAutenticacao_mercado_livre in 'servicos\uAutenticacao_mercado_livre.pas',
  uConexao_Firedac_Postgres in 'servicos\uConexao_Firedac_Postgres.pas',
  uRequisicoes_REST_Indy in 'servicos\uRequisicoes_REST_Indy.pas',
  uIRequisicoes_REST in 'servicos\interfaces\uIRequisicoes_REST.pas',
  uIConexao_bancoDeDados in 'servicos\interfaces\uIConexao_bancoDeDados.pas',
  uEPropriedadeRequisicao in 'servicos\enum\uEPropriedadeRequisicao.pas',
  uBase_Cadastro_View in 'view\uBase_Cadastro_View.pas' {fBaseCadastro_View},
  uORM_AtributosDosCampos in 'ORM\uORM_AtributosDosCampos.pas',
  uORM_ObjetoPersistente in 'ORM\uORM_ObjetoPersistente.pas';

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
