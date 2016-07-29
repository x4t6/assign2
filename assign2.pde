//You should implement your assign2 here.
PImage fighter, enemy, treasure, hpBar, bg1, bg2, bgGameStart, bgGameStart_light, bgGameOver, bgGameOver_light ;

final int GAME_START = 1, GAME_RUN = 2, GAME_OVER = 3;
final int FIGHTER_SPEED = 6, ENEMY_SPEED = 3, BG_SPEED = 2 ;
final int GAME_WIDTH = 640, GAME_HEIGHT = 480 ;
final int FIGHTER_WIDTH = 50, FIGHTER_HEIGHT = 50 ;
final int ENEMY_WIDTH = 60, ENEMY_HEIGHT = 60 ;
final int TREASURE_WIDTH = 40, TREASURE_HEIGHT = 40 ;
final int HP_Max = 200 ;

boolean upPressed = false ;
boolean downPressed = false ;
boolean leftPressed = false ;
boolean rightPressed = false ;

int bg1X, bg2X, enemyX, enemyY, treasureX, treasureY, fighterX, fighterY;
int hpLength ;
int gameState ;

void setup () {
  size(640, 480) ;
  fighter = loadImage("img/fighter.png");
  enemy = loadImage("img/enemy.png");
  treasure = loadImage("img/treasure.png");
  hpBar = loadImage("img/hp.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  bgGameStart = loadImage("img/start2.png");
  bgGameStart_light = loadImage("img/start1.png");
  bgGameOver = loadImage("img/end2.png");
  bgGameOver_light = loadImage("img/end1.png");
  
  gameState = GAME_START ;
  bg1X = -640;
  bg2X = 0;
  fighterX = 590 ;
  fighterY = 240;
  enemyX = -60 ; 
  enemyY = (int)random(45,420) ;
  treasureX = (int)random(0,540) ;
  treasureY = (int)random(45,440) ;
  hpLength = HP_Max/5 ;  
  
}

void draw() {
  switch(gameState){    
    case GAME_START :
      image(bgGameStart,0,0);
      if( 208 <= mouseX && mouseX <= 453 && 378 <= mouseY && mouseY <= 412){
        image(bgGameStart_light,0,0) ;
        if(mousePressed)gameState = GAME_RUN ;
      }//if end
      break;
      
    case GAME_RUN :
      image(bg1,bg1X,0); 
      image(bg2,bg2X,0);
      image(treasure,treasureX,treasureY) ;
      image(fighter,fighterX,fighterY);
      image(enemy,enemyX,enemyY);
      
      fill(#FF0000);
      rect(21,19,hpLength,16);
      image(hpBar,15,15);        
      
      //----enemy collision----//
      if( (fighterX>=enemyX && fighterX<=enemyX+ENEMY_WIDTH ) && ( fighterY>=enemyY && fighterY<=enemyY+ENEMY_HEIGHT) ){
        hpLength -= HP_Max/5 ;      
        enemyX = -60 ;
        enemyY = (int)random(45,420) ;  
      }//if end
      if( (fighterX>=enemyX && fighterX<=enemyX+ENEMY_WIDTH ) && ( fighterY+FIGHTER_HEIGHT>=enemyY && fighterY+FIGHTER_HEIGHT<=enemyY+ENEMY_HEIGHT) ){
        hpLength -= HP_Max/5 ;      
        enemyX = -60 ;
        enemyY = (int)random(45,420) ;  
      }//if end
      if( (fighterX+FIGHTER_WIDTH>=enemyX && fighterX+FIGHTER_WIDTH<=enemyX+ENEMY_WIDTH ) && ( fighterY+FIGHTER_HEIGHT>=enemyY && fighterY+FIGHTER_HEIGHT<=enemyY+ENEMY_HEIGHT) ){
        hpLength -= HP_Max/5 ;
        enemyX = -60 ;
        enemyY = (int)random(45,420) ;    
      }//if end
      if( (fighterX+FIGHTER_WIDTH>=enemyX && fighterX+FIGHTER_WIDTH<=enemyX+ENEMY_WIDTH ) && ( fighterY>=enemyY && fighterY<=enemyY+ENEMY_HEIGHT) ){
        hpLength -= HP_Max/5 ;      
        enemyX = -60 ;
        enemyY = (int)random(45,420) ;  
      }//if end
      
      //----get treasure----//
      if( ( treasureX>=fighterX && treasureX<=fighterX+FIGHTER_WIDTH ) && ( treasureY>=fighterY && treasureY<=fighterY+FIGHTER_HEIGHT ) ){
        if( hpLength < HP_Max ) hpLength += HP_Max/10 ;
        treasureX = (int)random(0,540) ;
        treasureY = (int)random(45,440) ;
      }//if end
      if( ( treasureX>=fighterX && treasureX<=fighterX+FIGHTER_WIDTH ) && ( treasureY+TREASURE_HEIGHT>=fighterY && treasureY+TREASURE_HEIGHT<=fighterY+FIGHTER_HEIGHT ) ){
        if( hpLength < HP_Max ) hpLength += HP_Max/10 ;
        treasureX = (int)random(0,540) ;
        treasureY = (int)random(45,440) ;
      }//if end    
      if( ( treasureX+TREASURE_WIDTH>=fighterX && treasureX+TREASURE_WIDTH<=fighterX+FIGHTER_WIDTH ) && ( treasureY+TREASURE_HEIGHT>=fighterY && treasureY+TREASURE_HEIGHT<=fighterY+FIGHTER_HEIGHT ) ){
        if( hpLength < HP_Max ) hpLength += HP_Max/10 ;
        treasureX = (int)random(0,540) ;
        treasureY = (int)random(45,440) ;
      }//if end
      if( ( treasureX+TREASURE_WIDTH>=fighterX && treasureX+TREASURE_WIDTH<=fighterX+FIGHTER_WIDTH ) && ( treasureY>=fighterY && treasureY<=fighterY+FIGHTER_HEIGHT ) ){
        if( hpLength < HP_Max ) hpLength += HP_Max/10 ;
        treasureX = (int)random(0,540) ;
        treasureY = (int)random(45,440) ;
      }//if end
      
      //----bg move----//
      bg1X += BG_SPEED; bg2X += BG_SPEED; 
      if(640 < bg1X) bg1X = -640 ; 
      if(640 < bg2X) bg2X = -640 ;  
      
      //----fighter move----//
      if(upPressed)
        fighterY -= FIGHTER_SPEED ;        
      if(downPressed)
        fighterY += FIGHTER_SPEED ;        
      if(leftPressed)
        fighterX -= FIGHTER_SPEED ;        
      if(rightPressed)
        fighterX += FIGHTER_SPEED ;
        
      //----let fighter not to out of bound----//  
      if(fighterX <=0)
        fighterX = 0 ;
      if( fighterX >= GAME_WIDTH-FIGHTER_WIDTH )
        fighterX = GAME_WIDTH - FIGHTER_WIDTH ;
      if(fighterY <=0)
        fighterY = 0 ;
      if( fighterY >= GAME_HEIGHT-FIGHTER_HEIGHT )
        fighterY = GAME_HEIGHT -FIGHTER_HEIGHT ;     
          
      //----enemy move----//
      enemyX +=  ENEMY_SPEED ;
      if(enemyX > 640){
        enemyY = (int)(random(0,420));
        enemyX = -60 ;
      }//if end
      
      //----enemy chase----//
      if(enemyX+ENEMY_WIDTH/2<fighterX+FIGHTER_WIDTH){
        if(enemyY+ENEMY_HEIGHT/2 < fighterY+22) 
          enemyY += ENEMY_SPEED ;
        else if(enemyY+ENEMY_HEIGHT/2 > fighterY+FIGHTER_HEIGHT-22)
          enemyY -= ENEMY_SPEED ;
      }//if end
      
      //----out of hp----//
      if(hpLength <= 0)
        gameState = GAME_OVER ;    
      break ;
      
    case GAME_OVER :
      image(bgGameOver,0,0) ;
      if( (mouseX>=209 && mouseX<= 433) && (mouseY>=311 && mouseY <=345) ){
        image(bgGameOver_light,0,0) ;
        if(mousePressed) {
          gameState = GAME_RUN ;
          bg1X = -640;
          bg2X = 0;
          fighterX = 590 ;
          fighterY = 240;
          enemyX = -60 ; 
          enemyY = (int)random(45,420) ;
          treasureX = (int)random(0,540) ;
          treasureY = (int)random(45,440) ;
          hpLength = HP_Max/5 ;  
        }//if end
      }//if end
      break ;  
  }//switch end
}//draw end
void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      
      case UP :
        upPressed = true ;
        break ; 
        
      case DOWN :
        downPressed = true ;
        break ;  
        
      case LEFT :
        leftPressed = true ;
        break ;
        
      case RIGHT :
        rightPressed = true ;
        break ;
    }//swtich end
  }//if end
}//keyPressed end

void keyReleased(){  
  if(key == CODED){
    switch(keyCode){      
      case UP :
        upPressed = false ;
        break ;
      
      case DOWN :
        downPressed = false ;
        break ;
       
      case LEFT :
        leftPressed = false ;
        break ;
      
      case RIGHT :
        rightPressed = false ;
        break ;
    }//swtich end
  }//if end
}//keyReleased end
