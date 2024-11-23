![https://i.imgur.com/ZxfrneW.png](https://i.imgur.com/ZxfrneW.png)


#### ***True Scrolls*** introduces D&D 5e mechanics for casting and scribing scrolls into Baldur's Gate 3 entirely Rules As Written.

### Requires [Norbyte's Script Extender](https://github.com/Norbyte/bg3se/releases)﻿

### Nexus: https://www.nexusmods.com/baldursgate3/mods/13894

![https://i.imgur.com/BEcO3dq.png](https://i.imgur.com/BEcO3dq.png)
> *A spell scroll bears the words of a single spell, written in a mystical cipher. If the spell is on your class’s spell list, you can read the scroll and cast its spell without providing any material components. Otherwise, the scroll is unintelligible. Casting the spell by reading the scroll requires the spell’s normal casting time. Once the spell is cast, the words on the scroll fade, and it crumbles to dust. If the casting is interrupted, the scroll is not lost.*

A scroll can no longer be used by a character if the spell isn't on a spell list of their class or subclass. For example, a Cleric will not be able to cast Fireball, unless they're a Light Domain Cleric, nor will a Sorcerer be able to cast Planar Binding from a scroll without multiclassing.

There are a few exceptions to this rule. For example, a bard will be able to use scrolls to cast spells that they chose as their magical secrets because they become bard spells in this case, and Artificers starting at level 14 can cast from any scroll.

***Note:*** Additionally, there is a setting to allow Thief Rogue to cast from scrolls with their Use Magic Device ability starting at level 13.

> *If the spell is on your class's spell list but of a higher level than you can normally cast, you must make an ability check using your spellcasting ability to determine whether you cast it successfully. The DC equals 10 + the spell's level. On a failed check, the spell disappears from the scroll with no other effect.

Once the spell is cast, the words on the scroll fade, and the scroll itself crumbles to dust.*

Whenever a character attempts to use a scroll to cast a spell of a higher level than they can normally cast **as the class that contains the spell in its spell list**, they have to make a roll using the spellcasting ability of that class. On a failed attempt, the scroll is destroyed and the caster's action is used up.

***True Scroll*** keeps track of all the party members to make sure that they always roll using their best abilities in cases when a spell is available in multiple spell lists. For example, a Knowledge Domain Cleric / Sorcerer multiclass below level 7 that has higher Wisdom would roll a Wisdom check when casting Confusion from a scroll.

To explain this further:

* If you attempt to use a Revivify scroll as a Cleric below level 5 you will roll a Wisdom check.
* As a Sorcerer 5 / Cleric 1 you will still roll a Wisdom check, even though you have a third level spell slot, since you couldn't cast Revivify as a Cleric yet.
* As a Paladin 5 / Cleric 1 with higher Charisma than Wisdom, you will roll a Charisma ability check.
* As a Paladin 5 / Cleric 5, you won't have to roll when casting Revivify, since you can cast it as a Cleric.

***Note:*** As this is a fairly common point of contention that often requires table rulings, this can be changed to allow casting as long as the character has a spell slot of the same level or higher than the spell on the scroll.

> *he level of the spell on the scroll determines the spell's saving throw DC and attack bonus, as well as the scroll's rarity, as shown in the 
Spell Scroll table.*

All spells that require an attack roll now have a static attack roll bonus when cast from a scroll, which depends on the level of the spell. This means that none of the caster's bonuses like their proficiency, ability modifier, bonuses from items and others like arcane acuity are taken into account when rolling an attack.

Similarly, when a spell cast from a scroll requires a saving throw like Fireball or Hold Person, the caster's Spell Save DC is replaced by a static DC based on the spell level of the scroll.

***Note:*** You'll see "Scroll Casting" as one of the modifiers in your spell attack log. The way it's calculated is* scroll attack bonus - ability modifier - proficiency. *Bonuses from items and other sources like arcane acuity will show 0 instead.

***Note:*** Spell Save DC change requires updating spell scroll items. You'll see a notification about scrolls being added to your inventory on the first save load.

![https://i.imgur.com/rMbn0zn.png](https://i.imgur.com/rMbn0zn.png)

> *A wizard spell on a spell scroll can be copied just as spells in spellbooks can be copied. When a spell is copied from a spell scroll, the copier must succeed on an Intelligence (Arcana) check with a DC equal to 10 + the spell's level. If the check succeeds, the spell is successfully copied. Whether the check succeeds or fails, the spell scroll is destroyed.*

Each time a wizard attempts to scribe a scroll, they must succeed on an Arcana check in order to do so. That goes for each individual spell scroll even if you try to learn multiple at once like the game allows.

![https://i.imgur.com/8ZUoJBX.png](https://i.imgur.com/8ZUoJBX.png)

***True Scrolls*** is fully customizable with [Mod Configuration Menu](https://www.nexusmods.com/baldursgate3/mods/9162) to allow various common rulings and interpretations.

In addition to shared global settings, each character or player can override them depending on their preference. For example, enabling "Thief Can Use Scrolls" will allow a Thief Rogue to cast from scrolls starting at level 13, but will still require to make an ability check without a spellcasting modifier. Disabling "Casting Ability Check" only for the rogue will effectively interpret their Use Magic Device ability as not requiring a roll.

Settings take effect immediately, so you always have an option to change your mind even in the middle of combat.

***Note:*** If you disable "Spell List Restrictions", for spells not on your spell lists you will roll an ability check using your default spellcasting ability like in vanilla. Martials without one will roll an Intelligence check with a modified DC, effectively rolling with a modifier +0, as the game requires an ability for a roll.

![https://i.imgur.com/M9Rssk6.png](https://i.imgur.com/M9Rssk6.png)
![https://i.imgur.com/SGrBOLP.png](https://i.imgur.com/SGrBOLP.png)
### REQUIREMENTS
### [Norbyte's Script Extender](https://github.com/Norbyte/bg3se/releases)

### INSTALLING
### [LaughingLeader's Mod Manager](https://github.com/LaughingLeader/BG3ModManager/releases)

### UNINSTALLING
If you want to uninstall ***True Scrolls*** mid-campaign:
1. Disable "Static Spell Save DC".
1. Save your game.
1. Uninstall using Mod Manager.

### COMPATIBILITY & SUPPORT
* Modded classes and subclasses should all function correctly without any patches.
* [Artificer class and all subclasses](https://www.nexusmods.com/baldursgate3/mods/1779) is supported, allowing Artificers to use any scroll from level 14.
* All mods that extend the progression to levels above 12 with regard to Artificer and Thief abilities are supported.
* [Secret Scrolls](https://www.nexusmods.com/baldursgate3/mods/416)﻿ and [Secret Scrolls for 5e Spells](https://www.nexusmods.com/baldursgate3/mods/2145/)﻿ are fully supported.
* Any other mods that add scrolls are most likely supported, but will use the caster's spell save DC.
* [Mod Configuration Menu](https://www.nexusmods.com/baldursgate3/mods/9162) is required to access the settings. Otherwise, default rules will be applied.
