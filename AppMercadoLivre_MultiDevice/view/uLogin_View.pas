unit uLogin_View;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.TabControl, uFormPrincipal, uSessao_Model;

type
  TfLogin_View = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Edit2: TEdit;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Text1: TText;
    RectContinuar: TRectangle;
    Text2: TText;
    Text3: TText;
    RectFechar: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure RectFecharMouseLeave(Sender: TObject);
    procedure RectFecharMouseEnter(Sender: TObject);
    procedure RectFecharClick(Sender: TObject);
    procedure RectFecharMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RectContinuarClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    sessao : TSessao_Model;

  public
    { Public declarations }
  end;

var
  fLogin_View: TfLogin_View;

implementation

uses
  uUsuario_Controller, uUsuario_Model, System.SysUtils;

{$R *.fmx}

procedure TfLogin_View.Edit1Enter(Sender: TObject);
begin
  if Edit1.Text = 'Nome de usuário' then
    Edit1.Text := '';
end;

procedure TfLogin_View.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then
    Edit1.Text := 'Nome de usuário';
end;

procedure TfLogin_View.Edit1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if(Key = vkTab)or(Key = vkReturn)then
    Edit2.SetFocus;
end;

procedure TfLogin_View.Edit2Enter(Sender: TObject);
begin
  if Edit2.Text = 'transparentedit' then
    Edit2.Text := '';

end;

procedure TfLogin_View.Edit2Exit(Sender: TObject);
begin
  if Edit2.Text = '' then
    Edit2.Text := 'transparentedit';
end;

procedure TfLogin_View.Edit2KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if(Key = vkTab)or(Key = vkReturn)then
    RectContinuar.SetFocus;
end;

procedure TfLogin_View.RectContinuarClick(Sender: TObject);
var
  usuarioController: TUsuario_Controller;
  usuarioModel     : TUsuario_Model;
  sql              : string;
  usuario          : string;
  senha            : string;
begin
  if (edit1.Text = '')or(edit1.Text = 'Nome de usuário') then
    ShowMessage('Digite o nome de usuário.')
  else if(edit2.Text = '')or(edit2.Text = 'transparentedit')then
    ShowMessage('Digite a senha.');

  usuario := stringreplace(edit1.Text, '''', '',[rfReplaceAll]);
  senha   := stringreplace(edit2.Text, '''', '',[rfReplaceAll]);

  sql := 'SELECT * FROM  public.usuario WHERE nome_de_usuario = ';
  sql := sql + ' ''' + usuario + ''' and senha = ''' + senha + ''' ';

  try
    usuarioController := nil;
    usuarioModel      := nil;

    usuarioController := TUsuario_Controller.Create();

    usuarioModel := usuarioController.buscar(sql);

    if(usuarioModel <> nil)and(usuarioModel.id > 0)then
      begin
        sessao := TSessao_Model.Create(usuarioModel);
        self.Close;
      end
    else
      begin
        ShowMessage('Usuário ou senha incorreto.');
        exit;
      end;


  finally
    if(usuarioController <> nil)then
      usuarioController.free;
  end;

end;

procedure TfLogin_View.RectFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfLogin_View.RectFecharMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin

  RectFechar.Fill.Color := $FF95C0FF;
end;

procedure TfLogin_View.RectFecharMouseEnter(Sender: TObject);
begin
  RectFechar.Fill.Color := $FFEEEEFF;
end;

procedure TfLogin_View.RectFecharMouseLeave(Sender: TObject);
begin
  RectFechar.Fill.Color := $ffffffff;
end;

end.
