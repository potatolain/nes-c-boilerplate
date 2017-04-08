# Famitone2

This library is actually integrated with neslib, so we don't need most of it. That said, we do need its
converter to turn your music into asm. 

## Windows users

Extract famitone2.zip here. We'll use the windows binaries in the tools/ folder.

## Other OSes

If you can port nsf2data and sfx2data to linux successfully, let me know. I got pretty close,
but I started hitting core dumps I didn't care to debug. You'll have to update the makefile to
use your binaries; I have a check that complains if you're on a non-windows OS in there. 

I'm not urgently rushing to fix this, since Famitracker is a Windows program. If you've got the
ability to run Famitracker, you've likely got the ability to build your music/sfx in the same way.