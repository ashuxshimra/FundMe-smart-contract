//Get funds from users into this smart contract
//withdraw funds
//set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{
uint256 minusd=50*1e18;//that is 50 dollars note : 50/1eth price here it can be in terms of dollar gives amount of ether for the min usd 50 , so u have to enter more than the obtained ether amount as needed by fund function
   address[] public funders; //a data structrue to keep a track so made this to record the addresses of the wallet that is msg.sender who are giving funds , so say ur wallet address and hence if sending from that then it is the msg.sender and its of address type
   mapping(address=>uint256) public addressToAmountFunded; //a track of those addresses to check how much amount they funded



   
   
    function fund() public payable{ //this fund function made so that funds can be given to this sc and only the owner will be able to withdraw this and use it how he wants to
//want to be able to set a minimum fund amount in USD   
//1.How do we send ETH to this contract , so here to transfer funds to this smart contract you are making this fund and function and it is payable so to send and recceive and make the button red we use this keyword
// require(msg.value > 1e18, "Didnt get enough fund"); //hence require is like a checker which checks and if this is not acc to it wants then the next message that is didnt receive enough funds is executed and transaction is reverted so also here 1e18 implies = 1ether or can be 1 avalanche or 1 polygon or any blockchain token also 1eth = 18'zero =1wei u can get this all with etherium unit converter and msg.value is the amount of value that you are funding to this sc
    //also when deployed this sc ,before clicking on fund button to allocte the sc and when u are typing say 1 Ether in the VALUE section and click on fund then that part of fund is allocated to the sc you are using and thus sc has this fund now and then you can make a function to withdraw it ,here fund >1e18 so if u give 1 Ether value then it will show red cross error in terminal and everything will be reverted so give more than this say 2 ether then click fund function button and 2Ether will be given to sc
    //note that msg.value is the value in terms of Etherium and hence say if you want to convert it into in terms of USD then chainlink can be helpful , also here we want to fund minimun amount of Usd Fund and so in require we are comparing in terms of etherium
    //so as you know the smarct contracts doesnt know about the outside values of coins say ETH or USD it doesnt know whats going outside and hence this is the problem of sc where integrating with outside data is not possible but this is how chainlink solves this problem
    //chainlink is the decentralised oracle network which brings data and external computations into our smarct contract so this is also called blockchain oracle which is a device which provides off chain data from external to our smart contract 
    //see page 12 upto page 14 in ur quicktakes web3 note to understand all about data feeds in chainlink
    //hence the data feeds and these price feeds as discussed in the above note are one of the most powerful decentralised features that you can use to level up the defi finance
    //check the note from page 12 to 18 for the working of a example of sc of chainlink
    //note that in order to interact with a smart contract from ooutside you need : Address and ABI : it is the list of all the functionalities that you can use or perform in a sc
    require(getConversionRate(msg.value) > minusd, "Didnt get enough fund"); //after below functions made , now we want to make sure that things are funded in terms of usd hence this function gives usd amount for entered eth amount and we are initialising minusd amount above ,also commented put the above require
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender]=msg.value;//what address has given how much amount that is msg.value 
    }//msg.sender is also the one who is calling the smarct contract say metmask popping with a acoount and u are sending money to sc that is funding hence that account is calling the sc msg.sender
   function getPrice() public view returns(uint256){//to get the conversion of real rate we are making this , and since we here have to deal with instance from outside sc as here for rates and stuff they come from oustide data , so to interact with a sc which is outside of our project we use two things Address of it and ABI , Address u can find for ETH/USD under etherium network from chain link and copy it , rest to get the interface abi,check note page 20 
//obtained Address :0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e , also we are getting outside needed data from the chain link as it provides in decentralised manner
//ABI : go to github.com/smartcontractkit/chainlink and contracts->src->v0.8->->INTERFACES->AggregatorV3iNTERFACE , if u note that u just have functions there with no logic which is exactly what an ABI of a sc usually is so you can copy the code and make a separate sc and import over here in this sc ,hence make the name as : AggregatorV3.sol of sc but you dont have to actually import this way , since we got this ABI from the github repo , we can directly import it from there as https://docs.chain.link/docs/data-feeds/price-feeds/ and then go under the SOLIDITY sc and copy the import part of import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; thus this is also referring to the same file we saw in git hub , so when done this simply remix recognises the chainlink and imports directly so for future reference u can do this
AggregatorV3Interface avi=AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
//now the above ABI combined with the address of sc , you get sc with all the functionalities that the ABI has and so if you go and see the code of ABI on given github you will see it has LatestPrice function that is returning roundId, price , etc but we only care about the price and so just include it as :
(,int price,,,)=avi.latestRoundData();//so calling the latestRoundData function of sc as it has fucntiosn of abi now and it all is returning as per the gitgub code of abi check and in that order keep things in LHS , so this line will get is value of ETH in terms of USD (since address of sc taken is for eth/usd)
return uint256(price*1e10);//when u get price u can see it returns decimal function as well so say if 3000.00000000 is the eth in terms of usd then we have to put decimal manually and given 8 places from rhs since soliditu doesnt work with decimal and so there are 10 digits after decimal and msg.value the amount we enter and give for our sc it is in terms of ethers more equal to wei which has 18 zeros so we multiply with 1e10 that is 1 exponential 10 so 10 0 digits hence it will match with the amount entered and if entered amount is say 2 18 zero then it is 2 ether and geting usd as 3000, 18 zero now , also in above since msg.value is of uint256 type but here price returned is of int type that is mainly because the prices can be -ive as well so lets just convert this to uint25 as well hence done by wrapping it around uint256
//note that : ABI combined with the address of sc gives us the entire sc and thus all functions and its address gives sc,
  }
function getVersion() public view returns(uint256){
AggregatorV3Interface avi=AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e); //here ABI combined with the address of the sc for ETH/USD gives us the sc and thus storing it in avi variable of type interface so whatever functionalities are there in this ABI all of it  will be having it in the sc of this address that is if u check , version function , latestRoundData function, getRoundData function all these now this sc of this address must be having now
return avi.version(); //returing the version of sc being used as this function is in the abi so you can access it using the type of abi variable which has stored sc
}
function getConversionRate(uint256 ethAmount) public view returns(uint256){//this function is used to convert the entered eth amount into the usd 
uint256 ethPrice=getPrice();//this will give us the eth amount in terms of usd amount
//1_18's0 is 1 ether , and our ethAmountInUSD is x_18's0 so multiplying will lead to some big so dividing by 1e18
uint256 ethAmountInUSD=(ethAmount*ethPrice)/1e18;//this will get the total amount of usd for entered ethamount
return ethAmountInUSD;
}
}
// contract withdraw() public
//if u want to see the more clear way of this code then u can do that by removing the math functions to other contract and import them and use them , almost same just more clear to see it go check the git repo of patrick in 4:30:01 but no need this great as well