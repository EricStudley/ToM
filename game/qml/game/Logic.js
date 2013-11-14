var optionSelector=0

function getRandom(minimum,maximum){
    var now=new Date()
    return Math.floor(Math.random(now.getSeconds())*(maximum-minimum+1))+minimum;
}

function checkCollision(a,b){
    return !(
                ((a.y+a.height)<(b.y))||
                (a.y>(b.y+b.height))||
                ((a.x+a.width)<b.x)||
                (a.x>(b.x+b.width))
                )
}

function getRotation(x, y, pointx, pointy){
    if(pointx>=x){
        if(pointy>=y)
            return 180-(Math.atan((pointx-x)/(pointy-y))*(180/Math.PI))
        else
            return Math.atan((pointx-x)/(y-pointy))*(180/Math.PI)
    }
    else{
        if(pointy>y)
            return 180+(Math.atan((x-pointx)/(pointy-y))*(180/Math.PI))
        else
            return 360-(Math.atan((x-pointx)/(y-pointy))*(180/Math.PI))
    }
}

function moveCharacter(move, character, characterMiddleX, characterMiddleY){
    character.stop()
    var moveX=move.x-(character.width/2)
    var moveY=move.y-(character.height/2)
    var direction=getRotation(characterMiddleX,characterMiddleY,move.x,move.y)
    var xDif=(Math.abs((character.x)-(move.x)))
    var yDif=(Math.abs((character.y)-(move.y)))
    var pythag=Math.sqrt((xDif^2)+(yDif^2))
    character.playerSpeed=pythag*40
    if(direction<45||direction>315){
        character.playerDirection="up"
    }
    else if(direction>45 && direction<135){
        character.playerDirection="right"
    }
    else if(direction>135 && direction<225){
        character.playerDirection="down"
    }
    else{
        character.playerDirection="left"
    }
    if(moveX<=map.mapTopLeftX){
        character.x=map.mapTopLeftX+(character.width/2)
        if(moveY<=map.mapTopLeftY){
            character.y=map.mapTopLeftY
        }
        else if(moveY>=map.mapBottomLeftY-character.height){
            character.y=map.mapBottomLeftY-character.height
        }
        else{
            character.y=moveY
        }
    }
    else if(moveX>=map.mapTopRightX){
        character.x=map.mapTopRightX-character.width
        if(moveY<=map.mapTopLeftY){
            character.y=map.mapTopLeftY
        }
        else if(moveY>=map.mapBottomLeftY-character.height){
            character.y=map.mapBottomLeftY-character.height
        }
        else{
            character.y=moveY
        }
    }
    else{
        character.x=moveX
        if(moveY<=map.mapTopLeftY){
            character.y=map.mapTopLeftY
        }
        else if(moveY>=map.mapBottomLeftY-character.height){
            character.y=map.mapBottomLeftY-character.height
        }
        else{
            character.y=moveY
        }
    }
}

