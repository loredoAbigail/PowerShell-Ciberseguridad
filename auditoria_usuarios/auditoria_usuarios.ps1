#SCRIPT EVIDENCIA 9

#Con el Get-LocalUser buscamos la lista de los usuarios locales en el sistema y lo guardamos en la variable $usuarios.
$usuarios = Get-LocalUser
#En esta nueva variable "$sinLogon" guardamos los usuarios que no han iniciado sesion en el sistema.
$sinLogon = @()
#En la variable "$conLogon" guardamos los usuarios que han iniciado sesión.
$conLogon = @()
#Aquí para cada usuario en el sisema.
foreach ($u in $usuarios) {
#Si el usuario no se encuentra en los ultimos inicios de sesion.
    if (-not $u.LastLogon) {
#en la variable sinLogon se guarda el nombre de usuario si nunca había entrado, y NUNCA como predeterminado en ultimo acceso.
        $sinLogon += "$($u.Name): Estado = $($u.Enabled), Ultimo acceso = NUNCA"
    } else {
#el usuario se guarda en conLogon si ya había inciado sesion.
        $conLogon += "$($u.Name): Estado = $($u.Enabled), Ultimo acceso = $($u.LastLogon)"
    }
}

# Guardamos cada variable en un archivo .txt diferente.
$sinLogon | Out-File -FilePath "$env:USERPROFILE\Desktop\usuarios_sin_logon.txt"
$conLogon | Out-File -FilePath "$env:USERPROFILE\Desktop\usuarios_con_logon.txt"

# Mostramos el contenido de las variables.
Write-Output "`n Usuarios que NUNCA han iniciado sesion:"
$sinLogon | ForEach-Object { Write-Output $_ }
Write-Output "`n Usuarios que SI han iniciado sesion:"
$conLogon | ForEach-Object { Write-Output $_ }