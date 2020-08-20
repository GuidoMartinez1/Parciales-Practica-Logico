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


/* Punto 4 Nos interesa saber de antemano cuanto se le debería cobrar a un cliente por un pedido (que son las tareas que pide).
 Para ellos disponemos de la siguiente información en la base de conocimientos:
- tareaPedida/3: relaciona al cliente, con la tarea pedida y
     la cantidad de metros cuadrados sobre los cuales hay que realizar esa tarea.
- precio/2: relaciona una tarea con el precio por metro cuadrado que se cobraría al cliente.
Entonces lo que se le cobraría al cliente sería la suma del valor a cobrar por cada tarea,
     multiplicando el precio por los metros cuadrados de la tarea.
*/

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

precioACobrar(Cliente, PrecioCobrado):-
    tareaPedida(_,Cliente,_),
    findall(Precio, precioPorTareaPedida(Cliente,_, Precio), Precios),
    sumlist(Precios, PrecioCobrado).


precioPorTareaPedida(Cliente, Tarea, Precio):-
    tareaPedida(Tarea, Cliente, MetrosCuadrados),
    precio(Tarea, PrecioTarea),
    Precio is MetrosCuadrados * PrecioTarea.

/*Punto 5 Finalmente necesitamos saber quiénes aceptarían el pedido de un cliente.
 Un integrante acepta el pedido cuando puede realizar todas las tareas del pedido 
 y además está dispuesto a aceptarlo.
Sabemos que Ray sólo acepta pedidos que no incluyan limpiar techos,
 Winston sólo acepta pedidos que paguen más de $500, 
 Egon está dispuesto a aceptar pedidos que no tengan tareas complejas y 
 Peter está dispuesto a aceptar cualquier pedido.
Decimos que una tarea es compleja si requiere más de dos herramientas. 
Además la limpieza de techos siempre es compleja.*/


