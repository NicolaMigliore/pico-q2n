function world_i()
    levels={}
    each(all_levels,function(lv,i)
        if i<=min(unlocked_levels or #all_levels,#all_levels) then
            add(levels,lv)
        end
    end)

    lv_i=mid(1,lv_i or 1,#levels)
    local sel=levels[lv_i]
    player=new_character(active_team[1],sel.x,sel.y)
    world_cam_x=flr(player.x/128)*128

    _entities={player}
    each(levels,function(lv,i)
        each(lv.enemy_team,function(enemy,i)
            local start_x=lv.x-((#lv.enemy_team-1)*8)/2
            enemy.x=start_x+8*(i-1)
            enemy.y=lv.y-14+rnd(10)
            enemy.ai=1
            enemy.as=0
            add(_entities,enemy)
        end)

        local node={
            x=lv.x,y=lv.y,w=8,z=-1,
            d=function(e)
                local h=i==lv_i
                local w=h and 18 or 8
                circfill(e.x,e.y,w-2,h and 9 or 1)
                circ(e.x,e.y,w,1)
                printl(i,e.x,e.y-9,'c',1)
            end
        }
        lv.node=node
        add(_entities,node)
    end)
end

function world_u()
    local t=get_timer('world_move')
    if player.m and (not t or t.done) then
        local lv=levels[lv_i]
        player.x=lv.x
        player.y=lv.y
        player.m=nil
    end
    world_cam_x=flr(player.x/128)*128

    if btnp(5) then
        set_scene('team')
        return
    end

    if player.m and t and not t.done then return end

    if(btnp(0))move_level_sel(0)
    if(btnp(1))move_level_sel(1)
    if(btnp(2))move_level_sel(2)
    if(btnp(3))move_level_sel(3)

    local lv=levels[lv_i]
    if btnp(🅾️) then
        local enemies={}
        for e in all(lv.enemy_team)do
            add(enemies,e.id)
        end
        set_scene('battle',{enemy_team=enemies,lv=lv.lv,party=lv.party,char=lv.char,c1=lv.c1,c2=lv.c2,c3=lv.c3,c4=lv.c4})
        return
    end
end

function move_level_sel(d)
    local c=levels[lv_i]
    local ni=lv_i

    if(lv_i>1 and lv_dir(c,levels[lv_i-1])==d) ni=lv_i-1
    if(lv_i<#levels and lv_dir(c,levels[lv_i+1])==d) ni=lv_i+1

    if ni!=lv_i then
        local dst=levels[ni]
        lv_i=ni
        player.m=new_motion('world_move',c.x,c.y,dst.x,dst.y)
        add_timer('world_move',.75)
    end
end

function lv_dir(a,b)
    local dx,dy=b.x-a.x,b.y-a.y
    if abs(dx)>abs(dy) then return dx<0 and 0 or 1 end
    return dy<0 and 2 or 3
end

function world_d()
    cls(13)
    camera(world_cam_x,0)
    -- draw the train-track path between sequential levels
    for i=1,#levels-1 do
        local a=levels[i]
        local b=levels[i+1]
        line(a.x,a.y,b.x,b.y,1)
    end
    graphics()
    camera()

    d_ui_panel(1,116,126,11)
    printl('party:'..team_names(active_team,true),4,119,nil,1,nil,{w=118})
    printl('❎team',123,122,'r',1)

    printl('overworld',4,5,nil,1)
    printl('lv:'..lv_i,123,5,'r',1)

end

function unlock_lv(n)
    unlocked_levels=max(n,unlocked_levels)
    store_data('unlocked_levels',unlocked_levels)
end
function unlock_party(n)
    max_team_size=max(n,max_team_size)
    store_data('max_team_size',max_team_size)
end
function unlock_char(n)
    unlocked_chars=max(n,unlocked_chars)
    store_data('unlocked_chars',unlocked_chars)
end

function parse_level_def(s)
    local p=split(s,'|',false)
    local e={}
    for i=3,5 do
        if p[i]!='' then add(e,new_character(p[i])) end
    end
    return {
        x=tonum(p[1]),y=tonum(p[2]),
        enemy_team=e,
        lv=tonum(p[6]),
        party=tonum(p[7]),
        char=tonum(p[8]),
        c1=tonum(p[9]),
        c2=tonum(p[10]),
        c3=tonum(p[11]),
        c4=tonum(p[12]),
    }
end
