program AppMercadoLivre;

uses
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {frmPrincipal},
  uRequisicoes in 'servicos\uRequisicoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
