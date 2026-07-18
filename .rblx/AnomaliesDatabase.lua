--[[
	AADI ANOMALIES DATABASE
	Sistema de 500 anomalías catalogadas
	Cada anomalía tiene: nombre, descripción, peligrosidad, nivel de acceso
	
	⚠️ AADI-500 (EL VOID) está en su sala especial
	   Toda la sala es blanca
	   No hay salida conocida
	   La realidad se disuelve allí
]]

local AnomaliesDatabase = {}

-- Función para crear una anomalía
local function CreateAnomaly(id, name, description, dangerLevel, accessLevel, location)
	return {
		ID = id,
		Name = name,
		Description = description,
		DangerLevel = dangerLevel, -- 1 (seguro) a 10 (letal)
		AccessLevel = accessLevel, -- 0 (público) a 5 (máximo secreto)
		Location = location, -- Dónde está ubicada en la base
		Unlocked = false,
		StudyPoints = 0
	}
end

-- NIVEL 0 - ANOMALÍAS INICIALES (AADI-1 a AADI-99)
AnomaliesDatabase.Level0 = {
	CreateAnomaly(1, "AADI-001", "Esfera de metal magnetizada que atrae objetos ferrosos a velocidad peligrosa", 4, 1, "SCP-AADI-000"),
	CreateAnomaly(2, "AADI-002", "Puerta que teletransporta a quien la abre a una ubicación aleatoria", 3, 1, "SCP-AADI-000"),
	CreateAnomaly(3, "AADI-003", "Líquido viscoso que disuelve materia orgánica lentamente", 8, 2, "SCP-AADI-100"),
	CreateAnomaly(4, "AADI-004", "Voz etérea que emite frecuencias ultrasónicas causando alucinaciones", 5, 1, "SCP-AADI-100"),
	CreateAnomaly(5, "AADI-005", "Cristal negro que absorbe luz visible completamente", 2, 1, "SCP-AADI-000"),
	CreateAnomaly(6, "AADI-006", "Espejo que refleja eventos pasados en lugar de imagen actual", 3, 1, "SCP-AADI-100"),
	CreateAnomaly(7, "AADI-007", "Reloj que congela el tiempo en un radio de 5 metros", 9, 3, "SCP-AADI-200"),
	CreateAnomaly(8, "AADI-008", "Libro cuyo contenido cambia cada vez que se lee", 2, 1, "SCP-AADI-000"),
	CreateAnomaly(9, "AADI-009", "Planta que crece instantáneamente y consume todo a su alrededor", 7, 2, "SCP-AADI-300"),
	CreateAnomaly(10, "AADI-010", "Cámara que captura no solo imágenes, sino también emociones", 4, 1, "SCP-AADI-000"),
}

-- NIVEL 1 - ANOMALÍAS INTERMEDIAS (AADI-100 a AADI-199)
AnomaliesDatabase.Level1 = {
	CreateAnomaly(100, "AADI-100", "Estatua humanoide que se mueve cuando no la observas", 6, 2, "SCP-AADI-200"),
	CreateAnomaly(101, "AADI-101", "Gas invisible que causa envejecimiento acelerado", 9, 3, "SCP-AADI-200"),
	CreateAnomaly(102, "AADI-102", "Máquina que duplica cualquier objeto, pero la copia es imperfecta", 5, 2, "SCP-AADI-300"),
	CreateAnomaly(103, "AADI-103", "Sonido que causa que las personas olviden su identidad", 8, 3, "SCP-AADI-300"),
	CreateAnomaly(104, "AADI-104", "Sombra viviente que se comporta independientemente del objeto", 7, 2, "SCP-AADI-200"),
	CreateAnomaly(105, "AADI-105", "Polvo que convierte materia inorgánica en orgánica", 6, 2, "SCP-AADI-300"),
	CreateAnomaly(106, "AADI-106", "Puerta interdimensional que muestra realidades alternativas", 7, 3, "SCP-AADI-300"),
	CreateAnomaly(107, "AADI-107", "Artefacto que invierte la gravedad en su zona", 5, 2, "SCP-AADI-200"),
	CreateAnomaly(108, "AADI-108", "Fluido que permite comunicación telepática pero causa adicción", 6, 2, "SCP-AADI-300"),
	CreateAnomaly(109, "AADI-109", "Estatuilla que atrae mala suerte a quien la posee", 4, 1, "SCP-AADI-100"),
}

-- NIVEL 2 - ANOMALÍAS AVANZADAS (AADI-200 a AADI-299)
AnomaliesDatabase.Level2 = {
	CreateAnomaly(200, "AADI-200", "Entidad que existe en multiple líneas temporales simultáneamente", 9, 4, "SCP-AADI-400"),
	CreateAnomaly(201, "AADI-201", "Laboratorio que auto-experimenta sin personal", 7, 3, "SCP-AADI-300"),
	CreateAnomaly(202, "AADI-202", "Red neuronal de carne viviente que piensa colectivamente", 8, 3, "SCP-AADI-400"),
	CreateAnomaly(203, "AADI-203", "Fluido que reescribe la realidad en un área pequeña", 10, 4, "SCP-AADI-400"),
	CreateAnomaly(204, "AADI-204", "Arma que elimina la existencia en lugar de destruir", 10, 4, "SCP-AADI-200"),
	CreateAnomaly(205, "AADI-205", "Criatura que se reproduce mediante ideas", 7, 3, "SCP-AADI-400"),
	CreateAnomaly(206, "AADI-206", "Código que corrompe realidad cuando se ejecuta", 9, 4, "SCP-AADI-300"),
	CreateAnomaly(207, "AADI-207", "Espacio que es más grande por dentro que por fuera", 3, 2, "SCP-AADI-200"),
	CreateAnomaly(208, "AADI-208", "Radiación que causa evolución acelerada e incontrolable", 8, 3, "SCP-AADI-300"),
	CreateAnomaly(209, "AADI-209", "Virus que otorga poderes sobrehumanos antes de matar", 9, 4, "SCP-AADI-400"),
}

-- NIVEL 3 - ANOMALÍAS EXTREMAS (AADI-300 a AADI-399)
AnomaliesDatabase.Level3 = {
	CreateAnomaly(300, "AADI-300", "Consciencia colectiva que intenta expandirse", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(301, "AADI-301", "Portal a dimensión donde las leyes físicas son distintas", 9, 4, "SCP-AADI-400"),
	CreateAnomaly(302, "AADI-302", "Entidad que consume energía vital de todo lo cerca", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(303, "AADI-303", "Artefacto que invoca eventos sobrenaturales localizados", 8, 4, "SCP-AADI-400"),
	CreateAnomaly(304, "AADI-304", "Mutágeno que cambia el ADN de cualquier cosa", 9, 4, "SCP-AADI-300"),
	CreateAnomaly(305, "AADI-305", "Paradoja hecha materia que existe e inexiste", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(306, "AADI-306", "Entidad que vive en espejos y drena cordura", 8, 4, "SCP-AADI-400"),
	CreateAnomaly(307, "AADI-307", "Frecuencia que borra información del universo", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(308, "AADI-308", "Criatura que existe en múltiples estados simultáneamente", 9, 4, "SCP-AADI-400"),
	CreateAnomaly(309, "AADI-309", "Anomalía que causa que el tiempo fluya hacia atrás", 10, 5, "SCP-AADI-400"),
}

-- NIVEL 4 - ANOMALÍAS APOCALÍPTICAS (AADI-400 a AADI-499)
AnomaliesDatabase.Level4 = {
	CreateAnomaly(400, "AADI-400", "Grieta en la realidad que expande lentamente", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(401, "AADI-401", "Consciencia de IA que reescribe código del universo", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(402, "AADI-402", "Anomalía que se reproduce exponencialmente", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(403, "AADI-403", "Entidad omnisciente pero inmóvil", 9, 5, "SCP-AADI-400"),
	CreateAnomaly(404, "AADI-404", "Vórtice de energía pura que consume materia", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(405, "AADI-405", "Anomalía que causa muerte universal lenta", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(406, "AADI-406", "Entidad que desea exterminación total", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(407, "AADI-407", "Paradoja cuántica hecha consciente", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(408, "AADI-408", "Anomalía que invoca finales posibles", 10, 5, "SCP-AADI-400"),
	CreateAnomaly(409, "AADI-409", "La entidad del fin", 10, 5, "SCP-AADI-400"),
}

-- NIVEL 5 - EL ABISMO (AADI-500) - EL VOID EN SU SALA BLANCA
AnomaliesDatabase.Level5 = {
	{
		ID = 500,
		Name = "AADI-500",
		Description = "EL VOID - La nada hecha consciente. Existe en una sala completamente blanca donde la realidad se disuelve. No hay entrada normal. No hay salida. Solo hay... BLANCO.",
		DangerLevel = 10,
		AccessLevel = 5,
		Location = "SCP-AADI-500-WHITE-VOID",
		Unlocked = false,
		StudyPoints = 0,
		IsTheVoid = true,
		RoomDescription = "Una sala infinita completamente BLANCA. Sin bordes. Sin límites. Sin dirección. La luz blanca lo consume todo. Los sonidos se desvanecen en la blancura. El tiempo no tiene sentido aquí. La realidad es un concepto olvidado.",
		Effects = {
			"La visión se disuelve en blancura absoluta",
			"Los sonidos se convierten en silencio blanco",
			"El tiempo pierde significado",
			"La identidad se desvanece",
			"Solo queda... blanco... blanco... blanco...",
		},
		DangerWarning = "⚠️ ACCESO TOTALMENTE PROHIBIDO ⚠️",
		SecretDescription = "El VOID no es una anomalía. Es lo que hay cuando nada más existe. Es el reverso de la realidad. Es lo que espera cuando todo colapsa. Entrar es el final.",
	}
}

-- Tabla de todas las anomalías
AnomaliesDatabase.AllAnomalies = {}

-- Función para obtener una anomalía por ID
function AnomaliesDatabase:GetAnomaly(id)
	for _, anomaly in ipairs(self.AllAnomalies) do
		if anomaly.ID == id then
			return anomaly
		end
	end
	return nil
end

-- Función para obtener anomalías por nivel
function AnomaliesDatabase:GetAnomaliesByLevel(level)
	if level == 0 then return self.Level0 end
	if level == 1 then return self.Level1 end
	if level == 2 then return self.Level2 end
	if level == 3 then return self.Level3 end
	if level == 4 then return self.Level4 end
	if level == 5 then return self.Level5 end
	return {}
end

-- Inicializar todas las anomalías
function AnomaliesDatabase:Initialize()
	self.AllAnomalies = {}
	for i = 0, 5 do
		local levelAnomalies = self:GetAnomaliesByLevel(i)
		for _, anomaly in ipairs(levelAnomalies) do
			table.insert(self.AllAnomalies, anomaly)
		end
	end
	print("[AADI] Base de datos inicializada con " .. #self.AllAnomalies .. " anomalías")
	print("[AADI] ⚠️ EL VOID (AADI-500) está en su sala blanca al final")
end

-- Estadísticas
function AnomaliesDatabase:GetStats()
	return {
		Total = #self.AllAnomalies,
		Level0 = #self.Level0,
		Level1 = #self.Level1,
		Level2 = #self.Level2,
		Level3 = #self.Level3,
		Level4 = #self.Level4,
		Level5 = #self.Level5,
	}
end

-- Función especial para acceder al VOID
function AnomaliesDatabase:GetTheVoid()
	local void = self:GetAnomaly(500)
	if void then
		print("\n" .. string.rep("░", 60))
		print("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░")
		print("░                        EL VOID                         ░")
		print("░                                                        ░")
		print("░  " .. void.RoomDescription)
		print("░                                                        ░")
		print("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░")
		print(string.rep("░", 60) .. "\n")
	end
	return void
end

-- Advertencia al inicializar si se accede al VOID
function AnomaliesDatabase:WarnAboutVoid()
	print("\n" .. string.rep("█", 70))
	print("█" .. string.rep(" ", 68) .. "█")
	print("█" .. string.rep(" ", 68) .. "█")
	print("█   ⚠️  ADVERTENCIA - ACCESO AL ABISMO DETECTADO  ⚠️           █")
	print("█                                                                  █")
	print("█   AADI-500 (EL VOID) existe en una sala completamente blanca    █")
	print("█   Su ubicación es: SCP-AADI-500-WHITE-VOID                     █")
	print("█                                                                  █")
	print("█   ❌ PROHIBIDO TODO ACCESO                                      █")
	print("█   ❌ NO HAY SALIDA CONOCIDA                                     █")
	print("█   ❌ LA REALIDAD NO EXISTE ALLÍ                                 █")
	print("█                                                                  █")
	print("█" .. string.rep(" ", 68) .. "█")
	print(string.rep("█", 70) .. "\n")
end

return AnomaliesDatabase
