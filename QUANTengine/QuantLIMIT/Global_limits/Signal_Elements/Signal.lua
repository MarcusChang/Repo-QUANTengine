--[[

Signal.lua: main script file.

This script is used to test the siganl in QuantENGINE. This examlpe will show you
how to send sgnaling message from one group, and deal with them on the Callback.

Before showing the examlpe, we should understand what is signal. Signal is one message
package, which is used to pass the string/double data between different QuantENGINEView
instance and EA. For the QuantENGINE, there is not essential diffence between Signal and
NamedEvent( have the same conception such as stateless/stateful  ). They are just coming
from diffenet source: Siganle from network( clientAPI ) and NamedEvent from lua script of QuantENGINE.

The below case show how to deal with the stateful signal string message.

--]]


-- Get the instance of nameEventCache, which is the entry of using Siganl or NamedEvent
local nameEventCache = QuquantCore():NamedEventManager();
local iCount = 0;
local strings;


function OnStart()

	--Turn on the Signal listening on the Group "signalingCase01" of NamedEvent.
	nameEventCache:EnableSignaling(true);

	--Subscribe one listener on the Group "signalingCase01" of NamedEvent and point out( Stateful )
	--the Callback script file.
	nameEventCache:AddListener( "signalingCase01", "key01", "",true, "Callback.lua");
    --nameEventCache:AddListener( "signalingCase01", "key02", "",true, "Callback.lua");

	--Create one empty version string signal: One package for one string map such as < string( key ), string( value ) >.

	--strings = { String01_Key = "String01_Var", String02_Key = "String02_Va", String03_Key = "String03_Va", String04_Key = "String04_Va", String05_Key = "String05_Va"  };
     strings = { String01_Key = "String01_Var", String02_Key = "String02_Va",String03_Key = "String03_Va",String04_Key = "String04_Va"}
	
	--init the empty string signal with one lua string table.
	--signalStrings:SetStringMap( strings );

	Timer( 200, 5000, "Signal.lua" );
end

--Callback fucntion for the timer is tiggered
function OnTimer( id )
	if( id == 200 ) then
		if( iCount ~= 10 ) then
			--Send one string signal to named group "signalingCase01"
			nameEventCache:SendSignal( "signalingCase01", "key01",   RS_STRING_SIGNAL,  strings );
			iCount = iCount + 1;
		end
	end
end


function OnStop()
    --Turn off the Signal listening on the Group "signalingCase01"
	nameEventCache:EnableSignaling( false );

	--Unsubscribe the listener on the Group "signalingCase01" ( Stateful )
	nameEventCache:RemoveListener( "signalingCase01", "key01","", true, "Callback.lua");

	StopTimer( 200 );
end




