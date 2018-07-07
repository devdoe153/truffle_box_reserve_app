import React from "react";

class RoomBox extends React.Component {
    hello(){
        console.log("hellos----");
        this.props.reservationInstance.registRoom("title5", 100, {gas: 300000})
    }
    render() {
        console.log(this.props);
        return(
            <div>
                방이름:<input type="text" name="name" />
                방가격:<input type="text" name="name" />
                <br/>
                <button onClick={()=>this.hello()}>방만들기</button>
            </div>
        )
    }
}

export default RoomBox