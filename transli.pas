Procedure transli(min,max,mip,map:real;var a,b:real);
begin
  a:=(mip-map)/(min-max);
  b:=(min*map-mip*max)/(min-max);
end;