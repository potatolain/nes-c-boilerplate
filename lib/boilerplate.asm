.feature c_comments
.linecont +

.export _set_prg_bank, _get_prg_bank, _temp_switch_prg_bank, _temp_restore_prg_bank, _set_chr_bank_0, _set_chr_bank_1

_set_prg_bank:
    ; Grab old bank and store it temporarily.
    ldx BP_BANK
    ; Store new bank into BP_BANK
    sta BP_BANK

    ; Write it to the reg (destroys a)
    mmc1_register_write MMC1_PRG
    txa ; Old bank's back!

    rts

_get_prg_bank:
    lda BP_BANK
    rts

_temp_switch_prg_bank: 
    ; Cache the current bank into BP_BANK_TEMP
    ldx BP_BANK
    stx BP_BANK_TEMP
    jmp _set_prg_bank ; Just do the regular bank switch past this point. We stored off what we care about.
    rts

_temp_restore_prg_bank:
    ; Load the bank we want to restore from before
    lda BP_BANK_TEMP 
    jmp _set_prg_bank  ; And call the same old method again.
    rts

_set_chr_bank_0:
    mmc1_register_write MMC1_CHR0
    rts

_set_chr_bank_1:
    mmc1_register_write MMC1_CHR1