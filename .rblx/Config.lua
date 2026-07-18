--[[
	CONFIGURATION FILE
	Archivo de configuración personalizable para AADI
	Ajusta estos valores según tus necesidades
]]

local Config = {}

-- 🎮 CONFIGURACIÓN DEL SERVIDOR
Config.Server = {
	Name = "AADI - Advanced Anomaly Development Institute",
	Version = "1.0.0",
	MaxPlayers = 50,
	Difficulty = "Hard", -- Easy, Normal, Hard, Extreme
	Debug = true, -- Mostrar mensajes de debug
}

-- 💰 CONFIGURACIÓN DE ECONOMÍA
Config.Economy = {
	StartingCredits = 1000, -- A-Credits iniciales
	DailyBonus = 500, -- Bonus diario
	ResearchPointsMultiplier = 1.0, -- Multiplicador de puntos
	SalaryMultiplier = 1.0, -- Multiplicador de salarios
}

-- 🔓 CONFIGURACIÓN DE ACCESO
Config.Access = {
	CardExpirationDays = 365,
	MaxAccessLevel = 5,
	DefaultAccessLevel = 0,
	RequireCardForEntry = true,
	LogAllAccess = true,
}

-- 🚪 CONFIGURACIÓN DE PUERTAS
Config.Doors = {
	AutoCloseTime = 10, -- Segundos
	LockdownDuration = 300, -- Segundos (5 minutos)
	RequireConfirmation = false,
	AlertOnFailedAccess = true,
	RecordAccessLog = true,
}

-- 🔬 CONFIGURACIÓN DE ANOMALÍAS
Config.Anomalies = {
	TotalAnomalies = 500,
	StudyTimeMultiplier = 1.0,
	ResearchPointsPerMinute = 5,
	DangerLevelScaling = 1.0,
	EnableAnomalyRisks = true,
}

-- 📊 CONFIGURACIÓN DE DESBLOQUEO
Config.Unlock = {
	Level0Required = 500,
	Level1Required = 1000,
	Level2Required = 1500,
	Level3Required = 2000,
	Level4Required = 2500,
	Level5Required = 3000,
	EnableProgression = true,
}

-- 👥 CONFIGURACIÓN DE EMPLEADOS
Config.Employees = {
	EnableSalaries = true,
	PayDay = 86400, -- Segundos (24 horas)
	MinimumSalary = 100,
	MaximumSalary = 500,
	EnableBenefits = true,
	MaxEmployees = 100,
}

-- 🎯 CONFIGURACIÓN DE MISIONES
Config.Missions = {
	EnableMissions = true,
	MissionTimeout = 3600, -- Segundos (1 hora)
	RewardMultiplier = 1.0,
	FailureConsequences = true,
}

-- 🛒 CONFIGURACIÓN DE TIENDA
Config.Shop = {
	EnableShop = true,
	MaxItemPrice = 5000,
	MinItemPrice = 10,
	DailyRestockTime = 86400,
	EnableSalesEvents = true,
}

-- 🚨 CONFIGURACIÓN DE SEGURIDAD
Config.Security = {
	EnableEmergencyProtocol = true,
	EnableLockdown = true,
	EnableAntiCheat = true,
	MaxFailedAccessAttempts = 3,
	BanDurationMinutes = 60,
}

-- 👥 CONFIGURACIÓN DE NPCs
Config.NPCs = {
	EnableNPCs = true,
	NPCDialogueFrequency = 60, -- Segundos
	NPCResponseDelay = 2, -- Segundos
	EnableAIDifficulty = "Normal", -- Easy, Normal, Hard
}

-- ⚙️ CONFIGURACIÓN DE SISTEMA
Config.System = {
	AutoSaveInterval = 300, -- Segundos (5 minutos)
	EnableLogging = true,
	LogFile = "AADI_Logs.txt",
	EnableMetrics = true,
	MaxLogSize = 1000000, -- Bytes (1MB)
}

-- 🎨 CONFIGURACIÓN VISUAL
Config.UI = {
	EnableGUI = true,
	Theme = "Dark", -- Light, Dark, SCP-Style
	Language = "Spanish", -- English, Spanish
	ShowProgressBars = true,
	ShowNotifications = true,
}

-- 📈 CONFIGURACIÓN DE ESCALABILIDAD
Config.Scaling = {
	DifficultyScaling = true,
	PlayerCountScaling = true,
	AnomalyStrengthScaling = true,
	EconomyInflation = 0.01, -- 1% por día
}

-- ⏰ CONFIGURACIÓN DE EVENTOS
Config.Events = {
	EnableRandomEvents = true,
	EventFrequency = 300, -- Segundos (5 minutos)
	EventSeverity = "Medium", -- Low, Medium, High, Critical
	CriticalEventChance = 0.05, -- 5%
}

-- 🎓 CONFIGURACIÓN DE BALANCE
Config.Balance = {
	DamageMultiplier = 1.0,
	HealthMultiplier = 1.0,
	ArmorMultiplier = 1.0,
	FireRateMultiplier = 1.0,
	AccuracyModifier = 0, -- -/+%
}

-- 📋 ROLES PERSONALIZABLES
Config.Roles = {
	Visitor = {
		AccessLevel = 0,
		Salary = 0,
		MaxHealth = 80,
		CanBuyWeapons = false,
	},
	Scientist = {
		AccessLevel = 2,
		Salary = 150,
		MaxHealth = 100,
		CanBuyWeapons = false,
	},
	Guard = {
		AccessLevel = 3,
		Salary = 200,
		MaxHealth = 150,
		CanBuyWeapons = true,
	},
	Doctor = {
		AccessLevel = 2,
		Salary = 180,
		MaxHealth = 120,
		CanBuyWeapons = false,
	},
	Executive = {
		AccessLevel = 4,
		Salary = 300,
		MaxHealth = 130,
		CanBuyWeapons = true,
	},
	Director = {
		AccessLevel = 5,
		Salary = 500,
		MaxHealth = 150,
		CanBuyWeapons = true,
	},
}

-- 🎯 PRESETS DE DIFICULTAD
Config.Presets = {
	Easy = {
		DamageMultiplier = 0.5,
		HealthMultiplier = 2.0,
		RewardMultiplier = 1.5,
		EnemyCountMultiplier = 0.5,
	},
	Normal = {
		DamageMultiplier = 1.0,
		HealthMultiplier = 1.0,
		RewardMultiplier = 1.0,
		EnemyCountMultiplier = 1.0,
	},
	Hard = {
		DamageMultiplier = 1.5,
		HealthMultiplier = 0.8,
		RewardMultiplier = 1.3,
		EnemyCountMultiplier = 1.5,
	},
	Extreme = {
		DamageMultiplier = 2.0,
		HealthMultiplier = 0.6,
		RewardMultiplier = 2.0,
		EnemyCountMultiplier = 2.0,
	},
}

-- 📍 UBICACIONES ESPECIALES
Config.Locations = {
	AADI_000 = "Entrada (Recepción)",
	AADI_100 = "Personal Civil & Oficinas",
	AADI_200 = "Zonas de Armamiento",
	AADI_300 = "Laboratorios Científicos",
	AADI_400 = "Celdas de Contención",
	AADI_500 = "ABISMO",
}

-- 🔑 CÓDIGOS DE SEGURIDAD
Config.SecurityCodes = {
	LOCKDOWN = "CODE-LOCKDOWN-ALPHA",
	EMERGENCY = "CODE-EMERGENCY-DELTA",
	BREACH = "CODE-BREACH-GAMMA",
	ALLCLEAR = "CODE-ALLCLEAR-OMEGA",
}

-- 📱 CONFIGURACIÓN API
Config.API = {
	EnableAPI = false,
	APIPort = 8080,
	APIKey = "YOUR_API_KEY_HERE",
	RateLimitPerMinute = 60,
}

-- ✅ VALIDAR Y APLICAR CONFIGURACIÓN
function Config:Validate()
	-- Validar que los valores estén en rangos correctos
	if self.Server.MaxPlayers < 1 or self.Server.MaxPlayers > 500 then
		self.Server.MaxPlayers = 50
		print("[CONFIG] MaxPlayers ajustado a 50")
	end
	
	if self.Economy.StartingCredits < 0 then
		self.Economy.StartingCredits = 1000
		print("[CONFIG] StartingCredits ajustado a 1000")
	end
	
	print("[CONFIG] ✅ Configuración validada y aplicada")
	return true
end

-- 🔧 OBTENER CONFIGURACIÓN
function Config:Get(path)
	local keys = string.split(path, ".")
	local current = self
	
	for _, key in ipairs(keys) do
		if current[key] then
			current = current[key]
		else
			return nil
		end
	end
	
	return current
end

-- ✏️ ESTABLECER CONFIGURACIÓN
function Config:Set(path, value)
	local keys = string.split(path, ".")
	local current = self
	
	for i = 1, #keys - 1 do
		if not current[keys[i]] then
			current[keys[i]] = {}
		end
		current = current[keys[i]]
	end
	
	current[keys[#keys]] = value
	print("[CONFIG] " .. path .. " = " .. tostring(value))
end

-- 🔄 RESETEAR A VALORES POR DEFECTO
function Config:Reset()
	-- Esto debería ser implementado con los valores originales
	print("[CONFIG] Configuración reseteada a valores por defecto")
	return self:Validate()
end

-- 📊 OBTENER TODAS LAS CONFIGURACIONES
function Config:GetAll()
	return self
end

-- 🎯 APLICAR PRESET DE DIFICULTAD
function Config:ApplyDifficultyPreset(difficulty)
	local preset = self.Presets[difficulty]
	if preset then
		self.Balance = preset
		print("[CONFIG] Dificultad aplicada: " .. difficulty)
		return true
	else
		print("[CONFIG] ❌ Dificultad desconocida: " .. difficulty)
		return false
	end
end

-- Validar configuración al cargar
Config:Validate()

return Config
