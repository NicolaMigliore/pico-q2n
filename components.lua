function new_flat_shader(c)
    local sh={}
    for i=1,15 do
        add(sh,{i,c})
    end
    return sh
end
function set_flat_shader(e,c)
    e.shader=new_flat_shader(c)
end

function new_motion(tn,sx,sy,tx,ty,r,sa,ta,cx,cy)
    return {tn=tn,sx=sx,sy=sy,tx=tx,ty=ty,r=r,sa=sa,ta=ta,cx=cx,cy=cy}
end
