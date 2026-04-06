-- main
function _init()
    _timers = {}

	-- player
	local a={
			idle={{8,0},{24,0}}
		}
	_p=new_actor(64,64,a)
	_p.u=function(s)
			if(btn(⬆️))s.y-=1
			if(btn(⬇️))s.y+=1
			if(btn(⬅️))s.x-=1
			if(btn(➡️))s.x+=1
		end
		
	-- actors
	_entities={
		_p,
		-- new_actor(50,100,{name="elfamir",a={idle={{8,16},{24,16}}}}),
		-- new_pickup(10,20),
		-- new_pickup(40,75),
		new_ent(100,100,8,{s={x=0,y=64,o=1}})
	}
	
	-- scenes
	_scenes={
		test={i=function()tmp=new_id()end,u=function()end,d=function()print(tmp,1,1,1)end},
		battle={i=battle_i,u=battle_u,d=battle_d},
	}
	cur_scene=nil
	set_scene('battle')
	-- set_scene('test')

	pts=0
	deb=nil
	show_col=false
	flash=1
	blink_c=9
end

function _update()

	flash=(sin(time())+1)/2
	blink_c=flash>.2 and 9 or nil

	-- run timers
	for k,timer in pairs(_timers) do
        if(timer.t>0)timer.t=timer.t-1/30 timer.perc = (timer.start_time - timer.t) / timer.start_time
        if timer.t<=0 and timer.done == false then 
            timer.done = true
            timer.f()
        end
    end


	cur_scene.u()

	-- animation()

	-- each(_entities,function(e,i)
	-- 	e:u()
		
	-- 	-- animation
	-- 	-- if(e.a)anim(e,e.s)
		
	-- 	-- collision checks
	-- 	if e.col_shape then
	-- 		each(_entities,function(o)
	-- 			if e!=o and o.col_shape then
	-- 				local d=e.w/2+o.w/2
	-- 				local collided=point_dist(e.x,e.y,o.x,o.y)<d
	-- 				if collided then
	-- 					if(e.col_func)e.col_func(e,o)if(e.del)del(_entities,e)
	-- 					if(o.col_func)o.col_func(o,e)if(o.del)del(_entities,o)
	-- 				end
	-- 			end
	-- 		end)
	-- 	end
	-- end,true)

end

function _draw()
	cls(6)
	cur_scene.d()

	-- graphics()

	-- each(_entities,function(e)
	-- 	-- e:d()
		
	-- 	if show_col then
	-- 		local c=2
	-- 		if(e.del)c=7
	-- 		if(e.col_shape=='circle')circ(e.x,e.y,e.w/2,c)
	-- 	end
	-- end)
	
	-- -- points
	-- print('points:'..pts,2,2,9)

	-- draw transition
    local trans_timer = get_timer('transition') 
    if trans_timer and trans_timer.t > 0 then
        local r = ((2 * trans_timer.perc - 1) ^ 2) * 64 
        poke(0x5f34,0x2)
        circfill(64,64,r,0 | 0x1800)
    end
	
	if(deb)print(deb,70,10)
end

function set_scene(newscene)
	if(_scenes[newscene])cur_scene=_scenes[newscene] cur_scene.i()
end

--- sort the elements
function sort(_list, _comparison_f)
    for i = 2, #_list do
        local j = i
        while j > 1 and _comparison_f(_list[j - 1], _list[j]) do
            _list[j], _list[j - 1] = _list[j - 1], _list[j]
            j -= 1
        end
    end
end

function add_timer(name, time, fn)
    _timers[name] = {
        start_time = time,
        t = time,
        f = fn or function()end,
        perc = 0,
        done = false
    }
    if(name=='transition')_can_input=false
end
function get_timer(name)
    return _timers[name]
end