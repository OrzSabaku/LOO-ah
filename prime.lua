local function prime(limit)
	local is_prime = {}
	for i = 2, limit do
		is_prime[i] = true
	end

	for i = 2, math.sqrt(limit) do
		if is_prime[i] then
			for j = i * i, limit, i do
				is_prime[j] = false
			end
		end
	end
	return is_prime
end

local function prime2(limit)
	local composite = {}
	local primes = {}

	for i = 2, limit do
		if not composite[i] then
			primes[#primes + 1] = i
			for j = i * i, limit, i do
				composite[j] = true
			end
		end
	end

	return primes
end

local primes = prime(100)

for i = 1, 100 do
	io.write(string.format("%3s ", primes[i] and i or "---"))
	io.write(i % 10 == 0 and "\n" or "")
end

local primes2 = prime2(100)

for i = 1, #primes2 do
	print(primes2[i])
end
