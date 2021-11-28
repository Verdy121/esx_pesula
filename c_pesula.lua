ESX = nil
PlayerLoaded = false

function Draw3DText(x,y,z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0150, 0.06 + factor, 0.03, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(object) ESX = object end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    PlayerLoaded = true
    local sijainti = Config.Sijainti
    local salliPesu = true
    while true do
        local coordit = GetEntityCoords(PlayerPedId())
        if PlayerLoaded == true then
            if Vdist(coordit, sijainti) < Config.MaxEtasyys then
                Draw3DText(sijainti.x, sijainti.y, sijainti.z, "~w~Paina ~r~[E]~w~ pestäksesi ~r~Rahaa", 0.4)
                if Vdist(coordit, sijainti) < Config.AvaamisEtasyys and IsControlPressed(1, 38) then
                    TriggerEvent("ovianim")
                    if salliPesu == true then
                        TriggerServerEvent('pesuPerkele:perkelePese')
                        
                        function loadAnimDict( dict )
                            while ( not HasAnimDictLoaded( dict ) ) do
                                RequestAnimDict( dict )
                                Citizen.Wait( 5 )
                            end
                        end

                        RegisterNetEvent( 'ovianim' )
                        AddEventHandler( 'ovianim', function()
                            
                            ClearPedSecondaryTask(GetPlayerPed(-1))
                            loadAnimDict( "amb@code_human_police_crowd_control@idle_a" ) 
                            TaskPlayAnim( GetPlayerPed(-1), "amb@code_human_police_crowd_control@idle_a", "idle_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                            Citizen.Wait(5000)
                            ClearPedTasks(GetPlayerPed(-1))
                        end)

                        Citizen.CreateThread(function()
                            salliPesu = false
                            Citizen.Wait(2500)
                            salliPesu = true
                        end)
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)