--- @param expr string
--- @return number
local function eval_rpn(expr)
	local stack = {}
	local ops = {
		["+"] = function(a, b)
			return a + b
		end,
		["-"] = function(a, b)
			return a - b
		end,
		["*"] = function(a, b)
			return a * b
		end,
		["/"] = function(a, b)
			return a / b
		end,
	}

	for token in expr:gmatch("%S+") do
		local num = tonumber(token)
		if num then
			table.insert(stack, num)
		else
			local op = ops[token]
			assert(op, "未知の演算子または不正なトークン: " .. token)
			assert(#stack >= 2, "オペランドが不足しています: " .. token)

			local b = table.remove(stack)
			local a = table.remove(stack)
			table.insert(stack, op(a, b))
		end
	end

	assert(#stack == 1, "式の形式が不正です（スタック残数: " .. #stack .. "）")
	return stack[1]
end

print(eval_rpn("3 4 + 2 *")) -- 14
print(eval_rpn("10 2 / 3 -")) -- 2.0
print(eval_rpn("5 1 2 + 4 * + 3 -")) -- 14
