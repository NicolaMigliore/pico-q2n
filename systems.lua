function graphics()
    -- sort by z (low->high), then y (low->high)
	sort(_entities,function(a,b)
		local az,bz=a.z or 0,b.z or 0
		if az!=bz then return az>bz end
		local ay,by=a.y or 0,b.y or 0
		return ay>by
	end)

    -- draw entities through shared rendering pipeline
    each(_entities, function(e)

        if e.sprite and e.sprite.x and e.sprite.y then
            -- if outline exists then draw it
            ssprc(e.sprite.x,e.sprite.y,e.w,e.w,e.x,e.y,e.w,e.w,false,e.sprite.o)
            -- if shader exists then apply
            if(e.shader)shade(e)
            ssprc(e.sprite.x,e.sprite.y,e.w,e.w,e.x,e.y,e.w,e.w,false)
        elseif e.d then
            e.d(e)
        end

        if show_col and e.collider then
            local cc=e.collider.colliding and 8 or 2
            circ(e.x,e.y,e.collider.r or 0,cc)
        end

        pal()
    end)
end

function animation()
    each_ent('a',function(e)
        -- advance anim
        e.ai+=e.as
        local cur_a=e.a[e.state]
        if(e.ai>#cur_a+1)e.ai=1

        -- update sprite
        local f=e.a[e.state][flr(e.ai)]
        local x,y=f[1],f[2]
        e.sprite.x=x
        e.sprite.y=y
    end)
end

function shade(e)
    for rep in all(e.shader)do
        pal(rep[1],rep[2])
    end
end

--called each frame
function control()
    each_ent('u',function(e)
        e.u(e)
    end)
end

function physic()
    -- reset collision state
    each(_entities,function(e)
        if e and e.collider then
            e.collider.colliding=false
        end
    end)

    -- pairwise circular collider checks
    for i=1,#_entities-1 do
        local e=_entities[i]
        if e and e.collider then
            for j=i+1,#_entities do
                local o=_entities[j]
                if o and o.collider then
                    local r=(e.collider.r or 0)+(o.collider.r or 0)
                    local hit=point_dist(e.x,e.y,o.x,o.y)<=r
                    if hit then
                        e.collider.colliding=true
                        o.collider.colliding=true
                        if e.collider.onenter then e.collider.onenter(e,o) end
                    end
                end
            end
            local col=e.collider
            if(col.colliding and col.whilecolliding)col.whilecolliding(e)
        end
    end
end
