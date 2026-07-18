--[[
	EMPLOYEE SYSTEM
	Sistema de empleados con diferentes roles: Científico, Guardia, Médico
	Cada rol tiene beneficios, salarios y habilidades especiales
]]

local EmployeeSystem = {}
EmployeeSystem.__index = EmployeeSystem

-- Crear un empleado
function EmployeeSystem.new(playerName, role, accessLevel)
	local self = setmetatable({}, EmployeeSystem)
	
	self.PlayerName = playerName
	self.Role = role or "Visitor" -- Visitor, Scientist, Guard, Doctor, Executive
	self.AccessLevel = accessLevel or 0
	self.EmployeeID = math.random(1000, 9999)
	self.HireDate = os.time()
	self.Salary = 0 -- A-Credits por día
	self.CurrentHealth = 100
	self.MaxHealth = 100
	self.Inventory = {}
	self.WorkHours = 0
	self.TotalEarnings = 0
	self.IsOnDuty = false
	
	-- Configurar rol
	self:SetRole(role)
	
	return self
end

-- Establecer rol y beneficios
function EmployeeSystem:SetRole(newRole)
	local roleConfigs = {
		Visitor = {
			AccessLevel = 0,
			Salary = 0,
			MaxHealth = 80,
			Benefits = {},
			Description = "Visitante básico"
		},
		Scientist = {
			AccessLevel = 2,
			Salary = 150,
			MaxHealth = 100,
			Benefits = {"LabAccess", "ResearchBonus", "StudyAcceleration"},
			Description = "Investigador científico de AADI"
		},
		Guard = {
			AccessLevel = 3,
			Salary = 200,
			MaxHealth = 150,
			Benefits = {"WeaponAccess", "HigherDamage", "Armor+20"},
			Description = "Personal de seguridad de AADI"
		},
		Doctor = {
			AccessLevel = 2,
			Salary = 180,
			MaxHealth = 120,
			Benefits = {"MedicalAccess", "Healing+30", "ReviveNearby"},
			Description = "Personal médico de AADI"
		},
		Executive = {
			AccessLevel = 4,
			Salary = 300,
			MaxHealth = 130,
			Benefits = {"FullLabAccess", "AllWeapons", "DirectorCommands"},
			Description = "Ejecutivo de AADI"
		},
		Director = {
			AccessLevel = 5,
			Salary = 500,
			MaxHealth = 150,
			Benefits = {"CompleteAccess", "LockdownCommand", "AdminPanel"},
			Description = "Director General de AADI"
		}
	}
	
	if roleConfigs[newRole] then
		local config = roleConfigs[newRole]
		self.Role = newRole
		self.AccessLevel = config.AccessLevel
		self.Salary = config.Salary
		self.MaxHealth = config.MaxHealth
		self.CurrentHealth = config.MaxHealth
		self.Benefits = config.Benefits
		self.RoleDescription = config.Description
		return true
	end
	
	return false
end

-- Clcular salario diario
function EmployeeSystem:ClaimSalary()
	if self.IsOnDuty then
		local earned = self.Salary
		self.TotalEarnings = self.TotalEarnings + earned
		return earned, "Salario reclamado: " .. earned .. " A-Credits"
	else
		return 0, "No estás en turno"
	end
end

-- Marcar entrada/salida
function EmployeeSystem:ClockIn()
	self.IsOnDuty = true
	self.WorkHours = self.WorkHours + 1
	return true, "✅ Entrada registrada - Turno iniciado"
end

function EmployeeSystem:ClockOut()
	self.IsOnDuty = false
	return true, "❌ Salida registrada - Turno finalizado"
end

-- Sistema de salud
function EmployeeSystem:TakeDamage(damage)
	self.CurrentHealth = math.max(0, self.CurrentHealth - damage)
	if self.CurrentHealth == 0 then
		return "💀 Has muerto"
	else
		return "Salud: " .. self.CurrentHealth .. "/" .. self.MaxHealth
	end
end

function EmployeeSystem:Heal(amount)
	self.CurrentHealth = math.min(self.MaxHealth, self.CurrentHealth + amount)
	return "❤️ Curación aplicada - Salud: " .. self.CurrentHealth .. "/" .. self.MaxHealth
end

-- Obtener información del empleado
function EmployeeSystem:GetInfo()
	return {
		PlayerName = self.PlayerName,
		EmployeeID = self.EmployeeID,
		Role = self.Role,
		RoleDescription = self.RoleDescription,
		AccessLevel = self.AccessLevel,
		Salary = self.Salary,
		CurrentHealth = self.CurrentHealth,
		MaxHealth = self.MaxHealth,
		WorkHours = self.WorkHours,
		TotalEarnings = self.TotalEarnings,
		IsOnDuty = self.IsOnDuty,
		HireDate = self.HireDate,
		Benefits = self.Benefits,
	}
end

-- Obtener beneficios
function EmployeeSystem:HasBenefit(benefit)
	if not self.Benefits then return false end
	for _, b in ipairs(self.Benefits) do
		if b == benefit then return true end
	end
	return false
end

-- Sistema de empleados en la base
local EmployeeDatabase = {}

function EmployeeDatabase:HireEmployee(playerName, role, accessLevel)
	local employee = EmployeeSystem.new(playerName, role, accessLevel)
	self[playerName] = employee
	print("[AADI] Empleado contratado: " .. playerName .. " (" .. role .. ")")
	return employee
end

function EmployeeDatabase:GetEmployee(playerName)
	return self[playerName]
end

function EmployeeDatabase:FireEmployee(playerName)
	local employee = self[playerName]
	if employee then
		self[playerName] = nil
		print("[AADI] Empleado despedido: " .. playerName)
		return true
	end
	return false
end

function EmployeeDatabase:GetAllEmployees()
	local employees = {}
	for _, emp in pairs(self) do
		table.insert(employees, emp)
	end
	return employees
end

function EmployeeDatabase:GetEmployeesByRole(role)
	local employees = {}
	for _, emp in pairs(self) do
		if emp.Role == role then
			table.insert(employees, emp)
		end
	end
	return employees
end

function EmployeeDatabase:GetPayroll()
	local total = 0
	for _, emp in pairs(self) do
		total = total + emp.Salary
	end
	return total
end

-- Estadísticas
function EmployeeDatabase:GetStats()
	local all = self:GetAllEmployees()
	local stats = {
		TotalEmployees = #all,
		Scientists = #self:GetEmployeesByRole("Scientist"),
		Guards = #self:GetEmployeesByRole("Guard"),
		Doctors = #self:GetEmployeesByRole("Doctor"),
		Executives = #self:GetEmployeesByRole("Executive"),
		Directors = #self:GetEmployeesByRole("Director"),
		TotalPayroll = self:GetPayroll(),
	}
	return stats
end

EmployeeSystem.EmployeeDatabase = EmployeeDatabase

return EmployeeSystem
