function characters_i()
    _characters={
        elf={
            id='elf',
            name='elfamir',
            a={idle={{8,0},{24,0}}},
            hp=50,
            ap=15,
            bp=5,
            he=15,
            bm=.5,
        },
        mas={
            id='mas',
            name='maspidez',
            a={idle={{8,16},{24,16}}},
            hp=50,
            ap=15,
            bp=5,
            he=15,
            bm=.5,
        },
        dal={
            id='dal',
            name='dalirya',
            a={idle={{0,32},{16,32}}},
            hp=50,
            ap=10,
            bp=5,
            he=20,
            bm=.5,
        },
        pos={
            id='pos',
            name='pos.bove',
            a={idle={{32,32},{48,32}}},
            hp=50,
            ap=10,
            bp=10,
            he=15,
            bm=.5,
        },
        yun={
            id='yun',
            name='yuna',
            a={idle={{64,32},{80,32}}},
            hp=50,
            ap=10,
            bp=5,
            he=15,
            bm=1,
        }
    }
end

function new_character(id,x,y,opts)
    opts=opts or {}
    local c=_characters[id]
    opts.id=c.id
    opts.name=opts.name or c.name
    opts.a=opts.a or c.a
    opts.hp=c.hp
    opts.ap=c.ap
    opts.bp=c.bp
    opts.he=c.he
    opts.bm=c.bm
    return new_actor(x,y,opts)
end
