function characters_i()
    _characters={
        elf={
            id='elf',
            name='elfmir',
            a={idle={{8,0},{24,0}}}
        },
        mas={
            id='mas',
            name='maspidez',
            a={idle={{8,16},{24,16}}}
        },
        dal={
            id='dal',
            name='daliria',
            a={idle={{0,32},{16,32}}}
        },
        pos={
            id='pos',
            name='pos.bove',
            a={idle={{32,32},{48,32}}}
        },
        yun={
            id='yun',
            name='yuna',
            a={idle={{64,32},{80,32}}}
        }
    }
end

function new_character(id,x,y,opts)
    opts=opts or {}
    local c=_characters[id]
    opts.id=c.id
    opts.name=opts.name or c.name
    opts.a=opts.a or c.a
    return new_actor(x,y,opts)
end
