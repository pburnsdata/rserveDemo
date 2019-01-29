package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;


public class DemoApplication {
    public static void main(String[] args) throws RserveException,
            REXPMismatchException {
        RConnection c = new RConnection();
        // source the Palindrom function
        c.eval("source('C:/Users/spburns/Downloads/Palindrome.R')");
 
        // call the function. Return true
        REXP is_aba_palindrome = c.eval("palindrome('aba')");
        System.out.println(is_aba_palindrome.asInteger()); // prints 1 => true
 
        // call the function. return false
        REXP is_abc_palindrome = c.eval("palindrome('abc')");
        System.out.println(is_abc_palindrome.asInteger()); // prints 0 => false;
 
    }
 
}
//
//public class DemoApplication {
//	 
//    public static void main(String[] args) throws RserveException,
//            REXPMismatchException {
//        RConnection c = new RConnection();
//        REXP x = c.eval("R.version.string");
//        double d[] = c.eval("rnorm(10)").asDoubles();
//        System.out.println(d);
//        System.out.println(x.asString());
//        
//    }
//}

//@Controller
//@SpringBootApplication
//public class DemoApplication {
//
//	@RequestMapping("/")
//	@ResponseBody
//	String home() {
//		
//		RConnection c = new RConnection();
//		REXP x = c.eval("R.version.string");
//		System.out.println(x.asString());
//		
//		return "Greetings from Java Tutorial Network";
//	}
//	
//	public static void main(String[] args) {
//		SpringApplication.run(DemoApplication.class, args);
//	}
//
//}

