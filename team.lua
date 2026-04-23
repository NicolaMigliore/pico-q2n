function team_i(opts)
    next_scene=opts.next_scene or opts.prev_scene
    is_sparring=opts.sparring
    team_roster={}
    each(roster_ids,function(id,i)
        if i<=min(unlocked_chars or #roster_ids,#roster_ids) then
            add(team_roster,id)
        end
    end)

    team_view_n=4
    team_top_i=1
    team_sel_i=1

    _entities={}
    each(team_roster,function(id,i)
        local e=new_character(id,94,24+18*(i-1))
        e.as=.2
        add(_entities,e)
    end)

    -- player and enemy teams
    team_pick=copy(active_team or {})
    enemy_pick={}
    cur_team=team_pick
    cur_max_size=max_team_size

    mode='team'

    music(8,500)
end

function team_u()
    if btnp(2) then team_sel_i=max(team_sel_i-1,1) sync_team_preview() end
    if btnp(3) then team_sel_i=min(team_sel_i+1,#team_roster) sync_team_preview() end

    if btnp(4) then
        local id=team_roster[team_sel_i]
        local i=find(cur_team,id)
        if i then
            deli(cur_team,i)
        else
            if #cur_team<cur_max_size then
                add(cur_team,id)
            else
                sfx(1)
            end
        end
    end

    if btnp(5) then
        if #cur_team>0 then
            -- set player team
            active_team=copy(team_pick)
            store_data('active_team',active_team)
            -- set enemy team
            local opts = {
                enemy_team=copy(enemy_pick),
                prev='title',
            }

            set_scene(next_scene,opts)
        end
    end

    if is_sparring then
        if(btnp(0))cur_team=team_pick cur_max_size=max_team_size mode='team'
        if(btnp(1))cur_team=enemy_pick cur_max_size=3 mode='enemy'
    end
end

function team_d()
    local sy=18*(team_top_i-1)

    cls(13)
    printl('\^o1ffselect '..mode,4,5,nil,7)
    printl('\^o1ffactive:'..#cur_team..'/'..cur_max_size,123,5,'r',7)
    clip(0,14,128,72)
    camera(0,sy)
    graphics()

    each(team_roster,function(id,i)
        local e=_entities[i]
        local x,y=25,16+18*(i-1)
        local sel=i==team_sel_i
        local in_team=find(cur_team,id)
        local card_c=sel and (mode=='team' and 1 or 2) or 5

        d_char_card(x,y,e,card_c,1)
        if in_team then
            circfill(x+48,y+7,3,card_c)
        end
        circ(x+48,y+7,5,card_c)
    end)
    
    camera()
    clip()

    if team_top_i>1 then
       if(flash>.2) printl('⬆️',64,11,'c',9,1)
    end
    if team_top_i+team_view_n-1<#team_roster then
        if(flash>.2)printl('⬇️',64,91,'c',9,1)
    end

    local e=_entities[team_sel_i]
    if e then
        d_stat_panel(e.name,e)
    end
end

function sync_team_preview()
    local max_top=max(#team_roster-team_view_n+1,1)
    if team_sel_i<team_top_i then
        team_top_i=team_sel_i
    elseif team_sel_i>team_top_i+team_view_n-1 then
        team_top_i=team_sel_i-team_view_n+1
    end
    team_top_i=mid(1,team_top_i,max_top)
end

function team_names(t,short)
    local names=''
    each(t,function(id,i)
        local n=short and id or _characters[id].name
        names=names..(i>1 and ',' or '')..n
    end)
    if names=='' then return '-' end
    return names
end
