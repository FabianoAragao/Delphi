unit Adm001;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
	TResultArray = array of string;

type
  TfAdm001 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    label1: TLabel;
    Label3: TLabel;
    Memo2: TMemo;
    Label101: TLabel;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    function Explode(const cSeparator, vString: String): TResultArray;
    function Implode(const cSeparator: String;
      const cArray: TResultArray): String;
    procedure alteraCampos;
    procedure TrimAppMemorySize;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdm001: TfAdm001;

implementation

{$R *.dfm}

//Implode igual php
function TfAdm001.Implode(const cSeparator: String; const cArray: TResultArray): String;
var
  i: Integer;
begin
  Result := '';
  Result := Result + cArray[0];

  for i := 1 to Length(cArray) -1 do
    begin
      Result := Result + cSeparator + cArray[i];
    end;

  //System.Delete(Result, 1, Length(cSeparator));
end;

procedure TfAdm001.TrimAppMemorySize;
var
  MainHandle : THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
    CloseHandle(MainHandle) ;
  except
  end;

  Application.ProcessMessages;
end;

procedure TfAdm001.alteraCampos();
var zParteCopiada,zNomeQuery,zNomeSeparador:string;
    zLinhaPt,zLinhaPt2 : TResultArray;
    zInicio,zFim,zSeparador,zI,zL,zI2:integer;
begin
  For zI := 0 to (Memo1.Lines.Count -1) do
    begin
      TrimAppMemorySize;

      if(Memo1.Lines[zI] = '')then
        Continue;

      zLinhaPt      := Explode(':=',Memo1.Lines[zI]);

      For zL := 0 to (Memo2.Lines.Count -1) do
        begin
          label101.Caption := 'zI = ' + IntToStr(zI) + ' - zL = ' + IntToStr(zL);
          label101.Update;

          if(Pos(LowerCase(Memo2.Lines[zL]),LowerCase(Memo1.Lines[zI])) <= 0)then
            Continue;

          if(Memo2.Lines[zL] <> '')THEN
            begin
              //*******************************************************
              //        Antes do :=
              //******************************************************
              zNomeQuery := Memo2.Lines[zL];

              //se não tiver o nome da query na lina pula pro proximo
              if(Pos(LowerCase(zNomeQuery),LowerCase(Memo1.Lines[zI])) <= 0)then
                Continue;

              //para não atrapalhar os que ja estiverem protos ou os .append, .post ...
              if(Length(zLinhaPt) = 1)then
                begin
                  zInicio := Pos(LowerCase(zNomeQuery),LowerCase(zLinhaPt[0]));
                  zInicio := zInicio + Length(zNomeQuery);

                  if(copy(zLinhaPt[0],(zInicio+1),1) = '.')then
                    begin
                      zInicio := 0;
                      continue;
                    end
                  else
                    zInicio := 0;
                end;

                if(pos(LowerCase('.'),LowerCase(zLinhaPt[0])) > 0)then
                  begin
                    zInicio := Pos(LowerCase(zNomeQuery),LowerCase(zLinhaPt[0]));

                    if(zInicio > 0)then
                      begin
                        zInicio        := zInicio + Length(zNomeQuery);
                        zFim           := Pos(LowerCase('.'),LowerCase(zLinhaPt[0])) - zInicio;

                        if((zFim - 1) <= 0)then
                          Continue;

                        zParteCopiada  := Copy(zLinhaPt[0],zInicio,zFim);

                        if (zLinhaPt[0] = '')then
                          Continue;

                        zLinhaPt[0] := StringReplace(zLinhaPt[0],zParteCopiada+'.','.',[rfIgnoreCase]);
                        zLinhaPt[0] := StringReplace(zLinhaPt[0],'.FieldByName('''')','',[rfIgnoreCase]);
                        zLinhaPt[0] := StringReplace(zLinhaPt[0],'.','.FieldByName('''+zParteCopiada+''').',[rfIgnoreCase]);
                      end;
                  end;

              if(pos('+',zLinhaPT[1]) > 0)or(pos(',',zLinhaPT[1]) > 0)then
                begin
                  //*******************************************************
                  //        Depois do := (Separa cada concatenação '+' e faz a troca)
                  //******************************************************

                  for zSeparador := 0 to 5 do
                    begin
                      case zSeparador of
                        0:
                          begin
                            zNomeSeparador := '+';
                          end;
                        1:
                          begin
                            zNomeSeparador := ',';
                          end;
                        2:
                          begin
                            zNomeSeparador := '-';
                          end;
                        3:
                          begin
                            zNomeSeparador := '*';
                          end;
                        4:
                          begin
                            zNomeSeparador := '/';
                          end;
                        5:
                          begin
                            zNomeSeparador := '=';
                          end;
                      end;

                      zLinhaPt2 := Explode(zNomeSeparador, zLinhaPT[1]);

                      for zI2 := 0 to (Length(zLinhaPt2)-1)do
                        begin
                          label101.Caption := 'zI = ' + IntToStr(zI) + ' - zL = ' + IntToStr(zL) + 'zI2 = ' + IntToStr(zI2);
                          label101.Update;

                          if(pos(LowerCase('.'),LowerCase(zLinhaPt2[zI2])) > 0)then
                            begin
                              zInicio        := Pos(LowerCase(zNomeQuery),LowerCase(zLinhaPt2[zI2]));

                              if(zInicio > 0)then
                                begin
                                  zInicio        := zInicio + Length(zNomeQuery);
                                  zFim           := Pos('.',zLinhaPt2[zI2]) - zInicio;

                                  if((zFim - 1) <= 0)then
                                    Continue;

                                  zParteCopiada  := Copy(zLinhaPt2[zI2],zInicio,zFim);

                                  if(zLinhaPt2[zI2] = '')then
                                    Continue;

                                  zLinhaPt2[zI2] := StringReplace(zLinhaPt2[zI2],zParteCopiada+'.','.',[rfIgnoreCase]);
                                  zLinhaPt2[zI2] := StringReplace(zLinhaPt2[zI2],'.FieldByName('''')','',[rfIgnoreCase]);
                                  zLinhaPt2[zI2] := StringReplace(zLinhaPt2[zI2],'.','.FieldByName('''+zParteCopiada+''').',[rfIgnoreCase]);
                                end;
                            end;
                        end;

                      zLinhaPT[1] := Implode(zNomeSeparador, zLinhaPt2);
                    end;
                end
              else
                begin
                  label101.Caption := 'zI = ' + IntToStr(zI) + ' - zL = ' + IntToStr(zL) + 'zI2 = ' + IntToStr(zI2);
                  label101.Update;

                  if(pos(LowerCase('.'),LowerCase(zLinhaPT[1])) > 0)then
                    begin
                      zInicio        := Pos(LowerCase(zNomeQuery),LowerCase(zLinhaPT[1]));

                      if(zInicio > 0)then
                        begin
                          zInicio        := zInicio + Length(zNomeQuery);
                          zFim           := Pos('.',zLinhaPT[1]) - zInicio;

                          if((zFim - 1) <= 0)then
                            Continue;

                          zParteCopiada  := Copy(zLinhaPT[1] ,zInicio,zFim);

                          if(zLinhaPT[1]  = '')then
                            Continue;

                          zLinhaPT[1] := StringReplace(zLinhaPT[1] ,zParteCopiada+'.','.',[rfIgnoreCase]);
                          zLinhaPT[1] := StringReplace(zLinhaPT[1] ,'.FieldByName('''')','',[rfIgnoreCase]);
                          zLinhaPT[1] := StringReplace(zLinhaPT[1] ,'.','.FieldByName('''+zParteCopiada+''').',[rfIgnoreCase]);
                        end;
                    end;
                end;
            end;
        end;

      Memo1.Lines[zI] := Implode(':=',zLinhaPt);
    end;

  label101.Caption := '';
  label101.Update;
end;

//Explode igual o php
procedure TfAdm001.BitBtn1Click(Sender: TObject);
begin
  alteraCampos();
end;

function TfAdm001.Explode(const cSeparator, vString: String): TResultArray;
var
  i: Integer;
  S: String;
begin
  S := vString;
  SetLength(Result, 0);
  i := 0;

  while Pos(cSeparator, S) > 0 do
    begin
      SetLength(Result, Length(Result) +1);
      Result[i] := Copy(S, 1, Pos(cSeparator, S) -1);
      Inc(i);
      S := Copy(S, Pos(cSeparator, S) + Length(cSeparator), Length(S));
    end;

  SetLength(Result, Length(Result) +1);
  Result[i] := Copy(S, 1, Length(S));

end;

end.
