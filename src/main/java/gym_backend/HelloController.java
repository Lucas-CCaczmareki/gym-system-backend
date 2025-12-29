package gym_backend;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


// This class is a controller
@RestController
public class HelloController {
    
    // This controller (class) is receiving a get request (reading data)
    @GetMapping("/hello")
    // this /hello is the path to a request
    // the end point is GET(method) + /hello (path)

    public String hello() {
        // Here I get no data and then do the logic, that is basically return a string 
        return "Hello World!";
    }
    
}
