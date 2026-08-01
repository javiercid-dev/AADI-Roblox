--[[
	MISSION SYSTEM - SISTEMA DE MISIONES
	Módulo para crear misiones relacionadas con AADI
	Las misiones giran alrededor de contener anomalías y ascender en rango
]]

local MissionSystem = {}
MissionSystem.__index = MissionSystem

-- Tipos de misiones
local MISSION_TYPES = {
	INVESTIGATE = "Investigación",
	CONTAIN = "Contención",
	RESEARCH = "Investigación profunda",
	ESCORT = "Escolta",
	DEFENSE = "Defensa",
	EXPLORATION = "Exploración",
	RETRIEVAL = "Recuperación",
}

-- Estados de misión
local MISSION_STATES = {
	AVAILABLE = "Disponible",
	ACTIVE = "Activa",
	COMPLETED = "Completada",
	FAILED = "Fracasada",
	ABANDONED = "Abandonada",
}

-- Crear una misión
local function CreateMission(missionID, title, description, type, difficulty, reward, objectiveType, targetAnomaly)
	return {
		MissionID = missionID,
		Title = title,
		Description = description,
		Type = type,
		Difficulty = difficulty, -- Easy, Normal, Hard, Extreme
		Reward = reward, -- A-Credits y puntos
		ObjectiveType = objectiveType,
		TargetAnomaly = targetAnomaly,
		State = MISSION_STATES.AVAILABLE,
		Progress = 0,
		MaxProgress = 100,
		CreatedAt = os.time(),
		StartedAt = nil,
		CompletedAt = nil,
		AssignedTo = nil,
		TimeLimit = 3600, -- 1 hora en segundos
	}
end

-- Base de datos de misiones
MissionSystem.MissionDatabase = {
	-- MISIONES DE NIVEL 0 (Iniciales)
	CreateMission(
		1, 
		"Bienvenida a AADI",
		"Tu primer día en AADI. Familiarízate con el complejo y recibe entrenamiento básico.",
		MISSION_TYPES.EXPLORATION,
		"Easy",
		{Credits = 250, Points = 50},
		"Explorar sectores",
		0
	),
	
	CreateMission(
		2,
		"Estudio de AADI-001",
		"Investigar y documentar los datos de la anomalía AADI-001 (Esfera Magnética).",
		MISSION_TYPES.INVESTIGATE,
		"Easy",
		{Credits = 500, Points = 100},
		"Estudiar anomalía",
		1
	),
	
	CreateMission(
		3,
		"Verificación de puertas",
		"Verificar que todos los sistemas de puertas funcionan correctamente en el Sector 200.",
		MISSION_TYPES.DEFENSE,
		"Easy",
		{Credits = 300, Points = 60},
		"Revisar sistemas",
		0
	),
	
	-- MISIONES DE NIVEL 1 (Investigación)
	CreateMission(
		10,
		"Anomalía peligrosa",
		"Se ha detectado un aumento en la actividad de AADI-007. Investiga la causa.",
		MISSION_TYPES.INVESTIGATE,
		"Normal",
		{Credits = 1000, Points = 200},
		"Investigar anomalía",
		7
	),
	
	CreateMission(
		11,
		"Contención de emergencia",
		"Una anomalía ha mostrado signos de brote. Ayuda a contenerla antes de que se propague.",
		MISSION_TYPES.CONTAIN,
		"Hard",
		{Credits = 2000, Points = 400},
		"Contener anomalía",
		15
	),
	
	CreateMission(
		12,
		"Escolta de científicos",
		"Acompaña y protege a un equipo de científicos durante la investigación de AADI-050.",
		MISSION_TYPES.ESCORT,
		"Normal",
		{Credits = 800, Points = 150},
		"Escoltar equipo",
		50
	),
	
	-- MISIONES DE NIVEL 2 (Avanzadas)
	CreateMission(
		20,
		"Investigación profunda",
		"Realizar un estudio exhaustivo de AADI-203. Muy peligroso. Requiere protección.",
		MISSION_TYPES.RESEARCH,
		"Hard",
		{Credits = 3000, Points = 600},
		"Investigación profunda",
		203
	),
	
	CreateMission(
		21,
		"Defensa del complejo",
		"Se ha detectado una brecha en la contención. Defiende el complejo de la propagación.",
		MISSION_TYPES.DEFENSE,
		"Extreme",
		{Credits = 5000, Points = 1000},
		"Defender",
		0
	),
	
	CreateMission(
		22,
		"Recuperación de datos",
		"Recupera información crítica del Sector 300 antes de que la anomalía lo destruya.",
		MISSION_TYPES.RETRIEVAL,
		"Hard",
		{Credits = 2500, Points = 500},
		"Recuperar datos",
		300
	),
	
	-- MISIONES DE NIVEL 3 (Críticas)
	CreateMission(
		30,
		"Amenaza extrema",
		"AADI-309 está activo. Se requiere personal de élite para investigar.",
		MISSION_TYPES.INVESTIGATE,
		"Extreme",
		{Credits = 7500, Points = 1500},
		"Investigar amenaza",
		309
	),
	
	CreateMission(
		31,
		"Contención de AADI-300",
		"La Consciencia Colectiva intenta expandirse. Contención CRÍTICA necesaria.",
		MISSION_TYPES.CONTAIN,
		"Extreme",
		{Credits = 10000, Points = 2000},
		"Contención crítica",
		300
	),
}

-- Sistema de jugador en misiones
function MissionSystem:CreatePlayerMissions(playerName)
	return {
		PlayerName = playerName,
		ActiveMissions = {},
		CompletedMissions = {},
		FailedMissions = {},
		TotalRewards = {Credits = 0, Points = 0},
	}
end

-- Asignar misión a jugador
function MissionSystem:AssignMission(playerData, missionID)
	local mission = self.MissionDatabase[missionID]
	
	if not mission then
		return false, "Misión no encontrada"
	end
	
	if mission.State ~= MISSION_STATES.AVAILABLE then
		return false, "Misión no disponible"
	end
	
	mission.State = MISSION_STATES.ACTIVE
	mission.AssignedTo = playerData.PlayerName
	mission.StartedAt = os.time()
	
	table.insert(playerData.ActiveMissions, mission)
	
	return true, "✅ Misión asignada: " .. mission.Title
end

-- Avanzar progreso de misión
function MissionSystem:ProgressMission(playerData, missionIndex, amount)
	local mission = playerData.ActiveMissions[missionIndex]
	
	if not mission then
		return false, "Misión no activa"
	end
	
	mission.Progress = math.min(mission.MaxProgress, mission.Progress + amount)
	
	if mission.Progress >= mission.MaxProgress then
		return self:CompleteMission(playerData, missionIndex)
	end
	
	return true, "📊 Progreso: " .. mission.Progress .. "/" .. mission.MaxProgress
end

-- Completar misión
function MissionSystem:CompleteMission(playerData, missionIndex)
	local mission = playerData.ActiveMissions[missionIndex]
	
	if not mission then
		return false, "Misión no encontrada"
	end
	
	mission.State = MISSION_STATES.COMPLETED
	mission.CompletedAt = os.time()
	mission.Progress = mission.MaxProgress
	
	-- Aplicar recompensas
	playerData.TotalRewards.Credits = playerData.TotalRewards.Credits + mission.Reward.Credits
	playerData.TotalRewards.Points = playerData.TotalRewards.Points + mission.Reward.Points
	
	table.insert(playerData.CompletedMissions, mission)
	table.remove(playerData.ActiveMissions, missionIndex)
	
	return true, 
		"🎉 ¡MISIÓN COMPLETADA! " .. mission.Title .. "\n" ..
		"📦 Recompensa: " .. mission.Reward.Credits .. " A-Credits + " .. mission.Reward.Points .. " Puntos"
end

-- Fallar misión
function MissionSystem:FailMission(playerData, missionIndex, reason)
	local mission = playerData.ActiveMissions[missionIndex]
	
	if not mission then
		return false, "Misión no encontrada"
	end
	
	mission.State = MISSION_STATES.FAILED
	mission.FailReason = reason
	
	table.insert(playerData.FailedMissions, mission)
	table.remove(playerData.ActiveMissions, missionIndex)
	
	return true, 
		"❌ MISIÓN FRACASADA: " .. mission.Title .. "\n" ..
		"Razón: " .. reason
end

-- Obtener misiones disponibles por dificultad
function MissionSystem:GetMissionsByDifficulty(difficulty)
	local missions = {}
	for _, mission in ipairs(self.MissionDatabase) do
		if mission.Difficulty == difficulty and mission.State == MISSION_STATES.AVAILABLE then
			table.insert(missions, mission)
		end
	end
	return missions
end

-- Obtener información de misión
function MissionSystem:GetMissionInfo(missionID)
	return self.MissionDatabase[missionID]
end

-- Listar todas las misiones disponibles
function MissionSystem:ListAllMissions()
	local available = {}
	for id, mission in ipairs(self.MissionDatabase) do
		if mission.State == MISSION_STATES.AVAILABLE then
			table.insert(available, {
				ID = id,
				Title = mission.Title,
				Difficulty = mission.Difficulty,
				Reward = mission.Reward.Credits,
			})
		end
	end
	return available
end

-- Estadísticas del jugador en misiones
function MissionSystem:GetPlayerStats(playerData)
	return {
		PlayerName = playerData.PlayerName,
		ActiveMissions = #playerData.ActiveMissions,
		CompletedMissions = #playerData.CompletedMissions,
		FailedMissions = #playerData.FailedMissions,
		TotalCreditsEarned = playerData.TotalRewards.Credits,
		TotalPointsEarned = playerData.TotalRewards.Points,
		SuccessRate = #playerData.CompletedMissions > 0 and 
			math.floor((#playerData.CompletedMissions / (#playerData.CompletedMissions + #playerData.FailedMissions)) * 100) or 0,
	}
end

return MissionSystem
