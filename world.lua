function world_i()
    player=new_actor(20,100,{id='elf',name='elfmir',a={idle={{8,0},{24,0}}}})
    player.collider=new_collider(8)
    levels={
        {
            x=25,y=30,
            enemy_team={
                new_actor(82,65,{id='pos',name='pos.bove',a={idle={{32,32},{48,32}}}}),
            }
        },
        {
            x=75,y=50,
            enemy_team={
                new_actor(82,65,{id='pos',name='pos.bove',a={idle={{32,32},{48,32}}}}),
                new_actor(97,70,{id='yun',name='yuna',a={idle={{64,32},{80,32}}}}),
                new_actor(97,70,{id='yun',name='yuna',a={idle={{64,32},{80,32}}}}),
            }
        }
    }

    _entities={player}
    each(levels,function(lv,i)
        local ec=#lv.enemy_team

        for i,enemy in ipairs(lv.enemy_team)do
            local start_x=lv.x-((ec-1)*8)/2
            local f=enemy.a.idle[1]
            add(_entities,new_actor(start_x+8*(i-1),lv.y-8+rnd(8),{sprite={x=f[1],y=f[2]}}))
        end

        local node=new_ent(lv.x,lv.y,8,{
            z=-1,
            s=nil,
            u=function(e)
                e.w=e.collider.colliding==true and 16 or 8
                e.collider.r=e.w
            end,
            d=function(e)
                local nc=(e.collider and e.collider.colliding) and 9 or 11
                circfill(e.x,e.y,e.w-2,nc)
                circ(e.x,e.y,e.w,1)
                printl(i,e.x,e.y-9,'c',1)
                printl('e:'..ec,e.x,e.y+10,'c',5)
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
        set_scene('battle',{enemy_team=lv.enemy_team})
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
