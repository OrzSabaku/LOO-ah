local function bubble(table)
	for _ = 1, #table - 1 do
		for i = 1, #table - 1 do
			if table[i] > table[i + 1] then
				table[i], table[i + 1] = table[i + 1], table[i]
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
