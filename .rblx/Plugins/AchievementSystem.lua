--[[
	ACHIEVEMENT SYSTEM - SISTEMA DE LOGROS
	Módulo para crear logros y recompensas en AADI
	Los jugadores desbloquean logros al alcanzar objetivos
]]

local AchievementSystem = {}
AchievementSystem.__index = AchievementSystem

-- Categorías de logros
local ACHIEVEMENT_CATEGORIES = {
	RANK = "Rango",
	COMBAT = "Combate",
	RESEARCH = "Investigación",
	WEALTH = "Riqueza",
	EXPLORATION = "Exploración",
	SURVIVAL = "Supervivencia",
	LEADERSHIP = "Liderazgo",
	SECRET = "Secreto",
}

-- Crear logro
local function CreateAchievement(achievementID, name, description, category, points, requirement, reward)
	return {
		AchievementID = achievementID,
		Name = name,
		Description = description,
		Category = category,
		Points = points, -- Puntos de logro
		Requirement = requirement, -- Qué se necesita para obtenerlo
		Reward = reward or {Credits = 0, Points = 0, Title = ""},
		UnlockedBy = {},
		IconEmoji = "🏅",
	}
end

-- Base de datos de logros
AchievementSystem.AchievementDatabase = {
	-- LOGROS DE RANGO
	CreateAchievement(
		1,
		"Nuevo Recluta",
		"Completa tu primer día en AADI.",
		ACHIEVEMENT_CATEGORIES.RANK,
		10,
		"complete_tutorial",
		{Credits = 100, Points = 10, Title = "Recluta"}
	),
	
	CreateAchievement(
		2,
		"Personal de Seguridad",
		"Alcanza el rango de Guard.",
		ACHIEVEMENT_CATEGORIES.RANK,
		25,
		"rank_guard",
		{Credits = 500, Points = 25, Title = "Guardia"}
	),
	
	CreateAchievement(
		3,
		"Investigador Certificado",
		"Alcanza el rango de Scientist.",
		ACHIEVEMENT_CATEGORIES.RANK,
		25,
		"rank_scientist",
		{Credits = 500, Points = 25, Title = "Científico"}
	),
	
	CreateAchievement(
		4,
		"Personal Médico",
		"Alcanza el rango de Doctor.",
		ACHIEVEMENT_CATEGORIES.RANK,
		25,
		"rank_doctor",
		{Credits = 500, Points = 25, Title = "Médico"}
	),
	
	CreateAchievement(
		5,
		"Ejecutivo",
		"Alcanza el rango de Executive.",
		ACHIEVEMENT_CATEGORIES.RANK,
		50,
		"rank_executive",
		{Credits = 2000, Points = 50, Title = "Ejecutivo"}
	),
	
	CreateAchievement(
		6,
		"Director General",
		"Alcanza el rango máximo de Director.",
		ACHIEVEMENT_CATEGORIES.RANK,
		100,
		"rank_director",
		{Credits = 5000, Points = 100, Title = "Director"}
	),
	
	-- LOGROS DE COMBATE
	CreateAchievement(
		10,
		"Primera Sangre",
		"Derrota a tu primer enemigo en combate.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		15,
		"first_kill",
		{Credits = 250, Points = 15}
	),
	
	CreateAchievement(
		11,
		"Cazador de Anomalías",
		"Derrota 10 enemigos.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		30,
		"kills_10",
		{Credits = 500, Points = 30}
	),
	
	CreateAchievement(
		12,
		"Devastador",
		"Derrota 50 enemigos.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		75,
		"kills_50",
		{Credits = 2000, Points = 75}
	),
	
	CreateAchievement(
		13,
		"Maestro del Combate",
		"Derrota 100 enemigos.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		150,
		"kills_100",
		{Credits = 5000, Points = 150, Title = "Maestro"}
	),
	
	CreateAchievement(
		14,
		"Sobreviviente",
		"Surviveye a 5 combates críticos.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		50,
		"critical_combats_5",
		{Credits = 1000, Points = 50}
	),
	
	CreateAchievement(
		15,
		"Invencible",
		"Gana 10 combates consecutivos sin perder salud.",
		ACHIEVEMENT_CATEGORIES.COMBAT,
		100,
		"perfect_wins_10",
		{Credits = 3000, Points = 100, Title = "Invencible"}
	),
	
	-- LOGROS DE INVESTIGACIÓN
	CreateAchievement(
		20,
		"Primer Descubrimiento",
		"Estudia tu primera anomalía.",
		ACHIEVEMENT_CATEGORIES.RESEARCH,
		15,
		"study_anomaly_1",
		{Credits = 250, Points = 15}
	),
	
	CreateAchievement(
		21,
		"Investigador Dedicado",
		"Estudia 10 anomalías diferentes.",
		ACHIEVEMENT_CATEGORIES.RESEARCH,
		40,
		"study_anomalies_10",
		{Credits = 1000, Points = 40}
	),
	
	CreateAchievement(
		22,
		"Experto en Anomalías",
		"Estudia 50 anomalías diferentes.",
		ACHIEVEMENT_CATEGORIES.RESEARCH,
		100,
		"study_anomalies_50",
		{Credits = 3000, Points = 100, Title = "Experto"}
	),
	
	CreateAchievement(
		23,
		"Maestro Científico",
		"Estudia todas las anomalías de un nivel completo.",
		ACHIEVEMENT_CATEGORIES.RESEARCH,
		80,
		"complete_level",
		{Credits = 2000, Points = 80, Title = "Maestro"}
	),
	
	CreateAchievement(
		24,
		"Descubridor de Secretos",
		"Desbloquea información sobre EL VOID.",
		ACHIEVEMENT_CATEGORIES.RESEARCH,
		250,
		"unlock_void_info",
		{Credits = 10000, Points = 250, Title = "Dios"}
	),
	
	-- LOGROS DE RIQUEZA
	CreateAchievement(
		30,
		"Primer A-Credit",
		"Gana tu primer A-Credit.",
		ACHIEVEMENT_CATEGORIES.WEALTH,
		5,
		"credits_1",
		{Credits = 50, Points = 5}
	),
	
	CreateAchievement(
		31,
		"Emprendedor",
		"Acumula 1000 A-Credits.",
		ACHIEVEMENT_CATEGORIES.WEALTH,
		20,
		"credits_1000",
		{Credits = 500, Points = 20}
	),
	
	CreateAchievement(
		32,
		"Magnate",
		"Acumula 10000 A-Credits.",
		ACHIEVEMENT_CATEGORIES.WEALTH,
		50,
		"credits_10000",
		{Credits = 2000, Points = 50, Title = "Millonario"}
	),
	
	CreateAchievement(
		33,
		"Fondo de Emergencia",
		"Compra 5 artículos diferentes en la tienda.",
		ACHIEVEMENT_CATEGORIES.WEALTH,
		25,
		"purchases_5",
		{Credits = 500, Points = 25}
	),
	
	-- LOGROS DE EXPLORACIÓN
	CreateAchievement(
		40,
		"Primer Paso",
		"Entra en tu primer sector de AADI.",
		ACHIEVEMENT_CATEGORIES.EXPLORATION,
		10,
		"explore_sector_1",
		{Credits = 200, Points = 10}
	),
	
	CreateAchievement(
		41,
		"Explorador",
		"Entra en todos los sectores públicos.",
		ACHIEVEMENT_CATEGORIES.EXPLORATION,
		40,
		"explore_all_public",
		{Credits = 1500, Points = 40, Title = "Explorador"}
	),
	
	CreateAchievement(
		42,
		"Cartógrafo de AADI",
		"Mapa completo de todos los sectores.",
		ACHIEVEMENT_CATEGORIES.EXPLORATION,
		60,
		"explore_all",
		{Credits = 2500, Points = 60, Title = "Cartógrafo"}
	),
	
	-- LOGROS DE SUPERVIVENCIA
	CreateAchievement(
		50,
		"Primer Turno Completo",
		"Completa tu primer turno de trabajo.",
		ACHIEVEMENT_CATEGORIES.SURVIVAL,
		15,
		"complete_shift_1",
		{Credits = 300, Points = 15}
	),
	
	CreateAchievement(
		51,
		"Guerrero de la Noche",
		"Completa 10 turnos de noche.",
		ACHIEVEMENT_CATEGORIES.SURVIVAL,
		40,
		"night_shifts_10",
		{Credits = 1000, Points = 40}
	),
	
	CreateAchievement(
		52,
		"Invulnerable",
		"Sobrevive a un brote de contención sin ser dañado.",
		ACHIEVEMENT_CATEGORIES.SURVIVAL,
		75,
		"containment_undamaged",
		{Credits = 2500, Points = 75, Title = "Invulnerable"}
	),
	
	CreateAchievement(
		53,
		"Fénix",
		"Sé resucitado 5 veces.",
		ACHIEVEMENT_CATEGORIES.SURVIVAL,
		50,
		"revived_5",
		{Credits = 1500, Points = 50}
	),
	
	-- LOGROS DE LIDERAZGO
	CreateAchievement(
		60,
		"Mentor",
		"Ayuda a 3 nuevos reclutas a completar su entrenamiento.",
		ACHIEVEMENT_CATEGORIES.LEADERSHIP,
		40,
		"mentor_3",
		{Credits = 1200, Points = 40, Title = "Mentor"}
	),
	
	CreateAchievement(
		61,
		"Comandante",
		"Lidera un equipo de 5 personas en una misión.",
		ACHIEVEMENT_CATEGORIES.LEADERSHIP,
		60,
		"lead_team_5",
		{Credits = 2000, Points = 60, Title = "Comandante"}
	),
	
	CreateAchievement(
		62,
		"General",
		"Completa 10 misiones como líder de equipo.",
		ACHIEVEMENT_CATEGORIES.LEADERSHIP,
		100,
		"lead_missions_10",
		{Credits = 3500, Points = 100, Title = "General"}
	),
	
	-- LOGROS SECRETOS
	CreateAchievement(
		100,
		"El Elegido",
		"Descubre la verdad sobre AADI.",
		ACHIEVEMENT_CATEGORIES.SECRET,
		200,
		"truth_aadi",
		{Credits = 5000, Points = 200, Title = "Elegido"}
	),
	
	CreateAchievement(
		101,
		"Guardián del Abismo",
		"Acepta la misión de vigilar EL VOID.",
		ACHIEVEMENT_CATEGORIES.SECRET,
		500,
		"guardian_void",
		{Credits = 10000, Points = 500, Title = "Guardián"}
	),
	
	CreateAchievement(
		102,
		"La Verdad Final",
		"Descubre el secreto de AADI-500.",
		ACHIEVEMENT_CATEGORIES.SECRET,
		1000,
		"void_truth",
		{Credits = 25000, Points = 1000, Title = "Iluminado"}
	),
}

-- Sistema de jugador
function AchievementSystem:CreatePlayerAchievements(playerName)
	return {
		PlayerName = playerName,
		UnlockedAchievements = {},
		AchievementPoints = 0,
		Title = "Recluta",
	}
end

-- Desbloquear logro
function AchievementSystem:UnlockAchievement(playerData, achievementID)
	local achievement = self.AchievementDatabase[achievementID]
	
	if not achievement then
		return false, "Logro no encontrado"
	end
	
	-- Verificar si ya está desbloqueado
	for _, unlockedID in ipairs(playerData.UnlockedAchievements) do
		if unlockedID == achievementID then
			return false, "Ya tienes este logro"
		end
	end
	
	-- Desbloquear
	table.insert(playerData.UnlockedAchievements, achievementID)
	playerData.AchievementPoints = playerData.AchievementPoints + achievement.Points
	
	-- Aplicar título si es apropiado
	if achievement.Reward.Title then
		playerData.Title = achievement.Reward.Title
	end
	
	local message = "🏆 ¡LOGRO DESBLOQUEADO!\n"
	message = message .. achievement.Name .. "\n"
	message = message .. achievement.Description .. "\n"
	message = message .. "+" .. achievement.Points .. " Puntos de Logro\n"
	
	if achievement.Reward.Title then
		message = message .. "Título: " .. achievement.Reward.Title
	end
	
	return true, message
end

-- Obtener logro
function AchievementSystem:GetAchievement(achievementID)
	return self.AchievementDatabase[achievementID]
end

-- Obtener logros por categoría
function AchievementSystem:GetAchievementsByCategory(category)
	local achievements = {}
	for id, achievement in ipairs(self.AchievementDatabase) do
		if achievement.Category == category then
			table.insert(achievements, {ID = id, Achievement = achievement})
		end
	end
	return achievements
end

-- Obtener progreso del jugador
function AchievementSystem:GetPlayerProgress(playerData)
	local totalAchievements = #self.AchievementDatabase
	local unlockedCount = #playerData.UnlockedAchievements
	local progressPercentage = math.floor((unlockedCount / totalAchievements) * 100)
	
	return {
		PlayerName = playerData.PlayerName,
		UnlockedCount = unlockedCount,
		TotalAchievements = totalAchievements,
		ProgressPercentage = progressPercentage,
		AchievementPoints = playerData.AchievementPoints,
		Title = playerData.Title,
		ProgressBar = string.rep("█", math.floor(progressPercentage / 5)) .. string.rep("░", 20 - math.floor(progressPercentage / 5)),
	}
end

-- Obtener estadísticas globales
function AchievementSystem:GetGlobalStats()
	return {
		TotalAchievements = #self.AchievementDatabase,
		RankAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.RANK),
		CombatAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.COMBAT),
		ResearchAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.RESEARCH),
		WealthAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.WEALTH),
		ExplorationAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.EXPLORATION),
		SurvivalAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.SURVIVAL),
		LeadershipAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.LEADERSHIP),
		SecretAchievements = #self:GetAchievementsByCategory(ACHIEVEMENT_CATEGORIES.SECRET),
	}
end

-- Mostrar tabla de clasificación
function AchievementSystem:ShowLeaderboard(playersData, topCount)
	topCount = topCount or 10
	
	-- Ordenar por puntos de logro
	table.sort(playersData, function(a, b)
		return a.AchievementPoints > b.AchievementPoints
	end)
	
	local leaderboard = "\n🏆 TABLA DE CLASIFICACIÓN DE LOGROS 🏆\n"
	leaderboard = leaderboard .. string.rep("=", 60) .. "\n"
	
	for i = 1, math.min(topCount, #playersData) do
		local player = playersData[i]
		leaderboard = leaderboard .. 
			i .. ". " .. player.PlayerName .. 
			" (" .. player.AchievementPoints .. " puntos) - " .. 
			player.Title .. "\n"
	end
	
	leaderboard = leaderboard .. string.rep("=", 60) .. "\n"
	
	return leaderboard
end

return AchievementSystem
