herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).


tiene(egon, aspiradora(200)).
tiene(ego, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

%Punto 2
satisfaceLaNecesidad(Integrante, Herramienta):-
    tiene(Integrante, Herramienta).

satisfaceLaNecesidad(Integrante, aspiradora(PotenciaRequerida)):-
    tiene(Integrante, aspiradora(Potencia)),
    between(0, Potencia, PotenciaRequerida).
    %Potencia >= PotenciaRequerida. si lo hacia asi no era inversible

/*Punto 3
    Queremos saber si una persona puede realizar una tarea, que dependerá de las herramientas que tenga.
    Sabemos que:
    - Quien tenga una varita de neutrones puede hacer cualquier tarea, 
        independientemente de qué herramientas requiera dicha tarea.
    - Alternativamente alguien puede hacer una tarea si puede satisfacer 
        la necesidad de todas las herramientas requeridas para dicha tarea.*/

puedeRealizarTarea(Persona, Tarea):-
    tiene(Persona, varitaDeNeutrones),
    herramientasRequeridas(Tarea, _).

puedeRealizarTarea(Persona, Tarea):-
    tiene(Persona,_),
    herramientasRequeridas(Tarea,_),
    forall(requiereHerramienta(Tarea, Herramienta), satisfaceLaNecesidad(Persona, Herramienta)).

requiereHerramienta(Tarea, Herramienta):-
    herramientasRequeridas(Tarea, ListaDeHerramientas),
    member(Herramienta, ListaDeHerramientas).


