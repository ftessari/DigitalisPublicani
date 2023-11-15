program DigitalisPublicani;

uses
  System.StartUpCopy,
  FMX.Forms,
  UDigitalisPublicani in 'UDigitalisPublicani.pas' {FDigitalisPublicani};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFDigitalisPublicani, FDigitalisPublicani);
  Application.Run;
end.
