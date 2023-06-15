INCLUDE Irvine32.inc
.data 
	Time DWORD ?
	Time2 real4 ?
	Array DWORD 10 DUP (?)
	Alength DWORD ?
	Alength2  DWORD ?
	Space BYTE " ",0
	M0 BYTE "Sorting Program",0dh,0ah,0
	M1 BYTE "Enter Any 10 Positive Values",0dh,0ah,0
	M2 BYTE "Enter Your Value : ",0
	M3 BYTE "Choose A Option : ",0dh,0ah,0dh,0ah
	   BYTE "1.Insertion Sort",0dh,0ah
	   BYTE "2.Bubble Sort",0dh,0ah
	   BYTE "3.Insertion Sort & Bubble Sort",0dh,0ah
	   BYTE "4.Exit",0dh,0ah,0dh,0ah
	   BYTE "Enter Your Choice : ",0
	M4 BYTE "Thanks For Adding Values, Goodbye :'))",0dh,0ah,0
	M5 BYTE "Entered A Negative Value, Please Enter A Positive Value",0dh,0ah,0
	I0 BYTE "1.Insertion Sort : ",0dh,0ah,0
	I1 BYTE "Array After Insertion Sort : ",0
	I2 BYTE "Time In Seconds To Complete Insertion Sort : ",0
	B0 BYTE "2.Bubble Sort : ",0dh,0ah,0
	B1 BYTE "Array After Bubble Sort : ",0 
	B2 BYTE "Time In Seconds To Complete Bubble Sort : ",0
	IB BYTE "The Time Complexity Of Insertion Sort Is Better Than Bubble Sort And Our Program Proves That",0dh,0ah,0
.code
Bubble_Sort PROC
	cpuid							;Forced To First Complete Previous Instruction Completely
	rdtsc							;Read Time Stamp
	mov time, eax					;Move Counter Into Variable
	fdiv							;Floating-Point Divide
	cpuid							;Forced To First Complete Previous Instruction Completely
	
	mov eax,Lengthof Array			;First Length Of Array
	mov Alength,eax					;First Length Of Array
	mov ecx,0						;i = 0
	mov ebx,Alength					;Second Length Of Array
	dec ebx							;Second Length Of Array
	mov Alength2,ebx				;Second Length Of Array
.while (ecx < Alength2)				;i < Second Length Of Array
	mov ebx,ecx						;j = i
	inc ebx							;j = i + 1 = 1
	.while(ebx < Alength)			;j < First Length Of Array
		mov eax,Array[ecx*4]		;Array[i] < Array[j]
		mov edx,Array[ebx*4]		;Array[i] < Array[j]
		cmp eax,edx					;Array[i] < Array[j]
		jg Swap						;Jump To Swapping To Swap Values
		cmp eax,Array[ecx*4]		;Array[i] < Array[j]
		jle DSwap					;Jump To DSwap To Move Further In Loop Without Swapping Values
		Swap:
			mov eax,Array[ecx*4]	;Swapping Values
			mov edx,Array[ebx*4]	;Swapping Values
			mov Array[ecx*4],edx	;Swapping Values
			mov Array[ebx*4],eax	;Swapping Values
		DSwap:
			inc ebx					;j = j + 1
	.endw 
	inc ecx							;i = i + 1
.endw
	rdtsc							;Read Time Stamp
	sub eax, time					;Find The Difference
	mov time2,eax					;Move Value To A Floating Point Variable
	fld time2						;Push Into FUP Stack
ret 
Bubble_Sort ENDP

Insertion_Sort Proc
	cpuid							;Forced To First Complete Previous Instruction Completely
	rdtsc							;Read Time Stamp
	mov time, eax					;Move Counter Into Variable
	fdiv							;Floating-Point Divide
	cpuid							;Forced To First Complete Previous Instruction Completely

	mov eax,Lengthof Array			;Length Of Array
	mov Alength,eax					;Length Of Array
	mov ecx,Alength					;Length Of Array
	mov esi,4						;i = 1

For_Loop_L1:
	mov edx,Array[esi]				;Temp = Array[i]
	mov edi,esi						;j = 1
	sub edi,4						;j = i - 1 = 0
While_Loop_L2:
	cmp edx,Array[edi]				;Temp > Array[j]
	jg End_Loop_L3					;Jump To End_Loop_L3
	mov eax,Array[edi]				;Array[j + 1] = Array[j]
	mov Array[edi + 4],eax			;Array[j + 1] = Array[j]
	sub edi,4						;j = j - 1
	cmp edi,0						;j >= 0
	jge While_Loop_L2				;Jump To While_Loop_L2 For Looping Purpose
End_Loop_L3:
	mov Array[edi + 4],edx			;Array[j + 1] = Temp
	add esi,4						;i = i + 1
	dec ecx							;Length Of Array = Length Of Array - 1
	cmp ecx,1						;Length Of Array != 1
	jne For_Loop_L1					;Jump To For_Loop_L1 For Looping Purpose
	
	rdtsc							;Read Time Stamp
	sub eax, time					;Find The Difference
	mov time2,eax					;Move Value To A Floating Point Variable
	fld time2						;Push Into FUP Stack
ret
Insertion_Sort ENDP

main PROC
	mov edx,OFFSET M0
	call writestring
	call crlf
	mov edx,OFFSET M1
	call writestring
	call crlf
	mov ecx,0
.while(ecx<10)
	mov edx,OFFSET M2
	call writestring
	call readint
	cmp eax,0
	jl Re_Enter
	cmp eax,0
	jge Cont
	Re_Enter:
		call crlf
		mov edx,OFFSET M5
		call writestring
		mov edx,OFFSET M2
		call writestring
		call readint
		cmp eax,0
		jl Re_Enter
	Cont:
		mov Array[ecx*4],eax
		inc ecx
.endw
	call crlf

	mov edx,OFFSET M3
	call writestring
	call readint
	cmp eax,1
	je IS
	cmp eax,2
	je BS
	cmp eax,3
	je IS_BS
	cmp eax,4
	je EX

IS:
	call crlf
	call Insertion_Sort
	mov edx,OFFSET I0
	call writestring
	call crlf
	mov edx,OFFSET I1
	call writestring
	mov ecx,0
.while(ecx<Alength)
	mov eax,Array[ecx*4]
	call writedec
	mov edx,OFFSET Space
	call writestring
	inc ecx
.endw
	call crlf
	call crlf
	mov edx,OFFSET I2
	call writestring
	call writefloat
	call crlf
	exit
BS:
	call crlf
	call Bubble_Sort
	mov edx,OFFSET B0
	call writestring
	call crlf
	mov edx,offset B1
	call writestring
	mov ecx,0 
.while (ecx < Alength) 
	mov eax,Array[ecx*4] 
	call writedec 
	inc ecx 
	mov edx,offset Space 
	call writestring 
.endw 
	call crlf
	call crlf
	mov edx,OFFSET B2
	call writestring
	call writefloat
	call crlf
	exit

IS_BS:
	call crlf
	call Insertion_Sort
	mov edx,OFFSET I0
	call writestring
	call crlf
	mov edx,OFFSET I1
	call writestring
	mov ecx,0
.while(ecx<Alength)
	mov eax,Array[ecx*4]
	call writedec
	mov edx,OFFSET Space
	call writestring
	inc ecx
.endw
	call crlf
	call crlf
	mov edx,OFFSET I2
	call writestring
	call writefloat
	call crlf
	call crlf

	call Bubble_Sort
	mov edx,OFFSET B0
	call writestring
	call crlf
	mov edx,offset B1
	call writestring
	mov ecx,0 
.while (ecx < Alength) 
	mov eax,Array[ecx*4] 
	call writedec 
	inc ecx 
	mov edx,offset Space 
	call writestring 
.endw 
	call crlf
	call crlf
	mov edx,OFFSET B2
	call writestring
	call writefloat
	call crlf
	call crlf
	mov edx,OFFSET IB
	call writestring
	exit
EX:	
	call crlf
	mov edx,OFFSET M4
	call writestring
exit
main ENDP
END main