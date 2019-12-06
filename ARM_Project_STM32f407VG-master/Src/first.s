     AREA     appcode, CODE, READONLY
     IMPORT main
	 IMPORT SystemClock_Config
	 ;IMPORT	MX_SPI1_Init	
	 ;IMPORT MX_GPIO_Init
	 EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	

	 BL main
	 BL SystemClock_Config
	 ;BL MX_SPI1_Init
	 ;BL MX_GPIO_Init
	 B stop
	 
stop B stop
	 ENDFUNC
	 END