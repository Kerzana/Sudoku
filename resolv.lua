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
term.setCursorPos(1,1)
x = 0
for w = 1, 9 do
    term.setCursorPos(1,x)
    if w == 4 or w == 7 then
    	term.setTextColor(colors.red)
    else
    	term.setTextColor(colors.gray)
    end
    term.write("------------------")
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,x + 1)
    for z = 1, 9 do
	if checkValid(tableau,w,z) and tonumber(tableau[w][z]) > 0 and tonumber(tableau[w][z]) < 10 then
		term.setTextColor(colors.blue)
	elseif checkValid(tableau,w,z) ~= true then
		term.setTextColor(colors.purple)
		l = 2
	end
	if tableau[w][z] == "-" then
	l = 2
		term.setTextColor(colors.lightGray)
	elseif tonumber(tableau[w][z]) > 0 and tonumber(tableau[w][z]) < 10 then
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
end

function resolvSudoku(tableau,line,column)
    tmpre = 0
    for line = line, 9 do
        if tmpre == 2 then
            column = 1
        end
        tmpre = 2
        for column = column, 9 do
            if tableau[line][column] == "-" then
                for case = 1, 9 do
                    tableau[line][column] = case
                    tmp = checkValid(tableau,line,column)
                    if  tmp == true then
                    	relosv = resolvSudoku(tableau,line,column+1)
                        if relosv == true then
                            return false
                        else if relosv == tableau then
                        	return tableau
                        end
                        end
                    end
                    if case == 9 then
                        tableau[line][column] = "-"
                        return false
                    end
                end
            else
            end
        end
    end
    return tableau
end

function sudokutotable(tableau)
    for n = 1, 9 do
        for b = 1, 9 do
            if checkValid(tableau,n,b) then
            else
                return false
            end
        end
    end
    finishtableau = resolvSudoku(tableau,1,1)
    return finishtableau
end

function sudoku()
	term.clear()
	term.setCursorPos(1,1)
	tableau = {
		[0] = {}
	}
	local h = fs.open("tableau","r")
	for	b = 1, 9 do
		tableau[b] = {}
		for a = 1, 9 do
			line = h.readLine()
			--arg = string.sub(arg,11,arg:len())
				line = string.sub(line,0,1)
			table.insert(tableau[b],a,line)
		end
	end
	h.close()
	tablecheck = tableau
	blue = sudokutotable(tablecheck)
	if blue == false then
	    term.clear()
	    term.setCursorPos(1,1)
	    term.write("Error No Valid Sudoku.")
	    return false
	end
	term.clear()
	local h = fs.open("tableausave","w")
	for i = 1, 9 do
		for j = 1, 9 do
			h.write(blue[i][j])
			h.write("\n")
		end
	end
	h.close()
	printtableau(tableau)
end

sudoku()
