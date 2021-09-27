program AcertaCampos;

uses
  Vcl.Forms,
  Adm001 in 'Adm001.pas' {fAdm001};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfAdm001, fAdm001);
  Application.Run;
end.
