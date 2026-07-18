--[[
	DOOR SYSTEM
	Sistema de puertas inteligentes con escaneo de tarjetas
	Cada puerta tiene un nivel de seguridad y solo se abre si tienes acceso
]]

local DoorSystem = {}
DoorSystem.__index = DoorSystem

-- Crear una nueva puerta
function DoorSystem.new(doorID, name, location, requiredAccessLevel)
	local self = setmetatable({}, DoorSystem)
	
	self.DoorID = doorID
	self.Name = name
	self.Location = location
	self.RequiredAccessLevel = requiredAccessLevel or 0
	self.IsOpen = false
	self.IsLocked = true
	self.AccessLog = {}
	self.LastOpened = nil
	self.AutoCloseTime = 10 -- Segundos antes de cerrar automáticamente
	
	return self
end

-- Intentar abrir puerta con tarjeta
function DoorSystem:TryOpen(accessCard)
	local hasAccess, message = accessCard:HasAccessToLevel(self.RequiredAccessLevel)
	
	if hasAccess then
		self:Open(accessCard.PlayerName)
		accessCard:LogScan(self.Location, true)
		return true, "🟢 Puerta abierta - Bienvenido " .. accessCard.PlayerName
	else
		accessCard:LogScan(self.Location, false)
		return false, "🔴 ACCESO DENEGADO - " .. message
	end
end

-- Abrir puerta
function DoorSystem:Open(playerName)
	self.IsOpen = true
	self.IsLocked = false
	self.LastOpened = os.time()
	table.insert(self.AccessLog, {
		Player = playerName,
		Action = "OPENED",
		Timestamp = os.time()
	})
	print("[AADI] Puerta " .. self.Name .. " abierta por " .. playerName)
end

-- Cerrar puerta
function DoorSystem:Close()
	self.IsOpen = false
	self.IsLocked = true
	table.insert(self.AccessLog, {
		Action = "CLOSED",
		Timestamp = os.time()
	})
	print("[AADI] Puerta " .. self.Name .. " cerrada")
end

-- Bloquear puerta (emergencia)
function DoorSystem:LockDown()
	self.IsOpen = false
	self.IsLocked = true
	table.insert(self.AccessLog, {
		Action = "LOCKDOWN",
		Timestamp = os.time()
	})
	print("[AADI] BLOQUEO DE EMERGENCIA - Puerta " .. self.Name)
end

-- Obtener estado de la puerta
function DoorSystem:GetStatus()
	return {
		DoorID = self.DoorID,
		Name = self.Name,
		Location = self.Location,
		IsOpen = self.IsOpen,
		IsLocked = self.IsLocked,
		RequiredAccessLevel = self.RequiredAccessLevel,
		LastOpened = self.LastOpened,
	}
end

-- Obtener registro de acceso
function DoorSystem:GetAccessLog()
	return self.AccessLog
end

-- Limpiar registro (solo para administradores)
function DoorSystem:ClearAccessLog()
	self.AccessLog = {}
	print("[AADI] Registro de acceso borrado para puerta: " .. self.Name)
end

-- Sistema de puertas múltiples
local DoorNetwork = {}

function DoorNetwork:CreateDoor(doorID, name, location, accessLevel)
	local door = DoorSystem.new(doorID, name, location, accessLevel)
	self[doorID] = door
	return door
end

function DoorNetwork:GetDoor(doorID)
	return self[doorID]
end

function DoorNetwork:GetAllDoors()
	local allDoors = {}
	for _, door in pairs(self) do
		table.insert(allDoors, door)
	end
	return allDoors
end

function DoorNetwork:LockdownAll()
	print("[AADI] 🚨 BLOQUEO TOTAL DE EMERGENCIA 🚨")
	for _, door in pairs(self) do
		door:LockDown()
	end
end

function DoorNetwork:UnlockAll()
	print("[AADI] ✅ Todas las puertas desbloqueadas")
	for _, door in pairs(self) do
		door:Open("System")
	end
end

-- Crear puertas predeterminadas de AADI
function DoorNetwork:InitializeAADI()
	-- AADI-000: Entrada
	self:CreateDoor("DOOR-000-A", "Entrada Principal", "SCP-AADI-000", 0)
	self:CreateDoor("DOOR-000-B", "Seguridad", "SCP-AADI-000", 1)
	
	-- AADI-100: Oficinas
	self:CreateDoor("DOOR-100-A", "Oficinas Generales", "SCP-AADI-100", 1)
	self:CreateDoor("DOOR-100-B", "Despacho del Director", "SCP-AADI-100", 4)
	self:CreateDoor("DOOR-100-C", "Sala de Conferencias", "SCP-AADI-100", 2)
	
	-- AADI-200: Armamento
	self:CreateDoor("DOOR-200-A", "Tienda de Armas", "SCP-AADI-200", 2)
	self:CreateDoor("DOOR-200-B", "Bóveda de Armamento Pesado", "SCP-AADI-200", 3)
	self:CreateDoor("DOOR-200-C", "Armería Segura", "SCP-AADI-200", 2)
	
	-- AADI-300: Laboratorios
	self:CreateDoor("DOOR-300-A", "Laboratorio Principal", "SCP-AADI-300", 2)
	self:CreateDoor("DOOR-300-B", "Laboratorio Químico", "SCP-AADI-300", 3)
	self:CreateDoor("DOOR-300-C", "Laboratorio Biológico", "SCP-AADI-300", 3)
	self:CreateDoor("DOOR-300-D", "Sector Investigación Avanzada", "SCP-AADI-300", 4)
	
	-- AADI-400: Contención
	self:CreateDoor("DOOR-400-A", "Zona de Contención Nivel 1", "SCP-AADI-400", 3)
	self:CreateDoor("DOOR-400-B", "Zona de Contención Nivel 2", "SCP-AADI-400", 4)
	self:CreateDoor("DOOR-400-C", "Cámara de Contención Crítica", "SCP-AADI-400", 5)
	
	-- AADI-500: Abismo
	self:CreateDoor("DOOR-500-A", "Entrada al Abismo", "SCP-AADI-500", 5)
	
	print("[AADI] Red de puertas inicializada")
end

DoorSystem.DoorNetwork = DoorNetwork

return DoorSystem
