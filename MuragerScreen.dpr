program MuragerScreen;

uses
  Forms,
  uMain in 'uMain.pas' {frmGL},
  uSetting in 'uSetting.pas' {fmSetting};

{$E scr}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGL, frmGL);
  Application.CreateForm(TfmSetting, fmSetting);
  Application.Run;
end.

