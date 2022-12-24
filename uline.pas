unit uline;

interface

uses
  Windows, Messages, Graphics, SysUtils, Classes, Controls;

type
  TLineDirection = (ldHorizontal, ldVertical);

  TLine = class(TGraphicControl)
  private

    FLineDirection: TLineDirection;
    FArrowFactor: Integer;

    function GetSize: Integer;
    function GetColor: TColor;
    procedure SetSize(const aSize: Integer);
    procedure SetColor(const aColor: TColor);
    procedure SetDirection(const aDirection: TLineDirection);

  protected

    procedure Paint; override;

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published

    property DragCursor;
    property DragKind;
    property DragMode;
    property Align;
    property ParentShowHint;
    property Hint;
    property ShowHint;
    property Visible;
    property PopupMenu;
    property Direction: TLineDirection read FLineDirection write SetDirection default ldHorizontal;
    property Color: TColor read GetColor write SetColor default clGrayText;
    property LineWidth: Integer read GetSize write SetSize default 1;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEndDock;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnClick;
    property OnDblClick;
  end;

procedure Register;

implementation

constructor TLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 64;
  Height := 4;
  SetSize(1);
  SetColor(clWindowFrame);

end;

destructor TLine.Destroy;
begin
  inherited Destroy;
end;

function TLine.GetSize: Integer;
begin
  Result := Canvas.Pen.Width;
end;

function TLine.GetColor: TColor;
begin
  Result := Canvas.Pen.Color;
end;

procedure TLine.SetSize(const aSize: Integer);
begin
  if aSize <> Canvas.Pen.Width then
  begin
    Canvas.Pen.Width := aSize;
    Invalidate;
  end;
end;

procedure TLine.SetColor(const aColor: TColor);
begin
  if aColor <> Canvas.Pen.Color then
  begin
    Canvas.Pen.Color := aColor;
    Invalidate;
  end;
end;

procedure TLine.SetDirection(const aDirection: TLineDirection);
begin
  if aDirection <> FLineDirection then
  begin
    FLineDirection := aDirection;
    Invalidate;
  end;
end;

procedure TLine.Paint;
var
  start: Integer;
  p1, p2, p3: TPoint;
  H0, W0, H, W: Integer;
  Alfa: extended;
begin
  inherited;
  if (FLineDirection = ldHorizontal) then begin
    start := Canvas.Pen.Width div 2;
    Canvas.MoveTo(0, start);
    Canvas.LineTo(Width, start);
  end
  else begin
    start := Canvas.Pen.Width div 2;
    Canvas.MoveTo(start, 0);
    Canvas.LineTo(start, Height);
  end;

end;

procedure Register;
begin
  RegisterComponents('Additional', [TLine]);
end;

end.
