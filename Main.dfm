object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 499
  ClientWidth = 553
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
  object LabelInfo: TLabel
    Left = 472
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
  object Panel2: TPanel
    Left = 0
    Top = 447
    Width = 553
    Height = 52
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 5
    ExplicitTop = 491
    ExplicitWidth = 871
    object Button1: TButton
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 113
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 4
    ExplicitWidth = 870
  end
  object EditFolder: TLabeledEdit
    Left = 24
    Top = 30
    Width = 353
    Height = 24
    Color = clScrollBar
    EditLabel.Width = 116
    EditLabel.Height = 16
    EditLabel.Hint = 'Select the Prism logfile for automatic observations'
    EditLabel.Caption = 'Prism Obsauto file'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clGradientActiveCaption
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Select current logfile'
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 113
    Width = 553
    Height = 334
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    Zoom = 100
    ExplicitTop = 106
    ExplicitWidth = 871
    ExplicitHeight = 385
  end
  object LabeledEditTimeout: TLabeledEdit
    Left = 24
    Top = 74
    Width = 353
    Height = 24
    Color = clScrollBar
    EditLabel.Width = 74
    EditLabel.Height = 16
    EditLabel.Hint = 'The longest acceptable time between new lines in log-file'
    EditLabel.Caption = 'Timeout (s)'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clGradientActiveCaption
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'The longest acceptable time '
    OnChange = LabeledEditTimeoutChange
  end
  object Button2: TButton
    Left = 383
    Top = 30
    Width = 50
    Height = 24
    Caption = 'File'
    TabOrder = 3
    OnClick = Button2Click
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
