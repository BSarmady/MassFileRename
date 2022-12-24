unit uMassFileRename;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, ExtCtrls, uline;

const
  cAppRegistryRoot = '\Software\JGhost\MassFileRename';
  cAppName = 'Mass File Rename';

type

{$REGION 'DEF: Class TfmMassFileRename'}
  TfmMassFileRename = class(TForm)
    PageControl: TPageControl;
    pgOptions: TTabSheet;
    pgLog: TTabSheet;
    logtext: TRichEdit;
    lblFolder: TLabel;
    edtSrcFolder: TEdit;
    cbUnderlineToSpace: TCheckBox;
    cbTitleCase: TCheckBox;
    cbMoveFileNumber: TCheckBox;
    cbExtensionLowerCase: TCheckBox;
    lblFrom: TLabel;
    lblTo: TLabel;
    edtChangeFrom: TEdit;
    edtChangeTo: TEdit;
    cbIgnoreCase: TCheckBox;
    cbPartialRename: TCheckBox;
    cbRenameFolders: TCheckBox;
    cbDoubleSpaceToOne: TCheckBox;
    lblCaption: TLabel;
    Panel1: TPanel;
    btnStart: TButton;
    rbMoveNumberToEnd: TRadioButton;
    rbMoveNumberToStart: TRadioButton;
    cbLowerCase: TCheckBox;
    cbUpperCase: TCheckBox;
    cbDotsToDash: TCheckBox;
    btnSelectFolder: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSrcFolderButtonClick(Sender: TObject);
    procedure ControlsChange(Sender: TObject);
  private
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Processing: Boolean;
    Errors: Integer;
    Exceptions: Integer;
    Files: Integer;
    FilesRenamed: Integer;
    Directories: Integer;
    DirectoriesRenamed: Integer;
    procedure FindAllFiles(Path: string);
    procedure Log(Msg: string; Color: TColor);
  public
  end;
{$ENDREGION}


var
  fmMassFileRename: TfmMassFileRename;

implementation

uses
  uRegistry, FileCtrl, StrUtils;

{$R *.dfm}

{$REGION 'procedure TfmMassFileRename.FormCreate(Sender: TObject);'}
procedure TfmMassFileRename.FormCreate(Sender: TObject);
begin
  Processing := False;
  Caption := cAppName;
  lblCaption.Caption := cAppName;
  Application.Title := cAppName;

  Line1 := TLine.Create(Self);
  with Line1 do begin
    Parent := pgOptions;
    Left := 3;
    Top := 56;
    Width := 338;
    Anchors := [TAnchorKind.akTop, TAnchorKind.akLeft, TAnchorKind.akRight];
  end;
  Line2 := TLine.Create(Self);
  with Line2 do begin
    Parent := pgOptions;
    Left := 3;
    Top := 104;
    Width := 338;
    Anchors := [TAnchorKind.akTop, TAnchorKind.akLeft, TAnchorKind.akRight];
  end;
  Line3 := TLine.Create(Self);
  with Line3 do begin
    Parent := pgOptions;
    Left := 3;
    Top := 184;
    Width := 338;
    Anchors := [TAnchorKind.akTop, TAnchorKind.akLeft, TAnchorKind.akRight];
  end;
  Line4 := TLine.Create(Self);
  with Line4 do begin
    Parent := pgOptions;
    Left := 3;
    Top := 288;
    Width := 338;
    Anchors := [TAnchorKind.akTop, TAnchorKind.akLeft, TAnchorKind.akRight];
  end;

  LoadFormState(Self, cAppRegistryRoot);
  edtSrcFolder.Text := LoadFromRegistry(cAppRegistryRoot, 'SourceFolder', ExtractFilePath(Application.ExeName));

  cbRenameFolders.Checked := LoadFromRegistry(cAppRegistryRoot, 'RenameFolders', cbRenameFolders.Checked);
  cbUnderlineToSpace.Checked := LoadFromRegistry(cAppRegistryRoot, 'UnderlineToSpace', cbUnderlineToSpace.Checked);
  cbDotsToDash.Checked := LoadFromRegistry(cAppRegistryRoot, 'DotsToDash', cbDotsToDash.Checked);
  cbDoubleSpaceToOne.Checked := LoadFromRegistry(cAppRegistryRoot, 'DoubleSpaceToOne', cbDoubleSpaceToOne.Checked);

  cbExtensionLowerCase.Checked := LoadFromRegistry(cAppRegistryRoot, 'ExtensionLowerCase', cbExtensionLowerCase.Checked);
  cbTitleCase.Checked := LoadFromRegistry(cAppRegistryRoot, 'TitleCase', cbTitleCase.Checked);
  cbLowerCase.Checked := LoadFromRegistry(cAppRegistryRoot, 'LowerCase', cbLowerCase.Checked);
  cbUpperCase.Checked := LoadFromRegistry(cAppRegistryRoot, 'UpperCase', cbUpperCase.Checked);

  cbPartialRename.Checked := LoadFromRegistry(cAppRegistryRoot, 'PartialRename', cbPartialRename.Checked);
  edtChangeFrom.Text := LoadFromRegistry(cAppRegistryRoot, 'ChangeFrom', edtChangeFrom.Text);
  edtChangeTo.Text := LoadFromRegistry(cAppRegistryRoot, 'ChangeTo', edtChangeTo.Text);
  cbIgnoreCase.Checked := LoadFromRegistry(cAppRegistryRoot, 'IgnoreCase', cbIgnoreCase.Checked);

  rbMoveNumberToStart.Checked := LoadFromRegistry(cAppRegistryRoot, 'MoveNumberToStart', rbMoveNumberToStart.Checked);
  rbMoveNumberToEnd.Checked := LoadFromRegistry(cAppRegistryRoot, 'MoveNumberToEnd', rbMoveNumberToEnd.Checked);
  cbMoveFileNumber.Checked := LoadFromRegistry(cAppRegistryRoot, 'MoveFileNumber', cbMoveFileNumber.Checked);

  ControlsChange(nil);
  PageControl.ActivePageIndex := 0;
  ActiveControl := edtSrcFolder;
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.FormDestroy(Sender: TObject);'}
procedure TfmMassFileRename.FormDestroy(Sender: TObject);
begin
  SaveFormState(Self, cAppRegistryRoot);
  SaveToRegistry(cAppRegistryRoot, 'SourceFolder', edtSrcFolder.Text);

  SaveToRegistry(cAppRegistryRoot, 'RenameFolders', cbRenameFolders.Checked);
  SaveToRegistry(cAppRegistryRoot, 'UnderlineToSpace', cbUnderlineToSpace.Checked);
  SaveToRegistry(cAppRegistryRoot, 'DotsToDash', cbDotsToDash.Checked);
  SaveToRegistry(cAppRegistryRoot, 'DoubleSpaceToOne', cbDoubleSpaceToOne.Checked);

  SaveToRegistry(cAppRegistryRoot, 'ExtensionLowerCase', cbExtensionLowerCase.Checked);
  SaveToRegistry(cAppRegistryRoot, 'TitleCase', cbTitleCase.Checked);
  SaveToRegistry(cAppRegistryRoot, 'LowerCase', cbLowerCase.Checked);
  SaveToRegistry(cAppRegistryRoot, 'UpperCase', cbUpperCase.Checked);

  SaveToRegistry(cAppRegistryRoot, 'PartialRename', cbPartialRename.Checked);
  SaveToRegistry(cAppRegistryRoot, 'ChangeFrom', edtChangeFrom.Text);
  SaveToRegistry(cAppRegistryRoot, 'ChangeTo', edtChangeTo.Text);
  SaveToRegistry(cAppRegistryRoot, 'IgnoreCase', cbIgnoreCase.Checked);

  SaveToRegistry(cAppRegistryRoot, 'MoveFileNumber', cbMoveFileNumber.Checked);
  SaveToRegistry(cAppRegistryRoot, 'MoveNumberToStart', rbMoveNumberToStart.Checked);
  SaveToRegistry(cAppRegistryRoot, 'MoveNumberToEnd', rbMoveNumberToEnd.Checked);

  SaveToRegistry(cAppRegistryRoot, 'ExtensionLowerCase', cbExtensionLowerCase.Checked);
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.Log(Msg: string; Color:TColor);'}
procedure TfmMassFileRename.Log(Msg: string; Color: TColor);
begin
  logtext.SelAttributes.Color := Color;
  logtext.Lines.Add(Msg);
  logtext.SelStart := Length(logtext.Text);
  logtext.Perform(EM_SCROLLCARET, 0, 0);
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.edtSrcFolderButtonClick(Sender: TObject);'}
procedure TfmMassFileRename.edtSrcFolderButtonClick(Sender: TObject);
var
  Directory: string;
begin
  if Processing then
      Exit;
  Directory := edtSrcFolder.Text;
  if SelectDirectory('Select Source Folder', '', Directory, [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]) then
      edtSrcFolder.Text := IncludeTrailingBackslash(Directory);
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.FindAllFiles(Path:string);'}
procedure TfmMassFileRename.FindAllFiles(Path: string);
var
  SearchRec: TSearchRec;
  Renamed,
    Names: string;

{$REGION 'function ChangeName(FileName: string): string;'}
  function ChangeName(FileName: string): string;
  var
    I: Integer;
    NumberPrefix: string;
  begin
    Result := FileName;
    try
      Result := StringReplace(FileName, ExtractFileExt(FileName), '', []);
      if cbDotsToDash.Checked then
          Result := StringReplace(Result, '.', ' - ', [rfReplaceAll]);
      if cbUnderlineToSpace.Checked then
          Result := StringReplace(Result, '_', ' ', [rfReplaceAll]);
      if cbLowerCase.Checked then
          Result := LowerCase(Result);
      if cbUpperCase.Checked then
          Result := UpperCase(Result);
      if cbMoveFileNumber.Checked then begin
        if rbMoveNumberToEnd.Checked then begin
          I := 1;
          NumberPrefix := '';
          while (I <= Length(Result)) and (StrToIntDef(Result[I], -1) > -1) do begin
            NumberPrefix := NumberPrefix + Result[I];
            Inc(I);
          end;
          Result := Trim(StringReplace(Result, NumberPrefix, '', []) + IfThen(NumberPrefix <> '', ' ', '') + NumberPrefix);
        end
        else begin
          I := Length(Result);
          NumberPrefix := '';
          while (I > 0) and (StrToIntDef(Result[I], -1) > -1) do begin
            NumberPrefix := Result[I] + NumberPrefix;
            Dec(I);
          end;
          Result := Trim(NumberPrefix + IfThen(NumberPrefix <> '', ' ', '') + StringReplace(Result, NumberPrefix, '', []));
        end;
      end;
      if cbTitleCase.Checked then begin
        for I := 1 to Length(Result) do
          if Result[I] in [' ', '~', '!', '@', '#', '$', '%', '^', '&', '(', ')', '_', '+', ',', '=', '-', ';', '.'] then
            if (I + 1 <= Length(Result)) and (Result[I + 1] > #96) and (Result[I + 1] < #123) then
                Result[I + 1] := Char(Ord(Result[I + 1]) - 32);
        Result := UpperCase(LeftStr(Result, 1)) + Copy(Result, 2, Length(Result) - 1);
      end;
      if cbDoubleSpaceToOne.Checked then
          Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
      if cbExtensionLowerCase.Checked then
          Result := Result + LowerCase(ExtractFileExt(FileName))
      else
          Result := Result + ExtractFileExt(FileName);
      if cbPartialRename.Checked then begin
        if cbIgnoreCase.Checked then
            Result := StringReplace(Result, edtChangeFrom.Text, edtChangeTo.Text, [rfReplaceAll, rfIgnoreCase])
        else
            Result := StringReplace(Result, edtChangeFrom.Text, edtChangeTo.Text, [rfReplaceAll]);
      end;
    except
      on ex: Exception do begin
        Log('  Error:' + ex.Message, clRed);
        Inc(Exceptions);
      end;
    end;
  end;
{$ENDREGION}

begin
  Log(Path, clBlack);
  SearchRec.Name := '';
  if FindFirst(Path + '*.*', faAnyFile, SearchRec) = 0 then begin
    repeat
      if not Processing then begin
        FindClose(SearchRec);
        Exit;
      end;
      try
        if (SearchRec.Attr and faDirectory) = faDirectory then begin
          Inc(Directories);
          if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then begin
            FindAllFiles(IncludeTrailingBackslash(Path + SearchRec.Name));
            if cbRenameFolders.Checked then begin
              Renamed := ChangeName(SearchRec.Name);
              if Renamed <> SearchRec.Name then begin
                Log('    ' + Renamed, clBlue);
                if not RenameFile(Path + SearchRec.Name, Path + Renamed) then begin
                  Log('    Cannot Rename ' + SearchRec.Name, clRed);
                  Inc(Errors);
                end
                else
                    Inc(DirectoriesRenamed);
              end;
            end;
          end;
        end
        else begin
          Inc(Files);
          Renamed := ChangeName(SearchRec.Name);
          if Renamed <> SearchRec.Name then begin
            Log('  ' + SearchRec.Name, $00FF8000);
            Log('    ' + Renamed, clBlue);
            if not RenameFile(Path + SearchRec.Name, Path + Renamed) then begin
              Log('    Cannot Rename ' + SearchRec.Name, clRed);
              Inc(Errors);
            end
            else
                Inc(FilesRenamed);
          end;
        end;
        Application.ProcessMessages;
      except
        on ex: Exception do begin
          Log('  Error:' + ex.Message, clRed);
          Inc(Exceptions);
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.btnStartClick(Sender: TObject);'}
procedure TfmMassFileRename.btnStartClick(Sender: TObject);
begin
  if Processing then begin
    Processing := False;
  end
  else begin
    Processing := True;
    try
      try
        logtext.Clear;
        Errors := 0;
        Files := 0;
        Directories := 0;
        FilesRenamed := 0;
        DirectoriesRenamed := 0;
        pgOptions.Enabled := False;
        PageControl.ActivePage := pgLog;
        btnStart.Caption := 'Stop';
        edtSrcFolder.Text := IncludeTrailingBackslash(edtSrcFolder.Text);
        FindAllFiles(edtSrcFolder.Text);

        Log('-------------------------------------------------', clBlack);
        if not Processing then
            Log('User Canceled', clRed)
        else
            Log('Completed', clPurple);
        Log('Files: '#9 + IntToStr(Files), clBlack);
        Log('Files Renamed: '#9 + IntToStr(FilesRenamed), clBlack);
        Log('Folders: '#9 + IntToStr(Directories), clBlack);
        Log('Folders Renamed: '#9 + IntToStr(DirectoriesRenamed), clBlack);
        Log('Total Errors: '#9 + IntToStr(Errors), clRed);
        Log('Total Exceptions: '#9 + IntToStr(Exceptions), clRed);
        if (Exceptions = 0) and (Errors = 0) then
            PageControl.ActivePage := pgOptions;
      except
        on ex: Exception do begin
          Log('  Error:' + ex.Message, clRed);
          Inc(Exceptions);
        end;
      end;
    finally
      pgOptions.Enabled := True;
      btnStart.Caption := 'Start';
      Processing := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);'}
procedure TfmMassFileRename.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
      btnStart.Click;
end;
{$ENDREGION}

{$REGION 'procedure TfmMassFileRename.ControlsChange(Sender: TObject);'}
procedure TfmMassFileRename.ControlsChange(Sender: TObject);
begin
  lblFrom.Enabled := cbPartialRename.Checked;
  lblTo.Enabled := cbPartialRename.Checked;
  edtChangeFrom.Enabled := cbPartialRename.Checked;
  edtChangeTo.Enabled := cbPartialRename.Checked;
  cbIgnoreCase.Enabled := cbPartialRename.Checked;

  if (Sender = cbUpperCase) and cbUpperCase.Checked then begin
    cbLowerCase.Checked := False;
    cbTitleCase.Checked := False;
  end
  else if (Sender = cbTitleCase) and cbTitleCase.Checked then
      cbUpperCase.Checked := False
  else if (Sender = cbLowerCase) and cbLowerCase.Checked then
      cbUpperCase.Checked := False;
  rbMoveNumberToStart.Enabled := cbMoveFileNumber.Checked;
  rbMoveNumberToEnd.Enabled := cbMoveFileNumber.Checked;
end;
{$ENDREGION}

end.
