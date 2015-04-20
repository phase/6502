---
layout: default
---

<h1 id="info">What's a 6502?</h1>
The [6502 processor](http://en.m.wikipedia.org/wiki/MOS_Technology_6502) was used in a lot of gaming console during the 80's, including the NES, Apple II, Commodore 64 (who later bought the company that made the 6502!), multiple Atari machines, and tons more. It's instruction set is known as *6502 Assembly*, or just *6502*.

##Why do I want to learn it?
Why not? It's a fun language that can be ported to many different systems! It's heavily used in the [NES development](http://nesdev.com/) community, which actively *make* NES games for emulators and consoles. Something like x86 may be used more today, but there's no real reason why you wouldn't use a language that compiles into x86. Until someone create a language that compiles to 6502, we'll all be stuck here coding it.

<h1 id="tutorial">Tutorial</h1>
Let's dive on in! We'll be using a simulator made by [skilldrick](https://github.com/skilldrick) in Javascript. You can find more info on the [simulator](/6502/sim) page.

{% include asm-start.html %}
{% include_relative asm/diveOnIn.asm %}
{% include asm-end.html %}

Not like any OOP, now is it? 6502 uses a variety of instructions to get it's job done, each of which may contain an argument.

The first instruction is `lda`, or `LoaD to register A`, and it's argument is the number you want loaded. There are three registers on the 6502, `A`, `X`, and `Y`, which temporarily store information. Using `lda`, we can load whatever number we want onto the `A` register.

Numbers can have two different meanings. If they have a `#` before it, they are the number itself. If not, it's redirected to the location in memory of that number. A `$` before a number means it's in hexadecimal, or base 16. So, the `#$01` means that `lda` is going to load `1` into register `A` (as you can see by the `A=` changing to the number `01` in the Debug menu).

Data stored between `$200` and `$5ff` will be displayed on the screen to the right. The color will depend on the value stored.

The second instruction is `sta`, or `STore what's on A`. This will take the number on register `A` and store it at the provided memory location. So, `sta $020` store the `#$01` that is on `A`.
