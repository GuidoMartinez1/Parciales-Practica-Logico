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