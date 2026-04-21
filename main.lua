-- main
function _init()
    _timers = {}
    characters_i()
    init_save()
    init_menu()

    -- levels
    all_levels={
        '59|76|min|||2||7|15|14|3|11',
        '186|76|min|min||3|2||15|14|3|11',
        '186|36|min|min|min|3|2||15|12|3|11',
        '340|36|dal|||4|||13|9|2|4',
        '468|36|pos|min||5|||13|2|1|3',
        '468|204|min|yun|min||5|||13|2|3|15',
        '332|204|kil|man||5|||13|14|4|15',
        '332|156|man|min|min|5|||13|2|4|15',
        '204|156|dar|min||5|||13|2|4|15',
        '43|156|bos|||5|||13|2|4|15',
        '43|220|min|bos|min|5|||13|2|4|15',
        '195|220|big|bos|baz|5|||13|2|1|5',
    }
    each(all_levels,function(v,i)
        all_levels[i]=parse_level_def(v)
    end)

    -- team
    roster_ids={'elf','mas','dal','pos','yun','kil','dar','man'}
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
    lv_i=load_data('lv_i')
    if lv_i==nil then
        lv_i=1
        store_data('lv_i',lv_i)
    end

	-- actors
	_entities={}
	
	-- scenes
	_scenes={
		test={i=function()end,u=function()end,d=function()print(tmp,1,1,1)end},
		battle={i=battle_i,u=battle_u,d=battle_d},
		team={i=team_i,u=team_u,d=team_d},
		world={i=world_i,u=world_u,d=world_d},
	}
	cur_scene=_scenes.test
	set_scene('world')

    particles_i()

	pts=0
	deb=nil
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

    systems()
	cur_scene.u()
    particles_u()
end

function _draw()
	cls(6)
	cur_scene.d()
    particles_d()

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
    music(-1,300)
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
    elseif k=='lv_i' then
        dset(6,v)
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
    elseif k=='lv_i' then
        local v=dget(6)
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

function init_menu()
    menuitem(1,'reset save',function()
        clear_saved_data()
        set_scene('world')
        return false
    end)
    menuitem(2,'unlock all',function()
        unlock_all_features()
        set_scene('world')
        return false
    end)
end

function clear_saved_data()
    for i=0,6 do
        dset(i,0)
    end
    max_team_size=1
    unlocked_chars=2
    unlocked_levels=1
    lv_i=1
    active_team={roster_ids[1]}
end

function unlock_all_features()
    max_team_size=3
    unlocked_chars=#roster_ids
    unlocked_levels=#all_levels
    lv_i=1
    active_team={}
    for i=1,min(max_team_size,#roster_ids) do
        add(active_team,roster_ids[i])
    end
    store_data('max_team_size',max_team_size)
    store_data('unlocked_chars',unlocked_chars)
    store_data('unlocked_levels',unlocked_levels)
    store_data('lv_i',lv_i)
    store_data('active_team',active_team)
end
