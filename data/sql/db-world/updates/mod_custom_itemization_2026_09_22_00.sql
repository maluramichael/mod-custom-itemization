-- --------------------------------------------------------------------------------------
--  mod-custom-itemization
--  A curated custom gear pack (item entries 9001000-9001099) sold by a new vendor NPC.
--  All items reuse existing client display models - no client patch required.
--  This file is idempotent: every block deletes its own rows before inserting them,
--  so re-running it (or re-applying the module) is always safe.
-- --------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------
--  ITEMS (9001000-9001013)
--  stat_type codes: 3=Agility 4=Strength 5=Intellect 6=Spirit 7=Stamina
--                    32=Crit Rating 36=Haste Rating 38=Attack Power 45=Spell Power
--  All pieces bind on pickup (`bonding` = 1) since they are sold only by this vendor.
-- ----------------------------------------------------------------------------------
DELETE FROM `item_template` WHERE `entry` BETWEEN 9001000 AND 9001013;
INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `InventoryType`, `ItemLevel`, `RequiredLevel`,
     `bonding`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`,
     `armor`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `delay`, `ammo_type`, `BuyPrice`, `SellPrice`)
VALUES
    -- "Emberwrought Battlegear" - matching-look plate set (Head/Shoulder/Chest/Legs/Hands).
    -- NOTE: this is a look-alike set only, no mechanical set bonus - AzerothCore reads set
    -- bonuses from the client's ItemSet.dbc, and patching that is out of scope for this
    -- module. Reusing an unrelated real itemset id would have applied that set's own
    -- (wrong) bonus text/effects, so the `itemset` column is intentionally left at its
    -- default (0) on every piece below.
    (9001000, 4, 4, 'Emberwrought Greathelm',    54403, 4, 1,  180, 75, 1, 7, 58, 4, 42, 32, 30, 620,   0,   0, 0,    0, 0, 180000, 36000),
    (9001001, 4, 4, 'Emberwrought Pauldrons',    56213, 4, 3,  180, 75, 1, 7, 46, 4, 32, 38, 40, 480,   0,   0, 0,    0, 0, 150000, 30000),
    (9001002, 4, 4, 'Emberwrought Battleplate',  55369, 4, 5,  180, 75, 1, 7, 70, 4, 50, 32, 34, 760,   0,   0, 0,    0, 0, 220000, 44000),
    (9001003, 4, 4, 'Emberwrought Legguards',    55375, 4, 7,  180, 75, 1, 7, 64, 4, 46, 36, 32, 700,   0,   0, 0,    0, 0, 200000, 40000),
    (9001004, 4, 4, 'Emberwrought Gauntlets',    55371, 4, 10, 180, 75, 1, 7, 40, 4, 28, 38, 36, 420,   0,   0, 0,    0, 0, 140000, 28000),

    -- Standalone plate accessories (fill the gaps around the matching set).
    (9001005, 4, 4, 'Girdle of the Unbroken Line', 48355, 3, 6, 150, 70, 1, 7, 36, 4, 24, 0,  0,  340,   0,   0, 0,    0, 0,  80000, 16000),
    (9001006, 4, 4, 'Sabatons of the Long March',  48366, 3, 8, 150, 70, 1, 7, 34, 4, 22, 36, 18, 380,   0,   0, 0,    0, 0,  85000, 17000),
    (9001007, 4, 4, 'Bracers of Grim Resolve',     48313, 3, 9, 150, 70, 1, 7, 30, 4, 20, 0,  0,  260,   0,   0, 0,    0, 0,  60000, 12000),

    -- Non-plate pieces for other armor classes/roles.
    (9001008, 4, 1, 'Mantle of the Cinder Wyrm',      45476, 4, 16, 155, 68, 1, 5, 34, 6, 22, 45, 40,  90,   0,   0, 0,    0, 0, 120000, 24000),
    (9001009, 4, 2, 'Sunfallen Hauberk',               48011, 4, 5,  159, 68, 1, 3, 54, 7, 48, 32, 30, 380,   0,   0, 0,    0, 0, 190000, 38000),
    (9001010, 4, 3, 'Ringmail of the Drowned Chorus',  46356, 4, 5,  159, 68, 1, 3, 46, 7, 44, 38, 50, 520,   0,   0, 0,    0, 0, 190000, 38000),

    -- Weapons.
    (9001011, 2, 7,  'Duskfang, Blade of Whispers', 48079, 4, 13, 154, 68, 1, 3, 32, 32, 22, 0, 0, 0, 120, 224, 0, 1700, 0, 160000, 32000),
    (9001012, 2, 10, 'Voidcaller''s Focus',         49132, 4, 17, 154, 68, 1, 5, 46, 45, 62, 36, 28, 0,  60, 112, 0, 2800, 0, 170000, 34000),
    (9001013, 2, 2,  'Longbow of the Silent Hunt',  45265, 4, 15, 154, 68, 1, 3, 40, 32, 26, 0, 0, 0, 180, 296, 0, 2800, 2, 165000, 33000);

-- ----------------------------------------------------------------------------------
--  VENDOR NPC - "Master Artificer" (entry 9001500)
--  Not spawned by default. Modeled on modules/mod-npc-enchanter's working vendor NPC
--  SQL on this fork: same creature_template column shape, displayid moved out into
--  creature_template_model (this fork does not read displayid from creature_template),
--  plus npc_vendor to actually sell the gear.
-- ----------------------------------------------------------------------------------
SET
@Entry      := 9001500,
@Model      := 1288, -- Smith Argus (Blacksmithing Trainer) - reused, no client patch needed
@Name       := "Master Artificer",
@Title      := "Custom Gear Vendor",
@Icon       := "Vendor",
@GossipMenu := 0,
@MinLevel   := 80,
@MaxLevel   := 80,
@Faction    := 35,   -- Friendly
@NPCFlag    := 128,  -- UNIT_NPC_FLAG_VENDOR
@Type       := 7,    -- CREATURE_TYPE_HUMANOID
@TypeFlags  := 0,
@FlagsExtra := 2,    -- CREATURE_FLAG_EXTRA_CIVILIAN
@AIName     := "",
@Script     := "";

-- NPC CREATURE
DELETE FROM `creature_template` WHERE `entry` = @Entry;
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `AiName`, `ScriptName`)
VALUES (@Entry, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra, @AIName, @Script);

-- NPC MODEL
DELETE FROM `creature_template_model` WHERE `CreatureID` = @Entry;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
VALUES (@Entry, 0, @Model, 1, 1, 0);

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID` = @Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`)
VALUES (@Entry, 'Welcome, adventurer. Every piece on this rack was forged for someone who outgrew their old gear a little too fast.');

-- ----------------------------------------------------------------------------------
--  VENDOR STOCK - sells all 14 custom items, unlimited stock, no restock timer.
-- ----------------------------------------------------------------------------------
DELETE FROM `npc_vendor` WHERE `entry` = 9001500;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`)
VALUES
    (9001500, 1,  9001000, 0, 0, 0),
    (9001500, 2,  9001001, 0, 0, 0),
    (9001500, 3,  9001002, 0, 0, 0),
    (9001500, 4,  9001003, 0, 0, 0),
    (9001500, 5,  9001004, 0, 0, 0),
    (9001500, 6,  9001005, 0, 0, 0),
    (9001500, 7,  9001006, 0, 0, 0),
    (9001500, 8,  9001007, 0, 0, 0),
    (9001500, 9,  9001008, 0, 0, 0),
    (9001500, 10, 9001009, 0, 0, 0),
    (9001500, 11, 9001010, 0, 0, 0),
    (9001500, 12, 9001011, 0, 0, 0),
    (9001500, 13, 9001012, 0, 0, 0),
    (9001500, 14, 9001013, 0, 0, 0);
