program AppMercadoLivre;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormPrincipal in 'view\uFormPrincipal.pas' {FormPrincipal},
  uUsuario_Controller in 'controller\uUsuario_Controller.pas',
  uUsuario_Model in 'model\uUsuario_Model.pas',
  uAutenticacao_mercado_livre in 'servicos\uAutenticacao_mercado_livre.pas',
  uConexao_Firedac_Postgres in 'servicos\uConexao_Firedac_Postgres.pas',
  uLogin_View in 'view\uLogin_View.pas' {fLogin_View},
  uRequisicoes_REST_Indy in 'servicos\uRequisicoes_REST_Indy.pas',
  uIRequisicoes_REST in 'servicos\interfaces\uIRequisicoes_REST.pas',
  uEPropriedadeRequisicao in 'servicos\enum\uEPropriedadeRequisicao.pas',
  uIConexao_bancoDeDados in 'servicos\interfaces\uIConexao_bancoDeDados.pas',
  uSessao_Model in 'model\uSessao_Model.pas',
  uUsuario_DAO in 'DAO\uUsuario_DAO.pas';

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
