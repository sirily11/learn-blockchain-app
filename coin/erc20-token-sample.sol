pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Coin {
    string public symbol;
    string public name;
    uint8 public decimals;
    // The keyword "public" makes variables
    // accessible from other contracts
    address public minter;
    mapping(address => uint256) public balances;

    // Events allow clients to react to specific
    // contract changes you declare
    event Sent(address from, address to, uint256 amount);

    event Spent(address from, uint256 amount);

    // Constructor code is only run when the contract
    // is created
    constructor() {
        minter = msg.sender;
        symbol = "LBCC";
        name = "Learn Blockchain Token";
        decimals = 10;
    }

    function reward(uint256 amount) public {
        // require(msg.sender == minter);
        require(amount < 100);
        balances[msg.sender] += amount;
    }

    // Sends an amount of existing coins
    // from any caller to an address
    function send(address receiver, uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function balanceOf(address tokenOwner)
        public
        view
        returns (uint256 balance)
    {
        return balances[tokenOwner];
    }
}

contract LBCC is Coin {
    string[] private _stories;

    function addStory(string memory story) public {
        require(10 <= balances[msg.sender]);
        require(0 < bytes(story).length);

        _stories.push(story);
        balances[msg.sender] -= 10;
        emit Spent(msg.sender, 10);
    }

    function getStoryInRange(uint256 start, uint256 end)
        public
        view
        returns (string[] memory)
    {
        uint256 max = end;
        if (max > _stories.length) {
            max = _stories.length;
        }
        uint256 itemCount = max - start;
        string[] memory results = new string[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            results[i] = _stories[i];
        }
        return results;
    }

    function getStorySize() public view returns (uint256) {
        return _stories.length;
    }
}
