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

local download_links = {}

-- Definimos las cabeceras personalizadas que tú quieras
local misCabeceras = {
    --["Authorization"] = "Bearer tu_token_secreto_aqui",
    --["User-Agent"] = "ComputerCraft-Computer-" .. os.computerID(),
    ["Accept"] = "application/vnd.github+json" -- Útil para la API de GitHub
}

print("Actualizando proyecto desde GitHub...")

for _, nombreItem in ipairs(archivos) do
    --local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", usuario, repo, rama, nombreItem)
    local api_url = string.format("https://api.github.com/repos/%s/%s/contents/%s", usuario, repo, nombreItem)
    local path = fs.combine(shell.dir(), nombreItem)

    -- Si el archivo ya existe en el juego, lo borramos para actualizarlo
    if fs.exists(path) then
        fs.delete(path)
    end

    -- Creamos la estructura de opciones para la petición HTTP
    local opciones = {
        url = api_url,
        headers = misCabeceras
    }

    local respuesta = http.get(opciones)
    
    if respuesta then
        respuestaJson = textutils.unserializeJSON(respuesta.readAll())
        respuesta.close()

        file_response = http.get(respuestaJson.download_url)
        if file_response then
            local contenido = file_response.readAll()
            file_response.close()

            local file = fs.open(path, "w")
            file.write(contenido)
            file.close()
            print("- ".. nombreItem)
        end

        

    else
        print("Error al descargar " .. nombreItem)
    end
end

print("¡Proyecto actualizado con éxito!")