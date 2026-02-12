package gym_backend.dto;

import java.time.LocalDate;
import java.util.List;

public class WorkoutDTO {
    private String name;
    private String day;
    private LocalDate date;
    private List<ExerciseDTO> exercises;
}
