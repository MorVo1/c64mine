; vim: set filetype=64tass:

chrout	= $ffd2
clear	= #$93
firstch	= $fb
secch	= $fc
newline	= #$0d

*	 = $0801
	.word (+), 10			; pointer, line number
	.null $9e, format("%4d", start)	; SYS 49152
+	.word 0				; end of BASIC program

*	 = $c051
start	lda clear
	jsr chrout			; clear the screen
	lda #$15
	sta $d018			; set uppercase mode
	lda #$b0			; top-left corner character
	jsr chrout			; print it
	lda #$60			; horizontal line character
	sta firstch			; store it in the first character variable
	lda #$b2			; up tack character
	sta secch			; store it in the second character variable
	ldx #$08
	jsr alter			; print 8 pairs + 1 of characters specified above
	lda #$ae			; top-right corner character
	jsr chrout			; print it
	ldy #$08			; Y as the number of loop iterations
brdloop	lda newline			; '\n' character
	jsr chrout			; print it
	lda #$7d			; vertical line character
	sta firstch			; store it in the first character variable
	lda #' '
	sta secch			; store a space in the second character variable
	ldx #$09
	jsr alter			; print 9 pairs + 1 of characters specified above
	lda newline			; '\n' character
	jsr chrout			; print it
	lda #$ab			; right tack character
	jsr chrout			; print it
	lda #$60			; horizontal line character
	sta firstch			; store it in the first character variable
	lda #$7b			; + shaped joint character
	sta secch			; store it in the second character variable
	ldx #$08
	jsr alter			; print 8 pairs + 1 of characters specified above
	lda #$b3			; left tack character
	jsr chrout			; print it
	dey
	bne brdloop			; continue drawing the loop
	lda newline
	jsr chrout			; print a '\n'
	lda #$7d			; vertical line character
	sta firstch			; store it in the first character variable
	lda #' '
	sta secch			; store a space in the second character variable
	ldx #$09
	jsr alter			; print 9 pairs + 1 of characters specified above
	lda newline
	jsr chrout			; print a '\n'
	lda #$ad			; bottom-left corner character
	jsr chrout			; print it
	lda #$60			; horizontal line character
	sta firstch			; store it in the first character variable
	lda #$b1			; up tack character
	sta secch			; store it in the second character variable
	ldx #$08
	jsr alter			; print 8 pairs + 1 of characters specified above
	lda #$bd			; bottom-right corner character
	jsr chrout			; print it
	rts				; return to BASIC prompt
alter	cpx #$00			; a subroutine for printing X pairs of characters in firstch and secch succeeded by firstch.
	beq +				; return from subroutine if X=0
-	lda firstch
	jsr chrout			; print the first character
	lda secch
	jsr chrout			; print the second character
	dex
	bne -				; loop
	lda firstch
	jsr chrout			; print the first character
+	rts	
