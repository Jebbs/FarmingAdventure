module gamestate;

public import dsfml.graphics.rendertarget;
public import dsfml.system.time;

enum State
{
    mainMenu = 0,
    stateCount
}

/**
 * Game state defines a state the game is in.
 *
 * menu, game, pause, etc.
 */
interface GameState
{
    /// Task to perform when entering the state
    void enter();

    /// Task to perform when exiting the state
    void exit();

    /// Perform the main update for this state
    void update(Time delta);

    /// Draw task
    void draw(RenderTarget target);
}
