unit mainf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ExtDlgs, CastleDialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnChooseSrcImage: TButton;
    CheckAvgRect: TCheckBox;
    CheckTwoColors: TCheckBox;
    LabelURL: TLabel;
    LabelRectWidth: TLabel;
    LabelRectWidth1: TLabel;
    LabelRectWidth2: TLabel;
    OpenDialog: TCastleOpenImageDialog;
    SpinTwoColorsLevel: TSpinEdit;
    SpinRectWidth: TSpinEdit;
    SpinRectHeight: TSpinEdit;
    procedure BtnChooseSrcImageClick(Sender: TObject);
    procedure LabelURLClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ImageSegmentsUtils, CastleLCLUtils, CastleImages, CastleUtils, ShowResultF,
  LCLIntf;

{$R *.lfm}

{ TForm1 }

procedure TForm1.BtnChooseSrcImageClick(Sender: TObject);
var
  OutFileName: string;
begin
  if OpenDialog.Execute then
  begin
    AvgRect := CheckAvgRect.Checked;
    TwoColors := CheckTwoColors.Checked;
    TwoColorLevel := SpinTwoColorsLevel.Value;
    OutFileName := AppendToFilename(OpenDialog.FileName, '_out');
    DoImageSegments(OpenDialog.URL, OutFileName,
      SpinRectWidth.Value, SpinRectHeight.Value);
    ShowResult.FileName:= OutFileName;
    ShowResult.ShowModal;
  end;
end;

procedure TForm1.LabelURLClick(Sender: TObject);
begin
  OpenURL((Sender as TLabel).Caption);
end;

end.

