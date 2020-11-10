/*
** EPITECH PROJECT, 2020
** main
** File description:
** test
*/

#include <SFML/Graphics.h>

sfRenderWindow *open_window(int width, int height, char *name)
{
    sfRenderWindow *window;
    sfVideoMode video_mode;

    video_mode.width = width;
    video_mode.height = height;
    video_mode.bitsPerPixel = 32;
    window = sfRenderWindow_create(video_mode, name, sfDefaultStyle, NULL);
    return (window);
}


int main(void)
{
    /* Create Window */
    sfRenderWindow *window = open_window(800, 600, "Window");

    sfTexture* texture;
    sfSprite* sprite;
    sfEvent event;
    /* Load a sprite to display */
    texture = sfTexture_createFromFile("test.jpg", NULL);
    if (!texture)
        return (84);
    sprite = sfSprite_create();
    sfSprite_setTexture(sprite, texture, sfTrue);
    /* Start the game loop */
    while (sfRenderWindow_isOpen(window)) {
        /* Process events */
        while (sfRenderWindow_pollEvent(window, &event)) {
            /* Close window : exit */
            if (event.type == sfEvtClosed)
                sfRenderWindow_close(window);
        }
        /* Clear the screen */
        sfRenderWindow_clear(window, sfBlack);
        /* Draw the sprite */
        sfRenderWindow_drawSprite(window, sprite, NULL);
        /* Update the window */
        sfRenderWindow_display(window);
    }
    /* Cleanup resources */
    sfSprite_destroy(sprite);
    sfTexture_destroy(texture);
    sfRenderWindow_destroy(window);
    return (0);
}