; Display Disco across the screen
start:
  inx
  txa
  sta $200, y
  sta $300, y
  sta $400, y
  sta $500, y
  iny
  tya
  cmp 16
  bne loop
  iny
  jmp start

loop:
  iny
  iny
  iny
  iny
  jmp start
