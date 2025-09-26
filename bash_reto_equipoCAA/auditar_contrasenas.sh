echo "=== AUDITORÍA CON HASHES ==="

#cambiar las contraseñas a formato MD5
echo "Convirtiendo hashes a formato MD5..."
while IFS=: read -r usuario contrasena; do
    echo "Actualizando $usuario..."
    echo "$usuario:$contrasena" | sudo chpasswd -c MD5
done < usuarios.txt

sleep 2

#combinar archivos
sudo unshadow /etc/passwd /etc/shadow > combined.txt

#verificar que ahora son hashes MD5
echo "=== VERIFICACIÓN HASHES ==="
head -n 3 combined.txt

#ejecutar John con formato MD5
sudo john --format=md5crypt --wordlist=/usr/share/wordlists/rockyou.txt combined.txt --max-run-time=30

#generar reporte
echo "Usuario | Estado de contraseña" > reporte_contrasenas.txt
echo "----------------------" >> reporte_contrasenas.txt

sudo john --show combined.txt | cut -d: -f1 > debiles.txt 2>/dev/null

while IFS=: read -r usuario contrasena; do
    if grep -q "^$usuario$" debiles.txt 2>/dev/null; then
        echo "$usuario | Debil" >> reporte_contrasenas.txt
    else
        echo "$usuario | Fuerte" >> reporte_contrasenas.txt
    fi
done < usuarios.txt

#limpiar
sudo rm -f combined.txt debiles.txt

echo "=== REPORTE FINAL ==="
cat reporte_contrasenas.txt