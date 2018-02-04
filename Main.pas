unit Main;

interface

uses
  ShellApi,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FolderDialog, Vcl.StdCtrls, Vcl.ExtCtrls,
  W7Classes, W7NaviButtons;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    EditFolder: TLabeledEdit;
    W7NavigationButton1: TW7NavigationButton;
    Memo1: TMemo;
    Button1: TButton;
    TimerSlow: TTimer;
    LabelInfo: TLabel;
    TimerFast: TTimer;
    procedure W7NavigationButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TimerSlowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerFastTimer(Sender: TObject);
  private
    SLast: String;
    procedure CallGNS(var Return: integer; SNew: string);
    function ObsEnd(SNew: String):Boolean;
    function StripTimeFromString(var STemp: string):String;
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
  Memo1.Lines.Clear;
  Form1.Caption:='GNS for Prism';
  Form1.Color:=RGB(100,100,100);
  SLast:='';
  LabelInfo.Font.Color:=RGB(255,25,25)
end;

function TForm1.ObsEnd(SNew:String): Boolean;
begin
  ObsEnd:=False;
  if SNew = 'Auto Observations process has been released' then
    ObsEnd:=True
end;

function TForm1.StripTimeFromString(var STemp: string):String;
var
  Position: Integer;
begin
  // Extract string after ':' in line
  Position := Pos(':', STemp) + 1;
  Delete(STemp, 1, Position);
  Result:=STemp;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if TimerSlow.enabled then
    begin
      TimerSlow.Enabled:= False;
      Button1.Caption:= 'Run';
      TimerFast.Enabled:=False;
      LabelInfo.caption:='Idle';
      LabelInfo.Font.Color:=RGB(255,25,25)

    end
    else
    begin
      Memo1.Lines.Clear;
      Memo1.Lines.Add('Start of sampling at: '+ DateTimeToStr(Now));
      TimerSlow.Enabled:= True;
      Button1.Caption:='Stop';
      TimerFast.Enabled:=True;
      LabelInfo.Font.Color:=RGB(25,255,25)
    end;
end;



procedure TForm1.CallGNS(var Return: integer; SNew: string);
// Calls GNS
var parameters, filename: String;

begin
  Memo1.Lines.Add(SNew);
  filename:='C:\Program Files (x86)\GNS\update.vbs';
  parameters:=' "'+StripTimeFromString(SNew)+'"'+' 120';
  return:=ShellExecute(handle,'open',Pchar(filename),PChar(parameters),'',SW_MINIMIZE);

  if ObsEnd(SNew) then
  // Observation ended ok. Send stop instruction to GNS
  begin
    filename:='C:\Program Files (x86)\GNS\switchoff.vbs';
    return:=ShellExecute(handle,'open',Pchar(filename),'','',SW_MINIMIZE);
    Memo1.Lines.Add('The session has ended. Shutdown is sent to GNS.');
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
            Memo1.Lines.Add('Problem with talkint to gns. Error: '+ intToStr(Return))
         end;
       SLast:=STemp;
       CloseFile(F)
     end
   else
     Memo1.Lines.Add('File '+EditFolder.Text+' not found!')
end;

procedure TForm1.W7NavigationButton1Click(Sender: TObject);
begin
  if OpenDialog1.execute then
    EditFolder.Text:= OpenDialog1.FileName;
end;

end.
