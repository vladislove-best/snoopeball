import pygame
import random

object_types = ['snowball','rock']

class player:
    def __init__(self):
        self.speed = 5
        self.move_right = False
        self.move_left = False
        self.size = 10
        self.pos_x = display_width//2
        self.pos_y = display_heigth - self.size - int(40/720*display_heigth)
        self.score = 0

    def walk_right(self):
        self.move_right = True
        self.move_left = False

    def walk_left(self):
        self.move_left = True
        self.move_right = False

    def stop(self):
        self.move_left = False
        self.move_right = False

    def update(self):
        if self.move_right == True:
            self.pos_x += self.speed
        elif self.move_left == True:
            self.pos_x -= self.speed
        pygame.draw.circle(gameDisplay,white,[self.pos_x,self.pos_y], self.size)

class falling_object:
    def __init__(self, object_type):
        self.object_type = object_types [random.randint(0,1)] 
        self.speed = random.randint(3, 7)
        self.size = random.randint(10, 40)
        self.pos_x = random.randint(self.size, display_width-self.size)
        self.pos_y = 0
        
    def update(self):
        self.pos_y += self.speed
        if self.object_type == 'snowball':
            pygame.draw.circle(gameDisplay,white,[self.pos_x,self.pos_y], self.size)
        else:
            pygame.draw.circle(gameDisplay,gray,[self.pos_x,self.pos_y], self.size)
def delete_fo():
    global falling_objects_list
    i=0
    while i < len(falling_objects_list):
        falling_objects_list[i].update()
        if falling_objects_list[i].pos_y > display_heigth - falling_objects_list[i].size - int(30/720*display_heigth):
            del falling_objects_list[i]
        elif abs(falling_objects_list[i].pos_x - player1.pos_x) < player1.size + falling_objects_list[i].size and abs(falling_objects_list[i].pos_y - player1.pos_y) < player1.size + falling_objects_list[i].size:
            if falling_objects_list[i].object_type == 'snowball':
                player1.size += falling_objects_list[i].size//2
                player1.pos_y -= falling_objects_list[i].size//2
            if falling_objects_list[i].object_type == 'rock':
                player1.size -= falling_objects_list[i].size//2
                player1.pos_y += falling_objects_list[i].size//2
            del falling_objects_list[i]
        else:
            i+=1
def gameover():
    textsurface = textfont.render('ПОТЕРЯНО', False, red)
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
        gameDisplay.blit(textsurface, (500,500))
        pygame.display.update()
        clock.tick(FPS)
###################Инициализация###################
pygame.init()
pygame.font.init()

background = pygame.image.load('snow_bg.png')
textfont = pygame.font.SysFont('Comic Sans MS', 30)
display_width = int(1280/1)
display_heigth = int(720/1)
gameDisplay = pygame.display.set_mode((display_width, display_heigth))
background = pygame.transform.scale(background, (display_width, display_heigth))

pygame.display.set_caption('snowball game')
clock = pygame.time.Clock()

white = (255,255,255)
gray = (150, 150, 150)
black = (0,0,0)
red = (255, 0, 0)
action_radius = 50
FPS = 60

player1 = player()
falling_objects_list = []
running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
        ############################
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_a:
                player1.walk_left()             
            elif event.key == pygame.K_d:
                player1.walk_right()                        
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_a or event.key == pygame.K_d:
                player1.stop()
        ############################
    if len(falling_objects_list) < 8:
        falling_objects_list.append(falling_object('snowball'))
    gameDisplay.blit(background, (0,0))
    delete_fo()
    if player1.size < 1:
        gameover()
    player1.update()
    pygame.display.update()
    clock.tick(FPS)