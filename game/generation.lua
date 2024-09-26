local grid = {}
local width = 50
local height = 50
local tileSize = 20

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
            end
            if amount < 3 then
                grid[x][y] = false
            end
            local amount4 = checkNeighborAmount(x, y)
            if amount4 < 2 and amount < 4 then
                grid[x][y] = false
            elseif amount4 > 2 then
                grid[x][y] = true
            end
        end
    end
end



posch.on("@loaded", function ()
    randomMap()
    for _=1, 4 do
        balanceMap()
    end
    for x, _ in ipairs(grid) do
        for y, tile in ipairs(grid[x]) do
            if not tile then
                table.insert(world, posch.entities.wall:new({x=x*tileSize, y=y*tileSize,width=tileSize, height=tileSize, colliderTag={"ent"}}))
            end
        end
    end
end)
