--- @param list table<number>
--- @retrun table
local function insertion(list)
	for i = 2, #list - 1 do
		local key = list[i]
		local j = i - 1
		while j >= 1 and list[j] > key do
			list[j + 1] = list[j]
			j = j - 1
		end
		list[j + 1] = key
	end
end

local array = {}

math.randomseed(os.time())

for i = 1, 10 do
	array[i] = math.random(10)
	io.write(array[i] .. " ")
end
print("")

insertion(array)

for i = 1, 10 do
	io.write(array[i] .. " ")
end
