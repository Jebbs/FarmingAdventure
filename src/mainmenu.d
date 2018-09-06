module mainmenu;

import gamestate;
import statemanager;

import dsfml.graphics;

import std.stdio;

/// The main menu of this game
class MainMenu : GameState
{
    Font m_font;
    Text m_text;

    this()
    {
        m_font = new Font();
        m_font.loadFromFile("resources/font.ttf");

        m_text = new Text("Farming Adventure", m_font);
    }

    /// Task to perform when entering the state
    void enter()
    {

    }

    /// Task to perform when exiting the state
    void exit()
    {

    }

    /// Perform the main update for this state
    void update(Time delta, const(Event[]) events)
    {
        writeln(delta.asSeconds(), ":", events.length);

        foreach(event; events)
        {
            if(event.type == Event.EventType.KeyReleased)
                stateManager.requestExit();
        }
    }

    /// Draw task
    void draw(RenderTarget target)
    {
        target.draw(m_text);
    }

}
