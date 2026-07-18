--[[
	NPC DIALOGUES SYSTEM
	Sistema de diálogos SCP-style para NPCs en AADI
	Guardias, científicos, médicos con conversaciones realistas
]]

local NPCDialogues = {}

-- Sistema de NPCs
local NPCDatabase = {}

-- Crear un NPC
function NPCDatabase:CreateNPC(npcID, name, role, location)
	local npc = {
		NPCID = npcID,
		Name = name,
		Role = role, -- Guard, Scientist, Doctor, Executive
		Location = location,
		Dialogues = {},
		LastSpoken = nil,
		Mood = "Neutral", -- Happy, Neutral, Angry, Scared
	}
	
	self[npcID] = npc
	return npc
end

-- Diálogos de GUARDIAS
local GuardDialogues = {
	Greeting = {
		"¿Qué haces aquí? Identifícate.",
		"Esta área requiere autorización. Muestra tu tarjeta.",
		"Ronda de seguridad completada. ¿Necesitas algo?",
		"Mantente alerta. Los protocolos están aumentados.",
		"Sector despejado. Continúa con el procedimiento.",
	},
	Alert = {
		"🚨 ¡INTRUSIÓN DETECTADA!",
		"¡Llamando refuerzos! No te muevas.",
		"LOCKDOWN ACTIVADO EN SECTOR",
		"¡Amenaza neutralizada!",
		"Códi de seguridad rojo. Todos a posiciones defensivas.",
	},
	Casual = {
		"Llevo 6 horas de turno... Es un aburrimiento.",
		"¿Escuchaste sobre la anomalía AADI-203? Aterradora.",
		"Los científicos nunca se toman esto en serio.",
		"Espero que hoy no pase nada anormal.",
		"La seguridad de esta base nunca será perfecta.",
	},
	Quest = {
		"Necesito que investigues el Sector 300. Reportes extraños.",
		"¿Puedes recoger suministros del almacén?",
		"Protege a los civiles mientras yo cubro.",
		"Necesitamos refuerzo en el Sector 400.",
		"Investiga esos ruidos. Probablemente sea nada.",
	}
}

-- Diálogos de CIENTÍFICOS
local ScientistDialogues = {
	Greeting = {
		"¿Venías a ayudar con los experimentos?",
		"Fascinante... Esta anomalía desafía toda lógica conocida.",
		"Bienvenido al laboratorio. ¿Tienes datos para compartir?",
		"La investigación nunca duerme en AADI.",
		"Observa esto... Increíble, ¿no?",
	},
	Research = {
		"AADI-301 muestra propiedades cuánticas anómalas.",
		"Los datos sugieren una realidad alternativa.",
		"Esto contradice todo lo que sabemos.",
		"¡Eureka! Creo que lo tengo.",
		"Necesitamos más tiempo y recursos para confirmar.",
	},
	Casual = {
		"No recuerdo la última vez que dormí...",
		"Los protocolos de seguridad son demasiado restrictivos.",
		"Estos datos son simplemente maravillosos.",
		"Trabajar aquí es peligroso pero emocionante.",
		"Algunos de mis colegas empiezan a comportarse... diferente.",
	},
	Warning = {
		"⚠️ ADVERTENCIA: No acerquemos a ese sector.",
		"AADI-309 mostró signos de contención comprometida.",
		"He visto cosas que... deberías olvidar.",
		"Tenemos un problema. Uno SERIO.",
		"Los datos no mienten. Estamos en peligro.",
	},
	Quest = {
		"¿Podrías analizar estas muestras?",
		"Necesito datos de AADI-205 para mi investigación.",
		"¿Puedes obtener permisos de acceso al Nivel 3?",
		"Estoy compilando información sobre anomalías peligrosas.",
		"Ayúdame a documentar este descubrimiento.",
	}
}

-- Diálogos de MÉDICOS
local DoctorDialogues = {
	Greeting = {
		"¿Necesitas atención médica?",
		"Bienvenido a la clínica de AADI.",
		"Reporta tu estado de salud.",
		"¿Algún síntoma anormal?",
		"La medicina aquí es avanzada pero complicada.",
	},
	Healing = {
		"Te inyectaré nanobots médicos.",
		"Tu radiación fue elevada. Tratándote ahora.",
		"Esto puede doler un poco.",
		"La recuperación será rápida con mi equipo.",
		"✅ Totalmente curado. Siguiente paciente.",
	},
	Warning = {
		"⚠️ Detecté anomalías en tu ADN.",
		"Tu exposición a radiación es peligrosa.",
		"Deberías ser puesto en cuarentena.",
		"He visto estas mutaciones antes... no son buenas.",
		"Necesitas descontaminación INMEDIATA.",
	},
	Casual = {
		"Trabajar aquí requiere nervios de acero.",
		"Veo cosas que medicina normal no puede explicar.",
		"Algunos empleados nunca regresan...",
		"La teoría médica aquí es diferente.",
		"Espero no enfermar de lo que veo diariamente.",
	},
	Quest = {
		"¿Podrías llevar medicinas al Sector 200?",
		"Necesito muestras de sangre para análisis.",
		"¿Pasaste por descontaminación?",
		"Acompaña a este paciente a observación.",
		"Documenta los síntomas de estos empleados.",
	}
}

-- Diálogos de EJECUTIVOS
local ExecutiveDialogues = {
	Greeting = {
		"Reporte de situación. Ahora.",
		"¿Qué novedad hay?",
		"Los estándares de seguridad se mantendrán.",
		"AADI funciona porque mantenemos control.",
		"Bienvenido. Que sea rápido.",
	},
	Important = {
		"Se activó Protocolo Rojo en Sector 400.",
		"Tenemos una contención comprometida.",
		"Los presupuestos de investigación fueron aprobados.",
		"Las anomalías Level 4 requieren vigilancia extrema.",
		"El Consejo Directivo ha tomado decisiones importantes.",
	},
	Threat = {
		"🚨 POSIBLE BRECHA EN CONTENCIÓN",
		"¡EVACÚEN LOS SECTORES CIVILES!",
		"Lockdown total activado.",
		"Todas las anomalías Level 5 bajo vigilancia máxima.",
		"Esto podría ser el fin de AADI.",
	},
	Quest = {
		"Necesito un reporte completo del Sector 300.",
		"¿Verificaste la integridad de todas las puertas?",
		"Investiga estas discrepancias en los datos.",
		"Coordina con Seguridad inmediatamente.",
		"Tu misión es crítica para AADI.",
	}
}

-- Función para obtener diálogo aleatorio
local function GetRandomDialogue(dialogueTable)
	return dialogueTable[math.random(1, #dialogueTable)]
end

-- Sistema interactivo de diálogos
function NPCDatabase:GetDialogue(npcID, context)
	local npc = self[npcID]
	if not npc then return "NPC no encontrado" end
	
	context = context or "Greeting"
	local dialogueTable = nil
	
	if npc.Role == "Guard" then
		dialogueTable = GuardDialogues[context] or GuardDialogues["Greeting"]
	elseif npc.Role == "Scientist" then
		dialogueTable = ScientistDialogues[context] or ScientistDialogues["Greeting"]
	elseif npc.Role == "Doctor" then
		dialogueTable = DoctorDialogues[context] or DoctorDialogues["Greeting"]
	elseif npc.Role == "Executive" then
		dialogueTable = ExecutiveDialogues[context] or ExecutiveDialogues["Greeting"]
	end
	
	if dialogueTable then
		return GetRandomDialogue(dialogueTable)
	end
	
	return "..."
end

-- Crear NPCs predefinidos
function NPCDatabase:InitializeAADINPCs()
	-- GUARDIAS
	self:CreateNPC("NPC-GUARD-001", "Sargento Rodriguez", "Guard", "SCP-AADI-000")
	self:CreateNPC("NPC-GUARD-002", "Oficial Chen", "Guard", "SCP-AADI-200")
	self:CreateNPC("NPC-GUARD-003", "Soldado Marcus", "Guard", "SCP-AADI-400")
	
	-- CIENTÍFICOS
	self:CreateNPC("NPC-SCI-001", "Dr. Helena Kross", "Scientist", "SCP-AADI-300")
	self:CreateNPC("NPC-SCI-002", "Prof. Yuki Tanaka", "Scientist", "SCP-AADI-300")
	self:CreateNPC("NPC-SCI-003", "Dr. Marcus Webb", "Scientist", "SCP-AADI-300")
	
	-- MÉDICOS
	self:CreateNPC("NPC-DOC-001", "Dra. Sarah Mitchell", "Doctor", "SCP-AADI-100")
	self:CreateNPC("NPC-DOC-002", "Dr. James Peterson", "Doctor", "SCP-AADI-100")
	
	-- EJECUTIVOS
	self:CreateNPC("NPC-EXEC-001", "Director General Vladmir", "Executive", "SCP-AADI-000")
	self:CreateNPC("NPC-EXEC-002", "Supervisor Thomas", "Executive", "SCP-AADI-200")
	
	print("[AADI] NPCs de AADI inicializados")
end

-- Obtener todos los NPCs
function NPCDatabase:GetAllNPCs()
	local npcs = {}
	for _, npc in pairs(self) do
		if npc.NPCID then
			table.insert(npcs, npc)
		end
	end
	return npcs
end

-- Obtener NPCs por rol
function NPCDatabase:GetNPCsByRole(role)
	local npcs = {}
	for _, npc in pairs(self) do
		if npc.Role == role then
			table.insert(npcs, npc)
		end
	end
	return npcs
end

-- Interacción con NPC
function NPCDatabase:Interact(npcID, context)
	local npc = self[npcID]
	if not npc then return "NPC no encontrado" end
	
	npc.LastSpoken = os.time()
	
	return {
		Name = npc.Name,
		Role = npc.Role,
		Dialogue = self:GetDialogue(npcID, context),
		Location = npc.Location,
	}
end

NPCDialogues.NPCDatabase = NPCDatabase
NPCDialogues.GuardDialogues = GuardDialogues
NPCDialogues.ScientistDialogues = ScientistDialogues
NPCDialogues.DoctorDialogues = DoctorDialogues
NPCDialogues.ExecutiveDialogues = ExecutiveDialogues

return NPCDialogues
