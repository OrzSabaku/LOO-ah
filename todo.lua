--- @param filename string
local function load_todos(filename)
	local file = io.open(filename, "r")
	if not file then
		return {}
	end

	local todos = {}
	for line in file:lines() do
		table.insert(todos, line)
	end
	file:close()
	return todos
end

--- @param filename string
--- @param todos table<string>
local function save_todos(filename, todos)
	local file = assert(io.open(filename, "a"))
	for _, item in ipairs(todos) do
		file:write(item .. "\n")
	end
	file:close()
end

save_todos("tasks.txt", { "Pending: Learn Lua", "Pending: Send a application for Security Camp" })
for idx, value in ipairs(load_todos("tasks.txt")) do
	print(idx, value)
end
