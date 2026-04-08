function new_collider(r,onenter,whilecolliding)
    return {r=r,onenter=onenter,whilecolliding=whilecolliding,colliding=false}
end

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