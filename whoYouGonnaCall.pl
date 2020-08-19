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

