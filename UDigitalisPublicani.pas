unit UDigitalisPublicani;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Objects, FMX.Edit,
  System.Actions, FMX.ActnList, FMX.ScrollBox, FMX.Memo, FMX.Clipboard,
  FMX.Platform;

type
  TFDigitalisPublicani = class(TForm)
    TabControl: TTabControl;
    TabCalc: TTabItem;
    TabAbout: TTabItem;
    GestureManager1: TGestureManager;
    Panel1: TPanel;
    Panel2: TPanel;
    btnI: TButton;
    btnV: TButton;
    btnL: TButton;
    btnX: TButton;
    btnC: TButton;
    btnD: TButton;
    btnM: TButton;
    btnNullis: TButton;
    bntPlus: TButton;
    btnMinus: TButton;
    btnMult: TButton;
    btnDiv: TButton;
    btnAeq: TButton;
    Text1: TText;
    editNum: TEdit;
    ActionList: TActionList;
    aTecI: TAction;
    aTecV: TAction;
    aTecX: TAction;
    aTecL: TAction;
    aTecC: TAction;
    aTecD: TAction;
    aTecM: TAction;
    aTecNull: TAction;
    aTecPlus: TAction;
    aTecMinus: TAction;
    aTecMulti: TAction;
    aTecDiv: TAction;
    aTecAequ: TAction;
    mResult: TMemo;
    lblNumArab: TLabel;
    aCalculus: TAction;
    btnOt: TButton;
    btnClear: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImageControl1: TImageControl;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure aTecIExecute(Sender: TObject);
    procedure aFuncAtivaTeclas(Sinais: Boolean);
    procedure ApagarTextoNoMemo(memo: TMemo);
    procedure aTecVExecute(Sender: TObject);
    procedure aTecXExecute(Sender: TObject);
    procedure aTecLExecute(Sender: TObject);
    procedure aTecMExecute(Sender: TObject);
    procedure aTecNullExecute(Sender: TObject);
    procedure aTecPlusExecute(Sender: TObject);
    procedure aTecMinusExecute(Sender: TObject);
    procedure aTecMultiExecute(Sender: TObject);
    procedure btnIClick(Sender: TObject);
    procedure btnVClick(Sender: TObject);
    procedure btnXClick(Sender: TObject);
    procedure btnLClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnDClick(Sender: TObject);
    procedure btnMClick(Sender: TObject);
    procedure btnNullisClick(Sender: TObject);
    procedure bntPlusClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure btnMultClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
    procedure btnAeqClick(Sender: TObject);
    procedure aTecCExecute(Sender: TObject);
    procedure aTecDExecute(Sender: TObject);
    procedure aTecAequExecute(Sender: TObject);
    procedure aCalculusExecute(Sender: TObject);
    procedure aTecDivExecute(Sender: TObject);
    procedure editNumChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mResultClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    var
      iCalc, iNumber, tipo: Integer;

    { Public declarations }
  end;

var
  FDigitalisPublicani: TFDigitalisPublicani;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone47in.fmx IOS}

procedure TFDigitalisPublicani.ApagarTextoNoMemo(memo: TMemo);
var
  texto: string;
  i: Integer;
begin
  texto := memo.Text;
  i := Length(texto);

  while (i > 0) and (texto[i] <> ' ') do
    Dec(i);

  if i > 0 then
  begin
    texto := Copy(texto, 1, i - 1);
    memo.Text := texto;
  end
  else
    memo.Lines.Clear;
end;

function IntToRoman(Number: Integer): string;
const
  RomanNumerals: array[1..13] of string = ('I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M');
  ArabicValues: array[1..13] of Integer = (1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000);
var
  Index: Integer;
begin
  Result := '';
  for Index := High(RomanNumerals) downto Low(RomanNumerals) do
  begin
    while Number >= ArabicValues[Index] do
    begin
      Result := Result + RomanNumerals[Index];
      Number := Number - ArabicValues[Index];
    end;
  end;
end;

procedure TFDigitalisPublicani.aCalculusExecute(Sender: TObject);
begin
  if tipo = 0 then // - minus
  begin
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iNumber) + ' minus ';
  end
  else if tipo = 1 then // + plus
  begin
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iNumber) + ' plus ';
  end
  else if tipo = 2 then // * Multi
  begin
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iNumber) + ' multi ';
  end
  else if tipo = 3 then // DIV
  begin
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iNumber) + ' div ';
  end;

  if iCalc = 0 then
  begin
    iCalc := iNumber;
    iNumber := 0;
  end;

  editNum.Text := '';
end;

procedure TFDigitalisPublicani.aFuncAtivaTeclas(Sinais: Boolean);
begin
  if Sinais = False then
  begin
    bntPlus.Enabled := False;
    btnMult.Enabled := False;
    btnMinus.Enabled := False;
    btnDiv.Enabled := False;
    btnAeq.Enabled := False;
  end
  else
  begin
    bntPlus.Enabled := True;
    btnMult.Enabled := True;
    btnMinus.Enabled := True;
    btnDiv.Enabled := True;
  end;

  btnAeq.Enabled := True;
  btnI.Enabled := True;
  btnV.Enabled := True;
  btnL.Enabled := True;
  btnX.Enabled := True;
  btnC.Enabled := True;
  btnD.Enabled := True;
  btnM.Enabled := True;
end;

procedure TFDigitalisPublicani.aTecAequExecute(Sender: TObject);
begin
  if tipo = 0 then // - minus
  begin
    iCalc := iCalc - iNumber;
  end
  else if tipo = 1 then // + plus
  begin
    iCalc := iCalc + iNumber;
  end
  else if tipo = 2 then // * Multi
  begin
    iCalc := iCalc * iNumber;
  end
  else if tipo = 3 then // DIV
  begin
    iCalc := iCalc div iNumber;
  end;

  mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iNumber) + ' Aequalis: ';
  if iCalc < 0 then
  begin
    iCalc := iCalc * - 1;
    mResult.Lines.Text := mResult.Lines.Text + ' negans ';
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iCalc) + sLineBreak;
    iCalc := iCalc * - 1;
  end
  else
    mResult.Lines.Text := mResult.Lines.Text + IntToRoman(iCalc) + sLineBreak;

  editNum.Text := '';
  iNumber := 0;
  lblNumArab.Text := IntToStr(iCalc);
  aFuncAtivaTeclas(true);
  btnAeq.Enabled := False;
  btnI.Enabled := False;
  btnV.Enabled := False;
  btnL.Enabled := False;
  btnX.Enabled := False;
  btnC.Enabled := False;
  btnD.Enabled := False;
  btnM.Enabled := False;
  editNum.SetFocus;
end;

procedure TFDigitalisPublicani.aTecCExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 100;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecDExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 500;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecDivExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(false);
  tipo := 3;
  aCalculus.Execute();
end;

procedure TFDigitalisPublicani.aTecIExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 1;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecLExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 50;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecMExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 1000;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecMinusExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(false);
  tipo := 0;
  aCalculus.Execute();
end;

procedure TFDigitalisPublicani.aTecMultiExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(false);
  tipo := 2;
  aCalculus.Execute();
end;

procedure TFDigitalisPublicani.aTecNullExecute(Sender: TObject);
begin
  mResult.Lines.Clear;
  editNum.Text := '';
  aFuncAtivaTeclas(false);
  iNumber := 0;

  editNum.SetFocus;
  lblNumArab.Text := '0000';
end;

procedure TFDigitalisPublicani.aTecPlusExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(false);
  tipo := 1;
  aCalculus.Execute();
end;

procedure TFDigitalisPublicani.aTecVExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 5;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.aTecXExecute(Sender: TObject);
begin
  aFuncAtivaTeclas(true);
  iNumber := iNumber + 10;
  lblNumArab.Text := IntToStr(iNumber);
  editNum.Text := IntToRoman(iNumber);

  if (iCalc <> 0) and (iNumber <> 0) then
    btnAeq.Enabled := True
  else
    btnAeq.Enabled := False;
end;

procedure TFDigitalisPublicani.bntPlusClick(Sender: TObject);
begin
  aTecPlus.Execute();
end;

procedure TFDigitalisPublicani.btnAeqClick(Sender: TObject);
begin
  aTecAequ.Execute();
end;

procedure TFDigitalisPublicani.btnCClick(Sender: TObject);
begin
  aTecC.Execute();
end;

procedure TFDigitalisPublicani.btnClearClick(Sender: TObject);
begin
  editNum.Text := '';
  iNumber := 0;
  lblNumArab.Text := '0000';
end;

procedure TFDigitalisPublicani.btnDClick(Sender: TObject);
begin
  aTecD.Execute();
end;

procedure TFDigitalisPublicani.btnDivClick(Sender: TObject);
begin
  aTecDiv.Execute();
end;

procedure TFDigitalisPublicani.btnIClick(Sender: TObject);
begin
  aTecI.Execute();
end;

procedure TFDigitalisPublicani.btnLClick(Sender: TObject);
begin
  aTecL.Execute();
end;

procedure TFDigitalisPublicani.btnMClick(Sender: TObject);
begin
  aTecM.Execute();
end;

procedure TFDigitalisPublicani.btnMinusClick(Sender: TObject);
begin
  aTecMinus.Execute();
end;

procedure TFDigitalisPublicani.btnMultClick(Sender: TObject);
begin
  aTecMulti.Execute();
end;

procedure TFDigitalisPublicani.btnNullisClick(Sender: TObject);
begin
  aTecNull.Execute();
end;

procedure TFDigitalisPublicani.btnVClick(Sender: TObject);
begin
  aTecV.Execute();
end;

procedure TFDigitalisPublicani.btnXClick(Sender: TObject);
begin
  aTecX.Execute();
end;

procedure TFDigitalisPublicani.editNumChange(Sender: TObject);
const
  AllowedChars =['I', 'V', 'X', 'L', 'C', 'D', 'M']; // Caracteres permitidos
var
  EditText: string;
  CharIndex: Integer;
begin
  EditText := editNum.Text;

  // Verifica cada caractere no texto
  for CharIndex := Length(EditText) downto 1 do
  begin
    // Se o caractere não estiver na lista de caracteres permitidos, remova-o
    if not (EditText[CharIndex] in AllowedChars) then
      Delete(EditText, CharIndex, 1);
  end;

  // Atualiza o texto no TEdit
  editNum.Text := EditText;
end;

procedure TFDigitalisPublicani.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl.ActiveTab := TabCalc;
end;

procedure TFDigitalisPublicani.FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
        Handled := True;
      end;
  end;
{$ENDIF}
end;

procedure TFDigitalisPublicani.FormShow(Sender: TObject);
begin
  aFuncAtivaTeclas(false);
  editNum.SetFocus;
end;

procedure TFDigitalisPublicani.mResultClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipboardService) then
  begin
    ClipboardService.SetClipboard(mResult.Lines.Text);
    ShowMessage('Contentus copied ut clipboard.');
  end;
end;

end.

