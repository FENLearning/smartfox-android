package com.smartfoxserver.v2.entities;

import com.smartfoxserver.v2.entities.managers.IRoomManager;
import com.smartfoxserver.v2.entities.variables.RoomVariable;

/**
	* The<em>Room</em>interface defines all the methods and properties that an object representing a SmartFoxServer Room entity exposes.
	*<p>In the SmartFoxServer 2X client API this Interface is implemented by the<em>SFSRoom</em>class. Read the class description for additional informations.</p>
	*
	* @see 	SFSRoom
 */
interface Room {
	/**
	 * Indicates the id of this Room.
	 * It is unique and it is generated by the server when the Room is created.
	 */
	var id(get, null):Int;

	/**
		* Indicates the name of this Room.
		* Two Rooms in the same Zone can't have the same name.
		*
		*<p><b>NOTE</b>:setting the<em>name</em>property manually has no effect on the server and can disrupt the API functioning.
		* Use the<em>ChangeRoomNameRequest</em>request instead.</p>
		*
		* @see com.smartfoxserver.v2.requests.ChangeRoomNameRequest ChangeRoomNameRequest
	 */
	var name(get, set):String;

	/** 
		* Returns the Room Group name.
		* Each Group is identified by a unique string(its name or id)and it represents a different "container" for Rooms.
		*<p>Room Groups enable developers to organize Rooms under different types or categories and let clients select only those Groups they are Interested in, in order to receive their events only.
		* This is done via the<em>SubscribeRoomGroupRequest</em>and<em>UnsubscribeRoomGroupRequest</em>requests.</p>
		*
		* @default default
		*
		* @see com.smartfoxserver.v2.requests.SubscribeRoomGroupRequest SubscribeRoomGroupRequest
		* @see com.smartfoxserver.v2.requests.UnsubscribeRoomGroupRequest UnsubscribeRoomGroupRequest
	 */
	var groupId(get, null):String;

	/**
		* Indicates whether the client joined this Room or not.
		*
		*<p><b>NOTE</b>:setting the<em>isJoined</em>property manually has no effect on the server and can disrupt the API functioning.
		* Use the<em>JoinRoomRequest</em>request to join a new Room instead.</p>
		*
		* @see com.smartfoxserver.v2.requests.JoinRoomRequest JoinRoomRequest
	 */
	var isJoined(get, set):Bool;

	/**
		* Indicates whether this is a Game Room or not.
		*
		*<p><b>NOTE</b>:setting the<em>isGame</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag must be set when creating the Room.</p>
	 */
	var isGame(get, set):Bool;

	/**
		* Indicates whether this Room is hidden or not.
		* This is a utility flag that can be used by developers to hide certain Rooms from the Interface of their application.
		*
		*<p><b>NOTE</b>:setting the<em>isHidden</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag must be set when creating the Room.</p>
	 */
	var isHidden(get, set):Bool;

	/**
		* Indicates whether this Room requires a password to be joined or not.
		*
		*<p><b>NOTE</b>:setting the<em>isPasswordProtected</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag depends on the Room's password set when the Room is created or by means of the<em>ChangeRoomPasswordStateRequest</em>request.</p>
		*
		* @see com.smartfoxserver.v2.requests.ChangeRoomPasswordStateRequest ChangeRoomPasswordStateRequest
	 */
	var isPasswordProtected(get, set):Bool;

	var isManaged(get, set):Bool;

	/**
		* Returns the current number of users in this Room.
		* In case of Game Rooms, this is the number of players.
		*
		*<p><b>NOTE</b>:setting the<em>userCount</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag depends on the Room state.</p>
	 */
	var userCount(get, set):Int;

	/**
		* Returns the maximum number of users allowed in this Room.
		* In case of Game Rooms, this is the maximum number of players.
		*
		*<p><b>NOTE</b>:setting the<em>maxUsers</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag must be set when creating the Room.</p>
	 */
	var maxUsers(get, set):Int;

	/**
		* Returns the current number of spectators in this Room(Game Rooms only).
		*
		*<p><b>NOTE</b>:setting the<em>spectatorCount</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag depends on the Room state.</p>
	 */
	var spectatorCount(get, set):Int;

	/**
		* Returns the maximum number of spectators allowed in this Room(Game Rooms only).
		*
		*<p><b>NOTE</b>:setting the<em>maxSpectators</em>property manually has no effect on the server and can disrupt the API functioning.
		* This flag must be set when creating the Game Room.</p>
	 */
	var maxSpectators(get, set):Int;

	/**
	 * Returns the maximum amount of users, including spectators, that can be contained in this Room.
	 */
	var capacity(get, null):Int;

	/** @private */
	function addUser(user:User):Void;

	/** @private */
	function removeUser(user:User):Void;

	/**
	 * Indicates whether the specified user is currently inside this Room or not.
	 *
	 * @param	user	The<em>User</em>object representing the user whose presence in this Room must be checked.
	 *
	 * @return	<code>true</code>if the user is inside this Room;<code>false</code>otherwise.
	 */
	function containsUser(user:User):Bool;

	/**
	 * Retrieves a<em>User</em>object from its<em>name</em>property.
	 *
	 * @param	name	The name of the user to be found.
	 *
	 * @return	The<em>User</em>object representing the user, or<code>null</code>if no user with the passed name exists in this Room.
	 *
	 * @see		#getUserById()
	 */
	function getUserByName(name:String):User;

	/**
	 * Retrieves a<em>User</em>object from its<em>id</em>property.
	 *
	 * @param	id	The id of the user to be retrieved.
	 *
	 * @return	The<em>User</em>object representing the user, or<code>null</code>if no user with the passed id exists in this Room.
	 *
	 * @see		#getUserByName()
	 */
	function getUserById(id:Int):User;

	/**
	 * Returns a list of<em>User</em>objects representing all the users currently inside this Room.
	 */
	var userList(get, null):Array<User>;

	/**
	 * Returns a list of<em>User</em>objects representing the players currently inside this Room(Game Rooms only).
	 */
	var playerList(get, null):Array<User>;

	/**
	 * Returns a list of<em>User</em>objects representing the spectators currently inside this Room(Game Rooms only).
	 */
	var spectatorList(get, null):Array<User>;

	/**
	 * Retrieves a Room Variable from its name.
	 *
	 * @param	name	The name of the Room Variable to be retrieved.
	 *
	 * @return	The<em>RoomVariable</em>object representing the Room Variable, or<code>null</code>if no Room Variable with the passed name exists in this Room.
	 *
	 * @see		#getVariables()
	 * @see 	com.smartfoxserver.v2.requests.SetRoomVariablesRequest SetRoomVariablesRequest
	 */
	function getVariable(name:String):RoomVariable;

	/**
	 * Retrieves all the Room Variables of this Room.
	 *
	 * @return	The list of<em>RoomVariable</em>objects associated with this Room.
	 *
	 * @see		com.smartfoxserver.v2.entities.variables.RoomVariable RoomVariable
	 * @see		#getVariable()
	 */
	function getVariables():Array<RoomVariable>;

	/** @private */
	function setVariable(roomVariable:RoomVariable):Void;

	/** @private */
	function setVariables(roomVariables:Array<RoomVariable>):Void;

	/**
	 * Indicates whether this Room has the specified Room Variable set or not.
	 *
	 * @param	name	The name of the Room Variable whose existance in this Room must be checked.
	 *
	 * @return	<code>true</code>if a Room Variable with the passed name exists in this Room.
	 */
	function containsVariable(name:String):Bool;

	/** 
	 * Defines a generic utility object that can be used to store custom Room data.
	 * The values added to this object are for client-side use only and are never transmitted to the server or to the other clients.
	 */
	var properties(get, set):Dynamic;

	/**
		* Returns a reference to the Room Manager which manages this Room.
		*
		*<p><b>NOTE</b>:setting the<em>roomManager</em>property manually has no effect on the server and can disrupt the API functioning.</p>
	 */
	var roomManager(get, set):IRoomManager;

	function setPasswordProtected(isProtected:Bool):Bool;
}
