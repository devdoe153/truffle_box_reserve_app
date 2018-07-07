import React from "react";

const RoomBox = React.createClass({
    render:()=>{
        return(
            <div>
                방이름:<input type="text" name="name" />
                방가격:<input type="text" name="name" />
                <br/>
                <button>방만들기</button>
            </div>
        )
    }
});

export default RoomBox