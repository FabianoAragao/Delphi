unit uFormPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.InertialMovement,

  uConexao_Firedac_Postgres, uIConexao_bancoDeDados, FireDAC.FMXUI.Wait,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Layouts, FMX.Ani,
  FMX.TabControl, FMX.Effects, FMX.MultiView, uSessao_Model;

type
  TFormPrincipal = class(TForm)
    Layout3: TLayout;
    Layout1: TLayout;
    ScrollBox1: TScrollBox;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    GridPanelLayout1: TGridPanelLayout;
    Layout5: TLayout;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Image1: TImage;
    Label3: TLabel;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    ShadowEffect2: TShadowEffect;
    Image2: TImage;
    Label4: TLabel;
    Layout7: TLayout;
    Rectangle5: TRectangle;
    ShadowEffect3: TShadowEffect;
    Image3: TImage;
    Label5: TLabel;
    Layout8: TLayout;
    Rectangle6: TRectangle;
    ShadowEffect4: TShadowEffect;
    Image4: TImage;
    Label6: TLabel;
    Layout9: TLayout;
    Rectangle7: TRectangle;
    ShadowEffect5: TShadowEffect;
    Image5: TImage;
    Label7: TLabel;
    Layout10: TLayout;
    Rectangle8: TRectangle;
    ShadowEffect6: TShadowEffect;
    Image6: TImage;
    Label8: TLabel;
    RectCabecalho: TRectangle;
    Label2: TLabel;
    Label1: TLabel;
    RectMenu: TRectangle;
    Line1: TLine;
    SpeedButton1: TSpeedButton;
    ImgMasterbutton: TImage;
    Text1: TText;
    ImgLogo: TImage;
    FloatAnimationMenu: TFloatAnimation;
    FloatAnimationImgMasterButton: TFloatAnimation;
    procedure Rectangle1MouseLeave(Sender: TObject);
    procedure Rectangle1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
  private
    procedure ConfigScroolBox;
    procedure logof;
    { Private declarations }
  public
    { Public declarations }

    sessao : TSessao_Model;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uLogin_View, uRequisicoes_REST_Indy,uIRequisicoes_REST,uEPropriedadeRequisicao;

{$R *.fmx}

procedure TFormPrincipal.ConfigScroolBox();
var
  LCalculations: TAniCalculations;
begin
  LCalculations := nil;
  LCalculations := TAniCalculations.Create(nil);

  try
    with LCalculations do
      begin
        Animation := True;
        BoundsAnimation := true;
        Averaging := true;
        AutoShowing := true;
        DecelerationRate := 0.5;
        Elasticity := 50;
        TouchTracking := [ttHorizontal];
      end;

    // - passa as configurações para os componentes que possuem rolagem - //
    ScrollBox1.AniCalculations.Assign(LCalculations);
  finally
    if(LCalculations <> nil)then
      LCalculations.Free;
  end;
end;

procedure TFormPrincipal.logof();
begin
  try
    self.Visible := false;
    Application.CreateForm(TfLogin_View, fLogin_View);
    fLogin_View.ShowModal;

    if(sessao.getUsuario.id = 0)then
      self.Close
    else
      begin
        label1.Text := sessao.getUsuario.Nome_de_usuario;
      end;

  finally
    fLogin_View.Free;

    self.Visible := true;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  self.ConfigScroolBox;

  logof();
end;

procedure TFormPrincipal.Rectangle1MouseLeave(Sender: TObject);
begin
  (Sender as TRectangle).Fill.color := $FFFBFFC4;
end;

procedure TFormPrincipal.Rectangle1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  (Sender as TRectangle).Fill.color := $FFF6FF7B;
end;

procedure TFormPrincipal.Rectangle2Click(Sender: TObject);
var
  fLogin_View : TfLogin_View;
begin
  logof();
end;

procedure TFormPrincipal.Rectangle2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  (Sender as TRectangle).Fill.color := $FFDEF8FD;
end;

procedure TFormPrincipal.Rectangle2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  (Sender as TRectangle).Fill.color := $FFF6FF7B;
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
begin
  if RectMenu.Width = 60 then
    begin
      FloatAnimationMenu.StartValue := 60;
      FloatAnimationMenu.StopValue  := 204;
      FloatAnimationMenu.Start;

      FloatAnimationImgMasterButton.StartValue := 0;
      FloatAnimationImgMasterButton.StopValue  := 90;
      FloatAnimationImgMasterButton.Start;
    end
  else
    begin
      FloatAnimationMenu.StartValue := 204;
      FloatAnimationMenu.StopValue  := 60;
      FloatAnimationMenu.Start;

      FloatAnimationImgMasterButton.StartValue := 90;
      FloatAnimationImgMasterButton.StopValue  := 0;
      FloatAnimationImgMasterButton.Start;
    end;
end;

//#FFEEFF0C
//#FFF9FFAA

end.
