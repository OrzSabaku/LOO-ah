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

-- nilがfalsyなので，合成数を逆だったかもしれねェにすることによって，初期化を減らせる
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

-- わざわざ2つも変数いらんやんけと思ったけど，truethyとfalsyの扱いで結局コード量は上の方が少ない
local function prime3(limit)
	local array = {}
	array[1] = true

	for i = 2, limit do
		if not array[i] then
			array[i] = i
			for j = i * i, limit, i do
				array[j] = true
			end
		end
	end

	return array
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

local primes3 = prime3(100)

for i = 1, #primes3 do
	-- Luaは真偽値周りの仕様が特異
	-- nilとfalseだけがfalsyでそれ以外はすべてtrue扱いらしい
	if type(primes3[i]) == "number" then
		print(primes3[i])
	end
end
