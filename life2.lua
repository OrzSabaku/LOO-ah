-- NOTE: 多分メタテーブルとメタメソッドがよくわかってないから理解しきれてないと思われる
-- これつかって色々実装してみるべきかも

-- この時点でBoardはただの連想配列
-- 公開用のテーブル
local Board = {}

local BoardMethods = {}

-- メタテーブルを作るよ．設定用のメタメソッドをまとめとくのがいいっぽい．
local BoardMeta = {
	__index = BoardMethods,
	-- このダンダーみたいなメンバーはメタメソッドっつうらしくて
	-- 存在しないキーを読み取ろうとしたときにフォールバックする先を登録するみたい
	-- この場合関数ばっか集めた`BoardMethods`に処理を移譲する感じ
}

-- 関数のグローバル宣言ではなく
-- テーブル`Board`に関数を設定している感じ
function Board.new(width, height)
	-- メタテーブル（設定用のテーブル）を貼り付けて初期化
	local self = setmetatable({}, BoardMeta)

	self.width = width
	self.height = height
	self.generation = 1
	self.grid = self:_create_empty_grid()

	-- 今回はメタメソッドを設定してからメンバーを追加したが
	-- メンバーを追加してからメタメソッドを設定してもいい．
	-- Ex.
	-- retrun setmetatable({ width = hikisuu}, Board)

	-- IMPORTANT: というか，別に構文があるわけじゃなくて
	-- 既存機能の組み合わせでオブジェクト指向プログラミングをやる
	-- ってのがプロトタイプベースの基本姿勢？
	-- 実際人によってプロトタイプの書き方が違う
	-- 気分的にはCで構造体に関数突っ込んで使うDIY感がある

	return self
end

function BoardMethods:_create_empty_grid()
	local grid = {}
	for y = 1, self.height do
		grid[y] = {}
		for x = 1, self.width do
			grid[y][x] = false
		end
	end
	return grid
end

function BoardMethods:count_neighbors(x, y)
	local count = 0
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dx == 0 and dy == 0) then
				local nx = ((x - 1 + dx) % self.width) + 1
				local ny = ((y - 1 + dy) % self.height) + 1
				count = count + (self.grid[ny][nx] and 1 or 0)
			end
		end
	end
	return count
end

function BoardMethods:next_generation()
	local next_grid = self:_create_empty_grid()
	for y = 1, self.height do
		for x = 1, self.width do
			local neighbors = self:count_neighbors(x, y)
			local alive = self.grid[y][x]

			if alive and (neighbors == 2 or neighbors == 3) then
				next_grid[y][x] = true
			elseif not alive and neighbors == 3 then
				next_grid[y][x] = true
			else
				next_grid[y][x] = false
			end
		end
	end
	self.grid = next_grid
	self.generation = self.generation + 1
end

function BoardMethods:render()
	io.write("\27[H")
	print(string.format("Generation: %d", self.generation))
	for y = 1, self.height do
		local line = ""
		for x = 1, self.width do
			line = line .. (self.grid[y][x] and "# " or ". ")
		end
		print(line)
	end
end

function BoardMethods:seed(coord)
	for _, pos in ipairs(coord) do
		local x, y = pos[1], pos[2]
		self.grid[y][x] = true
	end
end

-- main --

local board = Board.new(20, 12)

local glider = {
	{ 2, 1 },
	{ 3, 2 },
	{ 1, 3 },
	{ 2, 3 },
	{ 3, 3 },
}

board:seed(glider)

for _ = 1, 30 do
	board:render()
	board:next_generation()
	os.execute("sleep 0.10")
end
