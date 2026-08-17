#!/usr/bin/env python3
"""
clav_naturals_v2_gcode.py -- Cap-only, groove-jointed g-code for all seven naturals,
using the EXACT head/tail geometry from irkem_C_keycapsForInt_v7.scad.

Convention (from the .scad): head at front position k*oct/7; tail at pitch slot
slot*oct/12. Two special cases baked in:
  E : tail widened to oct/12 (no gap) -> flush right
  F : tail built by difference -> flush left, width (6*oct/12 - 2) - 3*oct/7

Per-key rib/groove X follows the .scad rib formula: oset + i*oct/12 + (oct/12-6.2)/2.
Underside-up => geometry mirrored so the flipped cap reads correctly.
"""
import numpy as np, re
from shapely.geometry import box, Polygon
from shapely.ops import unary_union
import shapely.affinity as aff

# ---- tool / feeds (your characterized values) ----
TOOL_D, RPM = 6.35, 12000
FEED_XY, FEED_PLUNGE, DOC = 200.0, 250.0, 2.0
SAFE_Z, CAP_H, FINISH_ALLOW = 5.0, 10.0, 0.3
# ---- joint / groove ----
RIB_W, RIB_LEN, FIT_CLEAR, GROOVE_DEPTH, RIB_TAILY0 = 6.2, 55.0, 0.2, 2.0, 73.0
# ---- tabs / placement ----
TAB_COUNT, TAB_LEN, TAB_H = 4, 5.0, 1.5
PART_X0, PART_Y0, MIRROR = 8.0, 8.0, True

oct_w, gap, wL, bL, oset = 6.5*25.4, 2.0, 50.0, 80.0, -1.0
o7, o12 = oct_w/7, oct_w/12
head_W = o7 - gap

# (head_L, tail_L, tail_W, rib_slot_i) in octave-local X ; front Y[0,wL], back Y[wL,wL+bL]
KEYS = {
 'C': (0*o7, 0*o12, o12-gap,               0),
 'D': (1*o7, 2*o12, o12-gap,               2),
 'E': (2*o7, 4*o12, o12,                    4),   # tail flush-right (2+oct/12-gap)
 'F': (3*o7, 3*o7,  (6*o12-2)-(3*o7),       5),   # tail flush-left via difference
 'G': (4*o7, 7*o12, o12-gap,               7),
 'A': (5*o7, 9*o12, o12-gap,               9),
 'B': (6*o7, 11*o12, o12-gap,              11),
}
def rib_cx_oct(i): return oset + i*o12 + (o12-RIB_W)/2 + RIB_W/2   # center, octave-local

def depths(top, bot):
    out=[]; z=top
    while z-DOC>bot+1e-6: z-=DOC; out.append(z)
    out.append(bot); return out

def build(note):
    head_L, tail_L, tail_W, ri = KEYS[note]
    head = box(head_L, 0, head_L+head_W, wL)
    tail = box(tail_L, wL, tail_L+tail_W, wL+bL)
    cap  = unary_union([head, tail])
    rcx  = rib_cx_oct(ri)
    minx = cap.bounds[0]
    cap  = aff.translate(cap, -minx, 0); rcx -= minx      # normalise min-x -> 0
    W    = cap.bounds[2]
    if MIRROR:
        cap = aff.scale(cap, xfact=-1, yfact=1, origin=(W/2, 0)); rcx = W - rcx
    cap  = aff.translate(cap, PART_X0, PART_Y0); rcx += PART_X0
    gw   = RIB_W + FIT_CLEAR
    groove = box(rcx-gw/2, RIB_TAILY0+PART_Y0, rcx+gw/2, RIB_TAILY0+RIB_LEN+PART_Y0)
    return cap, groove, (head_L, tail_L, tail_W)

def gen_nc(note, cap, groove):
    G=[]; _f=[None]
    def xyz(x,y,z):
        s="";  s+=f" X{x:.3f}" if x is not None else ""
        s+=f" Y{y:.3f}" if y is not None else ""; s+=f" Z{z:.3f}" if z is not None else ""; return s
    def rap(x=None,y=None,z=None): G.append("G0"+xyz(x,y,z))
    def cut(x=None,y=None,z=None,f=None):
        s="G1"+xyz(x,y,z)
        if f is not None and f!=_f[0]: s+=f" F{f:.0f}"; _f[0]=f
        G.append(s)
    G+=[f"; clavinet {note} -- cap only, groove joint, underside-up mirror={MIRROR}",
        f"; tool {TOOL_D} RPM {RPM} feed {FEED_XY} DOC {DOC}",
        "G21 G90 G17 G94", f"M3 S{RPM}", "G4 P2"]; rap(z=SAFE_Z)
    G.append("; --- groove ---")
    gx=groove.centroid.x; gy0,gy1=groove.bounds[1],groove.bounds[3]
    for z in depths(0.0,-GROOVE_DEPTH):
        rap(z=SAFE_Z); rap(x=gx,y=gy0); cut(z=z,f=FEED_PLUNGE); cut(y=gy1,f=FEED_XY)
    rap(z=SAFE_Z)
    def profile(off):
        c=list(cap.buffer(off,join_style=1).exterior.coords)
        seg=[np.hypot(c[i+1][0]-c[i][0],c[i+1][1]-c[i][1]) for i in range(len(c)-1)]
        tot=sum(seg); ctr=[(k+0.5)*tot/TAB_COUNT for k in range(TAB_COUNT)]
        intab=lambda s:any(abs(((s-q+tot/2)%tot)-tot/2)<TAB_LEN/2 for q in ctr)
        rap(x=c[0][0],y=c[0][1]); rap(z=1.0)
        for z in depths(0.0,-CAP_H):
            use=z<(-CAP_H+TAB_H); cut(z=z,f=FEED_PLUNGE); s=0.0
            for i in range(1,len(c)):
                s+=seg[i-1]
                cut(x=c[i][0],y=c[i][1],z=(-CAP_H+TAB_H if(use and intab(s)) else z),f=FEED_XY)
        rap(z=SAFE_Z)
    G.append("; --- profile rough ---");  profile(TOOL_D/2+FINISH_ALLOW)
    G.append("; --- profile finish ---"); profile(TOOL_D/2)
    G+=["M5"]; rap(z=SAFE_Z); G+=["G0 X0 Y0","M30"]
    open(f"clav_{note}_caponly.nc","w").write("\n".join(G)+"\n")

# ---- generate + comparison table + octave preview ----
import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
fig,ax=plt.subplots(figsize=(11,4))
old_Lo={'C':0,'D':4.914,'E':9.827,'F':0,'G':4.914,'A':4.914,'B':9.827}   # my earlier guess
print(f"{'key':3}{'head_L':>9}{'tail_L':>9}{'Lo(actual)':>11}{'Lo(old)':>9}{'L_over':>8}{'R_over':>8}")
for note in "CDEFGAB":
    cap,groove,(hL,tL,tW)=build(note); gen_nc(note,cap,groove)
    Lo=tL-hL; Lover=tL-hL; Rover=(hL+head_W)-(tL+tW)
    print(f"{note:3}{hL:9.2f}{tL:9.2f}{Lo:11.3f}{old_Lo[note]:9.3f}{Lover:8.3f}{Rover:8.3f}")
    # assembled octave, playing-up (unmirrored) at true octave position
    head=box(hL,0,hL+head_W,wL); tail=box(tL,wL,tL+tW,wL+bL); u=unary_union([head,tail])
    xs,ys=u.exterior.xy; ax.fill(xs,ys,alpha=0.25,fc="saddlebrown",ec="saddlebrown",lw=1.5)
    rcx=rib_cx_oct(KEYS[note][3]); gv=box(rcx-(RIB_W+FIT_CLEAR)/2,RIB_TAILY0,rcx+(RIB_W+FIT_CLEAR)/2,RIB_TAILY0+RIB_LEN)
    gxs,gys=gv.exterior.xy; ax.fill(gxs,gys,alpha=0.6,fc="peru",ec="peru")
    ax.text(hL+head_W/2,25,note,ha="center",va="center",fontsize=12,weight="bold")
ax.set_aspect("equal"); ax.set_xlim(-5,oct_w+5)
ax.set_title("Assembled octave (playing-up) from your v7 .scad — grooves in tan")
ax.set_xlabel("octave X (mm)"); ax.set_ylabel("Y (mm)")
plt.tight_layout(); plt.savefig("octave_naturals_v2.png",dpi=120); print("wrote octave_naturals_v2.png + 7 .nc")
