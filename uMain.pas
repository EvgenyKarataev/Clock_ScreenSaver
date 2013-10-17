unit uMain;

interface

uses
 Windows, Messages, Classes, Graphics, Forms, ExtCtrls, Menus,
 Controls, Dialogs, SysUtils, OpenGL, IniFiles;

const
  Size = 8;

type
  TfrmGL = class(TForm)
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);

  private
    DC : HDC;
    hrc : HGLRC;

    Mous: TPoint;
    nHour, nMin, nSec, nMSec: Word;

    procedure Clock;

    procedure InitializeRC;
    procedure SetDCPixelFormat;
    procedure Writing;
  public
    LTX, LTY, RTX, RTY, LBX, LBY, RBX, RBY, CX, CY: real;  //координаты надписей
    LTS, RTS, RBS, LBS, CS: real;                //размеры надписей
  end;

const
  GLF_START_LIST = 1000;

  cAngHour = 360 / 12;
  cAngMinSec = 360 / 60;

var
  frmGL: TfrmGL;

implementation

uses uSetting;

{$R *.DFM}

{=======================================================================
Вывод текста}
procedure OutText (Litera : PChar; ScaleF: Single);
begin
  glPushMatrix;
    glListBase(GLF_START_LIST);
    glScalef(ScaleF, ScaleF, ScaleF);
    glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
  glPopMatrix;
end;

{=======================================================================
Процедура инициализации источника цвета}
procedure TfrmGL.InitializeRC;
begin
  glEnable(GL_DEPTH_TEST);// разрешаем тест глубины
  glEnable(GL_LIGHTING);  // разрешаем работу с освещенностью
  glEnable(GL_LIGHT0);    // включаем источник света 0
end;

{=======================================================================
Рисование картинки}
procedure TfrmGL.FormPaint(Sender: TObject);
begin
 glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Clock;

  glLineWidth(4);
  glRotatef(-cAngHour * (nHour + (nMin + nSec / 60) /60), 0.0, 0.0, 1.0);       // Hour
  glBegin(GL_LINES);
    glVertex2f(0, -0.02);
    glVertex2f(0, 0.35);
  glEnd;
  glRotatef(cAngHour * (nHour + (nMin + nSec / 60) /60), 0.0, 0.0, 1.0);       // Hour


  glLineWidth(2.5);
  glRotatef(-6 * (nMin + nSec / 60), 0.0, 0.0, 1.0);       // Min
  glBegin(GL_LINES);
    glVertex2f(0, -0.03);
    glVertex2f(0, 0.55);
  glEnd;
  glRotatef(6 * (nMin + nSec / 60), 0.0, 0.0, 1.0);       // Min


  glLineWidth(0.5);
  glRotatef(-6 * nSec, 0.0, 0.0, 1.0);       // Sec
  glBegin(GL_LINES);
    glVertex2f(0, -0.035);
    glVertex2f(0, 0.64);
  glEnd;
  glRotatef(6 * nSec, 0.0, 0.0, 1.0);       // Sec

 SwapBuffers(DC);
end;

{=======================================================================
Установка формата пикселей}
procedure TfrmGL.SetDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);

  With pfd do begin
    dwFlags   := PFD_DRAW_TO_WINDOW or
                 PFD_SUPPORT_OPENGL or
                 PFD_DOUBLEBUFFER;
    cDepthBits:= 32;
  end;

  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);
end;

{=======================================================================
Создание окна}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC(Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.3, 0.4, 0.6, 1.0);
  wglUseFontOutlines (Canvas.Handle, 0, 256, GLF_START_LIST, 50, 0.15,
                      WGL_FONT_POLYGONS, nil);
  InitializeRC;

  Self.WindowState := wsMaximized;

  ShowCursor(False);  //Убивает курсор
  Mous.X := -1;
  Mous.Y := 0;

  Timer.Enabled := True;
end;

procedure TfrmGL.FormShow(Sender: TObject);
var
  Path: string;
  i: Integer;
  Ini: TIniFile;
begin
  if ParamCount>0 then
  begin
    if ParamStr(1)='/p' then
    begin
      Close;
      exit;
    end;
    if ParamStr(1)[2]='c' then
    begin
      ShowCursor(True);  //Убивает курсор
      Application.MessageBox('Окно настроек доступно в режиме просмотра заставки.'+ #13#10 + '            Для вызова настроек нажмите S', 'Внимaние!', mb_IconExclamation + mb_Ok);
      ShowCursor(False);  //Убивает курсор
      Close;
      exit;
    end;
  end;


  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Setting.ini';

  try
    Ini := TIniFile.Create(Path);

    fmSetting.cbLTShow.Checked := Ini.ReadBool('LT', 'cbLTShow', True);
    fmSetting.rbLTTitle.Checked := Ini.ReadBool('LT', 'rbLTTitle', True);
    fmSetting.rbLTTime.Checked := Ini.ReadBool('LT', 'rbLTTime', False);
    fmSetting.rbLTDate.Checked := Ini.ReadBool('LT', 'rbLTDate', False);
    fmSetting.edLTTitle.Text := Ini.ReadString('LT', 'edLTTitle', 'Нажмите S для вызова настроек');
    fmSetting.seLTX.Value := Ini.ReadInteger('LT', 'seLTX', 0);
    fmSetting.seLTY.Value := Ini.ReadInteger('LT', 'seLTY', 0);
    fmSetting.seLTSize.Value := Ini.ReadInteger('LT', 'seLTSize', Size);

    LTX := fmSetting.seLTX.Value / 100 - 1.3;
    LTY := fmSetting.seLTY.Value / 100 + 0.9;
    LTS := fmSetting.seLTSize.Value / 100;

    fmSetting.cbRTShow.Checked := Ini.ReadBool('RT', 'cbRTShow', True);
    fmSetting.rbRTTitle.Checked := Ini.ReadBool('RT', 'rbRTTitle', False);
    fmSetting.rbRTTime.Checked := Ini.ReadBool('RT', 'rbRTTime', False);
    fmSetting.rbRTDate.Checked := Ini.ReadBool('RT', 'rbRTDate', True);
    fmSetting.edRTTitle.Text := Ini.ReadString('RT', 'edRTTitle', 'Нажмите S для вызова настроек');
    fmSetting.seRTX.Value := Ini.ReadInteger('RT', 'seRTX', 0);
    fmSetting.seRTY.Value := Ini.ReadInteger('RT', 'seRTY', 0);
    fmSetting.seRTSize.Value := Ini.ReadInteger('RT', 'seRTSize', Size);

    RTX := fmSetting.seRTX.Value / 100 + 0.91;
    RTY := fmSetting.seRTY.Value / 100 + 0.9;
    RTS := fmSetting.seRTSize.Value / 100;

    fmSetting.cbRBShow.Checked := Ini.ReadBool('RB', 'cbRBShow', True);
    fmSetting.rbRBTitle.Checked := Ini.ReadBool('RB', 'rbRBTitle', True);
    fmSetting.rbRBTime.Checked := Ini.ReadBool('RB', 'rbRBTime', False);
    fmSetting.rbRBDate.Checked := Ini.ReadBool('RB', 'rbRBDate', False);
    fmSetting.edRBTitle.Text := Ini.ReadString('RB', 'edRBTitle', 'karataevevgeniy@mail.ru');
    fmSetting.seRBX.Value := Ini.ReadInteger('RB', 'seRBX', 0);
    fmSetting.seRBY.Value := Ini.ReadInteger('RB', 'seRBY', 0);
    fmSetting.seRBSize.Value := Ini.ReadInteger('RB', 'seRBSize', Size - 3);

    RBX := fmSetting.seRBX.Value / 100 + 0.8;
    RBY := fmSetting.seRBY.Value / 100 - 0.96;
    RBS := fmSetting.seRBSize.Value / 100;

    fmSetting.cbLBShow.Checked := Ini.ReadBool('LB', 'cbLBShow', True);
    fmSetting.rbLBTitle.Checked := Ini.ReadBool('LB', 'rbLBTitle', True);
    fmSetting.rbLBTime.Checked := Ini.ReadBool('LB', 'rbLBTime', False);
    fmSetting.rbLBDate.Checked := Ini.ReadBool('LB', 'rbLBDate', False);
    fmSetting.edLBTitle.Text := Ini.ReadString('LB', 'edLBTitle', 'karataevevgeniy@mail.ru');
    fmSetting.seLBX.Value := Ini.ReadInteger('LB', 'seLBX', 0);
    fmSetting.seLBY.Value := Ini.ReadInteger('LB', 'seLBY', 0);
    fmSetting.seLBSize.Value := Ini.ReadInteger('LB', 'seLBSize', Size - 3);

    LBX := fmSetting.seLBX.Value / 100 - 1.3;
    LBY := fmSetting.seLBY.Value / 100 - 0.96;
    LBS := fmSetting.seLBSize.Value / 100;

    fmSetting.cbCShow.Checked := Ini.ReadBool('C', 'cbCShow', True);
    fmSetting.rbCTitle.Checked := Ini.ReadBool('C', 'rbCTitle', True);
    fmSetting.rbCTime.Checked := Ini.ReadBool('C', 'rbCTime', False);
    fmSetting.rbCDate.Checked := Ini.ReadBool('C', 'rbCDate', False);
    fmSetting.rbCTitleOfA.Checked := Ini.ReadBool('C', 'rbCTitleOfA', False);
    fmSetting.edCTitle.Text := Ini.ReadString('C', 'edCTitle', 'www.murager.karaganda.kz');
    fmSetting.seCX.Value := Ini.ReadInteger('C', 'seCX', 0);
    fmSetting.seCY.Value := Ini.ReadInteger('C', 'seCY', 0);
    fmSetting.seCSize.Value := Ini.ReadInteger('C', 'seCSize', Size + 1);

    CX := fmSetting.seCX.Value / 100 - 0.45;
    CY := fmSetting.seCY.Value / 100 - 0.4;
    CS := fmSetting.seCSize.Value / 100;

  finally
    Ini.Destroy;
  end; //try
end;

{=======================================================================
Изменение размеров окна}
procedure TfrmGL.FormResize(Sender: TObject);
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(15.0, ClientWidth / ClientHeight, 1.0, 20.0);
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, -7.5);
  InvalidateRect(Handle, nil, False);
end;

{=======================================================================
Конец работы приложения}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
  glDeleteLists (GLF_START_LIST, 256);
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC(DC);
end;

procedure TfrmGL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = ord('S') then
    begin
      ShowCursor(True);
      fmSetting.ShowModal;
      Writing;
      ShowCursor(False);
      Mous.X := -1;
    end
  else
   Close;
end;

procedure TfrmGL.Writing;
{записывает все изменения}
var
  Ini: TIniFile;
  Path: string;
  i: Integer;
begin
  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Setting';

  try
    Ini := TIniFile.Create(ChangeFileExt(Path, '.ini'));

    Ini.WriteBool('LT', 'cbLTShow', fmSetting.cbLTShow.Checked);
    Ini.WriteBool('LT', 'rbLTTitle', fmSetting.rbLTTitle.Checked);
    Ini.WriteBool('LT', 'rbLTTime', fmSetting.rbLTTime.Checked);
    Ini.WriteBool('LT', 'rbLTDate', fmSetting.rbLTDate.Checked);
    Ini.WriteString('LT', 'edLTTitle', fmSetting.edLTTitle.Text);
    Ini.WriteInteger('LT', 'seLTX', fmSetting.seLTX.Value);
    Ini.WriteInteger('LT', 'seLTY', fmSetting.seLTY.Value);
    Ini.WriteInteger('LT', 'seLTSize', fmSetting.seLTSize.Value);

    Ini.WriteBool('RT', 'cbRTShow', fmSetting.cbRTShow.Checked);
    Ini.WriteBool('RT', 'rbRTTitle', fmSetting.rbRTTitle.Checked);
    Ini.WriteBool('RT', 'rbRTTime', fmSetting.rbRTTime.Checked);
    Ini.WriteBool('RT', 'rbRTDate', fmSetting.rbRTDate.Checked);
    Ini.WriteString('RT', 'edRTTitle', fmSetting.edRTTitle.Text);
    Ini.WriteInteger('RT', 'seRTX', fmSetting.seRTX.Value);
    Ini.WriteInteger('RT', 'seRTY', fmSetting.seRTY.Value);
    Ini.WriteInteger('RT', 'seRTSize', fmSetting.seRTSize.Value);

    Ini.WriteBool('RB', 'cbRBShow', fmSetting.cbRBShow.Checked);
    Ini.WriteBool('RB', 'rbRBTitle', fmSetting.rbRBTitle.Checked);
    Ini.WriteBool('RB', 'rbRBTime', fmSetting.rbRBTime.Checked);
    Ini.WriteBool('RB', 'rbRBDate', fmSetting.rbRBDate.Checked);
    Ini.WriteString('RB', 'edRBTitle', fmSetting.edRBTitle.Text);
    Ini.WriteInteger('RB', 'seRBX', fmSetting.seRBX.Value);
    Ini.WriteInteger('RB', 'seRBY', fmSetting.seRBY.Value);
    Ini.WriteInteger('RB', 'seRBSize', fmSetting.seRBSize.Value);

    Ini.WriteBool('LB', 'cbLBShow', fmSetting.cbLBShow.Checked);
    Ini.WriteBool('LB', 'rbLBTitle', fmSetting.rbLBTitle.Checked);
    Ini.WriteBool('LB', 'rbLBTime', fmSetting.rbLBTime.Checked);
    Ini.WriteBool('LB', 'rbLBDate', fmSetting.rbLBDate.Checked);
    Ini.WriteString('LB', 'edLBTitle', fmSetting.edLBTitle.Text);
    Ini.WriteInteger('LB', 'seLBX', fmSetting.seLBX.Value);
    Ini.WriteInteger('LB', 'seLBY', fmSetting.seLBY.Value);
    Ini.WriteInteger('LB', 'seLBSize', fmSetting.seLBSize.Value);

    Ini.WriteBool('C', 'cbCShow', fmSetting.cbCShow.Checked);
    Ini.WriteBool('C', 'rbCTitle', fmSetting.rbCTitle.Checked);
    Ini.WriteBool('C', 'rbCTime', fmSetting.rbCTime.Checked);
    Ini.WriteBool('C', 'rbCDate', fmSetting.rbCDate.Checked);
    Ini.WriteBool('C', 'rbCTitleOfA', fmSetting.rbCTitleOfA.Checked);
    Ini.WriteString('C', 'edCTitle', fmSetting.edCTitle.Text);
    Ini.WriteInteger('C', 'seCX', fmSetting.seCX.Value);
    Ini.WriteInteger('C', 'seCY', fmSetting.seCY.Value);
    Ini.WriteInteger('C', 'seCSize', fmSetting.seCSize.Value);
  finally
    Ini.Destroy;
  end; //try
end;

procedure TfrmGL.TimerTimer(Sender: TObject);
begin
  DecodeTime(Now, nHour, nMin, nSec, nMSec);
  if nHour > 12 then
    Dec(nHour, 12);

  FormResize(Self);
end;

procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if Mous.X < 0 then
    begin
      Mous.X := X;
      Mous.Y := Y;
    end // if Mous.X < 0
    else if (Mous.X <> X)or(Mous.Y <> Y) then
       Close;
end;

procedure TfrmGL.Clock;
//Рисует сами часы
var
  i: Integer;
  s : string;
begin
  glPushMatrix;                         //Запоминаем матрицы
  glPushAttrib(GL_ALL_ATTRIB_BITS);     //Запоминаем все артибуты

    for i := 1 to 60 do
      begin
        glRotatef(-cAngMinSec, 0.0, 0.0, 1.0);
        if i mod 5 = 0 then
          begin
            glBegin(GL_LINES);
              glVertex2f(0, 0.75);
              glVertex2f(0, 0.85);
            glEnd;
          end // if i mod 5 = 0
        else
          begin
            glBegin(GL_LINES);
              glVertex2f(0, 0.75);
              glVertex2f(0, 0.8);
            glEnd;
          end; //else;
      end;

      //вывод текста
      glTranslatef(-0.04, 0.865, 0.0);
      OutText('12', 0.09);
      glTranslatef(0.04, -0.865, 0.0);

      glTranslatef(0.43, 0.75, 0.0);
      OutText('1', 0.09);
      glTranslatef(-0.43, -0.75, 0.0);

      glTranslatef(0.75, 0.42, 0.0);
      OutText('2', 0.09);
      glTranslatef(-0.75, -0.42, 0.0);

      glTranslatef(0.86, -0.025, 0.0);
      OutText('3', 0.09);
      glTranslatef(-0.86, 0.025, 0.0);

      glTranslatef(0.74, -0.47, 0.0);
      OutText('4', 0.09);
      glTranslatef(-0.74, 0.47, 0.0);

      glTranslatef(0.43, -0.77, 0.0);
      OutText('5', 0.09);
      glTranslatef(-0.43, 0.77, 0.0);

      glTranslatef(-0.02, -0.93, 0.0);
      OutText('6', 0.09);
      glTranslatef(0.02, 0.93, 0.0);

      glTranslatef(-0.475, -0.77, 0.0);
      OutText('7', 0.09);
      glTranslatef(0.475, 0.77, 0.0);

      glTranslatef(-0.787, -0.47, 0.0);
      OutText('8', 0.09);
      glTranslatef(0.787, 0.47, 0.0);

      glTranslatef(-0.9, -0.025, 0.0);
      OutText('9', 0.09);
      glTranslatef(0.9, 0.025, 0.0);

      glTranslatef(-0.82, 0.42, 0.0);
      OutText('10', 0.09);
      glTranslatef(0.82, -0.42, 0.0);

      glTranslatef(-0.48, 0.75, 0.0);
      OutText('11', 0.09);
      glTranslatef(0.48, -0.75, 0.0);

      //центр
      if fmSetting.cbCShow.Checked then
      begin
        glTranslatef(CX, CY, 0.0);
        if fmSetting.rbCTitle.Checked then
            OutText(PChar(fmSetting.edCTitle.Text), CS)
          else if fmSetting.rbCTime.Checked then
            OutText(PChar(TimeToStr(Now)), CS)
              else if fmSetting.rbCDate.Checked then
                OutText(PChar(DateToStr(Now)), CS)
                  else
                   begin
                     glTranslatef(-CX, -CY, 0.0);

                     glTranslatef(-0.4, -0.3, 0.0);
                     OutText('Мозг - это мой второй', 0.09);
                     glTranslatef(0.4, 0.3, 0.0);

                     glTranslatef(-0.28, -0.4, 0.0);
                     OutText('любимый орган.', 0.09);
                     glTranslatef(0.28, 0.4, 0.0);

                     glTranslatef(CX, CY, 0.0);
                   end;

        glTranslatef(-CX, -CY, 0.0);
      end;


      //правый нижний угол
      if fmSetting.cbRBShow.Checked then
      begin
        glTranslatef(RBX, RBY, 0.0);
        if fmSetting.rbRBTitle.Checked then
            OutText(PChar(fmSetting.edRBTitle.Text), RBS)
          else if fmSetting.rbRBTime.Checked then
            OutText(PChar(TimeToStr(Now)), RBS)
              else
                OutText(PChar(DateToStr(Now)), RBS);

        glTranslatef(-RBX, -RBY, 0.0);
      end;

      //левый нижний угол
      if fmSetting.cbLBShow.Checked then
      begin
        glTranslatef(LBX, LBY, 0.0);
        if fmSetting.rbLBTitle.Checked then
            OutText(PChar(fmSetting.edLBTitle.Text), LBS)
          else if fmSetting.rbLBTime.Checked then
            OutText(PChar(TimeToStr(Now)), LBS)
              else
                OutText(PChar(DateToStr(Now)), LBS);

        glTranslatef(-LBX, -LBY, 0.0);
      end;

      //левый верхний угол
      if fmSetting.cbLTShow.Checked then
      begin
        glTranslatef(LTX, LTY, 0.0);
          if fmSetting.rbLTTitle.Checked then
            OutText(PChar(fmSetting.edLTTitle.Text), LTS)
          else if fmSetting.rbLTTime.Checked then
            OutText(PChar(TimeToStr(Now)), LTS)
              else
                OutText(PChar(DateToStr(Now)), LTS);

        glTranslatef(-LTX, -LTY, 0.0);
      end;// if fmSetting.cbLTShow

      //правый верхний угол
      if fmSetting.cbRTShow.Checked then
      begin
        glTranslatef(RTX, RTY, 0.0);
          if fmSetting.rbRTTitle.Checked then
            OutText(PChar(fmSetting.edRTTitle.Text), RTS)
          else if fmSetting.rbRTTime.Checked then
            OutText(PChar(TimeToStr(Now)), RTS)
              else
                OutText(PChar(DateToStr(Now)), RTS);

        glTranslatef(-RTX, -RTY, 0.0);
      end;

  glPopAttrib;                          //Восстанавливаем атрибуты
  glPopMatrix;                          //Восстанавливаем матрицы
end;

end.

