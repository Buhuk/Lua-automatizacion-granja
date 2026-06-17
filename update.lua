-- Contenido de update.lua
local usuario = "Buhuk"
local repo = "Lua-automatizacion-granja"
local rama = "main"

-- Lista de todos los archivos de tu proyecto modular
local archivos = {
    "main.lua",
    "config.lua",
    "Nido.lua",
    "interfaz.lua",
    "calibracion.lua"
}

-- Definimos las cabeceras personalizadas que tú quieras
local misCabeceras = {
    --["Authorization"] = "Bearer tu_token_secreto_aqui",
    --["User-Agent"] = "ComputerCraft-Computer-" .. os.computerID(),
    ["Accept"] = "application/vnd.github.raw+json" -- Útil para la API de GitHub
}

print("Actualizando proyecto desde GitHub...")

for _, nombreItem in ipairs(archivos) do
    --local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", usuario, repo, rama, nombreItem)
    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s", usuario, repo, nombreItem)
    
    -- Si el archivo ya existe en el juego, lo borramos para actualizarlo
    if fs.exists(nombreItem) then
        fs.delete(nombreItem)
    end

    -- Creamos la estructura de opciones para la petición HTTP
    local opciones = {
        url = url,
        headers = misCabeceras
    }

    local respuesta = http.get(opciones)
    if respuesta then
        local contenido = respuesta.readAll()
        respuesta.close()
        
        local file = fs.open(nombreItem, "w")
        file.write(contenido)
        file.close()

        print("- ".. nombreItem)
    else
        print("Error al descargar " .. nombreItem)
    end
end

print("¡Proyecto actualizado con éxito!")