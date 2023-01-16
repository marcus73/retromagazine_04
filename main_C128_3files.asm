*=$1c01 "Basic Program"

:BasicUpstart(main)

.pc=$1300
main:
	lda #$78	// set bit map @ $2000
	sta $0A2D	// set video matrix @ 7168
	
	lda $D8
	ora #%10100000
	sta $D8		// select bit map mode

/////////////////////////////////////////////////////////////////////////////

	lda #0
	sta $d020
	sta $d021		//setted manually border and  background color...

/////////////////////////////////////////////////////////////////////////////

	// riempie la memoria schermo 
	// (locazioni 1C00-1FE7 x C128)
	// con i dati di -screen-

	ldx #$00
loop:
	lda $1400,x
	sta $1c00,x
	
	lda $1500,x
	sta $1d00,x

	lda $1600,x
	sta $1e00,x

	lda $16E8,x
	sta $1eE8,x
	inx              //Increment accumulator until 256 bytes read
	bne loop	

	//////////////////////////

	// poke 216,255:rem disable kernal vic changes
	// poke 1,peek(1)and 254:rem use color bank 0 (mc-bitmap)

	lda #$FF
	sta $D8

      lda $01
	and #$FE
	sta $01

	// riempie la memoria colore
	// (locazioni 55296-56295 ovvero da $d800 a $dbe7)
	// con i dati di -colors-

	ldx #$00
loop2:
	lda $1800,x
	sta $d800,x
	
	lda $1900,x
	sta $d900,x

	lda $1A00,x
	sta $da00,x

	lda $1AE8,x
	sta $daE8,x
	inx              //Increment accumulator until 256 bytes read
	bne loop2

	jmp *

.pc=$2000
.import binary "hires.dat",2

.pc=$1400
.import binary "screen.dat",2

.pc=$1800
.import binary "colors.dat",2
