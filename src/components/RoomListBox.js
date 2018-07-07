import React from "react";

class RoomListBox extends React.Component {
    render() {
        let list = [];
        if(this.props.roomList != null){
            list = this.props.roomList;
        }
        console.log(this.props)
        return(
            <table>
                <th>
                    <td>
                        방이름
                    </td>
                    <td>
                        방가격
                    </td>
                </th>
                <tbody>
                    {list.map((arItem)=><RoomItem room={arItem}/>)}
                </tbody>
            </table>
        )
    }
}

function RoomItem(props) {

    const price = props.room[2].toNumber();
    return (
        <tr>
            <td>
                {props.room[1]}
            </td>
            <td>
                {price}
            </td>
        </tr>

    )
}

export default RoomListBox