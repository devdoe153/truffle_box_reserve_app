import React from "react";

class RoomListBox extends React.Component {
    render() {
        const name = "hello";

        return(
            <div>
                방목록보기
                {this.props.name}
            </div>
        )
    }

}

export default RoomListBox