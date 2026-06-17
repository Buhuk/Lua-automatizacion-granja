-- Contenido de update.lua
local usuario = "Buhuk"
local repo = "lua-automatizacion-granja"
local rama = "main"

-- Lista de todos los archivos de tu proyecto modular
local archivos = {
    "main.lua",
    "config.lua",
    "Roost.lua",
    "interfaz.lua",
    "calibracion.lua"
}

print("Actualizando proyecto desde GitHub...")

for _, nombreItem in ipairs(archivos) do
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", usuario, repo, rama, nombreItem)
    
    -- Si el archivo ya existe en el juego, lo borramos para actualizarlo
    if fs.exists(nombreItem) then
        fs.delete(nombreItem)
    end
    
    -- Lo descargamos usando la API HTTP de ComputerCraft
    print("Descargando: " .. nombreItem)
    local respuesta = http.get(url)
    if respuesta then
        local contenido = respuesta.readAll()
        respuesta.close()
        
        local file = fs.open(nombreItem, "w")
        file.write(contenido)
        file.close()
    else
        print("Error al descargar " .. nombreItem)
    end
end

print("¡Proyecto actualizado con éxito!")