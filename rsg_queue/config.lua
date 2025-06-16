Config = {}

-- Lista de prioridade por Steam HEX
Config.Priority = {
    ["steam:110000112345678"] = 100, -- Dono
    ["steam:110000198765432"] = 50,  -- Admin
    ["steam:110000199999999"] = 25   -- VIP
}

-- Tempo de atualização da fila (em milissegundos)
Config.QueueUpdateTime = 3000

-- Mensagem para quem não está com Steam aberta
Config.SteamRequired = "Você precisa estar com a Steam aberta para entrar no servidor."
