---
layout: default
---

# NES Development

Here we will be learning how to make games for the NES using 6502 Assembly. The NES uses a modified 6502, so not everything is the same. There also won't be code simulators (yet).

## Background
The first "game" we are going to create will show how to create a background and change the color. All of the source code is on [GitHub](https://github.com/phase/6502/blob/gh-pages/asm/nes/background/background.asm).

### iNes Header
The 16 byte iNES header gives the NES all the information about the game including mapper, graphics mirroring, and PRG/CHR sizes. You can include all this inside your asm file at the very beginning.
{% highlight Assembly %}
  .inesprg 1   ; 1x 16KB bank of PRG code
  .ineschr 1   ; 1x 8KB bank of CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring (ignore for now)
{& endhighlight %}
