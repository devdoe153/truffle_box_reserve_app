import React from "react";

class RoomListBox extends React.Component {
    render() {

        const list = [
            {"name":"krk", "price":100},
            {"name":"krk2", "price":100}
        ];
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
                {list.map((item)=><RoomItem room={item}/>)}

            </table>
        )
    }
}

function RoomItem(props) {
    return (
        <tr>
            <td>
                {props.room.name}
            </td>
            <td>
                {props.room.price}
            </td>
        </tr>

    )
}

export default RoomListBox