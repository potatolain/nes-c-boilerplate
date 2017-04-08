# This attempts to build the game for you. 
# Note: This is a pretty poor excuse for a makefile. I'd look elsewhere for better examples. 
# Prequisites:
# - A few fairly standard unix applications available; Gow/Cygwin installed for Windows.
# - ca65 binaries in the tools folder

### USER EDITABLE STUFF STARTS HERE

ROM_NAME=hello_world
OBJECTS_TO_BUILD=$(ROM_NAME).c bin/crt0.o bin/$(ROM_NAME).o bin/rom_0.o bin/rom_1.o

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAIN_COMPILER=./tools/cc65/bin/cc65
MAIN_ASM_COMPILER=./tools/cc65/bin/ca65
MAIN_LINKER=./tools/cc65/bin/ld65
MAIN_EMULATOR=tools/fceux/fceux
DEBUG_EMULATOR=tools/nintendulatordx/nintendulator
SPACE_CHECKER=tools/nessc/nessc
CONFIG_FILE=$(ROOT_DIR)/cfg/game.cfg
ifeq ($(OS),Windows_NT)
	TEXT2DATA=tools/famitone2/tools/text2data
	NSF2DATA=tools/famitone2/tools/nsf2data
else
	TEXT2DATA=echo Music compilation can only be done under Windows. There isn't a good linux/osx port. Exiting without doing anything. 
	NSF2DATA=echo Sound effect compilation can only be done under Windows. There isn't a good linux/osx port. Exiting without doing anything.
endif

### USER EDITABLE STUFF ENDS HERE

.PHONY: clean fceux run nintendulator debug space_check 

all: $(ROM_NAME).nes

bin/%.s: %.c
	$(MAIN_COMPILER) -Oi $< --add-source --include-dir ./tools/cc65/include -o $@

bin/%.s: src/%.c
	$(MAIN_COMPILER) -Oi $< --add-source --include-dir ./tools/cc65/include -o $@

bin/crt0.o: lib/crt0.asm sound/sfx.s sound/music.s lib/boilerplate.asm
	$(MAIN_ASM_COMPILER) lib/crt0.asm -o bin/crt0.o

sound/sfx.s: sound/sfx.nsf
	$(NSF2DATA) sound/sfx.nsf -ntsc -ca65

sound/music.s: sound/music.txt
	$(TEXT2DATA) sound/music.txt -ca65 -ntsc

bin/%.o: bin/%.s
	$(MAIN_ASM_COMPILER) $<

$(ROM_NAME).nes: $(OBJECTS_TO_BUILD)
	$(MAIN_LINKER) -C $(CONFIG_FILE) -o $(ROM_NAME).nes bin/*.o lib/runtime.lib

fceux:
	$(MAIN_EMULATOR) $(ROM_NAME).nes
	
run: fceux

nintendulator:
	$(DEBUG_EMULATOR) $(ROM_NAME).nes

debug: nintendulator

space_check:
ifeq ($(OS),Windows_NT)
	$(SPACE_CHECKER) $(ROM_NAME).nes
else
	@echo "Space check is only available on Windows right now, sorry!"
endif

clean:
	-rm -f *.nes
	-rm -f *.o
	-rm -f bin/*.o
	-rm -f bin/*.s

