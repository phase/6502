---
layout: default
---

# NES Development

Here we will be learning how to make games for the NES using 6502 Assembly. The NES uses a modified 6502, so not everything is the same. There also won't be code simulators (yet).

## Background
The first "game" we are going to create will show how to create a background and change the color. All of the source code is on [GitHub](https://github.com/phase/6502/blob/gh-pages/asm/nes/background/background.asm).

### Setting Up

The first thing you want to do is download [NESASM3](http://www.nespowerpak.com/nesasm/NESASM3.zip), which compiles Assembly code into `.nes` files. You might want to add it to your Path for later use.

After setting up NESASM, you're going to want to grab an emulator. I recommend [FCEUXD SP](http://www.the-interweb.com/serendipity/exit.php?url_id=627_id=90). It has a great Debugger and loads of options.

Next, create an Assembly file. For this tutorial, we'll be using `background.asm`. To compile it, run `NESASM3 background.asm` in your shell. It should come up with `pass 1` and `pass 2`. Stick the `.nes` file in your emulator and you're ready to go!

### iNes Header
The 16 byte iNES header gives the NES all the information about the game including mapper, graphics mirroring, and PRG/CHR sizes. This will be the start of your file.
{% highlight Ca65 %}
  .inesprg 1   ; 1x 16KB bank of PRG code
  .ineschr 1   ; 1x 8KB bank of CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring (ignore for now)
{% endhighlight %}

### Reseting the system
Next, we need to reset the system. This will clear the memory and reset various things. You can put this in your code right after the header.
{% highlight Ca65 %}
  .bank 0
  .org $C000 
RESET:
  sei          ; disable IRQs
  cld          ; disable decimal mode
  ldx #$40
  stx $4017    ; disable APU frame IRQ
  ldx #$FF
  txs          ; Set up stack
  inx          ; now X = 0
  stx $2000    ; disable NMI
  stx $2001    ; disable rendering
  stx $4010    ; disable DMC IRQs

vblankwait1:       ; First wait for vblank to make sure PPU is ready
  bit $2002
  bpl vblankwait1

clrmem:
  lda #$00
  sta $0000, x
  sta $0100, x
  sta $0200, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  lda #$FE
  sta $0300, x
  inx
  bne clrmem
   
vblankwait2:      ; Second wait for vblank, PPU is ready after this
  bit $2002
  bpl vblankwait2
{% endhighlight %}

### Rendering a background
For now, we're only going to render a background color. To do this, we will be writing to a special byte of memory.

The byte `$2001` renders the color of the background. Inputting a binary number, we can add a variety of options.
<pre>
76543210
||||||||
|||||||+- Grayscale (0: normal color; 1: AND all palette entries
|||||||   with 0x30, effectively producing a monochrome display;
|||||||   note that colour emphasis STILL works when this is on!)
||||||+-- Disable background clipping in leftmost 8 pixels of screen
|||||+--- Disable sprite clipping in leftmost 8 pixels of screen
||||+---- Enable background rendering
|||+----- Enable sprite rendering
||+------ Intensify reds (and darken other colors)
|+------- Intensify greens (and darken other colors)
+-------- Intensify blues (and darken other colors)</pre>

{% highlight Ca65 %}
  lda #%100000   ;intensify blue
  sta $2001
{% endhighlight %}
