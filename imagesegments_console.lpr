uses SysUtils, ImageSegmentsUtils, CastleParameters;
var
  SrcImageFilename, OutImageFilename: string;
  RectWidth, RectHeight: Integer;
begin
  Parameters.CheckHigh(4);
  SrcImageFilename := Parameters[1];
  OutImageFilename := Parameters[2];
  RectWidth := StrToInt(Parameters[3]);
  RectHeight := StrToInt(Parameters[4]);
  DoImageSegments(SrcImageFilename, OutImageFilename, RectWidth, RectHeight);
end.
