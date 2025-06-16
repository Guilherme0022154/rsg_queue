local queue = {}

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    deferrals.defer()
    Wait(500)

    local identifiers = GetPlayerIdentifiers(src)
    local steam = nil

    for _, id in pairs(identifiers) do
        if string.sub(id, 1, 6) == "steam:" then
            steam = id
            break
        end
    end

    if not steam then
        deferrals.done(Config.SteamRequired)
        CancelEvent()
        return
    end

    local prio = Config.Priority[steam] or 0

    table.insert(queue, {src = src, steam = steam, prio = prio})
    table.sort(queue, function(a, b) return a.prio > b.prio end)

    local pos = 1
    for i, player in ipairs(queue) do
        if player.steam == steam then
            pos = i
            break
        end
    end

    deferrals.update("⌛ Aguarde... você está na fila. Posição: " .. pos)

    while queue[1].steam ~= steam do
        for i, player in ipairs(queue) do
            if player.steam == steam then
                deferrals.update("⌛ Aguarde... você está na fila. Posição: " .. i)
                break
            end
        end
        Wait(Config.QueueUpdateTime)
    end

    deferrals.done()
    table.remove(queue, 1)
end)

AddEventHandler("playerDropped", function()
    local src = source
    local identifiers = GetPlayerIdentifiers(src)
    local steam

    for _, id in ipairs(identifiers) do
        if string.sub(id, 1, 6) == "steam:" then
            steam = id
            break
        end
    end

    if steam then
        for i, player in ipairs(queue) do
            if player.steam == steam then
                table.remove(queue, i)
                break
            end
        end
    end
end)
