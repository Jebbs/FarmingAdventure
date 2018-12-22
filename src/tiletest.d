module tiletest;

import gamestate;
import statemanager;

import dsfml.graphics;
import input;

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

    Texture m_farmerTexture;
    Sprite m_farmerSprite;


    this()
    {
        m_font = new Font();
        m_font.loadFromFile("resources/font.ttf");

        m_text = new Text("", m_font);

        m_tileSet = new Texture();
        m_tileSet.loadFromFile("resources/tileset.png");

        m_tileMap = new VertexArray(PrimitiveType.Quads);

        loadMap();

        m_farmerTexture = new Texture();
        m_farmerTexture.loadFromFile("resources/farmer.png");

        m_farmerSprite = new Sprite(m_farmerTexture);
        Vector2f spriteSize = m_farmerTexture.getSize();
        m_farmerSprite.origin = spriteSize/2;
        m_farmerSprite.position = Vector2f(352,352);

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

        m_text.setString(text(delta.asMicroseconds()/1000f));

        foreach(event; events)
        {
            //if(even.type == Event.)
        }

        Vector2f mov = Input.movement();


        m_farmerSprite.position = m_farmerSprite.position + (mov * 100 * delta.asSeconds());


    }

    /// Draw task
    void draw(RenderTarget target)
    {
        auto view = target.getDefaultView();
        view.center = m_farmerSprite.position;
        target.view = view;

        RenderStates states = RenderStates(m_tileSet);

        target.draw(m_tileMap, states);
        target.draw(m_farmerSprite);


        //HUD?
        target.view = target.getDefaultView();
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
