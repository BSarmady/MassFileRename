object fmMassFileRename: TfmMassFileRename
  Left = 217
  Top = 93
  Caption = 'fmMassFileRename'
  ClientHeight = 448
  ClientWidth = 365
  Color = clBtnFace
  Constraints.MinHeight = 486
  Constraints.MinWidth = 377
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 4
  Padding.Top = 4
  Padding.Right = 4
  Padding.Bottom = 4
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 13
  object lblCaption: TLabel
    Left = 4
    Top = 4
    Width = 357
    Height = 30
    Align = alTop
    Caption = 'lblCaption'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 116
  end
  object PageControl: TPageControl
    Left = 4
    Top = 34
    Width = 357
    Height = 381
    ActivePage = pgOptions
    Align = alClient
    HotTrack = True
    TabOrder = 0
    TabPosition = tpBottom
    ExplicitWidth = 353
    ExplicitHeight = 380
    object pgOptions: TTabSheet
      Caption = 'Options'
      DesignSize = (
        349
        355)
      object lblFolder: TLabel
        Left = 8
        Top = 8
        Width = 83
        Height = 13
        Caption = 'Folder to Process'
      end
      object lblFrom: TLabel
        Left = 24
        Top = 216
        Width = 37
        Height = 13
        Caption = 'Change'
      end
      object lblTo: TLabel
        Left = 48
        Top = 240
        Width = 12
        Height = 13
        Caption = 'To'
      end
      object edtSrcFolder: TEdit
        Left = 8
        Top = 24
        Width = 315
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        ExplicitWidth = 311
      end
      object cbUnderlineToSpace: TCheckBox
        Left = 200
        Top = 64
        Width = 161
        Height = 17
        Caption = 'Underline to Space'
        TabOrder = 2
        OnClick = ControlsChange
      end
      object cbTitleCase: TCheckBox
        Left = 3
        Top = 164
        Width = 161
        Height = 17
        Caption = 'Title Case'
        TabOrder = 8
        OnClick = ControlsChange
      end
      object cbMoveFileNumber: TCheckBox
        Left = 3
        Top = 297
        Width = 169
        Height = 17
        Caption = 'Move File Number'
        TabOrder = 13
        OnClick = ControlsChange
      end
      object cbExtensionLowerCase: TCheckBox
        Left = 3
        Top = 112
        Width = 161
        Height = 17
        Caption = 'File Extension to Lowercase '
        TabOrder = 5
        OnClick = ControlsChange
      end
      object edtChangeFrom: TEdit
        Left = 64
        Top = 216
        Width = 278
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 10
        ExplicitWidth = 274
      end
      object edtChangeTo: TEdit
        Left = 64
        Top = 240
        Width = 278
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 11
        ExplicitWidth = 274
      end
      object cbIgnoreCase: TCheckBox
        Left = 24
        Top = 267
        Width = 161
        Height = 17
        Caption = 'Ignore Case'
        TabOrder = 12
        OnClick = ControlsChange
      end
      object cbPartialRename: TCheckBox
        Left = 3
        Top = 193
        Width = 97
        Height = 17
        Caption = 'Partial Rename'
        TabOrder = 9
        OnClick = ControlsChange
      end
      object cbRenameFolders: TCheckBox
        Left = 3
        Top = 64
        Width = 169
        Height = 17
        Caption = 'Rename Folders'
        TabOrder = 1
        OnClick = ControlsChange
      end
      object cbDoubleSpaceToOne: TCheckBox
        Left = 200
        Top = 80
        Width = 161
        Height = 17
        Caption = 'Double Spaces to One'
        TabOrder = 4
        OnClick = ControlsChange
      end
      object rbMoveNumberToEnd: TRadioButton
        Left = 120
        Top = 320
        Width = 65
        Height = 17
        Caption = 'To End'
        Checked = True
        TabOrder = 15
        TabStop = True
        OnClick = ControlsChange
      end
      object rbMoveNumberToStart: TRadioButton
        Left = 24
        Top = 320
        Width = 73
        Height = 17
        Caption = 'To Start'
        TabOrder = 14
        OnClick = ControlsChange
      end
      object cbLowerCase: TCheckBox
        Left = 3
        Top = 130
        Width = 161
        Height = 17
        Caption = 'Lower Case'
        TabOrder = 6
        OnClick = ControlsChange
      end
      object cbUpperCase: TCheckBox
        Left = 3
        Top = 147
        Width = 161
        Height = 17
        Caption = 'Upper Case'
        TabOrder = 7
        OnClick = ControlsChange
      end
      object cbDotsToDash: TCheckBox
        Left = 3
        Top = 80
        Width = 153
        Height = 17
        Caption = 'Change Dots To Dashes'
        TabOrder = 3
        OnClick = ControlsChange
      end
      object btnSelectFolder: TButton
        Left = 322
        Top = 24
        Width = 20
        Height = 21
        Anchors = [akTop, akRight]
        Caption = #8230
        TabOrder = 16
        OnClick = edtSrcFolderButtonClick
        ExplicitLeft = 318
      end
    end
    object pgLog: TTabSheet
      Caption = 'Log'
      object logtext: TRichEdit
        Left = 0
        Top = 0
        Width = 345
        Height = 354
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 4
    Top = 415
    Width = 357
    Height = 29
    Align = alBottom
    AutoSize = True
    BorderWidth = 4
    TabOrder = 1
    ExplicitTop = 414
    ExplicitWidth = 353
    object btnStart: TButton
      Left = 295
      Top = 5
      Width = 57
      Height = 19
      Align = alRight
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
      ExplicitLeft = 291
    end
  end
end
