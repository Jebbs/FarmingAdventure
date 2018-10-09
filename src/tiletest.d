module tiletest;

import gamestate;
import statemanager;

import dsfml.graphics;


import std.stdio;
import std.conv;

/// The main menu of this game
class TileTest : GameState
{
    Font m_font;
    Text m_text;

    Texture m_tileSet;
    uint m_tileSize = 32;
    VertexArray m_tileMap;


    this()
    {
        m_font = new Font();
        m_font.loadFromFile("resources/font.ttf");

        m_text = new Text("", m_font);

        m_tileSet = new Texture();
        m_tileSet.loadFromFile("resources/tileset.png");

        m_tileMap = new VertexArray(PrimitiveType.Quads);

        loadMap();

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

        m_text.setString(text(1/delta.asSeconds()));

        foreach(event; events)
        {
            //if(even.type == Event.)
        }
    }

    /// Draw task
    void draw(RenderTarget target)
    {
        RenderStates states = RenderStates(m_tileSet);
        target.draw(m_tileMap, states);

        target.draw(m_text);

    }

    final void loadMap()
    {
        import std.json;
        import std.file : readText;

        auto contents = readText("resources/tilemap.json");
        auto mapFile = parseJSON(contents);

        int x = 0;
        int y = 0;


        foreach(row; mapFile["map"].array())
        {
            foreach(pair; row.array())
            {
                //tile x and y
                auto tx = pair.array()[0].integer();
                auto ty = pair.array()[1].integer();


                m_tileMap.append(Vertex(Vector2f(x*m_tileSize, y*m_tileSize),
                                        Vector2f(tx*m_tileSize, ty*m_tileSize)));
                m_tileMap.append(Vertex(Vector2f(x*m_tileSize + m_tileSize, y*m_tileSize),
                                        Vector2f(tx*m_tileSize + m_tileSize, ty*m_tileSize)));
                m_tileMap.append(Vertex(Vector2f(x*m_tileSize+ m_tileSize, y*m_tileSize + m_tileSize),
                                        Vector2f(tx*m_tileSize+ m_tileSize, ty*m_tileSize + m_tileSize)));
                m_tileMap.append(Vertex(Vector2f(x*m_tileSize, y*m_tileSize + m_tileSize),
                                        Vector2f(tx*m_tileSize, ty*m_tileSize + m_tileSize)));

                x++;
            }
            y++;
            x=0;
        }


    }

}
