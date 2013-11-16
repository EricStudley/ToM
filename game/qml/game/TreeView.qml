import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    width:scroll.height
    height:scroll.width
    color:"black"

    property int value
    Image{
        id:scroll
        source:"misc/scroll.png"
        anchors.centerIn: parent
        rotation:-90
        z:100
    }
    Column{
        anchors.horizontalCenter: scroll.horizontalCenter
        anchors.verticalCenter: scroll.verticalCenter
        anchors.verticalCenterOffset: 40
        spacing:110
        z:500
        Image{
            id:one
            width: 90
            height:90
            source:"icons/1.png"
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(bar.value>.3&&lineOne.active!=true){
                        lineOne.active=true
                        bar.value-=.3
                    }
                }
            }
        }
        Image{
            id:two
            width: 90
            height:90
            source:"icons/2.png"
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(bar.value>.3&&lineTwo.active!=true&&lineOne.active==true){
                        lineTwo.active=true
                        bar.value-=.3
                    }
                }
            }
        }
        Image{
            id:three
            width: 90
            height:90
            source:"icons/3.png"
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(bar.value>.3&&lineThree.active!=true&&lineTwo.active==true){
                        lineThree.active=true
                        bar.value-=.3
                    }
                }
            }
        }
    }
    TreeLine{
        z:300
        id:lineOne
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:scroll.top
        anchors.topMargin: 110
        width:10
        height:110
    }
    TreeLine{
        z:300
        id:lineTwo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:scroll.top
        anchors.topMargin: 265
        width:10
        height:120
    }
    TreeLine{
        z:300
        id:lineThree
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:scroll.top
        anchors.topMargin: 460
        width:10
        height:130
    }
}
