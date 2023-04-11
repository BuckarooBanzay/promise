
mtt.register("simple promise", function(callback)
    Promise.new(function(resolve)
        resolve(5)
    end):next(function(result)
        assert(result == 5)
        callback()
    end)
end)

mtt.register("returned promise", function(callback)
    local p1 = Promise.new(function(resolve)
        resolve(5)
    end)

    local p2 = Promise.new(function(resolve)
        resolve(10)
    end)

    p1:next(function(result)
        assert(result == 5)
        return p2
    end):next(function(result)
        assert(result == 10)
        callback()
    end)
end)

mtt.register("error handling", function(callback)
    Promise.new(function(_, reject)
        reject("nope")
    end):catch(function(err)
        assert(err == "nope")
        callback()
    end)
end)

mtt.register("Promise.all", function(callback)
    local p1 = Promise.new(function(resolve)
        resolve(5)
    end)

    local p2 = Promise.new(function(resolve)
        resolve(10)
    end)

    Promise.all(p1, p2):next(function(values)
        assert(#values == 2)
        assert(values[1] == 5)
        assert(values[2] == 10)
        callback()
    end):catch(function(err)
        callback(err)
    end)
end)

mtt.register("Promise.race", function(callback)
    local p1 = Promise.new(function(resolve)
        resolve(5)
    end)

    local p2 = Promise.new(function() end)

    Promise.race(p1, p2):next(function(v)
        assert(v == 5)
        callback()
    end)
end)
