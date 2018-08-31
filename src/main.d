module main;

import dsfml.graphics;
import std.stdio;

import statemanager;
import gamestate;

void main()
{
    auto window = new RenderWindow(VideoMode(800,600), "Farming Adventure");
    auto stateManager = new StateManager();

    auto clock = new Clock();

    while (window.isOpen())
    {
        auto delta = clock.restart();

        Event event;

        while(window.pollEvent(event))
        {
            if(event.type == event.EventType.Closed)
            {
                window.close();
            }
        }

        auto currentState = stateManager.getCurrentState();

        currentState.update(delta);

        window.clear();
        currentState.draw(window);
        window.display();
    }
}