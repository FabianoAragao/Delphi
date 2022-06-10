unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,IniFiles,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,uIConexaoComBancoDeDados,uConexao_Postgres,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.VCLUI.Wait;

type
  TfrmPrincipal = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

Uses uRequisicoes_REST,uUsuario_View;

{$R *.dfm}

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
var
  sUrl:String;
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

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
var
  query   : TFDQuery;
  conexao : IConexaoComBancoDeDados<TFDConnection>;
begin
  query   := tFDQuery.Create(nil);
  conexao := TConexaoPostgres<TFDConnection>.create;

  query.ConnectionName := conexao.Conexao.ConnectionName;

  query.SQL.Clear;
  query.SQL.add('select nome from public.usuario where nome_de_usuario = ''fabianoxavante''');
  query.Active := true;

  showmessage(query.FieldByName('nome').AsString);
end;

procedure TfrmPrincipal.BitBtn3Click(Sender: TObject);
var
  fUsuario_view:TfUsuario_View;
begin
  Application.CreateForm(TfUsuario_View, fUsuario_view);

  fUsuario_view.show;
end;

end.
