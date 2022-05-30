program AppMercadoLivre;

uses
  Vcl.Forms,
  uRequisicoes in 'servicos\uRequisicoes.pas',
  uFormPrincipal in 'view\uFormPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
