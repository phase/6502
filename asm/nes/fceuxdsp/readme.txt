FCEUXD SP 1.07

1. Introduction

FCEUXD SP is a NES Emulator based on the source code of FCE Ultra eXtended-Debug 1.0a.
It's only goal is to improve the debugging experience of NES roms.

2. History

February 01, 2007: Version 1.07
- New: Added RAM Filter

December 15, 2005: Version 1.06
- Bugfix: Fixed a bug in the conditional breakpoint code
- Change: *.deb Debug files are now only created if the user actually debugged the game

September 04, 2005: Version 1.05
- New: Added range options for freezing / unfreezing addresses
- New: Added dump RAM to file option
- New: Added dump PPU memory to file option
- New: Readme file fceuxd.txt from FCE Ultra Extended Debugger is now included (read this if you want to learn about the debugger)
- Change: Increased the maximum number of frozen addresses
- Bugfix: NL files for banks at 0x8000 work again
- Bugfix: Empty comments work properly again
- Bugfix: Fixed a breakpoint persistence problem

August 31, 2005: Version 1.04
- New: Better error handling
- New: Invalid lines in NL files are now shown to the user instead of being silently ignored
       This gives the user the opportunity to fix erroneous lines.
- New: Good news for other developers, all C files added by me are now fully documented.
- Change: Array indices in disassembly windows are now hexadecimal values.
- Bugfix: Fixed a bug that occured when loading the bookmark description of hex bookmarks from disk
- Bugfix: Fixed a bug that occured when using arrays and long comments in symbolic debugging
- Bugfix: Fixed a bug that occured when reading NL files

July 31, 2005: Version 1.03

- New: Added register P (Program Counter) to the conditional breakpoint expressions.
- New: There's a new name list file for symbolic debugging. Put all debugging information
       for addresses < $8000 into the name list file romname.nes.ram.nl.
- New: Added a feature to NL files to support arrays.
- Bugfix: Names for offsets can now be properly distinguished from byte values. All
          offsets have the four-byte format $XXXX now (including zero-page offsets)
          while all byte values have the two-byte format ($XX). This fixes some bugs
          and issues with NL files.

July 17, 2005: Version 1.02

- New: Added hotkey F6 to open hex window.
- New: Added bookmarks to the hex window.
- New: Debugging data like breakpoints or bookmarks are automatically saved and restored
       when games are closed / opened.
- New: Increased the size of the mouse-over information area below the diassembly window
- New: Added name list file information for addresses to the mouse-over information area
- New: It's now possible to give breakpoints a brief description/name.
- Bugfix: Inline Assembler works for all lines again.
- Bugfix: Deleting breakpoints correctly updates breakpoint conditions now.

June 30, 2005: Version 1.01

- New: Significantly better conditional breakpoints
- New: Multi-line comments are now allowed in symbolic debugging mode
- New: Added the possibility to reload the *.nl files
- New: Added the possibility to enable / disable symbolic debugging
- New: Increased the number of visible lines in the disassembly window to 34.
- New: Added disassembly bookmarks
- Bugfix: Conditional breakpoints can now be removed again.

June 24, 2005: Initial release

3. Differences to FCE Ultra eXtended-Debug 1.0a

3.1 Symbolic Debugging

The most important feature (at least for me) that was introduced in FCEUXD SP is symbolic debugging.
With this new feature it's possible to rename addresses in the disassembly window (like $C022) to
easily understandable names (like AddHealthpoints). It's also possible to add comments to lines
in the disassembly window.

To be able to use this feature it's necessary to create so called name list files (*.nl) which
contain all names and comments you wish to display in the disassembly window. These files are
plain ASCII files of the following format (example follows):

$C000#NewName1#Comment1
$C002##Comment2
$C004#NewName2#
$C006#NewName3#MultilineComment-Part1
\MultilineComment-Part2
\MultilineComment-Part3
$C008/10#NewName4#

Every line contains two # characters which separate the three parts of one line:
The first part (starting with a $ character) is the address to be renamed. Optionally you can add
a "/number" part which marks the offsets as a beginning of an array of the given size (the size
must be specified in hex form).
The second (optional) part is the new name of that address. Whenever the line of that address
is shown in the disassembly window an extra line saying "Name: NewName" is shown above it.
Instructions referencing this address, for example JSR $C000 are also changed to JSR NewName1
(in that example).
The third (optional) part is the comment that's also added above the disassembly line the comment
refers to. It works exactly like the additional name line, only the prefix of that line is
different. Comment lines start with "Comment: " rather than with "Name: ". Multi-lines comments
are possible. Lines starting with a \ character are just appended to the comment of the preceding
line. Multi-line comments are also shown in multiple lines in the disassembly window.

Let's get back to the example.
The first line contains all three parts. Using this name list file all references to the address
$C000 are replaced with NewName1 and whenever line $C000 is shown in the disassembly window an
additional comment is also visible right above the actual disassembled line.
The second line defines only a comment while the third line defines only a name. Following that
there's a multi-line comment definition for address $C006.
The last line defines an array called NewName4 of size $10 (= 16) bytes starting at offset $C008.

Now you know the format of the nl files but you do not yet know the naming convention for the
file names. Due to the bank-swapping nature of the NES it's getting a little bit difficult here.
Each bank needs it's own nl file. The naming convention goes like this: Take the name of the ROM
file and just add ".X.nl" to it where the X is the hexadecimal representation of the number of the
ROM bank. Suppose you have the ROM file "Faxanadu (U).nes" and you want to create a nl file for
ROM bank 15. As 15 is 0x0F in hex the name of the nl file would be "Faxanadu (U).nes.F.nl". All
nl files go into the same directory as the ROM file itself.

You can enable and disable symbolic debugging by clicking the checkbox "Symbolic Debugging" in
the debugger window. To forcibly reload the nl files of the currently active ROM file press the
button with the text "Reload Symbols".

New in 1.03:

The array feature is an easy way to group names and comments for sequential offsets.

$C000/5#NewName1#Comment1

is equivalent to

$C000#NewName1#Comment1
$C001#NewName1#Comment1
$C002#NewName1#Comment1
$C003#NewName1#Comment1
$C004#NewName1#Comment1


3.2 Conditional breakpoints

Conditional breakpoints were the 2nd feature added to FCEUXD SP. They allow the user to define a
condition for a breakpoint. That means that breakpoint is only executed if the attached condition
is true in addition to the already existing breakpoint functionality from FCEUXD. Conditions are
entered in an additional edit field in the Add/Edit Breakpoint dialogs. They are specified in a
simple pseudo-C style syntax. Here are the elements that can be used in conditional expressions.

The registers A, X, Y and PC can be used in conditional expressions using the characters A, X, Y and P.
The flags N, V, U, B, D, I, Z, C can be used in conditional expressions using the characters
N, V, U, B, D, I, Z and C.
All numbers are specified in hexadecimal representation starting with the character #.
Values of bytes at certain addresses in the CPU memory can be accessed using the hexadecimal value
of the address starting with a $ character.
If you don't know the exact address you want to check either you can access the memory using
expressions too. In that case use the syntax $[expression], for example $[#2CC + X]. When the
breakpoint is triggered the expression inside the brackets is evaluated and the memory is
read at the position of the result of the expression.

Valid operators to use in the expressions are + (addition), - (subtraction), * (multiplication),
/ (division), == (equal), != (not equal), <= (less or equal), >= (greater or equal), < (less),
> (greater), || (or) and && (and).

C rules apply when determining whether an expression is true. Since version 1.01 it's not necessary
to compare values to evaluate them to a boolean value (e.g. C == #1 to check if the C flag is set).
Expressions that evaluate to 0 are now considered false, expressions that evaluate to another
value are considered true. To check if the C flag is set now it's enough to write "C".

Here are some examples:
A != X && C: The value of register A does not equal the value of register X and the C flag is set.
$2CC == #FF || $2CC == A: The value of the byte at address $2CC equals 0xFF or the value of the register A.
$8000 >= #0 && $8000 <= #10: The value of the byte at address $8000 is between 0x00 and 0x10
$[#2CC + X] == #34: The value of the byte at address $2CC + X is 0x34.
$333 == X * #20: The value of the byte at address $333 is the value of X multiplied by 0x20.

3.3 CPU Bookmarks

To allow easy access to addresses in the disassembly window it's possible to define bookmarks
in the debugger window. To add a new bookmark enter the address (in hex representation) in the
edit field in the Bookmark box and click the "Add" button. To go to that address then double-click
the address in the list box next to the "Add" button. To remove a bookmark select it in the list box
and click the "Delete" button.

3.4 Additional disassembly lines

34 instead of 25 visible lines of disassembled code. More disassembled lines are always good for
getting an understanding of the code you're looking at. What really made the enlargement of the
disassembly window necessary were the multi-line comments. It's a common occurence to have 8-line
comments for flag collection bytes, having one line + comments take 1/3rd of the disassembly window
was quite annoying.

3.5 Removed the Close button from the debugger window

The Close button didn't really serve any purpose but took away some space that could be necessary
at one point. I'm relatively certain that it won't be missed because it didn't even work in
FCE Ultra eXtended-Debug

3.6. RAM Filter

You can use the RAM Filter to detect changes in RAM. RAM Filter allows you to set up rules
like "byte changed from 00 to 13" or "byte value is now greater than before". That way you can
eliminate all bytes you're not looking for until only a few potential candidates are left.

-- Written by sp (February 2007)
