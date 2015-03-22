local NamedEventManager = QuantCORE():NamedEventManager()

local iterations = 100000
local clock = os.clock

--local productPath = "SIM.O.NK.JUN2013.10000.C.0"
local productPath = "SIM.O.XJO.JUN2013.2200.C.0"
local productData 
local store = { }
local group = "group";

function OnStart()
	local productParser = Util:ProductParser(productPath)

    productData = { }
    productData.Product = productParser:Product()
    productData.IsStrategy = productParser:IsStrategy()
    if not(productData.IsStrategy) then
        productData.Strike = productParser:Strike()
        productData.OptionType = productParser:CallPut()
        productData.Version = productParser:VersionNr()
        productData.Series = productParser:Series()
    else
        local strategyParser = productParser:Strategy()
        productData.IsTight = strategyParser:TightStrategy()
        productData.StrategyType = strategyParser:StrategyType()
        productData.Legs = strategyParser:Legs()
        
        productData.IsVolStrategy = strategyParser:IsVolStrategy()
        if (productData.IsVolStrategy) then
            productData.VolLeg = strategyParser:VolLeg()
            productData.Price = strategyParser:Price()
            productData.Currency = strategyParser:Currency()
            productData.Delta = strategyParser:Delta()
        end
    end
    productData.ProductType = productParser:ProductType()
    productData.ProductName = productParser:ProductName()
    productData.Environment = productParser:Simulation()
    
    TestAddEvent();
    TestGetEvent();
    TestRemoveEvent();
end

function OnStop()

end

function TestAddEvent()
	local startTime = clock()
    for i=1, iterations do
        NamedEventManager:AddEvent(group, tostring(i), productData);
    end
    local endTime = clock()
    
    local totalTime = (endTime - startTime) * 1000
    print("[INF]AddEvent: total time = "..tostring(totalTime).."ms.")
    print("[INF]AddEvent: average time = "..tostring(totalTime * 1000 / iterations) .."us.")
end

function TestGetEvent()
    local startTime = clock()    
    for i=1, iterations do
        local productData = NamedEventManager:GetEvent(group, tostring(i), "")
    end     
    local endTime = clock()
    
    local totalTime = (endTime - startTime) * 1000
    print("[INF]GetEvent: total time = "..tostring(totalTime).."ms.")
    print("[INF]GetEvent: average time = "..tostring(totalTime * 1000 / iterations) .."us.")
end

function TestRemoveEvent()
    local startTime = clock()    
    for i=1, iterations do
        local productData = NamedEventManager:RemoveEvent(group, tostring(i));
    end     
    local endTime = clock()
    
    local totalTime = (endTime - startTime) * 1000
    print("[INF]RemoveEvent: total time = "..tostring(totalTime).."ms.")
    print("[INF]RemoveEvent: average time = "..tostring(totalTime * 1000 / iterations) .."us.")
end