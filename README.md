# 🔐 AADI - Advanced Anomaly Development Institute

**Sistema completo SCP-style para Roblox con 500 anomalías, economía de A-Credits, tarjetas inteligentes, tienda de armas y progresión desbloqueada.**

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Lua](https://img.shields.io/badge/language-Lua-purple)
![Roblox](https://img.shields.io/badge/platform-Roblox-brightgreen)
![Status](https://img.shields.io/badge/status-OPERATIONAL-success)
![License](https://img.shields.io/badge/license-Open%20Source-green)

---

## 📚 Tabla de Contenidos

- [Características](#-características)
- [Instalación Rápida](#-instalación-rápida)
- [Uso Rápido](#-uso-rápido)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Sistema de Anomalías](#-sistema-de-anomalías)
- [Sistema de Acceso](#-sistema-de-acceso)
- [Tienda de Armas](#-tienda-de-armas)
- [Empleados y Roles](#-empleados-y-roles)
- [NPCs y Diálogos](#-npcs-y-diálogos)
- [Ejemplos](#-ejemplos)
- [Configuración](#-configuración)
- [Troubleshooting](#-troubleshooting)
- [Créditos](#-créditos)

---

## 🎮 Características

### ✅ 500 Anomalías AADI
- **Nivel 0**: AADI-001 a AADI-099 (Acceso inicial)
- **Nivel 1**: AADI-100 a AADI-199 (Explorando)
- **Nivel 2**: AADI-200 a AADI-299 (Investigando)
- **Nivel 3**: AADI-300 a AADI-399 (Profundizando)
- **Nivel 4**: AADI-400 a AADI-499 (Peligroso)
- **Nivel 5**: AADI-500 (ABISMO - máximo secreto)

Cada anomalía tiene:
- Descripción SCP-style detallada
- Nivel de peligro (1-10)
- Nivel de acceso requerido (0-5)
- Sistema de estudio y progresión

### 💰 Sistema Económico de A-Credits
- 💸 Gana dinero estudiando anomalías (50 + 5 por minuto)
- 💵 Completa misiones para bonificaciones
- 💴 Trabaja como empleado con salarios (100-500 A-Credits/día)
- 🛒 Compra armas, equipos y medicinas

### 🔐 Sistema de Tarjetas de Acceso Inteligentes
- 6 niveles de acceso (0-5)
- Escaneo automático en puertas
- Registro completo de acceso y historial
- Roles: Visitor, Scientist, Guard, Doctor, Executive, Director

### 🚪 Puertas Inteligentes de Seguridad
- 18 puertas predefinidas en la base
- Sistema de bloqueo de emergencia
- Auto-cierre configurable (10 segundos)
- Registro de acceso detallado por puerta

### 🛒 Tienda de Armas Completa
- **30+ artículos** en 6 categorías
- Pistolas (100-500 A-Credits)
- Rifles (300-1000 A-Credits)
- Escopetas (250-400 A-Credits)
- Explosivos (30-200 A-Credits)
- Equipos Médicos (75-1000 A-Credits)
- Equipos Tácticos (300-800 A-Credits)

### 👥 Sistema de Empleados
- 6 roles diferentes con beneficios únicos
- Sistema de salarios configurable
- Control de turnos (Clock In/Out)
- Sistema de salud y daño

### 📈 Sistema de Desbloqueo Progresivo
- 6 niveles de desbloqueo
- Puntos de investigación (estudio de anomalías)
- Misiones con recompensas
- Barra de progreso visual

### 🗣️ NPCs con Diálogos SCP-style
- 10 NPCs predefinidos
- Diálogos dinámicos y contextuales
- Roles: Guard, Scientist, Doctor, Executive
- Sistema de humores y situaciones

---

## 🚀 Instalación Rápida

### 1. Descargar
Descarga todos los archivos de la carpeta `.rblx/`:

```
✓ AnomaliesDatabase.lua
✓ AccessCardSystem.lua
✓ DoorSystem.lua
✓ WeaponShop.lua
✓ EmployeeSystem.lua
✓ UnlockSystem.lua
✓ NPCDialogues.lua
✓ Config.lua
✓ main.lua
```

### 2. Copiar a Roblox Studio

1. Abre **Roblox Studio**
2. Crea nuevo proyecto o abre uno existente
3. Ve a **ServerScriptService** (Explorer → game → ServerScriptService)
4. Copia los 9 archivos `.lua` en **cualquier orden**

### 3. Ejecutar

El sistema se inicializa automáticamente cuando se carga `main.lua`.

Abre la consola (**View → Output**) y verás:

```
🔐 AADI - ADVANCED ANOMALY DEVELOPMENT INSTITUTE 🔐
Sistema de seguridad iniciando...

[✅] Base de datos de anomalías cargada
[✅] Red de puertas inteligentes activada
[✅] NPCs de AADI en línea
[✅] Sistema listo para operaciones

📊 ESTADÍSTICAS DEL SISTEMA:
   • Total de anomalías: 500
   • Nivel 0: 10 anomalías
   • Nivel 1: 10 anomalías
   [...]

✅ AADI COMPLETAMENTE OPERATIVO
```

---

## 💡 Uso Rápido

### Registrar Nuevo Jugador
```lua
local AADI = require(game.ServerScriptService:WaitForChild("main"))

AADI:RegisterNewPlayer("Juan_Guardia", "Guard", 3)
```

### Intentar Acceso a Puerta
```lua
local success, message = AADI:AttemptDoorAccess("Juan_Guardia", "DOOR-200-A")
print(message)
```

### Estudiar Anomalía
```lua
AADI:StudyAnomaly("Juan_Guardia", 1, 15)  -- ID 1, 15 minutos
```

### Obtener Información del Jugador
```lua
local info = AADI:GetPlayerInfo("Juan_Guardia")
print("Nivel: " .. info.Progress.CurrentLevel)
print("Progreso: " .. info.Progress.ProgressPercentage .. "%")
```

### Comprar en la Tienda
```lua
local bought, msg = AADI:BuyWeapon("Juan_Guardia", "WRIF-001", 1000)
print(msg)
```

### Activar Modo Emergencia
```lua
AADI:EmergencyLockdown()  -- Bloquea todas las puertas
```

---

## 📁 Estructura del Proyecto

```
AADI-Roblox/
├── README.md (este archivo)
├── .rblx/
│   ├── main.lua ⭐ Script principal (EJECUTAR PRIMERO)
│   ├── AnomaliesDatabase.lua (500 anomalías)
│   ├── AccessCardSystem.lua (Tarjetas de acceso)
│   ├── DoorSystem.lua (Puertas inteligentes)
│   ├── WeaponShop.lua (Tienda con 30+ armas)
│   ├── EmployeeSystem.lua (Roles y empleados)
│   ├── UnlockSystem.lua (Desbloqueo progresivo)
│   ├── NPCDialogues.lua (NPCs SCP-style)
│   ├── Config.lua (Configuración personalizable)
│   ├── INSTALLATION_GUIDE.lua (Guía completa)
│   └── README.md (Documentación en carpeta)
```

---

## 🎯 Sistema de Anomalías

### Estructura de Anomalía
```lua
{
    ID = 1,
    Name = "AADI-001",
    Description = "Esfera de metal magnetizada que atrae objetos ferrosos",
    DangerLevel = 4,      -- 1-10
    AccessLevel = 1,      -- 0-5
    Location = "SCP-AADI-000",
    Unlocked = false,
    StudyPoints = 0
}
```

### Anomalías Destacadas

| ID | Nombre | Peligro | Acceso | Descripción |
|---|---|---|---|---|
| AADI-001 | Esfera Magnética | 4 | 1 | Atrae metal a velocidad |
| AADI-007 | Reloj Congelador | 9 | 3 | Congela tiempo en radio |
| AADI-100 | Estatua Móvil | 6 | 2 | Se mueve sin observación |
| AADI-203 | Fluido Reescritor | 10 | 4 | Reescribe realidad |
| AADI-300 | Consciencia Colectiva | 10 | 5 | Se expande infinitamente |
| AADI-500 | ██████ ACCESO DENEGADO ██████ | 10 | 5 | ABISMO ABSOLUTO |

### Cómo Estudiar
```lua
-- Estudiar AADI-1 durante 15 minutos
local success, msg = player:StudyAnomaly(1, 15)

-- Gana: 50 puntos base + (5 × 15 minutos) = 125 puntos
```

---

## 🔐 Sistema de Acceso

### Niveles de Acceso

| Nivel | Rol | Salario | Beneficios |
|---|---|---|---|
| 0 | Visitor | 0 A-Credits | Acceso básico |
| 1 | Scientist | 150 | LabAccess, ResearchBonus |
| 2 | Guard | 200 | WeaponAccess, Armor+20 |
| 3 | Doctor | 180 | MedicalAccess, Healing+30 |
| 4 | Executive | 300 | FullLabAccess, AllWeapons |
| 5 | Director | 500 | CompleteAccess, LockdownCommand |

### Funciones de Tarjeta
```lua
local card = AccessCardSystem.new("NombreJugador", 3, "Guard")

card:HasAccessToLevel(2)        -- Verificar acceso
card:LogScan("SCP-AADI-200", true)  -- Registrar escaneo
card:GetScanHistory()           -- Ver historial
card:SetAccessLevel(4)          -- Cambiar nivel
card:Deactivate()               -- Desactivar tarjeta
```

---

## 🛒 Tienda de Armas

### Categorías y Precios

**Pistolas**
- Pistola Estándar (100 A-Credits) - Daño: 25
- Pistola Magnética (250 A-Credits) - Daño: 40
- Pistola Plasma (500 A-Credits) - Daño: 60

**Rifles**
- Rifle M4A1 (300 A-Credits) - Daño: 45
- Rifle Francotirador (450 A-Credits) - Daño: 80
- Rifle Electromagnético (1000 A-Credits) - Daño: 120

**Equipos Médicos**
- Botiquín (75 A-Credits) - Cura: 25HP
- Inyector Nanobots (500 A-Credits) - Cura: 150HP
- Estasis Emergencia (1000 A-Credits) - Previene muerte

**Equipos**
- Chaleco Antibalas (300 A-Credits) - Armadura: +20%
- Escudo Energético (800 A-Credits) - HP: 100
- Botas Propulsión (500 A-Credits) - Salto: +2x

### Cómo Comprar
```lua
local cart = WeaponShop.Shop:CreateCart("NombreJugador")
cart:AddItem("WRIF-001", 1)     -- Agregar rifle
cart:AddItem("WMED-001", 2)     -- Agregar medicinas

local success, msg, receipt = WeaponShop.Shop:ProcessPayment(
    "NombreJugador", 
    cart, 
    1000  -- A-Credits disponibles
)

if success then
    print("✅ Compra completada: " .. receipt.ReceiptID)
end
```

---

## 👥 Empleados y Roles

### Crear Empleado
```lua
local emp = EmployeeSystem.EmployeeDatabase:HireEmployee(
    "NombreJugador", 
    "Guard",    -- Rol
    3           -- Nivel de acceso
)

emp:SetRole("Scientist")        -- Cambiar rol
emp:ClockIn()                   -- Marcar entrada
emp:ClockOut()                  -- Marcar salida
emp:ClaimSalary()               -- Cobrar salario
emp:Heal(50)                    -- Curar daño
emp:TakeDamage(25)              -- Recibir daño
```

### Beneficios por Rol
- **Guard**: Armas avanzadas, armadura, daño aumentado
- **Scientist**: Laboratorios, bonificación investigación
- **Doctor**: Médicos, curación mejorada, revivir cercanos
- **Executive**: Acceso casi completo, comandos especiales
- **Director**: Acceso total, modo emergencia

---

## 🗣️ NPCs y Diálogos

### NPCs Disponibles

**Guardias** (Seguridad)
- Sargento Rodriguez (SCP-AADI-000)
- Oficial Chen (SCP-AADI-200)
- Soldado Marcus (SCP-AADI-400)

**Científicos** (Investigación)
- Dr. Helena Kross (SCP-AADI-300)
- Prof. Yuki Tanaka (SCP-AADI-300)
- Dr. Marcus Webb (SCP-AADI-300)

**Médicos** (Clínica)
- Dra. Sarah Mitchell (SCP-AADI-100)
- Dr. James Peterson (SCP-AADI-100)

**Ejecutivos** (Administración)
- Director General Vladmir (SCP-AADI-000)
- Supervisor Thomas (SCP-AADI-200)

### Interactuar con NPCs
```lua
local npcDB = NPCDialogues.NPCDatabase
npcDB:InitializeAADINPCs()

local response = npcDB:Interact("NPC-GUARD-001", "Alert")
print(response.Name .. ": " .. response.Dialogue)
-- Output: Sargento Rodriguez: 🚨 ¡INTRUSIÓN DETECTADA!
```

### Contextos de Diálogo
- `Greeting` - Saludo inicial
- `Alert` - Situación de peligro
- `Research` - Información técnica
- `Casual` - Conversación relajada
- `Warning` - Advertencia crítica
- `Quest` - Misión/tarea

---

## 📚 Ejemplos

### Ejemplo 1: Sistema Completo de Jugador
```lua
local AADI = require(game.ServerScriptService:WaitForChild("main"))

-- Registrar científico
AADI:RegisterNewPlayer("Dr_Helena", "Scientist", 2)

-- Obtener información
local info = AADI:GetPlayerInfo("Dr_Helena")
print("Tarjeta: " .. info.Card.CardID)
print("Rol: " .. info.Employee.Role)
print("Nivel: " .. info.Progress.CurrentLevel)
```

### Ejemplo 2: Sistema de Progresión
```lua
local UnlockSys = require(game.ServerScriptService:WaitForChild("UnlockSystem"))
local player = UnlockSys.UnlockDatabase:GetPlayer("Dr_Helena")

-- Estudiar múltiples anomalías
for i = 1, 5 do
    player:StudyAnomaly(i, 20)
end

-- Ver progreso
local progress = player:GetProgress()
print(player:GetProgressBar())  -- Barra visual
```

### Ejemplo 3: Emergencia
```lua
local AADI = require(game.ServerScriptService:WaitForChild("main"))
AADI:EmergencyLockdown()  -- Bloquea todas las puertas
```

---

## ⚙️ Configuración

### Personalizar Sistema
Edita `Config.lua`:

```lua
Config.Economy.StartingCredits = 1000
Config.Doors.AutoCloseTime = 10
Config.Server.Difficulty = "Hard"

-- Aplicar dificultad
Config:ApplyDifficultyPreset("Hard")
```

### Presets de Dificultad
- **Easy**: 0.5x daño, 2x salud, 1.5x recompensas
- **Normal**: Valores base 1.0x
- **Hard**: 1.5x daño, 0.8x salud, 1.3x recompensas
- **Extreme**: 2.0x daño, 0.6x salud, 2.0x recompensas

---

## 🔧 Troubleshooting

| Problema | Solución |
|---|---|
| "Module not found" | Verifica que todos los 9 archivos están en ServerScriptService |
| Las puertas no abren | Verifica el nivel de acceso de la tarjeta |
| Los NPCs no hablan | Ejecuta: `NPCDialogues.NPCDatabase:InitializeAADINPCs()` |
| No puedo comprar | Verifica que tienes suficientes A-Credits |
| Script no se ejecuta | Asegúrate de que `main.lua` está al final |

Para más ayuda, ver `INSTALLATION_GUIDE.lua` en `.rblx/`

---

## 📊 Estadísticas

```lua
-- Ver estadísticas globales
local stats = AADI:GenerateSecurityReport()

print("Total jugadores: " .. stats.TotalPlayers)
print("Total empleados: " .. stats.TotalEmployees)
print("Total puertas: " .. stats.TotalDoors)
print("A-Credits totales: " .. stats.GlobalStats.TotalCreditsEarned)
```

---

## 📝 Licencia

Este proyecto es de **código abierto**. Úsalo, modifícalo y distribúyelo libremente.

---

## 👨‍💻 Autor

**javiercid-dev** - Creado el 18 de julio de 2026

---

## 🙏 Créditos

Inspirado en la **SCP Foundation** - Un proyecto de ficción colaborativa.

---

## ✨ Características Futuras

- [ ] Sistema de misiones dinámicas
- [ ] Eventos aleatorios
- [ ] Sistema de combate
- [ ] Interfaz gráfica (GUI)
- [ ] Guardado persistente (DataStore)
- [ ] Multijugador sincronizado
- [ ] Más anomalías (hasta 1000)
- [ ] Sistema de logros

---

## 📞 Soporte

¿Preguntas o problemas?

- 📖 Lee `INSTALLATION_GUIDE.lua` en `.rblx/`
- 🐛 Reporta bugs en [GitHub Issues](https://github.com/javiercid-dev/AADI-Roblox/issues)
- 💬 Contacta al autor

---

<div align="center">

**[⬆ Volver arriba](#-aadi---advanced-anomaly-development-institute)**

### 🔐 AADI está completamente operativo 🔐

*"En AADI, la realidad es solo una sugerencia"*

---

![AADI Banner](https://img.shields.io/badge/AADI%201.0.0-OPERATIONAL-brightgreen?style=for-the-badge)

</div>
