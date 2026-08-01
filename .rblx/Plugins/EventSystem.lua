--[[
	EVENT SYSTEM - SISTEMA DE EVENTOS DINÁMICOS
	Módulo para crear eventos aleatorios y críticos en AADI
	Los eventos pueden ser desde rutinarios hasta catastróficos
]]

local EventSystem = {}
EventSystem.__index = EventSystem

-- Tipos de eventos
local EVENT_TYPES = {
	ROUTINE = "Rutinario",
	WARNING = "Advertencia",
	CRITICAL = "Crítico",
	CATASTROPHIC = "Catastrófico",
}

-- Severidades
local EVENT_SEVERITY = {
	LOW = 1,
	MEDIUM = 2,
	HIGH = 3,
	CRITICAL = 4,
	APOCALYPTIC = 5,
}

-- Crear evento
local function CreateEvent(eventID, name, description, eventType, severity, location, effects, likelihood)
	return {
		EventID = eventID,
		Name = name,
		Description = description,
		Type = eventType,
		Severity = severity,
		Location = location,
		Effects = effects or {},
		Likelihood = likelihood or 0.5,
		Active = false,
		StartedAt = nil,
		Duration = 300, -- 5 minutos por defecto
		AffectedPlayers = {},
	}
end

-- Base de datos de eventos
EventSystem.EventDatabase = {
	-- EVENTOS RUTINARIOS
	CreateEvent(
		1,
		"Cambio de turno",
		"El turno de empleados cambia. Nuevos guardias llegan.",
		EVENT_TYPES.ROUTINE,
		EVENT_SEVERITY.LOW,
		"SCP-AADI-000",
		{"Cambio de personal", "Nuevos guardias en posición"},
		0.8
	),
	
	CreateEvent(
		2,
		"Mantenimiento de puertas",
		"Mantenimiento rutinario de puertas de seguridad.",
		EVENT_TYPES.ROUTINE,
		EVENT_SEVERITY.LOW,
		"SCP-AADI-200",
		{"Algunas puertas temporalmente inoperantes", "Acceso limitado"},
		0.6
	),
	
	CreateEvent(
		3,
		"Inspección de anomalías",
		"Inspección de rutina de anomalías de bajo riesgo.",
		EVENT_TYPES.ROUTINE,
		EVENT_SEVERITY.LOW,
		"SCP-AADI-300",
		{"Personal científico trabajando", "Mayor actividad"},
		0.7
	),
	
	-- EVENTOS DE ADVERTENCIA
	CreateEvent(
		10,
		"Lectura anómala detectada",
		"Los sensores detectan lecturas anómalas en un sector.",
		EVENT_TYPES.WARNING,
		EVENT_SEVERITY.MEDIUM,
		"SCP-AADI-400",
		{"Aumento de radiación", "Equipo de contención activado"},
		0.4
	),
	
	CreateEvent(
		11,
		"Fallo de generador",
		"Se ha detectado un fallo parcial en los generadores de emergencia.",
		EVENT_TYPES.WARNING,
		EVENT_SEVERITY.MEDIUM,
		"SCP-AADI-000",
		{"Apagones en sectores", "Sistemas de respaldo activándose"},
		0.3
	),
	
	CreateEvent(
		12,
		"Comunicación interferida",
		"La comunicación interna está siendo interferida.",
		EVENT_TYPES.WARNING,
		EVENT_SEVERITY.MEDIUM,
		"SCP-AADI-300",
		{"Interferencia de radio", "Visión limitada"},
		0.25
	),
	
	CreateEvent(
		13,
		"Cambio de clima",
		"Condiciones climáticas extremas detectadas afuera.",
		EVENT_TYPES.WARNING,
		EVENT_SEVERITY.MEDIUM,
		"Exterior",
		{"Tormentas intensas", "Reducción de personal externo"},
		0.5
	),
	
	-- EVENTOS CRÍTICOS
	CreateEvent(
		20,
		"Brote de contención menor",
		"Una anomalía de bajo riesgo ha iniciado un brote menor.",
		EVENT_TYPES.CRITICAL,
		EVENT_SEVERITY.HIGH,
		"SCP-AADI-300",
		{"Lockdown parcial", "Equipo de respuesta activado"},
		0.15
	),
	
	CreateEvent(
		21,
		"Intrusión de personal no autorizado",
		"Se ha detectado personal no autorizado en el complejo.",
		EVENT_TYPES.CRITICAL,
		EVENT_SEVERITY.HIGH,
		"SCP-AADI-200",
		{"Búsqueda de personal", "Puertas bloqueadas"},
		0.1
	),
	
	CreateEvent(
		22,
		"Fallo en sistema de contención",
		"El sistema de contención de una anomalía ha fallado parcialmente.",
		EVENT_TYPES.CRITICAL,
		EVENT_SEVERITY.HIGH,
		"SCP-AADI-400",
		{"Brote inminente", "Evacuación de personal"},
		0.08
	),
	
	CreateEvent(
		23,
		"Corrupción de datos",
		"Los datos críticos están siendo corrompidos.",
		EVENT_TYPES.CRITICAL,
		EVENT_SEVERITY.HIGH,
		"SCP-AADI-000",
		{"Pérdida de información", "Sistemas en riesgo"},
		0.05
	),
	
	CreateEvent(
		24,
		"Anomalía rogue detectada",
		"Se ha detectado una anomalía no catalogada en el complejo.",
		EVENT_TYPES.CRITICAL,
		EVENT_SEVERITY.HIGH,
		"SCP-AADI-100",
		{"Amenaza desconocida", "Protocolos especiales activados"},
		0.07
	),
	
	-- EVENTOS CATASTRÓFICOS
	CreateEvent(
		30,
		"Brote masivo de contención",
		"MÚLTIPLES anomalías han iniciado un brote simultáneo.",
		EVENT_TYPES.CATASTROPHIC,
		EVENT_SEVERITY.CRITICAL,
		"SCP-AADI-400",
		{"Lockdown total", "Evacuación de emergencia", "Protocolos de defensa"},
		0.02
	),
	
	CreateEvent(
		31,
		"Fallo cascada del sistema",
		"Los sistemas de toda la base están fallando en cascada.",
		EVENT_TYPES.CATASTROPHIC,
		EVENT_SEVERITY.CRITICAL,
		"SCP-AADI-000",
		{"Apagón generalizado", "Sistemas de contención comprometidos"},
		0.01
	),
	
	CreateEvent(
		32,
		"PROTOCOLO ROJO ACTIVADO",
		"Se ha activado el Protocolo Rojo. Contención de todas las anomalías ha fallado.",
		EVENT_TYPES.CATASTROPHIC,
		EVENT_SEVERITY.APOCALYPTIC,
		"SCP-AADI-000",
		{"Brote universal", "Todos los sistemas comprometidos", "AADI está cayendo"},
		0.005
	),
	
	CreateEvent(
		33,
		"EL VOID DESPERTANDO",
		"⚪ ADVERTENCIA EXTREMA ⚪\nADI-500 muestra signos de DESPERTAR.\nLa sala blanca se está expandiendo.\nLa realidad en el área se está disolviendo.",
		EVENT_TYPES.CATASTROPHIC,
		EVENT_SEVERITY.APOCALYPTIC,
		"SCP-AADI-500-WHITE-VOID",
		{"La blancura se expande", "La realidad colapsa", "EL FINAL COMIENZA"},
		0.001
	),
}

-- Sistema de eventos global
function EventSystem:Initialize()
	self.ActiveEvents = {}
	self.EventHistory = {}
	self.TotalEventsTriggered = 0
	print("[EVENT SYSTEM] Sistema de eventos inicializado")
end

-- Disparar evento aleatorio
function EventSystem:TriggerRandomEvent()
	local event = self.EventDatabase[math.random(1, #self.EventDatabase)]
	
	-- Calcular probabilidad
	if math.random() > event.Likelihood then
		return nil, "Evento no se disparó"
	end
	
	return self:TriggerEvent(event.EventID)
end

-- Disparar evento específico
function EventSystem:TriggerEvent(eventID)
	local event = self.EventDatabase[eventID]
	
	if not event then
		return false, "Evento no encontrado"
	end
	
	if event.Active then
		return false, "El evento ya está activo"
	end
	
	event.Active = true
	event.StartedAt = os.time()
	
	table.insert(self.ActiveEvents, event)
	table.insert(self.EventHistory, {
		EventID = eventID,
		EventName = event.Name,
		TriggeredAt = os.time(),
	})
	
	self.TotalEventsTriggered = self.TotalEventsTriggered + 1
	
	-- Anuncio del evento
	local announcement = self:AnnounceEvent(event)
	
	return true, announcement
end

-- Anunciar evento
function EventSystem:AnnounceEvent(event)
	local severityEmoji = {
		[EVENT_SEVERITY.LOW] = "🟢",
		[EVENT_SEVERITY.MEDIUM] = "🟡",
		[EVENT_SEVERITY.HIGH] = "🔴",
		[EVENT_SEVERITY.CRITICAL] = "⚫",
		[EVENT_SEVERITY.APOCALYPTIC] = "⚫⚫⚫",
	}
	
	local message = "\n" .. string.rep("=", 70) .. "\n"
	message = message .. severityEmoji[event.Severity] .. " EVENTO DETECTADO: " .. event.Name .. "\n"
	message = message .. "Tipo: " .. event.Type .. "\n"
	message = message .. "Ubicación: " .. event.Location .. "\n"
	message = message .. "Descripción: " .. event.Description .. "\n"
	message = message .. "\nEfectos:\n"
	
	for _, effect in ipairs(event.Effects) do
		message = message .. "  • " .. effect .. "\n"
	end
	
	message = message .. string.rep("=", 70) .. "\n"
	
	print(message)
	return message
end

-- Resolver evento
function EventSystem:ResolveEvent(eventID, outcome)
	for i, event in ipairs(self.ActiveEvents) do
		if event.EventID == eventID then
			event.Active = false
			event.ResolvedAt = os.time()
			event.Outcome = outcome
			table.remove(self.ActiveEvents, i)
			return true, "✅ Evento resuelto: " .. event.Name
		end
	end
	return false, "Evento no encontrado"
end

-- Obtener eventos activos
function EventSystem:GetActiveEvents()
	return self.ActiveEvents
end

-- Obtener eventos por severidad
function EventSystem:GetEventsBySeverity(severity)
	local events = {}
	for _, event in ipairs(self.EventDatabase) do
		if event.Severity == severity then
			table.insert(events, event)
		end
	end
	return events
end

-- Obtener eventos por tipo
function EventSystem:GetEventsByType(eventType)
	local events = {}
	for _, event in ipairs(self.EventDatabase) do
		if event.Type == eventType then
			table.insert(events, event)
		end
	end
	return events
end

-- Estadísticas de eventos
function EventSystem:GetEventStats()
	return {
		TotalEventTypes = #self.EventDatabase,
		ActiveEvents = #self.ActiveEvents,
		TotalTriggered = self.TotalEventsTriggered,
		EventHistory = #self.EventHistory,
		RoutineEvents = #self:GetEventsByType(EVENT_TYPES.ROUTINE),
		WarningEvents = #self:GetEventsByType(EVENT_TYPES.WARNING),
		CriticalEvents = #self:GetEventsByType(EVENT_TYPES.CRITICAL),
		CatastrophicEvents = #self:GetEventsByType(EVENT_TYPES.CATASTROPHIC),
	}
end

-- Sistema de simulación automática
function EventSystem:StartEventSimulation(interval)
	interval = interval or 60 -- Cada 60 segundos
	
	print("[EVENT SYSTEM] Simulación de eventos iniciada (intervalo: " .. interval .. "s)")
	
	while true do
		wait(interval)
		local success, msg = self:TriggerRandomEvent()
		if success then
			-- Los eventos se resuelven después de su duración
			-- En un juego real, esto sería manejado por el servidor
		end
	end
end

return EventSystem
