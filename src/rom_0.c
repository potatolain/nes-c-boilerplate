#include "src/globals.h"
#pragma rodataseg ("ROM_00")
#pragma codeseg ("ROM_00")

static const char* messageA = "First message ";
void set_message_from_rom_0() {
	const char* temp = messageA;
	i = 0;
	while(1) {
		if (!*temp) break;
		currentMessage[i] = (*temp++);
		++i;
	}
	currentMessage[i] = '\0';
}