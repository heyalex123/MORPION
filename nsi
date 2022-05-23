#début
import pygame
from pygame.locals import *
from random import randint


#Initialisation de tous les modules pygame.
pygame.init()


#grille
largeur = 600
hauteur = 400
windowSurface = pygame.display.set_mode((largeur,hauteur), 0,32)


#couleur
BLACK = (0,0,0)
WHITE = (255,255,255)
RED = (255,0,0)
GREEN = (0,255,0)
BLUE = (0,0,255)
YELLOW = (255,211,67)
GREY = (127,127,127)


#grille
pygame.draw.line(windowSurface, WHITE , (700,133), (0,133), 9)
pygame.draw.line(windowSurface, WHITE , (700,266), (0,266), 9)

pygame.draw.line(windowSurface, WHITE , (200,0), (200,400), 9)
pygame.draw.line(windowSurface, WHITE , (400,0), (400,400), 9)

pygame.display.update()

Cases = [[0, 0, 0],
         [0, 0, 0],
         [0, 0, 0]]


#tours
match_fini = False
turn = 0
def Turn():
    global ligne, colonne, turn, match_fini
    if Cases[ligne][colonne] == 0 and not match_fini:
        if event.type == MOUSEBUTTONDOWN and event.button==1:
            turn = turn + 1

        if turn%2 == 0:
            pygame . draw . circle ( windowSurface , WHITE , ((100 + (colonne * 200) , 65 + (ligne * 133))) , 40 , 0 )
            pygame . draw . circle ( windowSurface , BLACK , ((100 + (colonne * 200) , 65 + (ligne * 133))) , 33 , 0 )
            Cases[ligne][colonne] = "o"

        else:
            pygame . draw . line ( windowSurface , WHITE , (160 + (colonne * 200), 20 + (ligne * 133)) , (40 + (colonne * 200), 100 + (ligne * 133)) , 10 )
            pygame . draw . line ( windowSurface , WHITE , (160 + (colonne * 200), 100 + (ligne * 133)) , (40 + (colonne * 200), 20 + (ligne * 133)) , 10 )
            Cases[ligne][colonne] = "x"


#message de victoire de X
def montrerVainqueurX():
    global match_fini
    font = pygame.font.SysFont(None, 36)
    text = font.render('Le joueur X a gagné.', True, RED)
    windowSurface.blit(text, (170, 180))
    match_fini = True


#message de victoire de O
def montrerVainqueurO():
    global match_fini
    font = pygame.font.SysFont(None, 36)
    text = font.render('Le joueur O a gagné.', True, GREEN)
    windowSurface.blit(text, (170, 180))
    match_fini = True


#message d' égalité
def montrerEgalite():
    global match_fini
    font = pygame.font.SysFont(None, 36)
    text = font.render('Aucun joueur gagne.', True, GREY)
    windowSurface.blit(text, (170, 180))
    match_fini = True


#paramètres
continuer = True
while continuer:
    for event in pygame.event.get():
        if event.type == QUIT:
            continuer  = False
        if event.type == MOUSEBUTTONDOWN and event.button==1:
            position_souris = pygame.mouse.get_pos()

            colonne = (position_souris [0] // 200)
            ligne = (position_souris [1] // 133)

            Turn()


#vicoire
    if not match_fini:
        victoire_o = ["o", "o", "o"]
        victoire_x = ["x", "x", "x"]
        for i in range(3):
            if [L[i] for L in Cases] == victoire_o or Cases[i] == victoire_o or [Cases[j][j] for j in range(3)] == victoire_o or [Cases[j][2-j] for j in range(3)] == victoire_o:
                montrerVainqueurO()
            if [L[i] for L in Cases] == victoire_x or Cases[i] == victoire_x or [Cases[j][j] for j in range(3)] == victoire_x or [Cases[j][2-j] for j in range(3)] == victoire_x:
                montrerVainqueurX()

#égalité
        egalite = 0
        for a in Cases:
            if 0 not in a:
                egalite += 1
        if egalite == 3:
            montrerEgalite()


#fin
    pygame.display.flip()
pygame.quit()
