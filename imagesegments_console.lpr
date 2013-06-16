uses SysUtils, ImageSegmentsUtils, CastleParameters;
var
  SrcImageURL, OutImageURL: string;
  RectWidth, RectHeight: Integer;
begin
  Parameters.CheckHigh(4);
  SrcImageURL := Parameters[1];
  OutImageURL := Parameters[2];
  RectWidth := StrToInt(Parameters[3]);
  RectHeight := StrToInt(Parameters[4]);
  DoImageSegments(SrcImageURL, OutImageURL, RectWidth, RectHeight);
end.
