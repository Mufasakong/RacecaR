# RacecaR
RACERBILS NEURO EVOLUTION
Teknikfaget Digital Design og Udvikling - HCØ Lyngby, HTX

## Opgavebeskrivelse
Byg et program til træning af en autonom virtuel racerbil, så den kan køre en omgang på kortest mulig tid.
Opgaven kan laves i grupper på maksimalt 2 personer. Vælg en af disse to varianter: 
●	Ekspert: Byg alt selv, med inspiration fra udleveret kode (se nedenstående).
●	Normal: Brug udleveret kode og byg selv den genetiske algoritme (anvend alt kode eller kun dele).

### TEORI
Racerbilen skal styres af et neuralt netværk, og netværket skal optimeres af en genetisk algoritme.
Metoden kaldes Neuro Evolution. 
●	Kernestof: Opbygning af simple Neurale Netværk & Anvendelse af Neuro Evolution
●	Materiale: Bogen “Nature of Code”, kapitel 9 og kapitel 10.
●	Videoer: “Om  Racerbil Evolution” og  “Gennemgang af udleveret kode”

## Programmet
Programmet laver 100 autonome racerbiler med “tilfældige” hjerner, der kører rundt på en sort racerbane tegnet i Paint. 
De autonome racerbils-objekter, består af en bil, et sensorsystem og en hjerne.
Bilen har en konstant hastighed på 5 pixels/frame og ændrer retning ved at rotere om sin egen akse. 
Hjernen er et neuralt netværk, der via tre input signaler bestemmer rotationsvinklen. De tre input stammer fra tre farvesensorer, der kan detektere farven hvid, som kun ses uden for banen.  
Sensorsystemet indsamler også anden data, end den, der bruges til at styre bilen nemlig:  
- Hvor mange frames bilen befinder sig i den hvide rabat,
- hvor mange frames bilen kører i den forkerte retning og 
- hvor hurtigt den kører en omgang. 

Hver eneste gang framecounten når et punkt (500%) vil de autonome racerbiler blive nulstillet og udvikle sig på ny. 

Vi anvender den her data til at bygge den genetiske algoritme.

