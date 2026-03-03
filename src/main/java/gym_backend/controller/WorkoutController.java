package gym_backend.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import gym_backend.dto.EchoResponse;
import gym_backend.dto.ExerciseDTO;


@RestController
public class WorkoutController {
    
    @PostMapping("/workout")
    public ExerciseDTO receiveExerice (@RequestBody ExerciseDTO ex1) {
        return ex1;
    }

}
