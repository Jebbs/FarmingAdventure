module main;

import dsfml.graphics;
import std.stdio;

import statemanager;
import gamestate;
import input;

void main()
{

    auto modes = VideoMode.getFullscreenModes();

    auto window = new RenderWindow(VideoMode(1920, 1080, 32), "Farming Adventure", Window.Style.Fullscreen);
    stateManager = new StateManager();


    writeln(VideoMode.getDesktopMode());
    /*
    foreach (i,mode; modes)
    {
        //writeln(i, ":", mode);
    }
    */


    auto clock = new Clock();
    Event[] events;

    while (window.isOpen())
    {
        auto delta = clock.restart();
        events.length = 0;

        Event event;

        while(window.pollEvent(event))
        {

            if(event.type == Event.EventType.JoystickButtonPressed ||
               event.type == Event.EventType.JoystickMoved)
            {
                Input.useGamepad(true);
            }

            if(event.type == Event.EventType.KeyPressed ||
               event.type == Event.EventType.MouseMoved ||
               event.type == Event.EventType.MouseButtonPressed)
            {
               Input.useGamepad(false);
            }


            events~=event;

            if(event.type == event.EventType.Closed ||
               (event.type == Event.EventType.KeyPressed &&
                event.key.code == Keyboard.Key.Escape))
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
