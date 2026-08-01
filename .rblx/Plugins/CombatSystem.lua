--[[
	COMBAT SYSTEM - SISTEMA DE COMBATE
	Módulo para añadir combate a AADI
	Gestiona daño, armas, combate PvP y PvE
]]

local CombatSystem = {}
CombatSystem.__index = CombatSystem

-- Crear combatiente
function CombatSystem.new(playerName, maxHealth, baseDamage)
	local self = setmetatable({}, CombatSystem)
	
	self.PlayerName = playerName
	self.MaxHealth = maxHealth or 100
	self.CurrentHealth = maxHealth or 100
	self.BaseDamage = baseDamage or 25
	self.Armor = 0 -- Porcentaje de reducción de daño
	self.IsInCombat = false
	self.LastDamageTakenFrom = nil
	self.CombatLog = {}
	self.Kills = 0
	self.Deaths = 0
	self.LastCombatTime = nil
	
	return self
end

-- Equip arma
function CombatSystem:EquipWeapon(weaponID, weaponDamage, weaponName)
	self.CurrentWeapon = {
		ID = weaponID,
		Damage = weaponDamage,
		Name = weaponName,
		Ammo = 999, -- Munición infinita para Roblox
	}
	return "🔫 Arma equipada: " .. weaponName .. " (Daño: " .. weaponDamage .. ")"
end

-- Calcular daño con armadura
function CombatSystem:CalculateDamage(incomingDamage)
	local armorReduction = (self.Armor / 100) * incomingDamage
	local finalDamage = incomingDamage - armorReduction
	return math.floor(finalDamage)
end

-- Recibir daño
function CombatSystem:TakeDamage(attacker, damage)
	self.IsInCombat = true
	self.LastDamageTakenFrom = attacker
	self.LastCombatTime = os.time()
	
	local finalDamage = self:CalculateDamage(damage)
	self.CurrentHealth = math.max(0, self.CurrentHealth - finalDamage)
	
	table.insert(self.CombatLog, {
		Event = "Daño recibido",
		From = attacker,
		Damage = finalDamage,
		HealthRemaining = self.CurrentHealth,
		Timestamp = os.time()
	})
	
	if self.CurrentHealth <= 0 then
		return "💀 " .. self.PlayerName .. " ha muerto"
	else
		return "🔴 " .. self.PlayerName .. " recibió " .. finalDamage .. " de daño. Salud: " .. self.CurrentHealth .. "/" .. self.MaxHealth
	end
end

-- Atacar a otro jugador
function CombatSystem:Attack(target, isCritical)
	if not self.CurrentWeapon then
		return false, "❌ No tienes arma equipada"
	end
	
	self.IsInCombat = true
	local baseDamage = self.CurrentWeapon.Damage
	
	-- Golpe crítico
	if isCritical then
		baseDamage = baseDamage * 1.5
	end
	
	local result = target:TakeDamage(self.PlayerName, baseDamage)
	
	table.insert(self.CombatLog, {
		Event = "Ataque realizado",
		Target = target.PlayerName,
		Damage = baseDamage,
		IsCritical = isCritical,
		Timestamp = os.time()
	})
	
	-- Verificar muerte
	if target.CurrentHealth <= 0 then
		self.Kills = self.Kills + 1
		target.Deaths = target.Deaths + 1
		return true, "⚔️ ¡ELIMINADO! " .. target.PlayerName .. " fue derrotado por " .. self.PlayerName
	end
	
	return true, "⚔️ " .. self.PlayerName .. " atacó a " .. target.PlayerName .. " por " .. baseDamage .. " de daño"
end

-- Equipar armadura
function CombatSystem:EquipArmor(armorValue, armorName)
	self.Armor = armorValue
	self.ArmorName = armorName
	return "🛡️ Armadura equipada: " .. armorName .. " (" .. armorValue .. "% reducción)"
end

-- Curar
function CombatSystem:Heal(amount)
	local oldHealth = self.CurrentHealth
	self.CurrentHealth = math.min(self.MaxHealth, self.CurrentHealth + amount)
	
	table.insert(self.CombatLog, {
		Event = "Curación",
		AmountHealed = self.CurrentHealth - oldHealth,
		HealthAfter = self.CurrentHealth,
		Timestamp = os.time()
	})
	
	return "❤️ Curación aplicada. Salud: " .. self.CurrentHealth .. "/" .. self.MaxHealth
end

-- Obtener estadísticas de combate
function CombatSystem:GetCombatStats()
	return {
		PlayerName = self.PlayerName,
		Health = self.CurrentHealth,
		MaxHealth = self.MaxHealth,
		Armor = self.Armor,
		CurrentWeapon = self.CurrentWeapon,
		IsInCombat = self.IsInCombat,
		Kills = self.Kills,
		Deaths = self.Deaths,
		KDRatio = self.Deaths > 0 and (self.Kills / self.Deaths) or self.Kills,
		CombatLogEntries = #self.CombatLog,
	}
end

-- Terminar combate
function CombatSystem:EndCombat()
	self.IsInCombat = false
	print("[COMBAT] Combate finalizado para " .. self.PlayerName)
end

-- Base de datos de combatientes
local CombatDatabase = {}

function CombatDatabase:RegisterCombatant(playerName, maxHealth, baseDamage)
	local combatant = CombatSystem.new(playerName, maxHealth, baseDamage)
	self[playerName] = combatant
	return combatant
end

function CombatDatabase:GetCombatant(playerName)
	return self[playerName]
end

function CombatDatabase:SimulateBattle(player1Name, player2Name)
	local p1 = self:GetCombatant(player1Name)
	local p2 = self:GetCombatant(player2Name)
	
	if not p1 or not p2 then
		return false, "❌ Uno o ambos jugadores no encontrados"
	end
	
	print("\n⚔️ COMBATE INICIADO: " .. player1Name .. " vs " .. player2Name)
	
	local round = 1
	while p1.CurrentHealth > 0 and p2.CurrentHealth > 0 and round <= 100 do
		-- Jugador 1 ataca
		local critical1 = math.random(1, 10) <= 2 -- 20% crítico
		p1:Attack(p2, critical1)
		
		if p2.CurrentHealth <= 0 then break end
		
		-- Jugador 2 ataca
		local critical2 = math.random(1, 10) <= 2 -- 20% crítico
		p2:Attack(p1, critical2)
		
		round = round + 1
	end
	
	if p1.CurrentHealth > 0 then
		print("✅ GANADOR: " .. player1Name .. " (Salud: " .. p1.CurrentHealth .. ")")
		return player1Name, p1.CurrentHealth
	else
		print("✅ GANADOR: " .. player2Name .. " (Salud: " .. p2.CurrentHealth .. ")")
		return player2Name, p2.CurrentHealth
	end
end

CombatSystem.CombatDatabase = CombatDatabase

return CombatSystem
