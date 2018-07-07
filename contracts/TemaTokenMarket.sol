pragma solidity ^0.4.24;

import "./TemaToken.sol";

/** This is an assignment to create a smart contract that allows you to run your own token crowdsale.
 *  Your contract will mint your custom token every time a purchase is made by your or your classmates.
 *  We've provided you with the pseudocode and some hints to guide you in the right direction.
 *  Make sure to implement the best practices you learned during the Solidity Walkthrough segment.
 *  Check for errors by compiling often. Ask your classmates for help - we highly encourage student collaboration.
 *  You should be able to deploy your crowdsale contract onto the Kovan testnet and buy/sell your classmates' tokens.
 */

// Set up your contract.
contract TemaTokenMarket {
    // Attach SafeMath library functions to the uint256 type.
    using SafeMath for uint256;

    // Define 4 publicly accessible state variables.
    // Your custom token being sold.
    ERC20 public tokenAddress;
    // Wallet address where funds are collected.
    address public walletAddress;
    // Rate of how many token units a buyer gets per wei. Note that wei*10^-18 converts to ether.
    uint256 public weiToTokenRate;
    // Amount of wei raised.
    uint256 public weiRaised;

    /** Create event to log token purchase with 4 parameters:
    * 1) Who paid for the tokens
    * 2) Who got the tokens
    * 3) Number of weis paid for purchase
    * 4) Amount of tokens purchased
    */
    event TokenPurchase(address _from, address _to, uint _weiAmount, uint _tokenAmount);

    /** Create publicly accessible constructor function with 3 parameters:
    * 1) Rate of how many token units a buyer gets per wei
    * 2) Wallet address where funds are collected
    * 3) Address of your custom token being sold
    * Function modifiers are incredibly useful and effective. Make sure to use the right ones for each Solidity function you write.
    */
    constructor (uint256 _weiToTokenRate, address _walletAddress, ERC20 _tokenAddress) public {
        // Set conditions with require statements to make sure the rate is a positive number and the addresses are non-zero.
        require(_weiToTokenRate > 0);
        require(_walletAddress != address(0));
        require(_tokenAddress != address(0));
        // Set inputs as defined state variables
        weiToTokenRate = _weiToTokenRate;
        walletAddress = _walletAddress;
        tokenAddress = _tokenAddress;
    }

    // THIS PORTION IS FOR THE CONTRACT'S EXTERNAL INTERFACE.
    // We suggest skipping down to fill out the internal interface before coming back to complete the external interface.

    // Create the fallback function that is called whenever anyone sends funds to this contract.
    // Fallback functions are functions without a name that serve as a default function.
    // Functions dealing with funds have a special modifier.
    function() external payable {
        // Call buyTokens function with the address defaulting to the address the message originates from.
        buyTokens(msg.sender);
    }

    // Create the function used for token purchase with one parameter for the address performing the token purchase.
    function buyTokens(address _beneficiary) public payable {

        // Define a uint256 variable that is equal to the number of wei sent with the message.
        uint256 weiAmount = msg.value;

        // Call function that validates an incoming purchase.
        _preValidatePurchase(_beneficiary, weiAmount);

        // Calculate token amount to be created and define it as type uint256.
        uint256 tokenAmount = _getTokenAmount(weiAmount);

        // Update amount of funds raised.
        weiRaised = weiRaised.add(msg.value);

        // Call function that processes a purchase.
        _processPurchase(_beneficiary, tokenAmount);

        // Raise the event associated with a token purchase.
        emit TokenPurchase(msg.sender, _beneficiary, weiAmount, tokenAmount);

        // Call function that stores ETH from purchases into a wallet address.
        _forwardFunds();

    }

    // THIS PORTION IS FOR THE CONTRACT'S INTERNAL INTERFACE.
    // Remember, the following functions are for the contract's internal interface.

    // Create function that validates an incoming purchase with two parameters: beneficiary's address and value of wei.
    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal pure {
        // Set conditions to make sure the beneficiary's address and the value of wei involved in purchase are non-zero.
        require(_beneficiary != address(0), "beneficiary can't be zero");
        require(_weiAmount != 0, "weiAmount can't be zero");
    }

    // Create function that delivers the purchased tokens with two parameters: beneficiary's address and number of tokens.
    function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal {
        // Set condition that requires contract to mint your custom token with the mint method inherited from your MintableToken contract.
        require(MintableToken(tokenAddress).mint(_beneficiary, _tokenAmount) == true, "can't mint token");
    }

    // Create function that executes the deliver function when a purchase has been processed with two parameters: beneficiary's address and number of tokens.
    function _processPurchase(address _beneficiary, uint256 _tokenAmount) internal {
        _deliverTokens(_beneficiary, _tokenAmount);
    }

    // Create function to convert purchase value in wei into tokens with one parameter: value in wei.
    // Write the function so that it returns the number of tokens (value in wei multiplied by defined rate).
    // Multiplication can be done as a method.
    function _getTokenAmount(uint256 _weiAmount) internal view returns (uint256) {
        return _weiAmount.mul(weiToTokenRate);
    }

    // Create function to store ETH from purchases into a wallet address.
    function _forwardFunds() internal {
        walletAddress.transfer(msg.value); // weiRaised
    }

}