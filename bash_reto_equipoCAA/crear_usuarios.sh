echo "===CREANDO USUARIOS==="

while IFS=: read -r usuario contrasena; do
    #crear el usuario
    sudo useradd -m -s /bin/bash "$usuario"
    
    #asignar la contraseña
    echo "$usuario:$contrasena" | sudo chpasswd
    
    echo "Usuario creado: $usuario"
done < usuarios.txt

echo "===USUARIOS CREADOS==="
