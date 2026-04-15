-- utils
function log(_text, override)
    printh(_text, "log", override or false)
end

function each(t,f,reverse)
	if reverse then
		for i=#t,1,-1 do
			local v=t[i]
			f(v,i)
		end		
	else
		for i,v in ipairs(t)do
			local v=t[i]
			f(v,i)
		end
	end
end

-- point to point distance
function point_dist(x1,y1,x2,y2)
	return sqrt((x2-x1)^2+(y2-y1)^2)
end

-- sprite centered
function ssprc(sx,sy,sw,sh,dx,dy,dw,dh,fx,oc)
    dw = dw or sw
    dh = dh or sh
    dx = dx - dw/2
    dy = dy - dh/2
    fx = fx or false

    -- outline
    if oc then
        for i=1,15 do pal(i,oc) end
        sspr(sx,sy,sw,sh,dx-1,dy,dw,dh,fx)
        sspr(sx,sy,sw,sh,dx+1,dy,dw,dh,fx)
        sspr(sx,sy,sw,sh,dx,dy-1,dw,dh,fx)
        sspr(sx,sy,sw,sh,dx,dy+1,dw,dh,fx)
        pal()
    end

    sspr(sx,sy,sw,sh,dx,dy,dw,dh,fx)
end

function sprc(n,x,y,oc)
    ssprc(n%16*8,flr(n/16)*8,8,8,x,y,8,8,false,oc)
end

-- print label
-- opts.w: max label width in pixels; text wraps to new lines when exceeded.
-- opts.vcenter: when true, vertically center lines around y (default: false for wrapped text, true otherwise).
function printl(text,x,y,align,c,oc,opts)
    text = tostr(text)
    opts = opts or {}
    local max_w=opts.w
    local vcenter=opts.vcenter
    local lines = {}

    if max_w then
        local raw_lines=split(text,'\n',false)
        for raw in all(raw_lines) do
            wrap_lines(lines,raw,max_w)
        end
    else
        lines = split(text,'\n',false)
    end

    if vcenter==nil then vcenter=not max_w end
    if vcenter then
        local h=7*#lines
        y=y-flr(h/2)
    end
    for i,l in ipairs(lines) do
        local cx=x
        local cy = y + (i-1)*7
        c = c or 7
        local w = print(l,128,-10) - 128
        if align=='r' then
            cx = x - w
        elseif align=='c' then
            cx = x - w/2
        end
        if oc then
            print(l,cx,cy-1,oc)
            print(l,cx,cy+1,oc)
            print(l,cx-1,cy,oc)
            print(l,cx+1,cy,oc)
        end
        print(l,cx,cy,c)
    end
end

function wrap_lines(out,raw,max_w)
    if raw=='' then
        add(out,'')
        return
    end

    local words=split(raw,' ',false)
    local cur=''
    for w in all(words) do
        local cand=cur=='' and w or cur..' '..w
        if text_w(cand)<=max_w then
            cur=cand
        else
            if cur!='' then add(out,cur) end
            if text_w(w)<=max_w then
                cur=w
            else
                cur=break_word(out,w,max_w)
            end
        end
    end
    if cur!='' then add(out,cur) end
end

function break_word(out,w,max_w)
    local part=''
    for i=1,#w do
        local ch=sub(w,i,i)
        local cand=part..ch
        if part=='' or text_w(cand)<=max_w then
            part=cand
        else
            add(out,part)
            part=ch
        end
    end
    return part
end

function text_w(t)
    return print(t,128,-10)-128
end

function bar(x,y,w,p,c)
    local bw=max((w-2)*p,1)
    rrectfill(x,y,w,5,1,1)
    rrectfill(x+1,y+1,bw,3,1,c)
end

-- table functions
function find(t,s)
    for i,v in ipairs(t)do
        if(v==s)return i
    end
    return nil
end
--- create a new table with the same elements
function copy(t)
    local ret={}
    for v in all(t)do
        add(ret,v)
    end
    return ret
end

--animate a text by moving based on a percentage value
function anim_text(t,sx,sy,dx,dy,p,a,c,oc)
    local x=sx+(dx-sx)*p
    local y=sy+(dy-sy)*p
    printl(t,x,y,a,c,oc)
end

function d_ui_panel(x,y,w,h)
    x,y,w,h=x or 1,y or 97,w or 126,h or 30
    rrectfill(x,y,w,h,2,1)
    rrectfill(x+1,y+1,w-2,h-2,2,6)
end

function ease_in_out_back(x)
    local c1 = 1.70158
    local c2 = c1 * 1.525
    
    return x < 0.5
      and ((2 * x)^2 * ((c2 + 1) * 2 * x - c2)) / 2
      or ((2 * x - 2)^2 * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
    
end
