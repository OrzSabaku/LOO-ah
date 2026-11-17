local array = {}

local function prime(limit)
	array[1] = false
	for i = 2, math.sqrt(limit) do
		if array[i] then
			for j = i * i, limit, i do
				array[j] = false
			end
		end
	end
end

for i = 1, 100 do
	array[i] = true
end

prime(100)

for i = 1, 100 do
	io.write(string.format("%3s ", array[i] and i or "---"))
	io.write(i % 10 == 0 and "\n" or "")
end
