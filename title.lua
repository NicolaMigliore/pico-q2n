function title_i()
    btn_i=1
    btns={
        {l="story",s="world"},
        {l="team",s="team"}
    }

    _entities={}
    for i=1,8 do
        local dx=4+flr((i-1)/2)*16
        local sx=i%2>0 and -16-dx or 144+dx
        local tx=i%2>0 and 60-dx or 68+dx
        local tn='scene_enter'..i
        local e=new_character(roster_ids[i],tx,95)
        add_timer(tn,.8+i*.05+rnd(),function()end)
        e.m=new_motion(tn,sx,rnd(100),tx,100-i*4)
        add(_entities,e)
    end

end

function title_u()
    if(btnp(2))btn_i=max(btn_i-1,1)
    if(btnp(3))btn_i=min(btn_i+1,#btns)

    if(btnp(4))set_scene(btns[btn_i].s,{prev_scene="title"})
end

function title_d()
    cls(11)
    map(64)

    graphics()

    printl('\^o3d0chat battles',64,30,'c',7)

    --buttons
    each(btns,function(b,i)
        local x,y,c=44,35,5
        if(i==btn_i)c=1
        rrectfill(x,y+10*i,40,9,2,6)
        rrect(x,y+10*i,40,9,2,c)
        printl(b.l,64,y+5+10*i,'c',c)
    end)
end
