> [!WARNING]
> This plugin is unmaintained since Torn Banner's acquisition of the game.

# [NMRiH] Sprinting Stamina Fix
This plugin fixes a bug that allows players to sprint without losing stamina by repeatedly starting and stopping their sprint while holding down the sprint button, also knowns as "half sprint". This bug also enables players to jump farther than usual due to the increase in velocity.

Some experienced players enjoy this bug and consider it a skillful technique. Use it at your own discretion!

Demo:

https://github.com/dysphie/nmrih-sprinting-stamina-fix/assets/11559683/4dbca9a0-ab4c-4b86-adfb-4155a235e911


Also untested on Linux, report any issues you find.

## Installation
- Download the .smx file and place it in your plugins folder.
- Load the plugin (`sm plugins load sprinting-stamina-fix`).

## Configuration
This plugin has a cvar that can be added to `server.cfg`:

| Cvar | Default | Description |
| --- | --- | --- |
| sm_stamina_glitch_fix | 1 | Enables or disables the plugin. 0 = off, 1 = on |
