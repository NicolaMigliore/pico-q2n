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

        
        pal()
    end)
end

function systems()
    each(_entities,function(e)
        -- animation
        if e.a then
            e.ai+=e.as
            local cur_a=e.a[e.state]
            if(e.ai>#cur_a+1)e.ai=1
            local f=e.a[e.state][flr(e.ai)]
            local x,y=f[1],f[2]
            e.sprite.x=x
            e.sprite.y=y
        end
        -- motion
        if e.m then
            local m=e.m
            local t=get_timer(m.tn)
            if not t then return end
            local p=ease_in_out_back(t.perc)
            if m.r then
                local a=m.sa+(m.ta-m.sa)*p
                e.x=m.cx+cos(a)*m.r
                e.y=m.cy+sin(a)*m.r
            else
                e.x=m.sx+(m.tx-m.sx)*p
                e.y=m.sy+(m.ty-m.sy)*p
            end
        end
    end)
end

function shade(e)
    for rep in all(e.shader)do
        pal(rep[1],rep[2])
    end
end
