if World.isClient then
require "script_client.main"
else
require "script_server.main_server"
end
require "script_common.main"

