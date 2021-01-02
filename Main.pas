// ****************************************************************************
//
// Software to make a connection between the Prism astronomical software
// www.hyperion-astronomy.com and the Good Night System (GNS)
// from lunatico.es.
//
// Niklas Storck
// Hallongr�nd 23, 182 45 Enebyberg, Sweden
// niklas@family-storck.se
//
// 2018-02-02
//
// ****************************************************************************

unit Main;

interface

uses
  ShellApi, System.UITypes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    EditFolder: TLabeledEdit;
    RichEdit: TRichEdit;
    TimerSlow: TTimer;
    LabelInfo: TLabel;
    TimerFast: TTimer;
    LabeledEditTimeout: TLabeledEdit;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure TimerSlowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerFastTimer(Sender: TObject);
    procedure LabeledEditTimeoutChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    SLast: String;
    TimeOut: Integer;
    procedure CallGNS(var Return: integer; SNew: string);
    function ObsEnd(SNew: String):Boolean;
    function StripTimeFromString(var STemp: string):String;
    procedure Welcome;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  TimerSlow.Interval:=10000;
  TimerSlow.Enabled:= False;
  Button1.Caption:= 'Run';
  TimerFast.Enabled:=False;
  LabelInfo.caption:='Idle';
  Form1.Caption:='GNS for Prism';
  Form1.Color:=RGB(100,100,100);
  SLast:='';
  TimeOut:=120;
  LabelInfo.Font.Color:=RGB(255,25,25);
  LabeledEditTimeout.Text:='120';
  Welcome;
end;

procedure TForm1.LabeledEditTimeoutChange(Sender: TObject);
var s: String;
begin
  s:=LabeledEditTimeOut.Text;
  Try
    TimeOut:=StrToInt(s)
  Except
    TimeOut:=120;
    s:=s+' must be a number';
    Application.MessageBox(PWideChar(s),'Error!',MB_OK);

  End
end;

function TForm1.ObsEnd(SNew:String): Boolean;
// Check if observation has ended by comparing tha string
// with a standarstring.
// Probably I should cahnge this to someting more dynamic
// that the user can change if Prism changes the message.
// It works today.
begin
  ObsEnd:=False;
  if SNew = 'Auto Observations process has been released' then
    ObsEnd:=True
end;

function TForm1.StripTimeFromString(var STemp: string):String;
// Deletes the timestamp from the line.
// This is because it was to much information for GNS to show in
// its main window.
var
  Position: Integer;
begin
  // Extract string after ':' in line
  Position := Pos(':', STemp) + 1; // +1 is to delete the space after ":".
  Delete(STemp, 1, Position);
  Result:=STemp;
end;

procedure TForm1.Welcome;
// Welcome message
begin

  Panel1.Caption:='';
  Panel2.Caption:='';

  RichEdit.Lines.Clear;
  RichEdit.Lines.Add('Welcome!');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('1. Start an automatic session with Prism.');
  RichEdit.Lines.Add('2. Open the new observation log file. It usually has a name like "Obsauto__UTC_2018-02-04__13h31m04s".');
  RichEdit.Lines.Add('2 b. You might want to change the timeout depending on your requirements. (Sorry I dont sawe between sesions)');
  RichEdit.Lines.Add('3. Press <Run>');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('At the moment it is necessary that GNS is in it''s default directory C:\Program Files (x86)\GNS');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('The software is a tool made for my own use. Its free for anyone to use in their observatory');
  RichEdit.Lines.Add('but I can not take any responsibility for any damage to equipment that might happen due');
  RichEdit.Lines.Add('to any malfunction of the software.');
  RichEdit.Lines.Add('With that said I believe it to work well.');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('Please drop me a mail if there is some problems: niklas@storckholmen.se');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('Clear skies!');
  RichEdit.Lines.Add('');
  RichEdit.Lines.Add('Niklas Storck');
end;

procedure TForm1.Button1Click(Sender: TObject);
// Switch to handle turn on/off sampling of logfile.
begin
  if TimerSlow.enabled then
  // Turn off
    begin
      TimerSlow.Enabled:= False;
      Button1.Caption:= 'Run';
      TimerFast.Enabled:=False;
      LabelInfo.caption:='Idle';
      LabelInfo.Font.Color:=RGB(255,25,25)

    end
    else
    // Turn on
    begin
      RichEdit.Lines.Clear;
      LabelInfo.caption := '';
      LabelInfo.Font.Color := RGB(25,255,25);
      RichEdit.SelAttributes.Color := clGreen;
      RichEdit.SelAttributes.Style := [fsBold];
      RichEdit.Lines.Add('Start of sampling at: '+ DateTimeToStr(Now));
      RichEdit.Lines.Add('Timeout is '+ IntToStr(TimeOut)+' s.');
      RichEdit.Lines.Add('Log file is: '+EditFolder.Text+'.');
      RichEdit.Lines.Add('--------------------------------------------------');
      RichEdit.Lines.Add('');
      TimerSlow.Enabled:= True;
      Button1.Caption:='Stop';
      TimerFast.Enabled:=True;
      TimerSlowTimer(self)
    end;
end;



procedure TForm1.Button2Click(Sender: TObject);
begin
if OpenDialog1.execute then
    EditFolder.Text:= OpenDialog1.FileName;

end;


procedure TForm1.CallGNS(var Return: integer; SNew: string);
// Calls GNS
// SNew is the Message that is sent
// Return is returncode from ShellExecute. Should be > 32 if ewerything is ok.

var parameters, filename: String;

begin
  RichEdit.Lines.Add(SNew);
  filename:='C:\Program Files (x86)\GNS\update.vbs';
  parameters:=' "'+StripTimeFromString(SNew)+'"'+' '+IntToStr(TimeOut);
  return:=ShellExecute(handle,'open',Pchar(filename),PChar(parameters),'',SW_MINIMIZE);

  if ObsEnd(SNew) then
  // Observation ended ok. Send stop instruction to GNS
  begin
    filename:='C:\Program Files (x86)\GNS\switchoff.vbs';
    return:=ShellExecute(handle,'open',Pchar(filename),'','',SW_MINIMIZE);
    RichEdit.Lines.Add('');
    RichEdit.Lines.Add('--------------------------------------------------');
    RichEdit.SelAttributes.Color:=clGreen;
    RichEdit.SelAttributes.Style := [fsBold];
    RichEdit.Lines.Add('The session has ended. Shutdown is sent to GNS.');
    Button1Click(self);
    LabelInfo.caption:='Ready';
    LabelInfo.Font.Color:=RGB(25,25,255)
  end;
end;

procedure TForm1.TimerFastTimer(Sender: TObject);
// Ticks the clock
begin
  LabelInfo.caption:='Running :'+DateTimeToStr(now)
end;


procedure TForm1.TimerSlowTimer(Sender: TObject);
// Reads the last line of the selected logfile
var F: TextFile;
    SNew, STemp: String;
    return: Integer;
begin
   STemp:='';
   RichEdit.Brush.Color:=RGB(200,200,200);
   RichEdit.SelAttributes.Color:=clBlack;
   if fileexists(EditFolder.Text) then
     begin

       AssignFile(F,EditFolder.Text);
       Reset(F);
       repeat
         Readln(F,SNew);
       until EOF(F);
       STemp:=Snew;
       if SNew <> SLast then
         begin
          CallGNS(return, SNew);
          if return < 32 then
          begin
            RichEdit.Lines.Add('--------------------------------------------------');
            RichEdit.Lines.Add('');
            RichEdit.SelAttributes.Color:=clRed;
            RichEdit.Lines.Add('Problem with talking to gns. Error: '+ intToStr(Return));
          end;
         end;
       SLast:=STemp;
       CloseFile(F)
     end
   else
     begin
       RichEdit.SelAttributes.Color:=clRed;
       RichEdit.Lines.Add('File '+EditFolder.Text+' not found!');
       RichEdit.SelAttributes.Style := [fsBold];
       RichEdit.Lines.Add('Session ended!');
       Button1Click(self);
     end;
end;


end.
