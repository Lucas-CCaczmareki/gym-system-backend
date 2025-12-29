package gym_backend.controller;

import org.springframework.web.bind.annotation.RestController;

import gym_backend.dto.EchoRequest;
import gym_backend.dto.EchoResponse;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
public class EchoController {
    
    @PostMapping("/echo")
    // this returns an EchoResponse object and receives and EchoRequest object
    // @requestbody get the body and converts it into a java object (in this case, the echorequest)
    public EchoResponse echo(@RequestBody EchoRequest request) {
        return new EchoResponse("'" + request.getMessage() + "' received.");
    }
}
