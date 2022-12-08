unit uBase_Cadastro_View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TfBaseCadastro_View = class(TForm)
    tabControl: TTabControl;
    tabListagem: TTabItem;
    tabCadastro: TTabItem;
    pnlRodaPe: TPanel;
    btnInserir: TButton;
    btnAlterar: TButton;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    grdListagem: TGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarListagem(sql: String);
  end;

var
  fBaseCadastro_View: TfBaseCadastro_View;

implementation

{$R *.fmx}

{ TfBaseCadastro_View }

procedure TfBaseCadastro_View.CarregarListagem(sql: String);
begin

end;

end.
