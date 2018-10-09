module statemanager;

import gamestate;
import mainmenu;
import tiletest;

/// global state manager states can trigger transitions and exit the game
StateManager stateManager;

/**
 * Class that manages states. What do you want from me?
 */
class StateManager
{
    /// List of states in the game
    private GameState[State.stateCount] m_gameStates;
    /// the current state
    private State m_currentState;
    /// describes if a particular state requested that the game exit
    private bool m_exitRequested;

    /// constructor
    this()
    {
        //construct and initialize all states
        m_gameStates[State.mainMenu] = new MainMenu();
        m_gameStates[State.tileTest] = new TileTest();

        m_currentState = State.tileTest;
        m_gameStates[m_currentState].enter();

        m_exitRequested = false;
    }

    /// Returns if the game should exit or not
    bool exitRequested() const
    {
        return m_exitRequested;
    }

    /// call this to request the game to exit
    void requestExit()
    {
        m_exitRequested = true;
    }


    /// transition to a new state
    void transition(State newState)
    {
        if(m_currentState != newState)
        {
            m_gameStates[m_currentState].exit();

            m_currentState = newState;

            m_gameStates[m_currentState].enter();
        }
    }

    /// Get the current state instance
    GameState getCurrentState()
    {
        return m_gameStates[m_currentState];
    }

}