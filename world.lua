function world_i()
    player=new_character('elf',20,50)
    player.collider=new_collider(8)
    levels={
        {
            x=25,y=30,
            enemy_team={
                new_character('dal',82,65),
            }
        },
        {
            x=110,y=24,
            enemy_team={
                new_character('pos',82,65),
            }
        },
        {
            x=75,y=50,
            enemy_team={
                new_character('pos',82,65),
                new_character('mas',97,70),
                new_character('yun',97,70),
            }
        }
    }

    _entities={player}
    each(levels,function(lv,i)
        local ec=#lv.enemy_team

        for i,enemy in ipairs(lv.enemy_team)do
            local start_x=lv.x-((ec-1)*8)/2
            enemy.x=start_x+8*(i-1)
            enemy.y=lv.y-8+rnd(10)
            enemy.ai=1
            enemy.as=0
            add(_entities,enemy)
        end

        local node=new_ent(lv.x,lv.y,8,{
            z=-1,
            s=nil,
            u=function(e)
                e.w=e.collider.colliding==true and 16 or 8
                e.collider.r=e.w
                for enemy in all(lv.enemy_team) do
                    if e.collider.colliding then clear_shader(enemy) else set_flat_shader(enemy,5) end
                end
            end,
            d=function(e)
                local nc=(e.collider and e.collider.colliding) and 9 or 11
                circfill(e.x,e.y,e.w-2,nc)
                circ(e.x,e.y,e.w,1)
                printl(i,e.x,e.y-9,'c',1)
                printl('lv:'..i,e.x,e.y+10,'c',5)
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

    local lv=get_colliding_level()
    if lv and btnp(🅾️) then
        local enemies={}
        for e in all(lv.enemy_team)do
            add(enemies,e.id)
        end
        set_scene('battle',{enemy_team=enemies})
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

    printl('overworld',4,5,nil,1)

    graphics()
end
