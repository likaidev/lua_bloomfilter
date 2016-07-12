local bitset = require("bitset")
local bit  = require("bit")

local SimpleHash={}

function SimpleHash:new(cap,seed)
    return setmetatable({
        cap = cap,
        seed = seed
    }, { __index = SimpleHash})
end

function SimpleHash:hash(value)
    local result = 0
    for i = 1, #value do
        result = self.seed * result + string.byte(value, i)
    end
    return bit.band(self.cap -1 ,result)
end

local BloomFilter={
     seeds = {3,5,7, 11, 13, 31, 37, 61}
}

function BloomFilter:new(defalut_size)
    local hobjs = {}
    defalut_size = defalut_size or bit.lshift(2, 24)
    for _, seed in pairs(self.seeds) do
        table.insert(hobjs, SimpleHash:new(defalut_size, seed))
    end

    return setmetatable({
        bits = bitset:new(),
        hobjs = hobjs
    },
    {__index = BloomFilter}
    )
end

function BloomFilter:put(value)
    if value ~= nil then
        for _, hobj in pairs(self.hobjs) do
            self.bits:set(hobj:hash(value))
        end
    end
end

function BloomFilter:contain(value)
    if value == nil then
        return false
    end
    ret = true

    for _, hobj in pairs(self.hobjs) do
        ret = ret and self.bits:get(hobj:hash(value))
    end

    return ret
end

return BloomFilter
