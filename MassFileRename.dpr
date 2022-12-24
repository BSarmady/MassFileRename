program MassFileRename;

uses
  Forms,
  uMassFileRename in 'uMassFileRename.pas' {fmMassFileRename},
  uRegistry in 'uRegistry.pas',
  uline in 'uline.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMassFileRename, fmMassFileRename);
  Application.Run;
end.
