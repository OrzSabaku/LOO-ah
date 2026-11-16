local function fibonacci(n)
	if n == 0 then
		return 0
	end

	local a, b = 0, 1
	for _ = 2, n do
		a, b = b, a + b
	end
	return b
end

local memo = {}
local function fib2(n)
	if n == 0 or n == 1 then
		return n
	-- Luaでは0はfalseyではないらしい
	elseif memo[n] ~= nil then
		return memo[n]
	else
		memo[n] = fib2(n - 2) + fib2(n - 1)
		return memo[n]
	end
end

print("---")

for i = 0, 10 do
	print(string.format("fib(%d) = %d", i, fibonacci(i)))
end

print("---")

for i = 0, 40 do
	print(string.format("fib(%03d) = %d", i, fib2(i)))
end
