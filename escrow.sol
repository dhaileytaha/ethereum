pragma solidity ^0.4.18;

contract Escrow {
    
    enum State {
        AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED
    }
    State public currentState;
    
    modifier buyerOnly(){
        require(msg.sender == buyer || msg.sender == arbiter);
        _;    
    }
    modifier sellerOnly(){
        require(msg.sender == seller || msg.sender == arbiter);
        _;
    }
    modifier escrowState(State _state){
        require(currentState == _state);
        _;
    }
    address buyer;
    address seller;
    address arbiter;
    
    // to specify who are buyer, seller and arbiter 
    function Escrow(address _buyer, address _seller, address _arbiter){
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
    }
    
    function confirmPayment() buyerOnly escrowState(State.AWAITING_PAYMENT) payable {
        currentState = State.AWAITING_DELIVERY;
    }
    function confirmDelivery() escrowState(State.AWAITING_DELIVERY) {
        seller.send(this.balance);
        currentState = State.COMPLETE;
    }
    function refundBuyer() sellerOnly escrowState(State.AWAITING_DELIVERY) {
        buyer.send(this.balance);
        currentState = State.REFUNDED;
           
    }
}
