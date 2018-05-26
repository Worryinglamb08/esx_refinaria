Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale = 'br'

Config.Zones = {

	Mina = {
		Pos   = {x = 492.26, y = 2964.60, z = 41.22},
		Size  = {x = 5.0, y = 5.0, z = 1.0},
		Color = {r = 22, g = 33, b = 4},
		Name  = "Coleta de Petroleo",
		Type  = 1
	},

	TratamentoEtanol = {
		Pos   = {x = 2759.65, y = 1498.88, z = 29.79},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 158, g = 213, b = 232},
		Name  = "Tratamento de Etanol",
		Type  = 1
	},

	TratamentoDiesel = {
		Pos   = {x = 2768.52, y = 1531.55, z = 29.79},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 214, g = 152, b = 178},
		Name  = "Tratamento de Diesel",
		Type  = 1
	},
	
	
	TratamentoGasolina = {
		Pos   = {x = 2777.23, y = 1564.25, z = 29.79},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 136, g = 184, b = 61},
		Name  = "Tratamento de Gasolina",
		Type  = 1
	},
	
	Venda = {
		Pos   = {x = 580.37, y = -2805.25, z = 5.05},
		Size  = {x = 2.5, y = 2.5, z = 0.5},
		Color = {r = 229, g = 0, b = 0},
		Name  = "Venda dos Produtos",
		Type  = 1
	},
-- OK --
	RefinariaAcoes = { 
		Pos   = {x = 558.02, y = -2327.77, z = 4.82},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 62, g = 108, b = 62},
		Name  = "Acoes do Chefe",
		Type  = 0
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 563.54, y = -2322.94, z = 5.88},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 62, g = 108, b = 62},
		Name  = "Garagem",
		Type  = 39
	},

	VehicleSpawnPoint = {
		Pos   = {x = 574.86, y = -2326.49, z = 5.50},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 140, g = 0, b = 255},
		Name  = "Ponto Spawn",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = 546.47, y = -2305.27, z = 5.88},
		Size  = {x = 3.0, y = 3.0, z = 2.0},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Guardar Veiculo",
		Type  = 39
	}

}

