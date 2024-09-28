local grid = {}
local width = 50
local height = 50
local tileSize = 16


local function checkNeighborAmount(x, y, type)
    local amount = 0
    if type == 8 then
        for dx=-1, 1 do
            for dy=-1, 1 do
                if grid[x+dx] and grid[x+dx][y+dy] then
                    amount = amount + 1
                end
            end
        end
    else
        if grid[x-1] and grid[x-1][y] then
            amount = amount + 1
        end
        if grid[x+1] and grid[x+1][y] then
            amount = amount + 1
        end
        if grid[x] and grid[x][y+1] then
            amount = amount + 1
        end
        if grid[x] and grid[x][y-1] then
            amount = amount + 1
        end
    end

    return amount
end

local function randomMap()
    for x=1, width do
        grid[x] = {}
        for y=1, height do
            if love.math.random()>0.5 then
                grid[x][y] = true
            else
                grid[x][y] = false
            end
        end
    end
end

local function balanceMap()
    for x=1, width do
        for y=1, height do
            local amount = checkNeighborAmount(x, y, 8)
            if amount > 6 then
                grid[x][y] = true
            elseif amount < 3 then
                grid[x][y] = false
            end
            local amount4 = checkNeighborAmount(x, y)
            if amount4 == 1 and amount <= 3 then
                grid[x][y] = false
            elseif amount4 > 2 then
                grid[x][y] = true   
            end
        end
    end
end

local function lastSmooth()
    local emptyGrid = {}
    for x=1, width do
        emptyGrid[x] = {}
        for y=1, height do
            emptyGrid[x][y] = false
        end
    end
    for x=1, width do
        for y=1, height do
            local amount = checkNeighborAmount(x, y, 8)
            local amount4 = checkNeighborAmount(x, y)
            emptyGrid[x][y] = grid[x][y]
            if amount4 >= 3 then
                emptyGrid[x][y] = true
            elseif amount4 == 2 and love.math.random() > 0.5 then
                emptyGrid[x][y] = true
            end
        end
    end
    for x=1, width do
        for y=1, height do
            if x == 1 or x == width or y == 1 or y == width then
                grid[x][y] = false
            else
                grid[x][y] = emptyGrid[x][y]
            end
        end
    end
end


posch.on("@loaded", function ()
    randomMap()
    for _=1, 4 do
        balanceMap()
    end
    lastSmooth()

    for x, _ in ipairs(grid) do
        for y, tile in ipairs(grid[x]) do
            if not tile then
                table.insert(world, posch.entities.wall:new({
                    x=(x-1)*tileSize,
                    y=(y-1)*tileSize,
                    width=tileSize, 
                    height=tileSize, 
                }))
                posch.call("@entityCreated")
            end
        end
    end
    
    table.insert(world, posch.entities.tile:new({
        image = love.graphics.newImage("assets/image/sand_tile.png"),
        width = tileSize*width,
        height = tileSize*height
    }))
    posch.call("@entityCreated")
end)

posch.on("@entityCreated", function ()
    world[#world].index = #world
end)