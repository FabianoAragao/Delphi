unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,IniFiles;

type
  TfrmPrincipal = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure ArquivoConfigINI;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

Uses uRequisicoes;

{$R *.dfm}

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
var
  sUrl:String;
  slBody:tstringstream;
  rRequisicao:TRequisicoes;
begin
//  curl --location --request POST 'https://api.mercadolibre.com/oauth/token?client_id=4984208124132508&client_secret=2zv4GCbuFj6GdAKwhx962dYPh5bmrYo1&grant_type=client_credentials' \
//--header 'Content-Type: application/x-www-form-urlencoded' \
//--header 'Accept: application/json'

  sUrl := 'https://api.mercadolibre.com/oauth/token';

  rRequisicao := TRequisicoes.Create(nil);

  try
    rRequisicao.AddPropriedade('Content-Type','application/x-www-form-urlencoded',Header);
    rRequisicao.AddPropriedade('Accept','application/json',Header);

    rRequisicao.AddPropriedade('grant_type','client_credentials',Parameter);
    rRequisicao.AddPropriedade('client_id','4984208124132508',Parameter);
    rRequisicao.AddPropriedade('client_secret','2zv4GCbuFj6GdAKwhx962dYPh5bmrYo1',Parameter);

     try
       memo1.text := rRequisicao.Post(sUrl);
     except
       on e:exception do
         begin
           showmessage(e.Message);
         end;
     end;
  finally
    freeandnil(rRequisicao);
  end;
end;

procedure TfrmPrincipal.ArquivoConfigINI();
var
  Arquivo:tIniFile;
begin
  try
    Arquivo := TIniFile.Create('C:\Configuracao.ini');
    Arquivo.WriteString('CONFIG', 'Banco','');
  finally
    Arquivo.Free;
  end;
end;

end.
