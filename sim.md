---
layout: default
---

#Simulator

This is a 6502 simulator that can assemble, run, and debug code developed by [skilldrick](https://github.com/skilldrick).

{% include asm.html %}

Input you code into the text area and hit `Assemble` and `Run` to see it in action.

You can debug it by checking `Debug` and go through each instruction with `Step`.

If you check `Monitor`, you can see a table of memory.

`Notes` lets you view this (useful on other pages):
{% highlight %}
Memory location $fe contains a new random byte on every instruction.
Memory location $ff contains the ascii code of the last key pressed.

Memory locations $200 to $5ff map to the screen pixels. Different values will
draw different colour pixels. The colours are:

$0: Black
$1: White
$2: Red
$3: Cyan
$4: Purple
$5: Green
$6: Blue
$7: Yellow
$8: Orange
$9: Brown
$a: Light red
$b: Dark grey
$c: Grey
$d: Light green
$e: Light blue
$f: Light grey
{% endhighlight %}
