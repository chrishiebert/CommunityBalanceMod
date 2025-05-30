-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\MarineWeaponEffects.lua
--
--    Created by:   Charlie Cleveland (charlie@unknownworlds.com)
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

kMarineWeaponEffects =
{
    power_surge = 
    {
        powerSurgeEffects = 
        {
            {cinematic = "cinematics/marine/power_surge.cinematic"},
        }
    },

    burn_bomb =
    {
        burnSporeEffects =
        {
            {cinematic = "cinematics/alien/burn_sporecloud.cinematic"},
            {sound = "sound/NS2.fev/alien/structures/death_grenade"},
        } 
    
    }, 

    burn_spore =
    {
        burnSporeEffects =
        {
            {cinematic = "cinematics/alien/burn_sporecloud.cinematic"},
        } 
    
    },
    
    burn_umbra =
    {
        burnSporeEffects =
        {
            {cinematic = "cinematics/alien/burn_umbra.cinematic"},
        } 
    
    },

    -- When marine weapon hits ground
    weapon_dropped =
    {
        weaponDropEffects = 
        {
            {sound = "sound/NS2.fev/marine/common/drop_weapon"},
        },
    },
    
    holster =
    {
        holsterStopEffects =
        {
            {stop_cinematic = "cinematics/marine/flamethrower/flame.cinematic", classname = "Flamethrower"},
        },
    },
    
    draw =
    {
        marineWeaponDrawSounds =
        {
            
            {player_sound = "sound/NS2.fev/marine/rifle/deploy_grenade", classname = "GrenadeLauncher", done = true},
            {player_sound = "sound/NS2.fev/marine/rifle/draw", classname = "Rifle", done = true},
            {player_sound = "sound/NS2.fev/marine/hmg/hmg_draw", classname = "HeavyMachineGun", done = true},
            {player_sound = "sound/NS2.fev/marine/pistol/draw", classname = "Pistol", done = true},
            {player_sound = "sound/NS2.fev/marine/axe/draw", classname = "Axe", done = true},
            {player_sound = "sound/NS2.fev/marine/flamethrower/draw", classname = "Flamethrower", done = true},
            {player_sound = "sound/NS2.fev/marine/shotgun/deploy", classname = "Shotgun", done = true},
            {player_sound = "sound/NS2.fev/marine/welder/deploy", classname = "Welder", done = true},
            {player_sound = "sound/NS2.fev/marine/grenades/draw", classname = "GrenadeThrower", done = true},
			{player_sound = "sound/combat.fev/combat/weapons/marine/lmg/draw", classname = "Submachinegun", done = true},
            
        },

    },
    
    grenade_throw =
    {
        effects = 
        {
            {player_sound = "sound/NS2.fev/marine/grenades/throw"},
        }
    },
    
    grenade_pull_pin =
    {
        effects = 
        {
            {player_sound = "sound/NS2.fev/marine/grenades/pin"},
        }
    },
    
    exo_login =
    {
        viewModelCinematics =
        {
            {viewmodel_cinematic = "cinematics/marine/heavy/deploy_light.cinematic", attach_point = "exosuit_camBone"},
        },
    },

    reload = 
    {
        gunReloadEffects =
        {
            {player_sound = "sound/NS2.fev/marine/rifle/reload", classname = "Rifle"},
            {player_sound = "sound/NS2.fev/marine/pistol/reload", classname = "Pistol"},
            {player_sound = "sound/NS2.fev/marine/flamethrower/reload", classname = "Flamethrower"},
            {player_sound = "sound/NS2.fev/marine/hmg/hmg_reload", classname = "HeavyMachineGun"},
        },
    },
    
    reload_cancel =
    {
        gunReloadCancelEffects =
        {
            {stop_sound = "sound/NS2.fev/marine/rifle/reload", classname = "Rifle"},
            {stop_sound = "sound/NS2.fev/marine/pistol/reload", classname = "Pistol"},
            {stop_sound = "sound/NS2.fev/marine/flamethrower/reload", classname = "Flamethrower"},
            {stop_sound = "sound/NS2.fev/marine/hmg/hmg_reload", classname = "HeavyMachineGun"},
			{stop_sound = "sound/combat.fev/combat/weapons/marine/lmg/reload0", classname = "Submachinegun"},
            {stop_sound = "sound/combat.fev/combat/weapons/marine/lmg/reload1", classname = "Submachinegun", done = true},
        },
    },
    
    clipweapon_empty =
    {
        emptySounds =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/fire_empty", classname = "Shotgun", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", classname = "Rifle", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", classname = "Flamethrower", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", classname = "GrenadeLauncher", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", classname = "Pistol", done = true},  
            {player_sound = "sound/NS2.fev/marine/common/empty", classname = "HeavyMachineGun", done = true},  
        },
        
    },
    
    rifle_alt_attack = 
    {
        rifleAltAttackEffects = 
        {
            --{ player_sound = "sound/NS2.fev/marine/rifle/alt_swing_bigmac_combat", sex = "bigmac", alt_type = true, done = true },
            { player_sound = "sound/NS2.fev/marine/rifle/alt_swing_bigmac_friendly", sex = "bigmac", done = true },
            { player_sound = "sound/NS2.fev/marine/rifle/alt_swing_female", sex = "female", done = true },
            { player_sound = "sound/NS2.fev/marine/rifle/alt_swing" },
        },
    },
    
    pistol_attack = 
    {
        pistolAttackEffects = 
        {
            {viewmodel_cinematic = "cinematics/marine/pistol/muzzle_flash.cinematic", attach_point = "fxnode_pistolmuzzle"},
            -- First-person and weapon shell casings
            {viewmodel_cinematic = "cinematics/marine/pistol/shell.cinematic", attach_point = "fxnode_pistolcasing"},
            
            {weapon_cinematic = "cinematics/marine/pistol/muzzle_flash.cinematic", attach_point = "fxnode_pistolmuzzle"},
            {weapon_cinematic = "cinematics/marine/pistol/shell.cinematic", attach_point = "fxnode_pistolcasing"} ,
            
            -- Sound effect
            {player_sound = "sound/NS2.fev/marine/pistol/fire"},
        },
    },
    
    pistol_idle_spin = 
    {
        effects = 
        {
            { player_sound = "sound/NS2.fev/marine/pistol/idle_spin" },
        },
    },
    
    pistol_idle_gangster = 
    {
        effects = 
        {
            { player_sound = "sound/NS2.fev/marine/pistol/idle_gangster" },
        },
    },
    
    pistol_stop_idle_sounds = 
    {
        axeIdleSounds = 
        {
            { stop_sound = "sound/NS2.fev/marine/pistol/idle_spin" },
            { stop_sound = "sound/NS2.fev/marine/pistol/idle_gangster" },
        },
    },
    
    axe_attack = 
    {
        axeAttackEffects = 
        {
            --{ player_sound = "sound/NS2.fev/marine/axe/attack_bigmac_combat", sex = "bigmac", alt_type = true, done = true },
            { player_sound = "sound/NS2.fev/marine/axe/attack_bigmac", sex = "bigmac", done = true },
            { player_sound = "sound/NS2.fev/marine/axe/attack_female", sex = "female", done = true },
            { player_sound = "sound/NS2.fev/marine/axe/attack" },
        },
    },
    
    axe_idle_toss = 
    {
        effects = 
        {
            { player_sound = "sound/NS2.fev/marine/axe/ide_throw" },
        },
    },
    
    axe_idle_fiddle = 
    {
        effects = 
        {
            { player_sound = "sound/NS2.fev/marine/axe/idle_fiddle" },
        },
    },
    
    axe_stop_idle_sounds = 
    {
        axeIdleSounds = 
        {
            { stop_sound = "sound/NS2.fev/marine/axe/ide_throw" },
            { stop_sound = "sound/NS2.fev/marine/axe/idle_fiddle" },
        },
    },
    
    shotgun_attack_sound_last =
    {
        effects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/fire_last"},
        }
    },
    
    shotgun_attack_sound = 
    {
        effects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/fire"},
        }
    },
    
    shotgun_attack_sound_medium = 
    {
        effects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/fire_upgrade_1"},
        }
    },
    
    shotgun_attack_sound_max = 
    {
        effects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/fire_upgrade_3"},
        }
    },

    shotgun_attack = 
    {
        shotgunAttackEffects = 
        {
            {viewmodel_cinematic = "cinematics/marine/shotgun/muzzle_flash.cinematic", attach_point = "fxnode_shotgunmuzzle"},
            {weapon_cinematic = "cinematics/marine/shotgun/muzzle_flash.cinematic", attach_point = "fxnode_shotgunmuzzle"},
            {weapon_cinematic = "cinematics/marine/shotgun/shell.cinematic", attach_point = "fxnode_shotguncasing"} ,
        },
    },
    
    -- Special shotgun reload effects
    shotgun_reload_start =
    {
        shotgunReloadStartEffects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/start_reload"},
        },
    },

    shotgun_reload_shell =
    {
        shotgunReloadShellEffects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/load_shell"},
        },
    },

    shotgun_reload_end =
    {
        shotgunReloadEndEffects =
        {
            {player_sound = "sound/NS2.fev/marine/shotgun/end_reload"},
        },
    },
    
    -- Special shotgun reload effects
    grenadelauncher_reload_start =
    {
        grenadelauncherReloadStartEffects =
        {
            {player_sound = "sound/NS2.fev/marine/grenade_launcher/reload_start"},
        },
    },

    grenadelauncher_reload_shell =
    {
        grenadelauncherReloadShellEffects =
        {
            {sound = "sound/NS2.fev/marine/grenade_launcher/reload"},
        },
    },
    
    grenadelauncher_reload_shell_last =
    {
        grenadelauncherReloadShellEffects =
        {
            {player_sound = "sound/NS2.fev/marine/grenade_launcher/reload_last"},
        },
    },

    grenadelauncher_reload_end =
    {
        grenadelauncherReloadEndEffects =
        {
            {player_sound = "sound/NS2.fev/marine/grenade_launcher/reload_end"},
        },
    },
    
    grenadelauncher_attack =
    {
        glAttackEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/gl/muzzle_flash.cinematic", attach_point = "fxnode_glmuzzle", empty = false},
            {weapon_cinematic = "cinematics/marine/gl/muzzle_flash.cinematic", attach_point = "fxnode_glmuzzle", empty = false},
            
            {player_sound = "sound/NS2.fev/marine/rifle/fire_grenade", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", empty = true, done = true},
        },
    },
    
    grenadelauncher_alt_attack =
    {
        glAttackEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/gl/muzzle_flash.cinematic", attach_point = "fxnode_glmuzzle", empty = false},
            
            {player_sound = "sound/NS2.fev/marine/rifle/fire_grenade", done = true},
            {player_sound = "sound/NS2.fev/marine/common/empty", empty = true, done = true},
        },
    },
    
    flamethrower_attack_start =
    {
        soundEffects =
        {
            {player_sound = "sound/NS2.fev/marine/flamethrower/attack_start"},
        }    
    },
    
    flamethrower_attack = 
    {
        flamethrowerAttackCinematics = 
        {
            -- If we're out of ammo, play 'flame out' effect
            {viewmodel_cinematic = "cinematics/marine/flamethrower/flameout.cinematic", attach_point = "fxnode_flamethrowermuzzle", empty = true},
            {weapon_cinematic = "cinematics/marine/flamethrower/flameout.cinematic", attach_point = "fxnode_flamethrowermuzzle", empty = true, done = true},
        
            -- Otherwise play either first-person or third-person flames
            {viewmodel_cinematic = "cinematics/marine/flamethrower/flame_1p.cinematic", attach_point = "fxnode_flamethrowermuzzle"},
            {weapon_cinematic = "cinematics/marine/flamethrower/flame.cinematic", attach_point = "fxnode_flamethrowermuzzle"},
        },
    },
    
    flamethrower_attack_end = 
    {
        flamethrowerAttackEndCinematics = 
        {
            --{stop_sound = "sound/NS2.fev/marine/flamethrower/attack_start"},
            {player_sound = "sound/NS2.fev/marine/flamethrower/attack_end"},
        },
    },
    
    mine_spawn =
    {
        mineSpawn =
        {
            {sound = "sound/NS2.fev/marine/common/mine_drop", world_space = true},
        },
    },
    
    mine_arm =
    {
        mineArm =
        {
            {sound = "sound/NS2.fev/marine/common/mine_explode"},
        }
    },
    
    mine_explode =
    {
        mineExplode =
        {
            {cinematic = "cinematics/materials/ethereal/grenade_explosion.cinematic", surface = "ethereal", done = true},  
            {cinematic = "cinematics/materials/%s/grenade_explosion.cinematic"},
        }
            
    },
    
    release_nervegas =
    {
        releaseNerveGasEffects = 
        {
            {parented_cinematic = "cinematics/marine/grenades/nerve_explo.cinematic"},
            {sound = "sound/NS2.fev/marine/grenades/gas/explode"},
        },    
    },

    grenadelauncher_reload =
    {
        glReloadEffects = 
        {
            {player_sound = "sound/NS2.fev/marine/rifle/reload_grenade"},
        },    
    },
    
    grenade_bounce =
    {
        grenadeBounceEffects =
        {
            {sound = "sound/NS2.fev/marine/rifle/grenade_bounce"},
        },
    },
    
    explosion_decal =
    {
        explosionDecal =
        {
            {decal = "cinematics/vfx_materials/decals/blast_01.material", scale = 2, done = true}
        }    
    },
    
    grenade_explode =
    {
        grenadeExplodeEffects =
        {
            -- Any asset name with a %s will use the "surface" parameter as the name
            {cinematic = "cinematics/materials/ethereal/grenade_explosion.cinematic", surface = "ethereal", done = true},   
            {cinematic = "cinematics/materials/%s/grenade_explosion.cinematic"},
        },
        
        grenadeExplodeSounds =
        {
            {sound = "sound/NS2.fev/marine/common/explode", surface = "ethereal", done = true},
            {sound = "sound/NS2.fev/marine/common/explode", done = true},
        },
    },
    
    cluster_grenade_explode =
    {
        grenadeExplodeEffects =
        {  
            {sound = "sound/NS2.fev/marine/grenades/cluster/primary_explode"},
            {cinematic = "cinematics/marine/grenades/cluster_main_explo.cinematic", done = true}
        }
    },
    
    cluster_fragment_explode =
    {
        grenadeExplodeEffects =
        {  
            {sound = "sound/NS2.fev/marine/grenades/cluster/secondary_explode"},
            {cinematic = "cinematics/marine/grenades/cluster_small_explos.cinematic", done = true}
        }
    },
    
    clusterfragment_residue = 
    {
        clusterFragmentResiudeEffect = 
        {
            {cinematic = "cinematics/marine/clusterfragment_residue.cinematic"},
        },
    },
    
    pulse_grenade_explode =
    {
        pulseGrenadeEffects =
        {   
            {sound = "sound/NS2.fev/marine/grenades/pulse/explode"},
            {cinematic = "cinematics/marine/grenades/pulse_explo.cinematic", done = true},
        },
    },
    
    welder_start =
    {
        welderStartEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/welder/welder_start.cinematic", attach_point = "fxnode_weldermuzzle"},
            {weapon_cinematic = "cinematics/marine/welder/welder_start.cinematic", attach_point = "fxnode_weldermuzzle"},
            --{sound = "sound/NS2.fev/marine/flamethrower/attack_start"},
        },
    },
    
    welder_end =
    {
        welderEndEffects =
        {   
            {stop_viewmodel_cinematic = "cinematics/marine/welder/welder_muzzle.cinematic" },
            --{sound = "sound/NS2.fev/marine/flamethrower/attack_end"},
        },
    },

    -- using looping sound at Welder class, only cinematic defined here
    welder_muzzle =
    {
        welderMuzzleEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/welder/welder_muzzle.cinematic", attach_point = "fxnode_weldermuzzle"},
            {weapon_cinematic = "cinematics/marine/welder/welder_muzzle.cinematic", attach_point = "fxnode_weldermuzzle"},
        },
    },
    
    welder_hit =
    {
        welderHitEffects =
        {
            {cinematic = "cinematics/marine/welder/welder_hit.cinematic"},
        },
    },
    
    minigun_overheated_left =
    {
        minigunOverheatEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/minigun/overheat.cinematic", attach_point = "fxnode_l_minigun_muzzle"},
        }
    },    
    
    minigun_overheated_right =
    {
        minigunOverheatEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/minigun/overheat.cinematic", attach_point = "fxnode_r_minigun_muzzle"},
        }
    },
    
    railgun_steam_left =
    {
        minigunOverheatEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/railgun/steam_1p_left.cinematic", attach_point = "fxnode_l_railgun_muzzle"},
        }
    },
    
    
    railgun_steam_right =
    {
        minigunOverheatEffects =
        {
            {viewmodel_cinematic = "cinematics/marine/railgun/steam_1p_right.cinematic", attach_point = "fxnode_r_railgun_muzzle"},
        }
    },
    
    claw_attack =
    {
        sounds =
        {
            {player_sound = "sound/NS2.fev/marine/heavy/punch", done = true},
        }
    },
    
    railgun_attack =
    {
        railgunAttackEffects =
        {
            -- Sound effect
            {player_sound = "sound/NS2.fev/marine/heavy/railgun_fire"}
        },
    },
    
    marine_weapon_pickup =
    {
        marineWeaponPickup = 
        {
            {sound = "sound/NS2.fev/marine/common/pickup_gun"}
        },
    },
    
    comm_powersurge = 
    {
        commanderPowerSurge = 
        {
            { sound = "sound/NS2.fev/marine/grenades/pulse/explode" }
        }
    },

	reload_speed0 =
    {
        gunReloadEffects =
        {
            {player_sound = "sound/combat.fev/combat/weapons/marine/lmg/reload0", classname = "Submachinegun", done = true},
        },
    },
	
	reload_speed1 =
    {
        gunReloadEffects =
        {
            {player_sound = "sound/combat.fev/combat/weapons/marine/lmg/reload1", classname = "Submachinegun", done = true},
        },
    },
}

GetEffectManager():AddEffectData("MarineWeaponEffects", kMarineWeaponEffects)

GetEffectManager():AddEffectData("ScattersModEffects", {
    leftexowelder_muzzle  = {
        welderMuzzleEffects = {
            { viewmodel_cinematic = "cinematics/marine/welder/exowelder_muzzle.cinematic", attach_point = "fxnode_l_railgun_muzzle" },
            { weapon_cinematic = "cinematics/marine/welder/exowelder_muzzle.cinematic", attach_point = "fxnode_lrailgunmuzzle" },
        },
    },
    rightexowelder_muzzle = {
        welderMuzzleEffects = {
            { viewmodel_cinematic = "cinematics/marine/welder/exowelder_muzzle.cinematic", attach_point = "fxnode_r_railgun_muzzle" },
            { weapon_cinematic = "cinematics/marine/welder/exowelder_muzzle.cinematic", attach_point = "fxnode_rrailgunmuzzle" },
        },
    },
    exowelder_hit         = {
        welderHitEffects = {
            { cinematic = "cinematics/marine/welder/exowelder_hit.cinematic" },
        },
    },
})

GetEffectManager():AddEffectData("FlamerModEffects", {
    leftexoflamer_muzzle  = {
        flamerMuzzleEffects = {
            { viewmodel_cinematic = "cinematics/modularexo/blowtorch_1p.cinematic", attach_point = "fxnode_l_railgun_muzzle" },
            { weapon_cinematic = "cinematics/modularexo/blowtorch.cinematic", attach_point = "fxnode_lrailgunmuzzle" },
        },
    },
    rightexoflamer_muzzle = {
        flamerMuzzleEffects = {
            { viewmodel_cinematic = "cinematics/modularexo/blowtorch_1p.cinematic", attach_point = "fxnode_r_railgun_muzzle" },
            { weapon_cinematic = "cinematics/modularexo/blowtorch.cinematic", attach_point = "fxnode_rrailgunmuzzle" },
        },
    },
})
    
GetEffectManager():AddEffectData("plasma_impact", {
	plasma_impact = 
    {
        PlasmaImpact = 
        {
            {cinematic = "cinematics/modularexo/plasma_impact_small.cinematic", done = true}
        }
    },
})	