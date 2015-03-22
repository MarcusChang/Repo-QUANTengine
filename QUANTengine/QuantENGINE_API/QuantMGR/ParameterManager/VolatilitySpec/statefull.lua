require "VolatilitySpec"
--changeSpec = true;
function OnVolatilitySpec(spec, fromSnapshot)

	if fromSnapshot == true then
		print("----------fromSnapshot = true--------")
	else
		print("----------fromSnapshot = false-------")
	end
 
    print("OnVolatilitySpec");
    --print key in spec
    print("key="..spec:GetKey());

	DisplaySpec(spec);
    
    --spec:ClearAllVolatilities();
end

