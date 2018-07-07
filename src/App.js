import React, {Component} from 'react'
import Reservation from '../build/contracts/Reservation.json'
import getWeb3 from './utils/getWeb3'

import RoomBox from './components/RoomBox';
import RoomListBox from './components/RoomListBox';

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {
    constructor(props) {
        super(props)

        this.state = {
            storageValue: 0,
            web3: null,
            "defaultAccount":"",
            "reservationInstance": null
        }
    }

    componentWillMount() {
        // Get network provider and web3 instance.
        // See utils/getWeb3 for more info.

        getWeb3
            .then(results => {
                this.setState({
                    web3: results.web3
                })

                // Instantiate contract once web3 provided.
                this.instantiateContract()
            })
            .catch(() => {
                console.log('Error finding web3.')
            })
    }

    temaTokenInstance;
    reservationInstance;

    instantiateContract() {
        const contract = require('truffle-contract')
        const reservation = contract(Reservation);
        reservation.setProvider(this.state.web3.currentProvider);

        // Get accounts.
        this.state.web3.eth.getAccounts( async (error, accounts) => {
            this.state.web3.eth.defaultAccount = accounts[4];
            var reservationInstance = await reservation.deployed();


            var roomCount = await reservationInstance.roomCount().then(r => r.toNumber());
            var roomList = [];
            for(var i = 0; i < roomCount; i++) {
                var room = await reservationInstance.roomByIndex(i);
                // console.log("room", i, room);
                roomList.push(room);
            }
            this.setState({
                roomList1: roomList,
                accountList: accounts,
                "defaultAccount":accounts[2],
                "reservationInstance": reservationInstance
            })
        })


        // console.log(this.state.accountList[1]);

        // this.makeReservation(this.state.accountList[0], "2018-01-01", 3);
        // this.getReservationForGuest(this.state.accountList[0]);

    }

    // rooms
    registRoom(title, pricePerDay) {
        console.log("here----");
        this.state.reservationInstance.registRoom(title, pricePerDay, {gas: 300000});
        this.setState({"hello":"nello"});
        this.render();
    }

    getRoomList() {
        console.log(this.state);
        var roomCount = this.state.reservationInstance.roomCount().then(r => r.toNumber());
        var roomList = [];
        for(var i = 0; i < roomCount; i++) {
            var room = this.state.reservationInstance.roomByIndex(i);
            roomList.push(room);
        }
        console.log(roomList);
        this.setState({
            roomList1: roomList
        });
    }

    async getRoomForHost(host) {
        return await this.reservationInstance.rooms(host);
    }

    // reservation
    async makeReservation(host, from, duration) {
        await this.reservationInstance.reserve(host, from, duration);
    }

    async getReservationForGuest(guest) {
        const reservation = await this.reservationInstance.reserves(guest);
        return reservation;
    }

    async checkout(comment, grade) {
        await this.reservationInstance.checkout(comment, grade);
    }


    async claim(from, comment, grader) {
        await this.reservationInstance.claim(from, comment, grader);
    }

    roomClickHandler(){
        console.log("click here");
        this.state.reservationInstance.registRoom('title4', 100, {gas: 300000});
    }

    render() {
        return (
            <div className="App">
                <nav className="navbar pure-menu pure-menu-horizontal">
                    <a href="#" className="pure-menu-heading pure-menu-link">Tema 토큰</a>
                </nav>

                <main className="container">
                    <div className="pure-g">
                        <div className="pure-u-1-1">
                            <h1>Tema Token!</h1>
                            <p>테마 토큰 호텔 예약 D앱 입니다.</p>
                            <p>defaultAccount : {this.state.defaultAccount}</p>
                            <h2>Smart Contract Example</h2>
                            <RoomListBox roomList={this.state.roomList1} name="hello"/>
                            <RoomBox reservationInstance={this.state.reservationInstance}/>
                            <button onClick={() => this.roomClickHandler()}>submit</button>
                            <p>If your contracts compiled and migrated successfully, below will show a stored value of 5
                                (by default).</p>
                            <p>Try changing the value stored on <strong>line 59</strong> of App.js.</p>
                            <p>The stored value is: {this.state.storageValue}</p>
                        </div>
                    </div>
                </main>
            </div>
        );
    }
}

export default App
