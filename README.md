# NES C Boilerplate 

This is meant to be a quick boilerplate library for games coded in C using cc65, neslib and the like. Has a hello
world rom that you can rename and hack at to suit your fancy. Released under the MIT license, so do with it 
what you like. Happy Hacking!

## Specs/Contents
- Neslib
- MMC1 ROM 256KB PRG ROM and 8k of chr rom.
  - compiler/assembler config
- nes_boilerplate library with helper functions that extend neslib
  - Switch PRG banks
- famitone2 
  - makefile-based compiling from nsf/txt files. (Windows only)
- makefile with commands to build, run, and more.
- CircleCI integration (Optional)
-- Build your ROM on every commit for free, as long as it's open source!
-- CircleCI Build details available to rom at build time. Ever want to show a build number in your rom?
- Auto-generated header file with build stats.

# Boilerplate Functions

These functions are meant to help facilitate mmc1 features such as prg bankswitching. Include them by including `boilerplate.h`.

### unsigned char set_prg_bank(unsigned char bank_id)
- **Inputs**: 
  - bank_id: The id of the prg bank to switch to.
- **Returns**: The id of the prior prg bank that you switched away from.
- **Description**: Sets the current prg bank to whatever id is passed in.

### unsigned char get_prg_bank(void)
- **Inputs**:
  - *N/A*
- **Returns**: The id of the prg bank that is currently in use.
- **Description**: Get the current prg bank.

### void temp_switch_prg_bank(unsigned char bank_id)
- **Inputs**:
  - bank_id: The bank to switch to
- **Returns**: *N/A*
- **Description**: Temporarily set the current PRG bank. Easily revesed with `temp_restore_prg_bank()`. Note that 
                   nested calls to this method *will not work*. This only caches a single bank.

### void temp_restore_prg_bank()
- **Inputs**:
  - *N/A*
- **Returns**: *N/A*
- **Description**: Returns from a temporary bank switch with `temp_switch_prg_bank(bank_id)`.

### void set_chr_bank_0(unsigned char bank_id)
- **Inputs**:
  - bank_id: The id of the chr bank to switch to.
- **Returns**: *N/A*
- **Description**: Switches the first **4k** bank of chr tiles to the given bank. These are 4k banks, so if you
                   are using 8k files (like the example) remember each file represents 2 banks, and thus 2 ids.

### void set_chr_bank_1(unsigned char bank_id)
- **Inputs**:
  - bank_id: The id of the chr bank to switch to.
- **Returns**: *N/A*
- **Description**: Switches the second **4k** bank of chr tiles to the given bank. These are 4k banks, so if you
                   are using 8k files (like the example) remember each file represents 2 banks, and thus 2 ids.

### void set_mirroring(unsigned char mirroring)
- **Inputs**: 
  - mirroring: Value to set mirroring to. The most common options are MIRROR_VERTICAL and MIRROR_HORIZONTAL.
               If for some reason you'd like single screen mirroring, you can use either MIRROR_LOWER_BANK
               or MIRROR_UPPER_BANK.
- **Returns**: *N/A*
- **Description**: MMC1 allows you to change the mirroring mode of the game on the fly. This method wraps that
                   for you. Pass it one of the constants defined for a mirroring mode.


# Working with Sound Effects and Music

This repository tries to make working with famitone2/famitracker a little easier. Unfortunately we can't extract
directly from the native format for famitracker/famitone, so any time you make changes you will have to remember
to export them to nsf (sound effects) or txt. (music) If you extract to `sound/music.txt` and 
`sound/sfx.nsf`, the makefile will automatically compile these into assembly. The compiled files are then included
by the bootstrap script. (`lib/crt0.asm`) 

**Important note**: This feature only works on Windows. The nsf2data and text2data tools for famitone2 are written
for Windows, and haven't yet been ported. As such, make sure you include your music.s and sfx.s files in git. (Sorry!) 

# CircleCI

This repo allows for easy integration with CircleCI if you're using a public Github repo. If you go to
http://circleci.com and sign in, you can turn on automatic builds for it, then on each commit, CircleCI will
build your rom using the makefile. Configuration is in `circle.yml` in the root of the repo. 

You can also link to the latest artifacts from your readme (or wherever) using the circleci-tkn service. Check
that out here: https://circleci-tkn.rhcloud.com. 

Example from this repo: 
[Download Rom](https://circleci-tkn.rhcloud.com/api/v1/project/cppchriscpp/nes-c-boilerplate/tree/master/latest/artifacts/hello_world.nes)

# Other Useful Stuff

## VSCode keyboard shortcuts

There are some predefined tasks for vs-code in the .vscode directory. If you want, you can add keybindings for
compiling so you only have to press f6 to compile and run with fceux, for example. Here's some sane defaults.
You will have to add these to your `keybindings.json` file in VS Code settings.

```json
[
	{"key": "f6", "command": "workbench.action.tasks.build"},
	{"key": "f5", "command": "workbench.action.tasks.runTask", "args": "debug"},
]
```

# Credits

[NESLib](https://shiru.untergrund.net/software.shtml) by [Shiru](http://shiru.untergrund.net/)

[Who's Cuter Font](https://forums.nesdev.com/viewtopic.php?f=21&t=10284&start=0) by [Damian Yerrick (Tepples)](http://pineight.com)

# Contributing

I don't have any set rules around this right now. If you've got something you'd like to add, just send over a pull 
request, and I'm sure we can get something together.

# Future Improvements

These are things I'd like to do, but haven't taken the time yet.
- Add a prepare_cart method to strip the headers. (Cross-platform ideally)
- Install script for cc65 to simplify non-windows installs (Since we're already figuring it out for circle)
- Generate proper output for nintendulatordx based debugging
- Support compressed nametables
