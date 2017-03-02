contract Loan{
    address Lender;
    address Debtor;
    uint256 Principal;
    uint Timestamp;
    uint interestFreq;
    uint interestRate;
    uint interestPlus;
    uint startDate;
    uint endDate;
    mapping (address => uint) Balance;
    enum State {Initialized, Release }
    State status;
    
function Loan (address _borrower, uint _rate, uint _freq, uint _blocknum, uint256 _amount){
    Balance[msg.sender]= this.balance;
    Lender = msg.sender;
    Debtor = _borrower;
    Principal = _amount;
    interestRate = _rate;
    startDate = now;
    interestFreq = _freq;
    endDate = _blocknum;
}

function sendMoney() returns (bool res) {
    if (status != State.Initialized) throw;
    if (msg.sender==Debtor){
        if (Balance[Lender] != Principal)// if the msg.sender is the debtor then how would the money be transfered
        return false;
        Balance[Lender]-= Principal;
        Balance[Debtor]+= Principal;
        return true;
    }
}

function cancel(){
    if (status != State.Release) throw;
    if (msg.sender==Lender){
       Timestamp=block.number;
       suicide (Lender);
    }  
}

function  calcInterest(uint256 _amount, uint _rate) returns (uint _r){
    _r = Principal + (interestRate * Principal);
    
}
 
function payback( uint date) payable returns (bool res) {
    if (msg.sender != Debtor) throw;
    endDate= date;
    if (endDate!= block.number) throw;
    uint amountDue= calcInterest(Principal, interestRate);
    if (msg.value != amountDue)
    {
        if (!Lender.send(msg.value)) throw;
        else return true;
        uint amountLeft = amountDue - msg.value;
    }
     if (!Lender.send(msg.value)) throw;
     else return true;

}
}