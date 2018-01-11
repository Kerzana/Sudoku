function checkColumn(tableau,line,column)
    errror = 0
    for linecheck = 1, 9 do
        if tableau[linecheck][column] ~= "-" then
            if tonumber(tableau[line][column]) == tonumber(tableau[linecheck][column]) then
                if errror == 2 then
                    return false
                end
                errror = 2
            end
        end
    end
    return true
end

function checkLine(tableau,line,column)
    failure = 0
    for checkcolumn = 1, 9 do
        if tableau[line][checkcolumn] ~= "-" then
            if tonumber(tableau[line][column]) == tonumber(tableau[line][checkcolumn]) then
                if failure == 2 then
                    return false
                end
                failure = 2
            end
        end
    end
    return true
end

function checkBox(tableau,line,column)
    minLine = 0
    maxline = 0
    if  line >= 1 and line <= 3 then
        minLine = 1
        maxline = 3
    else if line >= 4 and line <= 6 then
        minLine = 4
        maxline = 6
    else if line >= 7 and line <= 9 then
        minLine = 7
        maxline = 9
    else
    end
    end
    end
    mincolumn = 0
    maxcolumn = 0
    if  column >= 1 and column <= 3 then
        mincolumn = 1
        maxcolumn = 3
    else if column >= 4 and column <= 6 then
        mincolumn = 4
        maxcolumn = 6
    else if column >= 7 and column <= 9 then
        mincolumn = 7
        maxcolumn = 9
    else
    end
    end
    end
    errror = 0
    for minLine = minLine, maxline do
        for mincolumn = mincolumn, maxcolumn do
            if tableau[minLine][mincolumn] ~= "-" then
                if tonumber(tableau[line][column]) == tonumber(tableau[minLine][mincolumn]) then
                    if errror == 2 then
                        return false
                    end
                    errror = 2
                end
            end
        end
    end
    return true
end

function checkValid(tableau,i,j)
    return(checkBox(tableau,i,j) and checkColumn(tableau,i,j) and checkLine(tableau,i,j))
end

function printtableau(tableau)
	l = 0
	term.setCursorPos(1,1)
	x = 1
	for w = 1, 9 do
		term.setCursorPos(1,x + 1)
		term.setTextColor(colors.gray)
		term.write("|")
		term.setCursorPos(1,x)
		if w == 4 or w == 7 then
			term.setTextColor(colors.red)
		else
			term.setTextColor(colors.gray)
		end
		term.write("-------------------")
		term.setTextColor(colors.yellow)
		term.setCursorPos(2,x + 1)
		for z = 1, 9 do
			old = readfile()
			if old[w][z] == "-" and checkValid(tableau,w,z) and tonumber(tableau[w][z]) > 0 and tonumber(tableau[w][z]) < 10 then
				term.setTextColor(colors.blue)
			elseif checkValid(tableau,w,z) ~= true then
				term.setTextColor(colors.purple)
				l = 2
			end
			if tableau[w][z] == "-" then
			l = 2
				term.setTextColor(colors.lightGray)
			elseif tonumber(tableau[w][z]) > 0 and tonumber(tableau[w][z]) < 10 and tonumber(old[w][z]) > 0 and tonumber(old[w][z]) < 10 and l == 0 then
				term.setTextColor(colors.yellow)
			end
			term.write(tableau[w][z])
			if z == 3 or z == 6 then
				term.setTextColor(colors.red)
			else
				term.setTextColor(colors.gray)
			end
			term.write("|")
			term.setTextColor(colors.yellow)
		end
		x = x + 2
	end
	term.setTextColor(colors.gray)
	term.setCursorPos(1,x)
	term.write("-------------------")
	term.setTextColor(colors.blue)
	if l == 0 then
		term.setCursorPos(22,5)
		term.write("Sudoku Terminer Gg.")
		return true
	end
	return false
end

function readfile()
	tableau = {
		[0] = {}
	}
	local h = fs.open("tableau","r")
	for	b = 1, 9 do
		tableau[b] = {}
		for a = 1, 9 do
			line = h.readLine()
			line = string.sub(line,0,1)
			table.insert(tableau[b],a,line)
		end
	end
	h.close()
	return tableau
end

function readfilesave()
	tableau = {
		[0] = {}
	}
	local h = fs.open("tableausave","r")
	for	b = 1, 9 do
		tableau[b] = {}
		for a = 1, 9 do
			line = h.readLine()
			line = string.sub(line,0,1)
			table.insert(tableau[b],a,line)
		end
	end
	h.close()
	return tableau
end

function clickEvent(tableau,x,y)
	x = math.floor(x/2)
	y = math.floor(y/2)

	if x < 10 and y < 10 and x > 0 and y > 0 then
		if tableau[y][x] == "-" then
			return true
		end
	else
		return exitsudoku
	end
	return false
end

function start()
	term.clear()
	term.setCursorPos(1,1)
	list = shell.programs()
	for k = 0, #list do
		if list[k] == "tableausave" then
			tableau = readfilesave()
			m = 0
			break
		end
		m = 1
	end
	if m == 1 then
		tableau = readfile()
	end
	worktableau = tableau
	while true do
		x = 2
		y = 2
		term.clear()
		fini = printtableau(worktableau)
		if fini then
			break
		end
		local event, button, x, y = os.pullEvent( "mouse_click" )
		if clickEvent(readfile(),x,y) == true then
			term.setCursorPos(math.floor(x/2)*2,math.floor(y/2)*2)
			tmp = read()
			if string.len(tmp) == 1 then
				worktableau[math.floor(y/2)][math.floor(x/2)] = tonumber(tmp)
			end
		elseif clickEvent(readfile(),x,y) == exitsudoku then
			term.setCursorPos(22,5)
			term.write("Exit Programme.")
			local h = fs.open("tableausave","w")
			for i = 1, 9 do
				for j = 1, 9 do
					h.write(worktableau[i][j])
					h.write("\n")
				end
			end
			h.close()
			sleep(3)
			break
		end
	end
	return false
end

start()
