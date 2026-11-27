local Params = {
    RepoURL = "https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/",
    BackupURL = "https://codeberg.org/phoriah/UniversalSynSaveInstance/raw/branch/main/",
    USSI = "saveinstance",
    Extension = ".lua",
    USSI_FOLDER = "ussi_cache/",
}
local Cache = Params.USSI_FOLDER .. Params.USSI .. Params.Extension
local function fetch(url)
    local ok, src = pcall(game.HttpGet, game, url .. Params.USSI .. Params.Extension, true)
    return ok and src and src ~= "" and loadstring(src, Params.USSI), src
end
local fn, src = fetch(Params.RepoURL)
if not fn and Params.BackupURL then
    fn, src = fetch(Params.BackupURL)
end
if fn then
    task.spawn(function()
        pcall(makefolder, Params.USSI_FOLDER)
        pcall(writefile, Cache, src)
    end)
else
    local ok, cached = pcall(readfile, Cache)
    fn = ok and cached and cached ~= "" and loadstring(cached, Params.USSI)
end
return assert(fn, "Failed to load " .. Params.USSI)()
