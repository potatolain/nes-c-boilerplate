/**
 * NES Boilerplate library
 * Some helper functions beyond what neslib provides. Mainly focused around bank switching, etc.
 Implementations can be found in boilerplate.asm
 */

#define MIRROR_LOWER_BANK 0
#define MIRROR_UPPER_BANK 1
#define MIRROR_VERTICAL 2
#define MIRROR_HORIZONTAL 3

// Switch to the given bank. Your prior bank is not saved, so be sure to save it if you need to switch back.
// bank_id: The bank to switch to.
// returns: The current bank.
unsigned char __fastcall__ set_prg_bank(unsigned char bank_id);

// Get the current bank.
// returns: The current bank.
unsigned char __fastcall__ get_prg_bank(void);

// Switch to the given bank for a short period. Use with restore_bank.
// NOTE: It is an error to call this more than once. If you can't see your restore_bank call when you do this,
// you should probably be using switch_bank instead.
// bank_id: The bank to switch to
void __fastcall__ temp_switch_prg_bank(unsigned char bank_id);

// Switch back to a bank after using switch_bank_temp
void __fastcall__ temp_restore_prg_bank(void);

// Set the current 1st 4k chr bank to the bank with this id.
void __fastcall__ set_chr_bank_0(unsigned char bank_id);

// Set the current 2nd 4k chr bank to the bank with this id.
void __fastcall__ set_chr_bank_1(unsigned char bank_id);

// Set the current mirroring mode. Your options are MIRROR_LOWER_BANK, MIRROR_UPPER_BANK, 
// MIRROR_HORIZONTAL, and MIRROR_VERTICAL.
void __fastcall__ set_mirroring(unsigned char mirroring);