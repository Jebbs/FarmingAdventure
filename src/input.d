module input;

import dsfml.system.vector2;
import dsfml.window.joystick;
import dsfml.window.keyboard;

import std.math;


class Input
{

    private static bool m_gamePad = false;

    static Vector2f movement()
    {
        Vector2f calculatedMovement = Vector2f(0,0);

        if(m_gamePad)
        {
            calculatedMovement.x = Joystick.getAxisPosition(0, Joystick.Axis.X);
            calculatedMovement.y = Joystick.getAxisPosition(0, Joystick.Axis.Y);

            if(abs(calculatedMovement.x) < 10)
                calculatedMovement.x = 0;
            if(abs(calculatedMovement.y) < 10)
                calculatedMovement.y = 0;
        }
        else
        {
            if(Keyboard.isKeyPressed(Keyboard.Key.W))
            {
                calculatedMovement.y -= 1;
            }
            if(Keyboard.isKeyPressed(Keyboard.Key.S))
            {
                calculatedMovement.y += 1;
            }
            if(Keyboard.isKeyPressed(Keyboard.Key.A))
            {
                calculatedMovement.x -= 1;
            }
            if(Keyboard.isKeyPressed(Keyboard.Key.D))
            {
                calculatedMovement.x += 1;
            }
        }

        float magnitude = sqrt(calculatedMovement.x*calculatedMovement.x +
                               calculatedMovement.y*calculatedMovement.y);

        if(magnitude == 0)
        {
            return Vector2f(0,0);
        }

        calculatedMovement.x/= magnitude;
        calculatedMovement.y/= magnitude;

        return calculatedMovement;
    }

    static void useGamepad(bool usingGamepad)
    {
        m_gamePad = usingGamepad;
    }

}