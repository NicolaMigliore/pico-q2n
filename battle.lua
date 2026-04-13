--MARK:Init
function battle_i(opts)
    opts=opts or {}
    onwin=opts.onwin or function()end
    onwin_msg=opts.onwin_msg
    -- phase: pu=pick unit pa=pick action pt=pick target ex=execute dn=done
    pu,pa,pt,ex,dn='pu','pa','pt','ex','dn'
    actions={
        {name='attack',spr=104,t='enemy',c=8,p=4,k='ap',bk='atk'},
        {name='block',spr=105,c=12,p=2,k='bp',bk='block'},
        {name='heal',spr=106,t='ally',c=11,p=3,k='he',bk='heal'},
        {name='boost',spr=107,t='ally',c=10,p=1}
    }
    _entities={}
    t1={}
    each(active_team or {'elf','mas','dal'},function(id,i)
        if i<=3 then
            local e=new_character(id,12+15*(i-1),72+5*(i-1))
            add(t1,{t=1,e=e,action=nil,target=nil})
            add(_entities,e)
        end
    end)
    t2={}
    if opts.enemy_team and #opts.enemy_team>0 then
        each(opts.enemy_team,function(e_id,i)
            local ne=new_character(e_id,83+15*(i-1),20+5*(i-1),{})
            add(t2,{t=2,e=ne,action=nil,target=nil})
            add(_entities,ne)
        end)
    end

    sel_i=1
    action_i=1
    tar_i=1
    exec_i=1
    exec_order={}
    exec_wait=false
    atk_fx=nil
    assign_i=1
    battle_rewarded=false

    phase=pu
    msg='assign actions'
end
--MARK:Update
function battle_u()
    animation()
    cleanup_dead()
    -- keep block tint in sync on all living actors
    each(t1,function(tm)
        refresh_actor_shader(tm.e)
    end)
    each(t2,function(tm)
        refresh_actor_shader(tm.e)
    end)
    update_action_fx()

    if phase==dn then
        if btnp(🅾️) then
            set_scene('world')
        end
        return
    end

    if is_battle_over() then
        if #t2==0 and not battle_rewarded then
            onwin()
            battle_rewarded=true
        end
        phase=dn
        if #t2==0 then
            if type(onwin_msg)=='function' then
                msg=onwin_msg() or 'victory'
            else
                msg=onwin_msg or 'victory'
            end
            sfx(6)
        else
            msg='defeat'
            sfx(7)
        end
        return
    end

    if phase==pu then
        if(#t1==1)sel_i=1 phase=pa return
        if(btnp(⬇️))sel_i=find_unassigned(sel_i,1)
        if(btnp(⬆️))sel_i=find_unassigned(sel_i,-1)
        if(btnp(❎))step_back_order()
        if(btnp(🅾️) and t1[sel_i] and not t1[sel_i].action)phase=pa

    elseif phase==pa then
        if(btnp(⬅️))action_i=move_action_sel(-1,0)
        if(btnp(➡️))action_i=move_action_sel(1,0)
        if(btnp(⬆️))action_i=move_action_sel(0,-1)
        if(btnp(⬇️))action_i=move_action_sel(0,1)

        if(btnp(❎))phase=pu
        if(btnp(🅾️)) then
            if actions[action_i].t then
                tar_i=1
                phase=pt
            else
                local tm=t1[sel_i]
                tm.action=actions[action_i]
                tm.target=nil
                commit_order()
            end
        end

    elseif phase==pt then
        local targets=current_targets()
        if #targets<=0 then
            msg='no targets'
            phase=pa
            return
        end
        if(btnp(⬇️))tar_i=min(tar_i+1,#targets)
        if(btnp(⬆️))tar_i=max(tar_i-1,1)
        if(btnp(❎))phase=pa
        if(btnp(🅾️)) then
            local tm=t1[sel_i]
            tm.action=actions[action_i]
            tm.target=targets[tar_i]
            commit_order()
        end

    elseif phase==ex then
        if exec_wait then return end
        if(btnp(🅾️))do_next_action()
    end
end

--MARK:Draw
function battle_d()
    --scene
    cls(13)
    ovalfill(1,70,55,95,3)
    ovalfill(3,72,53,93,11)

    ovalfill(72,18,126,43,3)
    ovalfill(74,20,124,41,11)

    graphics()


    -- ui
    local gap=1
    local total_h=0
    each(t1,function(tm,i)
        if card_sel(i,'ally') then
            total_h+=16
        else
            total_h+=11
        end
    end)
    total_h+=max(#t1-1,0)*gap
    local y=96-total_h
    each(t1,function(tm,i)
        local e=tm.e
        local selected=card_sel(i,'ally')
        local ox,oy=127-57-1,y
        local c=5
        if(selected)ox,c=ox-4,1

        d_char_card(ox,oy,e,c,selected,tm.action)
        y+=char_card_h(selected)+gap
    end)

    y=2
    each(t2,function(tm,i)
        local e=tm.e
        local selected=card_sel(i,'enemy')
        local c=5
        local ox,oy=2,y
        if(selected)ox,c=ox+4,1
        d_char_card(ox,oy,e,c,selected,tm.action)
        y+=char_card_h(selected)+gap
    end)

    -- commands

    local sel_tm=t1[sel_i]
    local sel_e=sel_tm and sel_tm.e
    local targets=current_targets()
    local target_tm=targets and targets[tar_i]
    local tar_e=target_tm and target_tm.e

    if phase==pu then
        if sel_e then
            d_stat_panel('select ally: '..sel_e.name,sel_e)
            printl('⬇️',sel_e.x,sel_e.y-13,'c',9,1)
        end
    elseif phase==pa then
        d_ui_panel()
        each(actions,function(a,i)
            local c=i==action_i and 1 or 5
            local col=(i-1)%2
            local row=flr((i-1)/2)
            local ox=6+60*col
            local oy=107+10*row

            sprc(a.spr,ox+4,oy,a.c)
            printl(a.name,ox+11,oy,nil,c)
        end)
    elseif phase==pt then
        if tar_e then
            if actions[action_i].t=='ally' then
                d_stat_panel('select ally: '..tar_e.name,tar_e)
            else
                d_stat_panel('select target: '..tar_e.name,tar_e)
            end
            printl('⬇️',tar_e.x,tar_e.y-13,'c',actions[action_i].c,1)
        else
            d_ui_panel()
            printl('no target available',4,100,nil,1,nil,{w=118})
        end
    elseif phase==ex then
        d_ui_panel()
        printl(msg,4,100,nil,1,nil,{w=118})
    elseif phase==dn then
        d_ui_panel()
        printl(msg,4,100,nil,1,nil,{w=118})
    end

    if(flash>.2)printl('🅾️',124,120,'r',9,1)
    draw_attack_fx()
end

function card_sel(i,t)
    return ((phase==pu or phase==pa) and t=='ally' and i==sel_i)
        or (phase==pt and actions[action_i].t==t and i==tar_i)
end

function current_targets()
    return actions[action_i].t=='ally' and t1 or t2
end

function move_action_sel(dx,dy)
    local cols=2
    local rows=ceil(#actions/cols)

    local i=action_i-1
    local col=i%cols
    local row=flr(i/cols)

    col=mid(0,col+dx,cols-1)
    row=mid(0,row+dy,rows-1)

    local ni=row*cols+col+1
    if ni>#actions then return action_i end
    return ni
end

function commit_order()
    local tm=t1[sel_i]
    if tm and not tm.order then
        tm.order=assign_i
        assign_i+=1
    end

    if assigned_count()==#t1 then
        start_execute_phase()
    else
        -- jump to the next ally without an assigned action
        sel_i=find_unassigned(sel_i,1)
        phase=pu
        msg='assigned '..assigned_count()..'/'..#t1
    end
end

function assigned_count()
    local c=0
    for tm in all(t1) do
        if tm.action then c+=1 end
    end
    return c
end

function find_unassigned(from_i,dir)
    local i=from_i
    for _=1,#t1 do
        i+=dir
        if i>#t1 then i=1 end
        if i<1 then i=#t1 end
        if not t1[i].action then return i end
    end
    return from_i
end

function find_assigned(from_i,dir)
    local i=from_i
    for _=1,#t1 do
        i+=dir
        if i>#t1 then i=1 end
        if i<1 then i=#t1 end
        if t1[i].action then return i end
    end
    return nil
end

function step_back_order()
    local i=find_assigned(sel_i,-1)
    if not i then
        msg='nothing to undo'
        return
    end

    local tm=t1[i]
    action_i=find(actions,tm.action) or 1
    tm.action=nil
    tm.target=nil
    tm.order=nil
    sel_i=i
    phase=pa
    msg='editing '..tm.e.name
end

function reset_orders()
    for tm in all(t1) do
        tm.action=nil
        tm.target=nil
        tm.order=nil
        tm.boost_ap=0
        tm.boost_he=0
        tm.boost_bp=0
    end
    for tm in all(t2) do
        tm.action=nil
        tm.target=nil
        tm.order=nil
        tm.boost_ap=0
        tm.boost_he=0
        tm.boost_bp=0
    end
    exec_order={}
    exec_i=1
    assign_i=1
end

function start_execute_phase()
    auto_plan_enemy_orders()

    exec_order={}
    for tm in all(t1) do
        tm.boost_ap=0
        tm.boost_he=0
        tm.boost_bp=0
        add(exec_order,tm)
    end
    for tm in all(t2) do
        tm.boost_ap=0
        tm.boost_he=0
        tm.boost_bp=0
        add(exec_order,tm)
    end
    sort(exec_order,function(a,b)
        local pa,pb=a.action.p or 99,b.action.p or 99
        if pa==pb then
            return (a.order or 999)>(b.order or 999)
        end
        return pa>pb
    end)
    exec_i=1
    phase=ex
    msg='executing...'
end

function do_next_action()
    local step=exec_order[exec_i]
    if not step then
        reset_orders()
        phase=pu
        sel_i=1
        msg='turn complete'
        return
    end

    local attacker=step.e
    local target_tm=step.target
    local action=step.action
    local needs_target=action and action.t

    if not is_valid_actor_tm(step) then
        msg=attacker.name..' is down'
        exec_i+=1
        return
    end

    if needs_target and not is_valid_target_tm(target_tm) then
        msg=attacker.name..' skips (no target)'
        exec_i+=1
        return
    end

    if action and action.name=='attack' and target_tm then
        local target=target_tm.e
        local raw=(attacker.ap or 0)+(step.boost_ap or 0)
        local block0=target.block or 0
        local dmg=apply_block(target,raw)
        local hp0=target.hp
        local hp1=max(hp0-dmg,0)
        msg=attacker.name..' hits '..target.name..' '..dmg
        if block0>0 then msg=msg..'('..raw..'-'..min(block0,raw)..')' end
        atk_fx={
            text='-'..dmg,
            sx=target.x,
            sy=target.y-12,
            dx=target.x,
            dy=target.y-24,
            c=8,
            mode='attack',
            e=target,
            hp0=hp0,
            hp1=hp1
        }
        exec_wait=true
        local fx=atk_fx
        add_timer('atk_anim',.5,function()
            if fx and fx.e then
                fx.e.hp=fx.hp1
                clear_shader(fx.e)
            end
            exec_wait=false
            if atk_fx==fx then atk_fx=nil end
        end)
        sfx(1)
        for i=1,4+rnd(5)do
            add_particle(target.x,target.y+4,10+rnd(10),rnd(2)-1,-.8-rnd(.8),true,false,false,1,{2,8,7})
        end
    elseif action and action.name=='heal' and target_tm then
        local target=target_tm.e
        local he=(attacker.he or 0)+(step.boost_he or 0)
        local hp0=target.hp
        local hp1=min(hp0+he,target.max_hp or hp0)
        msg=attacker.name..' heals '..target.name
        atk_fx={
            text='+'..he,
            sx=target.x,
            sy=target.y-12,
            dx=target.x,
            dy=target.y-24,
            c=11,
            mode='heal',
            e=target,
            hp0=hp0,
            hp1=hp1
        }
        exec_wait=true
        local fx=atk_fx
        add_timer('atk_anim',.5,function()
            if fx and fx.e then
                fx.e.hp=fx.hp1
                clear_shader(fx.e)
            end
            exec_wait=false
            if atk_fx==fx then atk_fx=nil end
            for i=1,4+rnd(5)do
                add_particle(target.x,target.y+4,10+rnd(10),rnd(2)-1,-.8-rnd(.8),true,false,false,1,{3,11,7})
            end
        end)
        sfx(2)
        for i=1,15 do
            local dest_x,dest_y=target.x,target.y
            local die=11+rnd(5)
            local a=rnd(1)
            local dist=8+rnd(6)
            local x=dest_x+cos(a)*dist
            local y=dest_y+sin(a)*dist
            local dx=(dest_x-x)/die
            local dy=(dest_y-y)/die

            add_particle(x,y,die,dx,dy,false,false,true,1+rnd(),{3,11,7})
        end
    elseif action and action.name=='block' then
        attacker.block=max((attacker.bp or 0)+(step.boost_bp or 0),0)
        msg=attacker.name..' blocks'
        sfx(3)
        for i=1,15 do
            local dest_x,dest_y=attacker.x,attacker.y
            local die=10+rnd(10)
            local a=rnd(1)
            local dist=8+rnd(6)
            local x=dest_x+cos(a)*dist
            local y=dest_y+sin(a)*dist
            local dx=(dest_x-x)/die
            local dy=(dest_y-y)/die

            add_particle(x,y,die,dx,dy,false,false,true,2+rnd(),{1,12,7})
        end
    elseif action and action.name=='boost' and target_tm then
        local target=target_tm.e
        local target_name=target and target.name or 'target'
        local ta=target_tm.action and target_tm.action.name or nil
        local bm=attacker.bm or 0
        if ta=='attack' then
            local base=target.ap or 0
            local bonus=base*bm
            msg=attacker.name..' boosts '..target_name..' atk='..base+target_tm.boost_ap..'+'..bonus
            target_tm.boost_ap=(target_tm.boost_ap or 0)+bonus
        elseif ta=='heal' then
            local base=target.he or 0
            local bonus=base*bm
            msg=attacker.name..' boosts '..target_name..' heal='..base+target_tm.boost_he..'+'..bonus
            target_tm.boost_he=(target_tm.boost_he or 0)+bonus
        elseif ta=='block' then
            local base=target.bp or 0
            local bonus=base*bm
            msg=attacker.name..' boosts '..target_name..' block='..base+target_tm.boost_bp ..'+'..bonus
            target_tm.boost_bp=(target_tm.boost_bp or 0)+bonus
        else
            msg=attacker.name..' boosts '..target_name..' (no effect)'
        end
        atk_fx={
            mode='boost',
            e=target
        }
        exec_wait=true
        local fx=atk_fx
        add_timer('atk_anim',.5,function()
            if fx and fx.e then
                clear_shader(fx.e)
                refresh_actor_shader(fx.e)
            end
            exec_wait=false
            if atk_fx==fx then atk_fx=nil end
        end)
        sfx(4)
        for i=1,4+rnd(5)do
            add_particle(target.x-6+rnd(13),target.y+8,10+rnd(5),0,-1-rnd(2),false,false,false,1+rnd(1),{9,10,7})
        end
    else
        msg=attacker.name..' uses '..(action and action.name or '...')
    end

    exec_i+=1
end

function auto_plan_enemy_orders()
    local q=shuffled_team(t2)
    for tm in all(q) do
        local a=pick_weighted_action(team_action_weights(tm))
        tm.action=a
        tm.target=nil
        tm.order=assign_i
        assign_i+=1

        if a.t then
            local targets=targets_for_team_action(tm.t,a)
            if #targets>0 then tm.target=pick_weighted_target(tm,a,targets) end
        end
    end
end

function team_action_weights(tm)
    local e=tm and tm.e or nil
    local weights={}
    if not e then return weights end

    -- stats drive the base tendency for each action
    weights.attack=1+(e.ap or 0)*2
    weights.block=1+(e.bp or 0)*2
    weights.heal=1+(e.he or 0)*2
    weights.boost=1+(e.bm or 0)*2

    -- low hp enemies lean defensive/supportive
    if e.hp<=2 then
        weights.block+=3
        weights.heal+=2
    end

    -- heal becomes more attractive when allies are hurt
    weights.heal+=count_damaged_team_members(tm.t)*(e.he or 0)

    -- boost is best when allies have actions worth boosting
    if count_boostable_allies(tm)>=1 then
        weights.boost+=2*(e.bm or 0)
    else
        weights.boost=max(weights.boost-2,0)
    end

    -- if nobody is hurt, de-emphasize healing a bit
    if count_damaged_team_members(tm.t)<=0 then
        weights.heal=max(weights.heal-2,0)
    end

    return weights
end

function pick_weighted_action(weights)
    local total=0
    for a in all(actions) do
        total+=max(weights[a.name] or 0,0)
    end

    if total<=0 then return actions[1] end

    local roll=rnd(total)
    local acc=0
    for a in all(actions) do
        acc+=max(weights[a.name] or 0,0)
        if roll<acc then
            return a
        end
    end

    return actions[1]
end

function pick_weighted_target(src_tm,a,targets)
    local total=0
    local weights={}

    for tm in all(targets) do
        local w=1
        local e=tm.e

        if a.name=='attack' then
            w+=max(6-(e.hp or 0),0)
            w+=max((e.ap or 0)-1,0)
            w+=max((e.he or 0)-1,0)
        elseif a.name=='heal' then
            w+=max(6-(e.hp or 0),0)*2
        elseif a.name=='boost' then
            if tm==src_tm then
                w=0
            elseif tm.action then
                local ta=tm.action
                if ta and ta.k=='ap' then w+=(e.ap or 0)*2
                elseif ta and ta.k=='he' then w+=(e.he or 0)*2
                elseif ta and ta.k=='bp' then w+=(e.bp or 0)*2
                else w=0 end
            else
                w=0
            end
        end

        w=max(w,0)
        weights[tm]=w
        total+=w
    end

    if total<=0 then return rnd(targets) end

    local roll=rnd(total)
    local acc=0
    for tm in all(targets) do
        acc+=weights[tm] or 0
        if roll<acc then return tm end
    end

    return targets[1]
end

function count_damaged_team_members(team_id)
    local team=team_id==1 and t1 or t2
    local c=0
    for tm in all(team) do
        if tm.e and tm.e.hp<(tm.e.max_hp or tm.e.hp) then
            c+=1
        end
    end
    return c
end

function count_boostable_allies(src_tm)
    local team=src_tm.t==1 and t1 or t2
    local c=0
    for tm in all(team) do
        if tm!=src_tm and tm.action and tm.action.k then c+=1 end
    end
    return c
end

function targets_for_team_action(team_id,a)
    if not a or not a.t then return {} end
    if a.t=='enemy' then return team_id==1 and t2 or t1 end
    return team_id==1 and t1 or t2
end

function shuffled_team(team)
    local pool=copy(team)
    local ret={}
    while #pool>0 do
        local i=flr(rnd(#pool))+1
        add(ret,pool[i])
        deli(pool,i)
    end
    return ret
end

function is_valid_target_tm(tm)
    if not tm or not tm.e or tm.e.hp<=0 then return false end
    return find(t1,tm) or find(t2,tm)
end

function is_valid_actor_tm(tm)
    if not tm or not tm.e or tm.e.hp<=0 then return false end
    return find(t1,tm) or find(t2,tm)
end

function is_battle_over()
    return #t1<=0 or #t2<=0
end

function cleanup_dead()
    -- remove defeated actors from both teams and the render list
    for i=#t1,1,-1 do
        local tm=t1[i]
        if tm.e.hp<=0 then
            del(_entities,tm.e)
            deli(t1,i)
        end
    end
    for i=#t2,1,-1 do
        local tm=t2[i]
        if tm.e.hp<=0 then
            del(_entities,tm.e)
            deli(t2,i)
        end
    end

    sel_i=mid(1,sel_i,max(#t1,1))
    local targets=current_targets()
    tar_i=mid(1,tar_i,max(#targets,1))
end

function update_action_fx()
    local t=get_timer('atk_anim')
    if not atk_fx or not t or t.done then return end
    if atk_fx.e and atk_fx.hp0!=nil and atk_fx.hp1!=nil then
        local hp=atk_fx.hp0+(atk_fx.hp1-atk_fx.hp0)*t.perc
        atk_fx.e.hp=flr(hp+0.5)
    end
    -- rapid flash while anim is active
    if not atk_fx.e then return end
    if atk_fx.mode=='attack' then
        if flr(t.perc*10)%2==0 then
            set_flat_shader(atk_fx.e,8)
        else
            set_flat_shader(atk_fx.e,7)
        end
    elseif atk_fx.mode=='heal' then
        if flr(t.perc*6)%2==0 then
            set_flat_shader(atk_fx.e,11)
        else
            set_flat_shader(atk_fx.e,7)
        end
    elseif atk_fx.mode=='boost' then
        if flr(t.perc*8)%2==0 then
            set_flat_shader(atk_fx.e,10)
        else
            set_flat_shader(atk_fx.e,7)
        end
    else
        clear_shader(atk_fx.e)
    end
end

function draw_attack_fx()
    local t=get_timer('atk_anim')
    if not atk_fx or not t or t.done then return end
    if atk_fx.e and atk_fx.mode!='boost' then
        -- local max_hp=max(atk_fx.e.max_hp or 1,1)
        bar(atk_fx.e.x-8,atk_fx.e.y-14,16,min(atk_fx.e.hp/atk_fx.e.max_hp,1),12)
    end
    if atk_fx.text and atk_fx.sx and atk_fx.sy and atk_fx.dx and atk_fx.dy then
        anim_text(atk_fx.text,atk_fx.sx,atk_fx.sy,atk_fx.dx,atk_fx.dy,t.perc,'c',atk_fx.c or 8,1)
    end
end

function refresh_actor_shader(e)
    if not e then return end
    if not e.sprite then return end
    if e.block and e.block>0 then
        e.sprite.o=12
    else
        e.sprite.o=nil
    end
end

function clear_shader(e)
    e.shader=nil
end

function apply_block(target,dmg)
    if dmg<=0 then return 0 end

    local b=target.block or 0
    if b<=0 then return dmg end

    local absorbed=min(b,dmg)
    target.block=max(b-absorbed,0)
    return dmg-absorbed
end

function char_card_h(full)
    return full and 16 or 11
end

function d_char_card(x,y,e,c,full,a)
    local w,h=57,char_card_h(full)

    rrectfill(x,y,w,h,1,c)
    rrectfill(x+1,y+1,w-2,h-2,1,6)
    if full then
        printl(e.name,x+2,y+5,nil,c)
        printl('hp:'..e.hp..' bk:'..e.block,x+2,y+12,nil,c)
        if(a)sprc(a.spr,x+w-6,y+9,a.c)
    else
        printl(e.sn..' '..e.hp..'/'..e.max_hp,x+2,y+6,nil,c)
        if(a)sprc(a.spr,x+w-6,y+7,a.c)
    end
end

function d_stat_panel(label,e)
    d_ui_panel()
    printl(label,4,100,nil,1,nil,{w=118})
    print_char_stats(e)
end

function print_char_stats(e)
    local stats={
        {k='hp',l='hp'},
        {k='ap',l='atk'},
        {k='bp',l='blk'},
        {k='block',l='sh'},
        {k='he',l='hea'},
        {k='bm',l='bst'}
    }
    each(stats,function(s,i)
        local col=(i-1)%3
        local row=flr((i-1)/3)
        local ox=40*col
        local oy=111+9*row
        local l=s.l..':'..e[s.k]
        if(s.k=='hp')l=s.l..':'..e[s.k]..'/'..e.max_hp
        printl(l,ox+4,oy+2,nil,1)
    end)
end
