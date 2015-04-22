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
{% highlight Assembly %}
  .inesprg 1   ; 1x 16KB bank of PRG code
  .ineschr 1   ; 1x 8KB bank of CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring (ignore for now)
{% endhighlight %}
