program AppMercadoLivre;

uses
  Vcl.Forms,
  uRequisicoes_REST in 'servicos\uRequisicoes_REST.pas',
  uFormPrincipal in 'view\uFormPrincipal.pas' {frmPrincipal},
  uConexao_Postgres in 'servicos\uConexao_Postgres.pas',
  uIConexaoComBancoDeDados in 'servicos\interfaces\uIConexaoComBancoDeDados.pas',
  uAutenticacao_mercado_livre in 'servicos\uAutenticacao_mercado_livre.pas',
  uUsuario_Model in 'model\uUsuario_Model.pas',
  uUsuario_Controller in 'controller\uUsuario_Controller.pas',
  uUsuario_View in 'view\uUsuario_View.pas' {fUsuario_View},
  uLogin_View in 'view\uLogin_View.pas' {fLogin_View};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
