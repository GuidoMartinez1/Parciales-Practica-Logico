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