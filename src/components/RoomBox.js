import React from "react";

class RoomBox extends React.Component {
    render() {
        console.log(this.props);
        return(
            <div>
                방이름:<input type="text" name="name" />
                방가격:<input type="text" name="name" />
                <br/>
                <button onClick={()=>this.props.roomClickHandler()}>방만들기</button>
            </div>
        )
    }
}

export default RoomBox