ldx #$0d  ;Load 0d in X
stx $0200 ;Store X in 0200
txa       ;Transfer X to A
inx       ;Increment X
stx $0201 ;Store X in 0201
sta $0202 ;Store A in 0202
