:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Util.pl').
:- include('Update.pl').

play(menu, Bubbles, Shooter, FallenBubbles, OnShoot, Time) :-
    sleep(1),
    render(menu, _, _, _),
    
    handleEvent(menu, _, _, NewGameState, _, _),
    nl, write("GameState: "), write(NewGameState), nl,

    play(NewGameState, [], [], [], false, 0).

play(game, [], [], [], false, 0) :-
    sleep(1),
    
    render(game, NewBubbles, NewShooter, []),
    
    initialBubbles(NewBubbles),

    initialShooter(NewShooter),

    play(game, NewBubbles, NewShooter, [], false, 0).

play(game, Bubbles, Shooter, FallenBubbles, OnShoot, Time) :-
    sleep(1),

    % Rederiza a tela
    render(game, FinalBubbles, FinalShooter, FinalFallenBubbles),

    nl,
    write(Bubbles), nl,
    write(Shooter), nl,
    write(FallenBubbles), nl,
    write(OnShoot), nl,
    write(Time), nl,

    % Incrementa o tempo
    NewTime is Time + 1,

    % Recebe uma entrada
    handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot),

    % Atualiza o shooter 
    updateShooter(Bubbles, NewShooter, FallenBubbles, NewBubbles, FinalShooter, NewFallenBubbles),

    write(Bubbles), nl,
    write(NewShooter), nl,
    write(FallenBubbles), nl,
    write(NewBubbles), nl,
    write(FinalShooter), nl,
    write(NewFallenBubbles), nl,

    % Atualiza a posicao das bolhas
    updateBubbles(NewBubbles, NewFallenBubbles, FinalBubbles, FinalFallenBubbles, NewTime),

    nl,
    write(FinalBubbles), nl,
    write(FinalFallenBubbles), nl,
    write(NewTime), nl,

    % Verifica se o jogo acabou
    checkGameOver(FinalBubbles, NewGameState),

    nl,
    write(NewGameState), nl,

    % Continua o jogo
    play(NewGameState, NewBubbles, FinalShooter, FinalFallenBubbles, NewOnShoot, NewTime).