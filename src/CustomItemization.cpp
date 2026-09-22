/*
 * mod-custom-itemization
 *
 * Ships a small curated custom gear pack (item entries 9001000-9001099) sold by a
 * new vendor NPC, "Master Artificer" (creature entry 9001500, not spawned by default).
 *
 * This module carries no combat logic of its own - all of the actual content lives in
 * SQL (item_template / creature_template / creature_template_model / npc_vendor).
 * The only job of the C++ side is to:
 *   - register the module's loader symbol so the DB updater picks up its SQL file, and
 *   - read CustomItemization.Enable so the module can be told apart from "not installed"
 *     in server logs, and so a future toggle has somewhere to hook into.
 *
 * Released under GNU GPL v2 or (at your option) any later version.
 */

#include "Config.h"
#include "ScriptMgr.h"

namespace CustomItemization
{
    // Cached config (populated in WorldScript::OnAfterConfigLoad).
    struct Config
    {
        bool Enable = true;
    };

    Config& GetConfig()
    {
        static Config cfg;
        return cfg;
    }
}

// =====================================================================
//  WorldScript: config load.
// =====================================================================
class CustomItemizationWorldScript : public WorldScript
{
public:
    CustomItemizationWorldScript() : WorldScript("CustomItemization_WorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        CustomItemization::Config& cfg = CustomItemization::GetConfig();
        cfg.Enable = sConfigMgr->GetOption<bool>("CustomItemization.Enable", true);
    }
};

// =====================================================================
//  Registration
// =====================================================================
void AddCustomItemizationScripts()
{
    new CustomItemizationWorldScript();
}
