local WIDTH = 20
local HEIGHT = 10
local GENERATIONS = 100

local function create_grid(width, height)
	local grid = {}
	for y = 1, height do
		grid[y] = {}
		for x = 1, width do
			grid[y][x] = false
		end
	end
	return grid
end

local function count_neighbors(grid, x, y)
	local count = 0
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dx == 0 and dy == 0) then
				-- トーラスにするための処置．
				-- Luaは1-originなのでこのように書いたが
				-- 0-originで計算を考えたほうが理解しやすいと思った
				local nx = ((x - 1 + dx) % WIDTH) + 1
				local ny = ((y - 1 + dy) % HEIGHT) + 1
				count = count + (grid[ny][nx] and 1 or 0)
			end
		end
	end
	return count
end

local function next_generation(grid)
	local next_gird = create_grid(WIDTH, HEIGHT)
	for y = 1, HEIGHT do
		for x = 1, WIDTH do
			local neighbors = count_neighbors(grid, x, y)
			local alive = grid[y][x]

			if alive and (neighbors == 2 or neighbors == 3) then
				next_gird[y][x] = true
			elseif not alive and neighbors == 3 then
				next_gird[y][x] = true
			else
				next_gird[y][x] = false
			end
		end
	end
	return next_gird
end

local function render(grid, gen)
	io.write("\27[H")
	print(string.format("Generation: %d", gen))
	for y = 1, HEIGHT do
		local line = ""
		for x = 1, WIDTH do
			line = line .. (grid[y][x] and "# " or ". ")
		end
		print(line)
	end
end

local grid = create_grid(WIDTH, HEIGHT)

local glider = {
	{ 2, 1 },
	{ 3, 2 },
	{ 1, 3 },
	{ 2, 3 },
	{ 3, 3 },
}

for _, pos in ipairs(glider) do
	local x, y = pos[1], pos[2]
	grid[y][x] = true
end

for gen = 1, GENERATIONS do
	render(grid, gen)
	grid = next_generation(grid)
	os.execute("sleep 0.10")
end
