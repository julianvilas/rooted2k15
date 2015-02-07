package org.apache.struts.helloworld.model;

/**
 * Model class that stores a message.
 * @author Bruce Phillips
 *
 */
public class MessageStore {
	
	private String message;
	
	public MessageStore() {
		
		setMessage("Hi RootedCON pals");
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
