#include "src/globals.h"
#pragma rodataseg ("ROM_01")
#pragma codeseg ("ROM_01")

static const char* messageB = "Second message";
void set_message_from_rom_1() {
	const char* temp = messageB;
	i = 0;
	while(1) {
		if (!*temp) break;
		currentMessage[i] = (*temp++);
		++i;
	}
	currentMessage[i] = '\0';
}