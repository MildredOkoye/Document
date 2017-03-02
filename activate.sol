contract mortal{
    address public owner;
    
    function mortal(){
        owner= msg.sender;
    }
    
    modifier onlyOnwer {
        if (msg.sender != owner) {throw;} 
        else {
            _ ;
        }
            
        
    }
    
    function kill(){
        suicide(owner);
    }
}
 
contract User is mortal{
    string public userName;
    mapping(address => Service) public service;
    
    struct Service {
        bool active;
        uint lastUpdate;
        uint256 debt; //this is becos you are dealing with ether cos the denomination of eher is based on the 256 bit size

    
    }
    function User(string _name){
        userName = _name;
    }
    
    function registerToProvider(address _provideraddress) onlyOnwer {
        service[_provideraddress]= Service({
            active: true,
            lastUpdate:now, 
            debt:0
        });
        
    }
    function setDebt(uint256 _debt)
    {
        if(service[msg.sender].active)
        {
            service[msg.sender].lastUpdate = now;
            service[msg.sender].debt = _debt;
        }
        else throw;
    }
    
}
contract Provider is mortal{
    string public providerName;
    string public description; //the type of service to the provided
    
    function Provider (string _name, string _describe)
    {
        providerName = _name;
        description = _describe;
    }
    function setDebt(uint256 _debt, address _user)
    {
        User Chidinma = User(_user);
        Chidinma.setDebt(_debt); 
        
    }
}