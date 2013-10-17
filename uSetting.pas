unit uSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, Buttons, XPMan, ExtCtrls, ImgList,
  jpeg, ShellApi;

const
  TitleT = 'Нажмите S для вызова настроек';
  Size = 8;

type
  TfmSetting = class(TForm)
    PageControl1: TPageControl;
    tsTitles: TTabSheet;
    bbOk: TBitBtn;
    PageControl2: TPageControl;
    tsLT: TTabSheet;
    tsRT: TTabSheet;
    tsRB: TTabSheet;
    tsLB: TTabSheet;
    XPManifest1: TXPManifest;
    GroupBox3: TGroupBox;
    gbLTTitle: TGroupBox;
    edLTTitle: TEdit;
    gbLTPlace: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    seLTX: TSpinEdit;
    seLTY: TSpinEdit;
    cbLTShow: TCheckBox;
    sbClearLTTitle: TSpeedButton;
    sbLTTitleS: TSpeedButton;
    sbLTXS: TSpeedButton;
    sbLTYS: TSpeedButton;
    ImageList1: TImageList;
    rbLTTitle: TRadioButton;
    rbLTTime: TRadioButton;
    rbLTDate: TRadioButton;
    bLTAllS: TButton;
    Label7: TLabel;
    seLTSize: TSpinEdit;
    seLTSizeS: TSpeedButton;
    Label8: TLabel;
    seLTColor: TSpeedButton;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    gbRTTitle: TGroupBox;
    sbClearRTTitle: TSpeedButton;
    sbRTTitleS: TSpeedButton;
    rbRTTitle: TRadioButton;
    edRTTitle: TEdit;
    rbRTTime: TRadioButton;
    rbRTDate: TRadioButton;
    gbRTPlace: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Bevel2: TBevel;
    sbRTXS: TSpeedButton;
    sbRTYS: TSpeedButton;
    Label15: TLabel;
    seRTSizeS: TSpeedButton;
    Label16: TLabel;
    SpeedButton6: TSpeedButton;
    seRTSize: TSpinEdit;
    cbRTShow: TCheckBox;
    bRTAllS: TButton;
    seRTX: TSpinEdit;
    seRTY: TSpinEdit;
    GroupBox2: TGroupBox;
    gbRBTitle: TGroupBox;
    sbClearRBTitle: TSpeedButton;
    sbRBTitleS: TSpeedButton;
    rbRBTitle: TRadioButton;
    edRBTitle: TEdit;
    rbRBTime: TRadioButton;
    rbRBDate: TRadioButton;
    gbRBPlace: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Bevel3: TBevel;
    sbRBXS: TSpeedButton;
    sbRBYS: TSpeedButton;
    Label23: TLabel;
    seRBSizeS: TSpeedButton;
    Label24: TLabel;
    SpeedButton7: TSpeedButton;
    seRBSize: TSpinEdit;
    cbRBShow: TCheckBox;
    bRBAllS: TButton;
    seRBX: TSpinEdit;
    seRBY: TSpinEdit;
    tsC: TTabSheet;
    GroupBox4: TGroupBox;
    gbLBTitle: TGroupBox;
    sbClearLBTitle: TSpeedButton;
    sbLBTitleS: TSpeedButton;
    rbLBTitle: TRadioButton;
    edLBTitle: TEdit;
    rbLBTime: TRadioButton;
    rbLBDate: TRadioButton;
    gbLBPlace: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Bevel4: TBevel;
    sbLBXS: TSpeedButton;
    sbLBYS: TSpeedButton;
    Label31: TLabel;
    seLBSizeS: TSpeedButton;
    Label32: TLabel;
    SpeedButton8: TSpeedButton;
    seLBSize: TSpinEdit;
    cbLBShow: TCheckBox;
    seLBX: TSpinEdit;
    seLBY: TSpinEdit;
    bLBAllS: TButton;
    GroupBox5: TGroupBox;
    gbCTitle: TGroupBox;
    sbClearCTitle: TSpeedButton;
    sbCTitleS: TSpeedButton;
    rbCTitle: TRadioButton;
    edCTitle: TEdit;
    rbCTime: TRadioButton;
    rbCDate: TRadioButton;
    gbCPlace: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Bevel5: TBevel;
    sbCXS: TSpeedButton;
    sbCYS: TSpeedButton;
    Label39: TLabel;
    seCSizeS: TSpeedButton;
    Label40: TLabel;
    SpeedButton9: TSpeedButton;
    seCSize: TSpinEdit;
    seCX: TSpinEdit;
    seCY: TSpinEdit;
    cbCShow: TCheckBox;
    bCAllS: TButton;
    rbCTitleOfA: TRadioButton;
    Image1: TImage;
    Label41: TLabel;
    Label42: TLabel;
    lbAuthor: TLabel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Bevel8: TBevel;
    Label47: TLabel;
    procedure seLTXChange(Sender: TObject);
    procedure seLTYChange(Sender: TObject);
    procedure seRTXChange(Sender: TObject);
    procedure seRTYChange(Sender: TObject);
    procedure seLBXChange(Sender: TObject);
    procedure seLBYChange(Sender: TObject);
    procedure seRBXChange(Sender: TObject);
    procedure seRBYChange(Sender: TObject);
    procedure sbClearLTTitleClick(Sender: TObject);
    procedure cbLTShowClick(Sender: TObject);
    procedure rbLTTitleClick(Sender: TObject);
    procedure rbLTTimeClick(Sender: TObject);
    procedure rbLTDateClick(Sender: TObject);
    procedure sbLTTitleSClick(Sender: TObject);
    procedure sbLTXSClick(Sender: TObject);
    procedure sbLTYSClick(Sender: TObject);
    procedure bLTAllSClick(Sender: TObject);
    procedure seLTSizeChange(Sender: TObject);
    procedure seLTSizeSClick(Sender: TObject);
    procedure cbRTShowClick(Sender: TObject);
    procedure rbRTTitleClick(Sender: TObject);
    procedure rbRTTimeClick(Sender: TObject);
    procedure rbRTDateClick(Sender: TObject);
    procedure seRTSizeChange(Sender: TObject);
    procedure sbClearRTTitleClick(Sender: TObject);
    procedure sbRTTitleSClick(Sender: TObject);
    procedure sbRTXSClick(Sender: TObject);
    procedure sbRTYSClick(Sender: TObject);
    procedure seRTSizeSClick(Sender: TObject);
    procedure bRTAllSClick(Sender: TObject);
    procedure cbRBShowClick(Sender: TObject);
    procedure rbRBTitleClick(Sender: TObject);
    procedure sbClearRBTitleClick(Sender: TObject);
    procedure sbRBTitleSClick(Sender: TObject);
    procedure rbRBTimeClick(Sender: TObject);
    procedure rbRBDateClick(Sender: TObject);
    procedure sbRBXSClick(Sender: TObject);
    procedure sbRBYSClick(Sender: TObject);
    procedure seRBSizeSClick(Sender: TObject);
    procedure seRBSizeChange(Sender: TObject);
    procedure bRBAllSClick(Sender: TObject);
    procedure cbLBShowClick(Sender: TObject);
    procedure rbLBTimeClick(Sender: TObject);
    procedure rbLBDateClick(Sender: TObject);
    procedure sbClearLBTitleClick(Sender: TObject);
    procedure sbLBTitleSClick(Sender: TObject);
    procedure sbLBXSClick(Sender: TObject);
    procedure sbLBYSClick(Sender: TObject);
    procedure seLBSizeChange(Sender: TObject);
    procedure seLBSizeSClick(Sender: TObject);
    procedure bLBAllSClick(Sender: TObject);
    procedure rbLBTitleClick(Sender: TObject);
    procedure seCXChange(Sender: TObject);
    procedure seCYChange(Sender: TObject);
    procedure cbCShowClick(Sender: TObject);
    procedure rbCTitleClick(Sender: TObject);
    procedure sbClearCTitleClick(Sender: TObject);
    procedure sbCTitleSClick(Sender: TObject);
    procedure rbCTimeClick(Sender: TObject);
    procedure rbCDateClick(Sender: TObject);
    procedure sbCXSClick(Sender: TObject);
    procedure sbCYSClick(Sender: TObject);
    procedure seCSizeChange(Sender: TObject);
    procedure seCSizeSClick(Sender: TObject);
    procedure bCAllSClick(Sender: TObject);
    procedure rbCTitleOfAClick(Sender: TObject);
    procedure lbAuthorMouseEnter(Sender: TObject);
    procedure lbAuthorMouseLeave(Sender: TObject);
    procedure lbAuthorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSetting: TfmSetting;

implementation

uses uMain;

{$R *.dfm}

procedure TfmSetting.seLTXChange(Sender: TObject);
begin
  frmGL.LTX := seLTX.Value / 100 - 1.3;
end;

procedure TfmSetting.seLTYChange(Sender: TObject);
begin
  frmGL.LTY := seLTY.Value / 100 + 0.9;
end;

procedure TfmSetting.seRTXChange(Sender: TObject);
begin
  frmGL.RTX := seRTX.Value / 100 + 0.91;
end;

procedure TfmSetting.seRTYChange(Sender: TObject);
begin
  frmGL.RTY := seRTY.Value / 100 + 0.9;
end;

procedure TfmSetting.seLBXChange(Sender: TObject);
begin
  frmGL.LBX := seLBX.Value / 100 - 1.3;
end;

procedure TfmSetting.seLBYChange(Sender: TObject);
begin
  frmGL.LBY := seLBY.Value / 100 - 0.96;
end;

procedure TfmSetting.seRBXChange(Sender: TObject);
begin
  frmGL.RBX := seRBX.Value / 100 + 0.8;
end;

procedure TfmSetting.seRBYChange(Sender: TObject);
begin
  frmGL.RBY := seRBY.Value / 100 - 0.96;
end;

procedure TfmSetting.seLTSizeChange(Sender: TObject);
begin
  frmGL.LTS := seLTSize.Value / 100;
end;

procedure TfmSetting.sbClearLTTitleClick(Sender: TObject);
{Очищает текст левый верхний}
begin
  edLTTitle.Text := '';
end;

procedure TfmSetting.cbLTShowClick(Sender: TObject);
begin
  gbLTTitle.Enabled := cbLtShow.Checked;
  gbLTPlace.Enabled := cbLtShow.Checked;
end;

procedure TfmSetting.rbLTTitleClick(Sender: TObject);
begin
  edLTTitle.Enabled := True;
  sbClearLTTitle.Enabled := True;
  sbLTTitleS.Enabled := True;
end;

procedure TfmSetting.rbLTTimeClick(Sender: TObject);
begin
  edLTTitle.Enabled := False;
  sbClearLTTitle.Enabled := False;
  sbLTTitleS.Enabled := False;
end;

procedure TfmSetting.rbLTDateClick(Sender: TObject);
begin
  edLTTitle.Enabled := False;
  sbClearLTTitle.Enabled := False;
  sbLTTitleS.Enabled := False;
end;

procedure TfmSetting.sbLTTitleSClick(Sender: TObject);
begin
  edLTTitle.Text := TitleT;
end;

procedure TfmSetting.sbLTXSClick(Sender: TObject);
begin
  seLTX.Value := 0;
end;

procedure TfmSetting.sbLTYSClick(Sender: TObject);
begin
  seLTY.Value := 0;
end;

procedure TfmSetting.bLTAllSClick(Sender: TObject);
begin
  cbLTShow.Checked := True;
  rbLTTitle.Checked := True;
  edLTTitle.Text := TitleT;
  seLTX.Value := 0;
  seLTY.Value := 0;
  seLTSize.Value := Size;
end;

procedure TfmSetting.seLTSizeSClick(Sender: TObject);
begin
  seLTSize.Value := Size;
end;

procedure TfmSetting.cbRTShowClick(Sender: TObject);
begin
  gbRTTitle.Enabled := cbRtShow.Checked;
  gbRTPlace.Enabled := cbRtShow.Checked;
end;

procedure TfmSetting.rbRTTitleClick(Sender: TObject);
begin
  edRTTitle.Enabled := True;
  sbClearRTTitle.Enabled := True;
  sbRTTitleS.Enabled := True;
end;

procedure TfmSetting.rbRTTimeClick(Sender: TObject);
begin
  edRTTitle.Enabled := False;
  sbClearRTTitle.Enabled := False;
  sbRTTitleS.Enabled := False;
end;

procedure TfmSetting.rbRTDateClick(Sender: TObject);
begin
  edRTTitle.Enabled := False;
  sbClearRTTitle.Enabled := False;
  sbRTTitleS.Enabled := False;
end;

procedure TfmSetting.seRTSizeChange(Sender: TObject);
begin
  frmGL.RTS := seRTSize.Value / 100;
end;

procedure TfmSetting.sbClearRTTitleClick(Sender: TObject);
begin
  edRTTitle.Text := '';
end;

procedure TfmSetting.sbRTTitleSClick(Sender: TObject);
begin
  edRTTitle.Text := TitleT;
end;

procedure TfmSetting.sbRTXSClick(Sender: TObject);
begin
  seRTX.Value := 0;
end;

procedure TfmSetting.sbRTYSClick(Sender: TObject);
begin
  seRTY.Value := 0;
end;

procedure TfmSetting.seRTSizeSClick(Sender: TObject);
begin
   seRTSize.Value := Size;
end;

procedure TfmSetting.bRTAllSClick(Sender: TObject);
begin
  cbRTShow.Checked := True;
  rbRTDate.Checked := True;
  edRTTitle.Text := TitleT;
  seRTX.Value := 0;
  seRTY.Value := 0;
  seRTSize.Value := Size;
end;

procedure TfmSetting.cbRBShowClick(Sender: TObject);
begin
  gbRBTitle.Enabled := cbRBShow.Checked;
  gbRBPlace.Enabled := cbRBShow.Checked;
end;

procedure TfmSetting.rbRBTitleClick(Sender: TObject);
begin
  edRBTitle.Enabled := True;
  sbClearRBTitle.Enabled := True;
  sbRBTitleS.Enabled := True;
end;

procedure TfmSetting.sbClearRBTitleClick(Sender: TObject);
begin
  edRBTitle.Text := '';
end;

procedure TfmSetting.sbRBTitleSClick(Sender: TObject);
begin
  edRBTitle.Text := 'karataevevgeniy@mail.ru';
end;

procedure TfmSetting.rbRBTimeClick(Sender: TObject);
begin
  edRBTitle.Enabled := False;
  sbClearRBTitle.Enabled := False;
  sbRBTitleS.Enabled := False;
end;

procedure TfmSetting.rbRBDateClick(Sender: TObject);
begin
  edRBTitle.Enabled := False;
  sbClearRBTitle.Enabled := False;
  sbRBTitleS.Enabled := False;
end;

procedure TfmSetting.sbRBXSClick(Sender: TObject);
begin
  seRBX.Value := 0;
end;

procedure TfmSetting.sbRBYSClick(Sender: TObject);
begin
  seRBY.Value := 0;
end;

procedure TfmSetting.seRBSizeSClick(Sender: TObject);
begin
  seRBSize.Value := Size;
end;

procedure TfmSetting.seRBSizeChange(Sender: TObject);
begin
  frmGL.RBS := seRBSize.Value / 100;
end;

procedure TfmSetting.bRBAllSClick(Sender: TObject);
begin
  cbRBShow.Checked := True;
  rbRBTitle.Checked := True;
  edRBTitle.Text := 'karataevevgeniy@mail.ru';
  seRBX.Value := 0;
  seRBY.Value := 0;
  seRBSize.Value := Size - 3;
end;

procedure TfmSetting.cbLBShowClick(Sender: TObject);
begin
  gbLBTitle.Enabled := cbLBShow.Checked;
  gbLBPlace.Enabled := cbLBShow.Checked;
end;

procedure TfmSetting.rbLBTimeClick(Sender: TObject);
begin
  edLBTitle.Enabled := False;
  sbClearLBTitle.Enabled := False;
  sbLBTitleS.Enabled := False;
end;

procedure TfmSetting.rbLBDateClick(Sender: TObject);
begin
  edLBTitle.Enabled := False;
  sbClearLBTitle.Enabled := False;
  sbLBTitleS.Enabled := False;
end;

procedure TfmSetting.rbLBTitleClick(Sender: TObject);
begin
  edLBTitle.Enabled := True;
  sbClearLBTitle.Enabled := True;
  sbLBTitleS.Enabled := True;
end;

procedure TfmSetting.sbClearLBTitleClick(Sender: TObject);
begin
  edLBTitle.Text := '';
end;

procedure TfmSetting.sbLBTitleSClick(Sender: TObject);
begin
  edLBTitle.Text := 'karataevevgeniy@mail.ru';
end;

procedure TfmSetting.sbLBXSClick(Sender: TObject);
begin
  seLBX.Value := 0;
end;

procedure TfmSetting.sbLBYSClick(Sender: TObject);
begin
  seLBY.Value := 0;
end;

procedure TfmSetting.seLBSizeChange(Sender: TObject);
begin
  frmGL.LBS := seLBSize.Value / 100;
end;

procedure TfmSetting.seLBSizeSClick(Sender: TObject);
begin
  seLBSize.Value := Size - 3;
end;

procedure TfmSetting.bLBAllSClick(Sender: TObject);
begin
  cbLBShow.Checked := True;
  rbLBTitle.Checked := True;
  edLBTitle.Text := 'karataevevgeniy@mail.ru';
  seLBX.Value := 0;
  seLBY.Value := 0;
  seLBSize.Value := Size - 3;
end;

procedure TfmSetting.seCXChange(Sender: TObject);
begin
  frmGL.CX := seCX.Value / 100 - 0.45;
end;

procedure TfmSetting.seCYChange(Sender: TObject);
begin
  frmGL.CY := seCY.Value / 100 - 0.4;
end;

procedure TfmSetting.cbCShowClick(Sender: TObject);
begin
  gbCTitle.Enabled := cbCShow.Checked;
  gbCPlace.Enabled := cbCShow.Checked;
end;

procedure TfmSetting.rbCTitleClick(Sender: TObject);
begin
  edCTitle.Enabled := True;
  sbClearCTitle.Enabled := True;
  sbCTitleS.Enabled := True;
  gbCPlace.Enabled := True;
end;

procedure TfmSetting.sbClearCTitleClick(Sender: TObject);
begin
  edCTitle.Text := '';
end;

procedure TfmSetting.sbCTitleSClick(Sender: TObject);
begin
  edCTitle.Text := 'www.murager.karaganda.kz';
end;

procedure TfmSetting.rbCTimeClick(Sender: TObject);
begin
  edCTitle.Enabled := False;
  sbClearCTitle.Enabled := False;
  sbCTitleS.Enabled := False;
  gbCPlace.Enabled := True;
end;

procedure TfmSetting.rbCDateClick(Sender: TObject);
begin
  edCTitle.Enabled := False;
  sbClearCTitle.Enabled := False;
  sbCTitleS.Enabled := False;
  gbCPlace.Enabled := True;
end;

procedure TfmSetting.sbCXSClick(Sender: TObject);
begin
  seCX.Value := 0;
end;

procedure TfmSetting.sbCYSClick(Sender: TObject);
begin
  seCY.Value := 0;
end;

procedure TfmSetting.seCSizeChange(Sender: TObject);
begin
  frmGL.CS := seCSize.Value / 100;
end;

procedure TfmSetting.seCSizeSClick(Sender: TObject);
begin
  seCSize.Value := Size + 1;
end;

procedure TfmSetting.bCAllSClick(Sender: TObject);
begin
  cbCShow.Checked := True;
  rbCTitle.Checked := True;
  edCTitle.Text := 'www.murager.karaganda.kz';
  seCX.Value := 0;
  seCY.Value := 0;
  seCSize.Value := Size + 1;
end;

procedure TfmSetting.rbCTitleOfAClick(Sender: TObject);
begin
  edCTitle.Enabled := False;
  sbClearCTitle.Enabled := False;
  sbCTitleS.Enabled := False;
  gbCPlace.Enabled := False;
end;

procedure TfmSetting.lbAuthorMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
end;

procedure TfmSetting.lbAuthorMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clWindowText;
end;

procedure TfmSetting.lbAuthorClick(Sender: TObject);
begin
  ShellExecute(Self.Handle, 'open', PChar(Format('mailto:karataevevgeniy@mail.ru?Subject="%s"', ['Clock'])), nil, nil, SW_SHOW);
end;

end.
