pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- renoiser 0.1.2 beta
-- by magnus runesson
a=9
b=7
c=8
d=0x3100
e=0x1200
f=0x4400
g=5
h=4
i=2
j=3
k=0
l=1
m="h"
n="l"
o="k"
p="s"
q="q"
r="w"
s="e"
t="r"
u="t"
v="c"
w="b"
x="d"
y="c"
z="b"
ba="f"
bb="d"
bc="0.1.2 beta"
bd=true
be={}
bf=
{
[0]=0b1001100100000110,
0b0011100010000011,
0b0110000010011001,
0b1100000100011100,
}
function _init()
printh("reboot")
cartdata("pw_renoiser")
poke(0x5f2d,1)
if stat(102)~=0 then
_update60=function() end
_draw=bg
return
end
bh={}
for bi=0,15 do
local bj=2048+bi
bh[bi]={[0]=bi}
for bk=1,7 do
bj+=64
bh[bi][bk]=peek(bj)
end
end
local bl=true
local bm=0
local bn=function()
cls()
local bo=flr(bm)
for bp=0,15 do
pal(bp,bh[bp][7-bo])
end
spr(80,5,40,16,3)
pal()
bq()
flip()
end
music(0)
while bl do
br()
bs()
bn()
if bm<7 then
bm+=1
end
if bt() or bu(1) then
bl=false
end
end
while bm>0 do
bs()
bn()
bm-=1
end
music(-1,500)
bv()
bw()
bx()
by=1
end
function _update60()
br()
bs()
local bz={}
for bi=#ca,1,-1 do
local cb=ca[bi]
cb.cc-=1
if cb.cc<0 then
del(ca,cb)
end
end
if cd(m) then
ce()
else
if bd then
if(cf(1) and not(cg<8 and ch<8)) or bt() then
ce()
end
end
end
if bd then
ci()
else
if not cj() then
if cd(q) then
ck()
end
if cd(s) then
cl()
end
if cd(r) then
cm()
end
if cd(t) then
cn()
end
if cd(u) then
co()
end
if cg<7 and cf(1) then
cp().bm()
end
end
end
end
function bg()
cq(cr)
end
function br()
cs=be or{}
be={}
while stat(30) do
be[stat(31)]=true
end
end
function bt()
return ct(be)>0
end
function cd(cu)
return be[cu] and true or false
end
function _draw()
cls(0)
if not cv() then
spr(160,0,0,16,1)
if bd then
spr(156,0,0)
end
if cw then
spr(154,8,0)
end
if cg<7 then
cx=function()
rectfill(0,7,127,13,8)
print(cp().cy,1,8,15)
end
end
spr(150,cz*16,0,2,1)
end
if bd then
da()
cx=nil
end
bq()
local db=128
for cb in all(ca) do
local dc=dd(cb)
clip(0,db-dc,127,dc)
rectfill(0,0,127,127,8)
print(cb.de,1,db-dc+1,15)
db-=dc
end
clip()
pal(4,0+128,1)
df()
end
function dg()
return
peek2(0x5f28)+ch,
peek2(0x5f2a)+cg
end
function bq()
local dh,di=dg()
if cx then
cx()
cx=nil
end
spr(32,dh-1,di-1,1,2)
end
cr=[[\✽05 \🐱14♥ \🐱07 welcome to renoiser! \🐱14♥ \🐱07

 this is a tool for copying
   songs and sfxs between
         cartridges.

 it also let you move sfxs
 and songs around within a
         cartridge.

\🐱08
           error!
  you need to download the
  cart and run it locally!
]]
function cq(de,dj)
rectfill(6,9,122,120,1)
rect(6,9,122,120,7)
dk(de,9,11,dj)
end
function dl(dm,db,bp)
local dn=(128-(#dm*4))/2
print(dm,dn,db,bp)
end
function dp(dm,db,bp)
print(dm,0,db,bp)
end
function dq(dm,db,bp)
local dn=128-(#dm*4)
print(dm,dn,db,bp)
end
dr=1
ds=2
dt=0
du=0
ch=0
cg=0
function bs()
dv=nil
dw=nil
ch=stat(32)
cg=stat(33)
dt=du
du=stat(34)
local dx=bxor(dt,du)
dy=band(dx,du)
dz=band(dx,dt)
end
function df()
if dv and cf(1) then
dv()
end
if dw and cf(2) then
dw()
end
end
function bu(ea)
return band(du,ea)==ea
end
function cf(ea)
return band(dy,ea)==ea
end
function eb(ea)
return band(dz,ea)==ea
end
ec=60*2
ed=7
ca={}
function ee(de)
add(ca,{
de=de,
cc=ec,
})
end
function dd(cb)
if(cb.cc>ec-ed) return ec-cb.cc
if(cb.cc>ed) return ed
if(cb.cc>0) return cb.cc
return 0
end
function ef(de)
rect(0,0,127,127,c)
dl("*** guru meditation ***",10,c)
print(de,2,20,b)
dl("❎ ok",121,b)
end
function eg()
return btnp(h) or btnp(g)
end
eh=
[[ 😐 - failed to load cartridge

you must run renoiser from
the directory in which your
cartridges are located

for example if your cartridge
is in /stuff/grategame.p8
renoiser.p8 must be in /stuff/

you must also start renoiser
in that folder. like this:

cd /stuff/
load renoiser.p8
]]
ei=
[[ ⌂ - location error

you must run renoiser from
the directory in which your
cartridges are located

for example if your cartridge
is in /stuff/grategame.p8
renoiser.p8 must be in /stuff/

you must also start renoiser
in that folder. like this:

cd /stuff/
load renoiser.p8
]]
function ej(ek)
local el=tostr(ek)
if ek<10 then
el="0"..el
end
return el
end
function stop()
sfx(-1,0)
music(-1)
em=-1
en=false
end
function eo(ep)
local el=cz!=ep
cz=ep
if el then
if eq then
eq()
end
er=true
end
return el
end
function ck()
if eo(1) then
if cz!=2 then
stop()
end
bx()
end
end
function cl()
if eo(3) then
stop()
es()
end
end
function cm()
if eo(2) then
if cz!=1 then
stop()
end
et()
end
end
function cn()
if eo(4) then
stop()
eu()
end
end
function co()
if eo(5) then
stop()
ev()
end
end
function ce()
bd=not bd
if bd and er then
local ew=1
if cj==ex then
ew=3
elseif cj==ey then
ew=5
elseif cj==ez then
ew=7
elseif cj==fa then
ew=9
elseif cj==fb then
ew=11
elseif cj==fc then
ew=13
end
local fd=fe[ew]
local ff=fe[ew+1]
if(by<fd) or(by>ff) then
by=fd
end
er=false
end
end
function fg()
if not fh then
printh("no filename, fail save yo!")
return
end
cstore(d,d,e,fh)
fi(false)
end
function fj(cy,bm)
return{cy=cy,bm=bm}
end
fk={
[0]=fj("help",ce),
fj("no unsaved changes",fg),
fj("song graph",ck),
fj("song graph",ck),
fj("patterns",cm),
fj("patterns",cm),
fj("sound effects",cl),
fj("sound effects",cl),
fj("patterns copy buffer",cn),
fj("patterns copy buffer",cn),
fj("sound effects copy buffer",co),
fj("sound effects copy buffer",co),
fj("",function() end),
fj("",function() end),
fj("",function() end),
fj("",function() end),
}
cz=1
cw=false
function fi(fl)
cw=fl
fk[1].cy=fl and"unsaved changes"or"no unsaved changes"
end
function cp()
return fk[
mid(0,
flr(ch/8)
,15)
]
end
function fm()
palt(0,false)
palt(15,true)
end
function fn(de)
rectfill(30,50,98,84,8)
print(de,31,52,7)
flip()
local el=false
local fo=true
while fo do
br()
if cd("y") then
el=true
fo=false
end
if cd("n") then
fo=false
end
end
return el
end
fp=1
em=-1
fq={}
fr=0
fs=true
ft=0
fu=0
function bx()
cj=ey
cv=fv
eq=nil
end
function fw()
fx=stat(24)
fy={}
fz={}
ga={}
local gb
for gb=0,3 do
local gc=stat(16+gb)
local gd=stat(20+gb)
fy[gc]=gb
fz[gc]=gd
ga[gb]=gc
end
end
function ge()
if gf>0 then
gf-=1
if bt() or cf(2) then
gf=gg
end
if gf<=0 then
gf=0
gh=-1
gi=-1
bv()
bw()
end
return true
end
if cd(n) then
local gj=true
if cw then
gj=fn([[    there are
 unsaved changes

  load anyway?
       y/n]])
end
if gj then
gk(gl)
end
end
if fh!=nil and cd(o) then
local gj=true
if cw then
gj=fn([[    there are
 unsaved changes

  load anyway?
       y/n]])
end
if gj then
if gm(fh) then
ee("reloaded "..fh)
gl(fh)
end
end
end
if cd(p) then
fg()
end
if cd(ba) then
if gn then
go(gn,gp)
gn=nil
else
gn=gp
end
end
if cd("1") then
by=4
ce()
end
fw()
end
function gq(gr)
local gs=-1
if fp==em then
stop()
gs=-1
else
stop()
em=fp
gs=fq[em].gt
if gr then
gs=gr
end
end
music(gs)
end
function gu()
if cd(v) then
gv()
end
if cd(w) then
gw()
bv()
bw()
end
if cd(x) then
if fn([[  really delete
     song ]]..tostr(fp)..[[?

       y/n]]) then
gx()
bv()
bw()
gy()
bv()
bw()
gy()
gz=nil
bv()
bw()
ee("removed "..tostr(#ha).." sfxs")
ee("removed song "..tostr(hb))
ha=nil
hb=nil
end
end
if em!=-1 and fx==-1 then
em=-1
end
if#fq==0 then
fp=-1
else
if btnp(j) then
fp+=1
fs=true
end
if btnp(i) then
fp-=1
fs=true
end
fp=((fp-1)%#fq)+1
if btnp(g) then
gq()
end
end
if btnp(h) then
em=-1
music(em)
end
if cd("+") then
local hc,hd,he=hf(fq[fp])
if hd<63 then
local hg,hh=hd+1,hd+1
local hi=hj(hg)
if hi>-1 then
hg,hh,hk=hf(fq[hi])
fp+=1
fs=true
end
stop()
hl(hc,hd,hh)
end
end
if cd("-") then
local hc,hd,he=hf(fq[fp])
if hc>0 then
local hg,hh=hc-1,hc-1
local hi=hj(hg)
if hi>-1 then
hg,hh,hk=hf(fq[hi])
fp-=1
fs=true
end
stop()
hl(hg,hh,hd)
end
end
end
function ey()
if ge() then
return true
end
gu()
if btn(k) then
ft-=2
end
if btn(l) then
ft+=2
end
end
function gl(hm)
cw=false
fp=1
fs=true
fh=hm
cz=1
stop()
bx()
bv()
bw()
end
function fv()
local hn=fq[fp]
ho()
hp(hn)
hq(hn)
end
function hr(hs,ht,hu)
if(hs>hu) hs=hu
if(hs<ht) hs=ht
return hs
end
function hp(hn)
local hv=51
local hw=16
local dc=13
local hx,hy,hz=hf(hn)
clip(0,hv,128,dc)
rectfill(0,0,128,128,0)
if fs then
ft=(hx*hw)-(hw*0.5)
fs=false
end
ft=hr(ft,-5,((64*hw)-128)+5)
local ia=ft-fu
local ib=ia*0.1
fu+=ib
camera(fu,0)
local dn
for cb=0,63 do
local dm=cb*hw
local cc=hv+1
local bp=5
if ic[cb].id then
bp=4
end
if cb>=hx and cb<=hy then
bp=15
end
if cb==fx then
bp=7
end
ie(hn,cb,dm,cc)
end
camera()
end
ig={
10,7,
5,9,
}
function ih(ii,ij,dm)
local ik=flr(time()*ig[dm])%((#bf)+1)
fillp(bf[ik])
rect(ii,ij,ii+16,ij+8,ig[dm+1])
fillp()
end
function il(hn,cb,dn,db,im,io)
local bp=8
if ip(hn,cb) then
bp=2
elseif iq(hn,cb) then
bp=3
else
if not hn and ir(cb) then
bp=3
else
if is[cb] then
bp=1
else
if it[cb].iu then
bp=4
else
bp=-1
end
end
end
end
if bp==-1 then
rectfill(dn,db,dn+14,db+6,4)
local iv=ej(cb)
print(iv,dn+4,db+1,0)
else
if im then
bp=im
end
rectfill(dn,db,dn+14,db+6,bp)
pal()
end
for iw=0,14 do
local bi=flr(iw*2)
local dc=it[cb].ix[bi]
local bp=it[cb].iy[bi]
if bp!=0 then
local iz=5
if it[cb].ja[iw] then
iz=3
end
line(dn+iw,db+6,dn+iw,db+6-dc,iz)
pset(dn+iw,db+6-dc,bp)
end
end
if fy[cb] then
local bi=fz[cb]/32
local jb=bi*15
line(dn+jb,db,dn+jb,db+6,7)
end
local ii=dn-1
local ij=db-1
if cb==gp then
rect(ii,ij,ii+16,ij+8,7)
end
if cb==gn then
ih(ii,ij,1)
end
if jc(cb)
and(jd==fh)
and not io then
ih(ii,ij,3)
end
local dh,di=dg()
if(dh>=dn)
and(dh<=dn+15)
and(di>=db)
and(di<=db+7) then
cx=function()
je(cb)
end
dv=function()
if gp==cb then
if en then
stop()
else
sfx(gp,0)
en=true
end
else
stop()
gp=cb
end
end
dw=function()
if gf>0 then
return
end
if gn==nil then
gn=cb
else
go(gn,cb)
gn=nil
end
end
end
end
function jf(hn)
for gc=0,63 do
if gc!=gh and gc!=gi then
il(hn,gc,band(gc,0x07)*16,band(gc,0xf8))
end
end
if gf>0 then
jg(gh,gi,gf)
end
end
function hq(hn)
clip(0,64,128,128)
camera(0,-64)
jf(hn,0)
camera()
clip()
end
function ho()
local jh=20
local ji=jh*2.25
clip(1,8,125,ji)
rectfill(0,0,128,118,0)
local jj=(fp-2)*20
jj=hr(jj,0,((#fq)*20)-ji)
local jk=fr
local ia=jj-jk
local ib=ia*0.1
fr+=ib
camera(-1,fr-8)
local dn=0
local db=0
if#fq==0 then
print("  …… no songs 😐 ……",0,0,8)
elseif fq then
for bi=1,#fq do
local jl=b
if fp==bi then
jl=a
end
local hn=fq[bi]
local jm=tostr(hn.gt)
if hn.jn and hn.gt!=hn.jn then
jm=jm.."("..tostr(hn.jn)..")"
end
jm=jm.."-"
if hn.jo then
jm=jm..tostr(hn.jo).." (looping)"
elseif hn.stop then
jm=jm..tostr(hn.stop)
end
print("song "..tostr(bi)..": "..jm,dn,db,jl)
db+=6
local jp=""
for jq,ek in pairs(hn.jr) do
if jp!=""then
jp=jp..";"
end
jp=jp..tostr(jq).."("..tostr(ek)..")"
end
print("sfxs: "..jp,dn,db,jl)
db+=6
local js=""
for jq,ek in pairs(hn.jt) do
if js!=""then
js=js..";"
end
js=js..tostr(jq).."("..tostr(ek)..")"
end
print("instruments: "..js,dn,db,jl)
db+=6
db+=2
end
end
camera()
clip()
end
function ir(gc)
if gc<8 then
if#ju[gc].jr>0 then
return true
end
end
return false
end
function jv(gc)
if is[gc] then
printh("sfx "..tostr(gc).." referred to from pattern")
return true
end
return ir(gc)
end
function gx()
hb=fp
ha={}
gz={}
local hn=fq[fp]
local hx,hy,hz=hf(hn)
for gc,jw in pairs(hn.jr) do
add(gz,gc)
end
for gc,jw in pairs(hn.jt) do
add(gz,gc)
end
local jx=0x3100+(hx*4)
for cb=0,hz-1 do
poke4(jx+(cb*4),0x4040.4040)
end
end
function gy()
for gc in all(gz) do
if not jv(gc) then
printh("removing sfx "..tostr(gc))
jy(gc)
end
end
end
function jy(gc)
local jz=0x3200+(gc*68)
memset(jz,0,68)
local hs=true
for ew in all(ha) do
if ew==gc then
hs=false
break
end
end
if(hs) add(ha,gc)
end
function ka(gc,dn,db)
local dc=16
rectfill(dn,db,dn+31,db+dc,0)
for iw=0,31 do
local kb=it[gc].iy[iw]
if kb!=0 then
local kc=it[gc].ix[iw]
kc*=(dc/6)
local iz=5
if it[gc].ja[iw] then
iz=3
end
line(dn+iw,db+dc-kc,dn+iw,db+dc,iz)
pset(dn+iw,db+dc-kc,kb)
end
end
if fy[gc] then
local bi=fz[gc]
line(dn+bi,db,dn+bi,db+dc,7)
end
end
function kd(hw,dc)
local dn,db=ch,cg
if db+dc>=120 then
db=db-dc
else
db+=6
end
if dn+hw>=126 then
dn=dn-hw
else
dn+=3
end
return dn,db
end
function ke(hn,hw,dc,dn,db)
fm()
spr(hn,dn-1,db-1,hw,dc)
palt()
return dn,db
end
function je(gc)
local dn,db=
ke(
192,5,4,
kd(37,25))
ka(gc,dn,db+7)
print(" sfx "..ej(gc),dn,db+1,7)
end
function kf(kg)
local dn,db=ke(
197,9,4,
kd(63,27))
print("pattern "..ej(kg),dn+12,db+1,7)
db+=15
for bi=0,3 do
local gc=ic[kg].jr[bi]
if gc!=-1 then
il(nil,gc,dn,db,0)
rectfill(dn,db+8,dn+14,db+12,8+band(gc,7))
print(ej(gc),dn+4,db+8,1)
end
dn+=16
end
end
function ie(kh,kg,dn,db)
local ki=ic[kg].ki
local kj=false
if kg<63 then
kj=ic[kg+1].ki
end
local kk=128
local kl=129
local hi=132
local hx,hy,hz=hf(kh)
if not ic[kg].id then
pal(13,1)
if(kg>0) and(not ic[kg-1].id) then
ki=true
end
if(kg<63) and(not ic[kg+1].id) then
kj=true
hi=133
end
end
if kg>=hx and kg<=hy then
pal(13,6)
end
if kg==fx then
pal(13,7)
end
if(ki) kk=130
if(kj) kl=131
spr(kk,dn,db,1,2)
spr(kl,dn+8,db,1,2)
if kj then
spr(hi,dn+15,db,1,2)
end
pal()
fm()
local km=ic[kg].jn
local kn=ic[kg].jo
local ko=ic[kg].kp
local kq=ic[kg].kr
local ks=-1
if km and kn then
ks=138
elseif km then
ks=135
elseif kn then
ks=136
elseif ko and kq then
ks=139
elseif ko then
ks=134
elseif kq then
ks=137
end
spr(ks,dn+1,db)
palt()
local kt=dn+2
for bp=0,3 do
local gc=ic[kg].jr[bp]
if gc!=-1 then
line(kt,db+9,kt+1,db+9,8+band(gc,7))
end
kt+=3
end
if kg==fx then
local bo=flr(time()*3)%3
spr(140+bo,dn+7,db+1)
else
local iv=ej(kg)
local bp=ic[kg].id and 1 or 0
print(iv,dn+7,db+2,bp)
end
local dh,di=dg()
if(dh>=dn)
and(dh<=dn+15)
and(di>=db)
and(di<=db+11) then
cx=function()
kf(kg)
end
dv=function()
local bi=hj(kg)
if bi>-1 then
if fp==bi then
gq(kg)
else
fp=bi
fs=true
end
end
end
end
end
gp=0
gf=0
ku=4
kv=4
kw=40
gh=-1
gi=-1
en=false
gg=
ku*
kv
kx=
kw+
gg
function es()
cj=fa
cv=ky
eq=nil
end
function fa()
if btnp(i) then
gp-=8
end
if btnp(j) then
gp+=8
end
if btnp(k) then
gp-=1
end
if btnp(l) then
gp+=1
end
gp=band(gp,63)
if ge() then
return true
end
if cd(y) then
memcpy(f,d,e)
kz=nil
jd=fh
if not jc(gp) then
la=la or{}
add(la,gp)
ee("added sfx "..tostr(gp).." to copy list")
else
for jq,ek in pairs(la) do
if ek==gp then
la[jq]=nil
ee("removed sfx "..tostr(gp).." from copy list")
break
end
end
end
end
if cd(z) then
lb()
end
if cd(bb) then
if gp then
if fn([[  really delete
     sfx ]]..tostr(gp)..[[?

       y/n]]) then
local lc=
d+
0x0100+
(gp*68)
memset(lc,0,68)
bw()
end
end
end
if btnp(g) then
sfx(gp,0)
en=true
end
if btnp(h) then
stop()
en=false
end
end
function jc(gc)
if(not la) return
for jq,ek in pairs(la) do
if(gc==ek) return true
end
end
function ld(dc)
local le=band(dc,7)
local lf=band(shr(dc,3),7)
le*=16
lf*=8
return le,lf
end
function ky()
camera(0,-8)
jf(nil,0)
local gc=gp
local db=64
local dn=0
print("sfx "..tostr(gc).." is used by patterns:",0,db,7)
db+=6
if#lg[gc].lh==0 then
print("-- no patterns",0,db,7)
else
for li,lj in pairs(lg[gc].lh) do
local de=tostr(lj)..","
print(de,dn,db,7)
dn+=(#de)*4
if dn>127 then
dn=0
db+=6
end
end
end
db+=6
dn=0
db+=2
print("sfx "..tostr(gc).." is used by songs:",0,db,7)
db+=6
if#lg[gc].lk==0 then
print("-- no songs",0,db,7)
else
for li,kh in pairs(lg[gc].lk) do
local de=tostr(kh)..","
print(de,dn,db,7)
dn+=(#de)*4
if dn>127 then
dn=0
db+=6
end
end
end
db+=6
dn=0
db+=2
if it[gc].iu then
print("has notes",0,db,7)
else
print("doesn't have any notes",0,db,7)
end
db+=6
if gc<8 then
db+=2
print("instrument "..tostr(gc).." is used by sfxs:",0,db,7)
db+=6
if#ju[gc].jr==0 then
print("-- no sfxs",0,db,7)
else
for li,ll in pairs(ju[gc].jr) do
local de=tostr(ll)..","
print(de,dn,db,7)
dn+=(#de)*4
if dn>127 then
dn=0
db+=6
end
end
end
db+=6
dn=0
end
camera()
end
function lm(gc)
return(gc<8) and(#ju[gc].jr>0)
end
function ln(gc)
return#lg[gc].lh>0
end
function lo(gc)
return it[gc].iu
end
function lp(gc)
return gc<8
end
function go(lq,lr)
if lq==lr then
return
end
stop()
if ir(lq) and lr>=8 then
ee("and cannot be moved to slot "..tostr(lr))
ee("error: sfx "..tostr(lq).." is instrument")
return
end
if ir(lr) and lq>=8 then
ee("and cannot be moved to slot "..tostr(lq))
ee("error: sfx "..tostr(lr).." is instrument")
return
end
gh=lq
gi=lr
gf=kx
ee("swapped sfxs "..tostr(lq).." and "..tostr(lr))
fi(true)
local lt=0x3200+(lq*68)
local lu=0x3200+(lr*68)
local lv=0x4300
memcpy(lv,lt,68)
memcpy(lt,lu,68)
memcpy(lu,lv,68)
local lw={
[lq]=lr,
[lr]=lq
}
local lx={
}
for hn=0,63 do
lx[hn]=hn
end
ly(lx,lw)
lz(lw,0,63)
bv()
bw()
end
function jg(hs,ea,ma)
local mb=ku
local mc=kv
local md=gg
local cc=(ma-md)/kw
local me=1-cc
local mf,mg=ld(hs)
local mh,mi=ld(ea)
local iw=(mf*cc)+(mh*me)
local mj=(mg*cc)+(mi*me)
local mk=(mh*cc)+(mf*me)
local ml=(mi*cc)+(mg*me)
if ma<md then
iw=mf
mj=mg
mk=mh
ml=mi
hs,ea=ea,hs
end
il(nil,ea,iw,mj)
il(nil,hs,mk,ml)
if ma<md then
local mm=mb-(flr(ma/mc)+1)
local kt=mm*32
sspr(kt,0,32,16,mf-8,mg-4)
sspr(kt,0,32,16,mh-8,mi-4)
end
end
function lb()
local mn=#la
local mo=mp(mn)
if mo==nil then
ee("not enough free sfx slots")
return
end
ee("pasted "..tostr(mn).." sfxs")
for bi=1,mn do
mq(
la[bi],
mo[mn])
mn-=1
end
bw()
end
function et()
cj=ez
cv=mr
eq=nil
end
function ez()
ge()
gu()
end
function mr()
if fp==-1 then
print("  …… no songs 😐 ……",1,1,8)
else
print("song "..tostr(fp),1,1,9)
end
local hn=fq[fp]
local dn,db=0,8
for kg=0,63 do
ie(hn,kg,band(kg,7)*16,8+band(kg,0xf8)*1.5)
end
for bp=0,3 do
local gc=ga[bp]
local dn=bp*32
local db=104
rectfill(dn,db,dn+31,db+6,1+band(bp,1))
print("chan "..tostr(bp),dn+4,db+1,0)
if gc>=0 then
ka(gc,dn,db+7)
end
end
end
function eu()
cj=fb
cv=ms
eq=mt
mt()
end
function ev()
cj=fc
cv=mu
eq=mt
mt()
mv={}
mw={}
local mx,my=0,0,0
for ll=0,63 do
if kz then
if kz.jt[ll] then
mv[mx]=ll
mx+=1
end
if kz and kz.jr[ll] then
mw[my]=ll
my+=1
end
else
if la and jc(ll) then
mw[my]=ll
my+=1
end
end
end
end
function mz()
ge()
end
function fb()
mz()
if btnp(g) then
music(kz.gt)
end
if btnp(h) then
stop()
end
end
function fc()
mz()
end
function ms()
local bn=function(de)
print(de,(128-#de*4)/2,60,8)
end
if not kz then
bn("nothing in copy buffer")
return
end
local hx,hy,hz=hf(kz)
if hz==0 then
bn("copied song is 0 patterns")
return
end
camera(0,-8)
print("copied patterns:",2,0,9)
local hn=nil
local dn,db=0,7
for kg=hx,hy do
ie(hn,kg,dn,db)
dn+=16
if dn>112 then
dn=0
db+=12
end
end
camera()
end
function mu()
if not kz and not la then
local de="nothing in copy buffer"
print(de,(128-#de*4)/2,60,8)
return
end
if kz then
local mn=kz.na
if mn==0 then
local de="copied song have 0 sfxs?"
print(de,(128-#de*4)/2,60,8)
return
end
end
camera(0,-8)
print("copied instruments:",2,0,9)
print("copied sfxs:",2,20,9)
local ll
local bi=0
for db=8,64,8 do
for dn=0,127,16 do
ll=mv[bi]
if ll!=nil then
il(nil,ll,dn,db,nil,true)
end
ll=mw[bi]
if ll!=nil then
il(nil,ll,dn,20+db,nil,true)
end
bi+=1
end
end
camera()
end
nb=10
function gk(nc)
cv=nd
cj=ex
bd=false
ne=ls()
nf=0
ng=0
nh=nc
er=true
ni=true
for jq,ek in pairs(ne) do
printh(tostr(jq).."="..tostr(ek))
if sub(ek,1,8)=="renoiser"then
ni=false
elseif sub(ek,1,11)=="pw_renoiser"then
ni=false
end
end
end
function nd()
if ni then
ef(ei)
return true
end
if nj then
ef(eh)
return true
end
dl("-- load file --",1,7)
if#ne==0 then
dl("no files found",10,8)
return true
end
local dn=10
local db=10
local gd
for gd=1,nb do
local nk=(ng*nb)+gd
if nk>#ne then
break
end
local ek=ne[nk]
local bp=b
if nf+1==nk then
bp=a
end
print(ek,dn+10,db,bp)
db+=6
end
print("❎",dn,10+((nf-(ng*nb))*6),a)
print("❎: load - 🅾️: cancel",dn,120,b)
return true
end
function ex()
if ni then
if eg() then
bd=true
bx()
end
return
end
if nj then
if eg() then
bd=true
bx()
end
return
end
if btnp(j) then
nf=nf+1
end
if btnp(i) then
nf=nf-1
end
nf=nf%#ne
while nf<ng*nb do
ng-=1
end
while nf>=(ng+1)*nb do
ng+=1
end
if btnp(g) then
local hm=tostr(ne[nf+1])
if gm(hm) then
fi(false)
ee("loaded "..hm)
if nh then
nh(hm)
end
else
nj=true
end
end
if btnp(h) then
bx()
end
return true
end
function gm(hm)
local nl=e
local nm=reload(d,d,nl,hm)
return nm==nl
end
by=1
nn=27
no={}
np=[[

]]
function dk(nq,dn,db,dj)
local nr=dn
local bp=7
dj=dj or 0
ns=0
local bi=1
if(dj>0) then
if no[dj] then
bi=no[dj]
dj=0
end
end
while bi<#nq do
local hn=sub(nq,bi,bi)
bi+=1
if hn=="\\"then
hn=sub(nq,bi,bi)
bi+=1
if dj>0 then
if hn=="◆"then
dj-=1
ns+=1
no[ns]=bi
end
else
if hn=="🐱"then
bp=tonum(sub(nq,bi,bi+1),true)
bi+=2
elseif hn=="✽"then
db+=tonum(sub(nq,bi,bi+1))
bi+=2
elseif hn=="➡️"then
dn+=tonum(sub(nq,bi,bi+1))
bi+=2
elseif hn=="█"then
local jl=tonum(sub(nq,bi,bi+1))
local hw=tonum(sub(nq,bi+3,bi+4))
local dc=tonum(sub(nq,bi+6,bi+7))
rectfill(dn,db,dn+hw,db+dc,jl)
bi+=8
elseif hn=="▥"then
local nt=tonum(sub(nq,bi,bi))
ih(dn,db,nt)
bi+=1
elseif hn=="★"then
local jm=tonum(sub(nq,bi,bi+2))
local hw=tonum(sub(nq,bi+4,bi+5))
local dc=tonum(sub(nq,bi+7,bi+8))
spr(jm,dn,db,hw,dc)
dn+=hw*8
bi+=9
elseif hn=="◆"then
break
end
end
else
if dj==0 then
if hn==np then
dn=nr
db+=6
else
print(hn,dn,db,bp)
dn+=4
end
end
end
end
end
function ci()
fw()
if btnp(g) then
bx()
ge()
end
if btnp(l) or cf(1) then
by+=1
end
if btnp(k) then
by-=1
end
for nu=1,nn do
if cd(tostr(nu)) and nu~=by then
by=nu
end
end
by=((by-1)%nn)+1
end
function da()
cq(nv,by-1)
rectfill(0,121,127,127,1)
local nw="page "..by.."/"..nn
dq("⬅️: "..nw.." :➡️  ",122,7)
print("❎: close",1,122,7)
line(0,120,127,120,7)
end
nx=[[\🐱09]]
fe={
1,5,
6,6,
7,10,
11,14,
15,19,
20,22,
23,25,
26,27,
}
nv=[[\✽05 \🐱14♥ \🐱07 welcome to renoiser! \🐱14♥ \🐱07

 this is a tool for copying
   songs and sfxs between
         cartridges.

 it also let you move sfxs
 and songs around within a
         cartridge.

            \🐱11😐 ?\🐱07

  please take a moment to
   read through the help

  use buttons ]]..nx..[[⬅️ \🐱07 and ]]..nx..[[➡️ \🐱07 to
     flip page in help
\◆          \🐱07renoiser
      version ]]..bc..[[ 
     by magnus runesson
\✽05\🐱06keyboard:\🐱07
]]..nx..m..[[\🐱07: show help
\✽03]]..nx..n..[[\🐱07: load cartridge
]]..nx..o..[[\🐱07: reload current cartridge
]]..nx..p..[[\🐱07: save cartridge
\✽03]]..nx..[[q\🐱07/]]..nx..[[w\🐱07/]]..nx..[[e\🐱07/]]..nx..[[r\🐱07/]]..nx..[[t\🐱07: change view
\◆\🐱06▤▤▤▤▤▤▤▤  \🐱07toolbar\🐱06 ▤▤▤▤▤▤▤▤▤\🐱07

\✽-1  \★160,01,01\✽01 click this to open help
\✽02  \★161,01,01\✽01 when lit there are
     unsaved changes.
     click to save.
\✽02\★162,02,01\✽01 the \🐱08song graph view\🐱07
\✽02\★164,02,01\✽01 the \🐱08patterns view\🐱07
\✽02\★166,02,01\✽01 the \🐱08sound effects view\🐱07
\✽02\★168,02,01\✽01 the \🐱08patterns copy
     buffer view\🐱07
\✽02\★170,02,01\✽01 the \🐱08sound effects copy
     buffer view\🐱07
\◆\🐱06▤▤▤▤  \🐱07getting started\🐱06 ▤▤▤▤▤\🐱07

this tool use the multicart
api. that means it needs to
start in a specific way for
it to work.

the cartridge \🐱10pw_renoiser.p8\🐱07
needs to be in the same
folder as the cart you want
to edit.

for example, if you want to
edit \🐱10/stuff/mygame.p8\🐱07

you need to copy renoiser
into \🐱10/stuff/pw_renoiser.p8\🐱07
\◆\🐱06▤▤▤▤  \🐱07getting started\🐱06 ▤▤▤▤▤\🐱07
             
pico-8 also need to have
that folder as working
folder.

type this in console to
get started:
\🐱10cd /stuff/
load pw_renoiser.p8\🐱07

              \🐱12●\🐱07

now you are ready to start
arranging your sound memory!
\◆\🐱06▤▤  \🐱07loading a cartridge\🐱06 ▤▤▤\🐱07

load a cartridge by hitting
']]..nx..tostr(n)..[[\🐱07' on your keyboard while
in edit mode

that will bring up a screen
where you can select which
cart you want to edit.

            \🐱10✽\🐱07

\🐱06keyboard:\🐱07
\✽03]]..nx..[[⬆️ \🐱07/]]..nx..[[⬇️ \🐱07: select cart
]]..nx..[[❎ \🐱07: load selected cart
]]..nx..[[🅾️ \🐱07: cancel load
\◆\🐱06▤▤▤▤▤▤▤  \🐱07song graph \🐱06▤▤▤▤▤▤▤\🐱07

\✽01\★162,02,01\✽-1 in the song graph view
     you see the list of
songs in the current
cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06keyboard:\🐱07
\✽03]]..nx..[[⬆️ \🐱07/]]..nx..[[⬇️ \🐱07: select song
]]..nx..[[⬅️ \🐱07/]]..nx..[[➡️ \🐱07: scroll pattern view
]]..nx..[[❎ \🐱07/]]..nx..[[🅾️ \🐱07: play/stop song
\✽03]]..nx..v..[[\🐱07: copy song
]]..nx..w..[[\🐱07: paste song
]]..nx..x..[[\🐱07: delete song

\◆\🐱06▤▤▤▤▤▤▤  \🐱07song graph \🐱06▤▤▤▤▤▤▤\🐱07

\✽01\★162,02,01\✽-1 in the song graph view
     you see the list of
songs in the current
cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03when a song is selected,
each pattern, instrument
and sfx that is used by
that song is highlighted.
\◆\🐱06▤▤▤▤▤▤▤  \🐱07song graph \🐱06▤▤▤▤▤▤▤\🐱07

in the middle of the screen
you see all patterns in the
cartridge, and their status.
\✽03\█00,16,12\➡️01\✽01\★128,02,02\➡️-9\✽02\🐱0101\✽-2\🐱07 a light blue pattern
     means that there is
     a song using it.
\✽03\█00,16,12\➡️01\✽01\★049,02,01\➡️-9\✽02\🐱0001\✽-2\🐱07 a dark blue pattern
\✽02\➡️01\★144,02,01\✽-2\➡️-1 means that it is not
     in use.
\✽03\█00,16,12\➡️01\✽01\★033,02,01\➡️-9\✽02\🐱0001\✽-2\🐱07 and a light grey
\✽02\➡️01\★144,02,01\✽-2\➡️-1 pattern means that it
     belong to the currently
     selected song.
\◆\🐱06▤▤▤▤▤▤▤  \🐱07song graph \🐱06▤▤▤▤▤▤▤\🐱07

the sfxs have different
background colors.
\✽04\█00,16,08\✽01\➡️01\★053,02,01\➡️-1 this sfx is used by a
     song in the cartridge.
\✽04\█00,16,08\✽01\➡️01\★051,02,01\➡️-1 this sfx is not used
     by a song, but may be
     used from code.
\✽04\█00,16,08\✽01\➡️01\★037,02,01\➡️-1 this sfx is used by
     the selected song.
\✽04\█00,16,08\✽01\➡️01\★035,02,01\➡️-1 this sfx is used as
     instrument by the
     selected song.
\◆\🐱06▤▤▤▤▤▤▤▤  \🐱07patterns \🐱06▤▤▤▤▤▤▤▤\🐱07

\✽01\★164,02,01\✽-1 in the patterns view
     you have an overview
of all the patterns in
the cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06keyboard:\🐱07
\✽03]]..nx..[[⬆️ \🐱07/]]..nx..[[⬇️ \🐱07: select song
]]..nx..[[❎ \🐱07/]]..nx..[[🅾️ \🐱07: play/stop song
\✽03]]..nx..[[+\🐱07/]]..nx..[[-\🐱07: move song
\✽03]]..nx..v..[[\🐱07: copy song
]]..nx..w..[[\🐱07: paste song
]]..nx..x..[[\🐱07: delete song
\◆\🐱06▤▤▤▤▤▤▤▤  \🐱07patterns \🐱06▤▤▤▤▤▤▤▤\🐱07

\✽01\★164,02,01\✽-1 in the patterns view
     you have an overview
of all the patterns in
the cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06mouse:\🐱07
\✽03]]..nx..[[left click\🐱07
select song/play pattern
\✽03]]..nx..[[hover\🐱07
see detailed information
about the pattern
\◆\🐱06▤▤▤▤▤▤▤▤  \🐱07patterns \🐱06▤▤▤▤▤▤▤▤\🐱07

\✽01\★164,02,01\✽-1 in the patterns view
     you have an overview
of all the patterns in
the cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03when playing a song you
will see the sfxs that
are playing in each
channel in the bottom
of the screen
\◆\🐱06▤▤▤▤▤▤▤▤  \🐱07patterns \🐱06▤▤▤▤▤▤▤▤\🐱07
\✽03\█00,16,12\➡️01\✽01\★128,02,02\➡️-9\✽02\🐱0101\✽-2\🐱07 a light blue pattern
     means that there is
     a song using it.
\✽03\█00,16,12\➡️01\✽01\★049,02,01\➡️-9\✽02\🐱0001\✽-2\🐱07 a dark blue pattern
\✽02\➡️01\★144,02,01\✽-2\➡️-1 means that it is not
     in use.
\✽03\█00,16,12\➡️01\✽01\★033,02,01\➡️-9\✽02\🐱0001\✽-2\🐱07 and a light grey
\✽02\➡️01\★144,02,01\✽-2\➡️-1 pattern means that it
     belong to the currently
     selected song.
\✽03\█00,16,12\➡️01\✽01\★128,02,02\➡️-9\✽02\🐱0101\✽07\➡️-9\➡️-4\█09,01,00\➡️03\█11,01,00\➡️03\█14,01,00\➡️03\█12,01,00\✽-9\➡️04\🐱07 the four bars represent
     the four channels of
     the pattern and their
     assigned sfxs.
\◆\🐱06▤▤▤▤▤  \🐱07sound effects \🐱06▤▤▤▤▤▤\🐱07

\✽01\★166,02,01\✽-1 in the sound effects
     view you see all the
sound effects (sfxs) in
the cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06keyboard:\🐱07
\✽03]]..nx..[[⬆️ \🐱07/]]..nx..[[⬇️ \🐱07/]]..nx..[[⬅️ \🐱07/]]..nx..[[➡️ \🐱07: select sfx
]]..nx..[[❎ \🐱07/]]..nx..[[🅾️ \🐱07: play/stop sfx
\✽03]]..nx..y..[[\🐱07: add sfx to copy buffer
]]..nx..z..[[\🐱07: paste copied sfxs
]]..nx..bb..[[\🐱07: delete highlighted sfx
\◆\🐱06▤▤▤▤▤  \🐱07sound effects \🐱06▤▤▤▤▤▤\🐱07

\✽01\★166,02,01\✽-1 in the sound effects
     view you see all the
sound effects (sfxs) in
the cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06mouse:\🐱07
\✽03]]..nx..[[left click\🐱07
highlight a sfx
\✽03]]..nx..[[right click\🐱07
select two sfxs that
\✽03]]..nx..[[hover\🐱07
shows detailed information
about the sfx
\◆\🐱06▤▤▤▤▤  \🐱07sound effects \🐱06▤▤▤▤▤▤\🐱07

the sfxs have different
background colors.
\✽04\█00,16,08\✽01\➡️01\★053,02,01\➡️-1 this sfx is used by a
     song in the cartridge.
\✽04\█00,16,08\✽01\➡️01\★051,02,01\➡️-1 this sfx is not used
     by a song, but may be
     used from code.
\✽04\█00,16,08\✽01\➡️01\★035,02,01\➡️-1 this sfx is used as
     instrument by the
     selected song.
\✽04\█00,16,08\✽01\➡️01\█04,14,06\✽01\➡️04\🐱0059\✽-1\➡️03\🐱07 this sfx is unused
     and has no notes
\◆\🐱06▤▤▤▤▤  \🐱07sound effects \🐱06▤▤▤▤▤▤\🐱07

when copying or swapping
sfxs they have an animated
outline.
\✽02\➡️02\█00,16,08\▥1\✽01\➡️01\★053,02,01\➡️-1 this sfx is marked
\➡️02     to be swapped.
\✽07\➡️02\█00,16,08\▥3\✽01\➡️01\★053,02,01\➡️-1 this sfx is placed
\➡️02     in the copy buffer
\◆\🐱06▤▤▤▤▤  \🐱07sound effects \🐱06▤▤▤▤▤▤\🐱07

the bottom half of the
screen show where the sfx
is used.

\🐱141.\🐱07which patterns use the sfx

\🐱142.\🐱07which song use patterns
that use this sfx

\🐱143.\🐱07if the sfx have any notes

\🐱144.\🐱07which sfxs use this sfx as
an instrument (sfx 0-7 only)
\◆\🐱06▤▤  \🐱07patterns copy buffer \🐱06▤▤\🐱07

\✽01\★168,02,01\✽-1 in this view you see
     all the patterns that
are marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06keyboard:\🐱07
\✽03]]..nx..[[❎ \🐱07/]]..nx..[[🅾️ \🐱07: play/stop song
\◆\🐱06▤▤  \🐱07patterns copy buffer \🐱06▤▤\🐱07

\✽01\★168,02,01\✽-1 in this view you see
     all the patterns that
are marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06mouse:\🐱07
\✽03]]..nx..[[left click\🐱07
play/stop song at pattern
\◆\🐱06▤▤  \🐱07patterns copy buffer \🐱06▤▤\🐱07

\✽01\★168,02,01\✽-1 in this view you see
     all the patterns that
are marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03if no song has been copied
\🐱13(hitting ']]..nx..v..[[\🐱13' in the \🐱08song
graph\🐱13/\🐱08pattern view\🐱13)\🐱07 then
this view has nothing to
display.
\◆\🐱06▤▤▤▤  \🐱07sfx copy buffer \🐱06▤▤▤▤▤\🐱07

\✽01\★170,02,01\✽-1 in this view you see
     all the sfxs that are
marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03\🐱06mouse:\🐱07
\✽03]]..nx..[[left click\🐱07
play/stop sfx
\◆\🐱06▤▤▤▤  \🐱07sfx copy buffer \🐱06▤▤▤▤▤\🐱07

\✽01\★170,02,01\✽-1 in this view you see
     all the sfxs that are
marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03if a song is in the copy
buffer then ths sfx copy
buffer is automatically
filled with the sfxs and
instruments used by that
song.
\◆\🐱06▤▤▤▤  \🐱07sfx copy buffer \🐱06▤▤▤▤▤\🐱07

\✽01\★170,02,01\✽-1 in this view you see
     all the sfxs that are
marked for copy into
another cartridge.
\✽04          \✽01\🐱09♪\✽-1♪\🐱07
\✽03you can also manually
select sfxs and instruments
to copy in the \🐱08sound effects
view\🐱07 by selecting an sfx and
hitting ']]..nx..y..[[\🐱07'
\◆\🐱06▤▤▤▤▤▤  thank you to ▤▤▤▤▤▤\🐱07

       \🐱14♥ ♥ \🐱11gruber\🐱14♥ ♥ \🐱07
   for awesome theme song
        and testing

      \🐱14♥ ♥ \🐱11krystman\🐱14♥ ♥ \🐱07
   for excellent testing
        and feedback

       \🐱14♥ ♥ \🐱11sparr\🐱14♥ ♥ \🐱07
     for valuable token
     optimization tips
\◆\🐱06▤▤▤▤▤▤▤▤  contact ▤▤▤▤▤▤▤▤▤\🐱07

   renoiser is created by
      \🐱11magnus runesson\🐱07

you can reach me via
\✽03\★068,01,01\🐱10\✽01 twitter.com/originalrune\🐱07

\★069,01,01\🐱10\✽-1 rune (rune#9984)\🐱07 on the
   pico-8 discord

i hope you find this
tool useful

               \🐱14♥\🐱07
]]
function ct(cc)
local ny=0
for jq,ek in pairs(cc) do
ny+=1
end
return ny
end
function mt()
local nz=d
local oa=f
for bi=0,e do
local hs=peek(nz)
local ea=peek(oa)
poke(oa,hs)
poke(nz,ea)
nz+=1
oa+=1
end
bv()
bw()
end
function ob(hs,ea)
local oc=0x3100+hs*4
local od=0x3100+ea*4
local bp=peek4(oc)
poke4(oc,peek4(od))
poke4(od,bp)
fi(true)
end
function hl(oe,of,og)
local oh=of-oe+1
local oi=og-of
local oj=of+1
for ok=oj,og do
for ol=0,oh-1 do
local om=ok-ol-1
local on=ok-ol
ob(om,on)
end
end
bv()
end
function hj(kg)
for bi=1,#fq do
local hx,hy,hz=hf(fq[bi])
if kg>=hx and kg<=hy then
return bi
end
end
return-1
end
function bv()
fq={}
is={}
lg={}
ic={}
for hn=0,63 do
lg[hn]={
lk={},
lh={},
}
end
local oo=nil
local op=0x3100
local hn
for hn=0,63 do
local bj=op+(hn*4)
local kh=peek4(bj)
local oq=0x4040.4040
local os=band(kh,oq)!=oq
local ki=false
local kp=false
local jn=false
local jo=false
local kr=false
local ot={
[0]=-1,
-1,
-1,
-1,
}
if os then
if not oo then
oo={
ou=#fq,
gt=hn,
jr={},
jt={},
}
kp=true
else
ki=true
end
local ov=0x0000.0080
local ow=0x0000.8000
local ox=0x0080.0000
for bp=0,3 do
local oy,cb,bn=oz(kh,bp)
if oy then
ot[bp]=cb
pa(cb,oo.ou,hn)
if oo.jr[cb] then
oo.jr[cb]+=1
else
oo.jr[cb]=1
end
if is[cb] then
is[cb]+=1
else
is[cb]=1
end
pb(oo.jt,cb)
end
end
if band(kh,ov)==ov then
oo.jn=hn
jn=true
end
if band(kh,ow)==ow then
oo.jo=hn
jo=true
pc(oo)
oo=nil
end
if band(kh,ox)==ox then
kr=true
oo.stop=hn
pc(oo)
oo=nil
end
else
if oo then
oo.stop=hn-1
pc(oo)
oo=nil
end
end
ic[hn]={
jr=ot,
id=os,
ki=ki,
kp=kp,
kr=kr,
jn=jn,
jo=jo,
}
end
end
function pc(oo)
oo.na=ct(oo.jr)
oo.pd=ct(oo.jt)
add(fq,oo)
for jq,ek in pairs(oo.jt) do
if is[jq] then
is[jq]+=ek
else
is[jq]=ek
end
end
end
function pb(jt,cb)
local pe=0x3200+(cb*68)
for ny=0,31 do
local pf=peek2(pe+(ny*2))
local pg=band(pf,0x8000)==0x8000
local ph=band(shr(pf,12),0x7)
local pi=band(shr(pf,9),0x7)
local pj=band(shr(pf,6),0x7)
local pk=band(pf,0x3f)
if pg and(pi>0) then
if not jt[pj] then
jt[pj]=0
end
jt[pj]+=1
end
end
end
function bw()
it={}
ju={}
for hn=0,7 do
ju[hn]={
jr={},
}
end
local lt=0x3200
for cb=0,63 do
local lj={
iu=false,
jt={},
ix={},
iy={},
ja={},
}
local dc=0
local pl=0
for ny=0,31 do
local bn=peek2(lt)
local pg=band(bn,0x8000)==0x8000
local ph=band(shr(bn,12),0x7)
local pi=band(shr(bn,9),0x7)
local pj=band(shr(bn,6),0x7)
local pk=band(bn,0x3f)
lj.ix[dc]=pk/11
if pi==0 then
lj.iy[dc]=0
else
lj.iy[dc]=8+pj
end
lj.ja[dc]=pg
dc+=1
if pi!=0 then
lj.iu=true
if pg then
pm(pj,cb)
if not lj.jt[pj] then
lj.jt[pj]=0
end
lj.jt[pj]+=1
end
end
lt+=2
end
lj.pn=peek(lt+0)
lj.po=peek(lt+1)
lj.jn=peek(lt+2)
lj.pp=peek(lt+3)
lt+=4
it[cb]=lj
end
end
function gv()
la=nil
memcpy(f,d,e)
kz=fq[fp]
ee("copied song "..tostr(fp))
end
function gw()
if not kz then
return
end
fi(true)
local hx,hy,hz=hf(kz)
local pq=pr(hz)
if not pq then
ee("not enough free patterns")
ee("error: failed to paste song")
return
end
local ps=kz.pd
local bo=nil
if ps>0 then
bo=pt(ps)
if not bo then
ee("not enough free instruments")
ee("error: failed to paste song")
return
end
end
local pu=kz.na
local pv=nil
if pu>0 then
pv=pw(pu)
if not pv then
ee("not enough free sfxs")
ee("error: failed to paste song")
return
end
end
local px=
f+
(hx*4)
local py=
d+
(pq*4)
local pz=hz*4
memcpy(py,px,pz)
local qa={}
local qb=1
for jq=0,63 do
if kz.jr[jq] then
local lt=jq
local lu=pv[qb]
qa[lt]=lu
qb+=1
mq(lt,lu)
end
end
lz(qa,pq,pq+hz-1)
local qc={}
local qd=1
for jq=0,63 do
if kz.jt[jq] then
local lt=jq
local lu=bo[qd]
qc[lt]=lu
qd+=1
mq(lt,lu)
end
end
ly(qa,qc)
ee("pasted song")
end
function mq(lt,lu)
fi(true)
local dm=68
local qe=
f+
0x0100+
(lt*dm)
local lc=
d+
0x0100+
(lu*dm)
memcpy(lc,qe,dm)
end
function qf(bp)
return-16+(bp*8)
end
function oz(hn,bp)
local pg=rotr(hn,qf(bp))
pg=band(pg,0xff)
local oy=not(band(pg,0x40)==0x40)
local cb=band(pg,0x3f)
return oy,cb,pg
end
function ip(hn,cb)
if hn then
for jq,ek in pairs(hn.jr) do
if(jq==cb) then
return true
end
end
end
return false
end
function iq(hn,cb)
if hn then
for jq,ek in pairs(hn.jt) do
if(jq==cb) then
return true
end
end
end
return false
end
function pr(pf)
local el=nil
local qg=true
for bi=0,63-pf do
qg=true
for qh=0,pf-1 do
local cb=bi+qh
if ic[cb].id then
qg=false
break
end
end
if qg then
el=bi
break
end
end
return el
end
function qi(pf,bm,dm,hn)
local el={}
for bi=bm,dm,hn do
if not it[bi].iu then
add(el,bi)
pf-=1
if pf==0 then
break
end
end
end
if pf!=0 then
el=nil
end
return el
end
function pt(pf)
return qi(pf,0,7,1)
end
function pw(pf)
return qi(pf,8,63,1)
end
function mp(pf)
return qi(pf,63,8,-1)
end
function hf(hn)
if not hn then
return-1,-1,0
end
local hx=hn.gt
local hy=hn.jo
if(not hy) hy=hn.stop
local hz=(hy-hx)+1
return hx,hy,hz
end
function qj(qk,ql,qm,bp)
local qn=rotl(0x7f,qf(bp))
local qo=bxor(qn,0xffff.ffff)
local qp=rotl(qm,qf(bp))
qk=band(qk,qo)
qk=bor(qk,qp)
return qk
end
function lz(lw,hx,hy)
local qq=0x3100
for cb=hx,hy do
local bj=qq+(cb*4)
local qr=peek4(bj)
for bp=0,3 do
local id,ll,ql=oz(qr,bp)
if id then
if lw[ll] then
local qs=qr
qr=qj(qr,ql,lw[ll],bp)
poke4(bj,qr)
end
end
end
end
end
function ly(lw,qt)
local qq=0x3200
for li,qu in pairs(lw) do
local lt=qq+(qu*68)
for ny=0,31 do
local bn=peek2(lt)
local pg=band(bn,0x8000)==0x8000
local ph=band(shr(bn,12),0x7)
local pi=band(shr(bn,9),0x7)
local pj=band(shr(bn,6),0x7)
local pk=band(bn,0x3f)
if pi!=0 then
if pg then
local op=0xfe3f
local qv=band(bn,op)
if qt[pj] then
local ps=qt[pj]
qv+=shl(ps,6)
local qw=band(shr(qv,6),0x7)
poke2(lt,qv)
end
end
end
lt+=2
end
end
end
function pa(ll,qx,qy)
local qz=lg[ll]
local ra=true
for li,kh in pairs(qz.lk) do
if kh==qx then
ra=false
break
end
end
if ra then
add(qz.lk,qx)
end
local rb=true
for li,lj in pairs(qz.lh) do
if lj==qy then
rb=false
break
end
end
if rb then
add(qz.lh,qy)
end
end
function pm(rc,rd)
local re=ju[rc]
local rf=true
for li,ll in pairs(re.jr) do
if ll==rd then
rf=false
break
end
end
if rf then
add(re.jr,rd)
end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000077700000000000000007770000000000000000000000000007770000000
00000000000000000000000000000000000000000000000000000000000000000000077777770000007777777770000000007777000000000000007777700000
00000000000000000000000000000000000000077700000000000077700000000000007777777000007777777700000000077777700000000000007777000000
00000000777777777777777700000000000000077777770077777777700000000000007777777000007777700000000000007777700000000000000070000000
00000000777777777777777700000000000000007777777077777777000000000000000077777700000777000000000000000077000000000000000000000000
00000000777777777777777700000000000000007777777077777000000000000000000007770000000000000000000000000000000000000000000000000000
00000000777777777777777700000000000000000077777707770770000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777777777777700000000000000007707777777777777000000000000000000000000000000077000000000000000000000000000000000000000
00000000777777777777777700000000000000007777707777770777000000000000000000000000000000777700000000000000000000000000000000000000
00000000777777777777777700000000000000007777077777777077000000000000007700000077777700077700000000000000000000000000000000000000
00000000777777777777777700000000000000077777077777770077700000000000007777700077777700007700000000000000000000000000000000000000
00000000000000000000000000000000000000077700000000000077700000000000007777000777777770007770000000007700000000000000000077000000
00000000000000000000000000000000000000000000000000000000000000000000077777000777777700007770000000077770000000077700000007000000
00000000000000000000000000000000000000000000000000000000000000000000077700000000000000000000000000077700000000777770000007700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000070770000007700000
01000000066666666666660033333333333333302222222222222220000000000000000000000000000000000000000000000000000000000000000007770000
17100000666666666666666033333333333333302222e2292299e220000000000000000000000000000000000000000000000000000000000000000000000000
17610000666666666666666033333333333333302299329322533290000000000000000000000000000000000000000000000000000000000000000000000000
177610006666666666666660a3333333333333302255323322533230000000000000000000000000000000000000000000000000000000000000000000000000
1677d10066666666666666605aaa3333333333308255323382533830000000000000000000000000000000000000000000000000000000000000000000000000
16776d1066666666666666605555a333333333305255323352533330000000000000000000000000000000000000000000000000000000000000000000000000
1d6d1100666666666666666055555333333333305255323352533330000000000000000000000000000000000000000000000000000000000000000000000000
1d110000666666666666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11000000011111111111110000000000000000001111111111111110000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111000000000000000001111111111111110000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111000000000000000001111111111111110000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111111110000000f0000000f0111111f1111111f0000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111000000d3000000d5011b11d3f1bbb1d50000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111111110bbbbb538bbbbb350bb3b1333b5551550000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111033353533335353503333133355551550000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00102030405060708090a0b0c0d0e0f000000cc00777777000000000000000000000000000000000000000000000000000000000000000000000000000000000
001020304050f0f040406030d0d04090c000cccc7777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
001020502050c06040409030d05040900cc0cccc7700007700000000000000000000000000000000000000000000000000000000000000000000000000000000
001010502010d0c0505090d0505050400cccccc07070070700000000000000000000000000000000000000000000000000000000000000000000000000000000
00001010101050d0505040d0501050d000ccccc07007700700000000000000000000000000000000000000000000000000000000000000000000000000000000
00001010101010501010505010101050cccccc007777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000101010101010100010100cccc0000777707700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000
67777777777765006777777777777777777750000077777705677777777776507777770567777777777650677777777777777767777777777765000000000000
75111111111056507011111111111107701065000070110756501111111105657011075651111111111565701111111111110775111111111056500000000000
71111111111115657111111111111117711106500071111765111111111111567111176511111111111156711111111111111771111111111115650000000000
71111111111111567111111111111117711110650071111771111111111111177111177111111111111117711111111111111771111111111111560000000000
71111000001111177111111111111107711111065071111771111100001111177111177111110000011107711111111111110771111000001111170000000000
71110777760111077111077777777776701100006570110770111067760111077011077011006777600007711107777777777671110777760111070000000000
70110700056011077011070000000000700000000670000770110650056011077000077000065000567777701107000000000070110700056011070000000000
70000700007000077000070000000000700006100060000770000700007000077000067100170000000000700007000000000070000700007000070000000000
71001700007100167100170000000000710017631000001771001700007100177100177311165000000000710017000000000071001700007100160000000000
73111700056111657311370000000000731137563311113773113700007311377311377c33336777777650731137000000000073111700056111650000000000
7c333777763337507c333777777777007c33c7056cc333c77c33c700007c33c77c33c776cccccccccccc657c333777777777007c333777763337500000000000
76cccccccccc675076cccccccccc670076cc6700566ccc6776cc67000076cc6776cc67776666666666667676cccccccccc670076cccccccccc67500000000000
77666666666677657766666666667700776677000576667777667700007766777766776777777777777777776666666666770077666666666677650000000000
77777777777777767777777777777700777777000077777777777700007777777777775670000000000577777777777777770077777777777777760000000000
76500000000005677650000000056700775577000077557777557700007755777755770567777776011057765000000005670076500000000005670000000000
75010777760110577501077777777600750057000075005775005700007500577500570000000005601107750107777777760075010777760110570000000000
70110700056011077011070000000000701107000070110770110700007011077011077777770000701107701107000000000070110700056011070000000000
70110700007011077001070000000000701107000070110770110700007011077011077011065005601007700107000000000070110700007011070000000000
72002700007200277200077777777776720027000072002772002650056200277200277200026776200027720007777777777672002700007200270000000000
74224700007422477422222222222247742247000074224774222467764222477422477422224444222247742222222222224774224700007422470000000000
79449700007944977944444444444497794497000079449779444444444444977944977944444444444497794444444444449779449700007944970000000000
7f99f700007f99f77f999999999999f77f99f700007f99f76f999999999999f67f99f76f999999999999f67f999999999999f77f99f700007f99f70000000000
77ff77000077ff7777ffffffffffff7777ff77000077ff7756ffffffffffff6577ff7756ffffffffffff6577ffffffffffff7777ff77000077ff770000000000
77777700007777777777777777777777777777000077777705677777777776507777770567777777777650777777777777777777777700007777770000000000
0ddddddddddddd00ddddddddddddddd05000000010000000fffffffffffffffffffffffffffffffffcffffffffffffff00000000000000000000100000000000
ddddddddddddddd0ddddddddddddddd0d000000010000000fcffffffffcfffffffcfffffffffffffccccffffffffffff01000000010100000100010000000000
ddddddddddddddd0ddddddddddddddd05000000010000000fccfffffcfccfffffccfcffffeeeffff0c00cfffcfffffff11010000110010001100010000000000
ddddddddddddddd0ddddddddddddddd0d000000010000000fcccffffcccccfffcccccffffeeeffffc0ffcfffccffffff11010000110010001100010000000000
ddddddddddddddd0ddddddddddddddd05000000010000000fcc0ffff00cc0fff0cc00ffffeeeffffcffc0fffc0feefff01000000010100000100010000000000
ddddddddddddddd0ddddddddddddddd0d000000010000000fc0fffffffc0fffff0cffffff000ffff0ccccfff0ffeefff00000000000000000000100000000000
ddddddddddddddd0ddddddddddddddd05000000010000000f0ffffffff0fffffff0ffffffffffffff00c0ffffff00fff00000000000000000000000000000000
ddddddddddddddd0ddddddddddddddd0d000000010000000fffffffffffffffffffffffffffffffffff0ffffffffffff00000000000000000000000000000000
1111111111111110111111111111111010000000100000007f9e0000000e9f708888888888888888888888888888888888888888000000000000000000000000
110010010010011011001001001001101000000010000000f0000000000000f08811188888111888882228888411148882282288000000000000000000000000
011111111111110011111111111111101000000010000000900000000000009081622188817ee188827a92888178818882a27288000000000000000000000000
000000000000000000000000000000000000000000000000e0000000000000e08122218881eee18882a7a2888188818882aa9288000000000000000000000000
00000000000000000000000000000000000000000000000090000000000000908122218881eee188829a92888188818888292888000000000000000000000000
000000000000000000000000000000000000000000000000f0000000000000f08811188888111888882228888411148888828888000000000000000000000000
0000000000000000000000000000000000000000000000007f9e0000000e9f708888888888888888888888888888888888888888000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888222288888888888822228888888888888888888888888888888888888
81181188881118888811111118555888881118111111188888b8b8b818181888881111828111188888b888828111188888888888888888888888888888888888
81216188816221888811111118555888881118111111188888888888888888888811118281881888888888828188188888888888888888888888888888888888
81222188812221888888888888888888888888888888888888989898989818888888888281881888889898828188188888888888888888888888888888888888
88121888812221888888888888888888885581118555588888888888888888888888888221881888888888822188188888888888888888888888888888888888
888188888811188888b8989818181888885581118555588888181818181818888888888881111888889888888111188888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f77777777777777777777777777777777ffffffff777777777777777777777777777777777777777777777777777777777777777ffffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
7111111111111111111111111111111117ffffff75555555555555555555555555555555555555555555555555555555555555557fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
7111111111111111111111111111111117ffffff75555555555555555555555555555555555555555555555555555555555555557fffffff0000000000000000
7111111111111111111111111111111117ffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
f77777777777777777777777777777777fffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffff70000000000000005000000000000000500000000000000050000000000000007fffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffff75555555555555555555555555555555555555555555555555555555555555557fffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffff71111111111111111111111111111111111111111111111111111111111111117fffffff0000000000000000
fffffffffffffffffffffffffffffffffffffffff777777777777777777777777777777777777777777777777777777777777777ffffffff0000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000677777777777650067777777777777777777500000777777056777777777765077777705677777777776506777777777777777677777777777650000000
00000751111111110565070111111111111077010650000701107565011111111056570110756511111111115657011111111111107751111111110565000000
00000711111111111156571111111111111177111065000711117651111111111115671111765111111111111567111111111111117711111111111156500000
00000711111111111115671111111111111177111106500711117711111111111111771111771111111111111177111111111111117711111111111115600000
00000711110000011111771111111111111077111110650711117711111000011111771111771111100000111077111111111111107711110000011111700000
00000711107777601110771110777777777767011000065701107701110677601110770110770110067776000077111077777777776711107777601110700000
00000701107000560110770110700000000007000000006700007701106500560110770000770000650005677777011070000000000701107000560110700000
00000700007000070000770000700000000007000061000600007700007000070000770000671001700000000007000070000000000700007000070000700000
00000710017000071001671001700000000007100176310000017710017000071001771001773111650000000007100170000000000710017000071001600000
0000073111700056111657311370000000000731137563311113773113700007311377311377c333367777776507311370000000000731117000561116500000
000007c333777763337507c333777777777007c33c7056cc333c77c33c700007c33c77c33c776cccccccccccc657c333777777777007c3337777633375000000
0000076cccccccccc675076cccccccccc670076cc6700566ccc6776cc67000076cc6776cc67776666666666667676cccccccccc670076cccccccccc675000000
00000776666666666776577666666666677007766770005766677776677000077667777667767777777777777777766666666667700776666666666776500000
00000777777777777777677777777777777007777770000777777777777000077777777777756700000000005777777777777777700777777777777777600000
00000765000000000056776500000000567007755770000775577775577000077557777557705677777760110577650000000056700765000000000056700000
00000750107777601105775010777777776007500570000750057750057000075005775005700000000056011077501077777777600750107777601105700000
00000701107000560110770110700000000007011070000701107701107000070110770110777777700007011077011070000000000701107000560110700000
00000701107000070110770010700000000007011070000701107701107000070110770110770110650056010077001070000000000701107000070110700000
00000720027000072002772000777777777767200270000720027720026500562002772002772000267762000277200077777777776720027000072002700000
00000742247000074224774222222222222477422470000742247742224677642224774224774222244442222477422222222222247742247000074224700000
00000794497000079449779444444444444977944970000794497794444444444449779449779444444444444977944444444444497794497000079449700000
000007f99f700007f99f77f999999999999f77f99f700007f99f76f999999999999f67f99f76f999999999999f67f999999999999f77f99f700007f99f700000
0000077ff77000077ff7777ffffffffffff7777ff77000077ff7756ffffffffffff6577ff7756ffffffffffff6577ffffffffffff7777ff77000077ff7700000
00000777777000077777777777777777777777777770000777777056777777777765077777705677777777776507777777777777777777777000077777700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
f300000000000000000000000000000000000000008100000081000000810000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4445484944454445444542434243404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4243424342434243424340414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041404146474647424342434041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041404146474243424340414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041404140414041404140414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041404140414041404140414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041464740414041404140414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041404140414041404140414041404100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6464686968696464646462626262606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6262626262626262666760606060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6262626262626262666762626060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6060626266676667666760606060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6060626262626060606060606060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6060606060606060606060606060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6060606060606060606060606060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0101000018250172511524113241112310e2310c22109221052110321100200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
011c0000186141861118621186150c6000c6000c6000c600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000010c17000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800041a7171b7171f7172471700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707
011000011845000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800041a3171b3171f3172431700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707007070070700707
010600001d000000001d000000001d000000002900000000000000000022000000002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0105000035500000001e5000000000000005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500000000000000000
010e00000c0630000000000245032491424911249213091530610246152460524914249112492130914309310c0630000000000309143091130914309310c05330610246150c0533091024911249153091430931
010e000018b1418b1118b4118b4118b3118b3118b4118b411b84316b1416b1116b2116b2116b3116b311630016c0022b112eb1122b1516c0016b3416b4116b511b8401bb141bb111bb211bb211bb311bb311bb41
010e000000a1500a7500a450017500a2500a7500a450aa7500a4500a750074500a750aa25007750aa450aa5503a150da7503a450357503a150da750314503a5505a450fa75057350577513a150717507a4507a35
010e000000a1500a5500a35001550ca1500a5500a350aa5500a3500a55007350ca550aa15007550aa350aa3503a150da5503a35035550fa150da550313503a2511a350fa55057150575513a150715513a3513a35
010e00000c0632491124921309310c063249112493130915306102461524605249140c0632492130914309310c063249143c9103c9150c06330914309310c05330610246150c0533c9100c063309213091430931
010e000018b1418b1118b4118b4118b3118b3118b4118b411b84316b1416b1116b2116b2116b3116b3116c0016c0022b112eb1122b1516c0016b3416b4116b511b843114141341016415184101b4101d4161f410
010e000000a1500a550ca350015500a1500a550ca350aa5500a350ca550073500a550aa150075516a350aa3503a150da550fa350355503a150da55031350fa25114141342016415184201b4101d4261f41022420
010e000000a1500a7500a450017500a2500a7500a450ca7500a4500a750074500a750aa25007750aa450aa5505a1511a7505a450557505a1511a750514505a5507a4511a75077350777511a1513a750714507a55
010e00001fc041fc2222c171fd001fc251fc2022c161fd011b8431f22218c221b402222251822522c221fd0118c221dc221fc161dd001f2251dc221fc161dd011b8431fc221dc221ad011d2251bc221d21229211
010e00001f430224271f4221f4001f430224261f4221f4051f2321843018222182011843018427184221f2201d4301f4271d4221d4001d4301f4261d4221d4051d23216430162221620116430164271642216405
010e000000a1500a7500a450017500a2500a7500a450ca7508a4508a750874508a7513a250877513a4513a5505a1511a7505a450557505a1511a750514505a5507a1513a7507a450757507a1513a750714507a55
010e00001b4301e4271b4221b4051b4301e4261b4221b4051b4301e4271b4221b4051b4301e4261b4221b4051b4301d42018422182221b4301d42018422182221b4301d4311d2201d4221d2221c4111b2111a411
010e00001bc041bc221ec171b4011bc251bc201ec161b4011b8431bc121ec171b4011bc251bc201ec161b40113c101ac101bc111bc121bc121bc121ac1119c111b8431332016310183201b3101d3201f31022320
010e00000c0631fc2222c171fd010c0631fc2022c161fd01306102461518c221b4020c0631822522c221fd010c0631dc221fc161dd010c0631dc221fc160c05330610246150c05330b000c0631bc221d21229211
010e0000243102732022310243101b3102431027320223101b8431b310243102732022310243101b310243102732022310243101b310243102732022310243101b840243102732022310243101b3102431027320
010e000000a1500a7500a450017500a2500a750ea4502a7503a4503a750374503a7508a250877508a4507a5505a1511a7505a450557505a1511a750514505a5507a4511a75077350777511a1513a750714507a55
010e00001f430224271f4221f4051f430224261f4221f4051f2322443024222182011843018427184221f2201d4301f4271d4221d4051d4301f4261d4221d4051d23216430162221620116430164271642216405
010e0000273102931024310273101f3102731029317243101b843293102b310273102931024310273172b3102931024310273171f316273102931024310273101b8432931024310273101b843273102931024310
010e000000a1500a7500a450017500a2500a7500a450ca7508a4508a750874508a7513a250877513a4513a5505a1511a7505a450557505a1511a750514505a550aa700aa3108a400fa700da400aa6008a5006a40
010e00000c0631bc221ec171bd010c0631bc201ec161bd0130610246151bc221bc150c0631bc121bc121bc150c0631bc221ec171bd010c0631bc221bc150c05330610246150c0531c33330610246151c32318333
010e00001b4301e4271b4221b4051b4301e4261b4221b4051b4301e4271b4221b4051b4301e4261b4221b405254302743127430274202742227412274121b4301b4301b2321b4201b4221b4221b4121b2121e400
010e00000c06322c2225c1722d010c06322c2025c1622d0130610246151bc221e4020c0631b22525c2222d010c06320c2222c1620d010c06320c2222c160c05330610246150c05330b000c0631bc221d21229211
010e0000032250323503225033350fa350fa350532511a3516a350a3251673516a35193151972519a252531518a252431518a25195351b3151b2250f2100f4150a42520a35223152e31520a350a3150a12516a35
000e000003a1503a7503a450317503a2503a7511a4505a7506a4506a750674506a750ba250b7750ba450aa5508a1514a7508a450857508a1514a750814508a550aa4514a750a7350a77514a1516a750a1450aa55
010e00002243025427224222252522430254262242222525222321b4301b2221b5251b4301b4271b42222220204302242720422205252043022426204221b5252023219430192221952519430194271942219525
010e00000c06322c2225c1722d010c06322c2025c1622d0130610246151bc221e4020c0631b22525c2222d010c06320c2222c1620d010c06320c2222c160c05330610246150c05330b0030610246151c32318333
010e00001e430214271e4221e5251e430214261e4221e5251e430214271e4221e5251e430214261e4221e5251e430204201b4221b2251e430204201b4221b2251e43020431204302042220412204121f4111e411
010e00002243025427224222252522430254262242222525222322743027222275251b4301b4111b43222230204302242720422205252043022426204221b5252023219430192221952519430194271942219525
010e0000273102a32025310273101e310273102a320253101b8431e310273102a32025310273101e310273102a32025310273101e310273102a32025310273101b843273102a32025310273101e310273102a320
010e00002a3102c310273102a310223102a3102c317273101b8432c3102e3102a3102c310273102a3172e3102c310273102a317223162a3102c310273102a3101b8432c3100b32012330103200d3200b31009320
010e000003a1503a7503a450317503a2503a7511a4505a7506a4506a750674506a750ba250b7750ba450aa5508a1514a7508a450857508a1514a750814508a550da700da310ba4012a7010a400da600ba5009a40
010e00001e430214271e4221e5251e430214261e4221e5251e430214271e4221e5251e430214261e4221e5252a4302a4302a4202a2202a4122a4122a4122a2121e4301e4301e4201e4201e4221e4121e41221430
010e00000ba600ba410b310093000ba600ba410b3100d3000ba600ba410b310093000ba600ba410b3100b3000ea5010a600ba600b3100ea5010a600ba600b31009a600ba510b04015a6015a500904009a6015a40
010e0000313102a3102f310283102d31025316313102a3102f310283102d31025310313102a3102f310283102d31025310313102a3102f310283102d31025310313102a3100b3201533015312093300931215330
010e00000c0631ed501ed501b3130c0033f2053f2153f225306102461530900309011ed501ed401ed301b3130c0631ed501ed403f2250c0631ed501ed401b313306102461530900309012ad502ad403f2251b313
010e0000214302142121220214102141021412212122121528400212122321225212282122a2122d212212122321225212282122a2122d212212122321225212282122a21221212232122f4302f230314302a430
010e00002a4302a2302a2202a2102a2102a2122a2122a21528400212122321225212282122a2152d212212122321225212282122a2152d212212122321225212344303642136422364122d4302d4222d4122f430
010e000006a7006a51063100430006a7006a51063100d30006a7006a51063101030006a7006a51123100b30009a700ba5006a7006a2509a700ba5006a7006a2506a7006a5109a4015a6015a500604009a6015a40
010e0000313102a3102f310283102d31525310313102a3102f310283102d31525310313102a3102f310283102d31525310313102a3102f310283102d31525310313102a310094201542015412063200941215430
010e00002f4302f2302f2202f2102f2102f2122f2122f21528400214122341225412284122a4122d412214122341225412284122a4122d412214122341225412283152a31521315233152f4302f230314302a430
010e00000ba600ba410b315093200ba600ba410b3150d3200ba600ba410b315093200ba600ba410b3150b3200ea6010a600ba600b3200ea6010a600ba600b32509a600ba510b04015a6015a500904009a6015a40
010e00000b2302a3102f310092202d31025310313100d2202f310283102d31009220313102a3102f3100b3202d31025310313100b2202f310283102d31025310313102a3100b4201543015412094300941215430
010e000006a6006a51063250432006a7006a51063150d32006a7006a51063151032006a7006a51123200b32009a700d32006a601232009a700ba5006a7006a35153200f34006a4012a6012a500304006a6012a40
010e00000c0631ed501ed501b3130c0033f2053f2153f225306102461530900309011ed501ed401ed301b3130c0631ed501ed403f2250c0631ed501ed401b3133061024615309000c06330610246151b3131b313
010e00002a4302a2302a2202a2102a2102a2122a2122a21528400214122341225412284122a4122d412214122341225412284122a4122d412214122341225412284122a4122d412214122341225412284122a412
010e0000313102a3102f310042202d31025310313100d2202f310283102d31010230313102a310122200b2202d3100d22031310122202f310283102d310253100932003320064201242012412033200641212430
010e00000331503325033150f3250f21503225032250d2350331503325033150f3250d215032250d2250d235063151032506315063251221510225062250623514315123250831508325272151b4152711527515
010e00002e214272152c214252152a214222152e214272152c214252152a214222152e214272152c214252152a314223142e314273142c314253142a314223142e51516515165151651516515165251652516535
010e000003a1503a7503a450317503a2503a7503a450da7503a4503a750374503a750da25037750da450da5506a1510a7506a450657506a1510a750614506a5508a4512a75087350877516a150a1750aa450aa35
010e00001f514185151d514165151b514135151f514185151b843160151b014130151f014187151d7141671516c0022b112eb1122b1516c0016b3416b4116b511b843114141341016415184101b4101d4161f410
010e0000032250323503225033350fa350fa350532511a3516a350a3251673516a35193151972519a252531518a252431518a25195351b3151b2250f2100f4150a42516320193101b3201e310203202231025320
__music__
00 08090a0b
00 0c0d0a0e
01 0c110f10
00 0c131214
00 15181716
00 1b1c1a19
00 1d201f1e
00 21221f3a
00 1d231f24
00 21272625
00 2a2b2829
00 2a2c2d2e
00 2a2f3031
00 33343235
00 08373836
02 0c390a0e

