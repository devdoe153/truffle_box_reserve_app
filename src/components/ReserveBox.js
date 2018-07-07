import React from "react";

class ReserveBox extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            "reserveHost":"",
            "reserveFrom":"",
            "reserveDuration":1
        }
    }
    hello(){
        console.log(this.state);
        this.props.reservationInstance.reserve(
            this.state.reserveHost,
            this.state.reserveFrom,
            this.state.reserveDuration
        )
    }
    handleChangeHost(event){
        this.setState({reserveHost: event.target.value});
    }
    handleChangeFrom(event){
        this.setState({reserveFrom: event.target.value});
    }
    handleChangeDuration(event){
        this.setState({reserveFrom: event.target.value});
    }
    render() {
        console.log(this.props);
        return(
            <div>
                host:<input type="text" name="name" value={this.state.reserveHost} onChange={this.handleChangeHost.bind(this)}/>
                언제부터:<input type="text" name="name" value={this.state.reserveFrom} onChange={this.handleChangeFrom.bind(this)}/>
                몇일동안:<input type="text" name="name" value={this.state.reserveDuration} onChange={this.handleChangeDuration.bind(this)}/>
                <button onClick={()=>this.hello()}>예약하기</button>
            </div>
        )
    }
}

export default ReserveBox