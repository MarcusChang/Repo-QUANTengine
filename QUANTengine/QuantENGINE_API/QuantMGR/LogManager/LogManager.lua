--[[
level = LOG_FAT,  only concern FAT
level = LOG_ERR, concern FAT, ERR
level = LOG_WRN, concern FAT, ERR, WRN
level = LOG_INF, concern FAT, ERR, WRN, INF
level = LOG_DEB, concern FAT, ERR, WRN, INF, DEB
level = LOG_DEV, concern FAT, ERR, WRN, INF, DEB, Develop
level = LOG_SIM, concern all the seven levels.
]]--

local QuantENGINE = QuantENGINE();
local LogManager = QuantENGINE:LogManager();

--[[
LogManager:SetGlobalLevel(LOG_FAT)
LogManager:SetGlobalLevel(LOG_ERR)
LogManager:SetGlobalLevel(LOG_WRN)
LogManager:SetGlobalLevel(LOG_INF);  --Only concern LOG_FAT, LOG_ERR, LOG_WRN and LOG_INF
LogManager:SetGlobalLevel(LOG_DEB)
LogManager:SetGlobalLevel(LOG_DEV)
LogManager:SetGlobalLevel(LOG_SIM)
]]--

local Logger1 = LogManager:CreateLogger();
Logger1:SetLogLevel(LOG_FAT)
Logger1:Log("Logger1 --> FAT", LOG_FAT)
Logger1:Fatal("Logger1 --> FAT")
Logger1:Log("Logger1 --> ERR", LOG_ERR)
Logger1:Error("Logger1 --> ERR")
Logger1:Log("Logger1 --> WRN", LOG_WRN)
Logger1:Warning("Logger1 --> WRN")
Logger1:Log("Logger1 --> INF", LOG_INF)
Logger1:Information("Logger1 --> INF")
Logger1:Log("Logger1 --> DEB", LOG_DEB)
Logger1:Debug("Logger1 --> DEB")
Logger1:Log("Logger1 --> Develop", LOG_DEV)
Logger1:Develop("Logger1 --> DEV")
Logger1:Log("Logger1 --> Simulation", LOG_SIM)
Logger1:Simulation("Logger1 --> SIM")



local Logger2 = LogManager:CreateLogger();
Logger2:SetLogLevel(LOG_ERR)
Logger2:Log("Logger2 --> FAT", LOG_FAT)
Logger2:Fatal("Logger2 --> FAT")
Logger2:Log("Logger2 --> ERR", LOG_ERR)
Logger2:Error("Logger2 --> ERR")
Logger2:Log("Logger2 --> WRN", LOG_WRN)
Logger2:Warning("Logger2 --> WRN")
Logger2:Log("Logger2 --> INF", LOG_INF)
Logger2:Information("Logger2 --> INF")
Logger2:Log("Logger2 --> DEB", LOG_DEB)
Logger2:Debug("Logger2 --> DEB")
Logger2:Log("Logger2 --> Develop", LOG_DEV)
Logger2:Develop("Logger2 --> DEV")
Logger2:Log("Logger2 --> Simulation", LOG_SIM)
Logger2:Simulation("Logger2 --> SIM")



local Logger3 = LogManager:CreateLogger();
Logger3:SetLogLevel(LOG_WRN)
Logger3:Log("Logger3 --> FAT", LOG_FAT)
Logger3:Fatal("Logger3 --> FAT")
Logger3:Log("Logger3 --> ERR", LOG_ERR)
Logger3:Error("Logger3 --> ERR")
Logger3:Log("Logger3 --> WRN", LOG_WRN)
Logger3:Warning("Logger3 --> WRN")
Logger3:Log("Logger3 --> INF", LOG_INF)
Logger3:Information("Logger3 --> INF")
Logger3:Log("Logger3 --> DEB", LOG_DEB)
Logger3:Debug("Logger3 --> DEB")
Logger3:Log("Logger3 --> Develop", LOG_DEV)
Logger3:Develop("Logger3 --> DEV")
Logger3:Log("Logger3 --> Simulation", LOG_SIM)
Logger3:Simulation("Logger3 --> SIM")


local Logger4 = LogManager:CreateLogger();
Logger4:SetLogLevel(LOG_INF)
Logger4:Log("Logger4 --> FAT", LOG_FAT)
Logger4:Fatal("Logger4 --> FAT")
Logger4:Log("Logger4 --> ERR", LOG_ERR)
Logger4:Error("Logger4 --> ERR")
Logger4:Log("Logger4 --> WRN", LOG_WRN)
Logger4:Warning("Logger4 --> WRN")
Logger4:Log("Logger4 --> INF", LOG_INF)
Logger4:Information("Logger4 --> INF")
Logger4:Log("Logger4 --> DEB", LOG_DEB)
Logger4:Debug("Logger4 --> DEB")
Logger4:Log("Logger4 --> Develop", LOG_DEV)
Logger4:Develop("Logger4 --> DEV")
Logger4:Log("Logger4 --> Simulation", LOG_SIM)
Logger4:Simulation("Logger4 --> SIM")


local Logger5 = LogManager:CreateLogger();
Logger5:SetLogLevel(LOG_DEB)
Logger5:Log("Logger5 --> FAT", LOG_FAT)
Logger5:Fatal("Logger5 --> FAT")
Logger5:Log("Logger5 --> ERR", LOG_ERR)
Logger5:Error("Logger5 --> ERR")
Logger5:Log("Logger5 --> WRN", LOG_WRN)
Logger5:Warning("Logger5 --> WRN")
Logger5:Log("Logger5 --> INF", LOG_INF)
Logger5:Information("Logger5 --> INF")
Logger5:Log("Logger5 --> DEB", LOG_DEB)
Logger5:Debug("Logger5 --> DEB")
Logger5:Log("Logger5 --> Develop", LOG_DEV)
Logger5:Develop("Logger5 --> DEV")
Logger5:Log("Logger5 --> Simulation", LOG_SIM)
Logger5:Simulation("Logger5 --> SIM")


local Logger6 = LogManager:CreateLogger();
Logger6:SetLogLevel(LOG_Develop)
Logger6:Log("Logger6 --> FAT", LOG_FAT)
Logger6:Fatal("Logger6 --> FAT")
Logger6:Log("Logger6 --> ERR", LOG_ERR)
Logger6:Error("Logger6 --> ERR")
Logger6:Log("Logger6 --> WRN", LOG_WRN)
Logger6:Warning("Logger6 --> WRN")
Logger6:Log("Logger6 --> INF", LOG_INF)
Logger6:Information("Logger6 --> INF")
Logger6:Log("Logger6 --> DEB", LOG_DEB)
Logger6:Debug("Logger6 --> DEB")
Logger6:Log("Logger6 --> Develop", LOG_DEV)
Logger6:Develop("Logger6 --> DEV")
Logger6:Log("Logger6 --> Simulation", LOG_SIM)
Logger6:Simulation("Logger6 --> SIM")


local Logger7 = LogManager:CreateLogger();
Logger7:SetLogLevel(LOG_Simulation)
Logger7:Log("Logger7 --> FAT", LOG_FAT)
Logger7:Fatal("Logger7 --> FAT")
Logger7:Log("Logger7 --> ERR", LOG_ERR)
Logger7:Error("Logger7 --> ERR")
Logger7:Log("Logger7 --> WRN", LOG_WRN)
Logger7:Warning("Logger7 --> WRN")
Logger7:Log("Logger7 --> INF", LOG_INF)
Logger7:Information("Logger7 --> INF")
Logger7:Log("Logger7 --> DEB", LOG_DEB)
Logger7:Debug("Logger7 --> DEB")
Logger7:Log("Logger7 --> Develop", LOG_DEV)
Logger7:Develop("Logger7 --> DEV")
Logger7:Log("Logger7 --> Simulation", LOG_SIM)
Logger7:Simulation("Logger7 --> SIM")


