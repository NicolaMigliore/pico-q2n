function world_i()
    player=new_character(active_team[1],20,50)
    player.collider=new_collider(8)
    levels={}
    each(all_levels,function(lv,i)
        if i<=min(unlocked_levels or #all_levels,#all_levels) then
            add(levels,lv)
        end
    end)

    _entities={player}
    each(levels,function(lv,i)
        local ec=#lv.enemy_team

        each(lv.enemy_team,function(enemy,i)
            local start_x=lv.x-((ec-1)*8)/2
            enemy.x=start_x+8*(i-1)
            enemy.y=lv.y-14+rnd(10)
            enemy.ai=1
            enemy.as=0
            add(_entities,enemy)
        end)

        local node=new_ent(lv.x,lv.y,8,{
            z=-1,
            s=nil,
            u=function(e)
                e.w=e.collider.colliding==true and 18 or 8
                e.collider.r=e.w
                -- for enemy in all(lv.enemy_team) do
                --     if e.collider.colliding then clear_shader(enemy) else set_flat_shader(enemy,1) end
                -- end
            end,
            d=function(e)
                local nc=(e.collider and e.collider.colliding) and 9 or 1
                circfill(e.x,e.y,e.w-2,nc)
                circ(e.x,e.y,e.w,1)
                printl(i,e.x,e.y-9,'c',1)
                printl('lv:'..i,e.x,e.y+13,'c',1)
            end
        })
        node.sprite=nil
        node.collider=new_collider(6)
        lv.node=node
        add(_entities,node)
    end)
end

function world_u()
    control()
    animation()

    -- basic free movement
    if(btn(⬅️))player.x-=1
    if(btn(➡️))player.x+=1
    if(btn(⬆️))player.y-=1
    if(btn(⬇️))player.y+=1

    -- screen bounds
    player.x=mid(4,player.x,123)
    player.y=mid(4,player.y,123)
    physic()

    if btnp(5) then
        set_scene('team')
        return
    end

    local lv=get_colliding_level()
    if lv and btnp(🅾️) then
        local enemies={}
        for e in all(lv.enemy_team)do
            add(enemies,e.id)
        end
        set_scene('battle',{enemy_team=enemies,onwin=lv.onwin,onwin_msg=lv.onwin_msg})
        return
    end
end

function get_colliding_level()
    for lv in all(levels) do
        local n=lv.node
        if n and n.collider and n.collider.colliding then
            return lv
        end
    end
    return nil
end

function world_d()
    cls(13)
    graphics()

    d_ui_panel(1,116,126,11)
    printl('party:'..team_names(active_team,true),4,119,nil,1,nil,{w=118})
    printl('❎team',123,122,'r',1)

    printl('overworld',4,5,nil,1)

end

function unlock_lv(n)
    unlocked_levels=max(n,unlocked_levels)
    store_data('unlocked_levels',unlocked_levels)
end
function unlock_party(n)
    max_team_size=max(n,max_team_size)
    store_data('max_team_size',max_team_size)
end
