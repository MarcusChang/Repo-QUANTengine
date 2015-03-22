
local QuantCORE = QuantCORE();
local attManager = QuantCORE:AttManager();
local ProductManager = QuantCORE:ProductManager();
--local MachineSpec="MQ5_XJO_MAC1";
local MachineSpec = "AOM_XJO_MAC1"
local productPath = "SIM.O.XJO.SEP2013.3000.C.0";


local timer_Id=100;
local timer_Interval=8000;

function OnStart()
attManager:SubscribeAtt(MachineSpec, false, "att_update_message.lua"); 
--attManager:SubscribeAtt(MachineSpec, true, "att_update_message.lua");   

local ATT_GetUpdateMessage = attManager:GetUpdateMessage(MachineSpec);
print("ATT_GetUpdateMessage:GetCalcActive()->"..tostring(ATT_GetUpdateMessage:GetCalcActive()));

local ATT_GetLimitData = attManager:GetLimitData(MachineSpec);
print("------->ATT_GetLimitData:GetCurrentContractLimit()------->"..tostring(ATT_GetLimitData:GetCurrentContractLimit()))
print("------->ATT_GetLimitData:GetGlobalContractLimit()------->"..tostring(ATT_GetLimitData:GetGlobalContractLimit()))
print("------->ATT_GetLimitData:GetCurrentDeltaLimit()------->"..tostring(ATT_GetLimitData:GetCurrentDeltaLimit()))
print("------->ATT_GetLimitData:GetPullOffset()------->"..tostring(ATT_GetLimitData:GetPullOffset()))
print("------->ATT_GetLimitData:GetMinHedgeVolume()------->"..tostring(ATT_GetLimitData:GetMinHedgeVolume()))
print("------->ATT_GetLimitData:GetMaxHedgeVolume()------->"..tostring(ATT_GetLimitData:GetMaxHedgeVolume()))
print("------->ATT_GetLimitData:GetUnderlyingRefNudge()------->"..tostring(ATT_GetLimitData:GetUnderlyingRefNudge()))
print("------->ATT_GetLimitData:GetGlobalDeltaLimit()------->"..tostring(ATT_GetLimitData:GetGlobalDeltaLimit()))

local ATT_GetSpec = attManager:GetSpec(MachineSpec);
print("--------->ATT_GetSpec:GetUser()-------->"..tostring(ATT_GetSpec:GetUser()))
print("--------->ATT_GetSpec:GetUserGroup()-------->"..tostring(ATT_GetSpec:GetUserGroup()))
print("--------->ATT_GetSpec:GetMachineType()-------->"..tostring(ATT_GetSpec:GetMachineType()))
print("--------->ATT_GetSpec:GetTargetProduct()-------->"..tostring(ATT_GetSpec:GetTargetProduct()))
print("--------->ATT_GetSpec:GetHedgeProduct()-------->"..tostring(ATT_GetSpec:GetHedgeProduct()))

local ATT_IsMachineAlive = attManager:IsMachineAlive(MachineSpec);
print("--------->ATT_IsMachineAlive-------->"..tostring(ATT_IsMachineAlive));

local ATT_GetKeepAliveNotification = attManager:GetKeepAliveNotification(MachineSpec);
print("------------>ATT_GetKeepAliveNotification:Command()---------->"..tostring(ATT_GetKeepAliveNotification:Command()))

local ATT_GetLimitUpdate = attManager:GetLimitUpdate(MachineSpec);
ATT_GetLimitUpdate:ResetGlobalDeltaLimit();
ATT_GetLimitUpdate:ResetGlobalContractLimit();
ATT_GetLimitUpdate:SetGlobalDeltaLimit(3333);
ATT_GetLimitUpdate:SetGlobalContractLimit(3333);
ATT_GetLimitUpdate:SetPullOffset(3.0);
ATT_GetLimitUpdate:SetMinHedgeVolume(3);
ATT_GetLimitUpdate:SetMaxHedgeVolume(3333);
ATT_GetLimitUpdate:SetUnderlyingRefNudge(3.5);
ATT_GetLimitUpdate:AddLimitUpdate(productPath, true, true, 2222, true, true, 2222, true, true, 2222, true);
--void AddLimitUpdate( string productPath, bool on, bool preHedgeOn, number limit, bool reset, bool bidon, number bidLimit, bool bidReset, bool askOn, number askLimit, bool askReset )

local ATT_CreateLimitUpdate = attManager:CreateLimitUpdate(MachineSpec);
ATT_CreateLimitUpdate:ResetGlobalDeltaLimit();
ATT_CreateLimitUpdate:ResetGlobalContractLimit();
ATT_CreateLimitUpdate:SetGlobalDeltaLimit(3333);
ATT_CreateLimitUpdate:SetGlobalContractLimit(3333);
ATT_CreateLimitUpdate:SetPullOffset(3.0);
ATT_CreateLimitUpdate:SetMinHedgeVolume(3);
ATT_CreateLimitUpdate:SetMaxHedgeVolume(3333);
ATT_CreateLimitUpdate:SetUnderlyingRefNudge(3.5);
ATT_CreateLimitUpdate:AddLimitUpdate(productPath, true, true, 2222, true, true, 2222, true, true, 2222, true);
--void AddLimitUpdate( string productPath, bool on, bool preHedgeOn, number limit, bool reset, bool bidon, number bidLimit, bool bidReset, bool askOn, number askLimit, bool askReset )

local ATT_SendLimitUpdate = attManager:SendLimitUpdate(MachineSpec, ATT_CreateLimitUpdate);
print("------------>ATT_SendLimitUpdate----------->"..tostring(ATT_SendLimitUpdate));


local ATT_CreateEdgeUpdate = attManager:CreateEdgeUpdate(MachineSpec);
ATT_CreateEdgeUpdate:AddEdgeUpdate(productPath, 3, 3, 4, 4, 20, QS_SPREAD_UNIT_UNDEFINDED, 3.0, 3.0, 4.0, 4.0)
--[[
void AddEdgeUpdate( string productPath, number bid, number ask, number dACBid, number dACAsk, number tolerance, rsSpreadUnitEnum spreadUnit, number bidDime, number askDime, number bidMatch, number askMatch )
QS_SPREAD_UNIT_CENTS
QS_SPREAD_UNIT_PERCENTAGE
QS_SPREAD_UNIT_TICKS
QS_SPREAD_UNIT_VOL
--]]

local ATT_SendEdgeUpdate = attManager:SendEdgeUpdate(MachineSpec, ATT_CreateEdgeUpdate);
print("------------->ATT_SendEdgeUpdate----------->"..tostring(ATT_SendEdgeUpdate));


local ATT_SendMachineCommand_Start = attManager:SendMachineCommand(MachineSpec, QS_START_MACHINE);
print("------------>ATT_SendMachineCommand_Start---------->"..tostring(ATT_SendMachineCommand_Start));
Sleep(2000);
local ATT_SendMachineCommand_Stop = attManager:SendMachineCommand(MachineSpec, QS_STOP_MACHINE);
print("------------>ATT_SendMachineCommand_Stop----------->"..tostring(ATT_SendMachineCommand_Stop));
Sleep(2000);
local ATT_SendMachineCommand_Pause = attManager:SendMachineCommand(MachineSpec, QS_PAUSE_MACHINE);
print("------------>ATT_SendMachineCommand_Pause----------->"..tostring(ATT_SendMachineCommand_Pause));


local ATT_GetDefaultSpecNames = attManager:GetDefaultSpecNames(productPath, QS_MACHINE_TYPE_MQ);
--local ATT_GetDefaultSpecNames = attManager:GetDefaultSpecNames(productPath, QS_MACHINE_TYPE_TOM);
--local ATT_GetDefaultSpecNames = attManager:GetDefaultSpecNames(productPath, QS_MACHINE_TYPE_AOM);
if ATT_GetDefaultSpecNames ~= nil then
	for k, v in pairs(ATT_GetDefaultSpecNames) do
		print("----------->ATT_GetDefaultSpecName:k ------------>"..tostring(k));
		print("----------->ATT_GetDefaultSpecName:v ------------>"..tostring(v));
	end
else
	print("---------->ATT_GetDefaultSpecNames----------> nil");
end

end

function OnStop()
attManager:SubscribeAtt(MachineSpec, false, "att_update_message.lua"); 
--attManager:UnsubscribeAtt(MachineSpec, true, "att_update_message.lua"); 
--StopTimer(timer_Id);
end


function OnATTUpdateMessage(UpdateMessage, fromSnapshot)
	print("OnATTUpdateMessage")
	print("Get Calculate Active ->"..tostring(UpdateMessage:GetCalcActive()));
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
end

function OnATTUpdateMessageNotify(MachineSpec, fromSnapshot)
	print("---------------------------------->OnAttUpdateMessageNotify begin<------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
end 

function OnATTLimitUpdate(takeoutLimitBroadcast, fromSnapshot)
	print("---------------------------------->OnATTLimitUpdate<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
	
	print("------->OnATTLimitUpdate:GetCurrentContractLimit()------->"..tostring(takeoutLimitBroadcast:GetCurrentContractLimit()))
	print("------->OnATTLimitUpdate:GetGlobalContractLimit()------->"..tostring(takeoutLimitBroadcast:GetGlobalContractLimit()))
	print("------->OnATTLimitUpdate:GetCurrentDeltaLimit()------->"..tostring(takeoutLimitBroadcast:GetCurrentDeltaLimit()))
	print("------->OnATTLimitUpdate:GetPullOffset()------->"..tostring(takeoutLimitBroadcast:GetPullOffset()))
	print("------->OnATTLimitUpdate:GetMinHedgeVolume()------->"..tostring(takeoutLimitBroadcast:GetMinHedgeVolume()))
	print("------->OnATTLimitUpdate:GetMaxHedgeVolume()------->"..tostring(takeoutLimitBroadcast:GetMaxHedgeVolume()))
	print("------->OnATTLimitUpdate:GetUnderlyingRefNudge()------->"..tostring(takeoutLimitBroadcast:GetUnderlyingRefNudge()))
	print("------->OnATTLimitUpdate:GetGlobalDeltaLimit()------->"..tostring(takeoutLimitBroadcast:GetGlobalDeltaLimit()))
	
end



function OnATTLimitUpdateNotify(MachineSpec, fromSnapshot)
	print("---------------------------------->OnATTLimitUpdateNotify<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
end

function OnATTHeartbeat(takeoutKeepAliveNotification, fromSnapshot)
	print("---------------------------------->OnATTHeartbeat<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
	
	print("------------>OnATTHeartbeat:Command()---------->"..tostring(takeoutKeepAliveNotification:Command()))
	
	
end

function OnATTHeartbeatNotify(MachineSpec, fromSnapshot)
	print("---------------------------------->OnATTHeartbeatNotify<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
end

function OnATTRequest(takeoutSpec, fromSnapshot)
	print("---------------------------------->OnATTRequest<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
	
	print("--------->OnATTRequest:GetUser()-------->"..tostring(takeoutSpec:GetUser()))
	print("--------->OnATTRequest:GetUserGroup()-------->"..tostring(takeoutSpec:GetUserGroup()))
	print("--------->OnATTRequest:GetMachineType()-------->"..tostring(takeoutSpec:GetMachineType()))
	print("--------->OnATTRequest:GetTargetProduct()-------->"..tostring(takeoutSpec:GetTargetProduct()))
	print("--------->OnATTRequest:GetHedgeProduct()-------->"..tostring(takeoutSpec:GetHedgeProduct()))
	
end

function OnATTRequestNotify(specName, fromSnapshot)
	print("---------------------------------->OnATTRequestNotify<-------------------------------")
	if fromSnapshot == true then
		print("-------------fromSnapshot = true ------------")
	else
		print("-------------fromSnapshot = false ------------")
	end
end

