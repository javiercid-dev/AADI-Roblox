--[[
	BASE FÍSICA DE AADI - GENERADOR AUTOMÁTICO
	Este script genera la estructura completa de AADI en Roblox
	Crea sectores, puertas, anomalías y ambientación
	
	⚠️ INSTALACIÓN: Copia este script en ServerScriptService
	El script auto-genera todo al ejecutarse
]]

local BaseGenerator = {}

-- Configuración de materiales
local Materials = {
	METAL = Enum.Material.Metal,
	CONCRETE = Enum.Material.Concrete,
	NEON = Enum.Material.Neon,
	GLASS = Enum.Material.Glass,
	PLASTIC = Enum.Material.Plastic,
}

-- Colores de AADI
local Colors = {
	DARK_GRAY = Color3.fromRGB(50, 50, 50),
	LIGHT_GRAY = Color3.fromRGB(150, 150, 150),
	RED = Color3.fromRGB(255, 0, 0),
	BLUE = Color3.fromRGB(0, 100, 255),
	WHITE = Color3.fromRGB(255, 255, 255),
	BLACK = Color3.fromRGB(0, 0, 0),
	NEON_RED = Color3.fromRGB(255, 0, 0),
	NEON_BLUE = Color3.fromRGB(0, 100, 255),
}

-- Crear parte básica
local function CreatePart(name, size, material, color, transparency, position, parent)
	local part = Instance.new("Part")
	part.Name = name
	part.Shape = Enum.PartType.Block
	part.Material = material
	part.Color = color
	part.Transparency = transparency or 0
	part.Size = size
	part.Position = position
	part.CanCollide = true
	part.Parent = parent or workspace
	return part
end

-- Crear puerta
local function CreateDoor(name, size, position, parent)
	local door = Instance.new("Part")
	door.Name = name
	door.Shape = Enum.PartType.Block
	door.Material = Materials.METAL
	door.Color = Colors.DARK_GRAY
	door.Size = size
	door.Position = position
	door.CanCollide = true
	door.Parent = parent
	
	-- Líneas rojas en la puerta
	local lines = Instance.new("Part")
	lines.Name = "DoorLines"
	lines.Material = Materials.NEON
	lines.Color = Colors.NEON_RED
	lines.Size = Vector3.new(size.X - 0.5, 0.2, 0.1)
	lines.Position = position + Vector3.new(0, 0, 0.5)
	lines.CanCollide = false
	lines.Parent = door
	
	return door
end

-- Crear pared
local function CreateWall(name, size, position, parent)
	local wall = CreatePart(name, size, Materials.CONCRETE, Colors.DARK_GRAY, 0, position, parent)
	return wall
end

-- Crear piso
local function CreateFloor(name, size, position, parent)
	local floor = CreatePart(name, size, Materials.CONCRETE, Colors.LIGHT_GRAY, 0, position, parent)
	return floor
end

-- Crear techo
local function CreateCeiling(name, size, position, parent)
	local ceiling = CreatePart(name, size, Materials.METAL, Colors.DARK_GRAY, 0, position, parent)
	
	-- Agregar luces
	local light = Instance.new("Part")
	light.Name = "CeilingLight"
	light.Material = Materials.NEON
	light.Color = Colors.NEON_BLUE
	light.Shape = Enum.PartType.Ball
	light.Size = Vector3.new(1, 1, 1)
	light.CanCollide = false
	light.Parent = ceiling
	
	local pointLight = Instance.new("PointLight")
	pointLight.Color = Colors.NEON_BLUE
	pointLight.Brightness = 2
	pointLight.Range = 30
	pointLight.Parent = light
	
	return ceiling
end

-- Crear sector
local function CreateSector(sectorName, sectorNumber, positionX, positionZ, parent)
	print("[BASE GENERATOR] Creando sector: " .. sectorName .. " (" .. sectorNumber .. ")")
	
	local sector = Instance.new("Folder")
	sector.Name = sectorName
	sector.Parent = parent
	
	local baseY = sectorNumber * 50
	
	-- Piso del sector (100x100)
	CreateFloor(
		sectorName .. "_Floor",
		Vector3.new(100, 2, 100),
		Vector3.new(positionX, baseY, positionZ),
		sector
	)
	
	-- Techo del sector
	CreateCeiling(
		sectorName .. "_Ceiling",
		Vector3.new(100, 2, 100),
		Vector3.new(positionX, baseY + 50, positionZ),
		sector
	)
	
	-- Paredes (4 paredes)
	-- Pared frontal
	CreateWall(
		sectorName .. "_WallFront",
		Vector3.new(100, 50, 2),
		Vector3.new(positionX, baseY + 25, positionZ - 50),
		sector
	)
	
	-- Pared trasera
	CreateWall(
		sectorName .. "_WallBack",
		Vector3.new(100, 50, 2),
		Vector3.new(positionX, baseY + 25, positionZ + 50),
		sector
	)
	
	-- Pared izquierda
	CreateWall(
		sectorName .. "_WallLeft",
		Vector3.new(2, 50, 100),
		Vector3.new(positionX - 50, baseY + 25, positionZ),
		sector
	)
	
	-- Pared derecha
	CreateWall(
		sectorName .. "_WallRight",
		Vector3.new(2, 50, 100),
		Vector3.new(positionX + 50, baseY + 25, positionZ),
		sector
	)
	
	-- Puerta de entrada
	CreateDoor(
		sectorName .. "_Door",
		Vector3.new(6, 10, 1),
		Vector3.new(positionX - 20, baseY + 5, positionZ - 50),
		sector
	)
	
	-- Puerta de salida
	CreateDoor(
		sectorName .. "_ExitDoor",
		Vector3.new(6, 10, 1),
		Vector3.new(positionX + 20, baseY + 5, positionZ + 50),
		sector
	)
	
	-- Pilares de soporte
	for i = 1, 4 do
		local pillarX = positionX + (i % 2 == 0 and 30 or -30)
		local pillarZ = positionZ + (i > 2 and 30 or -30)
		CreatePart(
			sectorName .. "_Pillar_" .. i,
			Vector3.new(3, 50, 3),
			Materials.METAL,
			Colors.DARK_GRAY,
			0,
			Vector3.new(pillarX, baseY + 25, pillarZ),
			sector
		)
	end
	
	return sector
end

-- Crear sala blanca del VOID
local function CreateVoidRoom(parent)
	print("[BASE GENERATOR] Creando sala blanca del VOID...")
	
	local voidRoom = Instance.new("Folder")
	voidRoom.Name = "SCP-AADI-500-WHITE-VOID"
	voidRoom.Parent = parent
	
	local baseY = 350 -- Muy abajo, separado
	
	-- Piso blanco infinito
	local voidFloor = CreatePart(
		"VoidFloor",
		Vector3.new(200, 2, 200),
		Materials.NEON,
		Colors.WHITE,
		0,
		Vector3.new(0, baseY, 0),
		voidRoom
	)
	
	-- Techo blanco
	local voidCeiling = CreatePart(
		"VoidCeiling",
		Vector3.new(200, 2, 200),
		Materials.NEON,
		Colors.WHITE,
		0,
		Vector3.new(0, baseY + 100, 0),
		voidRoom
	)
	
	-- Paredes blancas
	for i = 1, 4 do
		local wallX = (i % 2 == 0) and 100 or -100
		local wallZ = (i > 2) and 100 or -100
		
		if i <= 2 then
			CreateWall(
				"VoidWall_" .. i,
				Vector3.new(200, 100, 2),
				Vector3.new(0, baseY + 50, wallZ),
				voidRoom
			)
		else
			CreateWall(
				"VoidWall_" .. i,
				Vector3.new(2, 100, 200),
				Vector3.new(wallX, baseY + 50, 0),
				voidRoom
			)
		end
	end
	
	-- Luces blancas anómalas
	for i = 1, 10 do
		local light = Instance.new("Part")
		light.Name = "VoidLight_" .. i
		light.Material = Materials.NEON
		light.Color = Colors.WHITE
		light.Shape = Enum.PartType.Ball
		light.Size = Vector3.new(3, 3, 3)
		light.CanCollide = false
		light.Position = Vector3.new(
			math.random(-80, 80),
			baseY + math.random(30, 80),
			math.random(-80, 80)
		)
		light.Parent = voidRoom
		
		-- Luz puntual
		local pointLight = Instance.new("PointLight")
		pointLight.Color = Colors.WHITE
		pointLight.Brightness = 5
		pointLight.Range = 50
		pointLight.Parent = light
	end
	
	-- Señal de peligro (rojo parpadeante)
	local warningLight = Instance.new("Part")
	warningLight.Name = "VoidWarning"
	warningLight.Material = Materials.NEON
	warningLight.Color = Colors.NEON_RED
	warningLight.Shape = Enum.PartType.Cylinder
	warningLight.Size = Vector3.new(2, 5, 2)
	warningLight.Position = Vector3.new(0, baseY + 50, 0)
	warningLight.CanCollide = false
	warningLight.Parent = voidRoom
	
	-- Script para efecto parpadeante
	local warningScript = Instance.new("LocalScript")
	warningScript.Source = [[
		local part = script.Parent
		while true do
			part.Color = Color3.fromRGB(255, 0, 0)
			wait(0.5)
			part.Color = Color3.fromRGB(100, 0, 0)
			wait(0.5)
		end
	]]
	warningScript.Parent = warningLight
	
	return voidRoom
end

-- Crear celda de anomalía
local function CreateAnomalyCell(anomalyID, anomalyName, sectorParent, posX, posY, posZ)
	local cell = Instance.new("Folder")
	cell.Name = anomalyName
	cell.Parent = sectorParent
	
	-- Caja de contención
	local containmentBox = CreatePart(
		anomalyName .. "_Container",
		Vector3.new(15, 15, 15),
		Materials.GLASS,
		Colors.BLUE,
		0.3,
		Vector3.new(posX, posY, posZ),
		cell
	)
	
	-- Líneas de seguridad (rojo)
	local securityLines = CreatePart(
		anomalyName .. "_SecurityLines",
		Vector3.new(15, 0.5, 0.5),
		Materials.NEON,
		Colors.NEON_RED,
		0,
		Vector3.new(posX, posY + 7, posZ),
		cell
	)
	
	-- Placa de identificación
	local plaque = CreatePart(
		anomalyName .. "_Plaque",
		Vector3.new(12, 2, 1),
		Materials.METAL,
		Colors.DARK_GRAY,
		0,
		Vector3.new(posX, posY - 8, posZ),
		cell
	)
	
	return cell
end

-- GENERADOR PRINCIPAL
function BaseGenerator:GenerateCompleteBase()
	print("\n" .. string.rep("█", 70))
	print("█" .. string.rep(" ", 68) .. "█")
	print("█  🔐 GENERANDO BASE FÍSICA GIGANTESCA DE AADI 🔐               █")
	print("█" .. string.rep(" ", 68) .. "█")
	print(string.rep("█", 70) .. "\n")
	
	-- Crear carpeta raíz
	local AADIBase = Instance.new("Folder")
	AADIBase.Name = "AADI-BASE-PHYSICAL"
	AADIBase.Parent = workspace
	
	-- SECTOR 0 - ENTRADA (Recepción)
	local sector0 = CreateSector(
		"SCP-AADI-000-ENTRADA",
		0,
		0,
		0,
		AADIBase
	)
	
	-- SECTOR 100 - Personal Civil & Oficinas
	local sector100 = CreateSector(
		"SCP-AADI-100-PERSONAL",
		1,
		150,
		0,
		AADIBase
	)
	
	-- Crear oficinas dentro del sector
	for i = 1, 5 do
		local office = Instance.new("Folder")
		office.Name = "Office_" .. i
		office.Parent = sector100
		
		CreateWall(
			"Office_" .. i .. "_Wall1",
			Vector3.new(20, 15, 2),
			Vector3.new(150 - 20 * i, 25 + (i * 5), -20),
			office
		)
	end
	
	-- SECTOR 200 - Zonas de Armamiento
	local sector200 = CreateSector(
		"SCP-AADI-200-ARMAMENTO",
		2,
		300,
		0,
		AADIBase
	)
	
	-- Armería (cajas de armas)
	for i = 1, 8 do
		CreatePart(
			"WeaponCrate_" .. i,
			Vector3.new(8, 8, 8),
			Materials.METAL,
			Colors.DARK_GRAY,
			0,
			Vector3.new(300 + (i * 10), 60, i % 2 == 0 and 20 or -20),
			sector200
		)
	end
	
	-- SECTOR 300 - Laboratorios Científicos
	local sector300 = CreateSector(
		"SCP-AADI-300-LABORATORIOS",
		3,
		450,
		0,
		AADIBase
	)
	
	-- Laboratorios de investigación
	for i = 1, 6 do
		local lab = Instance.new("Folder")
		lab.Name = "Laboratory_" .. i
		lab.Parent = sector300
		
		-- Meseta de trabajo
		CreatePart(
			"LabTable_" .. i,
			Vector3.new(15, 1, 10),
			Materials.METAL,
			Colors.LIGHT_GRAY,
			0,
			Vector3.new(450 + (i * 20), 85 + (i % 3) * 5, -30 + (i % 2) * 30),
			lab
		)
	end
	
	-- SECTOR 400 - Celdas de Contención
	local sector400 = CreateSector(
		"SCP-AADI-400-CONTENCION",
		4,
		600,
		0,
		AADIBase
	)
	
	-- Crear celdas de anomalías en sector 400
	print("[BASE GENERATOR] Creando celdas de contención...")
	for i = 1, 10 do
		CreateAnomalyCell(
			i,
			"AADI-" .. string.format("%03d", i),
			sector400,
			600 + (i % 5) * 20,
			110 + math.floor(i / 5) * 30,
			(i % 2 == 0) and 20 or -20
		)
	end
	
	-- SECTOR 500 - LA SALA BLANCA DEL VOID
	local voidSector = CreateVoidRoom(AADIBase)
	
	-- Camino hacia el VOID (pasillo terrorífico)
	print("[BASE GENERATOR] Creando pasillo hacia el VOID...")
	for i = 1, 10 do
		CreateWall(
			"VoidPath_Wall_" .. i,
			Vector3.new(10, 20, 2),
			Vector3.new(600 + (i * 15), 200 + (i * 5), 0),
			AADIBase
		)
	end
	
	-- Puerta de entrada al VOID (muy especial)
	local voidDoor = CreateDoor(
		"VoidDoor",
		Vector3.new(8, 15, 1),
		Vector3.new(750, 250, 0),
		AADIBase
	)
	voidDoor.Material = Materials.NEON
	voidDoor.Color = Colors.BLACK
	
	-- Luces de advertencia
	for i = 1, 5 do
		local warning = Instance.new("Part")
		warning.Name = "VoidWarningLight_" .. i
		warning.Material = Materials.NEON
		warning.Color = Colors.NEON_RED
		warning.Shape = Enum.PartType.Ball
		warning.Size = Vector3.new(1, 1, 1)
		warning.CanCollide = false
		warning.Position = Vector3.new(750 + (i * 10), 260 + (i * 5), math.random(-20, 20))
		warning.Parent = AADIBase
		
		local light = Instance.new("PointLight")
		light.Color = Colors.NEON_RED
		light.Brightness = 3
		light.Range = 25
		light.Parent = warning
	end
	
	print("[BASE GENERATOR] ✅ Base física generada exitosamente")
	print("[BASE GENERATOR] Total de sectores: 5 + 1 (VOID)")
	print("[BASE GENERATOR] Estructura completa en workspace.AADI-BASE-PHYSICAL")
	
	print("\n" .. string.rep("█", 70))
	print("█" .. string.rep(" ", 68) .. "█")
	print("█  ✅ AADI ESTÁ COMPLETAMENTE CONSTRUIDA 🔐                    █")
	print("█                                                                  █")
	print("█  Sectores:                                                      █")
	print("█  • SCP-AADI-000 (Entrada)                                      █")
	print("█  • SCP-AADI-100 (Personal)                                     █")
	print("█  • SCP-AADI-200 (Armamento)                                    █")
	print("█  • SCP-AADI-300 (Laboratorios)                                 █")
	print("█  • SCP-AADI-400 (Contención)                                   █")
	print("█  • SCP-AADI-500 (LA SALA BLANCA DEL VOID) ⚪                  █")
	print("█                                                                  █")
	print(string.rep("█", 70) .. "\n")
	
	return AADIBase
end

-- EJECUTAR GENERADOR
BaseGenerator:GenerateCompleteBase()

return BaseGenerator
