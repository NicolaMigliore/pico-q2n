-- main
function _init()
    _timers = {}

	-- actors
	_entities={}
	
	-- scenes
	_scenes={
		test={i=function()tmp=new_id()end,u=function()end,d=function()print(tmp,1,1,1)end},
		battle={i=battle_i,u=battle_u,d=battle_d},
		world={i=world_i,u=world_u,d=world_d},
	}
	cur_scene=_scenes.test
	set_scene('world')
	-- set_scene('test')

	pts=0
	deb=nil
	show_col=true
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
end

function _draw()
	cls(6)
	cur_scene.d()

	-- draw transition
    local trans_timer = get_timer('transition') 
    if trans_timer and trans_timer.t > 0 then
        local r = ((2 * trans_timer.perc - 1) ^ 2) * 64 
        poke(0x5f34,0x2)
        circfill(64,64,r,0 | 0x1800)
    end
	
	if(deb)print(deb,70,10)
end

function set_scene(newscene,opts)
	if(_scenes[newscene]) then
		add_timer('transition', 1, function()
		cur_scene=_scenes[newscene]
		cur_scene.i(opts)
		end)
	end
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
