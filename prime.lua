local array = {}

local function prime(x)
	array[1] = false
	for i = 1, math.sqrt(x) do
		if array[i] then
			local j = 2
			while i * j <= x do
				array[i * j] = false
				j = j + 1
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
