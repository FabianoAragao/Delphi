unit uRequisicoes_REST;

interface

uses IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Generics.Collections, System.Classes, IdMultipartFormData;

type
  //enum  para verificar qual propriedade esta sendo adicionada a requisicao
  //se é cabecalho, corpo(raw ou x_www_form_urlencoded) ou parametro
  TPropriedadeRequisicao = (Header,Parameter,
                            X_WWW_Form_URLEncoded,
                            X_WWW_Form_URLEncoded_File);

  TRequisicoes = class
  private
    { Private declarations }
    Parametros                : String;
    X_WWW_Form_URLEncoded_Body: TIdMultipartFormDataStream;
    Raw_body                  : String;

    //componentes para fazer as requisições
    IdHTTP     : TIdHTTP;
    IdSSL      : TIdSslIoHandlerSocketOpenSsl;
  public
    constructor Create(sender:TObject);
    destructor Destroy();

    function Post(pUrl:String):String;
    function Put(pUrl: String): String;
    function Get(pUrl: String): String;
    function Delete(pUrl: String): String;
    procedure AddPropriedade(pNome, pValor: String;pPropriedade:TPropriedadeRequisicao = Parameter); Overload;
    procedure AddPropriedade(pBody: String); Overload;    // quando for RawBody
end;


implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TRequisicoes }

constructor TRequisicoes.create(sender:TObject);
begin
  //configura o componente de tls
  IdSSL                              := TIDSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSSL.SSLOptions.Method            := sslvSSLv3;
  IdSSL.SSLOptions.SSLVersions       := [sslvTLSv1,sslvSSLv2,sslvSSLv2];

  //configura o componente que fará as requisições
  IdHTTP                             := TIdHTTP.Create(nil);
  IdHTTP.Request.Clear;
  IdHTTP.IOHandler                   := IdSSL;
  IdHTTP.Request.BasicAuthentication := False;
  IdHTTP.Request.CharSet             := 'utf-8';

  //propriedade que guarda os parametros da requisicao
  Parametros := '?';

  //propriedade que guarda o corpo da requisicao (X_WWW_Form_URLEncoded_Body)
  X_WWW_Form_URLEncoded_Body := TIdMultipartFormDataStream.Create;

  //propriedade que guarda o corpo da requisicao (Raw_Body)
  Raw_body := '';
end;

destructor TRequisicoes.Destroy();
begin
  if(Assigned(IdHTTP))then
    FreeAndNil(IdHTTP);

  if(Assigned(IdHTTP))then
    FreeAndNil(IdSSL);

  if(Assigned(IdHTTP))then
    FreeAndNil(X_WWW_Form_URLEncoded_Body);
end;


procedure TRequisicoes.AddPropriedade(pNome, pValor: String;pPropriedade:TPropriedadeRequisicao = Parameter);
begin
  case pPropriedade of
    Header:
      begin
        IdHTTP.Request.CustomHeaders.Values[pNome] := pValor;
      end;

    Parameter:
      begin
        if(Parametros = '?')then
          Parametros := Parametros + pNome + '=' + pValor
        else
          Parametros := Parametros + '&' + pNome + '=' + pValor;
      end;

    X_WWW_Form_URLEncoded:
      begin
        X_WWW_Form_URLEncoded_Body.AddFormField(pNome,pValor);
      end;

    X_WWW_Form_URLEncoded_File:
      begin
        X_WWW_Form_URLEncoded_Body.AddFile(pNome,pValor);
      end;
  end;
end;

procedure TRequisicoes.AddPropriedade(pBody: String);
begin
  Raw_body := pBody;
end;

function TRequisicoes.Post(pUrl:String):String;
begin
  if(Parametros = '?')then
    Parametros := '';

  try
    if(Raw_body <> '')then
      Result := IdHTTP.Post(pUrl + Parametros, TStringStream.Create(Raw_body))
    else if(Assigned(X_WWW_Form_URLEncoded_Body))then
      begin
        Result := IdHTTP.Post(pUrl + Parametros, X_WWW_Form_URLEncoded_Body);
      end
    else //se nao tiver nenhum corpo setado joga um corpo vazio
      Result := IdHTTP.Post(pUrl + Parametros, TStringStream.Create(''));
  except
    on e:exception do
      begin
        showmessage(e.Message +  ' - ' + Result);
      end;
  end;
end;

function TRequisicoes.Put(pUrl:String):String;
begin
  if(Parametros = '?')then
    Parametros := '';

  try
    if(Raw_body <> '')then
      Result := IdHTTP.Put(pUrl + Parametros, TStringStream.Create(Raw_body))
    else if(Assigned(X_WWW_Form_URLEncoded_Body))then
      Result := IdHTTP.Put(pUrl + Parametros, X_WWW_Form_URLEncoded_Body)
    else //se nao tiver nenhum corpo setado joga um corpo vazio
      Result := IdHTTP.Put(pUrl + Parametros, TStringStream.Create(''));
  except
    on e:exception do
      begin
        showmessage(e.Message +  ' - ' + Result);
      end;
  end;
end;

function TRequisicoes.Get(pUrl:String):String;
begin
  if(Parametros = '?')then
    Parametros := '';

  try
    Result := IdHTTP.Get(pUrl + Parametros);
  except
    on e:exception do
      begin
        showmessage(e.Message +  ' - ' + Result);
      end;
  end;
end;

function TRequisicoes.Delete(pUrl:String):String;
begin
  if(Parametros = '?')then
    Parametros := '';

  try
    Result := IdHTTP.Delete(pUrl + Parametros);
  except
    on e:exception do
      begin
        showmessage(e.Message +  ' - ' + Result);
      end;
  end;
end;

end.
