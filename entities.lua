-- MARK: actor
function new_actor(x,y,opts)
	opts=opts or {}
	return {
		-- identity
		id=opts.id,
		name=opts.name,
		sn=opts.sn,		-- short name

		-- world/visual
		x=x,y=y,w=16,
		z=opts.z or 0,
		sprite=opts.sprite or {x=0,y=32},

		-- base combat stats
        hp=opts.hp or 5,	--health points
		max_hp=opts.max_hp or opts.hp or 5,
		ap=opts.ap or 1,	--attack power
		bp=opts.bp or 1,	--block power
		he=opts.he or 1,	--heal amount
		bm=opts.bm or 1,	--boost modifier used when this actor boosts allies

		-- runtime combat state
		block=opts.block or 0, --current block shield remaining

		-- animation definitions
		a=opts.a,

		-- animation runtime state
		ai=1,as=.3,
		state='idle',

		shader=opts.shader,
		
		col_shape='circle',
	}
end
