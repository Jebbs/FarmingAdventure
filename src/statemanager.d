module statemanager;

import gamestate;
import mainmenu;

/**
 * Class that manages states. What do you want from me?
 */
class StateManager
{
    /// List of states in the game
    private GameState[State.stateCount] m_gameStates;
    private State m_currentState;


    /// constructor
    this()
    {
        //construct and initialize all states
        m_gameStates[State.mainMenu] = new MainMenu();

        m_gameStates[m_currentState].enter();

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