*= $1000

:BasicUpstart2(start)

start:
	lda #0
	sta $d020

	lda #1
	sta $d021

	lda $d018
	ora #$08
	sta $d018

	lda $d011
	ora #$20
	sta $d011
	
  	lda #$18	//multicolor mode on
	sta $d016	//

	// riempie la memoria schermo 
	// (locazioni 1024-2023)
	// con i dati di -screen-

	ldx #$00
loop:
	lda $5000,x
	sta $0400,x
	
	lda $5100,x
	sta $0500,x

	lda $5200,x
	sta $0600,x

	lda $52E8,x
	sta $06E8,x
	inx              //Increment accumulator until 256 bytes read
	bne loop

	//////////////////////////


	// riempie la memoria colore
	// (locazioni 55296-56295)
	// con i dati di -colors-

	ldx #$00
loop2:
	lda $4000,x
	sta $d800,x
	
	lda $4100,x
	sta $d900,x

	lda $4200,x
	sta $da00,x

	lda $42E8,x
	sta $daE8,x
	inx              //Increment accumulator until 256 bytes read
	bne loop2

	jmp *

.pc=$2000-2
.import binary "hires.dat"

.pc=$4000-2
.import binary "colors.dat"

.pc=$5000-2
.import binary "screen.dat"

