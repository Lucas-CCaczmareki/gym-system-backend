package gym_backend.dto;

import gym_backend.enums.Muscle;
import gym_backend.enums.MuscleRole;
import lombok.Data;

@Data
public class TargetMuscle {
    private Muscle muscle;
    private MuscleRole role;
}
