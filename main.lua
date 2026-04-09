-- main
function _init()
    _timers = {}
    init_save()
    characters_i()

    -- team
    roster_ids={'elf','mas','dal','pos','yun','kil','man'}
    max_team_size=load_data('max_team_size')
    if max_team_size==nil then
        max_team_size=1
        store_data('max_team_size',max_team_size)
    end
    unlocked_chars=load_data('unlocked_chars')
    if unlocked_chars==nil then
        unlocked_chars=2
        store_data('unlocked_chars',unlocked_chars)
    end
    active_team=load_data('active_team')
    if active_team==nil then
        active_team={roster_ids[1]}
        store_data('active_team',{1,0,0})
    end
    unlocked_levels=load_data('unlocked_levels')
    if unlocked_levels==nil then
        unlocked_levels=1
        store_data('unlocked_levels',unlocked_levels)
    end

	-- actors
	_entities={}
	
	-- scenes
	_scenes={
		test={i=function()tmp=new_id()end,u=function()end,d=function()print(tmp,1,1,1)end},
		battle={i=battle_i,u=battle_u,d=battle_d},
		team={i=team_i,u=team_u,d=team_d},
		world={i=world_i,u=world_u,d=world_d},
	}
	cur_scene=_scenes.test
	set_scene('world')
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

function init_save()
    cartdata('pico-q2n')
end

function store_data(k,v)
    if k=='max_team_size' then
        dset(0,v)
    elseif k=='active_team' then
        local a=v
        if a[1] and type(a[1])=='string' then
            a={
                find(roster_ids,a[1]) or 0,
                find(roster_ids,a[2]) or 0,
                find(roster_ids,a[3]) or 0
            }
        end
        dset(1,a[1] or 0)
        dset(2,a[2] or 0)
        dset(3,a[3] or 0)
    elseif k=='unlocked_chars' then
        dset(4,v)
    elseif k=='unlocked_levels' then
        dset(5,v)
    end
end

function load_data(k)
    if k=='max_team_size' then
        local v=dget(0)
        if v==0 then return nil end
        return v
    elseif k=='unlocked_chars' then
        local v=dget(4)
        if v==0 then return nil end
        return v
    elseif k=='unlocked_levels' then
        local v=dget(5)
        if v==0 then return nil end
        return v
    elseif k=='active_team' then
        local ids={}
        local i1=dget(1)
        local i2=dget(2)
        local i3=dget(3)
        if i1==0 and i2==0 and i3==0 then return nil end
        if i1>0 and roster_ids[i1] then add(ids,roster_ids[i1]) end
        if i2>0 and roster_ids[i2] then add(ids,roster_ids[i2]) end
        if i3>0 and roster_ids[i3] then add(ids,roster_ids[i3]) end
        return ids
    end
end
