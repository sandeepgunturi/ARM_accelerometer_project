	AREA     appcode, CODE, READONLY
;	IMPORT main
;	IMPORT main2
	;IMPORT printMsg
	EXPORT __main1
	ENTRY
__main1  FUNCTION	
;	BL main
		LDR R0,=0x200000E0
		LDR R1,[R0]
		LDR R2,=0x200000E4
		LDR R3,[R2]
		LDR R4,=0x200000E8
		LDR R11,[R4]
		VMOV.F32 S1,R1
		VMOV.F32 S2,R3
		VMOV.F32 S3,R11
	
		;VCVT.F32.S32 S1,S1
		;VCVT.F32.S32 S2,S2
		;VCVT.F32.S32 S3,S3
	
		VDIV.F32 S0,S2,S3
	
		;VLDR.F32 s0,=0.5;x
		VLDR.F32 s1,=0;s1 has answer
		MOV R10,#2;const 2
		MOV R5,#0;i in int
loop	MUL R6,R5,R10;2*i;
		ADD R7,R6,#1;2*i+1;--->n
		AND R8,R5,#1;if i is odd R8=1
		CMP R8,#0;
		BEQ even
		B odd
mark	MOV R9,R7;
		VMOV.F32 s3,s0;
		CMP R9,#1;
		BEQ mark2;
mark1	VMUL.F32 s3,s3,s0;
		SUB R9,R9,#1;
		CMP R9,#1;
		BNE mark1;
		
mark2	VMOV.F32 s4,R7;			convert n(R7) to float 
        VCVT.F32.U32 s4,s4;
		VDIV.F32 s5,s3,s4;(pow(x,n)/n)
		VDIV.F32 s6,s5,s2;(pow(x,n)/n)*c
		VADD.F32 s1,s1,s6;
		ADD R5,R5,#1;
		CMP R5,#3;    i till 4
		BNE loop
		VLDR.F32 S7,=180
		VLDR.F32 S8,=3.14159
		VMUL.F32 S1,S1,S7
		VDIV.F32 S1,S1,S8
		VMOV.F32 R0,S1
		MOV R2,R11
		MOV R3,R12
		;BL printMsg
		B stop
		
		
		
even	VLDR.F32 s2,=1;c
		B mark
odd 	VLDR.F32 s2,=-1;c
		B mark
			
	
stop BX lr	
;stop B stop ; stop program
     ENDFUNC
	 END
	