; vim: set filetype=64tass:

; KERNAL functions
chrout	= $ffd2
; KERNAL variables
chmode	= $d018
; constants
upper	= $15
; variable addresses
firstch	= $fb
secch	= $fc
; PETSCII codes
clear	= $93
newline	= $0d
hori	= $60
vert	= $7d
uptack	= $b1
rghtack	= $ab
dwntack	= $b2
lftack	= $b3
cross	= $7b
tplftc	= $b0
tprghtc = $ae
btlftc	= $ad
btrghtc	= $bd
space	= $a0
rvson	= $12
rvsoff	= $92

row	.macro left=0, first, second, pairs, right
	.if \left!=0
	lda #\left			; character opening the row
	jsr chrout			; print it
	.endif
	lda #\first			; load the first character
	sta firstch			; store it in the firstch variable
	lda #\second			; load the second character
	sta secch			; store it in the secch variable
	ldx #\pairs
	jsr alter			; print \pairs number of pairs + 1 of characters stored in firstch and secch
	lda #\right			; character closing the row
	jsr chrout			; print it
	.endmacro

*	 = $0801
	.word (+), 10			; pointer, line number
	.null $9e, format("%4d", start)	; SYS 49233
+	.word 0				; end of BASIC program

*	 = $c051
start	lda #clear
	jsr chrout			; clear the screen
	lda #upper
	sta chmode			; set uppercase mode
	#row tplftc, hori, dwntack, $08, tprghtc
	ldy #$08			; Y as the number of loop iterations
brdloop	lda #newline			; '\n' character
	jsr chrout			; print it
	#row , vert, space, $09, newline
	#row rghtack, hori, cross, $08, lftack
	dey
	bne brdloop			; continue drawing the loop
	lda #newline
	jsr chrout			; print a '\n'
	#row , vert, space, $09, newline
	#row btlftc, hori, uptack, $08, btrghtc
	rts				; return to BASIC prompt
alter	cpx #$00			; a subroutine for printing X pairs of characters in firstch and secch succeeded by firstch. Reverse every space in secch.
	beq +				; print firstch and return from subroutine if X=0
-	lda firstch
	jsr chrout			; print the first character
	lda secch
	cmp #space			; is the second character a space?
	bne _prtsec			; no, print the second character
	lda #rvson			; yes, load the reverse on character
	jsr chrout			; print it
	lda #space			; space character
	jsr chrout			; print it
	lda #rvsoff			; reverse off character
_prtsec jsr chrout			; print the second character
	dex
	bne -				; loop
+	lda firstch
	jsr chrout			; print the first character
	rts
