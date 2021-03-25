pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name; /*declare type, visibility, variable*/
    uint public postCount = 0;
    mapping(uint => Post) public posts;

    struct Post{
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    }

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author

    );   
    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author

    );   

    constructor() public {
        name = "Dapp University Social Network";
    }
//want contract to create posts, list all the posts, tip the post with crypto
    function createPost(string memory _content) public {
        //Require valid content
        require(bytes(_content).length > 0);
        // increment post count
        postCount ++;
        // create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        //trigger event
        emit PostCreated(postCount, _content, 0, msg.sender);
    }
    function tipPost(uint _id) public payable {
        //make asure id is valid
        require(_id > 0 && _id <= postCount);
        // fetch post
        Post memory _post = posts[_id];
        // fetch author
        address payable _author = _post.author;
        //pay author
        address(_author).transfer(msg.value);
        //increment tip amt
        _post.tipAmount = _post.tipAmount + msg.value;
        //update post
        posts[_id] = _post;
        //trigger an event
        emit PostTipped(postCount, _post.content, _post.tipAmount, _author);
    
        
    }

}    

