function particles_i()
    effects = {}

    explode_size = 5
    explode_colors = {8,9,6,5}
    explode_amount = 5

    -- sfx definition
end

function particles_u(fx_list)
    fx_list = fx_list or effects
    for fx in all(fx_list) do
        --lifetime
        fx.t+=1
        if(fx.t>fx.die)del(fx_list,fx)
        
        --color depends on lifetime
        local perc = fx.t/fx.die
        local ci = flr((perc * #fx.c_table) + 1)
        fx.c=fx.c_table[ci]

        --physics
        if fx.grav then fx.dy+=.05 end
        if fx.grow then fx.r+=.1 end
        if fx.shrink then fx.r-=.1 end

        --move
        fx.x+=fx.dx
        fx.y+=fx.dy
    end
end

function particles_d(fx_list)
    fx_list = fx_list or effects
    for fx in all(fx_list) do
        --draw pixel for size 1, draw circle for larger
        if fx.r<=1 then
            pset(fx.x,fx.y,fx.c)
        else
            circfill(fx.x,fx.y,fx.r,fx.c)
        end
    end    
end

function add_particle(x,y,die,dx,dy,grav,grow,shrink,r,c_table,fx_list)
    fx_list = fx_list or effects
    local fx={
        x=x,
        y=y,
        t=0,
        die=die,
        dx=dx,
        dy=dy,
        grav=grav,
        grow=grow,
        shrink=shrink,
        r=r,
        c=0,
        c_table=c_table
    }
    add(fx_list,fx)
end
