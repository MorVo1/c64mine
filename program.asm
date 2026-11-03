; vim: set filetype=64tass:

chrout	= $ffd2
clear	= #$93
firstch	= $fb
secch	= $fc

*	 = $0801
	.word (+), 10			; pointer, line number
	.null $9e, format("%4d", start)	; SYS 49152
+	.word 0				; end of BASIC program

*	 = $c051
start	lda clear
	jsr chrout			; clear the screen
	ldx #$41
	stx firstch
	inx
	stx secch
	ldx #$03
	jsr alter
	rts

					; a subroutine for printing X pairs of characters in firstch and secch
alter	cpx #$00
	beq +				; return from subroutine if X=0
-	lda firstch
	jsr chrout			; print the first character
	lda secch
	jsr chrout			; print the second character
	dex
	bne -				; loop
+	rts
