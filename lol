import pygame

pygame.init()

pygame.font.init()

display_width = 1280
display_height = 700

gameDisplay = pygame.display.set_mode((display_width,display_height))
pygame.display.set_caption('два снуптога играют в футбол')

black = (0,0,0)
white = (255,255,255)

clock = pygame.time.Clock()
crashed = False
carImg = pygame.image.load('racecar.png')
Ball_Img = pygame.image.load('ball.png')
car2_Img = pygame.image.load('racecar.png')    

def car(x,y):
    gameDisplay.blit(carImg, (x,y))

def Ball(x,y):
    gameDisplay.blit(Ball_Img, (x,y))

def car2(x,y):
    gameDisplay.blit(car2_Img, (x,y))

def score1(scorep1):
       gameDisplay.blit(scorep1,(display_width * 0.4,display_height * 0.50))

def score2(scorep2):
       gameDisplay.blit(scorep2,(display_width * 0.6,display_height * 0.50))

x =  (display_width * 0.80)
y = (display_height * 0.80)	#1
x_ball =(display_width * 0.5)
y_ball =(display_height * 0.5)
x_car2 =(display_width * 0)
y_car2 =(display_height * 0)
font=pygame.font.SysFont('Comic Sans MS', 30)
textp1= (display_width * 0.4)
textp1= (display_height * 0.90)
textp2= (display_width * 0.6) 
textp2= (display_height * 0.90)
p1=0
p2=0 
x_change = 0
y_change = 0
ball_x_change = 0
ball_y_change = 0
car2_x_change =0
car2_y_change =0
# spawn = False
car_speed = 0
ball_speed = 0
car2_speed =0
while not crashed:
    scorep1 = font.render(str(p1),False, (0,0,255))
    scorep2 = font.render(str(p2),False, (255,0,0))
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            crashed = True
        ############################
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_a:
                car2_x_change = -5
            elif event.key == pygame.K_d:
                car2_x_change = 5
            elif event.key == pygame.K_w:
                car2_y_change = -5
            elif event.key == pygame.K_s:
                car2_y_change = 5
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_a or event.key == pygame.K_d:
                car2_x_change = 0
            elif event.key == pygame.K_w or event.key == pygame.K_s:
                car2_y_change = 0
        ############################
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                x_change = -5
            elif event.key == pygame.K_RIGHT:
                x_change = 5
            elif event.key == pygame.K_UP:
                y_change = -5
            elif event.key == pygame.K_DOWN:
                y_change = 5
            # elif event.key == pygame.K_w:
            #    print("W")
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_LEFT or event.key == pygame.K_RIGHT:
                x_change = 0
            elif event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                y_change = 0
        ######################
    ##
    x += x_change
    y += y_change

    x_car2 += car2_x_change
    y_car2 += car2_y_change
    ##         
    gameDisplay.fill(white)
    if abs(x-x_ball)<=64+64 and abs(y-y_ball)<=64+64:
        p1+=1       
        if x_ball-x>0:
            ball_x_change = 5
        else:
            ball_x_change = -5
        if y_ball-y>0:
            ball_y_change = 5
        else:
            ball_y_change = -5
    if abs (x_car2 - x_ball)<=64+64 and abs(y_car2-y_ball)<=64+64:
        p2+=1     
        if x_ball-x>0:
            ball_x_change = 5
        else:
            ball_x_change = -5
        if y_ball-y>0:
            ball_y_change = 5
        else:
            ball_y_change = -5

    x_ball += ball_x_change
    y_ball += ball_y_change

    if x_ball > display_width:
        x_ball=0
    if x_ball < 0:
        x_ball = display_width
    if y_ball > display_height:
        y_ball=0
    if y_ball < 0:
        y_ball = display_height
                
    car(x,y)
    car2(x_car2,y_car2)
    Ball(x_ball,y_ball)
    score1(scorep1)
    score2(scorep2)
    pygame.display.update()
    clock.tick(60)



pygame.quit()
quit()
