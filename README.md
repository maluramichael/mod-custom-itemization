# mod-custom-itemization

<!-- links:start -->
[![Support me on Ko-fi](https://malura.de/assets/badge/kofi.svg)](https://malura.de/go/kofi?ref=mod-custom-itemization)
[![Check out my page](https://malura.de/assets/badge/malura.svg)](https://malura.de/go/site?ref=mod-custom-itemization)
<!-- links:end -->

An [AzerothCore](https://www.azerothcore.org/) module (WotLK 3.3.5a) that adds a small,
curated custom gear pack sold by a new vendor NPC. No client patch is required - every
item reuses an existing in-game display model.

## What it adds

- **14 custom items** (entries `9001000`-`9001013`), blue and epic quality, spanning most
  armor slots plus a 1H weapon, a 2H weapon and a ranged weapon.
- **One themed matching-look set**, "Emberwrought Battlegear" (Head / Shoulder / Chest /
  Legs / Hands - 5 pieces). It is a **look only**, not a mechanical set: real item set
  bonuses are read from the client's `ItemSet.dbc`, and patching that file is out of
  scope for this module. The pieces do not use the `itemset` column at all, so they will
  never accidentally borrow an unrelated set's bonus text or effects.
- A vendor NPC, **"Master Artificer"** (creature entry `9001500`), selling all 14 items
  with unlimited stock and no restock timer. The NPC is **not spawned anywhere** by
  default - spawn it wherever you like with:
  ```
  .npc add 9001500
  ```

## Items

| Entry     | Name                             | Slot        | Quality | Notes                       |
|-----------|-----------------------------------|-------------|---------|------------------------------|
| 9001000   | Emberwrought Greathelm             | Head        | Epic    | Emberwrought set (1/5)       |
| 9001001   | Emberwrought Pauldrons             | Shoulder    | Epic    | Emberwrought set (2/5)       |
| 9001002   | Emberwrought Battleplate           | Chest       | Epic    | Emberwrought set (3/5)       |
| 9001003   | Emberwrought Legguards             | Legs        | Epic    | Emberwrought set (4/5)       |
| 9001004   | Emberwrought Gauntlets             | Hands       | Epic    | Emberwrought set (5/5)       |
| 9001005   | Girdle of the Unbroken Line        | Waist       | Blue    | Plate                        |
| 9001006   | Sabatons of the Long March         | Feet        | Blue    | Plate                        |
| 9001007   | Bracers of Grim Resolve            | Wrist       | Blue    | Plate                        |
| 9001008   | Mantle of the Cinder Wyrm          | Cloak       | Epic    | Cloth, caster                |
| 9001009   | Sunfallen Hauberk                  | Chest       | Epic    | Leather, agility             |
| 9001010   | Ringmail of the Drowned Chorus     | Chest       | Epic    | Mail, agility                |
| 9001011   | Duskfang, Blade of Whispers        | 1H weapon   | Epic    | Sword                        |
| 9001012   | Voidcaller's Focus                 | 2H weapon   | Epic    | Staff, caster                |
| 9001013   | Longbow of the Silent Hunt         | Ranged      | Epic    | Bow                          |

All items bind on pickup and are sold only by Master Artificer.

## Configuration

`conf/mod_custom_itemization.conf.dist`:

| Key                            | Default | Description                                              |
|---------------------------------|---------|------------------------------------------------------------|
| `CustomItemization.Enable`      | `1`     | Master on/off switch for the module's own C++ hook. The SQL content (items, NPC, vendor list) is always present in the world database regardless of this setting - it only gates this module's loader-level logic. |

## Installation

Clone into your AzerothCore `modules/` directory, rebuild the worldserver, and let the DB
updater apply this module's SQL file on next boot. Then spawn the vendor with
`.npc add 9001500` wherever you'd like it.

## License

Released under the GNU GPL v2 (or later).
