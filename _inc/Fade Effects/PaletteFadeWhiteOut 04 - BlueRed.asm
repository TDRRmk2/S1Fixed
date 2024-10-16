; ---------------------------------------------------------------------------
; Subroutine to fade to white (Special Stage) -- Mode 04: Blue+Red (RetroKoH)
; Slight optimization to WhiteOut_AddColour by RetroKoH
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WhiteOut_AddColour:
		cmpi.w	#cWhite,(a0)	; Does this colour entry need to be faded out?
		beq.s	.next			; if not, branch and jump to the next palette entry

.addgreen:
		move.b	1(a0),d1	; d1 = GR byte
		andi.b	#$E0,d1		; d1 = current green
		cmpi.b	#$E0,d1
		beq.s	.addbluered	; if green is already whited out, check blue
		addi.b	#$20,1(a0)	; increase green value
		addq.w	#2,a0		; next colour
		rts
; ===========================================================================

.addbluered:
		move.b	(a0),d1		; d1 = 0B byte
		andi.b	#$E,d1		; d1 = blue (done for error-proofing)
		cmpi.b	#$E,d1
		beq.s	.addred		; if blue is already whited out, that means only red remains
		addq.b	#2,(a0)		; increase blue value

.addred:
		move.b	1(a0),d1	; d1 = GR byte
		andi.b	#$E,d1		; d1 = current red
		cmpi.b	#$E,d1
		beq.s	.next		; if red is already whited out, check blue/green
		addq.b	#2,1(a0)	; increase red value	

.next:
		addq.w	#2,a0		; next colour
		rts	
; End of function WhiteOut_AddColour
