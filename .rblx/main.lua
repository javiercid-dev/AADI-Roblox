--[[
	MAIN AADI SYSTEM
	Script principal que integra todos los sistemas de AADI
	Ejecuta este script primero en ServerScriptService
]]

-- Importar todos los módulos
local AnomaliesDatabase = require(script.Parent:WaitForChild("AnomaliesDatabase"))
local AccessCardSystem = require(script.Parent:WaitForChild("AccessCardSystem"))
local DoorSystem = require(script.Parent:WaitForChild("DoorSystem"))
local WeaponShop = require(script.Parent:WaitForChild("WeaponShop"))
local EmployeeSystem = require(script.Parent:WaitForChild("EmployeeSystem"))
local UnlockSystem = require(script.Parent:WaitForChild("UnlockSystem"))
local NPCDialogues = require(script.Parent:WaitForChild("NPCDialogues"))

-- AADI Sistema Principal
local AADISystem = {}

-- Inicializar todo
function AADISystem:Initialize()
	print("\n" .. string.rep("=", 60))
	print("🔐 AADI - ADVANCED ANOMALY DEVELOPMENT INSTITUTE 🔐")
	print("Sistema de seguridad iniciando...")
	print(string.rep("=", 60) .. "\n")
	
	-- Inicializar bases de datos
	AnomaliesDatabase:Initialize()
	local doorNetwork = DoorSystem.DoorNetwork
	doorNetwork:InitializeAADI()
	
	local npcDB = NPCDialogues.NPCDatabase
	npcDB:InitializeAADINPCs()
	
	print("[✅] Base de datos de anomalías cargada")
	print("[✅] Red de puertas inteligentes activada")
	print("[✅] NPCs de AADI en línea")
	print("[✅] Sistema listo para operaciones\n")
	
	-- Estadísticas
	local stats = AnomaliesDatabase:GetStats()
	print("📊 ESTADÍSTICAS DEL SISTEMA:")
	print("   • Total de anomalías: " .. stats.Total)
	print("   • Nivel 0 (Iniciado): " .. stats.Level0 .. " anomalías")
	print("   • Nivel 1 (Explorando): " .. stats.Level1 .. " anomalías")
	print("   • Nivel 2 (Investigando): " .. stats.Level2 .. " anomalías")
	print("   • Nivel 3 (Profundizando): " .. stats.Level3 .. " anomalías")
	print("   • Nivel 4 (Peligroso): " .. stats.Level4 .. " anomalías")
	print("   • Nivel 5 (Abismo): " .. stats.Level5 .. " anomalías\n")
	
	-- Tienda
	local shopStats = WeaponShop.Shop:GetStats()
	print("🛒 TIENDA DE ARMAS:")
	print("   • Total de artículos: " .. shopStats.TotalItems)
	print("   • Categorías: " .. table.concat(shopStats.Categories, ", "))
	print("   • Precio promedio: " .. math.floor(shopStats.AveragePrice) .. " A-Credits")
	print("   • Artículo más caro: " .. shopStats.MostExpensive .. " (" .. shopStats.MostExpensivePrice .. " A-Credits)\n")
	
	print(string.rep("=", 60))
	print("✅ AADI COMPLETAMENTE OPERATIVO")
	print(string.rep("=", 60) .. "\n")
end

-- Crear un jugador nuevo con tarjeta de acceso
function AADISystem:RegisterNewPlayer(playerName, role, accessLevel)
	-- Crear tarjeta de acceso
	local card = AccessCardSystem.new(playerName, accessLevel, role)
	AccessCardSystem.CardStorage:SaveCard(card)
	
	-- Crear empleado
	local employee = EmployeeSystem.EmployeeDatabase:HireEmployee(playerName, role, accessLevel)
	
	-- Crear progreso de desbloqueo
	local unlock = UnlockSystem.UnlockDatabase:CreatePlayer(playerName)
	
	print("[AADI] Nuevo jugador registrado: " .. playerName)
	print("   • Rol: " .. role)
	print("   • Nivel de acceso: " .. accessLevel)
	print("   • Tarjeta ID: " .. card.CardID)
	
	return {
		Card = card,
		Employee = employee,
		UnlockProgress = unlock,
	}
end

-- Simular entrada del jugador a una puerta
function AADISystem:AttemptDoorAccess(playerName, doorID)
	local card = AccessCardSystem.CardStorage:GetCard(playerName) or nil
	
	if not card then
		-- Buscar tarjeta por nombre de jugador
		local allCards = AccessCardSystem.CardStorage:GetAllCards()
		for _, c in ipairs(allCards) do
			if c.PlayerName == playerName then
				card = c
				break
			end
		end
	end
	
	if not card then
		return false, "❌ Tarjeta no encontrada"
	end
	
	local door = DoorSystem.DoorNetwork:GetDoor(doorID)
	if not door then
		return false, "❌ Puerta no encontrada"
	end
	
	local success, message = door:TryOpen(card)
	return success, message
end

-- Completar estudio de anomalía
function AADISystem:StudyAnomaly(playerName, anomalyID, studyTime)
	local player = UnlockSystem.UnlockDatabase:GetPlayer(playerName)
	local success, message = player:StudyAnomaly(anomalyID, studyTime)
	
	if success then
		local progress = player:GetProgress()
		print("[AADI] " .. playerName .. ": " .. message)
		print("   • Progreso: " .. progress.ProgressPercentage .. "% (" .. progress.ProgressPoints .. "/" .. progress.RequiredPoints .. ")")
		print("   • Nivel: " .. progress.CurrentLevel)
	end
	
	return success, message
end

-- Comprar arma en la tienda
function AADISystem:BuyWeapon(playerName, itemID, playerCredits)
	local cart = WeaponShop.Shop:CreateCart(playerName)
	local success, message = cart:AddItem(itemID, 1)
	
	if not success then
		return false, message
	end
	
	local paymentSuccess, paymentMsg, receipt = WeaponShop.Shop:ProcessPayment(playerName, cart, playerCredits)
	
	return paymentSuccess, paymentMsg, receipt
end

-- Obtener información de jugador
function AADISystem:GetPlayerInfo(playerName)
	local card = nil
	local allCards = AccessCardSystem.CardStorage:GetAllCards()
	for _, c in ipairs(allCards) do
		if c.PlayerName == playerName then
			card = c
			break
		end
	end
	
	local employee = EmployeeSystem.EmployeeDatabase:GetEmployee(playerName)
	local unlock = UnlockSystem.UnlockDatabase:GetPlayer(playerName)
	
	if not card or not employee or not unlock then
		return nil, "Jugador no encontrado"
	end
	
	return {
		Card = card:GetCardInfo(),
		Employee = employee:GetInfo(),
		Progress = unlock:GetProgress(),
	}
end

-- Generar reporte de seguridad
function AADISystem:GenerateSecurityReport()
	local report = {
		Timestamp = os.time(),
		TotalEmployees = #EmployeeSystem.EmployeeDatabase:GetAllEmployees(),
		TotalCards = #AccessCardSystem.CardStorage:GetAllCards(),
		TotalDoors = #DoorSystem.DoorNetwork:GetAllDoors(),
		TotalPlayers = UnlockSystem.UnlockDatabase:GetGlobalStats().TotalPlayers,
		EmployeeStats = EmployeeSystem.EmployeeDatabase:GetStats(),
		GlobalStats = UnlockSystem.UnlockDatabase:GetGlobalStats(),
	}
	
	return report
end

-- Activar modo emergencia (bloquear todo)
function AADISystem:EmergencyLockdown()
	print("\n🚨 🚨 🚨 EMERGENCIA - BLOQUEO TOTAL 🚨 🚨 🚨\n")
	DoorSystem.DoorNetwork:LockdownAll()
	
	local allNPCs = NPCDialogues.NPCDatabase:GetAllNPCs()
	for _, npc in ipairs(allNPCs) do
		if npc.Role == "Guard" or npc.Role == "Executive" then
			print("[" .. npc.Name .. "]: ¡LOCKDOWN ACTIVADO! TODOS A POSICIONES DEFENSIVAS")
		end
	end
	
	print("\n" .. string.rep("█", 60))
	print("PROTOCOLO DE EMERGENCIA ACTIVADO")
	print(string.rep("█", 60) .. "\n")
end

-- Ejemplo de uso
function AADISystem:RunDemo()
	print("\n\n📝 DEMOSTRANDO SISTEMA AADI...\n")
	
	-- Registrar jugador
	print("1️⃣  REGISTRANDO NUEVO JUGADOR...")
	self:RegisterNewPlayer("Juan_Guardia", "Guard", 3)
	
	-- Intentar acceso a puerta
	print("\n2️⃣  INTENTANDO ACCESO A PUERTA...")
	local success, message = self:AttemptDoorAccess("Juan_Guardia", "DOOR-200-A")
	print("Resultado: " .. message)
	
	-- Estudiar anomalía
	print("\n3️⃣  ESTUDIANDO ANOMALÍA...")
	self:StudyAnomaly("Juan_Guardia", 1, 15)
	
	-- Obtener información
	print("\n4️⃣  OBTENIENDO INFORMACIÓN DEL JUGADOR...")
	local info = self:GetPlayerInfo("Juan_Guardia")
	if info then
		print("✅ Jugador encontrado")
		print("   • Tarjeta ID: " .. info.Card.CardID)
		print("   • Rol: " .. info.Employee.Role)
		print("   • Nivel actual: " .. info.Progress.CurrentLevel)
	end
	
	print("\n" .. string.rep("=", 60))
	print("✅ DEMOSTRACIÓN COMPLETADA")
	print(string.rep("=", 60) .. "\n")
end

-- Inicializar sistema
AADISystem:Initialize()

-- Exportar sistema
return AADISystem
