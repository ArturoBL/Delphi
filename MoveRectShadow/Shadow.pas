unit Shadow;

interface

uses
gr32,gr32_polygons, gr32_vectorutils, gr32_blurs, gr32_blend;

procedure RoundRectShadow(pBm: tbitmap32; pRect : tfloatrect; pFillColor: tcolor32; pOutline: single; pOutlineColor: tcolor32; pRectRadius : single; pShadowColor : tcolor32; pShadowRadius : single; pShadowdistance : integer);
function rrBMShadow(pr : tfloatrect; rectradius:single; shadowradius : single; col : tcolor32) : tbitmap32;

implementation

type
  tShadowClass = class
  public
    procedure PC_BlendModulate(F: TColor32; var B: TColor32; M: TColor32);
  end;


function rrBMShadow(pr : tfloatrect; rectradius:single; shadowradius : single; col : tcolor32) : tbitmap32;
var
  b : tbitmap32;
  rr : tarrayoffloatpoint;
  shc : tshadowclass;
begin
  shc := tshadowclass.Create;

  b := tbitmap32.Create(round(pr.Right-pr.Left + shadowradius * 2)+2, round(pr.Bottom - pr.Top + shadowradius *2)+2);
  b.FillRectS(0,0,b.Width, b.Height,clwhite32);
  rr := roundrect(floatrect(shadowradius + 1,shadowradius + 1,pr.Right-pr.Left + shadowradius+1, pr.Bottom - pr.top + shadowradius+1),rectradius);
  //b.Clear(clwhite32);
  //rr := RoundRect(pr,rectradius);
  polygonfs(b,rr,col);
  GaussianBlurGamma(b, shadowradius);
  b.OnPixelCombine := shc.PC_BlendModulate;
  b.DrawMode := dmCustom;
  result := b;
end;

procedure RoundRectShadow(pBm: tbitmap32; pRect : tfloatrect; pFillColor: tcolor32; pOutline: single; pOutlineColor: tcolor32; pRectRadius : single; pShadowColor : tcolor32; pShadowRadius : single; pShadowdistance : integer);
var
  r : tarrayoffloatpoint;
  bs : tbitmap32;
begin
  r := RoundRect(pRect,pRectRadius);

  bs := rrBMShadow(prect,pRectRadius,pshadowradius,pShadowColor);
  pbm.Draw(round(prect.Left - pShadowRadius + pShadowDistance), round(prect.Top- pShadowRadius + pShadowDistance),bs);
  bs.Free;
  polygonfs(pBm,r,pFillColor);
  polylinefs(pBm,r,pOutlineColor,true,pOutline);
end;

{ tShadowClass }

procedure tShadowClass.PC_BlendModulate(F: TColor32; var B: TColor32;
  M: TColor32);
begin
  B := BlendColorModulate(F, B);
end;

end.
