module mainmenu;

import gamestate;

import dsfml.graphics;

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
    void update(Duration delta)
    {

    }

    /// Draw task
    void draw(RenderTarget target)
    {
        target.draw(m_text);
    }

}
