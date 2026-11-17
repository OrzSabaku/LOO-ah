local function bubble(list)
	for _ = 1, #list - 1 do
		for i = 1, #list - 1 do
			if list[i] > list[i + 1] then
				list[i], list[i + 1] = list[i + 1], list[i]
			end
		end
	end
end

local array = {}

math.randomseed(os.time())

for i = 1, 10 do
	array[i] = math.random(10)
	print(array[i])
end

bubble(array)

for i = 1, 10 do
	print(array[i])
end
