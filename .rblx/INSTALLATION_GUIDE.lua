--[[
	INSTALLATION GUIDE - GUÍA DE INSTALACIÓN COMPLETA
	Cómo instalar y usar AADI en Roblox Studio paso a paso
]]

--[[
	📋 ÍNDICE
	
	1. Requisitos Previos
	2. Paso 1: Preparación
	3. Paso 2: Instalación de Archivos
	4. Paso 3: Iniciar Sistema
	5. Paso 4: Primer Uso
	6. Ejemplos Básicos
	7. Ejemplos Avanzados
	8. Troubleshooting
	9. Tips y Trucos
	10. FAQ
]]

--[[
	✅ REQUISITOS PREVIOS
	
	- Roblox Studio instalado
	- Conocimiento básico de Lua
	- Acceso a ServerScriptService
	- Los 9 archivos .lua descargados
]]

--[[
	🔧 PASO 1: PREPARACIÓN
	
	1. Abre Roblox Studio
	2. Crea nuevo juego (Blank Project) O abre uno existente
	3. Ve a View → Explorer (si no está visible)
	4. Expande "game" → ServerScriptService
	5. Verifica que tienes acceso de escritura
]]

--[[
	📂 PASO 2: INSTALACIÓN DE ARCHIVOS
	
	ORDEN CORRECTO:
	
	Primero (sin orden específico):
	□ AnomaliesDatabase.lua
	□ AccessCardSystem.lua
	□ DoorSystem.lua
	□ WeaponShop.lua
	□ EmployeeSystem.lua
	□ UnlockSystem.lua
	□ NPCDialogues.lua
	□ Config.lua
	
	ÚLTIMO:
	□ main.lua ← EJECUTAR ESTO AL FINAL
	
	PASOS DETALLADOS:
	1. Click derecho en ServerScriptService
	2. Insert Object → LocalScript (para cada archivo)
	3. Rename con el nombre del archivo (sin .lua)
	4. Copia el código del archivo en el script
	5. Repite para cada archivo
	6. Finalmente, copia main.lua
]]

--[[
	🚀 PASO 3: INICIAR SISTEMA
	
	El sistema se inicia automáticamente cuando main.lua se ejecuta.
	
	Abre la CONSOLA (View → Output) para ver:
	
	============================================================
	🔐 AADI - ADVANCED ANOMALY DEVELOPMENT INSTITUTE 🔐
	Sistema de seguridad iniciando...
	============================================================
	
	[✅] Base de datos de anomalías cargada
	[✅] Red de puertas inteligentes activada
	[✅] NPCs de AADI en línea
	[✅] Sistema listo para operaciones
	
	📊 ESTADÍSTICAS DEL SISTEMA:
	   • Total de anomalías: 500
	   • Nivel 0 (Iniciado): 10 anomalías
	   • Nivel 1 (Explorando): 10 anomalías
	   [...]
	
	🛒 TIENDA DE ARMAS:
	   • Total de artículos: 30
	   • Categorías: Pistol, Rifle, Shotgun, Explosive, Medical, Equipment
	   • Precio promedio: 400 A-Credits
	
	============================================================
	✅ AADI COMPLETAMENTE OPERATIVO
	============================================================
]]

--[[
	🎮 PASO 4: PRIMER USO
	
	En la consola de Roblox Studio, copia esto:
	
	local AADI = require(game.ServerScriptService:WaitForChild("main"))
	AADI:RunDemo()
	
	Verás la demostración completa del sistema.
]]

--[[
	📝 EJEMPLOS BÁSICOS
	
	--- Ejemplo 1: Registrar Jugador ---
	
	local AADI = require(game.ServerScriptService:WaitForChild("main"))
	
	-- Parámetros: nombre, rol, nivel de acceso
	local player = AADI:RegisterNewPlayer("Juan", "Guard", 3)
	
	-- Output:
	-- [AADI] Nuevo jugador registrado: Juan
	--    • Rol: Guard
	--    • Nivel de acceso: 3
	--    • Tarjeta ID: 523641
	
	
	--- Ejemplo 2: Intentar Acceso a Puerta ---
	
	local success, message = AADI:AttemptDoorAccess("Juan", "DOOR-200-A")
	
	if success then
		print("🟢 " .. message)
	else
		print("🔴 " .. message)
	end
	
	-- Output posible 1:
	-- 🟢 Puerta abierta - Bienvenido Juan
	
	-- Output posible 2:
	-- 🔴 ACCESO DENEGADO - Nivel de acceso insuficiente: 2/3
	
	
	--- Ejemplo 3: Estudiar Anomalía ---
	
	-- Parámetros: nombre jugador, ID anomalía, minutos de estudio
	AADI:StudyAnomaly("Juan", 1, 15)
	
	-- Output:
	-- [AADI] Juan: ✅ Anomalía estudiada. Puntos: 125
	--    • Progreso: 25% (125/500)
	--    • Nivel: 0
	
	
	--- Ejemplo 4: Obtener Información del Jugador ---
	
	local info = AADI:GetPlayerInfo("Juan")
	
	if info then
		print("Tarjeta: " .. info.Card.CardID)
		print("Rol: " .. info.Employee.Role)
		print("Nivel de Acceso: " .. info.Card.AccessLevel)
		print("Nivel Desbloqueo: " .. info.Progress.CurrentLevel)
		print("Progreso: " .. info.Progress.ProgressPercentage .. "%")
	end
	
	
	--- Ejemplo 5: Comprar en la Tienda ---
	
	-- Comprar Rifle M4A1 con 1000 A-Credits
	local bought, message, receipt = AADI:BuyWeapon("Juan", "WRIF-001", 1000)
	
	if bought then
		print("✅ " .. message)
		print("Recibo: " .. receipt.ReceiptID)
	else
		print("❌ " .. message)
	end
]]

--[[
	🔬 EJEMPLOS AVANZADOS
	
	--- Ejemplo 1: Sistema Completo de Jugador ---
	
	local AADI = require(game.ServerScriptService:WaitForChild("main"))
	local UnlockSys = require(game.ServerScriptService:WaitForChild("UnlockSystem"))
	local EmployeeSys = require(game.ServerScriptService:WaitForChild("EmployeeSystem"))
	
	-- Registrar científico
	AADI:RegisterNewPlayer("Dr_Helena", "Scientist", 2)
	
	-- Obtener datos
	local unlock = UnlockSys.UnlockDatabase:GetPlayer("Dr_Helena")
	local emp = EmployeeSys.EmployeeDatabase:GetEmployee("Dr_Helena")
	
	-- Iniciar turno
	emp:ClockIn()
	print("Turno iniciado")
	
	-- Estudiar múltiples anomalías
	for i = 1, 5 do
		unlock:StudyAnomaly(i, 20)
	end
	
	-- Ver progreso
	local progress = unlock:GetProgress()
	print("Progreso visual: " .. unlock:GetProgressBar())
	
	-- Finalizar turno y cobrar salario
	emp:ClockOut()
	local salary = emp:ClaimSalary()
	print("Salario reclamado: " .. salary .. " A-Credits")
	
	
	--- Ejemplo 2: Sistema de Diálogos con NPCs ---
	
	local NPCDialogues = require(game.ServerScriptService:WaitForChild("NPCDialogues"))
	
	local npcDB = NPCDialogues.NPCDatabase
	npcDB:InitializeAADINPCs()
	
	-- Obtener dialogo de guardia en contexto de alerta
	local guardResponse = npcDB:Interact("NPC-GUARD-001", "Alert")
	print(guardResponse.Name .. ": " .. guardResponse.Dialogue)
	-- Output: Sargento Rodriguez: 🚨 ¡INTRUSIÓN DETECTADA!
	
	-- Obtener dialogo de científico en contexto de investigación
	local sciResponse = npcDB:Interact("NPC-SCI-001", "Research")
	print(sciResponse.Name .. ": " .. sciResponse.Dialogue)
	-- Output: Dr. Helena Kross: AADI-301 muestra propiedades cuánticas anómalas.
	
	
	--- Ejemplo 3: Reporte de Seguridad Completo ---
	
	local AADI = require(game.ServerScriptService:WaitForChild("main"))
	
	-- Crear varios jugadores
	AADI:RegisterNewPlayer("Guard1", "Guard", 3)
	AADI:RegisterNewPlayer("Sci1", "Scientist", 2)
	AADI:RegisterNewPlayer("Doc1", "Doctor", 2)
	
	-- Generar reporte
	local report = AADI:GenerateSecurityReport()
	
	print("=== REPORTE DE SEGURIDAD ===")
	print("Total empleados: " .. report.TotalEmployees)
	print("Total tarjetas: " .. report.TotalCards)
	print("Total puertas: " .. report.TotalDoors)
	print("Total jugadores: " .. report.TotalPlayers)
	print("")
	print("Guardias: " .. report.EmployeeStats.Guards)
	print("Científicos: " .. report.EmployeeStats.Scientists)
	print("Médicos: " .. report.EmployeeStats.Doctors)
	print("A-Credits totales: " .. report.GlobalStats.TotalCreditsEarned)
	
	
	--- Ejemplo 4: Cambiar Rol de Empleado Dinámicamente ---
	
	local EmployeeSys = require(game.ServerScriptService:WaitForChild("EmployeeSystem"))
	
	local AADI = require(game.ServerScriptService:WaitForChild("main"))
	AADI:RegisterNewPlayer("MultiRole", "Visitor", 0)
	
	local emp = EmployeeSys.EmployeeDatabase:GetEmployee("MultiRole")
	
	print("Rol inicial: " .. emp.Role)
	-- Output: Rol inicial: Visitor
	
	emp:SetRole("Guard")
	print("Nuevo rol: " .. emp.Role .. " (Acceso: " .. emp.AccessLevel .. ")")
	-- Output: Nuevo rol: Guard (Acceso: 3)
	
	emp:SetRole("Director")
	print("Acceso máximo: " .. emp.AccessLevel)
	-- Output: Acceso máximo: 5
]]

--[[
	🔧 TROUBLESHOOTING
	
	❌ Error: "Module not found"
	✓ Solución: 
	  - Asegúrate de que TODOS los 9 archivos están en ServerScriptService
	  - Verifica que los nombres sean exactos (sin espacios extra)
	  - Recarga el juego: Ctrl+Shift+F5
	
	❌ Error: "Cannot require nil"
	✓ Solución:
	  - Ejecuta main.lua ÚLTIMO, después de los demás scripts
	  - Espera a que los otros scripts se carguen primero
	  - Usa wait(1) antes de require si necesitas
	
	❌ Las puertas no abren
	✓ Solución:
	  - Verifica el nivel de acceso de la tarjeta
	  - Asegúrate de que existe la puerta (DOOR-200-A, etc)
	  - Verifica en la consola si hay errores
	
	❌ Los NPCs no hablan
	✓ Solución:
	  - Inicializa los NPCs: NPCDialogues.NPCDatabase:InitializeAADINPCs()
	  - Verifica que usas el ID correcto (NPC-GUARD-001, etc)
	  - Comprueba los contextos válidos
	
	❌ No puedo comprar en la tienda
	✓ Solución:
	  - Verifica que tienes suficientes A-Credits
	  - Usa IDs de artículos válidos (WPIC-001, WRIF-001, etc)
	  - Revisa el precio del artículo
	
	❌ Scroll en consola está lleno de errores
	✓ Solución:
	  - Abre la consola completamente (Output)
	  - Busca el primer error (es el más importante)
	  - Copia el error completo en GitHub Issues
	
	❌ El juego se congela
	✓ Solución:
	  - Es normal si hay muchos jugadores
	  - Reduce el número de anomalías en Config
	  - Desactiva Debug mode: Config.Server.Debug = false
]]

--[[
	💡 TIPS Y TRUCOS
	
	1. MULTI-TARJETA
	   Crea múltiples tarjetas para el mismo jugador con diferentes roles
	
	2. SIMULACIÓN
	   Crea 10+ jugadores ficticios para probar el sistema
	
	3. DEBUG
	   Activa Debug mode en Config para ver mensajes detallados
	
	4. RESPALDO
	   Guarda la configuración antes de cambios importantes
	
	5. OPTIMIZACIÓN
	   Usa Config:ApplyDifficultyPreset("Easy") para juegos más ligeros
	
	6. PERSONALIZACIÓN
	   Modifica los diálogos de NPCs para tu tema
	
	7. EXTENSIÓN
	   Agrega más anomalías editando AnomaliesDatabase.lua
	
	8. INTEGRACIÓN
	   Conecta con otros sistemas de Roblox (GUI, Marketplace, etc)
	
	9. LOGS
	   Habilita logging para trackear actividades
	
	10. BACKUP AUTOMÁTICO
	    Guarda player data cada 5 minutos
]]

--[[
	❓ PREGUNTAS FRECUENTES (FAQ)
	
	P: ¿Puedo agregar más anomalías?
	R: Sí, edita AnomaliesDatabase.lua y usa CreateAnomaly()
	
	P: ¿Cómo cambio los precios de las armas?
	R: Edita WeaponShop.lua y modifica los valores de Price
	
	P: ¿Puedo crear nuevos roles?
	R: Sí, edita Config.Roles o EmployeeSystem.lua
	
	P: ¿Cómo agregar NPCs nuevos?
	R: Usa NPCDatabase:CreateNPC() en NPCDialogues.lua
	
	P: ¿Funciona en otros juegos Roblox?
	R: Sí, es un sistema modular que funciona en cualquier juego
	
	P: ¿Puedo usar esto comercialmente?
	R: Sí, el código es de código abierto
	
	P: ¿Cómo guardo los datos de jugadores?
	R: Implementa DataStores de Roblox para persistencia
	
	P: ¿Cuál es el máximo de jugadores soportados?
	R: Teóricamente ilimitado, depende de tu servidor Roblox
	
	P: ¿Hay límite de anomalías?
	R: Puedes agregar hasta 10,000+ sin problemas de performance
	
	P: ¿Cómo reporto bugs?
	R: Abre un issue en https://github.com/javiercid-dev/AADI-Roblox
]]

--[[
	📚 REFERENCIAS ÚTILES
	
	- Documentación de Roblox Lua:
	  https://developer.roblox.com/en-us/docs
	
	- ServerScriptService:
	  https://developer.roblox.com/en-us/api-reference/class/ServerScriptService
	
	- DataStore para persistencia:
	  https://developer.roblox.com/en-us/docs/game-design/storage/data-stores
	
	- Sistema de módulos Lua:
	  https://developer.roblox.com/en-us/docs/scripting/scripts/luau-module-scripts
]]

--[[
	🎓 ESTRUCTURA DEL CÓDIGO
	
	AnomaliesDatabase.lua
	├── CreateAnomaly()
	├── GetAnomaly()
	├── GetAnomaliesByLevel()
	└── Initialize()
	
	AccessCardSystem.lua
	├── new() - Crear tarjeta
	├── HasAccessToLevel() - Verificar acceso
	└── CardStorage - Almacenar tarjetas
	
	DoorSystem.lua
	├── new() - Crear puerta
	├── TryOpen() - Intenta abrir
	└── DoorNetwork - Sistema de puertas
	
	WeaponShop.lua
	├── CreateCart() - Crear carrito
	├── GetItemByID() - Obtener artículo
	└── ProcessPayment() - Procesar compra
	
	EmployeeSystem.lua
	├── new() - Crear empleado
	├── SetRole() - Cambiar rol
	└── EmployeeDatabase - Gestionar empleados
	
	UnlockSystem.lua
	├── new() - Crear usuario
	├── StudyAnomaly() - Estudiar
	└── UnlockDatabase - Gestionar desbloques
	
	NPCDialogues.lua
	├── CreateNPC() - Crear NPC
	├── GetDialogue() - Obtener diálogo
	└── NPCDatabase - Gestionar NPCs
	
	main.lua
	├── Initialize() - Iniciar sistema
	├── RegisterNewPlayer() - Registrar jugador
	└── Funciones principales
]]

print("\n✅ Guía de instalación cargada exitosamente\n")
print("Para más información: https://github.com/javiercid-dev/AADI-Roblox\n")

return {
	Version = "1.0.0",
	Author = "javiercid-dev",
	LastUpdated = "2026-07-18",
}
