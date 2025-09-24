@{

	#NewModuleManifest = '.\AuditoriaBasica.psm1' 

	RootModule = 'AuditoriaBasica.psm1'  

	ModuleVersion = '1.0.0' 

	Author = 'Equipo de Ciberseguridad'

	Description = 'Módulo para auditoría básica de usuarios y servicios'

	PowerShellVersion = '5.1' 

	FunctionsToExport = @(

        	'Obtener-UsuariosInactivos',

        	'Obtener-ServiciosExternos'

	)
}