;* Rafal Meisel
;* Informatyka, Rybnik
;* Semestr 5, 2016/2017
;*    
;* Projekt Jezykow Asemblerowych
;* Algorytm Sortujacy :
;* Sortowanie Shella
;*
 
.386
.model flat, c
.code
 
ASM_SortowanieShella PROC
  ;Od³o¿enie zawartoœci rejestrów na stos
	push EBP
	mov EBP, ESP
	push EBX
	push ESI
	push EDI


	;Pobranie liczby elementow tablicy 
	mov EAX, [EBP+12]  
	sub EAX, 1
	mov ECX, 4
	mul ECX
	;Wprowadzenie do rejestru ECX wartoœci koncz¹cej pêtle
	mov ECX, EAX  
  
    ;Pobranie adresu pierwszego elementu tablicy
	mov ESI, [EBP+8]  

	; Sprawdzenie czy w tabeli znajduje sie wiecej niz jeden element
	cmp ECX, 4
	JL KoniecProcedury
    
	; * Pierwsza Petla * 

	mov EAX, [EBP+12]
	mov	EBX, 2
	div EBX
	mov EBX, EAX
	push EBX ; chowamy i

	; for (i = dl / 2; i > 0; i = i / 2)
	; EBX = i ; na stosie

	PierwszaPetla:
	cmp EBX, 1
	jl KoniecProcedury

	; * Druga Petla * 
	
	; EBX = j = i
	; for (j = i; j < dl; j++)

	DrugaPetla:
	cmp [EBP + 12], EBX
	jle KoniecPierwszaPetla

	; * Trzecia Petla * 

	pop EAX
	push EAX ; chowamy i
	
	mov EDI, EBX
	sub EDI, EAX		
	
	; EAX = i
	; EBX = j
	; EDI = k
	
	; chowamy rejestry na stos
	push EDI
	push EBX
	push EAX

	; for (k = j - i; k >= 0; k = k - i)
	TrzeciaPetla:
	cmp EDI, 0
	jl KoniecDrugaPetla

	; * Zamiana * 

	mov EBX, EAX ; EBX = i
	mov EAX, EDI ; EAX = k 
	add EAX, EBX ; k + i
	push EDI
	mov EDI, 4
	mul EDI 
	add EAX, ESI
	pop EDI
	; Na tym etapie mamy adres [k + i] w EAX
	push EDI
	push EAX
	mov EAX, EDI
	mov EDI, 4
	mul EDI
	add EAX, ESI
	mov EDI, EAX
	pop EAX
	; Na tym etapie mamy adres [k] w EDI

	; EAX - adres k+i , EDI - adres k

	; Przygotowanie wartosci i adresow
	push ECX
	push EDX
	mov ECX, [EAX]
	mov EDX, [EDI]

	; if (tab[k + i] >= tab[k])
	
	cmp ECX, EDX
	JGE KoniecTrzeciaPetla ; wieksze lub rowne
	
	; zamieniamy
	mov [EAX], EDX
	mov [EDI], ECX

	; * Zamiana * 


	KoniecTrzeciaPetla:
	pop EDX
	pop ECX
	pop EDI
	pop EAX
	push EAX
	sub EDI, EAX
	jmp TrzeciaPetla

	; * Trzecia Petla *

	KoniecDrugaPetla:
	pop EAX
	pop EBX
	pop EDI

	add EBX, 1;
	jmp DrugaPetla
	; * Druga Petla * 


	KoniecPierwszaPetla:
	pop EBX
	mov EAX, EBX
	mov EBX, 2
	div EBX
	mov EBX, EAX
	push EBX

	jmp PierwszaPetla
	
	; * Pierwsza Petla * 


	KoniecProcedury:
		pop EBX
		;pobranie ze stosu wartosci rejestrów
		pop EDI
		pop ESI
		pop EBX
		pop EBP

	;powrót z procedury
	RET
 
ASM_SortowanieShella ENDP
 
END