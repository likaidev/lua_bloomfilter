# lua_bloomfilter
布隆过滤器
需要引入https://github.com/bsm/bitset.lua

实现方案按照《数据之美第二版》布隆过滤器

对于每个字符串，用8个不同的随机产生器（F1,F2,.....,F8）产生8个信息指纹(f1,f2,....,f8)
再将这八个信息指纹映射到 1 到容器中中的八个自然数 g1, g2, ...,g8

使用示例：

local BloomFilter = require("bloomfilter")


bf = BloomFilter:new() --或设置过滤器的容量：bf = BloomFilter:new(10000)，容量大小影响过滤器的误判率


bf:put("lk_1988@126.com") --添加值，值类型为string

print(bf:contain("lk_1988@126.com")) --判断值是否存在

目前实现版本简单，欢迎各位大神批评指正。

可以通过lk_1988@126.com或者qq:809723918 与我联系
