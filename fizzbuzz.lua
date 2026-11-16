for i = 1, 100, 1 do
	if i % 15 == 0 then
		print(i, "FizzBuzz")
	elseif i % 3 == 0 then
		print(i, "Fizz")
	elseif i % 5 == 0 then
		print(i, "Buzz")
	else
		print(i)
	end
end

local rules = {
	{
		num = 3,
		text = "Fizz",
	},
	{
		num = 5,
		text = "Buzz",
	},
}

for i = 1, 40 do
	local out = ""
	for _, rule in ipairs(rules) do
		if i % rule.num == 0 then
			out = out .. rule.text
		end
	end

	if out ~= "" then
		print(i, out)
	else
		print(i)
	end
end
