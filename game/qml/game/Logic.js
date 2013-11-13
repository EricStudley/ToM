var optionSelector=0

function getRandom(minimum,maximum){
    var now=new Date()
    return Math.floor(Math.random(now.getSeconds())*(maximum-minimum+1))+minimum;
}
