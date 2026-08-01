# 🔌 AADI - SISTEMA DE PLUGINS

Documentación completa de todos los plugins disponibles para AADI.

---

## 📚 Índice de Plugins

1. [CombatSystem](#-combat-system)
2. [MissionSystem](#-mission-system)
3. [EventSystem](#-event-system)
4. [AchievementSystem](#-achievement-system)
5. [BasePhysicalGenerator](#-base-physical-generator)

---

## ⚔️ Combat System

**Archivo:** `.rblx/Plugins/CombatSystem.lua`

### Descripción
Sistema completo de combate PvP/PvE con daño, armadura, armas y registro de combate.

### Funciones Principales

```lua
local Combat = require(game.ServerScriptService:WaitForChild("CombatSystem"))

-- Crear combatiente
local player1 = Combat.new("Juan", 100, 25)

-- Equipar arma
player1:EquipWeapon("WRIF-001", 45, "Rifle M4A1")

-- Equipar armadura
player1:EquipArmor(20, "Chaleco Antibalas")

-- Recibir daño
player1:TakeDamage("Enemy", 30)

-- Atacar
local success, msg = player1:Attack(player2, false)

-- Curar
player1:Heal(50)

-- Obtener estadísticas
local stats = player1:GetCombatStats()
```

### Estadísticas de Combate

```lua
{
    PlayerName = "Juan",
    Health = 85,
    MaxHealth = 100,
    Armor = 20,
    CurrentWeapon = {...},
    IsInCombat = true,
    Kills = 5,
    Deaths = 2,
    KDRatio = 2.5,
    CombatLogEntries = 15,
}
```

### Simulación de Batalla

```lua
local winner, finalHealth = Combat.CombatDatabase:SimulateBattle("Juan", "Pedro")
-- Output: Juan gana la batalla con 35 HP restantes
```

---

## 🎯 Mission System

**Archivo:** `.rblx/Plugins/MissionSystem.lua`

### Descripción
Sistema de misiones dinámicas temáticas de AADI con 30+ misiones, dificultades variables y recompensas.

### Funciones Principales

```lua
local Missions = require(game.ServerScriptService:WaitForChild("MissionSystem"))

-- Crear datos de jugador
local playerData = Missions:CreatePlayerMissions("Juan")

-- Asignar misión
local success, msg = Missions:AssignMission(playerData, 1)
-- Output: ✅ Misión asignada: Bienvenida a AADI

-- Avanzar progreso
Missions:ProgressMission(playerData, 1, 25)

-- Completar misión
local success, msg = Missions:CompleteMission(playerData, 1)
-- Output: 🎉 ¡MISIÓN COMPLETADA!

-- Fallar misión
Missions:FailMission(playerData, 1, "Jugador derrotado")

-- Obtener misiones por dificultad
local hardMissions = Missions:GetMissionsByDifficulty("Hard")

-- Listar todas las misiones disponibles
local availableMissions = Missions:ListAllMissions()

-- Obtener estadísticas del jugador
local stats = Missions:GetPlayerStats(playerData)
```

### Tipos de Misiones

| Tipo | Descripción |
|---|---|
| Investigación | Estudiar anomalías |
| Contención | Contener brotes |
| Investigación profunda | Análisis avanzado |
| Escolta | Proteger personal |
| Defensa | Defender el complejo |
| Exploración | Explorar sectores |
| Recuperación | Recuperar datos |

### Dificultades

- **Easy** - 250-500 A-Credits
- **Normal** - 800-1500 A-Credits
- **Hard** - 2000-3500 A-Credits
- **Extreme** - 5000-10000 A-Credits

---

## 🚨 Event System

**Archivo:** `.rblx/Plugins/EventSystem.lua`

### Descripción
Sistema de eventos dinámicos que genera eventos aleatorios y críticos en AADI.

### Funciones Principales

```lua
local Events = require(game.ServerScriptService:WaitForChild("EventSystem"))

-- Inicializar
Events:Initialize()

-- Disparar evento aleatorio
local success, msg = Events:TriggerRandomEvent()

-- Disparar evento específico
local success, msg = Events:TriggerEvent(10)
-- Output: 🟡 EVENTO DETECTADO: Lectura anómala detectada

-- Obtener eventos activos
local activeEvents = Events:GetActiveEvents()

-- Obtener eventos por severidad
local criticalEvents = Events:GetEventsBySeverity(Events.Severity.CRITICAL)

-- Obtener eventos por tipo
local warningEvents = Events:GetEventsByType("Advertencia")

-- Resolver evento
Events:ResolveEvent(10, "Anomalía contenida")

-- Obtener estadísticas
local stats = Events:GetEventStats()
```

### Tipos de Eventos

| Tipo | Severidad | Probabilidad |
|---|---|---|
| Rutinario | Baja | 80% |
| Advertencia | Media | 40% |
| Crítico | Alta | 15% |
| Catastrófico | Crítica | 2% |

### Eventos Especiales

- **Cambio de turno** - Personal rotativo
- **Mantenimiento de puertas** - Sistemas inoperantes
- **Brote de contención** - Anomalía escapando
- **PROTOCOLO ROJO** - Colapso total
- **EL VOID DESPERTANDO** - Apocalipsis ⚪

---

## 🏆 Achievement System

**Archivo:** `.rblx/Plugins/AchievementSystem.lua`

### Descripción
Sistema de logros con 30+ objetivos, puntos de logro y títulos desbloqueables.

### Funciones Principales

```lua
local Achievements = require(game.ServerScriptService:WaitForChild("AchievementSystem"))

-- Crear datos de logros del jugador
local playerAchievements = Achievements:CreatePlayerAchievements("Juan")

-- Desbloquear logro
local success, msg = Achievements:UnlockAchievement(playerAchievements, 1)
-- Output: 🏆 ¡LOGRO DESBLOQUEADO! Nuevo Recluta

-- Obtener información de logro
local achievement = Achievements:GetAchievement(5)

-- Obtener logros por categoría
local rankAchievements = Achievements:GetAchievementsByCategory("Rango")

-- Obtener progreso del jugador
local progress = Achievements:GetPlayerProgress(playerAchievements)
-- Output: 25% completado, 150 puntos acumulados

-- Obtener estadísticas globales
local stats = Achievements:GetGlobalStats()

-- Ver tabla de clasificación
local leaderboard = Achievements:ShowLeaderboard({playerAchievements}, 10)
```

### Categorías de Logros

- 🏅 **Rango** - 6 logros (Recluta → Director)
- ⚔️ **Combate** - 6 logros (Primera sangre → Invencible)
- 🔬 **Investigación** - 5 logros (Primer descubrimiento → Maestro científico)
- 💰 **Riqueza** - 4 logros (Primer A-Credit → Magnate)
- 🗺️ **Exploración** - 3 logros (Primer paso → Cartógrafo)
- 💪 **Supervivencia** - 4 logros (Primer turno → Fénix)
- 👑 **Liderazgo** - 3 logros (Mentor → General)
- 🔐 **Secretos** - 3 logros (El elegido → La verdad final)

### Títulos Especiales

```
Recluta → Guardia → Científico → Médico → 
Ejecutivo → Director → Maestro → Invencible → 
Millonario → Explorador → Cartógrafo → Mentor → 
Comandante → General → Elegido → Guardián → 
Iluminado (Máximo)
```

---

## 🏗️ Base Physical Generator

**Archivo:** `.rblx/BasePhysicalGenerator.lua`

### Descripción
Script que auto-genera la estructura completa y gigantesca de AADI en Roblox.

### Instalación

1. Copia `BasePhysicalGenerator.lua` a `ServerScriptService`
2. El script se ejecuta automáticamente
3. Genera toda la base en `workspace.AADI-BASE-PHYSICAL`

### Estructura Generada

```
AADI-BASE-PHYSICAL/
├── SCP-AADI-000-ENTRADA
│   ├── Piso (100x100)
│   ├── Techo con luces
│   ├── 4 Paredes de concreto
│   ├── 2 Puertas de seguridad
│   └── 4 Pilares de soporte
│
├── SCP-AADI-100-PERSONAL
│   ├── Oficinas (5 unidades)
│   └── Áreas de descanso
│
├── SCP-AADI-200-ARMAMENTO
│   └── Armería (8 cajas de armas)
│
├── SCP-AADI-300-LABORATORIOS
│   └── Laboratorios (6 unidades con mesas de trabajo)
│
├── SCP-AADI-400-CONTENCION
│   ├── 10 Celdas de anomalías
│   └── Sistemas de seguridad
│
└── SCP-AADI-500-WHITE-VOID ⚪
    ├── Sala blanca infinita
    ├── 10 Luces blancas anómalas
    ├── Luz de advertencia roja parpadeante
    └── Pasillo de acceso (terrorífico)
```

### Especificaciones

| Sector | Tamaño | Altura | Propósito |
|---|---|---|---|
| AADI-000 | 100x100 | 50 | Entrada principal |
| AADI-100 | 100x100 | 50 | Personal y oficinas |
| AADI-200 | 100x100 | 50 | Armería |
| AADI-300 | 100x100 | 50 | Laboratorios |
| AADI-400 | 100x100 | 50 | Contención |
| AADI-500 | 200x200 | 100 | LA SALA BLANCA |

### Materiales y Colores

- **Piso/Techo:** Concreto gris oscuro
- **Paredes:** Concreto gris oscuro
- **Pilares:** Metal gris oscuro
- **Puertas:** Metal con líneas rojo neón
- **Celdas:** Vidrio azul translúcido
- **Luces:** Neón azul
- **Sala Blanca:** Neón blanco puro
- **Advertencias:** Rojo neón parpadeante

### Funciones Principales

```lua
local BaseGen = require(game.ServerScriptService:WaitForChild("BasePhysicalGenerator"))

-- La base se genera automáticamente al cargar el script
-- Para acceder a ella:
local AADIBase = workspace:FindFirstChild("AADI-BASE-PHYSICAL")

-- Acceder a sectores específicos
local entrance = AADIBase:FindFirstChild("SCP-AADI-000-ENTRADA")
local void = AADIBase:FindFirstChild("SCP-AADI-500-WHITE-VOID")
```

---

## 📊 Tabla de Estadísticas Completas

```lua
-- COMBATE
Kills: 0-∞
Deaths: 0-∞
K/D Ratio: Variable
Health: 0-100+
Armor: 0-100%

-- MISIONES
Active Missions: 0-10
Completed: 0-∞
Failed: 0-∞
Success Rate: 0-100%
Total Rewards: 0-∞ A-Credits

-- EVENTOS
Active Events: 0-10
Total Triggered: 0-∞
Event History: 0-∞
Routine: 8
Warning: 5
Critical: 5
Catastrophic: 4

-- LOGROS
Unlocked: 0-30
Total Points: 0-∞
Categories: 8
Titles: 16
```

---

## 🔗 Integración con Sistema Principal

Todos los plugins se integran automáticamente con `main.lua`:

```lua
local AADI = require(game.ServerScriptService:WaitForChild("main"))

-- Sistema de combate integrado
AADI:EnableCombatSystem()

-- Sistema de misiones integrado
AADI:EnableMissionSystem()

-- Sistema de eventos integrado
AADI:EnableEventSystem()

-- Sistema de logros integrado
AADI:EnableAchievementSystem()

-- Generar base física
AADI:GenerateBasePhysical()
```

---

## 🎮 Uso Completo (Ejemplo)

```lua
local AADI = require(game.ServerScriptService:WaitForChild("main"))

-- 1. Registrar jugador
AADI:RegisterNewPlayer("Juan", "Guard", 3)

-- 2. Generar base física
AADI:GenerateBasePhysical()

-- 3. Iniciar misión
local missions = AADI:GetMissionSystem()
local playerData = missions:CreatePlayerMissions("Juan")
missions:AssignMission(playerData, 10)

-- 4. Iniciar combate
local combat = AADI:GetCombatSystem()
local player = combat.CombatDatabase:RegisterCombatant("Juan", 100, 25)
player:EquipWeapon("WRIF-001", 45, "Rifle M4A1")

-- 5. Disparar evento
local events = AADI:GetEventSystem()
events:TriggerRandomEvent()

-- 6. Desbloquear logro
local achievements = AADI:GetAchievementSystem()
local achievements_data = achievements:CreatePlayerAchievements("Juan")
achievements:UnlockAchievement(achievements_data, 1)
```

---

## 🚀 Características Futuras

- [ ] Integración con DataStores
- [ ] Interfaz GUI completa
- [ ] Sistema de multijugador en tiempo real
- [ ] Física realista de anomalías
- [ ] Más de 100 anomalías adicionales
- [ ] Sistema de meteorología
- [ ] Inteligencia artificial de NPCs
- [ ] Sistema de facciones

---

## 📞 Soporte

Para más información o reportar problemas:
👉 https://github.com/javiercid-dev/AADI-Roblox/issues

---

**Creado por javiercid-dev** 🔐✨
