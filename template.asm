;	Author:     RavHUDZULO
;	Template document
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

INCLUDE io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.data
    
	strNumber BYTE "Enter the number: ", 0
	space     Byte " ", 10, 0
	strWidth  Byte "Enter the width: ", 0

; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE

   _format PROC NEAR32

       ; Function Entry
	   push ebp            ; Save the base pointer
	   mov  ebp, esp       ; Create main stack frame

	   ;Save the registers
	   push edx
	   push ecx 
	   push ebx 

	   pushfd    ; Save the flags

	   ; Function Block

	   mov ecx, 0          ; i = 0

	   forCounterLoop:
	      cmp ecx, [ebp+12]
	      jge theEnd

		  PUSH 0
		  call outputInt

		  inc ecx

	   JMP forCounterLoop	

	   theEnd:   

	   push [ebp+8]
	   call outputInt

	   ; Function Exit 
	   popfd       ; Restore the flags

	   ; Restore the registers
	   pop ebx
	   pop ecx 
	   pop ebx

	   mov esp, ebp      ; Restore the stack frame
	   pop ebp           ; Restore the base pointer

	   ret   ; return

   _format ENDP

_start:
	; Most of your initial code will be under the _start tag.
	; The _start tag is just a memory address referenced by the Public indicator
	; highlighting which functions are available to calling functions.
	; _start gets called by the operating system to start this process. page 122, 88

	push ebp  ; Save the base register
	mov  ebp, esp    ; Create the stack frame 
	sub  esp, 4      ; Reserve 1 local variable

	lea ebx, strWidth
	push ebx
	call outputStr       ; Request the width of the number from the user

	push eax
	call inputInt    ; Input of width of the number from the user

	mov  [ebp-4], eax

	lea ebx, strNumber
	push ebx
	call outputStr

	push eax
	call inputInt    ; Request the number of the number (preferred)

	push [ebp-4]
	push eax
	call _format     ; ebp+8 argument

	mov  esp, ebp     ; Destroy the stack frame
	pop  ebp  ; Restore the base pointer	

	; We call the Operating System ExitProcess system call to close the process.
	push 0
	call ExitProcess
	;INVOKE ExitProcess, 0
Public _start
END
