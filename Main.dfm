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
  object Button1: TButton
    Left = 766
    Top = 446
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 1
    OnClick = Button1Click
  end
  object RichEdit: TRichEdit
    Left = 24
    Top = 80
    Width = 825
    Height = 346
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    Zoom = 100
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
