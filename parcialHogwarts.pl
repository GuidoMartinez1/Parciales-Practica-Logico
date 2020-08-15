%COMIENZO RESOLUCION

%PARTE 1 SOMBRERO SELECCIONADOR

%mago (NOMBRE, CARACTERISTICAS, TIPO DE SANGRE, ODIARIA ESTAR EN)


sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).
casa(gryffindor).

mago(Mago):-
    sangre(Mago,_).

%caracteristicas que tiene que tener un personaje segun la casa donde pertenece

caracteristicasSegunCasa(gryffindor, coraje).
caracteristicasSegunCasa(slytherin, orgullo).
caracteristicasSegunCasa(slytherin, inteligente).
caracteristicasSegunCasa(ravenclaw, inteligente).
caracteristicasSegunCasa(ravenclaw, responsable).
caracteristicasSegunCasa(hufflepuff, amistoso).


caracteristicas(harry, [coraje, amistoso, orgullo, inteligente]).
caracteristicas(draco, [inteligente, orgullo]).
caracteristicas(hermione, [inteligente, orgullo, responsable]).

odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).



%PUNTO 1
permiteEntrar(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

%PUNTO 2

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(caracteristicasSegunCasa(Casa, Caracteristica), tieneCaracteristica(Mago, Caracteristica)).

tieneCaracteristica(Mago, Caracteristica):-
    caracteristicas(Mago, Caracteristicas),
    member(Caracteristica, Caracteristicas).

%PUNTO 3

puedeQuedarSeleccionadoPara(Mago, Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago, Casa)).

puedeQuedarSeleccionadoPara(hermione, gryffindor).

%PUNTO 4

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago, Magos), esAmistoso(Mago)).

esAmistoso(Mago):-
    tieneCaracteristica(Mago, amistoso).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    puedeQuedarSeleccionadoPara(Mago1, Casa),
    puedeQuedarSeleccionadoPara(Mago2, Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).

cadenaDeCasas([_]).
cadenaDeCasas([]).

/* OTRA FORMA
cadenaDeCasas(Magos):-
    forall(consecutivos(Mago1, Mago2, Magos), puedenQuedarEnLaMismaCasa(Mago1, Mago2, _)).

consecutivos(Anterior, Siguiente, Lista):-
    nth1(IndiceAnterior, Lista, Anterior),
    IndiceSiguiente is IndiceAnterior + 1,
    nth1(IndiceSiguiente, Lista, Siguiente).

puedenQuedarEnLaMismaCasa(Mago1, Mago2, Casa):-
    puedeQuedarSeleccionadoPara(Mago1, Casa),
    puedeQuedarSeleccionadoPara(Mago2, Casa),
    Mago1 \= Mago2.
*/
%----------------------------------------------------------PARTE 2 -------------------------------------------------------------------------------------------
hizo(harry, fueraDeLaCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, buenaAccion(50, ganarAlAjedrez)).
hizo(hermione, buenaAccion(50, salvarASusAmigos)).
hizo(harry, buenaAccion(60, matarAVoldemort)).


esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizoAlgunaAccion(Mago):-
    hizo(Mago,_).

hizoAlgoMalo(Mago):-
    hizo(Mago, Accion),
    puntajeQueGeneraAccion(Accion, Puntaje),
    Puntaje < 0.

lugarProhibido(tercerPiso, 75).
lugarProhibido(seccionRestringida,10).
lugarProhibido(bosque, 50).

puntajeQueGeneraAccion(fueraDeLaCama, -50).
puntajeQueGeneraAccion(irA(Lugar), PuntajeNegativo):-
    lugarProhibido(Lugar, Puntos),
    PuntajeNegativo is Puntos * -1.

puntajeQueGeneraAccion(buenaAccion(Puntaje,_),Puntaje).

%PUNTO 1 A
esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

%PUNTO 1 B
esRecurrente(Accion):-
    hizo(Mago1, Accion),
    hizo(Mago2, Accion),
    Mago1 \= Mago2.

puntajeTotalDeLaCasa(Casa,PuntajeTotal):-
    esDe(_, Casa),
    findall(Puntos, (esDe(Mago, Casa),puntosQueObtuvo(Mago,_,Puntos)),Puntajes),
    sum_list(Puntajes, PuntajeTotal).
    
puntosQueObtuvo(Mago, Accion, Puntos):-
    hizo(Mago, Accion),
    puntajeQueGeneraAccion(Accion, Puntos).


