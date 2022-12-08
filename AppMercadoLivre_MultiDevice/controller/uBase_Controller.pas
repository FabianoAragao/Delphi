unit uBase_Controller;

interface

uses Classes, uBase_Cadastro_View, uORM_ObjetoPersistente;

type
  TBase_Controller<F: TfBaseCadastro_View; O: TPersintentObject> = class
  private
    _View: TfBaseCadastro_View;
    _Model: TPersintentObject;
  protected
    property View: TfBaseCadastro_View read _View write _View;
    property ObjetoPersistente: TPersintentObject read _Model write _Model;

    procedure InserirClick(sender: TObject); virtual;
    procedure AlterarClick(sender: TObject); virtual;
    procedure SalvarClick(sender: TObject); virtual; abstract;
    procedure ExcluirClick(sender: TObject); virtual; abstract;
    procedure CancelarClick(sender: TObject); virtual;

    procedure Listar(sql: string); virtual;

    procedure BindInView(); virtual; abstract;
    procedure BindInModel(); virtual; abstract;
  public
    function showForm(): Integer;

    constructor Create; virtual;
  end;

implementation

uses
  System.Rtti, FMX.Forms;

{ TBase_Controller<F, O> }

procedure TBase_Controller<F, O>.AlterarClick(sender: TObject);
begin
  BindInView;
  _View.tabControl.ActiveTab := _View.tabCadastro;
end;

procedure TBase_Controller<F, O>.CancelarClick(sender: TObject);
begin
  _Model.free;
  BindInView;
  _View.tabControl.ActiveTab := _View.tabListagem;
end;

constructor TBase_Controller<F, O>.Create;
var
  ctx: TRttiContext;
begin
  _View :=  ctx.GetType(TClass(TfBaseCadastro_View))
               .GetMethod('Create')
               .Invoke(TClass(TfBaseCadastro_View),[application])
               .AsType<TfBaseCadastro_View>;

  _Model :=  ctx.GetType(TClass(TPersintentObject))
               .GetMethod('Create')
               .Invoke(TClass(TPersintentObject),[application])
               .AsType<TPersintentObject>;

  _View.btnInserir.OnClick  := InserirClick;
  _View.btnAlterar.OnClick  := AlterarClick;
  _View.btnCancelar.OnClick := CancelarClick;
  _View.btnSalvar.OnClick   := SalvarClick;
  _View.btnExcluir.OnClick  := ExcluirClick;


  _View.tabControl.ActiveTab := _View.tabListagem;
end;

procedure TBase_Controller<F, O>.ExcluirClick(sender: TObject);
begin

end;

procedure TBase_Controller<F, O>.InserirClick(sender: TObject);
begin
  _Model.Free;
  BindInView;
  _View.tabControl.ActiveTab := _View.tabCadastro;
end;

procedure TBase_Controller<F, O>.Listar(sql: string);
begin

end;

procedure TBase_Controller<F, O>.SalvarClick(sender: TObject);
begin

end;

function TBase_Controller<F, O>.showForm: Integer;
begin

end;

end.
