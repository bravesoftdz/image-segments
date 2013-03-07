unit ShowResultF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TShowResult }

  TShowResult = class(TForm)
    ButtonOpenImage: TBitBtn;
    ButtonOpenDir: TBitBtn;
    ButtonClose: TBitBtn;
    Image1: TImage;
    LabelResult: TLabel;
    procedure ButtonOpenDirClick(Sender: TObject);
    procedure ButtonOpenImageClick(Sender: TObject);
  private
    FFileName: string;
    procedure SetFileName(AValue: string);
    { private declarations }
  public
    property FileName: string read FFileName write SetFileName;
  end;

var
  ShowResult: TShowResult;

implementation

uses LCLIntf;

{$R *.lfm}

{ TShowResult }

procedure TShowResult.ButtonOpenDirClick(Sender: TObject);
begin
  OpenDocument(ExtractFilePath(FileName));
end;

procedure TShowResult.ButtonOpenImageClick(Sender: TObject);
begin
  OpenDocument(FileName);
end;

procedure TShowResult.SetFileName(AValue: string);
begin
  FFileName := AValue;
  LabelResult.Caption := 'Pełną wersję pliku zapisano do "' +  AValue + '".';
  Image1.Picture.LoadFromFile(AValue);
end;

end.

