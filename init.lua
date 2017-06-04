--[[
	Mod AntiPVP para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Carpete Anti PVP
  ]]

-- Raio (em blocos) de alcance do Carpete AntPVP
local RAIO_ANTPVP = tonumber(minetest.setting_get("antipvp_dist") or 25)

-- Carpete AntPVP
minetest.register_node("antipvp:placa", {
	description = "Placa Anti PVP",
	tiles = {"default_sign_wall_wood.png^antipvp_placa.png"},
	inventory_image = "default_sign_wood.png^antipvp_placa.png",
	wield_image = "default_sign_wood.png^antipvp_placa.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {oddly_breakable_by_hand=3},
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
		wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
		wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
	},
})

minetest.register_on_punchplayer(function(player, hitter)
	if minetest.find_node_near(player:getpos(), RAIO_ANTPVP, "antipvp:placa") then
		if hitter then 
			if hitter:is_player() then
				minetest.chat_send_player(hitter:get_player_name(),"Area Anti PVP. Proibido atacar jogadores nesse local.")
			else
				hitter:remove()
			end
			return true
		end
	end
end)

