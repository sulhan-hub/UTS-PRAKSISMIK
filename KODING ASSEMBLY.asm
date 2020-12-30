$mod51

Sensor_Input  bit  p3.2
Buzzer_Output bit  p3.3
LED_Hijau     bit  p3.4
LED_Merah     bit  p3.5

org   0h
      ajmp  Inisialiasasi

org   0bh
	djnz  r7, Pewaktu_Selesai
	
	djnz  r6, Pewaktu_Indikator
	mov   r6, #2
	jnb   Sensor_Input, Indikator_Hijau
	clr   LED_Merah
	djnz  r5, Pewaktu_Selesai
	djnz  r4, Pewaktu_Menit
	reti

Pewaktu_Indikator:
	setb  LED_Hijau
	setb  LED_Merah
	reti

Pewaktu_Menit:
	mov   r5, #60
	reti

Indikator_Hijau:
	clr   LED_Hijau
	
Pewaktu_Selesai:
	Reti

Inisialiasasi:
	mov   tmod, #02h
	mov   th0, #255-225
	mov   tl0, #255-225
	
	mov   r6, #2
	mov   ie, #82h
	mov   tcon, #10h
App_Mulai:
	jnb   Sensor_Input, $
	mov   a, p1
	anl   a, #80h
	jz    Setup_Detik
	mov   r5, #60
	mov   a, p1
	anl   a, #01111111b
	mov   r4, a
	ajmp  Hitung_Mundur

Setup_Detik:
	mov   a, p1
	anl   a, #01111111b
	mov   r5, a
	mov   r4, #1
Hitung_Mundur:
	jnb   Sensor_Input, App_Mulai
	mov   a, r4
	jnz   Hitung_Mundur
	clr   Buzzer_Output

Alarm_Aktif:
	clr   LED_Merah
	jb    Sensor_Input, Alarm_Aktif
	setb  Buzzer_Output
	setb  LED_Merah
	ajmp  App_Mulai

end