function graphics()
    -- sort based on y
	sort(_entities,function(a,b)
		return a.y>b.y
	end)

    --animated entities
    each_ent({'sprite'}, function(e)
        if(e.shader)shade(e)
        ssprc(e.sprite.x,e.sprite.y,e.w,e.w,e.x,e.y,e.w,e.w,false,e.sprite.o)
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