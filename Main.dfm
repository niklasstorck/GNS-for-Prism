object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 479
  ClientWidth = 873
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object W7NavigationButton1: TW7NavigationButton
    Left = 383
    Top = 29
    Width = 24
    Height = 24
    Caption = 'W7NavigationButton1'
    FadeInInterval = 17
    FadeOutInterval = 17
    ParentFont = False
    OnClick = W7NavigationButton1Click
  end
  object LabelInfo: TLabel
    Left = 440
    Top = 25
    Width = 36
    Height = 25
    Caption = 'Idle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditFolder: TLabeledEdit
    Left = 24
    Top = 32
    Width = 353
    Height = 21
    Color = clScrollBar
    EditLabel.Width = 133
    EditLabel.Height = 13
    EditLabel.Caption = 'Map for Prism log_obs_auto'
    TabOrder = 0
    Text = 'Select latest logfile'
  end
  object Memo1: TMemo
    Left = 24
    Top = 80
    Width = 793
    Height = 329
    Color = clScrollBar
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 728
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 2
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 72
    Top = 312
  end
  object TimerSlow: TTimer
    OnTimer = TimerSlowTimer
    Left = 200
    Top = 312
  end
  object TimerFast: TTimer
    OnTimer = TimerFastTimer
    Left = 488
    Top = 296
  end
end
