module main;

import dsfml.graphics;
import std.stdio;

import statemanager;
import gamestate;

void main()
{
    auto window = new RenderWindow(VideoMode(800,600), "Farming Adventure");
    stateManager = new StateManager();

    auto clock = new Clock();
    Event[] events;

    while (window.isOpen())
    {
        auto delta = clock.restart();
        events.length = 0;

        Event event;

        while(window.pollEvent(event))
        {

            events~=event;

            if(event.type == event.EventType.Closed)
            {
                window.close();
            }
        }

        if(stateManager.exitRequested)
            break;

        auto currentState = stateManager.getCurrentState();

        currentState.update(delta, events);

        window.clear();
        currentState.draw(window);
        window.display();
    }
}