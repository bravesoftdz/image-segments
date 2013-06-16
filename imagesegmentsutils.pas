unit ImageSegmentsUtils;

{$mode objfpc}{$H+}

interface

uses CastleVectors;

var
  { Average the colors within each rectangle. }
  AvgRect: boolean = true;
  { Based on average rectangle color, convert it to either light or dark. }
  TwoColors: boolean = true;
  TwoColorLevel: Byte = High(Byte) div 2;
  TwoColorDark: TVector3Byte = (20, 20, 20);
  TwoColorLight: TVector3Byte = (255, 100, 100);
  { Colors of bars dividing rectangles. }
  BorderColor: TVector3Byte = (0, 0, 0);

procedure DoImageSegments(const SrcImageURL: string;
  const OutImageURL: string;
  const RectWidth, RectHeight: Integer);

implementation

uses SysUtils, CastleImages, CastleUtils, CastleColors;

procedure DoImageSegments(const SrcImageURL: string;
  const OutImageURL: string;
  const RectWidth, RectHeight: Integer);
var
  SrcImage: TRGBImage;

  RectAvgColorCache: boolean;
  RectAvgColorCacheX: Integer;
  RectAvgColorCacheY: Integer;
  RectAvgColorCacheResult: TVector3Byte;

  function RectAvgColor(const RectX, RectY: Integer): TVector3Byte;
  var
    X, Y, X1, X2, Y1, Y2: Integer;
    Avg: TVector3Double; // Double to keep the sum of many bytes
    Count: Cardinal;
  begin
    if RectAvgColorCache and
       (RectAvgColorCacheX = RectX) and
       (RectAvgColorCacheY = RectY) then
      Exit(RectAvgColorCacheResult);

    X1 := Max(0, RectX * RectWidth);
    X2 := Min(SrcImage.Width - 1, (RectX + 1) * RectWidth - 1);
    Y1 := Max(0, RectY * RectHeight);
    Y2 := Min(SrcImage.Height - 1, (RectY + 1) * RectHeight - 1);

    Count := (X2 - X1 + 1) * (Y2 - Y1 + 1);
    if Count <> 0 then
    begin
      Avg := Vector3Double(0, 0, 0);
      for X := X1 to X2 do
        for Y := Y1 to Y2 do
        begin
          Avg[0] += PVector3Byte(SrcImage.PixelPtr(X, Y))^[0];
          Avg[1] += PVector3Byte(SrcImage.PixelPtr(X, Y))^[1];
          Avg[2] += PVector3Byte(SrcImage.PixelPtr(X, Y))^[2];
        end;
      Result := Vector3Byte(
        Clamped(Round(Avg[0] / Count), Low(Byte), High(Byte)),
        Clamped(Round(Avg[1] / Count), Low(Byte), High(Byte)),
        Clamped(Round(Avg[2] / Count), Low(Byte), High(Byte))
      );
    end else
      { may happen in case rect is outside our range }
      Result := Vector3Byte(0, 0, 0);

    if TwoColors then
      if GrayscaleValue(Result) > TwoColorLevel then
        Result := TwoColorLight else
        Result := TwoColorDark;

    RectAvgColorCache := true;
    RectAvgColorCacheX := RectX;
    RectAvgColorCacheY := RectY;
    RectAvgColorCacheResult := Result;
  end;

var
  X, Y, XOut, YOut, RectX, RectY: Integer;
  OutImage: TCastleImage;
begin
  SrcImage := LoadImage(SrcImageURL, [TRGBImage]) as TRGBImage;
  try
    OutImage := TRGBImage.Create(
      SrcImage.Width div RectWidth + SrcImage.Width,
      SrcImage.Height div RectHeight + SrcImage.Height);

    YOut := 0;
    RectY := -1; { in the 1st loop iteration this will become 0 }
    for Y := 0 to SrcImage.Height - 1 do
    begin
      if Y mod RectHeight = 0 then
      begin
        for XOut := 0 to OutImage.Width - 1 do
          PVector3Byte(OutImage.PixelPtr(XOut, YOut))^ := BorderColor;
        Inc(YOut); if YOut >= OutImage.Height then Break;
        Inc(RectY);
      end;

      XOut := 0;
      RectX := -1; { in the 1st loop iteration this will become 0 }
      for X := 0 to SrcImage.Width - 1 do
      begin
        if X mod RectWidth = 0 then
        begin
          PVector3Byte(OutImage.PixelPtr(XOut, YOut))^ := BorderColor;
          Inc(XOut); if XOut >= OutImage.Width then Break;
          Inc(RectX);
        end;

        if AvgRect then
          PVector3Byte(OutImage.PixelPtr(XOut, YOut))^ := RectAvgColor(RectX, RectY) else
          PVector3Byte(OutImage.PixelPtr(XOut, YOut))^ := PVector3Byte(SrcImage.PixelPtr(X, Y))^;
        Inc(XOut); if XOut >= OutImage.Width then Break;
      end;
      Inc(YOut); if YOut >= OutImage.Height then Break;
    end;

    SaveImage(OutImage, OutImageURL);
  finally
    FreeAndNil(SrcImage);
    FreeAndNil(OutImage);
  end;
end;

end.
