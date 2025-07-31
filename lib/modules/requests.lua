--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module requests
--- Handles wrapper functions around FiveM's native `Request` functions.

local requests = {}

if not graft.is_server then

    --- Requests a model and waits until it's loaded.
    --- @param model hash: The hash of the model to load.
    function requests.model(model)
        if HasModelLoaded(model) then return end
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end

    --- Requests an interior and waits until it's ready.
    --- @param interior number: The ID of the interior to load.
    function requests.interior(interior)
        if IsInteriorReady(interior) then return end
        if IsValidInterior(interior) then
            LoadInterior(interior)
            while not IsInteriorReady(interior) do
                Wait(0)
            end
        end
    end

    --- Requests a texture dictionary and optionally waits until it's loaded.
    --- @param texture string: The name of the texture dictionary to load.
    --- @param boolean boolean: Whether to wait for the texture dictionary to load.
    function requests.texture(texture, boolean)
        if HasStreamedTextureDictLoaded(texture) then return end
        RequestStreamedTextureDict(texture, boolean)
        if boolean and not HasStreamedTextureDictLoaded(texture) then
            Wait(150)
        end
    end

    --- Requests collision at a given location and waits until it's loaded.
    --- @param x number: The X coordinate.
    --- @param y number: The Y coordinate.
    --- @param z number: The Z coordinate.
    function requests.collision(x, y, z)
        if HasCollisionLoadedAroundEntity(PlayerPedId()) then return end
        RequestCollisionAtCoord(x, y, z)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            Wait(0)
        end
    end

    --- Requests an animation dictionary and waits until it's loaded.
    --- @param dict string: The name of the animation dictionary to load.
    function requests.anim(dict)
        if HasAnimDictLoaded(dict) then return end
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
    --- Requests a animation set and waits until loaded.
    --- @param set string: The name of the animation set to load
    function requests.anim_set(set)
        RequestAnimSet(set)
        while not HasAnimSetLoaded(set) do
            Wait(100)
        end
    end

    --- Requests an animation clip set and waits until it's loaded.
    --- @param clip string: The name of the clip set to load.
    function requests.clip_set(clip)
        if HasClipSetLoaded(clip) then return end
        RequestClipSet(clip)
        while not HasClipSetLoaded(clip) do
            Wait(0)
        end
    end

    --- Requests a script audio bank and waits until it's loaded.
    --- @param audio string: The name of the audio bank to load.
    function requests.audio_bank(audio)
        if HasScriptAudioBankLoaded(audio) then return end
        RequestScriptAudioBank(audio, false)
        while not HasScriptAudioBankLoaded(audio) do
            Wait(0)
        end
    end

    --- Requests a scaleform movie and waits until it's loaded.
    --- @param scaleform string: The name of the scaleform movie to load.
    --- @return handle number: The handle of the loaded scaleform movie.
    function requests.scaleform_movie(scaleform)
        if HasScaleformMovieLoaded(scaleform) then return end
        local handle = RequestScaleformMovie(scaleform)
        while not HasScaleformMovieLoaded(handle) do
            Wait(0)
        end
        return handle
    end

    --- Requests a cutscene and waits until it's loaded.
    --- @function cutscene
    --- @param scene string: The name of the cutscene to load.
    --- @usage requests.cutscene('example_cutscene_name')
    function requests.cutscene(scene)
        if HasCutsceneLoaded() then return end
        RequestCutscene(scene, 8)
        while not HasCutsceneLoaded() do
            Wait(0)
        end
    end

    --- Requests an ipl and waits until it's active.
    --- @param str string: The name of the ipl to load.
    function requests.ipl(str)
        if IsIplActive(str) then return end
        RequestIpl(str)
        while not IsIplActive(str) do
            Wait(0)
        end
    end

end

return requests