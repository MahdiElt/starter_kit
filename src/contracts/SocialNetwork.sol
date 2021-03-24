pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name; /*declare type, visibility, variable*/
    uint public postCount = 0;
    mapping(uint => Post) public posts;

    struct Post{
        uint id;
        string content;
        uint tipAmount;
        address author;
    }

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address author

    );   

    constructor() public {
        name = "Dapp University Social Network";
    }
//want contract to create posts, list all the posts, tip the post with crypto
    function createPost(string memory _content) public {
        //Rewuire valid content
        require(bytes(_content).length > 0);
        // increment post count
        postCount ++;
        // create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        //trigger event
        emit PostCreated(postCount, _content, 0, msg.sender);
    }

}    

