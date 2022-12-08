unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    dbnvgr1: TDBNavigator;
    dbgrd1: TDBGrid;
    lbl: TLabel;
    dbedtid: TDBEdit;
    lbl1: TLabel;
    dbedtnome: TDBEdit;
    lbl2: TLabel;
    dbedtid_fone: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

end.
