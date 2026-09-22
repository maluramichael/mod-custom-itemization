-- Master Artificer (9001500) world spawn in Stormwind, placed by Michael 2026-09-22.
-- Idempotent (DELETE by guid + INSERT), safe to re-apply. Fixed guid in the reserved
-- 9100011+ spawn range so the placement survives a full world-DB reset / redeploy.
DELETE FROM `creature` WHERE `guid` = 9100034;
INSERT INTO `creature`
(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`,`CreateObject`,`Comment`) VALUES
(9100034,9001500,0,0,0,1,1,0,-8830.47,648.114,95.0827,5.32415,300,0,0,5342,0,0,0,0,0,'',NULL,0,NULL);
