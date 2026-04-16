function characters_i()
    _characters={
        elf='elf|elfamir|0|16|16|16|50|20|10|10|.5',
        mas='mas|maspidez|32|16|48|16|50|20|10|10|.5',
        dal='dal|dalirya|64|16|80|16|50|10|10|20|.5',
        pos='pos|pos.bove|96|16|112|16|50|10|20|10|.5',
        yun='yun|yuna|0|32|16|32|50|10|10|10|1',
        kil='kil|kilia|32|32|48|32|60|10|10|10|.5',
        man='man|manuagog|64|32|80|32|60|10|10|10|.5',
        dar='dar|darkgreen|96|32|112|32|50|10|12|10|.7',
        baz='baz|elbazo|96|48|112|48|40|10|5|10|.5',
        big='big|big\'mon|64|48|80|48|40|10|5|10|.5',
        min='min|minion|0|48|16|48|40|10|5|10|.5',
        bos='bos|boss|32|48|48|48|40|10|5|10|.5',
    }
    for k,v in pairs(_characters)do
        _characters[k]=parse_character_def(v)
    end
end

function parse_character_def(s)
    local p=split(s,'|',false)
    return {
        id=p[1],
        name=p[2],
        a={idle={{tonum(p[3]),tonum(p[4])},{tonum(p[5]),tonum(p[6])}}},
        hp=tonum(p[7]),
        ap=tonum(p[8]),
        bp=tonum(p[9]),
        he=tonum(p[10]),
        bm=tonum(p[11]),
    }
end

function new_character(id,x,y,opts)
    x=x or 0
    y=y or 0
    opts=opts or {}
    local c=_characters[id]
    opts.id=c.id
    opts.name=opts.name or c.name
    opts.sn=opts.sn or id
    opts.a=opts.a or c.a
    opts.hp=c.hp
    opts.max_hp=c.hp
    opts.ap=c.ap
    opts.bp=c.bp
    opts.he=c.he
    opts.bm=c.bm
    return new_actor(x,y,opts)
end
