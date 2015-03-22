local stringToSplit = Util:LoadVarString( "stringToSplit" );
local delimetor = Util:LoadVarString( "delimetor" );
vec = Util:StringSplit( stringToSplit, delimetor );
if vec == nil then
print("The returned table is empty");
else
print("Elements number in table = "..#vec);
for i, v in pairs(vec) do
print("vec"..tostring(i).."="..v);
end
end


function OnStart()

end

function OnStop()

end
