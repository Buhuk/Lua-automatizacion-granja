-- Configuración de la descarga
local args = {...}

if args < 1 then
    print("Uso: fgit <URL del archivo> [nombre del archivo destino (opcional)]")
    return
end

local url = args[1]
local nombreArchivoDestino = args[2] or url:match("^.+/(.+)$") -- Extrae el nombre del archivo de la URL si no se proporciona uno

-- Definimos las cabeceras personalizadas que tú quieras
local misCabeceras = {
    --["Authorization"] = "Bearer tu_token_secreto_aqui",
    --["User-Agent"] = "ComputerCraft-Computer-" .. os.computerID(),
    ["Accept"] = "application/vnd.github.raw+json" -- Útil para la API de GitHub
}

-- Creamos la estructura de opciones para la petición HTTP
local opciones = {
    url = url,
    headers = misCabeceras
}

print("Enviando petición con cabeceras personalizadas...")

-- Realizamos la petición
local respuesta = http.get(opciones)

if respuesta then
    local contenido = respuesta.readAll()
    respuesta.close()
    
    -- Guardamos el archivo descargado en el disco de Minecraft
    local archivo = fs.open(nombreArchivoDestino, "w")
    archivo.write(contenido)
    archivo.close()
    
    print("- ".. nombreArchivoDestino)
else
    print("Error: El servidor rechazó la petición o la URL es incorrecta.")
end