-- MARK: entity
-- @param opts: {s:sprite, u:update function, d: draw function}
function new_ent(x,y,w,opts)
	return {
		x=x,y=y,w=w or 8,
		sprite=opts.s or 1,
		u=opts.u or function()end,
		d=opts.d or function(e)
			sprc(e.sprite,e.x,e.y,1)
		end
	}
end

-- MARK: actor
function new_actor(x,y,opts)
	return {
		-- identity
		id=opts.id,
		name=opts.name,

		-- world/visual
		x=x,y=y,w=16,
		sprite=opts.sprite or {x=0,y=32},

		-- base combat stats
        hp=opts.hp or 50,	--health points
		ap=opts.ap or 10,	--attack power
		bp=opts.bp or 5,	--block power
		he=opts.he or 15,	--heal amount
		bm=opts.bm or .5,	--boost modifier used when this actor boosts allies

		-- runtime combat state
		block=opts.block or 0, --current block shield remaining

		-- animation definitions
		a=opts.a or {
			idle={{8,0},{24,0}}
		},

		-- animation runtime state
		ai=1,as=.3,
		state='idle',

		shader=opts.shader,
		
		col_shape='circle',
		
		u=function(s)
		end,
		
		-- d=function(s)
		-- 	local f=s.a[s.s][flr(s.ai)]
		-- 	local x,y=f[1],f[2]
		-- 	ssprc(x,y,16,16,s.x,s.y)

        --     local label='hp:'..s.hp
        --     printl(label,s.x,s.y-s.w/2-3,'c',7,1)
		-- end
	}
end
