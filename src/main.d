module main;

import dsfml.graphics;
import std.stdio;

void main()
{
    auto window = new RenderWindow(VideoMode(800,600), "Farming Adventure");

    while (window.isOpen())
    {
        Event event;

        while(window.pollEvent(event))
        {
            if(event.type == event.EventType.Closed)
            {
                window.close();
            }
        }

        window.clear();
        window.display();
    }
}