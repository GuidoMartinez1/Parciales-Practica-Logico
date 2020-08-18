%canta(CANTANTE, CANCION(NOMBRE, DURACION)).
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).


/* 1- Para comenzar el concierto, es preferible introducir primero a los cantantes más novedosos,
 por lo que necesitamos un predicado para saber si un vocaloid es novedoso cuando saben al menos 2 canciones
 y el tiempo total que duran todas las canciones debería ser menor a 15.
*/


vocaloidNovedoso(Vocaloid):-
    sabeAlMenosDosCanciones(Vocaloid),
    tiempoTotalCanciones(Tiempo, Vocaloid),
    Tiempo < 15.

sabeAlMenosDosCanciones(Vocaloid):-
    canta(Vocaloid, Cancion),
    canta(Vocaloid, Cancion2),
    Cancion \= Cancion2.


tiempoTotalCanciones(TiempoTotal, Vocaloid):-
    canta(Vocaloid,_),
    findall(Duracion, tiempoCancion(Duracion, Vocaloid), Duraciones),
    sumlist(Duraciones, TiempoTotal).

tiempoCancion(Tiempo, Vocaloid):-
    canta(Vocaloid, Cancion),
    tiempo(Cancion, Tiempo).

tiempo(cancion(_,TiempoCancion), TiempoCancion).

/*
2-
Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no les gusta,
 es por eso que se pide saber si un cantante es acelerado,
  condición que se da cuando todas sus canciones duran 4 minutos o menos. Resolver sin usar forall/2.
*/

esAcelerado(Vocaloid):-
    canta(Vocaloid,_),
    not((tiempoCancion(Tiempo, Vocaloid), Tiempo > 4)).
/*
Con forall hubiese sido

esAcelerado(Vocaloid):-
    canta(Vocaloid,_).
    forall(tiempoCancion(Tiempo, Vocaloid), Tiempo =< 4).


concierto(Nombre, Pais, Fama, TipoConcierto).
gigante(CantMinDeCanciones, DuracionTotalDeLasCanciones).
mediano(DuracionCanciones).
pequeño(DuracionDeCancion).
*/
concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

/*
Se requiere saber si un vocaloid puede participar en un concierto,
     esto se da cuando cumple los requisitos del tipo de concierto.
    También sabemos que Hatsune Miku puede participar en cualquier concierto.
*/
puedeParticipar(hatsuneMiku, _).

puedeParticipar(Vocaloid, Concierto):-
    canta(Vocaloid,_),
    Vocaloid \= hatsuneMiku,
    concierto(Concierto,_,_,TipoConcierto),
    cumpleTipoConcierto(TipoConcierto, Vocaloid).

cantCancionesQueElCantanteDebeSaber(Vocaloid, Cant):-
    findall(Cancion, canta(Vocaloid,Cancion), Canciones),
    length(Canciones, Cant).


cumpleTipoConcierto(gigante(CantMinDeCanciones, DuracionTotalDeLasCanciones), Vocaloid):-
    cantCancionesQueElCantanteDebeSaber(Vocaloid, Cant),
    Cant >= CantMinDeCanciones,
    tiempoTotalCanciones(TiempoTotal, Vocaloid),
    TiempoTotal > DuracionTotalDeLasCanciones.

cumpleTipoConcierto(mediano(DuracionCanciones), Vocaloid):-
    tiempoTotalCanciones(TiempoTotal, Vocaloid),
    TiempoTotal < DuracionCanciones.
    
cumpleTipoConcierto(pequenio(DuracionDeCancion), Vocaloid):-
    canta(Vocaloid, Cancion),
    tiempoCancion(Duracion, Cancion),
    Duracion > DuracionDeCancion.

/*
Conocer el vocaloid más famoso, es decir con mayor nivel de fama. 
    El nivel de fama de un vocaloid se calcula como
    la fama total que le dan los conciertos en los cuales puede participar
     multiplicado por la cantidad de canciones que sabe cantar.
*/

vocaloidMasFamoso(Vocaloid):-
    nivelFamoso(Vocaloid, NivelMasFamoso),
    forall(nivelFamoso(Vocaloid, Nivel), NivelMasFamoso >= Nivel).


fama(Concierto, Fama):-
    concierto(Concierto,_,Fama,_).

famaTotal(Vocaloid, FamaTotal):-
    canta(Vocaloid,_),
    findall(Fama, famaConcierto(Vocaloid, Fama), CantidadDeFama),
    sumlist(CantidadDeFama, FamaTotal).

famaConcierto(Vocaloid, Fama):-
    puedeParticipar(Vocaloid, Concierto),
    fama(Concierto, Fama).

nivelFamoso(Vocaloid, NivelMasFamoso):-
    famaTotal(Vocaloid, FamTotal),
    cantCancionesQueElCantanteDebeSaber(Vocaloid, Cant),
    NivelMasFamoso is FamTotal * Cant.

/*Sabemos que:
megurineLuka conoce a hatsuneMiku  y a gumi 
gumi conoce a seeU
seeU conoce a kaito

Queremos verificar si un vocaloid es el único que participa de un concierto,
 esto se cumple si ninguno de sus conocidos ya sea directo o indirectos (en cualquiera de los niveles)
  participa en el mismo concierto.
*/

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

conocido(Vocaloid, Conocido):-
    conoce(Vocaloid, UnCantante),
    conoce(UnCantante, Conocido).

conocido(Vocaloid, Conocido):-
    conoce(Vocaloid, Conocido).

vocaloidEsUnicoParticipante(Vocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto),
    not(conocido(Vocaloid, OtroVocaloid)),
    puedeParticipar(OtroVocaloid, Concierto).
